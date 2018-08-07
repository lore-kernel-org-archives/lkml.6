Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22421C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B441821A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WlGnooNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B441821A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeHGEpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:45:22 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:53340 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeHGEpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:45:22 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w772X71u015942;
        Tue, 7 Aug 2018 11:33:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w772X71u015942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533609188;
        bh=9uOxmyNr2bnD37+eNXGHepBEU8yf+fwzMZSlj7aiuL0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WlGnooNxshlCkdtkSWQLeAft3g53TEhEHatByu4d/h6SzF504kT3YRwctHpIziaon
         3xp5RxDKVUPJu5Z/hu1VO5XuA71Kld1dTLMRqu2cR/8Yhique8nIh2IjXptr3SQPM3
         6e4q/zxCAV28g2gCqb75h2QzWMIIgiHCGwxNlo532zzIjekFYytDHIGIXeZTCTUTP5
         kru2czE0oQ5ry/2+S+Fg0sjVC/cRXtIIhyeioXszlGnlnzgBEzAnabFqeq2XlyR9Yk
         egQQodrjJKke83zlNhZvozyXaiUhySWZWTnaMwMGDTO7b7Y26PxkNi7aDvbl97Vs2U
         aEItVJ+HjxLtA==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id o11-v6so14483871uak.5;
        Mon, 06 Aug 2018 19:33:08 -0700 (PDT)
X-Gm-Message-State: AOUpUlHW5L2/l49iUUEISmSk5rVHM4LEfZkfonzhJ4iaz+Ch8uLdzJgH
        eseKgc35ASgvdu9Q212jLtfvdYynuDnaK8anMTA=
X-Google-Smtp-Source: AAOMgpezI+yeNtDdggcyLuk7M+/74R6kvODTjNtdcUkRXxYzecQB49LAQ6P6mmCuqY7XN8AGEnFGKrJRasVW5gZ1NMk=
X-Received: by 2002:a1f:968f:: with SMTP id y137-v6mr10893838vkd.55.1533609187247;
 Mon, 06 Aug 2018 19:33:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 19:32:26 -0700 (PDT)
In-Reply-To: <3f332e65-0b33-9952-6aba-f9c8953a1f26@kernel.org>
References: <20180413090351.25662-1-anders.roxell@linaro.org>
 <20180607110911.12252-1-anders.roxell@linaro.org> <CADYN=9J=hSFb2wCZ1+dXL=023p9y05MEGUPvH48WfPX7XDZvwQ@mail.gmail.com>
 <f222aa8d-88b8-140c-30ed-83fd908bfd09@kernel.org> <CADYN=9LSA60E4mFwrbeY-RGi4kZV6hO0ygz0-C6QB3+KKaoxQg@mail.gmail.com>
 <3f332e65-0b33-9952-6aba-f9c8953a1f26@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 7 Aug 2018 11:32:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ6hNmjmZc8J54KWCtR6x4Megn3mbdzprGgSZL5Zk9GCg@mail.gmail.com>
Message-ID: <CAK7LNAQ6hNmjmZc8J54KWCtR6x4Megn3mbdzprGgSZL5Zk9GCg@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: add headers_install to lib.mk
To:     Shuah Khan <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Bamvor Zhang <bamv2005@gmail.com>, brgl@bgdev.pl,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-07 2:03 GMT+09:00 Shuah Khan <shuah@kernel.org>:
> Hi Anders,
>
> On 07/25/2018 10:08 AM, Anders Roxell wrote:
>> On Tue, 24 Jul 2018 at 19:11, Shuah Khan <shuah@kernel.org> wrote:
>>>
>>> On 07/23/2018 02:49 PM, Anders Roxell wrote:
>>>> On Thu, 7 Jun 2018 at 13:09, Anders Roxell <anders.roxell@linaro.org> wrote:
>>>>>
>>>>> If the kernel headers aren't installed we can't build all the tests.
>>>>> Add a new make target rule 'khdr' in the file lib.mk to generate the
>>>>> kernel headers and that gets include for every test-dir Makefile that
>>>>> includes lib.mk If the testdir in turn have its own sub-dirs the
>>>>> top_srcdir needs to be set to the linux-rootdir to be able to generate
>>>>> the kernel headers.
>>>>>
>>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>>>> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
>>>>> ---
>>>>>  Makefile                                           | 14 +-------------
>>>>>  scripts/subarch.include                            | 13 +++++++++++++
>>>>>  tools/testing/selftests/android/Makefile           |  2 +-
>>>>>  tools/testing/selftests/android/ion/Makefile       |  2 ++
>>>>>  tools/testing/selftests/futex/functional/Makefile  |  1 +
>>>>>  tools/testing/selftests/gpio/Makefile              |  7 ++-----
>>>>>  tools/testing/selftests/kvm/Makefile               |  7 ++-----
>>>>>  tools/testing/selftests/lib.mk                     | 12 ++++++++++++
>>>>>  tools/testing/selftests/net/Makefile               |  1 +
>>>>>  .../selftests/networking/timestamping/Makefile     |  1 +
>>>>>  tools/testing/selftests/vm/Makefile                |  4 ----
>>>>>  11 files changed, 36 insertions(+), 28 deletions(-)
>>>>>  create mode 100644 scripts/subarch.include
>>>>>
>>>>> diff --git a/Makefile b/Makefile
>>>>> index 6b9aea95ae3a..8050072300fa 100644
>>>>> --- a/Makefile
>>>>> +++ b/Makefile
>>>>> @@ -286,19 +286,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
>>>>>  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
>>>>>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
>>>>>
>>>>> -# SUBARCH tells the usermode build what the underlying arch is.  That is set
>>>>> -# first, and if a usermode build is happening, the "ARCH=um" on the command
>>>>> -# line overrides the setting of ARCH below.  If a native build is happening,
>>>>> -# then ARCH is assigned, getting whatever value it gets normally, and
>>>>> -# SUBARCH is subsequently ignored.
>>>>> -
>>>>> -SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
>>>>> -                                 -e s/sun4u/sparc64/ \
>>>>> -                                 -e s/arm.*/arm/ -e s/sa110/arm/ \
>>>>> -                                 -e s/s390x/s390/ -e s/parisc64/parisc/ \
>>>>> -                                 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
>>>>> -                                 -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
>>>>> -                                 -e s/riscv.*/riscv/)
>>>>> +include scripts/subarch.include
>>>
>>> What is the reason for this SUBARCH block move to to scripts/subarch.include?
>>> Is this necessary for adding headers install dependency to lib.mk?
>>
>> This is needed to create headers for cross build.
>>
>
> I am sorry for the delay on this patch. I am going to get this into 4.19.
> If anybody has objections, please let me.
>
> Anders! Will be able to rebase the patch and send me the latest. I think
> I have Acks from kvm, android, and vm so far.
>


I may be missing something about the tools/ directory,
but why isn't it like this?


kselftest: headers_install
        $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests







-- 
Best Regards
Masahiro Yamada
