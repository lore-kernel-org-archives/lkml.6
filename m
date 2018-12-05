Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4352FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B572084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXjYdT2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B572084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeLEEiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 23:38:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44322 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEEiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 23:38:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so8394539pgr.11;
        Tue, 04 Dec 2018 20:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=le6ae74zufL4m2Y6XwHzvjNGgrkfyQ/r81b+srxBU+Y=;
        b=lXjYdT2F+sIHuaKTsH61XxcVPU55Z4AcqqoeBhdrrwVxD1MzHgA8CKCrcLXFOO4i9v
         SwX7Ai1L8hT7rZocqog798MtAa/kqZoqyZMXrgxKrYVNcjDRjqw9VMmqH7LhkedypekA
         6/PcwLa32ENucRDzL40zTGW+NS9t0tqOhl9xd4DiAmESj9BNbsnlTCIAPFnRV+G9rRUH
         diKuDh1UTt05tctaoQNwv7vyKgQm/fJ1C675600Z+O3aLTKepCRg0ckSZXllCBZJO4DT
         yHlPU/JmJxNUqxlNgI4DLtyEGBiFDWWEbRiARZJTjI4LCDHG2jBqOxhr9MDqZXNnDpoS
         x4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=le6ae74zufL4m2Y6XwHzvjNGgrkfyQ/r81b+srxBU+Y=;
        b=ZL7uHBBT4Pabnak9y79Iu8F+4/yXV6HRSQr63tJQpE3SqnGAGow3i+IKbFmvhGBodF
         /pJR0QZafZGGSZbR2wk9d+oU154SM17FEuZsVEb/D3BXi05gXURdufDAYvZtJhSjN0Ei
         rZH2F4pEbC2oOqDRf9c3/Mgt42l1tDmaMaX2AllLt3z0Ism3PuJc22/TPcqhruvmUb2K
         qyj2mhOZGSNL0qoTmUkTf51Su1V6dyDpMgtaz0Ef00AAoHobgEYor5c2Kqg5l1L1z1oC
         qYmMwU7X0WHv62K09IScKOi7vmTj1A22rYqYru3c/8A9xRzDXM++jdBy8nm+lxPkOLAe
         sftA==
X-Gm-Message-State: AA+aEWY+GP9m3LrDbaYZAlsOYMFI2c4oa3oxQBoVTFZdr+ZhJqwIKCOT
        RvrDVLBZdKLfwhJ8usQAbqAKCtCAsjbPiDSBv2w=
X-Google-Smtp-Source: AFSGD/WuDIP+AyUFPnfgQVvexY5yaZZVC3sivr7bJu8/Qsljb4TOVGbJRzEbCeoVT6LnFDUGNhHEuH4rSwxci+a64eo=
X-Received: by 2002:a63:7154:: with SMTP id b20mr19153212pgn.342.1543984683221;
 Tue, 04 Dec 2018 20:38:03 -0800 (PST)
MIME-Version: 1.0
References: <5bec5342.1c69fb81.b02fa.ace9@mx.google.com> <CAJr6mf1d=tviauDfd4Hq_750mGiypheUxHhQEv_tsdR_TrTkNA@mail.gmail.com>
In-Reply-To: <CAJr6mf1d=tviauDfd4Hq_750mGiypheUxHhQEv_tsdR_TrTkNA@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 5 Dec 2018 10:07:51 +0530
Message-ID: <CAJr6mf1wqNq02e89U85u=h1Ge0MSzAOk+wQc9q_gWurEZzWZUw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
To:     satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 8:13 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> On Wed, Nov 14, 2018 at 10:24 PM Sabyasachi Gupta
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
> > v2: Removed additional braces
> >
> >  drivers/scsi/fnic/fnic_trace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
> > index 8271785..bf0fd2a 100644
> > --- a/drivers/scsi/fnic/fnic_trace.c
> > +++ b/drivers/scsi/fnic/fnic_trace.c
> > @@ -468,14 +468,13 @@ int fnic_trace_buf_init(void)
> >         fnic_max_trace_entries = (trace_max_pages * PAGE_SIZE)/
> >                                           FNIC_ENTRY_SIZE_BYTES;
> >
> > -       fnic_trace_buf_p = (unsigned long)vmalloc((trace_max_pages * PAGE_SIZE));
> > +       fnic_trace_buf_p = (unsigned long)vzalloc(trace_max_pages * PAGE_SIZE);
> >         if (!fnic_trace_buf_p) {
> >                 printk(KERN_ERR PFX "Failed to allocate memory "
> >                                   "for fnic_trace_buf_p\n");
> >                 err = -ENOMEM;
> >                 goto err_fnic_trace_buf_init;
> >         }
> > -       memset((void *)fnic_trace_buf_p, 0, (trace_max_pages * PAGE_SIZE));
> >
> >         fnic_trace_entries.page_offset =
> >                 vmalloc(array_size(fnic_max_trace_entries,
> > --
> > 2.7.4
> >
