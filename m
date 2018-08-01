Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC2E20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BMCXAo9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC2E20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390022AbeHARLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:11:47 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52915 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389476AbeHARLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=hSEz3UK9wRNGq2Pw0daFIwzzh3aClMFwZA3qwg3cRko=;
        b=BMCXAo9NPYZuOcPl7m2yqK6BihzgINBx0XQSMHV1gItPeZ0/Gj7TmnZuL9Z5XWdN6tKmG7UJa/ht0S2yqhml+jFY3Ofp4c90C7m9Ga3yHvdpyc7utPmJz/0FxQYS3Tyzsh10HgvcE/SgkS9fKa9nGQBLEV0RupMunrOfPnUO7vc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fkt0D-0004xG-TM; Wed, 01 Aug 2018 17:25:29 +0200
Date:   Wed, 1 Aug 2018 17:25:29 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: Do not suspend/resume closed slave_dev
Message-ID: <20180801152529.GF32125@lunn.ch>
References: <20180801001253.16312-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801001253.16312-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 05:12:52PM -0700, Florian Fainelli wrote:
> If a DSA slave network device was previously disabled, there is no need
> to suspend or resume it.
> 
> Fixes: 2446254915a7 ("net: dsa: allow switch drivers to implement suspend/resume hooks")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
