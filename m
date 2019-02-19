Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0D9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2689221479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfBSLTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:19:22 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47139 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:19:21 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BC10D6000C;
        Tue, 19 Feb 2019 11:19:18 +0000 (UTC)
Date:   Tue, 19 Feb 2019 12:19:18 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the asm-generic tree
Message-ID: <20190219111918.GC2294@behemoth.owl.eu.com.local>
References: <20190219173654.47e9bc36@canb.auug.org.au>
 <20190219074519.GA2294@behemoth.owl.eu.com.local>
 <CAK8P3a0omA-__7MLAw_SKuug_GZ0FfFPVr1Tsnx5Hb0sesv8gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0omA-__7MLAw_SKuug_GZ0FfFPVr1Tsnx5Hb0sesv8gw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sending a pull request for this if it breaks any architectures,
> so I think we need to fix them all, and I suppose we also have to
> change all architectures in the same patch that changes the architecture
> independent declaration, so it doesn't break intermittently.
> 
> At this point, I'd probably drop your patches from my asm-generic
> tree  entirely to avoid the regression, and wait for you to resend
> them all after 5.1-rc1, for inclusion in 5.2.
> 
> Can you elaborate on the original problem that you saw? Maybe
> we can have a different workaround for it in the meantime.

Agree, these two patches should be dropped:

1. iomap: add missing const to ioread*/iowrite addr arg

since there are incompatible definitions or declarations in

arch/alpha/include/asm/core_apecs.h
arch/alpha/include/asm/core_cia.h
arch/alpha/include/asm/core_lca.h
arch/alpha/include/asm/core_marvel.h
arch/alpha/include/asm/core_mcpcia.h
arch/alpha/include/asm/core_t2.h
arch/alpha/include/asm/io.h
arch/alpha/include/asm/io_trivial.h
arch/alpha/include/asm/jensen.h
arch/alpha/include/asm/machvec.h
arch/alpha/kernel/core_marvel.c
arch/alpha/kernel/io.c
arch/parisc/lib/iomap.c
arch/powerpc/kernel/iomap.c
arch/sh/kernel/iomap.c

2. lib/iomap: add missing const to mmio_ins* addr arg

since there are incompatible definitions or declarations in

arch/sh/kernel/iomap.c

I will resubmit them with all changes required for arch/. The ones for
alpha, powerpc and sh are already ready and built with cross compiler.
I still have to setup a cross compiler to build my parisc changes.

Thanks,

regards,
 Hugo

-- 
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C
