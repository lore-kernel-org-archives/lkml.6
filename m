Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67258C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BA3206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="T/OQcV/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BA3206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeKQHwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:52:19 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43268 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeKQHwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:52:19 -0500
Received: by mail-yb1-f193.google.com with SMTP id h187-v6so10322298ybg.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PxIltTtwat7p4wJMBSGyQimAz1uAgPIdJMabzuAVwWU=;
        b=T/OQcV/99L8uXQWFl3HqWu9nTD2pG4GP2iekoEjseh0lq7y2iVZIABLcnwiA2VqQHx
         X/+tFRGy6vO287L0gYSdtERku7KH9E/O0JuDpunLNdV0tp8o82ZaccrklDglXtrLn3z7
         uTtMtQ/Md+hWqDufOZfcSM+EVrPV2FoxVx0meVITg7blWmsvwlIP+m7osjf/be67lscM
         h2S9D37s3T26ntXbxwhmhYJx79YKiEbvAx+5ZuCLHWmI9s60+p/ho2VdCNCj8ZncCV92
         IHuZvlwdJBVOZCaPpUH2Jcwon3hBIjbakUctfXxVnBwXe4X52tz8mioP5/LTScLirTkj
         r93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PxIltTtwat7p4wJMBSGyQimAz1uAgPIdJMabzuAVwWU=;
        b=hc7fvv6rtQv159Ene3/2h+KQyFURKrXD0FA6nqYRfhfk3dUKccla5e0fhL+WwM0v00
         Uag4iaShSucOrep15NMfWuVU9YeLwPZPId3fSp36LXR6X2L/KI6h1Jww7Zbnq+KAZmw7
         VLTknweGyXSKJZWDNYxZG8FWaY6KyH3UMsw5u7opKLgXd0yj2EZVkEwZGO3/cv7nRTup
         jGCQQV5uKUFperOUstG1MJ3RvvUMnl/Xpbm6AAruhPxSdoH6ESCw6hT/DUoFVD/BjOuv
         gj24bBdvdO6vmJPpa8okPVeU1guUtuP+SlANFBo3Jc8FnJyASXsOiY2X+j/YYxMo8/SK
         b1yg==
X-Gm-Message-State: AGRZ1gJ6knpPu1M8UYgi2aheLfFccMDX/8iSNXSMOP06ywOdIoumv8tg
        4MvIOB3YDU/n9zncas4knMuOsnSrASResA==
X-Google-Smtp-Source: AJdET5d6P4ymSgsVKG4nk1+Z4tjLHSoewVk8DBRpwKUVF/9tgye1P4TkyT5tkVBRdjqvhlTS8gm0Lg==
X-Received: by 2002:a25:f80a:: with SMTP id u10-v6mr12048421ybd.219.1542404293118;
        Fri, 16 Nov 2018 13:38:13 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id m133-v6sm3827125ywc.95.2018.11.16.13.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 13:38:12 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:38:12 -0500
From:   Sean Paul <sean@poorly.run>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     robdclark@gmail.com, airlied@linux.ie, seanpaul@chromium.org,
        linux-kernel@vger.kernel.org, jsanka@codeaurora.org,
        jcrouse@codeaurora.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/msm: dpu: Fix "WARNING: invalid free of devm_
 allocated data"
Message-ID: <20181116213812.GB154160@art_vandelay>
References: <20181116112526.10552-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116112526.10552-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 07:25:26PM +0800, YueHaibing wrote:
> 'dpu_enc' is a member of 'drm_enc'

It's the other way around :)

> And 'drm_enc' got allocated with devm_kzalloc in dpu_encoder_init.
> 
> This gives this error message:
> ./drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:459:1-6:
>  WARNING: invalid free of devm_ allocated data
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 82c55ef..99526d9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -455,8 +455,6 @@ static void dpu_encoder_destroy(struct drm_encoder *drm_enc)
>  
>  	drm_encoder_cleanup(drm_enc);
>  	mutex_destroy(&dpu_enc->enc_lock);
> -
> -	kfree(dpu_enc);
>  }
>  
>  void dpu_encoder_helper_split_config(
> -- 
> 2.7.0
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
