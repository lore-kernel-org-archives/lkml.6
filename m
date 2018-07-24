Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A5120852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A5120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeGXOXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:23:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32948 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeGXOXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:23:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C684720756; Tue, 24 Jul 2018 15:17:04 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id F087F203D9;
        Tue, 24 Jul 2018 15:16:51 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Dmitri Epshtein <dima@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 0/8] A fix and a few improvements on mvneta
References: <20180718161057.28704-1-gregory.clement@bootlin.com>
Date:   Tue, 24 Jul 2018 15:16:52 +0200
In-Reply-To: <20180718161057.28704-1-gregory.clement@bootlin.com> (Gregory
        CLEMENT's message of "Wed, 18 Jul 2018 18:10:49 +0200")
Message-ID: <87h8ko7ozf.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
 
 On mer., juil. 18 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Hello,
>
> This series brings some improvements for the mvneta driver and also
> adds a fix.
>
> Compared to the v2, the main change is another patch fixing a bug
> in mtu_change.
>

I saw in patchwork, the status was "Accepted" (for example the 1st patch
[1]). However the series is not in your git branches and usually you
also answered to the series to inform that you have applied it. So I
would like to know what is the status of the series.

Thanks,

Gregory


[1]: https://patchwork.ozlabs.org/patch/945807/

> Gregory
>
> Changelog:
> v1 -> v2
>
>  - In patch 2, use EXPORT_SYMBOL_GPL for mvneta_bm_get and
>    mvneta_bm_put to be used in module, reported by kbuild test robot.
>
>  - In patch 4, add the counter to the driver's ethtool state,
>    suggested by David Miller.
>
>  - In patch 6, use a single if, suggested by Marcin Wojtas
>
> v2 -> v3
>
>  - Adding a patch fixing the mtu change issue
>
>  - Removing the inline keyword for mvneta_rx_refill() and let the
>    comiler decided, suggested by David Miller.
>
> Andrew Lunn (1):
>   net: ethernet: mvneta: Fix napi structure mixup on armada 3700
>
> Gregory CLEMENT (3):
>   net: mvneta: remove data pointer usage from device_node structure
>   net: mvneta: discriminate error cause for missed packet
>   net: mvneta: Allocate page for the descriptor
>
> Yelena Krivosheev (4):
>   net: mvneta: fix mtu change on port without link
>   net: mvneta: increase number of buffers in RX and TX queue
>   net: mvneta: Verify hardware checksum only when offload checksum
>     feature is set
>   net: mvneta: Improve the buffer allocation method for SWBM
>
>  drivers/net/ethernet/marvell/mvneta.c    | 409 ++++++++++++++---------
>  drivers/net/ethernet/marvell/mvneta_bm.c |  15 +
>  drivers/net/ethernet/marvell/mvneta_bm.h |   8 +-
>  3 files changed, 272 insertions(+), 160 deletions(-)
>
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
