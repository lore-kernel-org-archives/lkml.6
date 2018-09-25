Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF7EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E1520676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E1520676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeIYXpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:45:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38572 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIYXpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:45:39 -0400
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6D3C0142154E7;
        Tue, 25 Sep 2018 10:37:06 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:37:05 -0700 (PDT)
Message-Id: <20180925.103705.90948916724711521.davem@davemloft.net>
To:     michal.simek@xilinx.com
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        edgar.iglesias@xilinx.com, netdev@vger.kernel.org,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH v2] net: macb: Clean 64b dma addresses if they are not
 detected
From:   David Miller <davem@davemloft.net>
In-Reply-To: <68051905ba59d7cfd74c63ef5bf0830dc2b9f6fe.1537857166.git.michal.simek@xilinx.com>
References: <68051905ba59d7cfd74c63ef5bf0830dc2b9f6fe.1537857166.git.michal.simek@xilinx.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 25 Sep 2018 10:37:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>
Date: Tue, 25 Sep 2018 08:32:50 +0200

> Clear ADDR64 dma bit in DMACFG register in case that HW_DMA_CAP_64B is
> not detected on 64bit system.
> The issue was observed when bootloader(u-boot) does not check macb
> feature at DCFG6 register (DAW64_OFFSET) and enabling 64bit dma support
> by default. Then macb driver is reading DMACFG register back and only
> adding 64bit dma configuration but not cleaning it out.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Clean reg at the first place - Edgar
> - Update commit message

Applied, thank you.
