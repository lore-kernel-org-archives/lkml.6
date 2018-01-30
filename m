Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeA3CVf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 21:21:35 -0500
Received: from regular1.263xmail.com ([211.150.99.130]:38443 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbeA3CVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 21:21:33 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: sandy.huang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <876510b40964230fddd0be7e64ef4f0a>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 01/43] drm/rockchip: Get rid of unnecessary struct
 fields
To: Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Tomasz Figa <tfiga@chromium.org>
Cc: Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?Q?=c3=98rjan_Eide?= <orjan.eide@arm.com>,
        Haixia Shi <hshi@chromium.org>
References: <20180126131710.7622-1-thierry.escande@collabora.com>
 <20180126131710.7622-2-thierry.escande@collabora.com>
From: Sandy Huang <hjc@rock-chips.com>
Message-ID: <0450cb94-962e-7b17-3d3a-2cf3c8f504c4@rock-chips.com>
Date: Tue, 30 Jan 2018 10:21:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180126131710.7622-2-thierry.escande@collabora.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2018/1/26 21:16, Thierry Escande Ð´µÀ:
> From: Tomasz Figa <tfiga@chromium.org>
> 
> This patch removes unused fields from vop structure.
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index ba7505292b78..7a137bc5708c 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -95,9 +95,6 @@ struct vop {
>   	struct drm_device *drm_dev;
>   	bool is_enabled;
>   
> -	/* mutex vsync_ work */
> -	struct mutex vsync_mutex;
> -	bool vsync_work_pending;
>   	struct completion dsp_hold_completion;
>   
>   	/* protected by dev->event_lock */
> @@ -1567,8 +1564,6 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
>   	spin_lock_init(&vop->reg_lock);
>   	spin_lock_init(&vop->irq_lock);
>   
> -	mutex_init(&vop->vsync_mutex);
> -
>   	ret = devm_request_irq(dev, vop->irq, vop_isr,
>   			       IRQF_SHARED, dev_name(dev), vop);
>   	if (ret)
> 
Reviewed-by: Sandy huang <hjc@rock-chips.com>
