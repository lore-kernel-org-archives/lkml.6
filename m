Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2641BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55D62084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l0tmekKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55D62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbeGSQLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:11:15 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40235 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730521AbeGSQLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=SyeA5Sjmo4XwQwHij2eLSErrdgUdQmtibPwzDS8jzrM=;
        b=l0tmekKzxzzaprekNZzarndQrhm212GPKBKDeJh1K5BPMoTZEbyl3Yh/aIf2glko4SrJi+X052cLtumwzJLgcTB5OrtCtQ+mteQpIigw2ZTHRkBGZDoPsJB4FJHa6YHT+EQXp0qWcDtVkk2HWSBieDjG3DdKENTEhhF2JiToklg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fgApk-0002rk-11; Thu, 19 Jul 2018 17:27:12 +0200
Date:   Thu, 19 Jul 2018 17:27:12 +0200
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 5/5] net: add MTD support to
 eth_platform_get_mac_address()
Message-ID: <20180719152712.GE9119@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch>
 <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
 <20180718170352.GF12477@lunn.ch>
 <CAMRc=Md3oeEktzrA9UZyNPX6pB4bG+Gv0o6cjbs0UUKb3sYTsA@mail.gmail.com>
 <20180719150138.GC9119@lunn.ch>
 <CAMRc=MfKedvD2OXes02op2ErGR2HKkzJwjHtv5i4NkbJAVg3dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfKedvD2OXes02op2ErGR2HKkzJwjHtv5i4NkbJAVg3dw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately: this would effectively block me from improving the
> support for older davinci boards.

Is there something blocking you from converting the board to device
tree? This is something i did with a lot of the Marvell boards a few
years ago. For a while, we had both DT and board setup files. After a
couple of cycles, we killed off the setup files.

       Andrew
