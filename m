Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE134206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE134206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeIENhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:37:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39292 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbeIENhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:37:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4689520737; Wed,  5 Sep 2018 11:08:01 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 19B6A20618;
        Wed,  5 Sep 2018 11:07:51 +0200 (CEST)
Date:   Wed, 5 Sep 2018 11:07:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        David Miller <davem@davemloft.net>, andrew@lunn.ch,
        ralf@linux-mips.org, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 00/11] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180905090750.GM13888@piout.net>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
 <20180903133415.GF4445@lunn.ch>
 <20180903134522.GC13888@piout.net>
 <20180903.220910.899357653888940454.davem@davemloft.net>
 <20180904151653.GI13888@piout.net>
 <20180904161028.nh5ejrtj22r5az5e@pburton-laptop>
 <20180904180006.d5th3jrbhr4vtahi@qschulz>
 <20180904230351.vwlq2s7joulvqw2i@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904230351.vwlq2s7joulvqw2i@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 16:03:51-0700, Paul Burton wrote:
> Well, it sounded like David is OK with this all going through the MIPS
> tree, though we'd need an ack for the PHY parts.
> 
> Alternatively I'd be happy for the DT changes to go through the net-next
> tree, which may make more sense given that the .dts changes are pretty
> trivial in comparison with the driver changes. If David wants to do that
> then for patches 1 & 8:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>
> 
> Either way there may be conflicts for ocelot.dtsi when it comes to
> merging to master, but they should be simple to resolve. It seems
> Wolfram already took your DT changes for I2C so there's probably going
> to be multiple trees updating that file this cycle already anyway.
> 

Actually, I think Wolfram meant that he took the bindings so you can
take the DT patches for i2c.

> Ideally I'd say "don't break bisection" but that's sort of a separate
> issue here since even if you restructure your series to do that it would
> still need to go through one tree. For example you could adjust
> mscc_ocelot_probe() to handle either the reg property or the syscon,
> then adjust the DT to use the syscon, then remove the code dealing with
> the reg property, and I'd consider that a good idea anyway but it would
> still probably all need to go through one tree to make sure things get
> merged in the right order & avoid breaking bisection.
> 

I don't really think bisection is important at this stage but if you
don't want to break it, then I guess it makes more sense to have the
whole series through net.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
