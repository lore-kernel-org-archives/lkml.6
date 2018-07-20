Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41630ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E802E205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x1V8JQe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E802E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbeGTPEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:04:52 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41291 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbeGTPEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=eYdCJpNWxgu+UtNhpuwoVQYntBf8c7eFSJg+EM38H6w=;
        b=x1V8JQe6BZ3fMa543EahjY/YVhOCcVQYsvdEUaylXE4iP1pmqZGUcLb7BoMvJDp0U6qIt/WEI5IeO/3OyrDdgmX2CZ7ayiGaUFGgeATfRqd1HBnuliDGQw7f8g5F09ETjsBt+ZT8K6/gxs/2NTwf0huYYOyUN633ZPHcJCzkN6E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fgWBu-0000Ni-51; Fri, 20 Jul 2018 16:15:30 +0200
Date:   Fri, 20 Jul 2018 16:15:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
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
Message-ID: <20180720141530.GA1034@lunn.ch>
References: <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch>
 <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
 <20180718170352.GF12477@lunn.ch>
 <CAMRc=Md3oeEktzrA9UZyNPX6pB4bG+Gv0o6cjbs0UUKb3sYTsA@mail.gmail.com>
 <20180719150138.GC9119@lunn.ch>
 <CAMRc=MfKedvD2OXes02op2ErGR2HKkzJwjHtv5i4NkbJAVg3dw@mail.gmail.com>
 <20180719152712.GE9119@lunn.ch>
 <CAMRc=MeqnRXF_R1J5G8ySvCr8pZhZMHiV3WHNFun=d8GjiOT9A@mail.gmail.com>
 <0355bdd8-f544-c462-99e8-da94488067bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0355bdd8-f544-c462-99e8-da94488067bb@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:47:51AM +0530, Sekhar Nori wrote:
> On Thursday 19 July 2018 09:05 PM, Bartosz Golaszewski wrote:
> > 2018-07-19 17:27 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> >>> Unfortunately: this would effectively block me from improving the
> >>> support for older davinci boards.
> >>
> >> Is there something blocking you from converting the board to device
> >> tree? This is something i did with a lot of the Marvell boards a few
> >> years ago. For a while, we had both DT and board setup files. After a
> >> couple of cycles, we killed off the setup files.
> >>
> >>        Andrew
> > 
> > Actually some board are supported both in DT and board files
> > (da850-evm) right now, but Sekhar wants to keep the support via board
> > files in the kernel so that's a no go.
> 
> Its not that I want it that way, but we cannot get rid of board files
> till DT has equivalent support.
> 
> The bigger issue is not on DA850, but on the 5 older DaVinci SoCs which
> do not support device-tree based boot today.

The nice thing about board files is they keep any ugly code near to
where it is needed. The proposal here is to put some 'temporary' code
in the net core. And it is assumed at some point somebody will write
nvmem over MTD, which can be used to replace this temporary code, but
that in itself needs an ugly list of special cases when using board
files?

I would prefer somebody just did the work to convert these 5 boards to
DT, with a clean design of how nvmem over MTD would work. Having
converted a number of Marvell boards to DT, i have an idea of the
effort required. If most of the drivers already support DT, it can be
done quickly. So the big job here is probably nvmem over MTD.

     Andrew
