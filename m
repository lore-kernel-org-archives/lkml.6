Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D599FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4C2222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mATzvWDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394790AbfBNImp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:42:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35724 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387828AbfBNImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:42:45 -0500
Received: by mail-it1-f194.google.com with SMTP id v72so12605644itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4o4O471w38IxBKHrVNFNmKCWLwJS5aMAkZO3EUbBvAk=;
        b=mATzvWDjii6CKL6544UHpusry6fp3858YOPXhTT4wNZGt4nwJEkdDWp93yjRP0u6vg
         aaZ8EVuSyeGccoOL5yTw/D1W0V7Mr8EUqZW5unP1d93iDhyay+8zjFRoejykagkZ4hhX
         tBliAPCMoDvSzvdQJbPXuDXCeXXU/woKFZlDGeJlG7A6i2PUrqMGgORnMSP1t0zZDJLv
         b0eTiX+zGSa1Vn6OoR5E5bd+Isl5AL3i3Ae+LK0HZNIqJ3QOBPYAYIGle+F1jKSvWtIT
         YlIdFDk37HJ6i89us3EuQY4GCvij7fjMWodX7wk31KxldW67FGZv6SQJKlaMepyI3Vpl
         roRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4o4O471w38IxBKHrVNFNmKCWLwJS5aMAkZO3EUbBvAk=;
        b=JV1HKoglyEgfhZ5yN9Y4XVVZatyqpJ8F9M/V/BL9v8qaZRiyECvY0eqlG6tnAA+j8I
         Sv9h/L0njZ2oIJUQBHQMI9y/TG/eXRr8TNt+R+mNsKoqYXWr0f8w7lMcGLMqbKrERIfZ
         sAH/8YbMvlxBBNohfX8UgGB/dJt/gt3rtfx/6dly9btsY8tnRvJxHiR5KS9V9NAQOKvk
         vwY+cHHdSLnfU7bZhQLxXarq48V4+qlsH4usLe0Xi0gJGQGACPDSxukAB1O07aXjq8aT
         zB/Y2/niK02r12v2dwdBc0xMJs6V1ACM1gEbKmzlCtz9zumvXRDMp9UMk9Wg8jd9ocMR
         2yPw==
X-Gm-Message-State: AHQUAuaiVXVN4XBFr0YKgcBKkt6fJKqHhzd4YZx9tocd5hzASb9BgtGc
        oR+l5ovfSRLb4Z6lmES1lIuR7KSyFyD1E4FITKjMFw==
X-Google-Smtp-Source: AHgI3IbSkVXIAMuLTZwa1eHKywUHV48CI/v75C/Nq8kE7FPVMJBrHVtz5qEiqkJ4K7vxM/rX1R0Y43Tpr5tTMzRvX3I=
X-Received: by 2002:a02:5782:: with SMTP id b2mr1418186jad.2.1550133764036;
 Thu, 14 Feb 2019 00:42:44 -0800 (PST)
MIME-Version: 1.0
References: <1548351151-3722-1-git-send-email-igor.opaniuk@linaro.org> <CAModR+WY-m+2mTEsgKe5vdH8OsSkV7cRBFQaMd0PHHAaJyzZSQ@mail.gmail.com>
In-Reply-To: <CAModR+WY-m+2mTEsgKe5vdH8OsSkV7cRBFQaMd0PHHAaJyzZSQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 14 Feb 2019 09:42:33 +0100
Message-ID: <CAHUa44G_f_AsvP_LCkR_0WU+P_AOASB9-iSkU_B5e9ecMhuWjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: add cancellation support to client interface
To:     Igor Opaniuk <igor.opaniuk@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Wed, Feb 13, 2019 at 2:36 PM Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
>
> On Thu, 24 Jan 2019 at 19:32, Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
> >
> > Add support of cancellation request to the TEE kernel internal
> > client interface. Can be used by software TPM drivers, that leverage
> > TEE under the hood (for instance TPM2.0 mobile profile), for requesting
> > cancellation of time-consuming operations (RSA key-pair generation etc.).
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
> > ---
> >
> > v2:
> > - use tee_ioctl_cancel_arg to provide session and cancel_id
> > - fix tee_client_cancel_req function description header
> >
> >  drivers/tee/tee_core.c  | 10 ++++++++++
> >  include/linux/tee_drv.h | 12 ++++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 7b2bb4c..1148175 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -1027,6 +1027,16 @@ int tee_client_invoke_func(struct tee_context *ctx,
> >  }
> >  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
> >
> > +int tee_client_cancel_req(struct tee_context *ctx,
> > +                         struct tee_ioctl_cancel_arg *arg)
> > +{
> > +       if (!ctx->teedev->desc->ops->cancel_req)
> > +               return -EINVAL;
> > +       return ctx->teedev->desc->ops->cancel_req(ctx, arg->cancel_id,
> > +                                                 arg->session);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_client_cancel_req);
> > +
> >  static int __init tee_init(void)
> >  {
> >         int rc;
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 6cfe058..177016e 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -526,6 +526,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
> >                            struct tee_ioctl_invoke_arg *arg,
> >                            struct tee_param *param);
> >
> > +/**
> > + * tee_client_cancel_req() - Request cancellation of the previous open-session
> > + * or invoke-command operations in a Trusted Application
> > + * @ctx:       TEE Context
> > + * @arg:       Cancellation arguments, see description of
> > + *             struct tee_ioctl_cancel_arg
> > + *
> > + * Returns < 0 on error else 0 if the cancellation was successfully requested.
> > + */
> > +int tee_client_cancel_req(struct tee_context *ctx,
> > +                         struct tee_ioctl_cancel_arg *arg);
> > +
> >  static inline bool tee_param_is_memref(struct tee_param *param)
> >  {
> >         switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
> > --
> > 2.7.4
> >
> Hi,
>
> Just gentle reminder - v2 patch has been sitting in ML for almost 2
> weeks with no review (all issues mentioned in v1 were addressed).
> If anyone has any objections/suggestions, please let me know.

Looks good. I'll pick it up.

Thanks,
Jens
