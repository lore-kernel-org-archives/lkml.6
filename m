Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA45C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E952152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E952152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbeITRDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:03:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51626 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbeITRDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:03:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 90B0020711; Thu, 20 Sep 2018 13:20:10 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id 30A72204AE;
        Thu, 20 Sep 2018 13:20:10 +0200 (CEST)
Date:   Thu, 20 Sep 2018 13:20:10 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Yelena Krivosheev <yelena@marvell.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: Re: [EXT] [PATCH net] net: mvneta: fix the Rx desc buffer DMA
 unmapping
Message-ID: <20180920112010.GB1158@kwain>
References: <20180919132906.26868-1-antoine.tenart@bootlin.com>
 <5ab58500e78549618b597fdc2e54356a@IL-EXCH01.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ab58500e78549618b597fdc2e54356a@IL-EXCH01.marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yelena,

On Thu, Sep 20, 2018 at 10:14:56AM +0000, Yelena Krivosheev wrote:
> 
> Please, check and fix all cases of dma_unmap_single() usage.
> See mvneta_rxq_drop_pkts()
> ...
> 		if (!data || !(rx_desc->buf_phys_addr))
> 			continue;
> 		dma_unmap_single(pp->dev->dev.parent, rx_desc->buf_phys_addr,
> 				 MVNETA_RX_BUF_SIZE(pp->pkt_size), DMA_FROM_DEVICE);
> 		__free_page(data);
> ...

I had a look at the one reported by CONFIG_DMA_API_DEBUG, and at DMA
unmapping calls using PAGE_SIZE. As you pointed out there might be
others parts, thanks!

Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
