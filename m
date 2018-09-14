Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6860ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEDB20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a+NAGSvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEDB20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeINWN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:13:56 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34964 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbeINWN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kh3xwiQBkd2YTo4ffKfr5Uu3uDvoHo2587jG00G0wGY=;
        b=a+NAGSvR89xUCNYv5UNGvdcjvm1rLo3n7hNDs9VxGgWaHMXSqU0FZHrsvMcsKW+i4lqkkrayfrVyAy3eOSAxIdAvK+SVxaGNlWIzogUsBotmFQ/ZjqqKo7gXG70MSwABQWmcC61p8TURy5CBnSJ3deMcN8NmcpTZPTwrN5IqTWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0rQG-0005za-DC; Fri, 14 Sep 2018 18:58:24 +0200
Date:   Fri, 14 Sep 2018 18:58:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 2/7] net: phy: mscc: add support for VSC8584 PHY
Message-ID: <20180914165824.GA3811@lunn.ch>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914131846.GG14865@lunn.ch>
 <20180914132930.fphdm3dm2incetbq@qschulz>
 <20180914162828.5e75ffh5sig4om3d@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914162828.5e75ffh5sig4om3d@qschulz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Confirmed by HW engineers, it only impacts PHYs in the same package.

Hi Quentin

Thanks for checking. As you said, it would be counter intuitive,
meaning a lot of confusion if it actually did happen.

Maybe you can add "in package" before broadcast in the commit message
and the code comments.

       Andrew

