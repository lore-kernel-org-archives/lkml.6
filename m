Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BA5C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D7925CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FjiPWMOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D7925CB0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeFYP2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:28:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41539 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbeFYP2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=RjrxPZoN+a5sgG0T0rFiwyXH6e73B0mLu4DSwtCwAFc=;
        b=FjiPWMOlavTA5xZwTdtdr+YQCfWhogxilNS+SdHWlefA7qx6kKFcUELyt9VDC1IBuFpien5ber+Etgx00qHMvwyptvOU19IzJZt+AGLlA8hfZTUPd2yFP5bHtu0p/BXa8U86wL8sxsQ0tjli4eCSGK+LKpIUllr0Kn3+OZNs8F4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fXTPS-0003IV-G4; Mon, 25 Jun 2018 17:28:06 +0200
Date:   Mon, 25 Jun 2018 17:28:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dean_Jenkins@mentor.com" <Dean_Jenkins@mentor.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] net: usb: asix: allow optionally getting mac address
 from device tree
Message-ID: <20180625152806.GA11603@lunn.ch>
References: <20180625080108.32441-1-marcel@ziswiler.com>
 <1529926008.12558.14.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529926008.12558.14.camel@toradex.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Now that you mentioned eth_platform_get_mac_address() on my igb attempt I am
> wondering whether that would not also be the better approach for ASIX USB net
> use. Looks like at least lan78xx already does it that way as well.
> 
> What do you think?

Hi Marcel

eth_platform_get_mac_address() is preferred, since it will try DT,
ACPI, and anything else the platform supports.

      Andrew
