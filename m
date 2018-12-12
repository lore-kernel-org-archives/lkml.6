Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E509C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7A121104
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7A121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeLLJcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:32:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55205 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbeLLJcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:32:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0960120763; Wed, 12 Dec 2018 10:32:23 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id D2A3D206DC;
        Wed, 12 Dec 2018 10:32:12 +0100 (CET)
Date:   Wed, 12 Dec 2018 10:32:13 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Stefan Chulski <stefanc@marvell.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH net] net: mvpp2: 10G modes aren't supported on all ports
Message-ID: <20181212093213.GB3219@kwain>
References: <20181211163228.26130-1-antoine.tenart@bootlin.com>
 <20181211163635.GG30658@n2100.armlinux.org.uk>
 <7b61c1fbf51a409684568216e799ebe3@IL-EXCH01.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b61c1fbf51a409684568216e799ebe3@IL-EXCH01.marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Tue, Dec 11, 2018 at 09:11:31PM +0000, Stefan Chulski wrote:
> 
> > 
> > Are these modes supported on anything except port 0?  If not, you should be
> > rejecting these, rather than just treating them as RGMII.
> 
> In CP115(which has PPv2) PHY_INTERFACE_MODE_10GKR supported on ports 0 and 1
> PHY_INTERFACE_MODE_XAUI/PHY_INTERFACE_MODE_RXAUI supported only on port 0.

That's right. But I think we need to first fix this, and then when
adding support for the cp115 we'll rework this. We will need a way to
differentiate the CP110 PPv2 from the CP115 PPv2.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
