Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C337C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA83A20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="huJeNWkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA83A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeJBT0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:26:38 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51943 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbeJBT0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=bg093OXkl/A3vthzxJ5HB8KTvJPGsHvxtRPFvseM4B4=;
        b=huJeNWkpwnBLhOlaEXUUAMbjmxCLa5/YFCS/4gJefPkR1ghskmkJM5K7/5giAfyPfvbQgONDzTe5DA+dZIZTIvItXSeMSVm5ylEeJFCZqjB0jakIcszPH14oBYVbeURzgQOUKVUI2vgOrDGhutTD7BwQXkVn/u2Vj8Y3GnVdSUc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g7K1L-00034L-FX; Tue, 02 Oct 2018 14:43:23 +0200
Date:   Tue, 2 Oct 2018 14:43:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next] net: mscc: allow extracting the FCS into the skb
Message-ID: <20181002124323.GC9155@lunn.ch>
References: <20181001095714.26024-1-antoine.tenart@bootlin.com>
 <25a88126-2397-a1fb-0c0d-06504bb348ca@gmail.com>
 <20181002065937.GB3368@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002065937.GB3368@kwain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The question could be "do we need len += ETH_FCS_LEN" to account for the
> FCS when NETIF_F_RXFCS is used", but I looked at other drivers and it
> seemed to me the FCS is not accounted in the stats. Should it be?

Hi Antoine

There does not appear to be a good answer to that. I submitted a patch
to a driver i'm using to not count it, so that the stats counters we
consistent with another driver. The patch was rejected.

I think the best you can do is flip a coin, and then document it using
a comment about if it is/is not included.

  Andrew
