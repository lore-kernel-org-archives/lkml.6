Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B399C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6444520657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OxX0kYs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404700AbfAPOse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:48:34 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45289 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733224AbfAPOsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=WwOlmpwAMZI6HE4VnDBXxaMouoJua1d8jL03E3u8LVo=;
        b=OxX0kYs5vxyW5am2gFdduVK+QNVm8/cBi776DWy6e6mRCufu0NfLsFxNJDH6wtIOViLYaVDiiKgr4Eq52Khck3JsVyG5GZc/a2fZ+C807BNHG18PqZEX248nt2U/pN/7W7sVkxzew/ZY86dxkxTlGfKKYNcBTkB0GasiEZuLpIU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjmUX-0007Ib-QM; Wed, 16 Jan 2019 15:48:29 +0100
Date:   Wed, 16 Jan 2019 15:48:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] net: phy: mdio_bus: add missing device_del() in
 mdiobus_register() error handling
Message-ID: <20190116144829.GC25731@lunn.ch>
References: <20190116095358.28354-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116095358.28354-1-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The actual error that we had from devm_gpiod_get_optional() was
> -EPROBE_DEFER, due to the GPIO being provided by a driver that is
> probed later than the Ethernet controller driver.
> 
> To fix this, we simply add the missing device_del() invocation in the
> error path.

Hi Thomas

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

However, i wounder if it makes sense to add a label before the
existing device_del() at the end of the function, and convert this,
and the case above into a goto? That might scale better, avoiding the
same issue in the future?

Thanks

    Andrew
