Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813C0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE8020644
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sa4eIja2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE8020644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeH3HoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:44:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47139 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbeH3HoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=UyCMPu52AJtRCcmNzJ8dtdSxM2VojpVtEgGXCwtAq3k=;
        b=sa4eIja2tCeuqswTu6yLp+oVND6+kvGnG3+LXthpXHIJGaf1VTqSJnV/oN/1CUnB0b6sITyTyE3qlZsQX9l65o4/ObiO5Xo4n/B0CEJHvRVoHAl9TLQCLRADRRpCRxwaymWiq2R6AmRJ/H3d+ZWbE3XqD4iixo9oOcWMJm5KLFM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fvDsI-00053J-9g; Thu, 30 Aug 2018 05:44:02 +0200
Date:   Thu, 30 Aug 2018 05:44:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     netdev@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] net: mvneta: enable NETIF_F_RXCSUM by default
Message-ID: <20180830034402.GE16896@lunn.ch>
References: <20180829162456.2bd69796@xhacker.debian>
 <20180829162932.6015e89d@xhacker.debian>
 <20180829130836.GD1955@lunn.ch>
 <20180830112745.61502abf@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830112745.61502abf@xhacker.debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've seen network interfaces get checksum'ing wrong when used with an
> > Ethernet switch with DSA. The extra header DSA uses means the hardware
> > cannot parse the packet correctly, and so cannot find these headers.
> 
> The network interface is mvneta?

I've not tested mvneta yet. It could be, since it was designed to be
used with Marvell switches in things like WiFi boxes, it knows how to
find the IP header when there is a DSA tag.

> Do you mean after this patch, we would see errors as the following?
> 
> "bad rx status 0xabcdefgh (crc error)"

I've not tried it yet. That is why i'm trying to understand what
NETIF_F_RXCSUM actually means.

       Andrew
