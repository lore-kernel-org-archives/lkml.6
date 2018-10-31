Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4C4ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996AD2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1wUTmfLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996AD2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeKAAqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:46:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47341 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbeKAAqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=omwy5a1LZltxGtebfJmssk+pLBsWIEIpU+9wQT33fb8=;
        b=1wUTmfLdjxWEjvkWytY3rxyY5ahQ9NlpVzHOJGQ2CKNL/G6eqUe8c5CibsLqqsubB0v6jZJ6E0bB4TRCjWnBJDWKTxfEvX/YRlUUqZ/bZn6TsDqg3xaos3Y5asHlK90VwNU9Y50y+YcqmkC27goRlF7b+D9y5/DCkHx8/RnRHQ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gHsiT-0006ji-DR; Wed, 31 Oct 2018 16:47:33 +0100
Date:   Wed, 31 Oct 2018 16:47:33 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harinik@xilinx.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        David Miller <davem@davemloft.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH 3/4] net: macb: Add pm runtime support
Message-ID: <20181031154733.GC25521@lunn.ch>
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
 <1540957223-30984-4-git-send-email-harini.katakam@xilinx.com>
 <20181031145400.GH20889@lunn.ch>
 <CAFcVECKg4u5t9=TOJ1omVJ=8ves_yvzcDZZA_-bE4OAv96cymg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcVECKg4u5t9=TOJ1omVJ=8ves_yvzcDZZA_-bE4OAv96cymg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I understand. But I thought I'd handle it when we have a separate
> MDIO bus driver. As of now, with macb, I do not see a way, for ex.,
> for MAC1 to access MDIO0 when MAC0 is suspended.
> However, I will work a bit more on this solution.

You could look at the FEC driver. Its runtime suspend works well for
me, and i've some complex setups, with two FEC interfaces, PHY and
switches hanging off various MDIO busses etc.

	 Andrew
