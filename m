Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE2DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50E621903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8c8/7/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfBSIrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:47:05 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34493 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSIrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:47:04 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so4491061vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 00:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42/ZTfsqTDsYcqN7wt14htZxBiXNFJVnlE2eq0v9/+o=;
        b=s8c8/7/FqamaVfrbfb7wU5WbWKz6cYKqoA50foBQ65NB1d9088e8TRY+BH1jekA2Cm
         0bS5LuRysKqc70lnaLz/7CxvKT+q7cQysD+2Ms55TtqT5LEzBdzLqtVzjAnL5dLCLlcN
         Lggmz1ABlmZzT+1Xr20CGLo3w6Dil2lseAb9maBpCnsFpoHwAnTV+LNn976ecqTi1T/o
         bUKSoGO9boRokYIjXZi+k3k1pwfg+PJOLenlxEj4CqoZYcuXxIKfXKY3fEIx4vQwgXKb
         rIVz71OMfnlqAV2wmOqhCp0w11rcfLfCRGsJDxzP4cTwVrBix3DNeDspLZ7yefQss8Y5
         T/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42/ZTfsqTDsYcqN7wt14htZxBiXNFJVnlE2eq0v9/+o=;
        b=PHu3M0vCVDP8M/mDF2XxoYiq1RUe98SCuOPzDln7QmvWkI2Z31AfmRwSvpxdO0F/4J
         sQO77U/HHVhvGxk4t8p16XRQh+4yj0E+1KOlxFLxFSmU2LoXkiMsHoyi0HzG+AAEUbmM
         iwZ3KPgOlF3ayv+ZmBVP8RHBXodECJS7P3KP3ksfANdyT0C1NJ6oP2chKBJSRAAsGlbp
         HnorJUYeF4qVFyvUOThuLa6nvQ3EfsrELgSf36kDFCbPkfsMW7v+90eEwivm89ITn/BC
         cKmURh31wRcpSZuy7aPBWBjnSi4I+i16jy7BKxPiYcYYRITVVMPpVXrSKm76zfGvCRu2
         NbLg==
X-Gm-Message-State: AHQUAuZEZUn7+0rFNq9MMbO+H6ENJvijrqc5MBjoP+/FXqCFYW1xNsVW
        yxsaLXYvChuhWexyw2QgIz2yJthkSMuOTZdiqlwl4Q==
X-Google-Smtp-Source: AHgI3IbkKpDf9HoRvERtWKABXqXuA6iGEqT/avKQmToOZw33QRKo0NF6Hy3OF/pC4sDWrtkxYist6Ueo3gQvvbYEhe4=
X-Received: by 2002:a1f:d8b:: with SMTP id 133mr5383061vkn.78.1550566023869;
 Tue, 19 Feb 2019 00:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20190219070428.15480-1-yuehaibing@huawei.com>
In-Reply-To: <20190219070428.15480-1-yuehaibing@huawei.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 19 Feb 2019 14:16:53 +0530
Message-ID: <CAFA6WYMg9BrownTELgE85AMO-_0VWBH0oJzfnBVXzN+LNNdDYA@mail.gmail.com>
Subject: Re: [PATCH -next] tee: optee: Fix unsigned comparison with less than zero
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 at 12:34, YueHaibing <yuehaibing@huawei.com> wrote:
>
> The return from the call to tee_client_invoke_func can be a
> negative error code however this is being assigned to an
> unsigned variable 'ret' hence the check is always false.
> Fix this by making 'ret' an int.
>
> Detected by Coccinelle ("Unsigned expression compared with zero:
> ret < 0")
>
> Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> ---
>  drivers/tee/optee/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 5e4938b..1f22376 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -34,7 +34,7 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>  static int get_devices(struct tee_context *ctx, u32 session,
>                        struct tee_shm *device_shm, u32 *shm_size)
>  {
> -       u32 ret = 0;
> +       int ret = 0;
>         struct tee_ioctl_invoke_arg inv_arg = {0};
>         struct tee_param param[4] = {0};
>
> --
> 2.7.0
>
>
