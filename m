Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD54C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE4D205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE4D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbeG0Aro convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:47:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48876 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730701AbeG0Arn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:47:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CF220207F4; Fri, 27 Jul 2018 01:28:39 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 421AB20618;
        Fri, 27 Jul 2018 01:28:39 +0200 (CEST)
Date:   Fri, 27 Jul 2018 01:28:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ia64: use asm-generic/io.h
Message-ID: <20180727012838.69beafb2@xps13>
In-Reply-To: <20180720111004.3bbb6b8f@bbrezillon>
References: <20180711120824.3882108-1-arnd@arndb.de>
        <20180720111004.3bbb6b8f@bbrezillon>
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
11:10:04 +0200:

> +Miquel
> 
> On Wed, 11 Jul 2018 14:08:05 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > asm-generic/io.h provides a generic implementation of all I/O accessors,
> > which the architectures can override.
> > 
> > Since ia64 does not provide readsl/writesl etc, any driver using those
> > fails to build, and including asm-generic/io.h will provide the
> > missing interfaces, as well as any other future interfaces that get
> > added there. We need to #define a couple of symbols to themselves
> > in the ia64 to ensure that we use the ia64 specific version of those
> > rather than the generic one.
> > 
> > There should be no other effect than adding {read,write}s{b,w,l}()
> > as well as {in,out}s{b,w,l}_p(), which were also not provided
> > by ia64 but are provided by the generic header for historic reasons.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> As for the other patch, I compile-tested it and it fixes the
> compilation errors reported by kbuild robots.
> 
> Tested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> If everyone is fine with that, we'll take the patch through the NAND
> tree.

Applied to nand/next.

Thanks,
Miquèl
