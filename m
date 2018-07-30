Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D5FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2677620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yvK8Q5rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2677620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeG3PAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:00:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50382 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeG3PAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=2/jopxJ0a3Xr5McvI9/4v/db/6AbFZh4lrTEwV7FVGg=;
        b=yvK8Q5rxVzowFxnL1dw2048nnDehg+3tD7VczRCuI59j27Tsu3BQIFQiFzAYyhCmBt/fetQupTzPsXZkMpxPAKjUolm+O3BML9JZA5BB35eMDd8uUHX9X9fFaDWvHwgPqe+R1U8LYPws7ABaMzvFV8p93787ZuaJojPQYW3tEeI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk8AD-000810-Uk; Mon, 30 Jul 2018 15:24:41 +0200
Date:   Mon, 30 Jul 2018 15:24:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 00/10] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180730132441.GC13198@lunn.ch>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The SerDes configuration is in the middle of an address space (HSIO) that
> is used to configure some parts in the MAC controller driver, that is why
> we need to use a syscon so that we can write to the same address space from
> different drivers safely using regmap.

Hi Quentin

I assume breaking backwards compatibility is not an issue here, since
there currently is only one board using the DT binding. But it would
be good to give a warning in the cover notes. git bisect will also
break for this one particular board. And since these changes are going
through different trees, it could be quite a big break.

	Andrew
