Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD4821726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="YyPjsn+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfAVUMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:12:01 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37366 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfAVUMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:12:00 -0500
Received: by mail-yb1-f195.google.com with SMTP id 2so9107778ybw.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 12:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hraNLzCILizjLFoyJU2KQqxBF9/mllvQ6yego70fDmE=;
        b=YyPjsn+ayZdNu7UZE6UtAoCxYDw+F9LkiYWIokON+2VPh0aNEz4dJBUEg3xqtn89NI
         SZyiSlITNU1q1DFK0SfdGoFNDkol5mHKAPXo599+ox1+zND4UtzqHiMknas+kDSHNz38
         MDC7cpcKDQ837hEsN7HCZfO62v1uOXcxt+oyr/PULkdNrpCPAW0bl7U3v/sanfEFIESa
         fDB2ExEogkgNOsG3JHRdftTV5R+yc0dZOlzyxPDv9CGpicNC5UM2tsGDLI8cd/GZCJ9E
         B0eh0r9fnwGfTDIGpnNR+PvWz+osYL6zL/Xp81+qJ3NMKEYUp+SgdiqYApu/9CgkzgFn
         aZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hraNLzCILizjLFoyJU2KQqxBF9/mllvQ6yego70fDmE=;
        b=o8hdRLBbXdXXSytYYleUM4ihosE/tssXkV4MXt71Mx3XQIWg0JeIcRCoj28k4qfZXl
         Y0G/jsuQr3lG/Rov5Rivg/2sjCcBUJWRvzRv5MoMogz5Talx8czEKSy/3lmB9qKhdXf9
         WWgVQZgif75qzjLpzlhoN1oqdhiNNEmYC/3sVugckMtBll9ORIHEqTR4zOCuHKzxM+M0
         WMzLR+CVNIyyOfRR/2D0+yMuGL5TX7GZoNgBsctcN51cNXuSFsufLR40aunlWG3XSzDp
         gvDZIT34HquMrDGsk9phJbghNsMuhpllcqRdKyjgfmm3eqn8jhnnHYTkprVnKjIMJLlx
         fx3g==
X-Gm-Message-State: AJcUuke5FLLu3eMaAHVPZOGAsdA9VUEeDqTsHCe0sMi2VXJXj4z9oVM+
        c044NY8c5bf57LV688rcJDyijg==
X-Google-Smtp-Source: ALg8bN5x38dOwscjLtv4K9rtPekdequVfIdeRSsvbIT4SDOJDih7PDCdGvdC+BRGTngMpwhMLzy/Hw==
X-Received: by 2002:a25:ca08:: with SMTP id a8mr13518415ybg.127.1548187918868;
        Tue, 22 Jan 2019 12:11:58 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id b129sm7318468ywc.106.2019.01.22.12.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 12:11:58 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:11:58 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, abhinavk@codeaurora.org,
        robdclark@gmail.com, nganji@codeaurora.org, seanpaul@chromium.org,
        hoegsberg@chromium.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org
Subject: Re: [Freedreno] [v3] drm/msm/dpu: Clean up dpu hw interrupts
Message-ID: <20190122201157.GL114153@art_vandelay>
References: <1545132948-20833-1-git-send-email-jshekhar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545132948-20833-1-git-send-email-jshekhar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:05:48PM +0530, Jayant Shekhar wrote:
> Remove unused functions and macros from files handling
> dpu hardware interrupts.
> 
> changes in v2:
>   Removed clear_interrupt_status (Jordan Crouse)
> changes in v3:
>   Changed commit text
> 
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>

Applied to dpu-staging, thanks!

Sean
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 44 -----------------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h | 44 -----------------------
>  2 files changed, 88 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> index c0b7f00..8a28a03 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> @@ -170,10 +170,6 @@
>  /**
>   * AD4 interrupt status bit definitions
>   */
> -#define DPU_INTR_BRIGHTPR_UPDATED BIT(4)
> -#define DPU_INTR_DARKENH_UPDATED BIT(3)
> -#define DPU_INTR_STREN_OUTROI_UPDATED BIT(2)
> -#define DPU_INTR_STREN_INROI_UPDATED BIT(1)
>  #define DPU_INTR_BACKLIGHT_UPDATED BIT(0)
>  /**
>   * struct dpu_intr_reg - array of DPU register sets
> @@ -782,18 +778,6 @@ static int dpu_hw_intr_irqidx_lookup(enum dpu_intr_type intr_type,
>  	return -EINVAL;
>  }
>  
> -static void dpu_hw_intr_set_mask(struct dpu_hw_intr *intr, uint32_t reg_off,
> -		uint32_t mask)
> -{
> -	if (!intr)
> -		return;
> -
> -	DPU_REG_WRITE(&intr->hw, reg_off, mask);
> -
> -	/* ensure register writes go through */
> -	wmb();
> -}
> -
>  static void dpu_hw_intr_dispatch_irq(struct dpu_hw_intr *intr,
>  		void (*cbfunc)(void *, int),
>  		void *arg)
> @@ -1004,18 +988,6 @@ static int dpu_hw_intr_disable_irqs(struct dpu_hw_intr *intr)
>  	return 0;
>  }
>  
> -static int dpu_hw_intr_get_valid_interrupts(struct dpu_hw_intr *intr,
> -		uint32_t *mask)
> -{
> -	if (!intr || !mask)
> -		return -EINVAL;
> -
> -	*mask = IRQ_SOURCE_MDP | IRQ_SOURCE_DSI0 | IRQ_SOURCE_DSI1
> -		| IRQ_SOURCE_HDMI | IRQ_SOURCE_EDP;
> -
> -	return 0;
> -}
> -
>  static void dpu_hw_intr_get_interrupt_statuses(struct dpu_hw_intr *intr)
>  {
>  	int i;
> @@ -1065,19 +1037,6 @@ static void dpu_hw_intr_clear_intr_status_nolock(struct dpu_hw_intr *intr,
>  	wmb();
>  }
>  
> -static void dpu_hw_intr_clear_interrupt_status(struct dpu_hw_intr *intr,
> -		int irq_idx)
> -{
> -	unsigned long irq_flags;
> -
> -	if (!intr)
> -		return;
> -
> -	spin_lock_irqsave(&intr->irq_lock, irq_flags);
> -	dpu_hw_intr_clear_intr_status_nolock(intr, irq_idx);
> -	spin_unlock_irqrestore(&intr->irq_lock, irq_flags);
> -}
> -
>  static u32 dpu_hw_intr_get_interrupt_status(struct dpu_hw_intr *intr,
>  		int irq_idx, bool clear)
>  {
> @@ -1113,16 +1072,13 @@ static u32 dpu_hw_intr_get_interrupt_status(struct dpu_hw_intr *intr,
>  
>  static void __setup_intr_ops(struct dpu_hw_intr_ops *ops)
>  {
> -	ops->set_mask = dpu_hw_intr_set_mask;
>  	ops->irq_idx_lookup = dpu_hw_intr_irqidx_lookup;
>  	ops->enable_irq = dpu_hw_intr_enable_irq;
>  	ops->disable_irq = dpu_hw_intr_disable_irq;
>  	ops->dispatch_irqs = dpu_hw_intr_dispatch_irq;
>  	ops->clear_all_irqs = dpu_hw_intr_clear_irqs;
>  	ops->disable_all_irqs = dpu_hw_intr_disable_irqs;
> -	ops->get_valid_interrupts = dpu_hw_intr_get_valid_interrupts;
>  	ops->get_interrupt_statuses = dpu_hw_intr_get_interrupt_statuses;
> -	ops->clear_interrupt_status = dpu_hw_intr_clear_interrupt_status;
>  	ops->clear_intr_status_nolock = dpu_hw_intr_clear_intr_status_nolock;
>  	ops->get_interrupt_status = dpu_hw_intr_get_interrupt_status;
>  }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
> index 61e4cba..4d7a1c7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
> @@ -20,13 +20,6 @@
>  #include "dpu_hw_util.h"
>  #include "dpu_hw_mdss.h"
>  
> -#define IRQ_SOURCE_MDP		BIT(0)
> -#define IRQ_SOURCE_DSI0		BIT(4)
> -#define IRQ_SOURCE_DSI1		BIT(5)
> -#define IRQ_SOURCE_HDMI		BIT(8)
> -#define IRQ_SOURCE_EDP		BIT(12)
> -#define IRQ_SOURCE_MHL		BIT(16)
> -
>  /**
>   * dpu_intr_type - HW Interrupt Type
>   * @DPU_IRQ_TYPE_WB_ROT_COMP:		WB rotator done
> @@ -96,18 +89,6 @@ enum dpu_intr_type {
>   */
>  struct dpu_hw_intr_ops {
>  	/**
> -	 * set_mask - Programs the given interrupt register with the
> -	 *            given interrupt mask. Register value will get overwritten.
> -	 * @intr:	HW interrupt handle
> -	 * @reg_off:	MDSS HW register offset
> -	 * @irqmask:	IRQ mask value
> -	 */
> -	void (*set_mask)(
> -			struct dpu_hw_intr *intr,
> -			uint32_t reg,
> -			uint32_t irqmask);
> -
> -	/**
>  	 * irq_idx_lookup - Lookup IRQ index on the HW interrupt type
>  	 *                 Used for all irq related ops
>  	 * @intr_type:		Interrupt type defined in dpu_intr_type
> @@ -177,16 +158,6 @@ struct dpu_hw_intr_ops {
>  			struct dpu_hw_intr *intr);
>  
>  	/**
> -	 * clear_interrupt_status - Clears HW interrupt status based on given
> -	 *                          lookup IRQ index.
> -	 * @intr:	HW interrupt handle
> -	 * @irq_idx:	Lookup irq index return from irq_idx_lookup
> -	 */
> -	void (*clear_interrupt_status)(
> -			struct dpu_hw_intr *intr,
> -			int irq_idx);
> -
> -	/**
>  	 * clear_intr_status_nolock() - clears the HW interrupts without lock
>  	 * @intr:	HW interrupt handle
>  	 * @irq_idx:	Lookup irq index return from irq_idx_lookup
> @@ -206,21 +177,6 @@ struct dpu_hw_intr_ops {
>  			struct dpu_hw_intr *intr,
>  			int irq_idx,
>  			bool clear);
> -
> -	/**
> -	 * get_valid_interrupts - Gets a mask of all valid interrupt sources
> -	 *                        within DPU. These are actually status bits
> -	 *                        within interrupt registers that specify the
> -	 *                        source of the interrupt in IRQs. For example,
> -	 *                        valid interrupt sources can be MDP, DSI,
> -	 *                        HDMI etc.
> -	 * @intr:	HW interrupt handle
> -	 * @mask:	Returning the interrupt source MASK
> -	 * @return:	0 for success, otherwise failure
> -	 */
> -	int (*get_valid_interrupts)(
> -			struct dpu_hw_intr *intr,
> -			uint32_t *mask);
>  };
>  
>  /**
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
Sean Paul, Software Engineer, Google / Chromium OS
