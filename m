Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3E4C46466
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E276D20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kfLGjgQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E276D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeKUHJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:09:11 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43097 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeKUHJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=1yMb0kLFq013sj/FBYZwkQT7FJGzUGOAGj8E/ndFEw8=;
        b=kfLGjgQp8tBE+dmrLhjgXoiMCv4HrSf4JCf7YH+UgOhbORGixiStZFlRI/hSdnn1zxlzVvo7jpVuK3N2F8PnOdPxdRLit/VAagDfp1FMpa+95C03dKpZHSyjb4q8MTNT0VcQII4IgCI3/7+oc7KfaV7fvbYC15VSgFdSIMXyNRI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gPCmU-0002ft-Vg; Tue, 20 Nov 2018 21:37:58 +0100
Date:   Tue, 20 Nov 2018 21:37:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Realtek NIC uses over 1 Watt with no traffic
Message-ID: <20181120203758.GF2649@lunn.ch>
References: <081beaeb-be22-55b3-2927-fec04e9f714a@molgen.mpg.de>
 <20181120144556.GC18335@lunn.ch>
 <7714a7b7-ca22-19ea-499a-e2d60f3c9fb5@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7714a7b7-ca22-19ea-499a-e2d60f3c9fb5@molgen.mpg.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >This sounds like Energy Efficient Ethernet, EEE, is not enabled.
> 
> No, idea if the router from my provider supports that.

It is pretty standard these days. But it requires both local and
remove MAC and PHY support it.

> >What does ethtool --show-eee ethX say?
> 
>     $ sudo ethtool --show-eee enp3s0f1
>     Cannot get EEE settings: Operation not supported

It would be nice to support this. Maybe Heiner can put it onto his
TODO list.

     Andrew
