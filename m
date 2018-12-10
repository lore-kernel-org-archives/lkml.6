Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEE5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E311020821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E311020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbeLJV2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:28:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38947 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeLJV2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:28:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id n21so14098996qtl.6;
        Mon, 10 Dec 2018 13:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQ22ZuQTTIWWjE+USpSR/19LZETkCyIRRdD7xwKsPgI=;
        b=YsPeVXTVNW0faJpiMZDujVzfPxTAYFI9hOXtqZ+D+VEqcn8IroGg/KQZcIDGuIRTfN
         V0CE60cdYoehEOr3T6b9zeXz8dzn1HWmvQH12peWIt7gAOAF0BqsQQBNkRydpnfoRCk0
         lsRjD0Drqb7ZGDmjgZGA0oMLaXyifEuW+qI8n1klemh4923l5SEMfW8DaQc8mpLf5GL3
         Qq8k9F9YalL11wY8PGCx/7QS9B5at9ZsPyWsjNPc4w9HM/KTCAM9G+3Z66iiAXdRo37/
         jZVqonr5l8OAtOkkvyYxMPywtZ5Q1erW2RMTUC2PEtiBwz4rZKS/cHrBCcBiiFuRT6Vl
         BhkQ==
X-Gm-Message-State: AA+aEWYSXsNy4gRGcL2qe5wmVo7wjRh4GlZGnoJVRxvjft7PixIvtoxu
        2oOTxurui8Yt7z79FOceP1GvYWKI8CVOI/PQ6TM=
X-Google-Smtp-Source: AFSGD/XgHekhBVEO1znX1LRditjvT/DZ89+mMkGrBi0egNT/tkysP6Pwc8VswEnUtgFZkhgdnpaibhgNWaE0oXRAAUo=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr12910049qvk.40.1544477303209;
 Mon, 10 Dec 2018 13:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20181210205215.2703138-1-arnd@arndb.de> <1544475666.185366.378.camel@acm.org>
In-Reply-To: <1544475666.185366.378.camel@acm.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 Dec 2018 22:28:05 +0100
Message-ID: <CAK8P3a0MShhjPMUdNs=CTqOJ-ovDPczYiQFL9c2M2dOUQ4yK7w@mail.gmail.com>
Subject: Re: [PATCH] scsi: qla2xxx: fix unused function warning
To:     bvanassche@acm.org
Cc:     qla2xxx-upstream@qlogic.com, jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        loberman@redhat.com,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, hmadhani@marvell.com,
        quinn.tran@cavium.com, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@kernel.dk>, darren.trapp@cavium.com,
        William.Kuzeja@stratus.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:01 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Mon, 2018-12-10 at 21:51 +0100, Arnd Bergmann wrote:
> > In what seems to be a mismatch between the scsi-fixes branch and
> > the scsi-mkp/for-next branch, a newly introduced variable from
> > one patch got obsoleted in another one:
> >
> > drivers/scsi/qla2xxx/qla_os.c: In function '__qla2x00_abort_all_cmds':
> > drivers/scsi/qla2xxx/qla_os.c:1791:11: error: unused variable 'status' [-Werror=unused-variable]
> >
> > Remove the variable again.
> >
> > Fixes: c4e521b654e1 ("scsi: qla2xxx: Split the __qla2x00_abort_all_cmds() function")
> > Fixes: f2ffd4e5bc7b ("scsi: qla2xxx: Timeouts occur on surprise removal of QLogic adapter")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Maybe check carefully that the merge in linux-next is otherwise correct
> > ---
> >  drivers/scsi/qla2xxx/qla_os.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> > index 63c47bc7ae59..db331cb5ba3c 100644
> > --- a/drivers/scsi/qla2xxx/qla_os.c
> > +++ b/drivers/scsi/qla2xxx/qla_os.c
> > @@ -1788,7 +1788,7 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
> >  static void
> >  __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
> >  {
> > -     int cnt, status;
> > +     int cnt;
> >       unsigned long flags;
> >       srb_t *sp;
> >       scsi_qla_host_t *vha = qp->vha;
>
> When I prepared commit c4e521b654e1 I verified that my patch did not produce any
> warnings when building with W=1. So something must be wrong at your side. Did you
> perhaps start from linux-next to prepare this patch? If so, please submit this
> patch to Stephen Rothwell.

Yes, I tried to make clear that the two branches are fine by themselves, sorry
if I was still ambiguous. The patch is currently only needed on linux-next
as far as I can tell, but we should avoid getting the same error when the
branches are merged in mainline.

        Arnd
