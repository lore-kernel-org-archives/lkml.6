Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E170C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A208021737
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACoIEqUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A208021737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeHHNDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:03:50 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46031 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeHHNDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:03:50 -0400
Received: by mail-yw1-f68.google.com with SMTP id 139-v6so1164121ywg.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 03:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wu2MRrcrGcbgt6W0pjTJsNIix2PeEglsbFDD6rFfkbw=;
        b=ACoIEqUDsJvG3NeAJKwBDjCVxoN8jBJIkTm331xnJ5jxweqySWrCTxnALM0PKtRdbO
         Dk4CcF6dWbCjXSXhSsUzfOF6rSphWj4q29idPzyLM29WnQF3sEErunrg/HKqM3PDuyYm
         HlDFCMdXVg9Etavk/8cdMqS5qXYOYRPE4thAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wu2MRrcrGcbgt6W0pjTJsNIix2PeEglsbFDD6rFfkbw=;
        b=RkBCarwEF5CUuVZFP+rnABHC704Ca7GVZzrbuv9ClexUCmdjCaYRaA8PKtxqVzsCkd
         8WHFJ8vpAP0blS7DyNOHol5D/8jVViZEQl99Ma1hp5rNBgsFxy4qza+UB48BISkDrt6x
         zb8Kc9UYXAvztDtb68iuJLcw3WESS8gA1CFbetzwhLajZ2vWw3sV4bPwHkmQPhu6UVuh
         eWL3oh9LlXYYkYBwfMYGxm349FcBYJwg392Mzg1DBLbrudLIs9QpfhmfEXuzwoBEY0rg
         k8KpArEvrJegKefIyKfl/f13f710uQ9F2NdRcctw/mstMbsY2AuoHEuym8nRpYBijveK
         A3Gg==
X-Gm-Message-State: AOUpUlFzsJ7msD+G+iRhYnPW3kMmVB2T1V2nbeAC/7SuYfxjuxd/lKFl
        59W216ZNJP3iChp1TkxBiyo0vy6y4+qE2JUwFVoOOw==
X-Google-Smtp-Source: AA+uWPwkwq4gpqLteI2L4G2RqGfnNd1Hmo/r2U/+gHCb4dhgMQYK51WIV4niZbKmxtzxfXrfNX5ByJkxzTrfu/ifmhc=
X-Received: by 2002:a81:ae61:: with SMTP id g33-v6mr1114942ywk.74.1533725082354;
 Wed, 08 Aug 2018 03:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180413090351.25662-1-anders.roxell@linaro.org>
 <20180607110911.12252-1-anders.roxell@linaro.org> <CADYN=9J=hSFb2wCZ1+dXL=023p9y05MEGUPvH48WfPX7XDZvwQ@mail.gmail.com>
 <f222aa8d-88b8-140c-30ed-83fd908bfd09@kernel.org> <CADYN=9LSA60E4mFwrbeY-RGi4kZV6hO0ygz0-C6QB3+KKaoxQg@mail.gmail.com>
 <3f332e65-0b33-9952-6aba-f9c8953a1f26@kernel.org> <CAK7LNAQ6hNmjmZc8J54KWCtR6x4Megn3mbdzprGgSZL5Zk9GCg@mail.gmail.com>
In-Reply-To: <CAK7LNAQ6hNmjmZc8J54KWCtR6x4Megn3mbdzprGgSZL5Zk9GCg@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 8 Aug 2018 12:44:31 +0200
Message-ID: <CADYN=9+mrrNN3m5FNCfiNC1ENe-aViYuGvmKsFOYdqMC2hMfAg@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: add headers_install to lib.mk
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Bamvor Zhang <bamv2005@gmail.com>, brgl@bgdev.pl,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, aarcange@redhat.com,
        linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018 at 04:33, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> 2018-08-07 2:03 GMT+09:00 Shuah Khan <shuah@kernel.org>:
> > Hi Anders,
> >
> > On 07/25/2018 10:08 AM, Anders Roxell wrote:
> >> On Tue, 24 Jul 2018 at 19:11, Shuah Khan <shuah@kernel.org> wrote:
> >>>
> >>> On 07/23/2018 02:49 PM, Anders Roxell wrote:
> >>>> On Thu, 7 Jun 2018 at 13:09, Anders Roxell <anders.roxell@linaro.org> wrote:
> >>>>>
> >>>>> If the kernel headers aren't installed we can't build all the tests.
> >>>>> Add a new make target rule 'khdr' in the file lib.mk to generate the
> >>>>> kernel headers and that gets include for every test-dir Makefile that
> >>>>> includes lib.mk If the testdir in turn have its own sub-dirs the
> >>>>> top_srcdir needs to be set to the linux-rootdir to be able to generate
> >>>>> the kernel headers.
> >>>>>
> >>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >>>>> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
> >>>>> ---
> >>>>>  Makefile                                           | 14 +-------------
> >>>>>  scripts/subarch.include                            | 13 +++++++++++++
> >>>>>  tools/testing/selftests/android/Makefile           |  2 +-
> >>>>>  tools/testing/selftests/android/ion/Makefile       |  2 ++
> >>>>>  tools/testing/selftests/futex/functional/Makefile  |  1 +
> >>>>>  tools/testing/selftests/gpio/Makefile              |  7 ++-----
> >>>>>  tools/testing/selftests/kvm/Makefile               |  7 ++-----
> >>>>>  tools/testing/selftests/lib.mk                     | 12 ++++++++++++
> >>>>>  tools/testing/selftests/net/Makefile               |  1 +
> >>>>>  .../selftests/networking/timestamping/Makefile     |  1 +
> >>>>>  tools/testing/selftests/vm/Makefile                |  4 ----
> >>>>>  11 files changed, 36 insertions(+), 28 deletions(-)
> >>>>>  create mode 100644 scripts/subarch.include
> >>>>>
> >>>>> diff --git a/Makefile b/Makefile
> >>>>> index 6b9aea95ae3a..8050072300fa 100644
> >>>>> --- a/Makefile
> >>>>> +++ b/Makefile
> >>>>> @@ -286,19 +286,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
> >>>>>  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> >>>>>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
> >>>>>
> >>>>> -# SUBARCH tells the usermode build what the underlying arch is.  That is set
> >>>>> -# first, and if a usermode build is happening, the "ARCH=um" on the command
> >>>>> -# line overrides the setting of ARCH below.  If a native build is happening,
> >>>>> -# then ARCH is assigned, getting whatever value it gets normally, and
> >>>>> -# SUBARCH is subsequently ignored.
> >>>>> -
> >>>>> -SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
> >>>>> -                                 -e s/sun4u/sparc64/ \
> >>>>> -                                 -e s/arm.*/arm/ -e s/sa110/arm/ \
> >>>>> -                                 -e s/s390x/s390/ -e s/parisc64/parisc/ \
> >>>>> -                                 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
> >>>>> -                                 -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
> >>>>> -                                 -e s/riscv.*/riscv/)
> >>>>> +include scripts/subarch.include
> >>>
> >>> What is the reason for this SUBARCH block move to to scripts/subarch.include?
> >>> Is this necessary for adding headers install dependency to lib.mk?
> >>
> >> This is needed to create headers for cross build.
> >>
> >
> > I am sorry for the delay on this patch. I am going to get this into 4.19.
> > If anybody has objections, please let me.
> >
> > Anders! Will be able to rebase the patch and send me the latest. I think
> > I have Acks from kvm, android, and vm so far.
> >
>
>
> I may be missing something about the tools/ directory,
> but why isn't it like this?
>
>
> kselftest: headers_install
>         $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests

That wont work if you cross compile, since you wont run the tests
where you build them.
Then you can argue that we should break it up in a build and run rule.
However, my understanding how people just build and run the the tests
for that particular subsystem that they develop for, like:
make -C tools/testing/selftests/<subsystem>/

Cheers,
Anders
