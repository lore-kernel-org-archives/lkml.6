Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF164C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2593F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="j6mRIsCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2593F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeGaKTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:19:47 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:19480 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbeGaKTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:19:47 -0400
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com [209.85.217.177]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w6V8eM7H005413
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 17:40:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w6V8eM7H005413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533026423;
        bh=DPNMlTHGxdMaionCEB+Lch41W3RMSTxN5Q0G4ZBhYZ8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=j6mRIsCH3V2BM8i2xRzXUhm79x95qOESCbscd8df9HGxgFb61rAK2XPoBzZRfwa1l
         IkCMnWb4S9UwnivmSeMyqJfzygqx5czUSzRf5R3UPfpyE/rVcERu204fdEVCkZOkHi
         qdlNO3XtFacG1v7QPmYXlfrQkF/HsAiqT4u6+YyZUHPu9Eau5MfLktYdvrtI32BCQ4
         mFX0TQtOEmfP5YkRGoujJ2Wv95dpRB1gK2tieBs6hAo02RUGvrjsVs7rtkow+WfqzL
         lhMladkllg9/z3jkenmK+ki0xY9N5ZzyTHsnV/x/VuZ2CPdlHfhZNWMA6Tj/f6GC0k
         ULl8rPgoYSCCA==
X-Nifty-SrcIP: [209.85.217.177]
Received: by mail-ua0-f177.google.com with SMTP id h1-v6so7413775uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:40:23 -0700 (PDT)
X-Gm-Message-State: AOUpUlGumZETwkayxB7nuXn3IDFwsCTNy2w+6jxslNfIn4wS56hX/d5F
        sA0eU5KZY6GJpo7zBJZLIb127ayH6MilOdVituk=
X-Google-Smtp-Source: AAOMgpffiJRmpaaRbkeT022gOCEAkTYpvG+UXNnd24e62dkcQsIQQrSXF8vSOB8MO/y6XT8OqrJ/XWwXZyGdrARsoUY=
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr14631729uad.82.1533026422504;
 Tue, 31 Jul 2018 01:40:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 01:39:42
 -0700 (PDT)
In-Reply-To: <CAK7LNAQHL16vxv7twzy9PPkLLrbvzuAMa9QtOjSN3Z1KHWKG_Q@mail.gmail.com>
References: <CAK7LNAShLhWqCRR8RfuJ0xBJAFoj-S6WLcSdh9QShg8dGfq9RA@mail.gmail.com>
 <20180721212430.odjwcusbbihffo6l@localhost> <CAK7LNAQHL16vxv7twzy9PPkLLrbvzuAMa9QtOjSN3Z1KHWKG_Q@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 31 Jul 2018 17:39:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSx1hSLQNCzAQyD74dvnHzVqkTFoWj6GL7_5+vZau7Uw@mail.gmail.com>
Message-ID: <CAK7LNARSx1hSLQNCzAQyD74dvnHzVqkTFoWj6GL7_5+vZau7Uw@mail.gmail.com>
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


2018-07-22 8:24 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Olof,
>
> 2018-07-22 6:24 GMT+09:00 Olof Johansson <olof@lixom.net>:
>> On Thu, Jul 19, 2018 at 08:05:03AM +0900, Masahiro Yamada wrote:
>>> Hi Arnd, Olof,
>>>
>>> Please pull UniPhier SoC changes for the v4.19 MW.
>>>
>>> Thanks!
>>>
>>>
>>> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>>
>>>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
>>> tags/uniphier-soc-v4.19
>>>
>>> for you to fetch changes up to ae93e694440a454609fa40725e16619c5a781768:
>>>
>>>   ARM: uniphier: remove empty Makefile (2018-07-19 06:53:16 +0900)
>>>
>>> ----------------------------------------------------------------
>>> UniPhier ARM SoC updates for v4.19
>>>
>>> - enable ethernet and thermal drivers from multi_v7_defconfig
>>>
>>> - select RESET_CONTROLLER
>>>
>>> - remove empty arch/arm/mach-uniphier/Makefile
>>>
>>> ----------------------------------------------------------------
>>> Kunihiko Hayashi (1):
>>>       ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE
>>
>> I renormalied multi_v7_defconfig for 4.18-rc3, so please base your branch
>> on that to avoid conflicts.
>>
>> Also, we separate out defconfig updates to branches on their own. I can
>> cherry-pick the branch apart but wanted to check with you before I do
>> so in case it messes up your workflow. If it does, send a fresh pull
>> request for SoC, and either one for the defconfig or just the patch and
>> we can apply it directly.
>>
>
> Can you do cherry-pick please?
>

Ping?

You offered to cherry-pick the patches directly to your tree,
and I asked you to do so.



We do not have much time until the MW opens.
Please cherry-pick the following four:


Kunihiko Hayashi (1):
      ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE

Masahiro Yamada (3):
      ARM: uniphier: select RESET_CONTROLLER
      arm64: uniphier: select RESET_CONTROLLER
      ARM: uniphier: remove empty Makefile





-- 
Best Regards
Masahiro Yamada
