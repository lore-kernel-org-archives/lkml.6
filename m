Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E87F208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Jrpw3/mD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E87F208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754495AbeGHCQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 22:16:19 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:60896 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754423AbeGHCQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 22:16:17 -0400
Received: from mail-ua0-f179.google.com (mail-ua0-f179.google.com [209.85.217.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w682GBDn019109;
        Sun, 8 Jul 2018 11:16:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w682GBDn019109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531016172;
        bh=TMJOtZV4av0FGxNeMAolyYudFrCn7Ydd/ZOmjWCv+Hk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Jrpw3/mD1jVQnuVc7yIKVOIcAmvOA7jNE8MIi93+CBzsnYKgUIKwk6ebNjsEEjH1g
         b7EHvNJkH9Sr+mqcLWMLqC2eFGxCX7FwmRb0o5V0VO5aDW7GGqKujLVomXOM3+VlKm
         ad/wvUEvCtfuN7JizAw+qOobOlG3L9sgch0+1T1dg0BP2VbAthGbaTDAxeK8et1Qyb
         FJhiFlYyKOKZ9Sa4FAi96dcYW1AMCzpAHBTyQU8oAujG7ePQzu3OJwu0E0hoFPnSdt
         acgdLkYyapOQucHVoiRy5IOyaeJrPOB1jWFZw5Qf+zJ0DQPUBF5jA34ONWKqGfMGor
         HUfYwuSDqDgCg==
X-Nifty-SrcIP: [209.85.217.179]
Received: by mail-ua0-f179.google.com with SMTP id i4-v6so2907504uak.0;
        Sat, 07 Jul 2018 19:16:11 -0700 (PDT)
X-Gm-Message-State: APt69E0TPqQf2Q7n2Ac2sJGzDxhR6L+ZEJrqDqadMKQH7VX2o8S0jFxq
        I+nmNBcNpMRPwF0SCKsH9RJoqADApn9fj9dCxxo=
X-Google-Smtp-Source: AAOMgpdV7HS/ayXaglEmbLmwzJJ2QWHBOikO8IYyMk88pBDWoJv4Yr2uCxHBUHAOsQi+VytyvcTQwuf1W+u6PShUMuU=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr9563337uaf.199.1531016170558;
 Sat, 07 Jul 2018 19:16:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 19:15:30 -0700 (PDT)
In-Reply-To: <a2a39cac-79fc-22d9-e1d0-b94787526794@cn.fujitsu.com>
References: <a2a39cac-79fc-22d9-e1d0-b94787526794@cn.fujitsu.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 8 Jul 2018 11:15:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQnpQn5k0fkb+nSASe7qg1UgX6BhdR-3EEuSX=xOuPhrw@mail.gmail.com>
Message-ID: <CAK7LNAQnpQn5k0fkb+nSASe7qg1UgX6BhdR-3EEuSX=xOuPhrw@mail.gmail.com>
Subject: Re: kconfig usage in automatic kernel test
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-06 17:49 GMT+09:00 Cao jin <caoj.fnst@cn.fujitsu.com>:
> Masahiro-san,
>
>   I am writing some utility for internal kdump test with latest kernel,
> my purpose is to test the new introduced kernel feature. For automatical
> test, I see several config target could help, like olddefconfig, all*config.
>
> But for my purpose, I don't find a good way. For example, olddefconfig
> will let the now config item has default value, while some feature may
> default to "N"; allyesconfig will slow the compilation notably.
> But "all*config" has KCONFIG_ALLCONFIG help to customizing some config
> item, that is a good utility, but seems it can't be used in olddefconfig.
>
> All these things let me have 2 questions:
>
> 1. What would you suggest for my purpose?


scripts/kconfig/merge_config.sh
can be used with any *config target.

If you want to tweak some symbols based on olddefconfig,
this could be the one you want.


> 2. allyesconfig, allmodconfig, randconfig seems useful for test kbuild,
> but what's the purpose of allnoconfig, alldefconfig? In others words,
> when people would need allnoconfig, alldefconfig?

I sometimes use allnoconfig for build testing.

When I want to test the whole build process quickly,
I disable as many drivers as possible to save time.


I do not use alldefconfig.
Anyway, it would not hurt to have it for completeness.


> --
> Sincerely,
> Cao jin
>
>



-- 
Best Regards
Masahiro Yamada
