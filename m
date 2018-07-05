Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C7C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF962405A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="d0eJKiB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF962405A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeGEJHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:07:20 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:49402 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbeGEJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:07:19 -0400
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com [209.85.213.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w65977kS030791;
        Thu, 5 Jul 2018 18:07:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w65977kS030791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530781628;
        bh=jVR//J3xdvI5vt+zVThklpAfInRNebJLd/G1vjpk8/k=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=d0eJKiB7azaVZkWwAG5hoTj9iX6bhl6/Hr5v6VtDPmKc4vwwMUkEwv3nMJGPdRHBG
         Hfgynz3eSFDRlFz/boppF2JZQHfevQvFOAY+35/t+0S52P0M0hOcLwIfXGA90OYBsk
         UNll/K5mAuyPJZ1ikUCA6Q6avEqGvCf8qH/F8iadGLMZJLzjoI/wqbjlcose8YcWSE
         NutsR7iEGU8gacYxDd2gaz9H9tUf4o2RymtGpM3rtzl3FY6aQ6p6epMw7D1krpXlAO
         JiYVOaB7ivLJ6VWDdMu8G310Z++LSseN8CTrf+2Ip3sv6VczEv0iUCqWyXYTbDGPJ1
         cxuY+cLyGbAFQ==
X-Nifty-SrcIP: [209.85.213.44]
Received: by mail-vk0-f44.google.com with SMTP id y70-v6so2132658vkc.0;
        Thu, 05 Jul 2018 02:07:08 -0700 (PDT)
X-Gm-Message-State: APt69E2REce4KiU+KDONsMikHRmY9uNZPIExGYAo/kWfS/SIPdJeXH9x
        ao9wWz8U4rWEUcfAlkBCghqmd8h+jztVCin+G7c=
X-Google-Smtp-Source: AAOMgpdtgRPdCAHvuYN8yUBl56gdAS3+j2MiXSBsEsdAvmVSnS2JVQ0f5NO8LZXVtv17mgNEoWNGinNwKUmhpmG2t7I=
X-Received: by 2002:a1f:d982:: with SMTP id q124-v6mr2849477vkg.166.1530781627202;
 Thu, 05 Jul 2018 02:07:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 02:06:26 -0700 (PDT)
In-Reply-To: <87po02zmxt.fsf@notabene.neil.brown.name>
References: <152929708853.17463.17302660556961083137.stgit@noble>
 <152929772052.17463.10728056000221362647.stgit@noble> <CAK7LNAR2n_Kf7HEwWgLwH8sjyVAiJUWkvV7ZAbkNn0KgVTUx1Q@mail.gmail.com>
 <87efgk0xx7.fsf@notabene.neil.brown.name> <CAK7LNAS22VUQytcX=BQt48qeAn9Rq00Sb555Gu98J+=8R_3OVA@mail.gmail.com>
 <87po02zmxt.fsf@notabene.neil.brown.name>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 5 Jul 2018 18:06:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9deaBb0aiFW+00G-S4FTVdN5GX-n3HbEUR07nzHQUmQ@mail.gmail.com>
Message-ID: <CAK7LNAT9deaBb0aiFW+00G-S4FTVdN5GX-n3HbEUR07nzHQUmQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] kbuild: disable KBUILD_MODNAME when building for mod.a
To:     NeilBrown <neilb@suse.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-05 6:54 GMT+09:00 NeilBrown <neilb@suse.com>:
> On Wed, Jul 04 2018, Masahiro Yamada wrote:
>
>> 2018-07-04 7:14 GMT+09:00 NeilBrown <neilb@suse.com>:
>>>
>>> Where I've been using these patches I've sometimes been adding
>>>
>>>   ccflags-y += -DKBUILD_MODNAME='"FOO"'
>>>
>>> to Makefiles so that modules_params get handled correctly on non-module
>>> builds.  I've thought about instead allowing "modobj-name" to be defined
>>> and requiring that it be set if either modobj-[yn] is set.  Then it gets
>>> used for the KBUILD_MODNAME when building modobj modules.
>>>
>>> Would you prefer to always require KBUILD_MODNAME, or to use a default
>>> name for dynamic-debug?
>>>
>>> Thanks,
>>> NeilBrown
>>
>>
>> I prefer flat directory structure for modules.
>> Most of modules fit in a single directory.
>
> I'd prefer that too in general.
> But some modules are bigger than others and some times it helps to
> sub-divide a module.
> xfs, btrfs, ceph, net/dccp, and lustre all already use multiple
> directories despite the poor support, so clearly some developers
> like a more structured approach to organizing their code.
> Wouldn't it be good to allow them to make full use of the kbuild system?


xfs is quite big, but the others are not too bad.
You can collect files into a single directory if you want.
If you mind the namespace, one tip might be to group files with prefix.
For example,

  drivers/btrfs/tests/foo.o  ->  drivers/btrfs/test-foo.o

I do not want to introduce a mess to core build scripts.


> Thanks,
> NeilBrown



-- 
Best Regards
Masahiro Yamada
