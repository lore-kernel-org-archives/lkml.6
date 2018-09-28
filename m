Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DDDC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E4D216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="HA8SQRov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E4D216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeI1Nnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:43:52 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38536 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbeI1Nnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:43:52 -0400
Received: by mail-yw1-f67.google.com with SMTP id d126-v6so2217424ywa.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D9gWa7fu4i0NHR67rYPV0hKYax0wtWp/u83TZhiScO0=;
        b=HA8SQRovbk6zHzg/9BwW9/noCrHoFONuU5gP3PtA5t2GwF6Wipg7Zxj+gE8KNvWNDV
         z+yK2QRnLMvM1Xqkw3VCUwZIoZM2UPsxyLzR4eITpJxtjk58nHJzxZZ5sjBQ24+8KChD
         BO033xmpgQCABH2ICvPTKj9NXx8cdfb22XMI+WPdMRPS26z2TeLpaj0yo9CY0RYfoXSv
         KZStUEXT+gUSMqvSTElaKaf9laPNbVVOVKLTaOIHRcNM2vEzWid8TVp2DDALBcBpWssw
         Ma1RyCrNGjQQW2JkzwLvOu6i+sVouk1dAQRahYZO1tzE4bPC8YQ5xDqHVyQO43eYl6HZ
         MrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D9gWa7fu4i0NHR67rYPV0hKYax0wtWp/u83TZhiScO0=;
        b=BtY9I2CYmT0BUi+D6CXoQqFsB9exunijlIgLVcKrU8KrdUtkjWTB17IDF3FV0nTq1y
         m8FCZE8uEWkWSkB2vDNPCKPDU8qNup7wr12jRPV+GlgJlwF61RFyOS+7OgtUfH/o+Q6Y
         xmqzd83/KdNrRPPK07zsBJpXVTHYdMghLLxXLy3S9UZfNMYjvvSfsOJdUEBApkNSE27N
         7an9Y+N/ogm2craB2Zz092nzaLDJ2/e0fbm25Nw1NFnQwDdCH8WLpeQ2de9mScXTTev5
         B+EYxp0ZDzIP9DJhD/EsMjfDsp3L9q8ug/N24zajLWo+VWHa1JGL6LZHXuvWw56uirz+
         wueQ==
X-Gm-Message-State: ABuFfogsptbvkqk49rssY6Knyex5ma4eyYC07rhWLEcxqcGCJZ7f7cSy
        hvqckt62Fq1hJN7a7GrCl3RiUsQrcRqFRLbf
X-Google-Smtp-Source: ACcGV60Ye5tiSWduadup6e7Ay0OqiPU9OWI0DVKmre4HcK2UwYU6z0TxgS3FFxE7XWeGtYrCAJ11pA==
X-Received: by 2002:a0d:c4c2:: with SMTP id g185-v6mr7706150ywd.355.1538119289933;
        Fri, 28 Sep 2018 00:21:29 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id r69-v6sm2169329ywh.44.2018.09.28.00.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 00:21:29 -0700 (PDT)
Date:   Fri, 28 Sep 2018 03:21:29 -0400
From:   Sean Paul <sean@poorly.run>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, pgaj@cadence.com,
        ltyrala@cadence.com, rafalc@cadence.com, jartur@cadence.com,
        piotrs@cadence.com, quentin.schulz@bootlin.com, jbergsagel@ti.com
Subject: Re: [PATCH v5 3/5] drm/dp: make dp_get_lane_status usable from
 outside of the core
Message-ID: <20180928072129.GX72545@art_vandelay>
References: <1537866837-4408-1-git-send-email-dkos@cadence.com>
 <1537866837-4408-4-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537866837-4408-4-git-send-email-dkos@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:13:33AM +0100, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> dp_get_lane_status is pretty generic and can be used for other means,
> so let's make it "public".
> 
> This adds drm_dp_get_lane_status to the header file and add the appropriate
> EXPORT_SYMBOL for it so that it can be used by other drivers, be they compiled
> built-in or as modules.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Signed-off-by: Damian Kos <dkos@cadence.com>

Now that you've refactored mhdp_validate_cr(), you no longer need this patch.

Sean

> ---
>  drivers/gpu/drm/drm_dp_helper.c | 9 +++++----
>  include/drm/drm_dp_helper.h     | 2 ++
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 735ebde5c2f0..169db52f92f5 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -48,14 +48,15 @@ static u8 dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
>  	return link_status[r - DP_LANE0_1_STATUS];
>  }
>  
> -static u8 dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
> -			     int lane)
> +u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
> +			  int lane)
>  {
>  	int i = DP_LANE0_1_STATUS + (lane >> 1);
>  	int s = (lane & 1) * 4;
>  	u8 l = dp_link_status(link_status, i);
>  	return (l >> s) & 0xf;
>  }
> +EXPORT_SYMBOL(drm_dp_get_lane_status);
>  
>  bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  			  int lane_count)
> @@ -69,7 +70,7 @@ bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  	if ((lane_align & DP_INTERLANE_ALIGN_DONE) == 0)
>  		return false;
>  	for (lane = 0; lane < lane_count; lane++) {
> -		lane_status = dp_get_lane_status(link_status, lane);
> +		lane_status = drm_dp_get_lane_status(link_status, lane);
>  		if ((lane_status & DP_CHANNEL_EQ_BITS) != DP_CHANNEL_EQ_BITS)
>  			return false;
>  	}
> @@ -84,7 +85,7 @@ bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  	u8 lane_status;
>  
>  	for (lane = 0; lane < lane_count; lane++) {
> -		lane_status = dp_get_lane_status(link_status, lane);
> +		lane_status = drm_dp_get_lane_status(link_status, lane);
>  		if ((lane_status & DP_LANE_CR_DONE) == 0)
>  			return false;
>  	}
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 698082a02b97..973d2fda9654 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -952,6 +952,8 @@
>  #define DP_MST_LOGICAL_PORT_0 8
>  
>  #define DP_LINK_STATUS_SIZE	   6
> +
> +u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE], int lane);
>  bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  			  int lane_count);
>  bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
> -- 
> 2.17.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
