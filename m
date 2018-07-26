Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90D2C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D630205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D630205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeG0ArE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:47:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48842 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730610AbeG0ArE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:47:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0E2AB207F4; Fri, 27 Jul 2018 01:28:00 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6765A20618;
        Fri, 27 Jul 2018 01:27:59 +0200 (CEST)
Date:   Fri, 27 Jul 2018 01:27:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 2/2] sparc64: add reads{b,w,l}/writes{b,w,l}
Message-ID: <20180727012758.664d5dcf@xps13>
In-Reply-To: <20180720102339.22c9aa57@bbrezillon>
References: <20180711120824.3882108-1-arnd@arndb.de>
        <20180711120824.3882108-2-arnd@arndb.de>
        <20180720102339.22c9aa57@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Fri, 20 Jul 2018
10:23:39 +0200:

> +Miquel who's in charge of the NAND tree for this release
> 
> On Wed, 11 Jul 2018 14:08:06 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Some drivers need these for compile-testing. On most architectures
> > they come from asm-generic/io.h, but not on sparc64, which has its
> > own definitions.
> > 
> > Since we already have ioread*_rep()/iowrite*_rep() that have the
> > same behavior on sparc64 (i.e. all PCI I/O space is memory mapped),
> > we can rename the existing helpers and add macros to define them
> > to the same implementation.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> I tried to compile a sparc64 kernel with COMPILE_TEST=y plus the
> orion and s3c2410 NAND drivers enabled and it compiles fine (it does
> without this patch). So it seems to fix the compilation error reported
> by kbuild robots.
> 
> Tested-by: Boris Brezillon <boris.brezillon@bootlin>
> (only compile-tested)
> 
> Dave gave his A-b, so, if everyone is okay with that, I'd like this
> patch to go trough the NAND tree.

Applied to nand/next.

Thanks,
Miquèl

