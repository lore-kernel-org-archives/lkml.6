Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8444AC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D64421907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBHCTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:19:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfBHCTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:19:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 781D8108B8734;
        Thu,  7 Feb 2019 18:19:18 -0800 (PST)
Date:   Thu, 07 Feb 2019 18:19:18 -0800 (PST)
Message-Id: <20190207.181918.1582739067793552076.davem@davemloft.net>
To:     arun.parameswaran@broadcom.com
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: dsa: b53: Fix for failure when irq is not
 defined in dt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190208000118.9268-1-arun.parameswaran@broadcom.com>
References: <20190208000118.9268-1-arun.parameswaran@broadcom.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Feb 2019 18:19:18 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Parameswaran <arun.parameswaran@broadcom.com>
Date: Thu,  7 Feb 2019 16:01:18 -0800

> Fixes the issues with non BCM58XX chips in the b53 driver
> failing, when the irq is not specified in the device tree.
> 
> Removed the check for BCM58XX in b53_srab_prepare_irq(),
> so the 'port->irq' will be set to '-EXIO' if the irq is not
> specified in the device tree.
> 
> Fixes: 16994374a6fc ("net: dsa: b53: Make SRAB driver manage port interrupts")
> Fixes: b2ddc48a81b5 ("net: dsa: b53: Do not fail when IRQ are not initialized")
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Applied and queued up for -stable, thanks.
