Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C59C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D8124A52
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PilTO0B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D8124A52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeFWQyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:54:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeFWQyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qmzMxjVCM1fuLj05sJlWZ1eebU10coqmnePP8san91c=; b=PilTO0B/zOMOv+TeIvAJzkDAQ
        VzkLB5TZSmSfTHVvJVvjcHwDfGq5FxzrkOGkS3cHckm7qG+vo//zUF6iIaOLgHW1+A4PtjKq5lAgt
        9umZHqvddgxI3AfZ01iSFV6vrj8rL0/FhLttm3M1zP0Hxz0rLTvGLcPR4SwfYfHarC2k7bTiaaP58
        twIcpl2JWwFZblA7UPn8ZxPIhrh4qd9HpE9r4PZZjAoAODCQsno6zFD4JLyzUWBWSL8z5KIRtLaZY
        irAgdsvl/+MWMbNMbpNSGN9tDJGuea78kRo/qSPYPU1fEzIHeYd6Rg0IZxHkvJXj6UGIV0fPkyCcl
        SCfepTLlw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWloC-0006CC-9B; Sat, 23 Jun 2018 16:54:44 +0000
Subject: Re: [GIT PULL 2/2] Kconfig updates for v4.18
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
References: <CAK7LNASMpvFgue9gZ=6Epq_Skt2pvTVOoT9w=SzA_uGR87KP-w@mail.gmail.com>
 <87r2l4jkgf.fsf@xmission.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <59c40547-7937-1000-3a8a-b852c3b8a6bf@infradead.org>
Date:   Sat, 23 Jun 2018 09:54:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87r2l4jkgf.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 06:25 AM, Eric W. Biederman wrote:
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> 
>> - drop CONFIG_CROSS_COMPILE support
> 
> aka
>> commit f1089c92da791034af73478159626007cba7f092
>> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Date:   Mon May 28 18:21:39 2018 +0900
>>
>>     kbuild: remove CONFIG_CROSS_COMPILE support
>>     
>>     Kbuild provides a couple of ways to specify CROSS_COMPILE:
>>     
>>     [1] Command line
>>     [2] Environment
>>     [3] arch/*/Makefile (only some architectures)
>>     [4] CONFIG_CROSS_COMPILE
>>     
>>     [4] is problematic for the compiler capability tests in Kconfig.
>>     CONFIG_CROSS_COMPILE allows users to change the compiler prefix from
>>     'make menuconfig', etc.  It means, the compiler options would have
>>     to be all re-calculated everytime CONFIG_CROSS_COMPILE is changed.
>>     
>>     To avoid complexity and performance issues, I'd like to evaluate
>>     the shell commands statically, i.e. only parsing Kconfig files.
>>     
>>     I guess the majority is [1] or [2].  Currently, there are only
>>     5 defconfig files that specify CONFIG_CROSS_COMPILE.
>>       arch/arm/configs/lpc18xx_defconfig
>>       arch/hexagon/configs/comet_defconfig
>>       arch/nds32/configs/defconfig
>>       arch/openrisc/configs/or1ksim_defconfig
>>       arch/openrisc/configs/simple_smp_defconfig
>>     
>>     Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>     Reviewed-by: Kees Cook <keescook@chromium.org>
>>
> 
> I just started working against 4.18-rc1 and discovered this.
> 
> This has broken my setup for building and testing changes on other
> architectures.  I have to put the name of the compiler prefix somewhere.
> The mapping between the prefix to gcc and the linux architecture is
> non-trivial.  Especially with a lot of architectures in the test pool.
> 
> I am tired and frustrated this morning as this is going to keep me from
> getting done what I had planned today.
> 
> This is a regression pure and simple.  It breaks my workflow.  Please
> fix it.

Hi Eric,

I haven't seen any replies to your email.

FWIW, every bump in kernel major version number breaks my scripts, and I just
update them.


Anyway, I can offer you my cross-build scripts if you want them.
Then are named xbuild_$(ARCH).sh (well, mostly) and they (mostly) replace
and work like "make".  E.g. this is how I use one of them:
$ xbuild_arm.sh allmodconfig
$ xbuild_arm.sh all >armall.out 2>&1

I used Arnd's crosstool builds from https://cdn.kernel.org/pub/tools/crosstool/.


Or you could check out the kbuild test robot make.cross script that is
mentioned in every build-errors report:

        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ee076e81fc14ca79334d02970cea66604f183a14
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=sparc


-- 
~Randy
