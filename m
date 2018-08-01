Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDD2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C07208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uh5c+rin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C07208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406449AbeHATKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:10:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44555 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389790AbeHATKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:10:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so8186073pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zczWfmNAlJFNqNCvCgcqeepI0jP+1C48KaUNenyGJoA=;
        b=Uh5c+rinM6saM9FkyDS768hJ7Ekbs82q38ZuSRVDESYyveZ3ixd9NRd27pChr4r+ws
         0lKAALgT6UfmJwmsV5sfVv0daUOGNIjlbkRFnXhJAzi5n+uJWhFj3Aq1JZI2FDyhxzGp
         H2sfyMKKhhtQUlpMs+LwGp1pyCfR4QvLM2k2MHY0uCmCY6MPs9EpQun+oiUXWsDS1qkV
         DDZA3wBsN7257U1ZrhSePSGEPbfT0KDmVFCBwHTxvlLBh/ocHkShlaIrhBToALc3dTR1
         MsU4IYhxaXyhb+yevzU9S+acWq+Puf5pBZCrKvOfH0HrExFaZzfJ6OHio93lMdQnjjfQ
         +PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zczWfmNAlJFNqNCvCgcqeepI0jP+1C48KaUNenyGJoA=;
        b=jVmYop42Gn3k9vy+8BbdgkI0OTmwehu0p3UMILJkKOhlfcDhvlmmJHNfgiEXHlh86c
         cHvZ1v/W8y0rH1Du+T2kE+tNwrFPDicTgpu/FmMyeSw7lvtytLMWcX1scHHYhEBHt0BB
         +g8lKqwXNJsBn8DyBjo0iO4XjFmyia/RwOrwYAW+i90kCbVQ9AdFgTAChbY7biDuEDaX
         d6LxhHmF77jtK4eY2SgbaUPOE0W+FdHDlv3+Dz7IhMJRVucJSHzonZCFrNZtQejb9UN9
         o/QtdEzOCvbnNCm3UyDxN9NEnDek8Le+vcC8DATqmS+CJMqn6dC+yoW2z/FDVhdTuYpe
         E4Jg==
X-Gm-Message-State: AOUpUlHoBl8s8k9hA/sSZaEcZOPuFkjbuhGaZyedsvMTBz2e2Huok7fd
        u8Fe5n2m6X9sNJVsB68P/DPJpjBhuOEv4PPuO9NjwQ==
X-Google-Smtp-Source: AAOMgpe3OYEQk46QFQ+LQYp66zbjLYxoph7LmxdHz1LH5h3m/YT9HU8YO9HC7/qbBG0uHpMFsIXRznL2Qh3TZtkdlqk=
X-Received: by 2002:a62:6003:: with SMTP id u3-v6mr28012238pfb.114.1533142350192;
 Wed, 01 Aug 2018 09:52:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 1 Aug 2018 09:52:09
 -0700 (PDT)
In-Reply-To: <20180801163538.GA10800@arm.com>
References: <cover.1530018818.git.andreyknvl@google.com> <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com> <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com> <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
 <CAAeHK+xc1E64tXEEHoXqOuUNZ7E_kVyho3_mNZTCc+LTGHYFdA@mail.gmail.com> <20180801163538.GA10800@arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Aug 2018 18:52:09 +0200
Message-ID: <CACT4Y+aZtph5qDsLzTDEgpQRz4_Vtg1DD-cB18qooi6D0bexDg@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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

On Wed, Aug 1, 2018 at 6:35 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Andrey,
>
> On Tue, Jul 31, 2018 at 03:22:13PM +0200, Andrey Konovalov wrote:
>> On Wed, Jul 18, 2018 at 7:16 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> > On Tue, Jul 3, 2018 at 7:36 PM, Will Deacon <will.deacon@arm.com> wrote:
>> >> Hmm, but elsewhere in this thread, Evgenii is motivating the need for this
>> >> patch set precisely because the lower overhead means it's suitable for
>> >> "near-production" use. So I don't think writing this off as a debugging
>> >> feature is the right approach, and we instead need to put effort into
>> >> analysing the impact of address tags on the kernel as a whole. Playing
>> >> whack-a-mole with subtle tag issues sounds like the worst possible outcome
>> >> for the long-term.
>> >
>> > I don't see a way to find cases where pointer tags would matter
>> > statically, so I've implemented the dynamic approach that I mentioned
>> > above. I've instrumented all pointer comparisons/subtractions in an
>> > LLVM compiler pass and used a kernel module that would print a bug
>> > report whenever two pointers with different tags are being
>> > compared/subtracted (ignoring comparisons with NULL pointers and with
>> > pointers obtained by casting an error code to a pointer type). Then I
>> > tried booting the kernel in QEMU and on an Odroid C2 board and I ran
>> > syzkaller overnight.
>> >
>> > This yielded the following results.
>> >
>> > ======
>> >
>> > The two places that look interesting are:
>> >
>> > is_vmalloc_addr in include/linux/mm.h (already mentioned by Catalin)
>> > is_kernel_rodata in mm/util.c
>> >
>> > Here we compare a pointer with some fixed untagged values to make sure
>> > that the pointer lies in a particular part of the kernel address
>> > space. Since KWHASAN doesn't add tags to pointers that belong to
>> > rodata or vmalloc regions, this should work as is. To make sure I've
>> > added debug checks to those two functions that check that the result
>> > doesn't change whether we operate on pointers with or without
>> > untagging.
>> >
>> > ======
>> >
>> > A few other cases that don't look that interesting:
>> >
>> > Comparing pointers to achieve unique sorting order of pointee objects
>> > (e.g. sorting locks addresses before performing a double lock):
>> >
>> > tty_ldisc_lock_pair_timeout in drivers/tty/tty_ldisc.c
>> > pipe_double_lock in fs/pipe.c
>> > unix_state_double_lock in net/unix/af_unix.c
>> > lock_two_nondirectories in fs/inode.c
>> > mutex_lock_double in kernel/events/core.c
>> >
>> > ep_cmp_ffd in fs/eventpoll.c
>> > fsnotify_compare_groups fs/notify/mark.c
>> >
>> > Nothing needs to be done here, since the tags embedded into pointers
>> > don't change, so the sorting order would still be unique.
>> >
>> > Check that a pointer belongs to some particular allocation:
>> >
>> > is_sibling_entry lib/radix-tree.c
>> > object_is_on_stack in include/linux/sched/task_stack.h
>> >
>> > Nothing needs to be here either, since two pointers can only belong to
>> > the same allocation if they have the same tag.
>> >
>> > ======
>> >
>> > Will, Catalin, WDYT?
>>
>> ping
>
> Thanks for tracking these cases down and going through each of them. The
> obvious follow-up question is: how do we ensure that we keep on top of
> this in mainline? Are you going to repeat your experiment at every kernel
> release or every -rc or something else? I really can't see how we can
> maintain this in the long run, especially given that the coverage we have
> is only dynamic -- do you have an idea of how much coverage you're actually
> getting for, say, a defconfig+modules build?
>
> I'd really like to enable pointer tagging in the kernel, I'm just still
> failing to see how we can do it in a controlled manner where we can reason
> about the semantic changes using something other than a best-effort,
> case-by-case basis which is likely to be fragile and error-prone.
> Unfortunately, if that's all we have, then this gets relegated to a
> debug feature, which sort of defeats the point in my opinion.

Well, in some cases there is no other way as resorting to dynamic testing.
How do we ensure that kernel does not dereference NULL pointers, does
not access objects after free or out of bounds? Nohow. And, yes, it's
constant maintenance burden resolved via dynamic testing.
In some sense HWASAN is better in this regard because it's like, say,
LOCKDEP in this regard. It's enabled only when one does dynamic
testing and collect, analyze and fix everything that pops up. Any
false positives will fail loudly (as opposed to, say, silent memory
corruptions due to use-after-frees), so any false positives will be
just first things to fix during the tool application.
