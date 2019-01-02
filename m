Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9E4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B42320656
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="NKDXpZgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfABPJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:09:08 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:39108 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfABPJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:09:07 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id ABC385C0249;
        Wed,  2 Jan 2019 16:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546441744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yyQmrlVqjJYGuohv6QITgAdpSPw6RbmaPhZKcGEJjR0=;
        b=NKDXpZgGGHPbTlJ6ALc6nwnci2LvUkYVEoQ+ywMeylHCJC99U+G+XZuARBPYMaNY8Gtvla
        7kMmY/dlDjRxXB/+LxZYCcqih1RfYnBSCoC7ye5j+Cu9CJ3ofQeaJvLajviIPXWI/hvZFb
        bN5QCwklQaHhZAqjDZR4bHagVEzvjQ0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Jan 2019 16:09:04 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] ARM: uaccess: use unified assembler language syntax
In-Reply-To: <201812310309.fFJTFUuf%fengguang.wu@intel.com>
References: <8190fb3605e863295bdb6311b1966b69d4fa9e73.1546185298.git.stefan@agner.ch>
 <201812310309.fFJTFUuf%fengguang.wu@intel.com>
Message-ID: <8f6aeb56adcb7a937c834ee24b654805@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.12.2018 20:12, kbuild test robot wrote:
> Hi Stefan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on arm/for-next]
> [also build test ERROR on v4.20 next-20181224]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Stefan-Agner/ARM-fix-argument-count-to-match-macro-definition/20181231-001137
> base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
> config: arm-ebsa110_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    /tmp/ccfKN3IW.s: Assembler messages:
>    /tmp/ccfKN3IW.s:26: Error: bad instruction `sbcscc r1,r1,r3'
>>> /tmp/ccfKN3IW.s:94: Error: bad instruction `sbcscc r8,r8,r0'
>    /tmp/ccfKN3IW.s:104: Error: bad instruction `sbcscc r0,r0,r2'
>    /tmp/ccfKN3IW.s:155: Error: bad instruction `sbcscc lr,lr,r2'
>    /tmp/ccfKN3IW.s:630: Error: bad instruction `sbcscc r1,r1,r2'

Hm, it seems that gcc always assumes inline assembly is in non-unified
syntax when compiling using -marm:

        .syntax divided
@ 244 "arch/arm/kernel/signal.c" 1
        adds ip, r1, #760; sbcscc ip, ip, r3; movcc r3, #0
@ 0 "" 2

It seems that gcc would have an option to force unified syntax when
generating code for ARM state (-marm) using -masm-syntax-unified.
However, unfortunately, this seems currently broken. I created a bug in
the gcc bug tracker:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88648

The only solution I found is using ".syntax unified" in inline assembly,
not pretty but seems to do the job... Will send a v2.

--
Stefan



> --
>    /tmp/cc9oa73P.s: Assembler messages:
>    /tmp/cc9oa73P.s:2036: Error: bad instruction `sbcscc r1,r1,r3'
>    /tmp/cc9oa73P.s:3325: Error: bad instruction `sbcscc r3,r3,r0'
>    /tmp/cc9oa73P.s:3724: Error: bad instruction `sbcscc r2,r2,r3'
>    /tmp/cc9oa73P.s:4242: Error: bad instruction `sbcscc r1,r1,r3'
>>> /tmp/cc9oa73P.s:4304: Error: bad instruction `sbcscc r10,r10,r2'
>    /tmp/cc9oa73P.s:4831: Error: bad instruction `sbcscc r1,r1,r3'
>    /tmp/cc9oa73P.s:4973: Error: bad instruction `sbcscc r1,r1,r3'
>    /tmp/cc9oa73P.s:5059: Error: bad instruction `sbcscc r0,r0,r2'
>    /tmp/cc9oa73P.s:5076: Error: bad instruction `sbcscc r0,r0,r2'
>    /tmp/cc9oa73P.s:5120: Error: bad instruction `sbcscc r1,r1,r3'
> --
>    /tmp/ccnaC92i.s: Assembler messages:
>>> /tmp/ccnaC92i.s:133: Error: bad instruction `sbcscc r7,r7,r1'
>    /tmp/ccnaC92i.s:225: Error: bad instruction `sbcscc r1,r1,r3'
>    /tmp/ccnaC92i.s:631: Error: bad instruction `sbcscc ip,ip,r3'
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
