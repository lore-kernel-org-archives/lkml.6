Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EF4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF3F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kSCcKchy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF3F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeGRPRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:17:39 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38445 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730429AbeGRPRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=b749QrOAleM5Vkjd816br6AQuxxqXff/A8+zlR3tUxk=;
        b=kSCcKchyretG1PAcl/7N30I+uaQg7IjQBj44s41YT4/wQlESXEMQ9155FRT/bTeH28g8E4F9+Lg60ODEAM0XugBCq+ulHdAcYViFjS3rWxLwemCFkJBpbE9piR04HnIUgulJUq/xAl9KgQX8uAqEQzVVosjN5DQa2GKQBbtFqwc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ffnbr-0002zJ-PM; Wed, 18 Jul 2018 16:39:19 +0200
Date:   Wed, 18 Jul 2018 16:39:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Camelia Groza <camelia.groza@nxp.com>
Cc:     f.fainelli@gmail.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: use generic clause 45 autonegotiation done
Message-ID: <20180718143919.GA10856@lunn.ch>
References: <1531919535-20269-1-git-send-email-camelia.groza@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531919535-20269-1-git-send-email-camelia.groza@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:12:15PM +0300, Camelia Groza wrote:
> Only Clause 22 PHYs can use genphy_aneg_done(). Use
> genphy_c45_aneg_done() for PHYs that implement Clause 45 without
> the Clause 22 register set.
> 
> This change follows the model of phy_restart_aneg() which
> differentiates between the two implementations in a similar way.

Hi Camelia

What about phy_config_aneg()? I would assume any sort of auto-neg
action needs to check for c45 without c22, before calling a genphy_
function. Do you think it is possible to write a
genphy_c45_config_aneg()? If not, we might want to return -EOPNOTSUPP.

	  Andrew
