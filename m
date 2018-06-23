Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2B4C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B2B24A94
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B2B24A94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934481AbeFWBle (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:41:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34280 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933585AbeFWBld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:41:33 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4049D1213842C;
        Fri, 22 Jun 2018 18:41:30 -0700 (PDT)
Date:   Sat, 23 Jun 2018 10:41:28 +0900 (KST)
Message-Id: <20180623.104128.1481634742295696624.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     gregory.clement@bootlin.com, mw@semihalf.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com
Subject: Re: [PATCH net] net: mvneta: fix the Rx desc DMA address in the Rx
 path
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180622081539.16584-1-antoine.tenart@bootlin.com>
References: <20180622081539.16584-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Jun 2018 18:41:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri, 22 Jun 2018 10:15:39 +0200

> When using s/w buffer management, buffers are allocated and DMA mapped.
> When doing so on an arm64 platform, an offset correction is applied on
> the DMA address, before storing it in an Rx descriptor. The issue is
> this DMA address is then used later in the Rx path without removing the
> offset correction. Thus the DMA address is wrong, which can led to
> various issues.
> 
> This patch fixes this by removing the offset correction from the DMA
> address retrieved from the Rx descriptor before using it in the Rx path.
> 
> Fixes: 8d5047cf9ca2 ("net: mvneta: Convert to be 64 bits compatible")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied and queued up for -stable, thank you.
