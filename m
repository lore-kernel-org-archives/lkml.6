Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52961C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABAA20882
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wnShD7KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABAA20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934923AbeFYSDg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:03:36 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41984 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933976AbeFYSDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Y2azTQrgxcP8ARvVfAQC7v1vEgJFC4PyvpKfiDQDNSk=;
        b=wnShD7KXfnpfqYNFSO2wEl2MSmA9QSc9Jb09RMhc25TbR11K5UO9k8L3Z35dw3+CHfwPNP6QgXe+WsloepK6BoPcXsa44DaD7Tu1vKvhbjs2ZS+wk8oaOwgBOhc9bcbPFr84MnveKTqb3tu2M+57sP1lS50AvhZRGTlRNQrOVy0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fXVoz-0004vw-0J; Mon, 25 Jun 2018 20:02:37 +0200
Date:   Mon, 25 Jun 2018 20:02:37 +0200
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
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing
 at24_platform_data
Message-ID: <20180625180237.GC17417@lunn.ch>
References: <20180625155025.12567-1-brgl@bgdev.pl>
 <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> With my patch 1/14 you'll get -EPROBE_DEFER from nvmem_cell_get() if
> the nvmem provider is not yet registered. Will that help in your case?

I don't think so. My driver instantiates the AT24 device. So if i get
-EPROBE_DEFER, i need to cleanup the probe, and return -EPROBDE_DEFER
to the code. Which means i need to remove the AT24 device...

       Andrew
