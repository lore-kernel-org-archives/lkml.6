Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F795ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DF120833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1XBG6OHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DF120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbeGTPRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:17:50 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41320 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbeGTPRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kGGUoforAXaHWlhaoqpcVHyHp/jC9jjFBgSyOpwe4iQ=;
        b=1XBG6OHBJRKh6w4ZPYaeo27Ru0IS32w7U4VZOnc210A4LWMXiyAPyEs6oiojVT+Rz1b72WiyDaIOITNdy+Fftl+641fpW31VZ5ukOks+Pt62NkLuGEH5w7Ad9ISBvu6GCO//+V7OTqa08vg2Hb98iyg7wA1Sp3lFwQaOqOBY/as=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fgWOV-0000TM-1h; Fri, 20 Jul 2018 16:28:31 +0200
Date:   Fri, 20 Jul 2018 16:28:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 3/3] net: add MTD support to
 eth_platform_get_mac_address()
Message-ID: <20180720142831.GB1034@lunn.ch>
References: <20180719153243.20944-1-brgl@bgdev.pl>
 <20180719153243.20944-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719153243.20944-4-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 05:32:43PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> MTD doesn't support nvmem yet. Some platforms use MTD to read the MAC
> address from SPI flash. If we want this function to generalize reading
> the MAC address, we need to separately try to use MTD.

How many board files are doing this? It is only worth generlizing if
there are a number of board files, all just pulling 6 bytes out from
the beginning of an MTD partition.

It is also normal to actually add a user of a new feature at the same
time as the new feature. It can be messy when it is across subsystem
boundaries, but please at least try.

    Andrew
