Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6166420863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kNng9sSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6166420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeK2JFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:05:20 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53345 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbeK2JFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=czRO0UEE3ESgbY/a14hqvC8rISDfqgDxILbyRE6HB5o=;
        b=kNng9sSmZuoTTSzZZhbweWrf2nGRoF+Sfs97GUbTHImQ9XcyVNyfun/ZZ42BgqWiIWwgUTeUOjx1IvhQWs1sRVdfra4amrRaxle9xgGkgGH44XEZi7ONnn6HoGqoPfWgAxU2X5j8gkE6tAirJoH5ze8E+HJrCy2TcJ1JuoNAHbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gS7uN-0001Ne-5p; Wed, 28 Nov 2018 23:02:11 +0100
Date:   Wed, 28 Nov 2018 23:02:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx
 packet size
Message-ID: <20181128220211.GA5037@lunn.ch>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
 <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com>
 <20181128044913.GB6730@lunn.ch>
 <6047b35d-d3c2-14f7-b42d-754b581a3c55@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6047b35d-d3c2-14f7-b42d-754b581a3c55@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is dynamic configuration related to ALE VLAN entries and
> I do not see the way to support its auto-detection with current driver,
> unfortunately.

I think you can subscribe to switchdev events which will tell you.

  Andrew
