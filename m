Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A396CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6E21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDxcrzO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfBSJrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:47:33 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44957 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBSJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:47:32 -0500
Received: by mail-vs1-f66.google.com with SMTP id r201so11298079vsc.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 01:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdqU4hPWRCpl2b+kX/GEU2aCB/25wPynl2JYRUOSoH8=;
        b=pDxcrzO2TlQLpPvWV1iPlozjnw4kOdLYTWzOTQ0FM+P4McnVmNwu1Hx/Zi26ZE+kPt
         K7pasG2p24dL777h6NtGwoeQMmURnvP3Y1dPKXkKGRLvNxgu+X7WT5AgPsc4syJkdXT9
         xdaiSwGxGh32GjMDgmV7cz7vi9QZGeHFcTn3fS5PTUSkeU3Bx29hl80FioUmNloldzTp
         RGcW115uunLfGUmiyYkb4Gt7/nyIFwL6qcvibouyVgIcduBLWxTj4N7HZggSgDvV2X/4
         B7rzbMFU4EnKOGFjj2Kyn/Mip0Dpr3IBmUMsURjHriQSKS+X+wW9D3fNhxgJcO3toKE8
         7SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdqU4hPWRCpl2b+kX/GEU2aCB/25wPynl2JYRUOSoH8=;
        b=Q/EeXkO1wINbD5qyzX288TCw7+HMlWI/HKGR2FDrHPQvKYETG3rl5zi0Pn2zTfDn3l
         0giD1jRIqgoADhMZ0dqmeZ2NGB99rgWzohvW+O4Q+8wYskd1F4CWcY2/YS8SotrnZwRP
         o1/xEJAeIidzTHWOlgE5WmJ63rVttPrByLLmCfjEbbNEhckRZhQbHStT1PcYqudfvmFK
         M965JqYUVmymYxFzFlygDk04hbf8t+3NxTRMA/2/ekOv3benB56bQ/vkczwgQHaI9rpr
         7B4vUBB98jJ4yB8qtwVWjc4/KS7r6ZcoVrnzoSDAabB23sstbgKm1VeUl0cZWfr3qWFJ
         /htg==
X-Gm-Message-State: AHQUAuZysnHXe9GKynUWBlmtneBlw7yqjdKL5JZWyuS6OLemrNNejlVx
        QF/IaEtzk6KsKjEAmA+p6fJgwzO3niSE2moopJLwKg==
X-Google-Smtp-Source: AHgI3IZ1Ov6w+qj1zBAFgts9Z3tv5yZqhsMjY+I6FnHkheHEVxYOczH1KCqC+TppIb6yi+gyRnmWAdNFygntZX2tVqs=
X-Received: by 2002:a67:2045:: with SMTP id g66mr13968154vsg.180.1550569650919;
 Tue, 19 Feb 2019 01:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20190219091520.28990-1-natechancellor@gmail.com>
In-Reply-To: <20190219091520.28990-1-natechancellor@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 19 Feb 2019 15:17:20 +0530
Message-ID: <CAFA6WYP+vinWcM_wkSxaKfmRhG9hSZQSCh7f4WoUBEMWe-htbQ@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Initialize some structs using memset instead
 of braces
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 at 14:45, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/tee/optee/device.c:39:31: warning: suggest braces around
> initialization of subobject [-Wmissing-braces]
>         struct tee_param param[4] = {0};
>                                      ^
>                                      {}
> drivers/tee/optee/device.c:92:48: warning: suggest braces around
> initialization of subobject [-Wmissing-braces]
>         struct tee_ioctl_open_session_arg sess_arg = {0};
>                                                       ^
>                                                       {}
> 2 warnings generated.
>
> One way to fix these warnings is to add additional braces like Clang
> suggests; however, there has been a bit of push back from some
> maintainers, who just prefer memset as it is unambiguous, doesn't
> depend on a particular compiler version, and properly initializes all
> subobjects [1][2]. Do that here so there are no more warnings.
>
> [1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
> [2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/
>
> Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> Link: https://github.com/ClangBuiltLinux/linux/issues/370
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> ---
>  drivers/tee/optee/device.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 5e4938bbef2b..167839b371f2 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -35,8 +35,11 @@ static int get_devices(struct tee_context *ctx, u32 session,
>                        struct tee_shm *device_shm, u32 *shm_size)
>  {
>         u32 ret = 0;
> -       struct tee_ioctl_invoke_arg inv_arg = {0};
> -       struct tee_param param[4] = {0};
> +       struct tee_ioctl_invoke_arg inv_arg;
> +       struct tee_param param[4];
> +
> +       memset(&inv_arg, 0, sizeof(inv_arg));
> +       memset(&param, 0, sizeof(param));
>
>         /* Invoke PTA_CMD_GET_DEVICES function */
>         inv_arg.func = PTA_CMD_GET_DEVICES;
> @@ -89,13 +92,15 @@ int optee_enumerate_devices(void)
>         const uuid_t pta_uuid =
>                 UUID_INIT(0x7011a688, 0xddde, 0x4053,
>                           0xa5, 0xa9, 0x7b, 0x3c, 0x4d, 0xdf, 0x13, 0xb8);
> -       struct tee_ioctl_open_session_arg sess_arg = {0};
> +       struct tee_ioctl_open_session_arg sess_arg;
>         struct tee_shm *device_shm = NULL;
>         const uuid_t *device_uuid = NULL;
>         struct tee_context *ctx = NULL;
>         u32 shm_size = 0, idx, num_devices = 0;
>         int rc;
>
> +       memset(&sess_arg, 0, sizeof(sess_arg));
> +
>         /* Open context with OP-TEE driver */
>         ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
>         if (IS_ERR(ctx))
> --
> 2.21.0.rc1
>
