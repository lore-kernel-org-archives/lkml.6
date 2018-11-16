Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2366AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE33F2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Oera7JTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE33F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbeKQKC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:02:56 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:38072 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbeKQKC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=cEreeUPEuYxn1XEpZwHXKnMAxZ1L7kB+1ohGGEkgvik=;
        b=Oera7JTmioE1/6X72R6PZzM+lDl20r9lbNcSLvNWo7s9/de2Wq9MNaS5zkXpPPkebE/fLzNK4Ebb/2Sqop9Ts0hpsrK/CqtlXJ9kN+PMoqZr3aInto+A/ZMT0rTwj01FZ6LTLDrEyZX0jH/BTvvVWQAH/CpY8jtoQ1FO9m13s8o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gNnqc-0000Oe-7N; Sat, 17 Nov 2018 00:48:26 +0100
Date:   Sat, 17 Nov 2018 00:48:26 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>
Subject: Re: [PATCH net-next 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Message-ID: <20181116234826.GB752@lunn.ch>
References: <1542298436-23422-1-git-send-email-claudiu.manoil@nxp.com>
 <1542298436-23422-2-git-send-email-claudiu.manoil@nxp.com>
 <20181115203544.GG32274@lunn.ch>
 <VI1PR04MB4880BE4EA7B7C0A1EEA0A0D196DD0@VI1PR04MB4880.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4880BE4EA7B7C0A1EEA0A0D196DD0@VI1PR04MB4880.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I know phylib has some limitations that are supposed to be addressed by phylink,
> but I didn't figure out yet how phylink does that or whether it works on our designs
> too.

Anything which phylib can do, phylink should also be able to do.

And phylink should make it easier to support SGMII. If you are using
the in-band signalling, you need to get that information out of the
MAC. And when you add support for 2.5G, you need to dynamically
reconfigure your SGMII link, depending on what speed the PHY decides
to do. phylink will help with that.

But you can start with phylib and convert later, if you want.

    Andrew
