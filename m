Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D29C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDBB20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yFyJ3xqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDBB20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeK3Dpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:45:42 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54623 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbeK3Dpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=pN8vz9NEBWTepb0s1vN1u+LUaOJEyOy8+uBDHRs3Lqs=;
        b=yFyJ3xqB3DD8Jwcq2ugjxQlzHV+Q9ktu65Ludf55ZTm4nmxDz+rNXwV0YMKN59I7LPm6WAL6PLrdFxf03XGV4Yr1cl04TgJ6yOqwtqRL8pSwQYCwI3IWAce+nPmrEPNvTZyzXkXmVBC8Xebs12tJnB2m2m7BKrajXdPLUOE9Ybo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gSPLk-0000sR-Nd; Thu, 29 Nov 2018 17:39:36 +0100
Date:   Thu, 29 Nov 2018 17:39:36 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     f.fainelli@gmail.com, davem@davemloft.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: Regression: v4.20-rc4: "SMSC LAN8710/LAN8720: Master/Slave
 resolution failed"
Message-ID: <20181129163936.GE1501@lunn.ch>
References: <20181129144206.GK9807@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129144206.GK9807@w540>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:42:06PM +0100, jacopo mondi wrote:
> Hello,
>    netdev people,
>    i.MX6 people,
> 
>    I'm running an i.MX6Q system, and since v4.20-rc1 the ethernet PHY
> fails to properly startup, preventing me from mounting my NFS rootfs
> (the interfaces gets configured after some minutes, but it's too late
> for NFS).
> 
> The complete boot log:
> 
> [    3.000186] SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)
> [    3.015616] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [    4.090582] SMSC LAN8710/LAN8720 2188000.ethernet-1:00: Master/Slave resolution failed, maybe conflicting manual settings?

Thanks for reporting this.

I made some changes in link mode handling. Let me check the code i modified.

  Andrew
