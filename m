Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9910C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A9B2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A9B2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbeHWEh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:37:27 -0400
Received: from nautica.notk.org ([91.121.71.147]:33711 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbeHWEh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:37:27 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id CC432C009; Thu, 23 Aug 2018 03:10:17 +0200 (CEST)
Date:   Thu, 23 Aug 2018 03:10:02 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually
 exclusive
Message-ID: <20180823011002.GB6244@nautica>
References: <20180822233724.110454-1-ndesaulniers@google.com>
 <20180823002508.GA822@nautica>
 <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote on Wed, Aug 22, 2018:
> I've fixed that manually, but when I tried to test it I just hit the
> 
>   arch/x86/Makefile:179: *** Compiler lacks asm-goto support..  Stop.
> 
> error.
> 
> Do you have some experimental clang build with asm goto support? What
> version? Or is it just that you're building ARM, not x86?

I'm not building linux directly, but BPF programs that indirectly uses
clang with bcc

On fedora you can install bcc-tools and run
e.g. /usr/share/bcc/tools/execsnoop that will compile something at
runtime.
If the package isn't available for your distro you can just install bcc
and run the script from their repo[1]

[1] https://raw.githubusercontent.com/iovisor/bcc/master/tools/execsnoop.py


Thanks,
-- 
Dominique
