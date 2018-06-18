Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153AC20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153AC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934167AbeFRNZX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:25:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40433 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933009AbeFRNZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:25:21 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fUu9m-0006Zv-GR; Mon, 18 Jun 2018 07:25:19 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fUu9k-0003XB-KO; Mon, 18 Jun 2018 07:25:18 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
References: <CAK7LNASMpvFgue9gZ=6Epq_Skt2pvTVOoT9w=SzA_uGR87KP-w@mail.gmail.com>
Date:   Mon, 18 Jun 2018 08:25:04 -0500
In-Reply-To: <CAK7LNASMpvFgue9gZ=6Epq_Skt2pvTVOoT9w=SzA_uGR87KP-w@mail.gmail.com>
        (Masahiro Yamada's message of "Thu, 7 Jun 2018 02:18:18 +0900")
Message-ID: <87r2l4jkgf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fUu9k-0003XB-KO;;;mid=<87r2l4jkgf.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ebwd7OpEEEBiNbkMo4WSIripsmL10FcA=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL 2/2] Kconfig updates for v4.18
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> - drop CONFIG_CROSS_COMPILE support

aka
> commit f1089c92da791034af73478159626007cba7f092
> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date:   Mon May 28 18:21:39 2018 +0900
> 
>     kbuild: remove CONFIG_CROSS_COMPILE support
>     
>     Kbuild provides a couple of ways to specify CROSS_COMPILE:
>     
>     [1] Command line
>     [2] Environment
>     [3] arch/*/Makefile (only some architectures)
>     [4] CONFIG_CROSS_COMPILE
>     
>     [4] is problematic for the compiler capability tests in Kconfig.
>     CONFIG_CROSS_COMPILE allows users to change the compiler prefix from
>     'make menuconfig', etc.  It means, the compiler options would have
>     to be all re-calculated everytime CONFIG_CROSS_COMPILE is changed.
>     
>     To avoid complexity and performance issues, I'd like to evaluate
>     the shell commands statically, i.e. only parsing Kconfig files.
>     
>     I guess the majority is [1] or [2].  Currently, there are only
>     5 defconfig files that specify CONFIG_CROSS_COMPILE.
>       arch/arm/configs/lpc18xx_defconfig
>       arch/hexagon/configs/comet_defconfig
>       arch/nds32/configs/defconfig
>       arch/openrisc/configs/or1ksim_defconfig
>       arch/openrisc/configs/simple_smp_defconfig
>     
>     Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>     Reviewed-by: Kees Cook <keescook@chromium.org>
> 

I just started working against 4.18-rc1 and discovered this.

This has broken my setup for building and testing changes on other
architectures.  I have to put the name of the compiler prefix somewhere.
The mapping between the prefix to gcc and the linux architecture is
non-trivial.  Especially with a lot of architectures in the test pool.

I am tired and frustrated this morning as this is going to keep me from
getting done what I had planned today.

This is a regression pure and simple.  It breaks my workflow.  Please
fix it.

Eric

