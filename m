Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E72C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ACC2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4iDD1ZOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfBUN0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:26:02 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:33045 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBUN0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BFLs3ECdBd7OUEOL+jbLAelIbJgRI2yEE0FpFhcbazc=; b=4iDD1ZOBjqTPCQj5NooPXDXoH3
        Jf55W0AvB3ShZjYnQVTigYFdSjvfEWouNT/SEZYlzkK9CRnroNlHr5KnPKiUh97JjGGd6odWPn6nQ
        qOWZgtEnk9eOh92BBYxXH7XXySzVClYKlYGv/h8p3WkbJ7rXg62xhV7LtM5jhwGjhjhE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gwoMQ-0001ub-3O; Thu, 21 Feb 2019 14:25:58 +0100
Date:   Thu, 21 Feb 2019 14:25:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rundong Ge <rdong.ge@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, hkallweit1@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: m88e6390_config_aneg will always reset the phy
Message-ID: <20190221132558.GB5653@lunn.ch>
References: <CAN1LvyqjHCCNxz30a-SMO3uSBw2WD-Mvn4sR==9SUcJKdqo9vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN1LvyqjHCCNxz30a-SMO3uSBw2WD-Mvn4sR==9SUcJKdqo9vA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 06:55:54PM +0800, Rundong Ge wrote:
> Hi Andrew
> 
> Before the "net: phy: marvell: Errata for mv88e6390 internal PHYs",
> phydev will only be soft reset when register value was changed.
> But after this patch, the phydev will always be reset when entering
> the "m88e6390_config_aneg".
> So is there any side effect of this change?

Hi Rundong

I tried to avoid the reset, but it does not appear you can read back
the magic values which got poked into the magic registers. So there is
no way to tell if the Errata has already been applied, e.g. by the
boot loader.

Side effects?

The PHY might work :-)

It might take a little bit longer to report link up, since there is an
additional soft reset.

	   Andrew
