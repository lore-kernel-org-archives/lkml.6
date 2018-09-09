Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA86C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FE520833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FE520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIIT7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 15:59:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49858 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeIIT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 15:59:06 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F0EB5142D4FA4;
        Sun,  9 Sep 2018 08:09:07 -0700 (PDT)
Date:   Sun, 09 Sep 2018 08:09:07 -0700 (PDT)
Message-Id: <20180909.080907.992434701890231030.davem@davemloft.net>
To:     mail@maciej.szmigiero.name
Cc:     nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: inform about CLKRUN protocol issue when behind
 a CardBus bridge
From:   David Miller <davem@davemloft.net>
In-Reply-To: <fcf6a23a-4721-5912-281e-488eb6a736c6@maciej.szmigiero.name>
References: <fcf6a23a-4721-5912-281e-488eb6a736c6@maciej.szmigiero.name>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 09 Sep 2018 08:09:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Thu, 6 Sep 2018 18:10:53 +0200

> It turns out that at least some r8169 CardBus cards don't operate correctly
> when CLKRUN protocol is enabled - the symptoms are recurring timeouts
> during PHY reads / writes and a very high packet drop rate.
> This is true of at least RTL8169sc/8110sc (XID 18000000) chip in
> Sunrich C-160 CardBus NIC.
> 
> Such behavior was observed on two separate laptops, the first one has
> TI PCIxx12 CardBus bridge, while the second one has Ricoh RL5c476II.
> 
> Setting CLKRUN_En bit in CONFIG 3 register via an EEPROM write didn't
> improve things in either case (this is probably why it wasn't set by the
> card manufacturer).
> The only way to fix the issue was to disable the CLKRUN protocol either
> in the CardBus bridge (only possible in the TI one) or in the southbridge.
> 
> Since the problem takes some time to debug let's warn people that have
> the suspect configuration (Conventional PCI r8169 NIC behind a CardBus
> bridge) so they know what they can do if they encounter it.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

I don't know about this.

Barking at the user in the kernel log about an obscure knob (which btw
doesn't exist for all cardbus bridges without other patches you are
posting elsewhere) is rarely effective.

We should just disable clkrun automatically we know it causes problems.

Sorry, I don't think this is that right approach and therefore I am not
applying this.

