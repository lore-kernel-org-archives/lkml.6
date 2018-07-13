Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C79CECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8195208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eancCoAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8195208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeGMKOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:14:47 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34538 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeGMKOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:14:47 -0400
Received: by mail-vk0-f65.google.com with SMTP id l143-v6so10545372vke.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEZ6v420qGg85C1XqKihXodVNPd0B66ct6AvziQF16I=;
        b=eancCoAfJkmsNySS6Sm6buPyYt1E+14LEgj1JI9O35nFe4lcIvVDvu6s0QV0ixqZfx
         FOMq1gEAlt5CLEv6ByPYfIirJhGDRuQpeCWfRcdiMFq08SZ14c+suK/X83Ce4ACr+lwU
         fhEw4tgwyojPr3zksFg8iw+WpsMwN/W6T8le8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEZ6v420qGg85C1XqKihXodVNPd0B66ct6AvziQF16I=;
        b=L2MEKKqu7h7dDhDT+0GDpv73XWXmgz6yDfNqBy3ScCzE1A/Q74/fp4as9fPrbPTww6
         1lS0jg/1JBzTlY1kIL6SMpAL88F321aQ2LY71FddhbfoYDs1h2cyop+28xHNLbR5PJPX
         EbMqnqGQ7OFOJm4VHufs1aYnx86MbS84sIUDjhBSUD8fQ9p1GUAjdce75tYNFa5FyNgt
         UIUW9Ld1r1r4Vb9NoXVL7YOJ0dIVT7Mc98GUPCHGKBgm7ofxV2QV+mH7JQJh80YjFMWr
         exFNI3CaDq2QS3/534s4I8dLlUl+xhEjBHOFRbMPNwHjpVGgYobJYJf/oSHVlbAqd1k/
         pAlg==
X-Gm-Message-State: AOUpUlGffU/aCVVRk6gi2s1rSjAES+VfiN6ng4k/rJObvXyRNCw9SV2R
        Fftjb2NQF8AgQPELhTbSqOVk7aMRp74kpT/XnQGqFQ==
X-Google-Smtp-Source: AAOMgpcc4WSodH3rDOtAaQ4lP29TIsH0DHU8FvkDFpmytpgQf+2dxXjvMB+CHNr6pwxSgS/+rm7Es5J2c8/j+0IWRHg=
X-Received: by 2002:a1f:bd13:: with SMTP id n19-v6mr3259476vkf.61.1531476048200;
 Fri, 13 Jul 2018 03:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180709061549.24382-1-jens.wiklander@linaro.org> <20180713092449.GA17766@jax.urgonet>
In-Reply-To: <20180713092449.GA17766@jax.urgonet>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 13 Jul 2018 15:30:36 +0530
Message-ID: <CAFA6WYOpaoLmzjjWEatF_NaurFmegF5L0=mDfC+2faE_gp6qbQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] tee: add kernel internal client interface
To:     jens.wiklander@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, prime.zeng@hisilicon.com,
        Victor Chong <victor.chong@linaro.org>,
        jerome.forissier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 at 14:54, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> [+Sumit]
>
> On Mon, Jul 09, 2018 at 08:15:49AM +0200, Jens Wiklander wrote:
> > Adds a kernel internal TEE client interface to be used by other drivers.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---

Thanks Jens for this patch. I have reviewed and tested this patch on
Developerbox [1]. Following is brief description of my test-case:

Developerbox doesn't have support for hardware based TRNG. But it does
have 7 on-chip thermal sensors accessible from Secure world only. So I
wrote OP-TEE static TA to collect Entropy using thermal noise from
these sensors.
After using the interface provided by this patch, I am able to write
"hw_random" char driver for Developerbox to get Entropy from OP-TEE
static TA which could be further used by user-space daemon (rngd).

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>

[1] https://www.96boards.org/product/developerbox/

-Sumit

> >  drivers/tee/tee_core.c  | 113 +++++++++++++++++++++++++++++++++++++---
> >  include/linux/tee_drv.h |  73 ++++++++++++++++++++++++++
> >  2 files changed, 179 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index dd46b758852a..7b2bb4c50058 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -38,15 +38,13 @@ static DEFINE_SPINLOCK(driver_lock);
> >  static struct class *tee_class;
> >  static dev_t tee_devt;
> >
> > -static int tee_open(struct inode *inode, struct file *filp)
> > +static struct tee_context *teedev_open(struct tee_device *teedev)
> >  {
> >       int rc;
> > -     struct tee_device *teedev;
> >       struct tee_context *ctx;
> >
> > -     teedev = container_of(inode->i_cdev, struct tee_device, cdev);
> >       if (!tee_device_get(teedev))
> > -             return -EINVAL;
> > +             return ERR_PTR(-EINVAL);
> >
> >       ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> >       if (!ctx) {
> > @@ -57,16 +55,16 @@ static int tee_open(struct inode *inode, struct file *filp)
> >       kref_init(&ctx->refcount);
> >       ctx->teedev = teedev;
> >       INIT_LIST_HEAD(&ctx->list_shm);
> > -     filp->private_data = ctx;
> >       rc = teedev->desc->ops->open(ctx);
> >       if (rc)
> >               goto err;
> >
> > -     return 0;
> > +     return ctx;
> >  err:
> >       kfree(ctx);
> >       tee_device_put(teedev);
> > -     return rc;
> > +     return ERR_PTR(rc);
> > +
> >  }
> >
> >  void teedev_ctx_get(struct tee_context *ctx)
> > @@ -100,6 +98,18 @@ static void teedev_close_context(struct tee_context *ctx)
> >       teedev_ctx_put(ctx);
> >  }
> >
> > +static int tee_open(struct inode *inode, struct file *filp)
> > +{
> > +     struct tee_context *ctx;
> > +
> > +     ctx = teedev_open(container_of(inode->i_cdev, struct tee_device, cdev));
> > +     if (IS_ERR(ctx))
> > +             return PTR_ERR(ctx);
> > +
> > +     filp->private_data = ctx;
> > +     return 0;
> > +}
> > +
> >  static int tee_release(struct inode *inode, struct file *filp)
> >  {
> >       teedev_close_context(filp->private_data);
> > @@ -928,6 +938,95 @@ void *tee_get_drvdata(struct tee_device *teedev)
> >  }
> >  EXPORT_SYMBOL_GPL(tee_get_drvdata);
> >
> > +struct match_dev_data {
> > +     struct tee_ioctl_version_data *vers;
> > +     const void *data;
> > +     int (*match)(struct tee_ioctl_version_data *, const void *);
> > +};
> > +
> > +static int match_dev(struct device *dev, const void *data)
> > +{
> > +     const struct match_dev_data *match_data = data;
> > +     struct tee_device *teedev = container_of(dev, struct tee_device, dev);
> > +
> > +     teedev->desc->ops->get_version(teedev, match_data->vers);
> > +     return match_data->match(match_data->vers, match_data->data);
> > +}
> > +
> > +struct tee_context *
> > +tee_client_open_context(struct tee_context *start,
> > +                     int (*match)(struct tee_ioctl_version_data *,
> > +                                  const void *),
> > +                     const void *data, struct tee_ioctl_version_data *vers)
> > +{
> > +     struct device *dev = NULL;
> > +     struct device *put_dev = NULL;
> > +     struct tee_context *ctx = NULL;
> > +     struct tee_ioctl_version_data v;
> > +     struct match_dev_data match_data = { vers ? vers : &v, data, match };
> > +
> > +     if (start)
> > +             dev = &start->teedev->dev;
> > +
> > +     do {
> > +             dev = class_find_device(tee_class, dev, &match_data, match_dev);
> > +             if (!dev) {
> > +                     ctx = ERR_PTR(-ENOENT);
> > +                     break;
> > +             }
> > +
> > +             put_device(put_dev);
> > +             put_dev = dev;
> > +
> > +             ctx = teedev_open(container_of(dev, struct tee_device, dev));
> > +     } while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
> > +
> > +     put_device(put_dev);
> > +     return ctx;
> > +}
> > +EXPORT_SYMBOL_GPL(tee_client_open_context);
> > +
> > +void tee_client_close_context(struct tee_context *ctx)
> > +{
> > +     teedev_close_context(ctx);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_client_close_context);
> > +
> > +void tee_client_get_version(struct tee_context *ctx,
> > +                         struct tee_ioctl_version_data *vers)
> > +{
> > +     ctx->teedev->desc->ops->get_version(ctx->teedev, vers);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_client_get_version);
> > +
> > +int tee_client_open_session(struct tee_context *ctx,
> > +                         struct tee_ioctl_open_session_arg *arg,
> > +                         struct tee_param *param)
> > +{
> > +     if (!ctx->teedev->desc->ops->open_session)
> > +             return -EINVAL;
> > +     return ctx->teedev->desc->ops->open_session(ctx, arg, param);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_client_open_session);
> > +
> > +int tee_client_close_session(struct tee_context *ctx, u32 session)
> > +{
> > +     if (!ctx->teedev->desc->ops->close_session)
> > +             return -EINVAL;
> > +     return ctx->teedev->desc->ops->close_session(ctx, session);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_client_close_session);
> > +
> > +int tee_client_invoke_func(struct tee_context *ctx,
> > +                        struct tee_ioctl_invoke_arg *arg,
> > +                        struct tee_param *param)
> > +{
> > +     if (!ctx->teedev->desc->ops->invoke_func)
> > +             return -EINVAL;
> > +     return ctx->teedev->desc->ops->invoke_func(ctx, arg, param);
> > +}
> > +EXPORT_SYMBOL_GPL(tee_client_invoke_func);
> > +
> >  static int __init tee_init(void)
> >  {
> >       int rc;
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index a2b3dfcee0b5..6cfe05893a76 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -453,6 +453,79 @@ static inline int tee_shm_get_id(struct tee_shm *shm)
> >   */
> >  struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
> >
> > +/**
> > + * tee_client_open_context() - Open a TEE context
> > + * @start:   if not NULL, continue search after this context
> > + * @match:   function to check TEE device
> > + * @data:    data for match function
> > + * @vers:    if not NULL, version data of TEE device of the context returned
> > + *
> > + * This function does an operation similar to open("/dev/teeX") in user space.
> > + * A returned context must be released with tee_client_close_context().
> > + *
> > + * Returns a TEE context of the first TEE device matched by the match()
> > + * callback or an ERR_PTR.
> > + */
> > +struct tee_context *
> > +tee_client_open_context(struct tee_context *start,
> > +                     int (*match)(struct tee_ioctl_version_data *,
> > +                                  const void *),
> > +                     const void *data, struct tee_ioctl_version_data *vers);
> > +
> > +/**
> > + * tee_client_close_context() - Close a TEE context
> > + * @ctx:     TEE context to close
> > + *
> > + * Note that all sessions previously opened with this context will be
> > + * closed when this function is called.
> > + */
> > +void tee_client_close_context(struct tee_context *ctx);
> > +
> > +/**
> > + * tee_client_get_version() - Query version of TEE
> > + * @ctx:     TEE context to TEE to query
> > + * @vers:    Pointer to version data
> > + */
> > +void tee_client_get_version(struct tee_context *ctx,
> > +                         struct tee_ioctl_version_data *vers);
> > +
> > +/**
> > + * tee_client_open_session() - Open a session to a Trusted Application
> > + * @ctx:     TEE context
> > + * @arg:     Open session arguments, see description of
> > + *           struct tee_ioctl_open_session_arg
> > + * @param:   Parameters passed to the Trusted Application
> > + *
> > + * Returns < 0 on error else see @arg->ret for result. If @arg->ret
> > + * is TEEC_SUCCESS the session identifier is available in @arg->session.
> > + */
> > +int tee_client_open_session(struct tee_context *ctx,
> > +                         struct tee_ioctl_open_session_arg *arg,
> > +                         struct tee_param *param);
> > +
> > +/**
> > + * tee_client_close_session() - Close a session to a Trusted Application
> > + * @ctx:     TEE Context
> > + * @session: Session id
> > + *
> > + * Return < 0 on error else 0, regardless the session will not be
> > + * valid after this function has returned.
> > + */
> > +int tee_client_close_session(struct tee_context *ctx, u32 session);
> > +
> > +/**
> > + * tee_client_invoke_func() - Invoke a function in a Trusted Application
> > + * @ctx:     TEE Context
> > + * @arg:     Invoke arguments, see description of
> > + *           struct tee_ioctl_invoke_arg
> > + * @param:   Parameters passed to the Trusted Application
> > + *
> > + * Returns < 0 on error else see @arg->ret for result.
> > + */
> > +int tee_client_invoke_func(struct tee_context *ctx,
> > +                        struct tee_ioctl_invoke_arg *arg,
> > +                        struct tee_param *param);
> > +
> >  static inline bool tee_param_is_memref(struct tee_param *param)
> >  {
> >       switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
> > --
> > 2.17.1
> >
