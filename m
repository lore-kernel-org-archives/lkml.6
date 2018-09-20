Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F44ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB3A2150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB3A2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbeITKHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:07:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34450 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeITKHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:07:05 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 256A91090303A;
        Wed, 19 Sep 2018 21:25:42 -0700 (PDT)
Date:   Wed, 19 Sep 2018 21:25:41 -0700 (PDT)
Message-Id: <20180919.212541.1251609826389428684.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     yelena@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net] net: mvneta: fix the Rx desc buffer DMA unmapping
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180919132906.26868-1-antoine.tenart@bootlin.com>
References: <20180919132906.26868-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Sep 2018 21:25:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Wed, 19 Sep 2018 15:29:06 +0200

> With CONFIG_DMA_API_DEBUG enabled we now get a warning when using the
> mvneta driver:
> 
>   mvneta d0030000.ethernet: DMA-API: device driver frees DMA memory with
>   wrong function [device address=0x000000001165b000] [size=4096 bytes]
>   [mapped as page] [unmapped as single]
> 
> This is because when using the s/w buffer management, the Rx descriptor
> buffer is mapped with dma_map_page but unmapped with dma_unmap_single.
> This patch fixes this by using the right unmapping function.
> 
> Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied.
