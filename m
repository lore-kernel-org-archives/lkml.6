Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC12C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859F820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="J27Iqbg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859F820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbeGWCzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 22:55:43 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:44677 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbeGWCzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 22:55:43 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jul 2018 22:55:41 EDT
Received: from mail-ua0-f171.google.com (mail-ua0-f171.google.com [209.85.217.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w6N1ubR6003183;
        Mon, 23 Jul 2018 10:56:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w6N1ubR6003183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532310997;
        bh=m+6ekxUrAqgLZfKoB5OPOVwpAQnkaLEUBbnlNdrghVg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=J27Iqbg273Pg8ljtsvmY6q7ER8kESDyFYS96JEjPIMqrAMStqZ8Fg/8JqDK6oB0r6
         rqMbIh7Cm5fKIMl1yf1Uy3esXvC7qmf9xAIHidhsGKJBbj9gTLoqNs02FDz7r+3ru/
         /Sswac4qKLL7CzOOU7Wr3OV+x5XiSQDe8Pxmw20LVqtTo8Eb1Ual2Bzgh6O0TyRmvI
         of4M8oupUCvKGKIwsKw4r0opn98od6QooayRRE5up87l/Mh6U/MlFBIZVo/Sa3oCbR
         PdBURxAEoLT/AKE22XL08bDU1IZw7NsSJ68ASw1koc1HGvHcB+wl62tnpSBfgGhRiX
         pmNm1wS9vuN5g==
X-Nifty-SrcIP: [209.85.217.171]
Received: by mail-ua0-f171.google.com with SMTP id x24-v6so10765419ual.10;
        Sun, 22 Jul 2018 18:56:37 -0700 (PDT)
X-Gm-Message-State: AOUpUlEGBT1MVBeXDryqZ9/KEBCUawcTiloCY/IJ8wQySsUn4tbE0Ugi
        rN3ZdmON3bHlyEvi92cL2mERBrhDz4e+6IMrxaE=
X-Google-Smtp-Source: AAOMgpe/RVCT6ZZXIe/OrvrY7yQMStSelaYDhmva/KEibEbjlm04+sqbk+q6QykgRFWiE2Fk/yXvyh0NmxQ62AXiHdQ=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr7300449uaf.199.1532310996319;
 Sun, 22 Jul 2018 18:56:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 18:55:55
 -0700 (PDT)
In-Reply-To: <CAGXu5jK4q6HLDZ6jokTeDABbzVasY85Jo0HFNKYeaKWZYPjPKg@mail.gmail.com>
References: <1531935483-30784-1-git-send-email-s.mesoraca16@gmail.com> <CAGXu5jK4q6HLDZ6jokTeDABbzVasY85Jo0HFNKYeaKWZYPjPKg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 23 Jul 2018 10:55:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyzWvJ6Bf1Zp4k=B-QFOHEg7YqeFErA2Gg9PNZadvuew@mail.gmail.com>
Message-ID: <CAK7LNASyzWvJ6Bf1Zp4k=B-QFOHEg7YqeFErA2Gg9PNZadvuew@mail.gmail.com>
Subject: Re: [RFC] kconfig: add hardened defconfig helpers
To:     Kees Cook <keescook@chromium.org>
Cc:     Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-20 14:15 GMT+09:00 Kees Cook <keescook@chromium.org>:
> +lkml, Masahiro, and linux-doc, just for wider review/thoughts.


I do not subscribe to kernel-hardening ML.

I do not see the original patch in lkml or kbuild/kconfig ML.


> On Wed, Jul 18, 2018 at 10:38 AM, Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
>> Adds 4 new defconfig helpers (hardenedlowconfig,
>> hardenedmediumconfig, hardenedhighconfig,
>> hardenedextremeconfig) to enable various hardening
>> features.
>> The list of config options to enable is based on
>> KSPP's Recommended Settings[1] and on
>> kconfig-hardened-check[2], with some modifications.
>> These options are divided into 4 levels (low, medium,
>> high, extreme) based on their negative side effects, not
>> on their usefulness.
>> 'Low' level collects all those protections that have
>> (almost) no negative side effects.
>
> Likely the "Low" should be on-by-default already, but it's easier to
> bike-shed that separately. :)
>
>> 'Extreme' level collects those protections that may have
>> some many negative side effects that most people
>> wouldn't want to enable them.
>> Every feature in each level is briefly documented in
>> Documentation/security/hardenedconfig.rst, this file
>> also contain a better explanation of what every level
>> means.
>> To prevent this file from drifting from what the various
>> defconfigs actually do, it is used to dynamically
>> generate the config fragments.
>
> I like that the configs are generated from the docs! This makes things
> very sane to update.
>
>>
>> [1] http://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings
>> [2] https://github.com/a13xp0p0v/kconfig-hardened-check
>>
>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>> ---
>>  .gitignore                                 |    6 +
>>  Documentation/security/hardenedconfig.rst  | 1027 ++++++++++++++++++++++++++++
>>  Documentation/security/index.rst           |    1 +
>>  Makefile                                   |    6 +-
>>  scripts/kconfig/Makefile                   |   72 +-
>>  scripts/kconfig/build_hardened_fragment.sh |   54 ++
>>  6 files changed, 1143 insertions(+), 23 deletions(-)
>>  create mode 100644 Documentation/security/hardenedconfig.rst
>>  create mode 100755 scripts/kconfig/build_hardened_fragment.sh
>>

-- 
Best Regards
Masahiro Yamada
