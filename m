Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CE6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ED221848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbfBSHpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:45:23 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38789 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfBSHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:45:22 -0500
X-Greylist: delayed 75100 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Feb 2019 02:45:22 EST
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 1DF59FF803;
        Tue, 19 Feb 2019 07:45:19 +0000 (UTC)
Date:   Tue, 19 Feb 2019 08:45:19 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the asm-generic tree
Message-ID: <20190219074519.GA2294@behemoth.owl.eu.com.local>
References: <20190219173654.47e9bc36@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219173654.47e9bc36@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Arnd,

> After merging the asm-generic tree, today's linux-next build (powerpc
> allnoconfig) failed like this:
> ...
> Caused by commit
> 
>   8e074c243ed3 ("iomap: add missing const to ioread*/iowrite addr arg")

I have prepared a patch addressing this issue, and am currently building it
with a powerpc cross compiler. I'll submit it once it's done. Please tell
me if I should update the initial patch instead.

> The const qualifiers are also missing in:
> 
> arch/parisc/lib/iomap.c
> arch/sh/kernel/iomap.c

I also have patches for these architectures, but it is more complicated for
me to test them with a cross compiler. Should I still submit them?

> I have reverted that commit for today.
> 
> BTW, that commit only added the const to the ioread* functions ...

Yes, and it does not even make sense to add a const qualifier to the addr
argument in the iowrite case. That was a bad commit message.

Thanks, and sorry for the trouble.

regards,
 Hugo

-- 
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C
