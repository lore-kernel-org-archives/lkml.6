Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,GUARANTEED_100_PERCENT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C28C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4D5214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FyMxmwYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4D5214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeKVG4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:56:32 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:44655 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeKVG4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=NMi8JmbN2y/VCpdE/OVAx3JH65kMFkQHfJdtDh/coIc=;
        b=FyMxmwYhs6SKvvDEH0Wvc/208xbhihbP+uSVfNaMnLyEznPpPQZc266Ok/TBO8fsoo2UcJf1dB6Z5n9UQq8TC0viRLBYaPKJwt4Y1etEgg2cx+/LjWb2U/cJZCgD108PKaS9ojgoz2wgC47x1UvxGRJrA9hbmnaNOtFkHmqNbSA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gPYzC-0002oq-N2; Wed, 21 Nov 2018 21:20:34 +0100
Date:   Wed, 21 Nov 2018 21:20:34 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Norbert Jurkeit <norbert.jurkeit@web.de>, nic_swsd@realtek.com,
        Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.wiktowy@gmail.com, jcline@redhat.com,
        marc.c.dionne@gmail.com
Subject: Re: Issue with RTL8111 NIC after upgrade to kernel 4.19
Message-ID: <20181121202034.GA10697@lunn.ch>
References: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de>
 <38dad61b-bc7f-7038-6d1b-f5c4afe3841c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38dad61b-bc7f-7038-6d1b-f5c4afe3841c@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> request_module() is supposed to be synchronous, however after some
> reading this may not be 100% guaranteed. Maybe the module init
> function on some systems isn't finished yet when request_module()
> returns. As a result the genphy driver may be used instead of
> the PHY version-specific driver.

Hi Heiner

That would be true for all PHYs i think. We would of noticed this
problem with other systems using other PHY drivers.

	Andrew
