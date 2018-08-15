Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30F2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A9021566
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A9021566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeHPBQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:16:06 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37088 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeHPBQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:16:06 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so4087216itf.2;
        Wed, 15 Aug 2018 15:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ax9bZfHgKpfM/ozxbqZMv3Ghf48gtyNUSpFHZcaq5Mo=;
        b=ALIlm4jSRbvbg+AG1G6tUti1KOd2nBv5CG0DV5KiFUJga629hp1AYyPg39wUgmYaHs
         FIb9Jvvnp0960p411UQ7Q2T3N1qws1g+eCCwm6unXyRsZuxU1A1FBlRnDWQfBa9i4yQF
         sJR42sVXZevrjpyuC0CyZc++c73K0S5aSxuDqjbH/E1hCbyjPrxZkeXF96IveoaCoOt8
         DZAj1RIMj4k/gDE+pY7Ot0H0XvVtPoojO8cE9yEPjpyNawFb4+s8AeP+s+bzWdS+r3uv
         bn3mSVJ29JAomPhW2B/WK06yNDjW/q+nNFOm0FXPWG+vzP5AgFQlbWHU5Lgk4wzaWGjT
         /rYQ==
X-Gm-Message-State: AOUpUlFarugfV99AKGXCaf8FWB2pg529I4MPMhyLVsSOPUyGeKTnuhe3
        gET1y2/d6LsNcGEqjctMhA==
X-Google-Smtp-Source: AA+uWPw//A+0cXMBX3mFYt29l2gN6FMLNAK39mBnWe31Vy0akM9w5bghR9YnLl3unDG6qlg8v0T8qQ==
X-Received: by 2002:a24:355:: with SMTP id e82-v6mr18126390ite.64.1534371719589;
        Wed, 15 Aug 2018 15:21:59 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u68-v6sm1461230ita.36.2018.08.15.15.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 15:21:59 -0700 (PDT)
Date:   Wed, 15 Aug 2018 16:21:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, amstan@chromium.org,
        groeck@google.com, kieran.bingham@ideasonboard.com,
        kernel@collabora.com, bleung@chromium.org, heiko@sntech.de,
        devicetree@vger.kernel.org, Frank Wang <frank.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: phy-rockchip-inno-usb2: add
 documentation for extcon and utmi-avalid properties.
Message-ID: <20180815222157.GA8193@rob-hp-laptop>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815095934.11205-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 11:59:32AM +0200, Enric Balletbo i Serra wrote:
> Commit 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for
> rk3399") introduces two new properties. The extcon property is used to
> detect the cable-state, and the rockchip,utmi-avalid is used to indicate
> which register should be used to detect the vbus state.
> 
> Document these properties in the documentation binding.
> 
> Fixes: 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for rk3399")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.txt         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> index 074a7b3b0425..2d4808d3920b 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> @@ -23,6 +23,7 @@ Optional properties:
>  		 register files". When set driver will request its
>  		 phandle as one companion-grf for some special SoCs
>  		 (e.g RV1108).
> + - extcon : phandle to the extcon device for the otg phy.

extcon is not a good binding. The usb connector binding should be used 
instead for new users.

Rob
