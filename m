Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83F6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7E920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="barrJS+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7E920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbeGYRUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:20:50 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42104 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbeGYRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:20:49 -0400
Received: by mail-yw0-f196.google.com with SMTP id y203-v6so3047091ywd.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0TWKqkF+3mDOHQcx4WLIh/IEJGCqlqopmSchDYFJGI=;
        b=barrJS+Y7+cYykEZRirGVaK0a6GUqNaUzj4wTlUofVu6jM81m/qP6tPqOJFeFvd3j5
         tt0GgdvPy5lDXrByv6x42Tx+hAUg+M0zzfUwBvuMfhgLIW/aO94fxJEQoJXfEFBf9nMf
         McH6QWZeh7oW7J8Srb678PmG7FEW4EYkPXwBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0TWKqkF+3mDOHQcx4WLIh/IEJGCqlqopmSchDYFJGI=;
        b=hPapJdhPuC9aHjXRIy04OvfWXkRPCCCBVU944aSF8Z+rTP5UPowTf4PfxsRw8xu0uH
         5WDE2yYAsCe+TCT714uHxmbJOdEg5JoVwgTONnjihgiBZl7F0A+z23tnwINgKqyIu7ey
         YjHg/P/ylqWRygD0+wZB8Wogai6soR0HcXy7vYhHyTRfTciViIsIf59YMLGnYJHXS2lI
         cJlbnLOeE/BsctI1tYMjZe2ogRa1Zjj/zyRDAIcqvMaMnOegUzJBrWGsL3jqCxUxJWkV
         +oGEUb/RQJsVwpgvkklrF7FNGV/V8hs94JfXjiZuWj3kFhR+/PUU8lZ98uemoBSEbpvF
         VeFg==
X-Gm-Message-State: AOUpUlGBDpNGZz0Cr2o1oJ9SEksD+nL2w1n5hIjwSzqNlEsOPd87lZ4D
        3ElIjZTkx1fa3phgT7mJ3LyzTgstxIA8f2ioNz3xtA==
X-Google-Smtp-Source: AAOMgpe2OEtvE5Y2/oPJvvhgpKPPgtfG+zmvf0RscIeN9iraGqO/7iNWPMCiiKUWRGvdf883MOX4+0R1pCpTzILIyNM=
X-Received: by 2002:a0d:f704:: with SMTP id h4-v6mr11160932ywf.240.1532534908784;
 Wed, 25 Jul 2018 09:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180413090351.25662-1-anders.roxell@linaro.org>
 <20180607110911.12252-1-anders.roxell@linaro.org> <CADYN=9J=hSFb2wCZ1+dXL=023p9y05MEGUPvH48WfPX7XDZvwQ@mail.gmail.com>
 <f222aa8d-88b8-140c-30ed-83fd908bfd09@kernel.org>
In-Reply-To: <f222aa8d-88b8-140c-30ed-83fd908bfd09@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 25 Jul 2018 18:08:17 +0200
Message-ID: <CADYN=9LSA60E4mFwrbeY-RGi4kZV6hO0ygz0-C6QB3+KKaoxQg@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: add headers_install to lib.mk
To:     Shuah Khan <shuah@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Tue, 24 Jul 2018 at 19:11, Shuah Khan <shuah@kernel.org> wrote:
>
> On 07/23/2018 02:49 PM, Anders Roxell wrote:
> > On Thu, 7 Jun 2018 at 13:09, Anders Roxell <anders.roxell@linaro.org> wrote:
> >>
> >> If the kernel headers aren't installed we can't build all the tests.
> >> Add a new make target rule 'khdr' in the file lib.mk to generate the
> >> kernel headers and that gets include for every test-dir Makefile that
> >> includes lib.mk If the testdir in turn have its own sub-dirs the
> >> top_srcdir needs to be set to the linux-rootdir to be able to generate
> >> the kernel headers.
> >>
> >> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
> >> ---
> >>  Makefile                                           | 14 +-------------
> >>  scripts/subarch.include                            | 13 +++++++++++++
> >>  tools/testing/selftests/android/Makefile           |  2 +-
> >>  tools/testing/selftests/android/ion/Makefile       |  2 ++
> >>  tools/testing/selftests/futex/functional/Makefile  |  1 +
> >>  tools/testing/selftests/gpio/Makefile              |  7 ++-----
> >>  tools/testing/selftests/kvm/Makefile               |  7 ++-----
> >>  tools/testing/selftests/lib.mk                     | 12 ++++++++++++
> >>  tools/testing/selftests/net/Makefile               |  1 +
> >>  .../selftests/networking/timestamping/Makefile     |  1 +
> >>  tools/testing/selftests/vm/Makefile                |  4 ----
> >>  11 files changed, 36 insertions(+), 28 deletions(-)
> >>  create mode 100644 scripts/subarch.include
> >>
> >> diff --git a/Makefile b/Makefile
> >> index 6b9aea95ae3a..8050072300fa 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -286,19 +286,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
> >>  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> >>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
> >>
> >> -# SUBARCH tells the usermode build what the underlying arch is.  That is set
> >> -# first, and if a usermode build is happening, the "ARCH=um" on the command
> >> -# line overrides the setting of ARCH below.  If a native build is happening,
> >> -# then ARCH is assigned, getting whatever value it gets normally, and
> >> -# SUBARCH is subsequently ignored.
> >> -
> >> -SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
> >> -                                 -e s/sun4u/sparc64/ \
> >> -                                 -e s/arm.*/arm/ -e s/sa110/arm/ \
> >> -                                 -e s/s390x/s390/ -e s/parisc64/parisc/ \
> >> -                                 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
> >> -                                 -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
> >> -                                 -e s/riscv.*/riscv/)
> >> +include scripts/subarch.include
>
> What is the reason for this SUBARCH block move to to scripts/subarch.include?
> Is this necessary for adding headers install dependency to lib.mk?

This is needed to create headers for cross build.

Cheers,
Anders
