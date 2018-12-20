Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CBBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CE32176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IixhOncg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeLTMIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:08:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42465 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeLTMIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:08:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so1315529lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+Cie+hX9uyE579W7SVj+x5h9uxygHhXQglD7p+kfotc=;
        b=IixhOncgtjk7X0Jf7L7/Yk1TCTg8lXfzBrltQvzBeOB5YUKHwuNVDjVDnqYd1Iyf3Q
         ro69I62WaQ971hwMYrFIaYD+fKXq/0UA1tyHNd1QUNJjto85OJn10fuShq2T5bRLn/Tb
         fSTIhm3khynFBgNTOuomCj5on+vcrer/eX1p/cTtlk2Ut6Q4Zxa7NN9zy27nDi3svLmk
         qF0kMogiWhcvrt3mV7TSxOX9kqihTD/es3/nLx90V3ui5JJIHMUP4SJp/9kQQW899N1z
         Ar++LuleBYDHJGgFfQ9XxTqRzA3maxXZ17YL7f+zVJDbsZQsbF8RqNGLAqJjPgGq6R2c
         nagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+Cie+hX9uyE579W7SVj+x5h9uxygHhXQglD7p+kfotc=;
        b=MG87HEZRUlXaAe3i4Gu27BMFw2VnmHbIEZS3BayCU9IiUGD796/pzGD5mU8Dgcrk3r
         XJyYl2Mm5FS+onZQ08N1VWFcDSAQJDWkDZunEsZ3t5BwPdAz1lmYEsMGaaAvLxe0FY/r
         LEjcpm90kWknW58SiKhc4Xe7e8uIPNrQhGZ/GDR0cunInwlb11boXxdH/xGMwR9MWXfg
         Bgzkxsw8C95HTX6yjlAUMZNPhKKd7oJDHMvZ+Q4hgQgk7PA9ipO3Fj86X8VPO/ikftkE
         AvjNMYPn234tciPpTCKQMp7R1y2Jjuq7IXW5wTlJLo/l7ckQHBGrS9+/sOfiW/BJuVIC
         0M5g==
X-Gm-Message-State: AA+aEWb4emROIMF+wDZZcYl9gzArcwYO0f7jrP7SAygeBCx3zmXkAcWx
        +pyl9Zz5f0L0Tmi6GG1fal4=
X-Google-Smtp-Source: AFSGD/U8tDikDJofcEYF06GeJcpuBZ/8yrccewF+K6JJiUSrcO5UwpHm9vZonprP5fVLgxbvE2l04Q==
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr14444075ljb.11.1545307710030;
        Thu, 20 Dec 2018 04:08:30 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id p23sm4296656lfh.47.2018.12.20.04.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:08:29 -0800 (PST)
Subject: Re: [PATCH 04/14] drm/bochs: atomic: add mode_set_nofb callback.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-5-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <bed74701-ac73-d8ed-866e-29f8017ca6f0@gmail.com>
Date:   Thu, 20 Dec 2018 14:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Conversion to atomic modesetting, step two.
> Add mode_set_nofb crtc helper callback.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/bochs/bochs_kms.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 59d469f343..18b705fb0b 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -86,6 +86,14 @@ static int bochs_crtc_mode_set(struct drm_crtc *crtc,
>   	return 0;
>   }
>   
> +static void bochs_crtc_mode_set_nofb(struct drm_crtc *crtc)
> +{
> +	struct bochs_device *bochs =
> +		container_of(crtc, struct bochs_device, crtc);
> +
> +	bochs_hw_setmode(bochs, &crtc->mode);
> +}
> +
>   static void bochs_crtc_prepare(struct drm_crtc *crtc)
>   {
>   }
> @@ -149,6 +157,7 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
>   	.dpms = bochs_crtc_dpms,
>   	.mode_set = bochs_crtc_mode_set,
>   	.mode_set_base = bochs_crtc_mode_set_base,
> +	.mode_set_nofb = bochs_crtc_mode_set_nofb,
>   	.prepare = bochs_crtc_prepare,
>   	.commit = bochs_crtc_commit,
>   	.atomic_enable = bochs_crtc_atomic_enable,

