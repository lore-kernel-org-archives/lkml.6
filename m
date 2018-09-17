Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889BBECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304B9214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvuN5wPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304B9214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeIRAkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:40:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43708 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIRAkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:40:42 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so12412278ioa.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gWplmzHDH6KZolY8ldYoeSPd33NxuFmbGBatguzK8Vc=;
        b=HvuN5wPJisbwgEIduyQO1/cxxJBQTiPteioabMrGnqLzEbe7VUjMs0YfIPmLaTfeiu
         cNWsfSyuG//Oi1D2FfkVY8iVHq1eiztamv8xKjA92GpoWuC5J+nIFtSFdYJhqgCCodh+
         2MgKI7xLF1LtD1yW9XrknA7fa5yD6I6RpabkiLgfRdS/HQ+ZNwrcSON2pfZG+C0bR/wv
         fpZA3JlrF+kwjoOsc6P9BWYRu11vjAHYf8MoEOH+sZZrpV+ZZqe9nB5viymzjt1WRgOy
         2T3DL2tKyh7odq44ZHGU+cPj/PZ0lUEjdToLeBkVhOolidZr26aju3+4UJO360cnw4lc
         8YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gWplmzHDH6KZolY8ldYoeSPd33NxuFmbGBatguzK8Vc=;
        b=bJY1rNSIMY9dNpwOLXEAoHKgxP0+J2lGv5Axy9ytXssO59eg+4P+6Urwfu8vI5ECNQ
         ZfOL/n0UpHBskkei9zXWE6aOC6Uv2ReW9wqop6nbpj1iCTA/QQl2vMtfxokQtdxbo+46
         X5g6AX1Ht2MGYI5QP6owCvFgEFUebPYgLTpSoc09Ia6K2x0FN4cnq8tG750SB1hotRPB
         Nl/6+2LUyanl26UIUTT9mbHu5FttJIinINg7XX7RoiLoG/Vxa5PuyoaDym55hd0091Sr
         xhyw6fg0REwMFmJ7qVTs/mBYel4tDlJZST5bgvLYKf4y84SH6HqCTvr4X8/arvDRtoLx
         wBAw==
X-Gm-Message-State: APzg51AyqhhC/k7rmw/0JvdeTi7uTmLWT3sO6DsigvCHSe3Ey971qjbY
        5iG67PaPrWtBykS5hQ75c3caI4I3t9s+KilhQvTPCA==
X-Google-Smtp-Source: ANB0VdY8n+M9HhpuOcLEY/zyoMKmpOkxRQdF6e0axt54jjcUVmq4g5FH/VdtRL5J93mMn1oQb/fbjviFylli1rc6S+A=
X-Received: by 2002:a6b:2147:: with SMTP id h68-v6mr21853988ioh.192.1537211521383;
 Mon, 17 Sep 2018 12:12:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 12:12:00
 -0700 (PDT)
In-Reply-To: <CACT4Y+ZwLnk7V1cY-EAHbrfXPBxs6qyynZPhxoSKZZDWSK8Fuw@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <f5e73b5ead3355932ad8b5fc96b141c3f5b8c16c.1535462971.git.andreyknvl@google.com>
 <CACT4Y+ZwLnk7V1cY-EAHbrfXPBxs6qyynZPhxoSKZZDWSK8Fuw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 17 Sep 2018 21:12:00 +0200
Message-ID: <CAAeHK+wVgmp2G63c5w4sMH1i97Ju-YW7RUQgOQjr5d8aMgh1EQ@mail.gmail.com>
Subject: Re: [PATCH v6 15/18] khwasan, arm64: add brk handler for inline instrumentation
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 7:13 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>> +static int khwasan_handler(struct pt_regs *regs, unsigned int esr)
>> +{
>> +       bool recover = esr & KHWASAN_ESR_RECOVER;
>> +       bool write = esr & KHWASAN_ESR_WRITE;
>> +       size_t size = KHWASAN_ESR_SIZE(esr);
>> +       u64 addr = regs->regs[0];
>> +       u64 pc = regs->pc;
>> +
>> +       if (user_mode(regs))
>> +               return DBG_HOOK_ERROR;
>> +
>> +       kasan_report(addr, size, write, pc);
>> +
>> +       /*
>> +        * The instrumentation allows to control whether we can proceed after
>> +        * a crash was detected. This is done by passing the -recover flag to
>> +        * the compiler. Disabling recovery allows to generate more compact
>> +        * code.
>> +        *
>> +        * Unfortunately disabling recovery doesn't work for the kernel right
>> +        * now. KHWASAN reporting is disabled in some contexts (for example when
>> +        * the allocator accesses slab object metadata; same is true for KASAN;
>> +        * this is controlled by current->kasan_depth). All these accesses are
>> +        * detected by the tool, even though the reports for them are not
>> +        * printed.
>
>
> I am not following this part.
> Slab accesses metadata. OK.
> This is detected as bad access. OK.
> Report is not printed. OK.
> We skip BRK and resume execution.
> What is the problem?

When the kernel is compiled with -fsanitize=kernel-hwaddress without
any additional flags (like it's done now with KASAN_HW) everything
works as you described and there's no problem. However if one were to
recompile the kernel with hwasan recovery disabled, KHWASAN wouldn't
work due to the reasons described in the comment. Should I make it
more clear?

>
>
>
>> +        *
>> +        * This is something that might be fixed at some point in the future.
>> +        */
>> +       if (!recover)
>> +               die("Oops - KHWASAN", regs, 0);
