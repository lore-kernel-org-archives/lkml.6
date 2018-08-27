Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E485C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEC6208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mzLUwkWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEC6208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeH1AXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:23:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44428 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeH1AXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=lTG3DN1sP5zGVuTmPmzp3flK4bU7RGKxe4WwtbYWUQo=;
        b=mzLUwkWdBNYD8omrCV9LDmg9MDLNZ5dFopeJUyr7/+zsayP6KDqSEFKZD/2s+zgsNtjqqNF+ml1UBnvONH4z92nYS5Asic6fiumC790oXZ2WX/UxWvew3nATyit1jklzrpRPpNXAZ8EO6R4C5m7rlJipIpCYdmG6EJkxEWzrOok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fuOE0-0006aq-8g; Mon, 27 Aug 2018 22:35:00 +0200
Date:   Mon, 27 Aug 2018 22:35:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
Message-ID: <20180827203500.GN27483@lunn.ch>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
 <20180827200344.16158-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827200344.16158-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -210,6 +228,17 @@
>  			reg = <4>;
>  		};
>  
> +		port@5 {
> +			label = "sfp";
> +			phy-mode = "sgmii";
> +			reg = <5>;
> +			sfp = <&sfp>;
> +			fixed-link {
> +				speed = <1000>;
> +				full-duplex;
> +			};

Hi Florian

You might want to add a comment about why you are using fixed-link and
sgmii, which seems very odd. Is it even correct?

       Andrew
