Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D4ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B841214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B841214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeIRUPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:15:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45069 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeIRUPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:15:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B6C8E208C7; Tue, 18 Sep 2018 16:42:04 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6E8F6206FF;
        Tue, 18 Sep 2018 16:41:54 +0200 (CEST)
Date:   Tue, 18 Sep 2018 16:41:54 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        prabhakar.kushwaha@nxp.com, linux-mtd@lists.infradead.org,
        han.xu@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        festevam@gmail.com
Subject: Re: [PATCH] mtd: spi-nor: Support controllers with limited TX FIFO
 size
Message-ID: <20180918164154.28d7a31c@bbrezillon>
In-Reply-To: <81e0653f-1e07-6ec9-f12a-d448e269c87a@exceet.de>
References: <1528870092-14526-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180709233427.1a714de7@bbrezillon>
        <81e0653f-1e07-6ec9-f12a-d448e269c87a@exceet.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 12:51:51 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> I want to revive the discussion about this patch. Meanwhile we have 
> received confirmation from NXP, that the hardware can't handle writing 
> data chunks bigger than the TX buffer size, even when we use DMA to 
> refill the buffer [1].
> 
> This means, that this patch is required to get the FSL QSPI driver 
> working with the SPI mem framework.
> 
> Could you please reconsider this patch?

I'm all for taking this patch, just waiting for a green light from
Marek.
