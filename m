Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CBAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C9220862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C9220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbeG0ApD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:45:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48792 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730610AbeG0ApC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:45:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C8333207F4; Fri, 27 Jul 2018 01:25:58 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3895B20618;
        Fri, 27 Jul 2018 01:25:58 +0200 (CEST)
Date:   Fri, 27 Jul 2018 01:25:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH] drivers/memory/Kconfig: Add CONFIG_OF dependency
Message-ID: <20180727012557.72fff5e1@xps13>
In-Reply-To: <20180723114107.664164d2@bbrezillon>
References: <20180721200049.7553-1-anders.roxell@linaro.org>
        <a83ff193-be57-f566-cafb-132075025b56@infradead.org>
        <20180722082939.2de739f1@bbrezillon>
        <CAK8P3a1_8OSqyKsbw+m3ZzLWfPqDK4ynG3WoPTk+K2uJJsiq5A@mail.gmail.com>
        <20180723114107.664164d2@bbrezillon>
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

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Mon, 23 Jul 2018
11:41:07 +0200:

> On Mon, 23 Jul 2018 11:34:43 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Sun, Jul 22, 2018 at 8:29 AM, Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:  
> > > +Arnd, Rob and the DT ML.
> > >
> > > On Sat, 21 Jul 2018 14:53:47 -0700
> > > Randy Dunlap <rdunlap@infradead.org> wrote:
> > >    
> > >> On 07/21/2018 01:00 PM, Anders Roxell wrote:    
> > >> > JZ4780_NEMC doesn't depend on OF, and if OF isn't enabled we get this
> > >> > error:
> > >> > drivers/memory/jz4780-nemc.c: In function ‘jz4780_nemc_num_banks’:
> > >> > drivers/memory/jz4780-nemc.c:72:10: error: implicit declaration of
> > >> >  function ‘of_read_number’; did you mean ‘down_read_nested’?
> > >> >  [-Werror=implicit-function-declaration]
> > >> >    bank = of_read_number(prop, 1);
> > >> >           ^~~~~~~~~~~~~~
> > >> >           down_read_nested    
> > >
> > > Looks like of.h defines stubs so that people can compile-test without
> > > CONFIG_OF selected. Maybe we should move of_read_number() and
> > > of_read_ulong() out of the #ifdef CONFIG_OF section.    
> > 
> > That seems fine, though the added dependency seems appropriate
> > here as well. of_read_number() is rarely used, and for the most part in
> > powerpc specific code that is guaranteed to have CONFIG_OF enabled,
> > so it's not that likely to cause many more problems.  
> 
> Ok, then I'll let Miquel apply Anders' patch to the NAND tree.

Applied to nand/next, thanks.

Miquèl
