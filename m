Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13F7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B6E20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KipjezCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B6E20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbeGaPCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:02:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33026 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732110AbeGaPCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:02:34 -0400
Received: by mail-it0-f67.google.com with SMTP id d16-v6so12403125itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cea+QR7vUGrYbV9TxX260FtXaToZOEPmUQN4XnVEkac=;
        b=KipjezCBn97Bs0JcB/3ZkpKqnOyk+Mxcg0LZR9VjRvBpSGmrv7WaXIz+KfUr9E+ZSY
         NHpyEuveDlYEUCM4oYlgcCUHoxpas1VE7wUv7WOd6NroUEWLJ75dQixuRMwA1owrnzDY
         bbi0zzbitadrNP7Bkg4d9BiVoddhMbRt77tVgh19caUbYC906FLo1jy6XZfQCvxeH4Oo
         dax56RdTglck+8l96reCfBSaTDyq1jnTf7ozbwOvEB8pMjdSVD2ezMd7U30dI5ttIpdm
         cHj857t42Zq765ALth03QoB7cVIPw+IXloGMN+vGwstLVElndIrhno6lHmfaRCLKirxl
         vRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cea+QR7vUGrYbV9TxX260FtXaToZOEPmUQN4XnVEkac=;
        b=APxy+09UvBZvMzrhRIM98uW9NuMIgJnFBqtoytMHLPlQ64UlN4+0TygDd2WGH2v6lu
         BO3mwLy4NMbs3pcjF09y/h0TsZb0ih7efg4oJBbuDq5kvQ5E5G0IlX/yrXGcTULktVPl
         vbnVc/Y52ZR18PPkazrw+84bh5hvaFf1PTL6xUgT8mnQr8ueZYVi8CnTH7K5OcbD19Qq
         pdfd4zzCLtI92mYSaJcSx/gv+XubqCgoURMg94hhbUwC0m1Q+ChjheB3EVj3AUTTqnJu
         bNUtqEXjIb/ANpqDAIP76Yxh00OzT0Q2tNtqaepp1vnEQvcz14niNXnrM37GlhOpqxTp
         /cLA==
X-Gm-Message-State: AOUpUlGCrOwf/urMtZ3EdjqI2Lw15ET2xSj4CpZIPRIFLYqeWC0O/P7B
        14vZTjuszM2Xbn8U8uIqVEIG5TNiiQTPsfjep5mH2A==
X-Google-Smtp-Source: AAOMgpcTqetMxXwG6tKGKsyOX3JweITjOUfA66vI84o5nQWcIwS/DS0jIKGs/SLuDUGpJh1Qs/i46/NRVXxQuEHJjV0=
X-Received: by 2002:a02:9962:: with SMTP id d31-v6mr20393986jak.1.1533043334704;
 Tue, 31 Jul 2018 06:22:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:918c:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 06:22:13
 -0700 (PDT)
In-Reply-To: <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com> <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com> <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com> <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 31 Jul 2018 15:22:13 +0200
Message-ID: <CAAeHK+xc1E64tXEEHoXqOuUNZ7E_kVyho3_mNZTCc+LTGHYFdA@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
To:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 7:16 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Tue, Jul 3, 2018 at 7:36 PM, Will Deacon <will.deacon@arm.com> wrote:
>> Hmm, but elsewhere in this thread, Evgenii is motivating the need for this
>> patch set precisely because the lower overhead means it's suitable for
>> "near-production" use. So I don't think writing this off as a debugging
>> feature is the right approach, and we instead need to put effort into
>> analysing the impact of address tags on the kernel as a whole. Playing
>> whack-a-mole with subtle tag issues sounds like the worst possible outcome
>> for the long-term.
>
> I don't see a way to find cases where pointer tags would matter
> statically, so I've implemented the dynamic approach that I mentioned
> above. I've instrumented all pointer comparisons/subtractions in an
> LLVM compiler pass and used a kernel module that would print a bug
> report whenever two pointers with different tags are being
> compared/subtracted (ignoring comparisons with NULL pointers and with
> pointers obtained by casting an error code to a pointer type). Then I
> tried booting the kernel in QEMU and on an Odroid C2 board and I ran
> syzkaller overnight.
>
> This yielded the following results.
>
> ======
>
> The two places that look interesting are:
>
> is_vmalloc_addr in include/linux/mm.h (already mentioned by Catalin)
> is_kernel_rodata in mm/util.c
>
> Here we compare a pointer with some fixed untagged values to make sure
> that the pointer lies in a particular part of the kernel address
> space. Since KWHASAN doesn't add tags to pointers that belong to
> rodata or vmalloc regions, this should work as is. To make sure I've
> added debug checks to those two functions that check that the result
> doesn't change whether we operate on pointers with or without
> untagging.
>
> ======
>
> A few other cases that don't look that interesting:
>
> Comparing pointers to achieve unique sorting order of pointee objects
> (e.g. sorting locks addresses before performing a double lock):
>
> tty_ldisc_lock_pair_timeout in drivers/tty/tty_ldisc.c
> pipe_double_lock in fs/pipe.c
> unix_state_double_lock in net/unix/af_unix.c
> lock_two_nondirectories in fs/inode.c
> mutex_lock_double in kernel/events/core.c
>
> ep_cmp_ffd in fs/eventpoll.c
> fsnotify_compare_groups fs/notify/mark.c
>
> Nothing needs to be done here, since the tags embedded into pointers
> don't change, so the sorting order would still be unique.
>
> Check that a pointer belongs to some particular allocation:
>
> is_sibling_entry lib/radix-tree.c
> object_is_on_stack in include/linux/sched/task_stack.h
>
> Nothing needs to be here either, since two pointers can only belong to
> the same allocation if they have the same tag.
>
> ======
>
> Will, Catalin, WDYT?

ping
