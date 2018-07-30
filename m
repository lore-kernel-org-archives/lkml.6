Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB3CFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5702B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ghgo7/Ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5702B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeG3Pd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:33:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50449 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeG3Pd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=WO66kSbvOcn3PBk1aFheaTemX3FRoYo8IRJdfsuZV3o=;
        b=ghgo7/PhrNxUoVWLJahGUI+PKhamU7k5nS1YV23apmEjnmTsq6G5meQD9ftgYrTq3vH+N3DDggMTjFynk8WT1i9mtvmBGXoRn4IvEhbnZFRLvfaHCRA/I8SSXTrIpiEc24qntKhvCLfhMmNy29Ew2Llt8qV4pkd5Ya1vUvSf22g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk8gf-0008Ip-LZ; Mon, 30 Jul 2018 15:58:13 +0200
Date:   Mon, 30 Jul 2018 15:58:13 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     f.fainelli@gmail.com, davem@davemloft.net, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 3/4] dt-bindings: net: phy: mscc: vsc8531: fix missing
 "/bits/ 8" in example
Message-ID: <20180730135813.GH13198@lunn.ch>
References: <20180730130236.3837-1-quentin.schulz@bootlin.com>
 <20180730130236.3837-3-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730130236.3837-3-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 03:02:35PM +0200, Quentin Schulz wrote:
> The "vsc8531,led-N-mode" property is read as a u8 in the driver and
> there aren't a lot of modes anyway.
> 
> Without the "/bits/ 8" in front of the value of the property, the
> value is stored as an u32 resulting in of_read_property_u8 to always
> return 0.

Hi Quentin

on big endian systems. I'm expect this worked on little endian ARM. I
think the development work was done on a hacked RPi, if i remember
correctly.

> 
> Fix the example so that people using the property can actually use it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> index 664d9d0543fc..4c7d1d384df0 100644
> --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> @@ -63,6 +63,6 @@ Example:
>                  compatible = "ethernet-phy-id0007.0570";
>                  vsc8531,vddmac		= <3300>;
>                  vsc8531,edge-slowdown	= <7>;
> -                vsc8531,led-0-mode	= <LINK_1000_ACTIVITY>;
> -                vsc8531,led-1-mode	= <LINK_100_ACTIVITY>;
> +                vsc8531,led-0-mode	= /bits/ 8 <LINK_1000_ACTIVITY>;
> +                vsc8531,led-1-mode	= /bits/ 8 <LINK_100_ACTIVITY>;

I don't know the device tree language well enough...

Would this work?

vsc8531,led-1-mode	= < /bits/ 8  LINK_100_ACTIVITY>;

If so, you can make it part of the #define.

   Andrew
