Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC57C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04518208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r6Q3mBgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfAAXgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 18:36:16 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60106 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfAAXgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 18:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=atoclGKcrH6AXasTfTfMuz/PAZpWUf69NSW7RXvqJY8=;
        b=r6Q3mBgQbrHuRFvF6Nm/43tLwwllM3yhQFrvLvx4bN244YKMTI1y681LDf2d95I62ktRPhm9zo7hWwGEGSBN83WgEl07v7OBJE2JkZETCb9Shhb5AF9GVLWO9aHh35ennH9d526fq4ZR19cQAd6ZWNmzFY/cNdY0bv1Pu42Rt0A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1geTZw-000687-Dc; Wed, 02 Jan 2019 00:36:08 +0100
Date:   Wed, 2 Jan 2019 00:36:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Murali Krishna Policharla <murali.policharla@broadcom.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "amritha.nambiar@intel.com" <amritha.nambiar@intel.com>,
        "ecree@solarflare.com" <ecree@solarflare.com>,
        "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: core: Fix to store new mtu setting in netdevice.
Message-ID: <20190101233608.GC22737@lunn.ch>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
 <b2127534-4e9c-1fef-27f1-72329595c3a3@virtuozzo.com>
 <bef4af12-f5ce-35ec-8d04-395a281e4322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef4af12-f5ce-35ec-8d04-395a281e4322@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there a .ndo_change_mtu callback, which does not assign a new mtu itself?
> > 
> So far all drivers have to do it themselves. But IMO this is more a workaround
> for the core not doing it. It's something the core should do.
> Now we can remove this from drivers.

Hi Heiner

I think somebody first needs to review all the ndo_change_mtu
implementations and check that none do something funny like round to
multiple of 2 or 4 to satisfy DMA restrictions, etc. If there is such
a thing, we cannot easily move this into the core.

    Andrew
