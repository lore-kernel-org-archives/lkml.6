Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB01EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892AD21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w08p/rIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbfBMNgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:36:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46795 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfBMNgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:36:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id o6so1162546pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+xpNGTBUJTFj8aS5gzxBxlHPbKgKMsr1yQqNDU1whc=;
        b=w08p/rIs9IF9WB9OMf1R+mbyfgQQ07QA0Mh3F/Bp3fkWGWogWT8m5VRfhAhCgxE+wQ
         R/vDF/V/uuSEp8+pdfGIQwH2Mr1aOP1goyVAStNFMtXPnv0lv86/0w4bRbC3rfXp3306
         5pmO/xJHhMrApVHevvqJKz0HPgw+06K9dZWHDKYvkV+kpcEayGbvctt7qmPnqyfHQ4Hv
         3nul8BSsBy2H5EQk8bNJ58J9AcL55r8WmnKVUn551RGLBa9QRQD7Q1bduHoRXPkN7gMj
         9B8qzWVtvbXhdznLM4iAs9ieH5WwdR6WPI/TJxOV5vrZmLAC55/qmRsEK47l1MszcpdA
         OEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+xpNGTBUJTFj8aS5gzxBxlHPbKgKMsr1yQqNDU1whc=;
        b=LqOHzZFgqTo1YY23VVTGdu7N9Asbl73rO5bNQ9qUw6vseFYzu9Mr2Yu+pH+qyEALUx
         Waqaof0RcYr1SqIxA6sv3p7HRPmfUf0701SAf6Kvks0HPkAXgiyo51y5qXCDOLiBIf9a
         YQleHef3jrBv+1EHWnlarfhkwpoT3JPz1G4TiFznW19pp5T7VVTXNpiKa52M385ENt3T
         rnL4QBC9K8dGhHTMniSL+RJoD3foKFoJvV9pLaWfP3sC4UzWCpruwBSna5FnmipWTbM+
         nQ9KQQxfhAv4GZ+29gFagSXe7lHIhEqxCy/m4rjKuv/XIUeQu2DjYaxemhM/+4dbnOwR
         1pnA==
X-Gm-Message-State: AHQUAua8+F90hYF5z78axmFOX9g1DGr0K9CfDkP0uuJLURPw1Nl5lFCc
        XpsRH3hjunlzlTBH1TYKwLr9S4M0/R9b4l8ydK4vqJ4iaG4=
X-Google-Smtp-Source: AHgI3IbhK68A9iubDxa2AvZUsBMfHxwwf55FuC5hSB+MQs3VjUYIA0seUsgl9se+Y4CIINk8i3AF94tDrbWkJXpAEXM=
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr600056plk.206.1550065012184;
 Wed, 13 Feb 2019 05:36:52 -0800 (PST)
MIME-Version: 1.0
References: <1548351151-3722-1-git-send-email-igor.opaniuk@linaro.org>
In-Reply-To: <1548351151-3722-1-git-send-email-igor.opaniuk@linaro.org>
From:   Igor Opaniuk <igor.opaniuk@linaro.org>
Date:   Wed, 13 Feb 2019 15:36:16 +0200
Message-ID: <CAModR+WY-m+2mTEsgKe5vdH8OsSkV7cRBFQaMd0PHHAaJyzZSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: add cancellation support to client interface
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jerome Forissier <jerome.forissier@linaro.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 19:32, Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
>
> Add support of cancellation request to the TEE kernel internal
> client interface. Can be used by software TPM drivers, that leverage
> TEE under the hood (for instance TPM2.0 mobile profile), for requesting
> cancellation of time-consuming operations (RSA key-pair generation etc.).
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
> ---
>
> v2:
> - use tee_ioctl_cancel_arg to provide session and cancel_id
> - fix tee_client_cancel_req function description header
>
>  drivers/tee/tee_core.c  | 10 ++++++++++
>  include/linux/tee_drv.h | 12 ++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 7b2bb4c..1148175 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1027,6 +1027,16 @@ int tee_client_invoke_func(struct tee_context *ctx,
>  }
>  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>
> +int tee_client_cancel_req(struct tee_context *ctx,
> +                         struct tee_ioctl_cancel_arg *arg)
> +{
> +       if (!ctx->teedev->desc->ops->cancel_req)
> +               return -EINVAL;
> +       return ctx->teedev->desc->ops->cancel_req(ctx, arg->cancel_id,
> +                                                 arg->session);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_cancel_req);
> +
>  static int __init tee_init(void)
>  {
>         int rc;
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 6cfe058..177016e 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -526,6 +526,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
>                            struct tee_ioctl_invoke_arg *arg,
>                            struct tee_param *param);
>
> +/**
> + * tee_client_cancel_req() - Request cancellation of the previous open-session
> + * or invoke-command operations in a Trusted Application
> + * @ctx:       TEE Context
> + * @arg:       Cancellation arguments, see description of
> + *             struct tee_ioctl_cancel_arg
> + *
> + * Returns < 0 on error else 0 if the cancellation was successfully requested.
> + */
> +int tee_client_cancel_req(struct tee_context *ctx,
> +                         struct tee_ioctl_cancel_arg *arg);
> +
>  static inline bool tee_param_is_memref(struct tee_param *param)
>  {
>         switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
> --
> 2.7.4
>
Hi,

Just gentle reminder - v2 patch has been sitting in ML for almost 2
weeks with no review (all issues mentioned in v1 were addressed).
If anyone has any objections/suggestions, please let me know.

Thanks!
--
Regards,
Igor Opaniuk
