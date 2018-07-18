Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9EFECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5597820673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTE7WuPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5597820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbeGRRzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:55:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40512 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbeGRRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:55:19 -0400
Received: by mail-it0-f67.google.com with SMTP id 188-v6so5351820ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nOIbBvKs7w+wDJzSJuqG5t9kAUaD+w7MtOThWcWpJpo=;
        b=uTE7WuPlpO+F+1fy9ED3zC7wsb2oMoyAFmebI0zDhkGEG8O2t7slJFbRqp5sO0H5HY
         5VOLwXtD52V4sIDFMVOaONcyMJFxXkV+QfzXGm9XrVW6DmECnuhFRjB2N8qymetwGmYR
         BY4TVkws+3ZSPAprGBp7bTf5AFLsrfCkilMS0DHG31lRmDmvBHfSGbtyNzkoK7hqRc0C
         qAWOm6Q1LAn4sdyw6UVJWtYqmAWEpG9rGWCinL8eo+0uNvzSh8mjMT/tHsr+pBQRnWl2
         /Jx3GmkOtIESzP0XGs5pPxC7GKMoqVEZi8se0uqHoJjWecZSZqwuvhDc0+NvinPTIWf1
         toBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nOIbBvKs7w+wDJzSJuqG5t9kAUaD+w7MtOThWcWpJpo=;
        b=Ow92jwtZaF27YJWAY8YbrNfeehND3i6piZTmiC7ErpQhoBz+I8BUe1oxowYA5Cw8Ts
         irlIz5HWOsn2a556akpVSc3z7r3GkEFDRKbNuTI4iCWYHEpHw8ACMgabVmWdeiB54Zwr
         3gXMjTZSjXRhFzcUbbCM5zlTWUg0BtFBcJn8Coe4FB0SlgCWpCnO7wF5emk147rYHb7E
         3hut7vjBV6pzBLWx5JHBVlLPrL41SO//A4RFYKPEEq2TFyt0AQsmuVrAhtfEhCdb/ZNx
         r237bsrOd1nQaz5ZAVrFuvHsbJCV01nDACPuohW7NfLAesPn+VulGVer6WuGd+zBtOB7
         WJrg==
X-Gm-Message-State: AOUpUlFHfi8Pn/CpUfL6kp9WTCK4hiVSSWK81YqRYu3lRHSs/iGhqUqE
        TrRbExyo6CIGJi8om4YAKIHQLtO5Nb3xE8YkooZ6YA==
X-Google-Smtp-Source: AAOMgpeV7pxdF9d94E24HUYDMpB/nyI0kS9DCG0THXgoTYiQbL5hkLsq0Dt0iNa1hzNxofvP0G0cu7qwIl78TXQtQ8U=
X-Received: by 2002:a02:3941:: with SMTP id w1-v6mr6402449jae.132.1531934186638;
 Wed, 18 Jul 2018 10:16:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:918c:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 10:16:25
 -0700 (PDT)
In-Reply-To: <20180703173608.GF27243@arm.com>
References: <cover.1530018818.git.andreyknvl@google.com> <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com> <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 18 Jul 2018 19:16:25 +0200
Message-ID: <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
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

On Mon, Jul 2, 2018 at 10:30 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> OK, anecdotal experience works for me.  But this is all stuff that
> should have been in the changelog from day zero, please.  It describes
> the reason for the patchset's existence!

I will add all those points to the cover letter in v5.

On Tue, Jul 3, 2018 at 7:36 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hmm, but elsewhere in this thread, Evgenii is motivating the need for this
> patch set precisely because the lower overhead means it's suitable for
> "near-production" use. So I don't think writing this off as a debugging
> feature is the right approach, and we instead need to put effort into
> analysing the impact of address tags on the kernel as a whole. Playing
> whack-a-mole with subtle tag issues sounds like the worst possible outcome
> for the long-term.

I don't see a way to find cases where pointer tags would matter
statically, so I've implemented the dynamic approach that I mentioned
above. I've instrumented all pointer comparisons/subtractions in an
LLVM compiler pass and used a kernel module that would print a bug
report whenever two pointers with different tags are being
compared/subtracted (ignoring comparisons with NULL pointers and with
pointers obtained by casting an error code to a pointer type). Then I
tried booting the kernel in QEMU and on an Odroid C2 board and I ran
syzkaller overnight.

This yielded the following results.

======

The two places that look interesting are:

is_vmalloc_addr in include/linux/mm.h (already mentioned by Catalin)
is_kernel_rodata in mm/util.c

Here we compare a pointer with some fixed untagged values to make sure
that the pointer lies in a particular part of the kernel address
space. Since KWHASAN doesn't add tags to pointers that belong to
rodata or vmalloc regions, this should work as is. To make sure I've
added debug checks to those two functions that check that the result
doesn't change whether we operate on pointers with or without
untagging.

======

A few other cases that don't look that interesting:

Comparing pointers to achieve unique sorting order of pointee objects
(e.g. sorting locks addresses before performing a double lock):

tty_ldisc_lock_pair_timeout in drivers/tty/tty_ldisc.c
pipe_double_lock in fs/pipe.c
unix_state_double_lock in net/unix/af_unix.c
lock_two_nondirectories in fs/inode.c
mutex_lock_double in kernel/events/core.c

ep_cmp_ffd in fs/eventpoll.c
fsnotify_compare_groups fs/notify/mark.c

Nothing needs to be done here, since the tags embedded into pointers
don't change, so the sorting order would still be unique.

Check that a pointer belongs to some particular allocation:

is_sibling_entry lib/radix-tree.c
object_is_on_stack in include/linux/sched/task_stack.h

Nothing needs to be here either, since two pointers can only belong to
the same allocation if they have the same tag.

======

Will, Catalin, WDYT?
