Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAADC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A935426C72
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A935426C72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933028AbeF1Eum (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:50:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45232 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeF1Euk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:50:40 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 484D312163CC5;
        Wed, 27 Jun 2018 21:50:37 -0700 (PDT)
Date:   Thu, 28 Jun 2018 13:50:35 +0900 (KST)
Message-Id: <20180628.135035.1675371432262099147.davem@davemloft.net>
To:     alexandre.belloni@bootlin.com
Cc:     rafalo@cadence.com, nicolas.ferre@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: macb: initialize bp->queues[0].bp for
 at91rm9200
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180626084401.16780-1-alexandre.belloni@bootlin.com>
References: <20180626084401.16780-1-alexandre.belloni@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Jun 2018 21:50:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 26 Jun 2018 10:44:01 +0200

> The macb driver currently crashes on at91rm9200 with the following trace:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000014
> [...]
> [<c031da44>] (macb_rx_desc) from [<c031f2bc>] (at91ether_open+0x2e8/0x3f8)
> [<c031f2bc>] (at91ether_open) from [<c041e8d8>] (__dev_open+0x120/0x13c)
> [<c041e8d8>] (__dev_open) from [<c041ec08>] (__dev_change_flags+0x17c/0x1a8)
> [<c041ec08>] (__dev_change_flags) from [<c041ec4c>] (dev_change_flags+0x18/0x4c)
> [<c041ec4c>] (dev_change_flags) from [<c07a5f4c>] (ip_auto_config+0x220/0x10b0)
> [<c07a5f4c>] (ip_auto_config) from [<c000a4fc>] (do_one_initcall+0x78/0x18c)
> [<c000a4fc>] (do_one_initcall) from [<c0783e50>] (kernel_init_freeable+0x184/0x1c4)
> [<c0783e50>] (kernel_init_freeable) from [<c0574d70>] (kernel_init+0x8/0xe8)
> [<c0574d70>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)
> 
> Solve that by initializing bp->queues[0].bp in at91ether_init (as is done
> in macb_init).
> 
> Fixes: ae1f2a56d273 ("net: macb: Added support for many RX queues")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied and queued up for -stable.
