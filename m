Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7863BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2600220834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="AW7a+YKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2600220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeJZCoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:44:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38542 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJZCoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:44:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id r22-v6so10992912qtm.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jMY5gsLRtkcxaEQuO4CexL42ifisuL+7HQtoBDwmyt4=;
        b=AW7a+YKcIhRs1tkEAYjH0UwwZNslTWTNJkb/0igQd2KkNaTZsf3KCgdVDqfbMiEPyq
         s2nS2BBLPI7291O3NPHl+j+dBfqnHI9YcnCNokrg32/1jCa/etEoW18NLk2CQuq0Mjs6
         uU56w3eRPJ/R/j03AcPaGu/n7oRCEf0bVpTmO+Z0pRVbqsmDd04r/YKfyNEEfNatSPsZ
         Q7M6FFaNizwBXQ/eOjaVJdeCgK9Ep5PQqgljaPET6F51u0p5VZuFblYDJ6IucvNcGXTO
         yvVTBRHD2JGhwi/+Xvc7OkxMNBZy9BGPWUyzdMUKSUJAwQ2gH3TWeeNGWiHQGfGwPx7b
         MhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jMY5gsLRtkcxaEQuO4CexL42ifisuL+7HQtoBDwmyt4=;
        b=e/eGOw2UgLvzGD1DyZ/bC/Uv4U43aIVnztXBD+Ru7BQnlwRW/rSXZ+HQRRpoOv3tNt
         4xIhw7VxB2KWWiMAYEoZf6kCe14+nnA7Lyae/g1mKro6NxmSKjQ3TmcSqyeT+ZyBXFmn
         1eQfmgKT+fAgRWQYtejAnEd+Bi4dwBcSQJsVcQjiHzuPg/ztKd3CN0ceOi/9l81Kf6gm
         ZRJlnKC6B7fXx24rI/1MwYn0lST5HpyYolz5aYb7mIvd4ZABOqydjWVMGjoXlcd26K1K
         Y7YgFWVkv3L4qplM6YGj4dZXhaN+0bTDq+x+kBpE6uYH+ld/jJ+Gx9V7+QmEFdbe3K54
         8KRA==
X-Gm-Message-State: AGRZ1gL5zBl9wR9lQBWT2aXr9AN5aybO9C0c1BiGGhAqCh0nwJd/tZfV
        x8omQB2Xz2IzLMkkjuemocgdig==
X-Google-Smtp-Source: AJdET5e/DdPXg91Tzyqv2ZlRJznDmLaDyA8cj+Z54qo3kQbEoXN+QDrUyczCm54SC+ejWM0L28ENwQ==
X-Received: by 2002:a0c:8822:: with SMTP id 31mr292718qvl.5.1540491018911;
        Thu, 25 Oct 2018 11:10:18 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id p127-v6sm5803160qkd.70.2018.10.25.11.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:10:18 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:10:17 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH 4/6] drm/bridge: ti-sn65dsi86: Remove the mystery delay
Message-ID: <20181025181017.GL154160@art_vandelay>
References: <20181022204639.8558-1-dianders@chromium.org>
 <20181022204639.8558-4-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022204639.8558-4-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:46:37PM -0700, Douglas Anderson wrote:
> Let's solve the mystery of commit bf1178c98930 ("drm/bridge:
> ti-sn65dsi86: Add mystery delay to enable()").  Specifically the
> reason we needed that mystery delay is that we weren't paying
> attention to HPD.
> 
> Looking at the datasheet for the same panel that was tested for the
> original commit, I see there's a timing "t3" that times from power on
> to the aux channel being operational.  This time is specced as 0 - 200
> ms.  The datasheet says that the aux channel is operational at exactly
> the same time that HPD is asserted.
> 
> Scoping the signals on this board showed that HPD was asserted 84 ms
> after power was asserted.  That very closely matches the magic 70 ms
> delay that we had.  ...and actually, in my testing the 70 ms wasn't
> quite enough of a delay and some percentage of the time the display
> didn't come up until I bumped it to 100 ms (presumably 84 ms would
> have worked too).
> 
> To solve this, we tried to hook up the HPD signal in the bridge.
> ...but in doing so we found that that the bridge didn't report that
> HPD was asserted until ~280 ms after we powered it (!).  This is
> explained by looking at the sn65dsi86 datasheet section "8.4.5.1 HPD
> (Hot Plug/Unplug Detection)".  Reading there we see that the bridge
> isn't even intended to report HPD until 100 ms after it's asserted.
> ...but that would have left us at 184 ms.  The extra 100 ms
> (presumably) comes from this part in the datasheet:
> 
> > The HPD state machine operates off an internal ring oscillator. The
> > ring oscillator frequency will vary [ ... ]. The min/max range in
> > the HPD State Diagram refers to the possible times based off
> > variation in the ring oscillator frequency.
> 
> Given that the 280 ms we'll end up delaying if we hook up HPD is
> _slower_ than the 200 ms we could just hardcode, for now we'll solve
> the problem by just hardcoding a 200 ms delay in the panel driver
> using the patch in this series ("drm/panel: simple: Support panels
> with HPD where HPD isn't connected").
> 
> If we later find a panel that needs to use this bridge where we need
> HPD then we'll have to come up with some new code to handle it.  Given
> the silly debouncing in the bridge chip, though, it seems unlikely.
> 
> One last note is that I tried to solve this through another way: In
> ti_sn_bridge_enable() I tried to use various combinations of
> dp_dpcd_writeb() and dp_dpcd_readb() to detect when the aux channel
> was up.  In theory that would let me detect _exactly_ when I could
> continue and do link training.  Unfortunately even if I did an aux
> transfer w/out waiting I couldn't see any errors.  Possibly I could
> keep looping over link training until it came back with success, but
> that seemed a little overly hacky to me.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Awesome commit message and comment, thanks for solving the mystery!

Reviewed-by: Sean Paul <sean@poorly.run>


> ---
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 29 +++++++++++++++------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index f8a931cf3665..680566d97adc 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -458,18 +458,6 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
>  	unsigned int val;
>  	int ret;
>  
> -	/*
> -	 * FIXME:
> -	 * This 70ms was found necessary by experimentation. If it's not
> -	 * present, link training fails. It seems like it can go anywhere from
> -	 * pre_enable() up to semi-auto link training initiation below.
> -	 *
> -	 * Neither the datasheet for the bridge nor the panel tested mention a
> -	 * delay of this magnitude in the timing requirements. So for now, add
> -	 * the mystery delay until someone figures out a better fix.
> -	 */
> -	msleep(70);
> -
>  	/* DSI_A lane config */
>  	val = CHA_DSI_LANES(4 - pdata->dsi->lanes);
>  	regmap_update_bits(pdata->regmap, SN_DSI_LANES_REG,
> @@ -536,7 +524,22 @@ static void ti_sn_bridge_pre_enable(struct drm_bridge *bridge)
>  	/* configure bridge ref_clk */
>  	ti_sn_bridge_set_refclk_freq(pdata);
>  
> -	/* in case drm_panel is connected then HPD is not supported */
> +	/*
> +	 * HPD on this bridge chip is a bit useless.  This is an eDP bridge
> +	 * so the HPD is an internal signal that's only there to signal that
> +	 * the panel is done powering up.  ...but the bridge chip debounces
> +	 * this signal by between 100 ms and 400 ms (depending on process,
> +	 * voltage, and temperate--I measured it at about 200 ms).  One
> +	 * particular panel asserted HPD 84 ms after it was powered on meaning
> +	 * that we saw HPD 284 ms after power on.  ...but the same panel said
> +	 * that instead of looking at HPD you could just hardcode a delay of
> +	 * 200 ms.  We'll assume that the panel driver will have the hardcoded
> +	 * delay in its prepare and always disable HPD.
> +	 *
> +	 * If HPD somehow makes sense on some future panel we'll have to
> +	 * change this to be conditional on someone specifying that HPD should
> +	 * be used.
> +	 */
>  	regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG, HPD_DISABLE,
>  			   HPD_DISABLE);
>  
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
