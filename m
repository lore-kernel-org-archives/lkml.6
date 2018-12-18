Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5234C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABAC218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeLRX6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:58:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44678 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeLRX6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:58:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 66A2C14884BDC;
        Tue, 18 Dec 2018 15:58:08 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:58:07 -0800 (PST)
Message-Id: <20181218.155807.980017168804336432.davem@davemloft.net>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: macb: restart tx after tx used bit read
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1545040937-6583-1-git-send-email-claudiu.beznea@microchip.com>
References: <1545040937-6583-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 15:58:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <Claudiu.Beznea@microchip.com>
Date: Mon, 17 Dec 2018 10:02:42 +0000

> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> On some platforms (currently detected only on SAMA5D4) TX might stuck
> even the pachets are still present in DMA memories and TX start was
> issued for them. This happens due to race condition between MACB driver
> updating next TX buffer descriptor to be used and IP reading the same
> descriptor. In such a case, the "TX USED BIT READ" interrupt is asserted.
> GEM/MACB user guide specifies that if a "TX USED BIT READ" interrupt
> is asserted TX must be restarted. Restart TX if used bit is read and
> packets are present in software TX queue. Packets are removed from software
> TX queue if TX was successful for them (see macb_tx_interrupt()).
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Applied and queued up for -stable, thanks.
