Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659CFC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFABD24D86
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="f3z51hkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFABD24D86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeFXCgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 22:36:55 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:58536 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbeFXCgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 22:36:54 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w5O2amHh005751;
        Sun, 24 Jun 2018 11:36:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w5O2amHh005751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529807809;
        bh=rKHslT/osSK2RWhr+8cP3M6PlQ3fg3jn62HGRMqDmVg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=f3z51hkmMDw0FlcGSwv+NEthMTsPF8TiDFW6tUVuxzqVwgjyl4SIBqwgsztuwydvX
         HkPpb8kBFTv23hUFdap2BuiPVPxM1mqRd/Nxaww+aDQfqBMPpPLvDXhWyGkfG9rkyq
         uqZb48dNQYyowEyD5SgKNHAOSmbg6PoegjUv8T8MA7xtnYD/exoGImsPtN4GzSWF7u
         i9/0NrZhxTQ7pl15mINVk8jP4m9V+2CdcsMAArQKKJjp8VfFXNY4YQDe8cIh6ywbBA
         xXH+Z7VtRaQVYk7IkJso5kpzJzXSSswDwc86avqVR5G/F+pucAwdnv1cptDJ496yB7
         wixcIg9UTf7BQ==
X-Nifty-SrcIP: [209.85.213.49]
Received: by mail-vk0-f49.google.com with SMTP id s187-v6so6000041vke.9;
        Sat, 23 Jun 2018 19:36:48 -0700 (PDT)
X-Gm-Message-State: APt69E1/JVD8BKkcM2sSgk3NSfe/QnD4OsawrDw1ePjFejPACxTSQjnO
        Ig76HhFw+KEltZ4T8x/YYYtqZEB1dX0MIO3i5mo=
X-Google-Smtp-Source: ADUXVKLymIt9hvgD1unybeRXbPfkmxXovdE4NqRtt2FQbkuLbsG1+izq6cMfC917oRnSG6AK1P6hOd+ovS8Vg/DSF5k=
X-Received: by 2002:a1f:2348:: with SMTP id j69-v6mr4461066vkj.160.1529807807496;
 Sat, 23 Jun 2018 19:36:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 19:36:06
 -0700 (PDT)
In-Reply-To: <87r2l4jkgf.fsf@xmission.com>
References: <CAK7LNASMpvFgue9gZ=6Epq_Skt2pvTVOoT9w=SzA_uGR87KP-w@mail.gmail.com>
 <87r2l4jkgf.fsf@xmission.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 24 Jun 2018 11:36:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmdv+n7i0sJTAQMkbRHRVj-mihJs5nS-oi4fUkB8x8qg@mail.gmail.com>
Message-ID: <CAK7LNATmdv+n7i0sJTAQMkbRHRVj-mihJs5nS-oi4fUkB8x8qg@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Kconfig updates for v4.18
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-06-18 22:25 GMT+09:00 Eric W. Biederman <ebiederm@xmission.com>:
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
>
> Eric
>

Sorry, I cannot fix.

As I mentioned in the commit log,
CONFIG_CROSS_COMPILE cannot co-exist with the new Kconfig feature.

Only the possible fix is to revert almost all Kbuild/Kconfig commits
merged in the previous MW, but I do not want to.



-- 
Best Regards
Masahiro Yamada
