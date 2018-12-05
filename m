Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D90C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9222087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/oH4TnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9222087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeLEEdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 23:33:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34251 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLEEdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 23:33:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so8424374pgg.1;
        Tue, 04 Dec 2018 20:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KcEIdsGut+2QxS4CWuCOChjjEYez+8JgtabCvWcaNpE=;
        b=u/oH4TnCEfC9kMwRua74K3fVFJ7cOm61chldxVnrQsLWA8yNj67yoMBDRvn6JcmFiF
         I0ilrf7/BwQe77vqMyo6CKCdG8PjgPFbkvkcHk916kjDy16FU5bi5dF5kaxzjH/iw3hs
         WTlCgHa9sBvuRLTx7Zv967F7jqTqEbbeyfT8NU5FJvtkvBlm4eQkdZAqfYLSNtpKScxh
         P8/yQG2dOeiFopGPB3cqZZ5OSxiHZJ3Viy39F1+6UXMAOFAHm45UT0iIHxotOgzIILPk
         /EM22yebr2JFAyFvQpTAO3ga+SsF/Z3tf7i47nticZaQgdEeTFzdFHKQFPlOuJJ73Son
         XXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcEIdsGut+2QxS4CWuCOChjjEYez+8JgtabCvWcaNpE=;
        b=NwRdrRHvCuA9W9IF3Gnp42myVOveZztIzQShMGxnIhOHKCleTl2AXBUFeU5W9DJX6h
         nRk6c8TOBKBTIGI3N3YYTIuW4kLJR3IwE3uY6aLKWOhho9QNHBto2VgnZs9Jm0yVzK2o
         jnuWVeZlug5zici3NBNi3aODV7Q+DqSWZ+P3yiCRuEAh3sFxeswAzQE9N4ZCgvNd+3dj
         USpOOs/BpEDjBgBgrPmDZSP/szV8d1sl/yHp6tigiTM/qnexiYh83G4GwZaZdh+RYxTM
         a9JC1busT8FEGdk8AlzEmyTlTarrL1APTy5xRlJ97I3X12AfNBpaizmaeZBVg3Y1Laah
         EEEA==
X-Gm-Message-State: AA+aEWZdA1iTsMUoyfXwpa+zGywcI8ZOwrjDpzHanWdFZ7eioIA048T4
        d1cG1MaDQfydU1ipGy14wkP7KKACr2NSc8u9dBY=
X-Google-Smtp-Source: AFSGD/WOE0ivakUkO37MsuySWrC4g4KgRKdobMG5or4DIixwJ+K/Diu/KpitTQCyrUCageNswpCVvqObl0riuTpOEuE=
X-Received: by 2002:a63:7154:: with SMTP id b20mr19145145pgn.342.1543984410614;
 Tue, 04 Dec 2018 20:33:30 -0800 (PST)
MIME-Version: 1.0
References: <5beda000.1c69fb81.e6599.d3d8@mx.google.com> <CAJr6mf0rawk6rDRB7NzsTUXyqvt0U5J4SUnVYck2_-jh6D6MoQ@mail.gmail.com>
In-Reply-To: <CAJr6mf0rawk6rDRB7NzsTUXyqvt0U5J4SUnVYck2_-jh6D6MoQ@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 5 Dec 2018 10:03:19 +0530
Message-ID: <CAJr6mf2obk8MgPc3AO74EwsiXt66OZGni57Z8v3TgnePyACLmg@mail.gmail.com>
Subject: Re: [PATCH] drivers/scsi/snic/snic_trc.c: Use vzalloc
To:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 8:07 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> On Thu, Nov 15, 2018 at 10:04 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Replaced vmalloc + memset with vzalloc
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Any comment on this patch?

Any comment on this patch?

>
> > ---
> >  drivers/scsi/snic/snic_trc.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
> > index fc60c93..458eaba 100644
> > --- a/drivers/scsi/snic/snic_trc.c
> > +++ b/drivers/scsi/snic/snic_trc.c
> > @@ -126,7 +126,7 @@ snic_trc_init(void)
> >         int tbuf_sz = 0, ret;
> >
> >         tbuf_sz = (snic_trace_max_pages * PAGE_SIZE);
> > -       tbuf = vmalloc(tbuf_sz);
> > +       tbuf = vzalloc(tbuf_sz);
> >         if (!tbuf) {
> >                 SNIC_ERR("Failed to Allocate Trace Buffer Size. %d\n", tbuf_sz);
> >                 SNIC_ERR("Trace Facility not enabled.\n");
> > @@ -135,7 +135,6 @@ snic_trc_init(void)
> >                 return ret;
> >         }
> >
> > -       memset(tbuf, 0, tbuf_sz);
> >         trc->buf = (struct snic_trc_data *) tbuf;
> >         spin_lock_init(&trc->lock);
> >
> > --
> > 2.7.4
> >
