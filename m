Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B7EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4878B21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4878B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbeKVBIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:08:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50879 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeKVBIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:08:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EAE88207AD; Wed, 21 Nov 2018 15:33:53 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id A8A2020701;
        Wed, 21 Nov 2018 15:33:43 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Tudor.Ambarus@microchip.com, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] mtd: spi-nor: fix selection of uniform erase type in flexible conf
Date:   Wed, 21 Nov 2018 15:33:43 +0100
Message-Id: <20181121143343.11330-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: e8828ec1c003727fc001eab06aa19bd2ca9b677e
In-Reply-To: <20181116174624.10817-1-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 17:46:37 UTC,  wrote:
> There are uniform, non-uniform and flexible erase flash configurations.
> 
> The non-uniform erase types, are the erase types that can _not_ erase
> the entire flash by their own.
> 
> As the code was, in case flashes had flexible erase capabilities
> (support both uniform and non-uniform erase types in the same flash
> configuration) and supported multiple uniform erase type sizes, the
> code did not sort the uniform erase types, and could select a wrong
> erase type size.
> 
> Sort the uniform erase mask in case of flexible erase flash
> configurations, in order to select the best uniform erase type size.
> 
> Uniform, non-uniform, and flexible configurations with just a valid
> uniform erase type, are not affected by this change.
> 
> Uniform erase tested on mx25l3273fm2i-08g and sst26vf064B-104i/sn.
> Non uniform erase tested on sst26vf064B-104i/sn.
> 
> Fixes: 5390a8df769e ("mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git master, thanks.

Boris
