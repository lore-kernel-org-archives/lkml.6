Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeDBFWw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 01:22:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55188 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbeDBFWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 01:22:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96CEC607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v2 3/6] drm/msm: Mark the crtc->state->event consumed
To: Sean Paul <seanpaul@chromium.org>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: robdclark@gmail.com, hoegsberg@chromium.org, jsanka@codeaurora.org,
        abhinavk@codeaurora.org, linux-kernel@vger.kernel.org
References: <20180328190657.218661-1-seanpaul@chromium.org>
 <20180328190657.218661-4-seanpaul@chromium.org>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <9fdb112c-7e2e-0f2d-646a-c9ffb3c4c5f8@codeaurora.org>
Date: Mon, 2 Apr 2018 10:52:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328190657.218661-4-seanpaul@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 29 March 2018 12:36 AM, Sean Paul wrote:
> Don't leave the event != NULL once it's consumed, this is used a signal
s/used a/used as a ?
> to the atomic helpers that the event will be handled by the driver.
>

Reviewed-by: Archit Taneja <architt@codeaurora.org>

> Changes in v2:
> - None
> 
> Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c | 1 +
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> index 6e5e1aa54ce1..b001699297c4 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> @@ -351,6 +351,7 @@ static void mdp4_crtc_atomic_flush(struct drm_crtc *crtc,
>   
>   	spin_lock_irqsave(&dev->event_lock, flags);
>   	mdp4_crtc->event = crtc->state->event;
> +	crtc->state->event = NULL;
>   	spin_unlock_irqrestore(&dev->event_lock, flags);
>   
>   	blend_setup(crtc);
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> index 9893e43ba6c5..76b96081916f 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> @@ -708,6 +708,7 @@ static void mdp5_crtc_atomic_flush(struct drm_crtc *crtc,
>   
>   	spin_lock_irqsave(&dev->event_lock, flags);
>   	mdp5_crtc->event = crtc->state->event;
> +	crtc->state->event = NULL;
>   	spin_unlock_irqrestore(&dev->event_lock, flags);
>   
>   	/*
> 
