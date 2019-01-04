Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EBFC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA9121872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfADNQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:16:10 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44709 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfADNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:16:09 -0500
Received: by mail-vs1-f66.google.com with SMTP id z23so19387684vsj.11;
        Fri, 04 Jan 2019 05:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUyMoDxuZ6yoKv0F03DbklK9TVyNAAiXgKniFZO5fZU=;
        b=KbpV2rNEMSoqgWtTdu5mIr2PsWEhB51m6gg4tCaPyzoBUI+/vyMkf94RZo0Z87WmD1
         QOFDiW310pF63cCEmCipEKGwd/Odi6H+zSia3N3Yqgg+8oI+ptcMwGF+zuH3r+KmoYGn
         sPbWnfs+ja3yZQekp16REszWBEdWnfNsu2AjSEozxgD2XNT5GUuSj8EX0UUkCw+OyrP1
         oksCjfaBQMtQPQFfz1hfwW7cI1kB3kfyapBrrou0jXjAi5QI2bV+/95m08P5FhMttAKx
         9LRkkxCz8J4ebRbWn7GraYJ8Qty0B3hTebbL1f0MHZZp4AyrZvaCNHqTldLC+kvIYyKs
         PWwQ==
X-Gm-Message-State: AJcUukcfVOCC+CLu4UbY2v7fOKWuRW9R7Og1JXyiOkgtbTD/ar3twQTN
        Yd5V/3cQoV0D6/pvPVuVySAJ93cEm7vIDtxe9rM=
X-Google-Smtp-Source: AFSGD/UHsM7pqUyf7B+Eq+NIAKafdxFTk8undoyLecP69GiUb+z6jCMNvGzcBZyHJ53Q6yHKpvEZPlcSRZq31pfE65M=
X-Received: by 2002:a67:3885:: with SMTP id n5mr17941137vsi.96.1546607767983;
 Fri, 04 Jan 2019 05:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20180413090351.25662-1-anders.roxell@linaro.org>
 <20180607110911.12252-1-anders.roxell@linaro.org> <CADYN=9J=hSFb2wCZ1+dXL=023p9y05MEGUPvH48WfPX7XDZvwQ@mail.gmail.com>
 <f222aa8d-88b8-140c-30ed-83fd908bfd09@kernel.org> <CADYN=9LSA60E4mFwrbeY-RGi4kZV6hO0ygz0-C6QB3+KKaoxQg@mail.gmail.com>
 <3f332e65-0b33-9952-6aba-f9c8953a1f26@kernel.org> <CAK7LNAQ6hNmjmZc8J54KWCtR6x4Megn3mbdzprGgSZL5Zk9GCg@mail.gmail.com>
 <CADYN=9+mrrNN3m5FNCfiNC1ENe-aViYuGvmKsFOYdqMC2hMfAg@mail.gmail.com>
In-Reply-To: <CADYN=9+mrrNN3m5FNCfiNC1ENe-aViYuGvmKsFOYdqMC2hMfAg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Jan 2019 14:15:55 +0100
Message-ID: <CAMuHMdXeA0XBv-OTvcChCs3CHszkNB15R0FpOXMgQfjpfDcs-g@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: add headers_install to lib.mk
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <shuah@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Bamvor Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On Wed, Aug 8, 2018 at 12:46 PM Anders Roxell <anders.roxell@linaro.org> wrote:
> On Tue, 7 Aug 2018 at 04:33, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > 2018-08-07 2:03 GMT+09:00 Shuah Khan <shuah@kernel.org>:
> > > On 07/25/2018 10:08 AM, Anders Roxell wrote:
> > >> On Tue, 24 Jul 2018 at 19:11, Shuah Khan <shuah@kernel.org> wrote:
> > >>> On 07/23/2018 02:49 PM, Anders Roxell wrote:
> > >>>> On Thu, 7 Jun 2018 at 13:09, Anders Roxell <anders.roxell@linaro.org> wrote:
> > >>>>>
> > >>>>> If the kernel headers aren't installed we can't build all the tests.
> > >>>>> Add a new make target rule 'khdr' in the file lib.mk to generate the
> > >>>>> kernel headers and that gets include for every test-dir Makefile that
> > >>>>> includes lib.mk If the testdir in turn have its own sub-dirs the
> > >>>>> top_srcdir needs to be set to the linux-rootdir to be able to generate
> > >>>>> the kernel headers.
> > >>>>>
> > >>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > >>>>> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
> > >>>>> ---
> > >>>>>  Makefile                                           | 14 +-------------
> > >>>>>  scripts/subarch.include                            | 13 +++++++++++++
> > >>>>>  tools/testing/selftests/android/Makefile           |  2 +-
> > >>>>>  tools/testing/selftests/android/ion/Makefile       |  2 ++
> > >>>>>  tools/testing/selftests/futex/functional/Makefile  |  1 +
> > >>>>>  tools/testing/selftests/gpio/Makefile              |  7 ++-----
> > >>>>>  tools/testing/selftests/kvm/Makefile               |  7 ++-----
> > >>>>>  tools/testing/selftests/lib.mk                     | 12 ++++++++++++
> > >>>>>  tools/testing/selftests/net/Makefile               |  1 +
> > >>>>>  .../selftests/networking/timestamping/Makefile     |  1 +
> > >>>>>  tools/testing/selftests/vm/Makefile                |  4 ----
> > >>>>>  11 files changed, 36 insertions(+), 28 deletions(-)
> > >>>>>  create mode 100644 scripts/subarch.include
> > >>>>>
> > >>>>> diff --git a/Makefile b/Makefile
> > >>>>> index 6b9aea95ae3a..8050072300fa 100644
> > >>>>> --- a/Makefile
> > >>>>> +++ b/Makefile
> > >>>>> @@ -286,19 +286,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
> > >>>>>  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> > >>>>>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
> > >>>>>
> > >>>>> -# SUBARCH tells the usermode build what the underlying arch is.  That is set
> > >>>>> -# first, and if a usermode build is happening, the "ARCH=um" on the command
> > >>>>> -# line overrides the setting of ARCH below.  If a native build is happening,
> > >>>>> -# then ARCH is assigned, getting whatever value it gets normally, and
> > >>>>> -# SUBARCH is subsequently ignored.
> > >>>>> -
> > >>>>> -SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
> > >>>>> -                                 -e s/sun4u/sparc64/ \
> > >>>>> -                                 -e s/arm.*/arm/ -e s/sa110/arm/ \
> > >>>>> -                                 -e s/s390x/s390/ -e s/parisc64/parisc/ \
> > >>>>> -                                 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
> > >>>>> -                                 -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
> > >>>>> -                                 -e s/riscv.*/riscv/)
> > >>>>> +include scripts/subarch.include
> > >>>
> > >>> What is the reason for this SUBARCH block move to to scripts/subarch.include?
> > >>> Is this necessary for adding headers install dependency to lib.mk?
> > >>
> > >> This is needed to create headers for cross build.
> > >
> > > I am sorry for the delay on this patch. I am going to get this into 4.19.
> > > If anybody has objections, please let me.
> > >
> > > Anders! Will be able to rebase the patch and send me the latest. I think
> > > I have Acks from kvm, android, and vm so far.
> >
> > I may be missing something about the tools/ directory,
> > but why isn't it like this?
> >
> >
> > kselftest: headers_install
> >         $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
>
> That wont work if you cross compile, since you wont run the tests
> where you build them.

So why does a similar dependency work for samples in the main Makefile
(even listed twice!)?

    Documentation/ samples/: headers_install

    samples: headers_install

Or perhaps this also doesn't work?

> Then you can argue that we should break it up in a build and run rule.
> However, my understanding how people just build and run the the tests
> for that particular subsystem that they develop for, like:
> make -C tools/testing/selftests/<subsystem>/

I'm still a bit puzzled: how can you "build and run" the tests when
cross-compiling, as you don't run the tests where you build them?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
