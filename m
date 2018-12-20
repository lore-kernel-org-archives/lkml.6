Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C9C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DB021904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545342054;
	bh=2idrwtPcnlrZPsUUEdlPXAgVtAS4C11FwmMlxk3wb7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w8h+OYpPjH/7LjJdEy1BZKOkXj0SePC+b9i32mo9xqw2pON6qAqEv3AHyIQ6ZKD9k
	 dlS5HW1GKuSojxVlVeZcSrxcIX3JYixFbM13/xId9dA/IA8EcqBVbe7BtdPVoIUhOR
	 gY1/J4sZxr8H4LM/ZjH2rknTrfzYkfjDG7V0gFI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbeLTVkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:40:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36337 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbeLTVkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:40:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so1472643plo.3;
        Thu, 20 Dec 2018 13:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OzlDUGVZLwA1bPenBZhw8gF2o4JDnMQ6lT/6wPw/zFg=;
        b=QWU/19p+L5GUOecus9ed1FYyHNmcoYRy3FQagRTFlq8l9v88C9JsFbeBcel++NEBmP
         bqEosfh+/ggn30QFEJw7lc3Xwe/Hnbt0sQKlESxN4yL8UV6DihV+7SBnKkhIWqtZdsFV
         afgSa6aPQOhaeG+Idmv0C4c/qMlkIdG8bpAGzw/ef3EmdiyjpiMFGlyJ7mUoWCKN8V3s
         AvTx8Z1nHgIKoGGUDaOuVJji87tHA19MM8k83CHqgaDK/L7Y0voGE9rDrLOgdEX5Str9
         noPJ7upVAOt/Toy2zLbwuOT7Fs/ZZVn4wvKjr2sF4mWCLtY6p+Don1+1ytJnyZQOLK1O
         LIjg==
X-Gm-Message-State: AA+aEWZue82V3j084WtMsr0DcHWJpULentl1b135spiNTDsKSRcwVy4O
        EyFlWE1eyjNyBIB1YMdPOw==
X-Google-Smtp-Source: AFSGD/UFVTsWeOtKla8gn4ybx5gCW+EByIkVajFut8Aul+L32NEp5KzdiETowkB/S7OXnNezF/oMbg==
X-Received: by 2002:a17:902:a710:: with SMTP id w16mr25082864plq.95.1545342051999;
        Thu, 20 Dec 2018 13:40:51 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id q5sm37727187pfi.165.2018.12.20.13.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:40:51 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:40:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 06/15] drm/rockchip: analogix_dp: add support for the
 rk3368 variant
Message-ID: <20181220214049.GA14179@bogus>
References: <20181217123650.6773-1-heiko@sntech.de>
 <20181217123650.6773-7-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217123650.6773-7-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 13:36:41 +0100, Heiko Stuebner wrote:
> Add the compatible and allow the driver to also not set any crtc input
> on socs that only have one vop. While that was already possible
> because the driver checked against the grf-reg being 0, make that
> var an int as "0x0" is a valid grf address itself. So standardize
> on -1 for "no setting needed".
> 
> The dp controller behaves similar to the one found on rk3288, so we
> don't add a new chip_type to not overly pollute the bridge driver.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../display/rockchip/analogix_dp-rockchip.txt   |  1 +
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 17 +++++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
