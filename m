Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673B8ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6A3208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6A3208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeIYBc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:32:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeIYBcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:32:53 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 05DA013CB21B2;
        Mon, 24 Sep 2018 12:29:10 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:29:10 -0700 (PDT)
Message-Id: <20180924.122910.450816619429773171.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     yelena@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net] net: mvneta: fix the remaining Rx descriptor
 unmapping issues
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180924145613.27307-1-antoine.tenart@bootlin.com>
References: <20180924145613.27307-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Sep 2018 12:29:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Mon, 24 Sep 2018 16:56:13 +0200

> With CONFIG_DMA_API_DEBUG enabled we get DMA unmapping warning in
> various places of the mvneta driver, for example when putting down an
> interface while traffic is passing through.
> 
> The issue is when using s/w buffer management, the Rx buffers are mapped
> using dma_map_page but unmapped with dma_unmap_single. This patch fixes
> this by using the right unmapping function.
> 
> Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied.
