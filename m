Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5yQ3B850GVudBQAAmS7hNA
	; Thu, 07 Jun 2018 18:12:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F2C88608B8; Thu,  7 Jun 2018 18:12:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZG41DjN3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 685636089E;
	Thu,  7 Jun 2018 18:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 685636089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934314AbeFGSMi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:12:38 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57024 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932568AbeFGSMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=DFqSliE1d59VkcGQ8/8d5sPpBghaT17vmzsZsNh5boo=;
        b=ZG41DjN3ZTGgJ5u0BxsnpjXR5WqndtAbYnXMebGtYgJyvJquYDIWR7aAvceMo9BQmhBcEyKwuzhk1Q5M4xkw7TBTsUq/dmeCrMCLFaz0S0y6p/FNNpw07tByMor/ddXUFJv+ZW9ThHed9y5gKR2AClp0uqI7jEhvQWoEvf+QCkc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fQzOg-0001xr-18; Thu, 07 Jun 2018 20:12:30 +0200
Date: Thu, 7 Jun 2018 20:12:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Brandon Maier <brandon.maier@rockwellcollins.com>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com,
        Clayton Shotwell <clayton.shotwell@rockwellcollins.com>,
        Kristopher Cory <kristopher.cory@rockwellcollins.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: phy: Check phy_driver ready before accessing
Message-ID: <20180607181230.GF25513@lunn.ch>
References: <20180607155348.149665-1-brandon.maier@rockwellcollins.com>
 <20180607165227.GD25513@lunn.ch>
 <CA+fik51YC14k8yMLRkybMXQNn6uWB0u6aQUd1GMZrQtOF=cd3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fik51YC14k8yMLRkybMXQNn6uWB0u6aQUd1GMZrQtOF=cd3A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed. Another thing that looks suspicious to me is the driver
> overrides the private data of the device it's attaching too, in the
> `priv->phy_dev->priv = priv` bit. Seems like that could cause all
> sorts of driver corruption problems.

Ah, yes. That is very broken. Many PHYs will just explode sometime
later, since they use phdev->priv.

> But fixing that is going to require more drastic changes to how this
> driver works. So it'd be worth applying this patch in the mean time.

Patches welcome.

	Andrew
