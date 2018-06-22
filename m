Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019C7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F13F24961
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BouGN6bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F13F24961
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeFVXMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:12:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32998 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754576AbeFVXMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:12:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so3869697pfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iU2Mb92uUkwnbuOQjZPGkbfiyAbM+AyRuv3h9vf0TmE=;
        b=BouGN6bYW+k51Ck7Kkwo96w2jTnP9B5FaBKXGDljWFyNpl8i95rBuW20ZUGbV+D8Fb
         yQeClgjBaiRnD/yv8xum6uaBWlZ8pzAsepIayhTXSgvwXxkjyVeWglDNrrsWePnGBx69
         GIkX+3GMY9AeTiAF25may/i0sYdpl+NOvP06Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iU2Mb92uUkwnbuOQjZPGkbfiyAbM+AyRuv3h9vf0TmE=;
        b=aSL58hRem47foYuSAc6E1/KTmh9pay55v7PxjKws3SjiGGK9GpNeQhEtsfeT69U+2Y
         bcGqkVXCPHXGOcTMnisg+YEVCjBTqWNbKvZuf+sH5M3qOm5DHuC8iT72zb1DebTy+6qK
         0xuZOTgPGZ8Mq5RbJPouUkghXIl0hAdZJMdVITodpUfVCO6g0jaJTS8BEuxLgJkbjrzX
         6O8aiznalGtbLL63ZouicJJFq9N5TRAQnpzxnk7nwouvKmeVpzxSnJCdlZAyxIIzBIZy
         pa6TNsx+rkXEL52bqLsXV6lU8XEp0tVX/nrsVZMoPAoc2WGqx3CI1NPjy264MGQs65W6
         SmOg==
X-Gm-Message-State: APt69E0IYwBEPKS7OcbDMYGOgKYnwC45bG3uYh+floSS7AqJ1M24+BgN
        DVbCRGr/6yhorS8fiN4i7kyZUA==
X-Google-Smtp-Source: ADUXVKJgClzaI9pB1XbfWHRJg3+BhVUQ2gbVVKk//w0WvRABFBO5zgX/3s5nxB0Z5vHcC/cWlFkfFA==
X-Received: by 2002:a63:7986:: with SMTP id u128-v6mr2915585pgc.273.1529709163377;
        Fri, 22 Jun 2018 16:12:43 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j23-v6sm13057183pfi.137.2018.06.22.16.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 16:12:42 -0700 (PDT)
Date:   Fri, 22 Jun 2018 16:15:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vikash Garodia <vgarodia@codeaurora.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        stanimir.varbanov@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        acourbot@chromium.org
Subject: Re: [PATCH v2 1/5] media: venus: add a routine to reset ARM9
Message-ID: <20180622231503.GN3402@tuxbook-pro>
References: <1527884768-22392-1-git-send-email-vgarodia@codeaurora.org>
 <1527884768-22392-2-git-send-email-vgarodia@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527884768-22392-2-git-send-email-vgarodia@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01 Jun 13:26 PDT 2018, Vikash Garodia wrote:
> +static void venus_reset_hw(struct venus_core *core)
> +{
> +	void __iomem *reg_base = core->base;
> +
> +	writel(0, reg_base + WRAPPER_FW_START_ADDR);
> +	writel(VENUS_FW_MEM_SIZE, reg_base + WRAPPER_FW_END_ADDR);
> +	writel(0, reg_base + WRAPPER_CPA_START_ADDR);
> +	writel(VENUS_FW_MEM_SIZE, reg_base + WRAPPER_CPA_END_ADDR);
> +	writel(0x0, reg_base + WRAPPER_CPU_CGC_DIS);
> +	writel(0x0, reg_base + WRAPPER_CPU_CLOCK_CONFIG);
> +
> +	/* Make sure all register writes are committed. */
> +	mb();

wmb() doesn't wait until the writes are completed, it simply ensures
that any writes before it are performed before any writes after it.

If you really want to ensure that these configs has hit the hardware
before you sleep, read back the value of the WRAPPER_CPU_CLOCK_CONFIG
register.

> +
> +	/*
> +	 * Need to wait 10 cycles of internal clocks before bringing ARM9
> +	 * out of reset.
> +	 */
> +	udelay(1);
> +
> +	/* Bring Arm9 out of reset */
> +	writel_relaxed(0, reg_base + WRAPPER_A9SS_SW_RESET);

There's no harm in using writel() here...

> +}

Regards,
Bjorn
