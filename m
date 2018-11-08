Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40902C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C4A2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C4A2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeKHUFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:05:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45740 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHUFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:05:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id d135so25496164qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 02:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxL2C1J0oBQd2bdhWgmhIQm68wlwbgN3ZzYAllO3X1Q=;
        b=npC+jekIlKlhd4mm8u5g8OVYiSwVcitbB3h/K/kIR6JcIfwtAp8db51LYDC+fJVBmt
         rj8NHj5hVyoSQHU7vazxj2B0dfKwO3f+cSLp+mVYhjjxzM6j+FIS0hFOLd8AFPgmjijY
         Tlt3l46yBE0UqnnERSokIMSATpvCkY1MUxWC213eT8EJqOHSWb1Zdmg4cWKk1X0Fsyaz
         i4HxCzpS9RjrdV2vhOLEIJD6gTyevXodb7dFu+51gmqpu/3YQF+d9NVs9BIu0oIk7Ost
         SLNApE+fgZxPYmdu/ijv+l4KWF2MgJssNSzqMIRotHG8bpio/G8hcEIRQUo0vKmT1NCk
         fbpw==
X-Gm-Message-State: AGRZ1gJKN//EMplDcd+5LmCyBu2AVE6aescEPnCGwK5xjxYskgDWFXYE
        kSKYp6fApYjUf6nFulRRMRmqCOqG5Ev5xRC9b3o=
X-Google-Smtp-Source: AJdET5cq4vS/qiYe2qnxe5I9EUNRCBdr816uNo1w7fOUfERq6sDJ+TF+i6exrKwmpHR5hcsE0sbKBq+YnN5KpYUaTw4=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr3727905qvm.149.1541673021780;
 Thu, 08 Nov 2018 02:30:21 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a30Dmq3vp-+=jvVu8VMe+GKc9dU=+ZF0rzhFiUq2NuJ_w@mail.gmail.com>
 <mhng-23f94805-b961-4e68-a4c1-7d79b60bd925@palmer-si-x1c4>
In-Reply-To: <mhng-23f94805-b961-4e68-a4c1-7d79b60bd925@palmer-si-x1c4>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Nov 2018 11:30:02 +0100
Message-ID: <CAK8P3a2468O=MVXVaZ8_Vq6DuOYV2iwR98upqpWOH67z9Gh-6Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: add asm/unistd.h UAPI header
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 3:10 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 07 Nov 2018 13:09:39 PST (-0800), Arnd Bergmann wrote:
> > On Wed, Nov 7, 2018 at 7:30 PM David Abdurachmanov
> > <david.abdurachmanov@gmail.com> wrote:
> >> On Wed, Nov 7, 2018 at 1:08 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >> > On Mon, 05 Nov 2018 12:56:15 PST (-0800), Arnd Bergmann wrote:
> >
> >> > The target is still the next glibc release (Feb 1st) for a stable RV32I ABI.
> >> > That's progressing well, with one last blocking issue related to some of our
> >> > floating-point emulation routines before we can submit the port.  This should
> >> > give us ample time to line up the ABIs correctly so everything works.
> >> >
> >> > So I think the correct answer here is to drop __ARCH_WANT_STAT64 from RISC-V.
> >> >
> >>
> >> Then if you agree I could do and send v2:
> >>
> >> +#ifdef __LP64__
> >> +#define __ARCH_WANT_NEW_STAT
> >> +#endif /* __LP64__ */
> >
> > Looks good to me.
>
> This is a bit pedantic, but I'm not sure what the right answer is here:
> "-march=rv64gc -mabi=ilp32d" will not define __LP64__, but will define
> "__riscv_xlen == 64".  I actually don't know enough about how an rv64gc/ilp32d
> ABI would work to answer this: would we have "long long" all over our syscalls?
>
> Probably not worth worrying about for now, as we'll have to go audit all of
> these if we ever end up with an ilp32 ABI.  So just go for it and we'll throw
> this on the pile to deal with later :)

Short answer: it doesn't matter because an ilp32d ABI would use neither
newstat nor stat64, it would only need statx().

Long answer: We've gone through multiple iterations on the question.
x86 uses long long in syscall interfaces and tries to reuse the native
64-bit syscalls as much as possible. This turned out to cause endless
problems, so for the (never merged but still kept around as a patchset)
arm64 ABI, we went the opposite way, and made the syscalls use the
same ABI as the arm32 mode.

From the experience with both of the above, I'd say if you end up
having to do it, use the same method as arm64, but try to resist
doing it at all. Unlike arm64 and x86-64, there is no inherent benefit
to using the 64-bit instruction set (doubled register number etc),
so compared to the normal lp64 ABI you only gain a little dcache
space for the smaller pointers at the cost of a smaller address
space. For you as a maintainer however, the cost of supporting this
mode is that you are stuck with three user space ABIs instead of
just two (normal 32-bit and 64-bit).
If anyone really wants to run 32-bit code, they need a CPU that
allows switching modes.

       Arnd
