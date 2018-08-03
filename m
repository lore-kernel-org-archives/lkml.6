Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9995C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD772173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7dPWiYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD772173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbeHCLiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:38:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36724 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbeHCLiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:38:24 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so2349910plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tYCS5wD6vAtxWT95Bpgkjd+Us7bJHFzRkwkufQg4uGQ=;
        b=A7dPWiYbD56fAtxLzC3IjZMbfOLKHJM6UHF7tIxKGuhi/Xj5nMp/9XWf7f+KaOJHB0
         KTD7WbgfdN1pJguLQlXz+OpgQSuvNwNpaXjEXF5Vx2ntsz4rtZCh5+DceZx8zAf72zad
         slmBGob2z14IobF6ad5PbCkQnLFuyjcnm/d2HiNegIylVdMGY3FIDFlFBPDWK5CoRLJW
         0tkb6TAy5S5FGAL14ig2Te/qIuGCvncYckQEtWCxQneXOXP3S3BN0SqqV8+DXtwardwn
         55qeK6EmgDmYPklzJhCxLI2LxEn1KxagHgU59Ba37rwMqsy0pnuCU3qxGmPwR5n/LoaR
         uxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tYCS5wD6vAtxWT95Bpgkjd+Us7bJHFzRkwkufQg4uGQ=;
        b=J4LSaZs4slu72wK7HCzfB7HJNQ3PyVc2KTT+0gT+Vl0ZpEKTujsH6IJXS9DGsiE5Ki
         /4TrTxyo98P3VivkM2NREQnYYk/BTe1dcfLQU4Shdq9VYx3LNBIlZiUxf0ayJcule5W8
         vNCc18bjWEQfAjvTfxWD4Iec951dQN1pKuFp2mCe3rYcVpRvMmAUZ4Qty89vZxnvOqZ4
         cQZal88NpJbjV9B+Fu60o7/NTdSxszuwSwncduqndzrEgAk5+/1FZ9omSMFkoe3+WzVd
         SsIUwt3BhSj52y/uUkuVA16oM4rCMaugvwhdIeJ7wSm0yWl0D3Pl83GPlNAfzDazVTq7
         QZgA==
X-Gm-Message-State: AOUpUlGWN/zWvJ0djbtnwJNkhwfkvM8XpV2/ZCRxg64JEjrS+4GZ/9ap
        csCopeHv/OSXkTvz67WTXGm+6HCu5B9I5oIinkRCFQ==
X-Google-Smtp-Source: AAOMgpdjI5mMdwC4CxAsKS7O2R8HcKUOrvYl14nmKC21/3PEoZo+ZrF/5HLo/HRbOUe81/y/r9XyF5zCbvltt5lz2wM=
X-Received: by 2002:a17:902:d710:: with SMTP id w16-v6mr2849493ply.93.1533289373008;
 Fri, 03 Aug 2018 02:42:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 3 Aug 2018 02:42:32
 -0700 (PDT)
In-Reply-To: <20180803092312.GA17798@arm.com>
References: <cover.1530018818.git.andreyknvl@google.com> <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com> <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com> <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
 <CAAeHK+xc1E64tXEEHoXqOuUNZ7E_kVyho3_mNZTCc+LTGHYFdA@mail.gmail.com>
 <20180801163538.GA10800@arm.com> <CACT4Y+aZtph5qDsLzTDEgpQRz4_Vtg1DD-cB18qooi6D0bexDg@mail.gmail.com>
 <20180803092312.GA17798@arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 3 Aug 2018 11:42:32 +0200
Message-ID: <CACT4Y+bCen+ccU8awYyx_Tw14JNZhaP4D-jNq-WZy7itW+vpYg@mail.gmail.com>
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

On Fri, Aug 3, 2018 at 11:23 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Aug 01, 2018 at 06:52:09PM +0200, Dmitry Vyukov wrote:
>> On Wed, Aug 1, 2018 at 6:35 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > Thanks for tracking these cases down and going through each of them. The
>> > obvious follow-up question is: how do we ensure that we keep on top of
>> > this in mainline? Are you going to repeat your experiment at every kernel
>> > release or every -rc or something else? I really can't see how we can
>> > maintain this in the long run, especially given that the coverage we have
>> > is only dynamic -- do you have an idea of how much coverage you're actually
>> > getting for, say, a defconfig+modules build?
>> >
>> > I'd really like to enable pointer tagging in the kernel, I'm just still
>> > failing to see how we can do it in a controlled manner where we can reason
>> > about the semantic changes using something other than a best-effort,
>> > case-by-case basis which is likely to be fragile and error-prone.
>> > Unfortunately, if that's all we have, then this gets relegated to a
>> > debug feature, which sort of defeats the point in my opinion.
>>
>> Well, in some cases there is no other way as resorting to dynamic testing.
>> How do we ensure that kernel does not dereference NULL pointers, does
>> not access objects after free or out of bounds? Nohow. And, yes, it's
>> constant maintenance burden resolved via dynamic testing.
>
> ... and the advantage of NULL pointer issues is that you're likely to see
> them as a synchronous exception at runtime, regardless of architecture and
> regardless of Kconfig options. With pointer tagging, that's certainly not
> the case, and so I don't think we can just treat issues there like we do for
> NULL pointers.

Well, let's take use-after-frees, out-of-bounds, info leaks, data
races is a good example, deadlocks and just logical bugs...

> If you want to enable khwasan in "production" and since enabling it
> could potentially change the behaviour of existing code paths, the
> run-time validation space doubles as we'd need to get the same code
> coverage with and without the feature being enabled.

This is true for just any change in configs, sysctls or just a
different workload. Any of this can enable new code, exiting code
working differently, or just working with data in new states. And we
have tens of thousands of bugs, so blindly deploying anything new to
production without proper testing is a bad idea. It's not specific to
HWASAN in any way. And when you enable HWASAN you actually do mean to
retest everything as hard as possible.

And in the end we do not seem to have any action points here, right?
