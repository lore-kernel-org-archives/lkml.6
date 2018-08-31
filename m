Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D03BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4553820661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1xWAVT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4553820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeHaMCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:02:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45101 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHaMCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:02:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so10296356wrb.12;
        Fri, 31 Aug 2018 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K4UoER4+vuH5vZqujfkHhUVYLNaoQ9LcYgtXLqeQa44=;
        b=Z1xWAVT9zHPsWx3rI1WPmykHxYstpj5d2wxbedHeg7Nb+gfBGNCupkafKgEe7ypSoS
         UE6ge4f2xd6P3iLjH1HjDrI+5YgGCQI2eYjT4eX+x+8t7Jmzh5hXjIMIR+FmApdOLlG9
         f6ZG5aANWsegLlM8WZN3IIPTdgHR3TKR0x9M9HUvlPUDIIqR+oLHcO5vkGfg6ocgqpE0
         r7hAb5QHQsunNA7vJj5kgn80jjag+63JTy3SnryRAeM+YVurrEsUgzHi70RpBrG+CDOo
         kYV+RL48WptGSCI9a8F7Gxev2mj45NWpwwH5L4wvEho9bEiHcrhhTfmkYfWewBw7tXR2
         ZyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K4UoER4+vuH5vZqujfkHhUVYLNaoQ9LcYgtXLqeQa44=;
        b=t219oiROhWljiAk8T5tV5FjOOGZRCVUe7Gv6HP7+QHu9XcdUB3ldV0+hYxz7bumBFz
         88FvUr26ajTxZBHzHvO18Ald2CHPYV/kGCF+v8tLqj89xcArx4F8iHEthBFKrxVFpSn7
         eCwH0YgXGkyN6ntZoU55CrNvLoRXPJn0a1G06aFsLIu/4AjuB3aJpbByXPuKxkGMuNEd
         ZSo/wcMYgEUJ3DzF/ToD4YmVNWIoppJbUJ1OeuS4EigPP9XgxYXdTTjfBH7BGX0iGsM9
         28UJvsiKCdFBVL61wr0MD7DdmOqhqq35e2b6VyvdlRQEuCm25AoUDJsiBIEgzam+X/ZB
         9xkw==
X-Gm-Message-State: APzg51CKchIKAYUhHbeXBiKrdoOqlJvfgjO9hno9rhxZ4rDK33PDa7LC
        jalKhmqHMqWEy4/WTRgpT8UOoU91
X-Google-Smtp-Source: ANB0VdYL3y5DzCvSVVKJo+8gX4F6jEDZig6QFpCPIlyORknW04y1B2EWCJ8rvG+Dp6uIWNsvO6PScg==
X-Received: by 2002:adf:82b4:: with SMTP id 49-v6mr9399099wrc.252.1535702194280;
        Fri, 31 Aug 2018 00:56:34 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id h18-v6sm9593610wru.42.2018.08.31.00.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 00:56:33 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:56:31 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
Message-ID: <20180831075631.GB16301@Red>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com>
 <20180831073500.zubqpvar4yhjqrge@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831073500.zubqpvar4yhjqrge@flea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> > R40 have a sata controller which is the same as A20.
> > This patch adds a DT node for it.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > index 852c2ccc3268..d6b5820da850 100644
> > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > @@ -550,6 +550,29 @@
> >  			#size-cells = <0>;
> >  		};
> >  
> > +		ahci: sata@1c18000 {
> > +			compatible = "allwinner,sun8i-r40-ahci";
> > +			reg = <0x01c18000 0x1000>;
> > +			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > +			resets = <&ccu RST_BUS_SATA>;
> > +			resets-name = "ahci";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			status = "disabled";
> > +
> > +			sata_port: sata-port@0 {
> > +				reg = <0>;
> > +				phys = <&sata_phy>;
> > +			};
> > +		};
> > +
> > +		sata_phy: sata-phy@1c180c0  {
> > +			compatible = "allwinner,sun8i-r40-sata-phy";
> > +			reg = <0x1c180c0 0x200>;
> 
> Overlapping devices in the DTS is not ok.
> 

I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000 phy@e900a0)
But since it is not a good justification, it seems that regmap is my only solution ?

Regards
