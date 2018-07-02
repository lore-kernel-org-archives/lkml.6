Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57427C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091CE24EF3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbPWFguS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091CE24EF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbeGBXj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:39:56 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38652 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753053AbeGBXjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:39:53 -0400
Received: by mail-ua0-f196.google.com with SMTP id 59-v6so76698uas.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9K+icf9Tq+L6chtSmDn+WHr0nVbD9w3yEqnxZuuW1z8=;
        b=fbPWFguSuI8+CQyYmKDPLIDBcZZdBRgHyfiLwFCxnOOEqxSpHUceGlGIefKWLLjM86
         S4TYDGRwq+ko6WkLq4qA3Gvgn6lCJSclShwxMYJZnlUZAFx2IWUrHbT2Ie4qZdBxSfc2
         HGVhvOAAQVYHWtFMe0q7Qsr1ZfDNY5MzSEZtFAE4V/WmNq519Pg1G2Mc46VcUCInD5vk
         nvRkZudXctIFtmMzTGxstxP+N9Nb31NF1b3FqpCDqDVY42te8AluRUvXMG5aHwfxrEpX
         w8TqX3Fk54zTDWgbgQJAy+A3OXUBbLtS6l7S4DUZuby9PqMkdB+iS7jr+KccY20PMwGM
         3xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9K+icf9Tq+L6chtSmDn+WHr0nVbD9w3yEqnxZuuW1z8=;
        b=gR00rCatnhrv8RynjgBS32nSBxvWBL8GlZBbEdJ0FOVBjDzXKmr/ywadtEGWmL+nhA
         gR+pVyLCDs268bjm9PTgXqV9wruSpB0OQBpNGQUpP5CdoVdgPHx5yj0xdL4qi5Ksv+J7
         ipJeXoZe8qGlOIftCzRlskYEOn4Mdon3J+MvRtkxzcJsEV4VEGkHjVK957pw17B1SK1N
         mEszROnqrPIc4oMozJ8U81/o64GFfBltiuuL4ehIh7YberqriGCj0DuSpkHiudQE8ZOY
         wXCzrr6mcqhQ0UWW51Y8vcvhhqaXvXqW7bqddd+DXYUjXUl6C9qlNxsDjqP9O7dP5tQv
         vg+A==
X-Gm-Message-State: APt69E1auRvPAeved9u/LRtQJNHFdn5lYVIHIH9BUb+grwvo3V5hYZKQ
        0z7+Qc7uYlOa6HntYqmMZqrLmsiDGYGVu2BaGkL1nw==
X-Google-Smtp-Source: AAOMgpdrvFVAAzt8J/rPMu+d7Eq7KLvym2WfvUKcKZHHVnPKL1kFwmqEd/rco5qHFjvvctreYcIjfGwSI2GGvVvXpck=
X-Received: by 2002:ab0:5013:: with SMTP id b19-v6mr17286927uaa.92.1530574792246;
 Mon, 02 Jul 2018 16:39:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9d83:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 16:39:51 -0700 (PDT)
In-Reply-To: <20180702203321.GA8371@bombadil.infradead.org>
References: <cover.1530018818.git.andreyknvl@google.com> <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com> <20180702203321.GA8371@bombadil.infradead.org>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Mon, 2 Jul 2018 16:39:51 -0700
Message-ID: <CAFKCwrg=3J-ARaOJgc73oRE7hQxs1VV7YiZEPS7Dt8Gfn6cWQA@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kostya Serebryany <kcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

On Mon, Jul 2, 2018 at 1:33 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Jun 27, 2018 at 05:04:28PM -0700, Kostya Serebryany wrote:
>> The problem is more significant on mobile devices than on desktop/server.
>> I'd love to have [K]HWASAN on x86_64 as well, but it's less trivial since x86_64
>> doesn't have an analog of aarch64's top-byte-ignore hardware feature.
>
> Well, can we emulate it in software?
>
> We've got 48 bits of virtual address space on x86.  If we need all 8
> bits, then that takes us down to 40 bits (39 bits for user and 39 bits
> for kernel).  My laptop only has 34 bits of physical memory, so could
> we come up with a memory layout which works for me?

Yes, probably.

We've tried this in userspace by mapping a file multiple times, but
that's very slow, likely because of the extra TLB pressure.
It should be possible to achieve better performance in the kernel with
some page table tricks (i.e. if we take top 8 bits out of 48, then
there would be only two second-level tables, and the top-level table
will look like [p1, p2, p1, p2, ...]). I'm not 100% sure if that would
work.

I don't think this should be part of this patchset, but it's good to
keep this in mind.
