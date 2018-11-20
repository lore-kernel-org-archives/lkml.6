Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A80C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A9206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ALZTnMuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7A9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeKUBPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:15:39 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41963 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbeKUBPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=9lR4cogK+Ei+KDeMH+b3zV9BFPcOlBnKY8bBJ7VLpDE=;
        b=ALZTnMuOl1tTtX1/SIbjeBVe/GWgijNs2aq23KMUauEquCe8KkXbsZaPyYJqSCmbLAR1JP2S3IxIvahAnRdoojspigLXh32dRASARgVJpTcoIIsR3gQeDn3WnbquH9ga2iMbnIOONcBds1aEZTDB6eAsBY/qXILSVtVsYAqDox0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gP7Ho-00070y-BN; Tue, 20 Nov 2018 15:45:56 +0100
Date:   Tue, 20 Nov 2018 15:45:56 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Realtek NIC uses over 1 Watt with no traffic
Message-ID: <20181120144556.GC18335@lunn.ch>
References: <081beaeb-be22-55b3-2927-fec04e9f714a@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <081beaeb-be22-55b3-2927-fec04e9f714a@molgen.mpg.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 09:40:25AM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Using Ubuntu 18.10, Linux 4.18.0-11-generic, PowerTOP 2.9 shows, the NIC
> uses 1.77 Watts. A network cable is plugged in, but there is no real traffic
> according to `iftop`. Only an email program is running.
> 
>     $ lspci -nn -s 3:00.1
>     03:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev
> 12)
> 
> Is that a measurement error, or does the NIC really need that much power?

Hi Paul

This sounds like Energy Efficient Ethernet, EEE, is not enabled.

What does ethtool --show-eee ethX say?

     Andrew
