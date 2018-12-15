Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9622C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BE721741
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbeLOVVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 16:21:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55914 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeLOVVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 16:21:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EE85B14E8EDF5;
        Sat, 15 Dec 2018 13:21:22 -0800 (PST)
Date:   Sat, 15 Dec 2018 13:21:22 -0800 (PST)
Message-Id: <20181215.132122.1103841076914796723.davem@davemloft.net>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: macb: restart tx after tx used bit read
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1544784033-16390-1-git-send-email-claudiu.beznea@microchip.com>
References: <1544784033-16390-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 13:21:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <Claudiu.Beznea@microchip.com>
Date: Fri, 14 Dec 2018 10:40:47 +0000

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
> ---
> 
> changes in v2:
> - use "static inline" instead of "inline static" for macb_tx_restart()

Yes that is the correct order for a static inline function declaration,
but in foo.c files we do not use the inline keyword and instead let the
compiler decide the best thing to do.

Please remove this inline keyword and resubmit.

Thank you.
