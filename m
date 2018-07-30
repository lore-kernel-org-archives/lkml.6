Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDA2FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B95A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RB6Z8MTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B95A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbeG3PJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:09:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50400 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbeG3PJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=m/UngLPTmZIQ+RQ2vs0wOdHdGz9MGHtZfbBwdMsJfoU=;
        b=RB6Z8MTCYeHVUoWm3fJw/kXu+bhHQT3rCIAg90Kmj56JM36GO4/LiYlPp+iyB0/V4Wynpj4puuQE/ZFrjcxULd2012nAg6gBAXHQaLenovgjLRn5/rXxanZ6CLn6+VR4LPtXzMAYc/15LfJSL1mNcQVKtT03TetK6v0n0An02EA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk8K0-00085O-LS; Mon, 30 Jul 2018 15:34:48 +0200
Date:   Mon, 30 Jul 2018 15:34:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
Message-ID: <20180730133448.GD13198@lunn.ch>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +Required properties:
> +
> +- compatible: should be "mscc,vsc7514-serdes"
> +- #phy-cells : from the generic phy bindings, must be 3. The first number
> +               defines the kind of Serdes (1 for SERDES1G_X, 6 for
> +	       SERDES6G_X), the second defines the macros in the specified
> +	       kind of Serdes (X for SERDES1G_X or SERDES6G_X) and the
> +	       last one defines the input port to use for a given SerDes
> +	       macro,

It looks like there are some space vs tab issues here.

> +
> +Example:
> +
> +	serdes: serdes {

Maybe this should be serdes-mux? The SERDES itself should have some
registers somewhere. If you ever decide to make use of phylink,
e.g. to support SFP, you are going to need to know if the SERDES is
up. So you might need to add the actual SERDES device, in addition to
the mux for the SERDES.

> +		compatible = "mscc,vsc7514-serdes";
> +		#phy-cells = <3>;
> +	};
