Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5871CC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 15:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0D920843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 15:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0D920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeJ1AVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 20:21:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35216 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbeJ1AVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 20:21:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 244F020789; Sat, 27 Oct 2018 17:39:48 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D9E1320729;
        Sat, 27 Oct 2018 17:39:47 +0200 (CEST)
Date:   Sat, 27 Oct 2018 17:39:45 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     "Grandbois, Brett" <brett.grandbois@opengear.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for SPI boot flash access
 for AMD Family 16h
Message-ID: <20181027173945.241e87b2@bbrezillon>
In-Reply-To: <20181016005726.26813-1-brett.grandbois@opengear.com>
References: <20181016005726.26813-1-brett.grandbois@opengear.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brett,

On Tue, 16 Oct 2018 00:57:41 +0000
"Grandbois, Brett" <brett.grandbois@opengear.com> wrote:

> Add support to expose the SPI boot flash on AMD Family 16h CPUs as a
> standard mtd device to give userspace BIOS updaters greater feature
> support.  The BIOS and Kernel Developer's Guide refers to this as the
> 'SPI ROM' controller and so the driver follows that naming convention
> for consistency.
> 

We're currently trying to convert spi-nor controller drivers to the
spi-mem interface [1]. Can you look at this new interface and tell me if
you'd be able to implement it? If that's not possible, then I'd prefer
to have this driver implement the mtd_info interface directly.

Thanks,

Boris

[1]https://elixir.bootlin.com/linux/latest/source/include/linux/spi/spi-mem.h#L185
