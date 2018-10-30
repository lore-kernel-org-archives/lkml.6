Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E455C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E578C2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E578C2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeJaDex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:34:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58410 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeJaDex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:34:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2B515140AA220;
        Tue, 30 Oct 2018 11:40:15 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:40:14 -0700 (PDT)
Message-Id: <20181030.114014.1116832622602679074.davem@davemloft.net>
To:     marc.zyngier@arm.com
Cc:     antoine.tenart@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        gregory.clement@bootlin.com, nadavh@marvell.com,
        stefanc@marvell.com, ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH] net: mvpp2: Fix affinity hint allocation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181030154100.78512-1-marc.zyngier@arm.com>
References: <20181030154100.78512-1-marc.zyngier@arm.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Oct 2018 11:40:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>
Date: Tue, 30 Oct 2018 15:41:00 +0000

> The mvpp2 driver has the curious behaviour of passing a stack variable
> to irq_set_affinity_hint(), which results in the kernel exploding
> the first time anyone accesses this information. News flash: userspace
> does, and irqbalance will happily take the machine down. Great stuff.
> 
> An easy fix is to track the mask within the queue_vector structure,
> and to make sure it has the same lifetime as the interrupt itself.
> 
> Fixes: e531f76757eb ("net: mvpp2: handle cases where more CPUs are available than s/w threads")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> As requested in https://lore.kernel.org/lkml/20181030135354.GD3407@kwain/

Applied.
