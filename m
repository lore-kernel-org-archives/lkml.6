Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF16CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BED72082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNC3gyM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BED72082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJKCmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:42:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45611 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJKCmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:42:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so6966180wrw.12;
        Wed, 10 Oct 2018 12:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqOVfRrR/v4kJtMWB9wlo/txgXuLcauAOHVi1XPf194=;
        b=FNC3gyM+d0rC8Af7tlAUbg/u10e3FosaigLWRo9ZM0GNogRvSGZNvGAl7WqTH17Jgt
         JKagoVjTwRf7XaPJgmcdr4Tj+cEZvCCVqsGH4rDzjAW1i9CNWY03N0wuPOYK9/+6aN4C
         LoPmxRfqMIe0rvrR5NFGxAndLyocCAry58JB8ZR1fJOLH/Jk87guOa0TCklM+ga5/vwY
         Wwt1sMxlVxZQ0kJE7kc18JmWzAv6agwqBR7ZuayUwmzBgnZBdh5veLElVQCtrrfKUiXD
         wDnm48T02ELtWLHnIwVq9qhaIHjr6Swc8kR9OY758mqsXyFA1Z9yfD4lUZBiLIIO/pWE
         NExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqOVfRrR/v4kJtMWB9wlo/txgXuLcauAOHVi1XPf194=;
        b=Q9bSiuLXDXkc/YzfN21otH7naWoqY+PgSL2epApwV/KqjWXyh8dTeIzokLPsFD5i3N
         TEB6SRFSqDMLMDvzvO2injoyA+2c3Gu+5WdM6ELAO2thj2xxNtXs/0OWNPdiNb1+Angk
         rTaahguVHR1Qz131zlV0kmOuAvFR+olMgkRxUIgIN7jJf/lVhx5MAe2QMq6N3cmRV2Si
         G0+fyhPIaVmGPqNk87fZiSAD848SQHhZOs85RXWhitO/Ajr44bJpQY1OMUnQva5THr7G
         8Y0UTClaNmJUNbtTxlkQM0MZyD+8B+C7qRLzH1ZKmEqHA3/vNIu6tfpeRSUq+sWQ0XQt
         JVeg==
X-Gm-Message-State: ABuFfohes1tX4UWRkzhXrFneLYeBZqs+lcvG0NudXOpAa+4U0wTJzwBi
        fx0/+DHXQfUq886OpA7MOwkvL3ur734Ag8yT+AoPD2tR
X-Google-Smtp-Source: ACcGV635Xlemb0zZ1+YOZVuFgeiIQK4zjqJXNUME0DQJI+N/6+00u16vsd72TrMRmJSE42ux+y9Zp9c77tMIGsGlRCw=
X-Received: by 2002:adf:decb:: with SMTP id i11-v6mr25089429wrn.270.1539199148506;
 Wed, 10 Oct 2018 12:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <1537971334-130152-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1537971334-130152-1-git-send-email-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 10 Oct 2018 15:18:56 -0400
Message-ID: <CADnq5_MF1KvBQQRPNuuRE1gcTq6aHutktCPBi2ocfjYyZAcPYA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable 'header'
To:     yuehaibing@huawei.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>, Likun Gao <Likun.Gao@amd.com>,
        David Francis <David.Francis@amd.com>,
        Huang Rui <ray.huang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        "monk.liu" <Monk.Liu@amd.com>, kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:01 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c: In function 'amdgpu_ucode_init_bo':
> drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:431:39: warning:
>  variable 'header' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 1fa8bc3..afd5cf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -428,7 +428,6 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>         uint64_t fw_offset = 0;
>         int i, err;
>         struct amdgpu_firmware_info *ucode = NULL;
> -       const struct common_firmware_header *header = NULL;
>
>         if (!adev->firmware.fw_size) {
>                 dev_warn(adev->dev, "No ip firmware need to load\n");
> @@ -465,7 +464,6 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>         for (i = 0; i < adev->firmware.max_ucodes; i++) {
>                 ucode = &adev->firmware.ucode[i];
>                 if (ucode->fw) {
> -                       header = (const struct common_firmware_header *)ucode->fw->data;
>                         amdgpu_ucode_init_single_fw(adev, ucode, adev->firmware.fw_buf_mc + fw_offset,
>                                                     adev->firmware.fw_buf_ptr + fw_offset);
>                         if (i == AMDGPU_UCODE_ID_CP_MEC1 &&
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
