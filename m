Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA99C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7099E20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7099E20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeKHWjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:39:20 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37138 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeKHWjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:39:20 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EE3D5224CD; Thu,  8 Nov 2018 14:03:54 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id A3271207B0;
        Thu,  8 Nov 2018 14:03:44 +0100 (CET)
Date:   Thu, 8 Nov 2018 14:03:44 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCH 6/7] mtd: spi-nor: ensure memory used for nor->read() is
 DMA safe
Message-ID: <20181108140344.77dcc0e8@bbrezillon>
In-Reply-To: <20181108110653.21063-7-tudor.ambarus@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
        <20181108110653.21063-7-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 11:07:18 +0000
<Tudor.Ambarus@microchip.com> wrote:

> Use GFP_DMA to ensure that the memory we allocate for transfers in
> nor->read() can be DMAed.

See my comment on patch 5.
