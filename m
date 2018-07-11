Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2128AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C833420883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E6Fqaaaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C833420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbeGKPCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:02:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59029 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732901AbeGKPCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8s2O71cJqk8x43nCFRwLqWUz3++uuDVo7SZufAuLVnQ=;
        b=E6FqaaafXRibe7Rd2OaCFgc7xaWRrckUwwPPf0KjfY5GZNKV+j+0KOQZrLFljet0eVYgquZLmwK5YaoyCZY2nM021Fs48EdtbBi3A3NJguXd1+oIFpXdPc6FoGICBwGcDOCueiJQ852p76oirwRv4MY/OdjwlVvw6fWI5zGM3EM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fdGYL-0003nZ-SD; Wed, 11 Jul 2018 16:57:13 +0200
Date:   Wed, 11 Jul 2018 16:57:13 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx: Add ZII SCU3 ESB
Message-ID: <20180711145713.GB14155@lunn.ch>
References: <20180711050704.11492-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711050704.11492-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:07:04PM -0700, Andrey Smirnov wrote:
> +		switch@0 {
> +			compatible = "marvell,mv88e6085";
> +			reg = <0>;
> +			dsa,member = <0 0>;
> +			eeprom-length = <512>;
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;

Hi Andrey

I don't see a pinmux for this GPIO. Is one needed?

    Andrew
