Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCC1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A438D2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bRgSHXhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A438D2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeISUeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:34:01 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:41706 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731594AbeISUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:34:00 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w8JEtQX9008319;
        Wed, 19 Sep 2018 23:55:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w8JEtQX9008319
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537368927;
        bh=Q7Y5wlwPHqec3GuTCmjDOHZPvQumJNguyhW3CRqN2KY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=bRgSHXhJJ9M/0DREjwwGaI2m5DroxaddEvhD7Fz7MQ7m1um8pOP2IM1en2v0xPRAl
         ALkIpkjEw1eXWvEJ0m4np4TFW7p6t39jlmKg+XagESRPNVx/xci1DYbAASw2EiQzgi
         6qtPZ++zQh1TEBTOzcGzzdx/wzomLBwoZ77YajXPV2HcFAOOkuvOCIlsWsUG8BFcFU
         okYOlLes8TCcqBjST2Mg2249XUY3XgIVQY91KczRCWEItCDuTeVj44+ZkAVbuX7o3K
         4gUl15SCAy/Mf1bURmmsLqssapMZkkTNeWC5IWSYAu9pycnANqO2BzJZ9nVFtO0QKQ
         dK+bt4cbORjRQ==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id y196-v6so1878512vsy.7;
        Wed, 19 Sep 2018 07:55:26 -0700 (PDT)
X-Gm-Message-State: APzg51BXbzVxTQPFeQagojP8rr0e1sADzZH9mhzBu9iljpHdE9tvj3gP
        DI19u3M/JWozAJhKb9pDvYoYu4JSMsIaiCEFlCA=
X-Google-Smtp-Source: ANB0VdY8iVhx60AREHhsmBIYQ1xgyL0CGcW0r8rxvwYB/MG+QfEqJfmmpyBi1jkWKjpsnWSBD6mzwDbRslG4YT5cJF4=
X-Received: by 2002:a67:4e92:: with SMTP id j18-v6mr10071355vsg.91.1537368925306;
 Wed, 19 Sep 2018 07:55:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 07:54:44
 -0700 (PDT)
In-Reply-To: <CAKwvOd=d4FdFzqimdq1os4gkk2JeeC4_-_ZbxVdkkPwd3KmuuQ@mail.gmail.com>
References: <20180917073754.24048-1-joel@jms.id.au> <CAKwvOd=d4FdFzqimdq1os4gkk2JeeC4_-_ZbxVdkkPwd3KmuuQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 19 Sep 2018 23:54:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9L==YS0a7FwuHTVaft2ONGd1b=GVExRrCYeLzW0sasw@mail.gmail.com>
Message-ID: <CAK7LNAT9L==YS0a7FwuHTVaft2ONGd1b=GVExRrCYeLzW0sasw@mail.gmail.com>
Subject: Re: [PATCH] ftrace: Build with CPPFLAGS to get -Qunused-arguments
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joel Stanley <joel@jms.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-18 2:24 GMT+09:00 Nick Desaulniers <ndesaulniers@google.com>:
> On Mon, Sep 17, 2018 at 12:38 AM Joel Stanley <joel@jms.id.au> wrote:
>>
>> When building to record the mcount locations the kernel uses
>> KBUILD_CFLAGS but not KBUILD_CPPFLAGS. This means it lacks
>> -Qunused-arguments when building with clang, resulting in a lot of
>> noisy warnings.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>> Not sure why -Qunused-arguments is in CPP instead of KBUILD_CFLAGS. We
>> could instead put it in KBUILD_CFLAGS, and not need this patch.
>
> The preprocessor has flags that can change the definitions of macros.
> So there might be unused flags there.  I'm not a fan of covering up
> those warnings via -Qunused-arguments; the flags should be feature
> detected via cc-option and friends rather than always added then
> silenced if excessive.  That hides flags that are long dead/unused.
>
> Thanks for this patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>>
>>  scripts/Makefile.build | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>


Applied to linux-kbuild/fixes. Thanks!


-- 
Best Regards
Masahiro Yamada
