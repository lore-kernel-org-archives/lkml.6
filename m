Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066DFECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A825F20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MobyjZyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A825F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeGVATn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 20:19:43 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:54251 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbeGVATm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 20:19:42 -0400
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6LNOv5C015888
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 08:24:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6LNOv5C015888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532215497;
        bh=j6PPolWUc9dRN7J2tpMcA1CEHEVzJDYJ2ojYgvqWoZc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=MobyjZybX/Ef3esQzTE+gWMXBz49ixbX5I27hl+VjxkaXaGDRMqxgdiLLuZ2E7TUu
         lMGLeParKHlPq8HRiFLEBY9SRO8HourrVXMr9MPrEW2kqQFKrXhv9ppXPhyVVVEjZi
         ZWUbvn+mIVJ90N68efW6HcA7D+4h5vb7WCwFkuSGmEI7HjBCJikM7N82rA8RycSaeX
         QymjtA1Nkoe3NAB330vwEjt/+8I3ySQM/cUo7iqI2fZInI3TqZIzv2r4Zgguyxm7id
         LgP/zFhqIiyc6feF9uJ9TIAyEnnOV+CA0PSk8kJPRvsZSxdDvlp5pKFLA3Gk84WU90
         ngiBnWyp+sL3A==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id b78-v6so7665332vka.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 16:24:57 -0700 (PDT)
X-Gm-Message-State: AOUpUlFXznhWysOdmoxGCe09d7N5G3n2djaPdLbz+cdMMxBNr6rvE7YZ
        W4rRYVn6dk1oSgRXZgVHYdPyMVvtoo4lfZfjebw=
X-Google-Smtp-Source: AAOMgpcKtcv0QNJHOstsxqTeKgcQYWydi66vIzy7dOl61GMzETh6eoW6sGuCpBgg/44IginNhRdJ12WJjtncWdYfFp8=
X-Received: by 2002:a1f:5347:: with SMTP id h68-v6mr4675789vkb.141.1532215496361;
 Sat, 21 Jul 2018 16:24:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 16:24:15
 -0700 (PDT)
In-Reply-To: <20180721212430.odjwcusbbihffo6l@localhost>
References: <CAK7LNAShLhWqCRR8RfuJ0xBJAFoj-S6WLcSdh9QShg8dGfq9RA@mail.gmail.com>
 <20180721212430.odjwcusbbihffo6l@localhost>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 22 Jul 2018 08:24:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQHL16vxv7twzy9PPkLLrbvzuAMa9QtOjSN3Z1KHWKG_Q@mail.gmail.com>
Message-ID: <CAK7LNAQHL16vxv7twzy9PPkLLrbvzuAMa9QtOjSN3Z1KHWKG_Q@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] ARM: uniphier: UniPhier SoC updates for v4.19
To:     Olof Johansson <olof@lixom.net>
Cc:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

2018-07-22 6:24 GMT+09:00 Olof Johansson <olof@lixom.net>:
> On Thu, Jul 19, 2018 at 08:05:03AM +0900, Masahiro Yamada wrote:
>> Hi Arnd, Olof,
>>
>> Please pull UniPhier SoC changes for the v4.19 MW.
>>
>> Thanks!
>>
>>
>> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>
>>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
>> tags/uniphier-soc-v4.19
>>
>> for you to fetch changes up to ae93e694440a454609fa40725e16619c5a781768:
>>
>>   ARM: uniphier: remove empty Makefile (2018-07-19 06:53:16 +0900)
>>
>> ----------------------------------------------------------------
>> UniPhier ARM SoC updates for v4.19
>>
>> - enable ethernet and thermal drivers from multi_v7_defconfig
>>
>> - select RESET_CONTROLLER
>>
>> - remove empty arch/arm/mach-uniphier/Makefile
>>
>> ----------------------------------------------------------------
>> Kunihiko Hayashi (1):
>>       ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE
>
> I renormalied multi_v7_defconfig for 4.18-rc3, so please base your branch
> on that to avoid conflicts.
>
> Also, we separate out defconfig updates to branches on their own. I can
> cherry-pick the branch apart but wanted to check with you before I do
> so in case it messes up your workflow. If it does, send a fresh pull
> request for SoC, and either one for the defconfig or just the patch and
> we can apply it directly.
>

Can you do cherry-pick please?

Thanks!





-- 
Best Regards
Masahiro Yamada
