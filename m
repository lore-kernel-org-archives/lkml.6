Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B748C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0841C21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTM11Oio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbeLTMPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:15:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43129 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeLTMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:15:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so1329481lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UltgMZZoLA6nZBKiJO5dAACg4hTITjHByF6W8Um+CnE=;
        b=CTM11OioPTcTN+/9oWMSKqWCesEzhOGQpdBfFABSgcEp+RtjI+3Ab1VrNOkso97A0s
         hbmpJ4QeZTetvhMesQ7FHH5JzwXi3M5O4WknVzmb+SOwr1bqMxQs0hG92z2w5BMeLUIH
         mzgiVq/oKUU/EAiRqVJqtBPg3Wf/QOiDehEn0m7pcQPvcLKn5M1SlkF1sspnQqCyTKAm
         2Xf5b/ZF4kRFe9QB4Hyn/JpDlJEM8bvIdoU8Kcq3uDK1b3PNGQ5seb4BefByzaDrJINg
         GYmjkTUVfr0aWn3d/gws90VoWQQvuAxavOnOSUhtPY3Vtj+ABRONPRpiTuScysPvDPpk
         AAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UltgMZZoLA6nZBKiJO5dAACg4hTITjHByF6W8Um+CnE=;
        b=daxQwlKEqDZqOd/MZrE1OZM8qM3kOK5WdjQS/WAZHPcL/4Qct+p3vW+5NJ3VMCcbvr
         1LHpPORyu+s1vtaDGN6NeIN8K+ONG3HVa/4c/SjzUO/WaQgkj/yh0uPXtBug/Gn7vfnI
         RxQB6UF60UwYqpoT7gyQ3LV/etk3k/vuSbH0Y6il7AQiyR3oHWKXfy4F+FVHwwI2xn/K
         /8yq5edoSRaFnWOBBufj5z8HENfLWbZDjEfTZ6KixXHZc+ryvz92lPW3+hphYdaTT/XY
         zxpC/tmFOILM/nOzRmZ5gFNoqzqH02V+w0iIEdlEN7YfjnD+t5LzIWAfGEadLU4g4RUF
         O1nQ==
X-Gm-Message-State: AA+aEWZ/e/5HA7cA+/z8JZCj18+8Ld7zC+1KBqIuxpwGRR/lkU/j/QTG
        beop9wDLvtLanfvV3/s4ZjdpQf/+
X-Google-Smtp-Source: AFSGD/W9YRlV/XvLxJ3kSZdpjyqZ6RGCfyVH6aRSPE59wMZT+4j7uzYVFgPZhQR+wEaeNLp7LuKuKg==
X-Received: by 2002:a05:651c:14e:: with SMTP id c14mr14416675ljd.20.1545308098447;
        Thu, 20 Dec 2018 04:14:58 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id h12-v6sm4053896ljb.80.2018.12.20.04.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:14:57 -0800 (PST)
Subject: Re: [PATCH 06/14] drm/bochs: atomic: use atomic set_config helper
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-7-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <6af06d90-169c-abe0-b746-dd2e7fe69d4a@gmail.com>
Date:   Thu, 20 Dec 2018 14:14:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-7-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Conversion to atomic modesetting, step four.
> Use atomic set_config helper for crtc.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/bochs/bochs_kms.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index aa3ba0377a..dcc8b864fc 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -150,7 +150,7 @@ static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
>   
>   /* These provide the minimum set of functions required to handle a CRTC */
>   static const struct drm_crtc_funcs bochs_crtc_funcs = {
> -	.set_config = drm_crtc_helper_set_config,
> +	.set_config = drm_atomic_helper_set_config,
>   	.destroy = drm_crtc_cleanup,
>   	.page_flip = bochs_crtc_page_flip,
>   	.reset = drm_atomic_helper_crtc_reset,

