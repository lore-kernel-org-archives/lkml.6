Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BCFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC74206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC74206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeLCOcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:32:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39911 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeLCOcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:32:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3171B2071D; Mon,  3 Dec 2018 15:30:47 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id B7DCF20618;
        Mon,  3 Dec 2018 15:30:46 +0100 (CET)
Date:   Mon, 3 Dec 2018 15:30:46 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-mtd@lists.infradead.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] SPI-NOR add NPCM FIU controller driver
Message-ID: <20181203153046.0554854f@bbrezillon>
In-Reply-To: <CAP6Zq1ib3p=UVC8ct_gvB801_XjTwknXMKPfFCq7=d1Jxv0Dfg@mail.gmail.com>
References: <20181203091456.454030-1-tmaimon77@gmail.com>
        <20181203102240.79a86a26@bbrezillon>
        <CAP6Zq1ib3p=UVC8ct_gvB801_XjTwknXMKPfFCq7=d1Jxv0Dfg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer;

On Mon, 3 Dec 2018 16:09:19 +0200
Tomer Maimon <tmaimon77@gmail.com> wrote:


> A few comments/input:
> 
> 
>    1. We have been working on this driver for quite a long time to port it
>    to the latest Linux conventions, polish the code, run tests and reach high
>    quality.
>    Our partners and customers are waiting to get this driver upstream so
>    they can freely use it.

Your patch prefix says "v1", so I'm assuming this is the first public
version. I'm sure you spent a lot of time developing this driver
internally, but no matter how long it took, it's a first version for
us, and since we are moving away from the spi_nor controller interface,
I'm not willing to accept new drivers using this interface.

If you want more background about the spi_nor controller interface
deprecation, you can read [1].

>    Since this driver is already in final stages and is in very good shape
>    we will appreciate if you can review this specific driver/interface and
>    help us to upstream it.

Actually, I'd like to do it the other way around: let you rework the
driver to implement the spi-mem interface and review this version.
Otherwise I'll be reviewing things I don't intend to merge anyway.

>    2.  As for the new interface, we are open for any discussion and for
>    porting the driver as required.
>    We are unsure what is this specific interface and weather it really fits
>    a driver for a Flash Interface Controller module (rather than a SPI flash
>    device).

Didn't go through the code in details, but at first glance, it looks
like it would fit pretty well.

>    Is it possible to get a sample driver from another Flash Interface
>    Controller module that was ported to this new interface ?

We recently converted the atmel QSPI driver [2].

Regards,

Boris

[1]https://bootlin.com/blog/spi-mem-bringing-some-consistency-to-the-spi-memory-ecosystem/
[2]https://patchwork.kernel.org/project/spi-devel-general/list/?series=38347&state=*
