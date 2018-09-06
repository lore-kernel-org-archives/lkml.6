Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B12CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88432083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A3d1QY29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88432083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeIGAcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:32:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55001 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeIGAcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=bFIM6hbBC4r2ErYN41kGQqbAe4/zwhljfPAeEmXC6OQ=;
        b=A3d1QY297JKUV2DaQrTwYdcgCUzFvWhiJ+yA0X0pDbpUC93xibdMlnfod2t3kdZcxUnzTTz14B4kqtU7uB3iufxSOgE3LxpfJ8yDt73cIFtbDIuTgasvND4YJXhb1g5v1Nd+I0quuYkAN2ab0Mit+y/PBF2dMOiXdUqKE9ziD0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fy0NX-0008Nb-FD; Thu, 06 Sep 2018 21:55:47 +0200
Date:   Thu, 6 Sep 2018 21:55:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: b53: Fix build with B53_SRAB enabled
 and not B53_SERDES
Message-ID: <20180906195547.GC26997@lunn.ch>
References: <20180906184245.31442-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906184245.31442-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 11:42:45AM -0700, Florian Fainelli wrote:
> In case B53_SRAB is enabled, but not B53_SERDES, we can get the
> following linking error:
> 
> ERROR: "b53_serdes_init" [drivers/net/dsa/b53/b53_srab.ko] undefined!
> 
> We also need to ifdef the body of b53_srab_serdes_map_lane() since it
> would not be used when B53_SERDES is disabled and that would produce a
> warning.
> 
> Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
