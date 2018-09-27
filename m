Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7781C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CD921531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CD921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeI0SGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:06:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51488 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbeI0SGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:06:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9B7B1208EB; Thu, 27 Sep 2018 13:48:06 +0200 (CEST)
Received: from bbrezillon (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6FFC0208A1;
        Thu, 27 Sep 2018 13:47:56 +0200 (CEST)
Date:   Thu, 27 Sep 2018 13:47:56 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 0/8] gpio-addr-flash: Support for device-tree and
 cleanup
Message-ID: <20180927134756.6a2e1317@bbrezillon>
In-Reply-To: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Sep 2018 16:36:35 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> This patch series does the following:
> 
> 1) Fix bug regarding ioremap size
> 2) Cleanup code to use new APIs
> 3) Simplify numerical operations
> 4) Add support for device-tree devices
> 
> Thanks!
> 
> Changelog v2:
> 
> From Boris Brezillon:
> -Add Fixes and cc:stable
> 
> From kbuild:
> - Fix warnings
> 
> - Rebase
> 
> Ricardo Ribalda Delgado (8):
>   mtd: maps: gpio-addr-flash: Replace custom printk
>   mtd: maps: gpio-addr-flash: Fix ioremapped size
>   mtd: maps: gpio-addr-flash: Use devm_* functions
>   mtd: maps: gpio-addr-flash: Use order insted of size
>   mtd: maps: gpio-addr-flash: Replace array with an integer
>   mtd: maps: gpio-addr-flash: Split allocation in two

I'll apply patches 1 to 6 soon.

>   mtd: maps: gpio-addr-flash: Add support for device-tree devices
>   dt-binding: mtd: Document gpio-addr-flash

Still think we should move to gpio_desc before adding support for
DT.
