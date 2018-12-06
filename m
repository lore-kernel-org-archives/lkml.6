Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBCBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E05120672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E05120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbeLFOga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:36:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43326 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeLFOg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:36:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8D38620745; Thu,  6 Dec 2018 15:36:27 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 139DA20CC5;
        Thu,  6 Dec 2018 15:36:10 +0100 (CET)
Date:   Thu, 6 Dec 2018 15:36:10 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Guochun Mao <guochun.mao@mediatek.com>
Subject: Re: [RESEND PATCH 2/4] mtd: spi-nor: mtk-quadspi: use ofpart for
 parsing partitions
Message-ID: <20181206153610.26db522c@bbrezillon>
In-Reply-To: <6cca6844f426d4ad4e7c878420b363cfb34499aa.1543472168.git.ryder.lee@mediatek.com>
References: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
        <6cca6844f426d4ad4e7c878420b363cfb34499aa.1543472168.git.ryder.lee@mediatek.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 14:29:54 +0800
Ryder Lee <ryder.lee@mediatek.com> wrote:

> From: Guochun Mao <guochun.mao@mediatek.com>
> 
> Replace mtd_device_register with mtd_device_parse_register for
> parsing partitions and add ofpart support.

What's the problem with the default partition parser table [1]?

[1]https://elixir.bootlin.com/linux/latest/source/drivers/mtd/mtdpart.c#L793
