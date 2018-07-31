Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91CFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FED20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+zaXx2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FED20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbeGaPDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:03:42 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35514 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732194AbeGaPDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:03:42 -0400
Received: by mail-it0-f65.google.com with SMTP id q20-v6so4323775ith.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QpbT3UXIG5rYjc4TLEcBAPVut8LzMvY571CNwf5xdWE=;
        b=a+zaXx2nTsLbGVADaHZ1GdN/atj2ZAJVQ0YMn3aApr41kI+SAJ37MkjKH5NbFUNkau
         8XrlQlK1VnWNqotEZawz45uQ2UE6aGXnjf1dVdUR0BC1duMXtBQwRAkHqOcSYV2R37c2
         yJnEzzlul9fk4nnBh7jYNKzUnFMnAw71+FGikJDjYUReTQ4xDNS8ks4qurq4Y8Rj81EK
         AP0NXwsQHO9bIGOkULG/U/N7vHr8JeZyAzzaF5tfKXaH/89JQAHmfB2VP5q5VXLdYzox
         LVz2OmzYVmliH4BQ43WVUjSzCimVTnd3z9UB+QmbnFEsqq4EJTjBzqtvHOo47Xi007YB
         cZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QpbT3UXIG5rYjc4TLEcBAPVut8LzMvY571CNwf5xdWE=;
        b=jiinxqLb1LzJSAi5v2Pw+9jktsQgSW0hVu9pFp7RikbIx897YHPPPm94DJ6Szeoa2R
         n0k8kFaVeEKv7kxewqSoYRYg1IDrxguZKQqRmoOOjT5nGHBW7dG3O3Ucv/KpdM2s4xxG
         lb+3WtcGu0EtZxFp9XEWkh7kRgsZtT0IqKAAgDPaG0LJ7RY/FFWQfi6Zz4W8Q2GjVMW9
         +SQVPBLg/5a1UTTVRf47F/emOb0WYXHdmFqPlqCjbUoX945bbKs4hNyEhLXejL/i2Mv6
         TxmBhfr+38pKhFxaF2EBVxwwXHWa/vE2JdcUPBlZ2eyBoCJtjoLEHNKrIcuDy1iJ0fOd
         FShg==
X-Gm-Message-State: AOUpUlH1sbO4EzgV8yZBFm5w1LQetmtYmRyeoqhg5jGfq6y8dnvhKkA1
        Ms0oPL6CSX7KTCWyVZeAjozVUqynE2eSqeTimaKj/w==
X-Google-Smtp-Source: AAOMgpdgX4ewobE99i4e+gAM/qg9U7PRr9cOZQge00eclnDH4v99UjeOsQ8D6hS/DNUTBhgdyjE+PWATiwriC7/ZOto=
X-Received: by 2002:a24:22cf:: with SMTP id o198-v6mr3005405ito.53.1533043402246;
 Tue, 31 Jul 2018 06:23:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:918c:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 06:23:21
 -0700 (PDT)
In-Reply-To: <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com>
References: <cover.1529507994.git.andreyknvl@google.com> <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com> <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 31 Jul 2018 15:23:21 +0200
Message-ID: <CAAeHK+y95YJZ6yEw0icsz7ScFYP=x5V+__8J0BG9T3vyB1J1xA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 1:25 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> So the checker reports ~100 different places where a __user pointer
> being casted. I've looked through them and found 3 places where we
> need to add untagging. Source code lines below come from 4.18-rc2+
> (6f0d349d).
>
> Place 1:
>
> arch/arm64/mm/fault.c:302:34: warning: user pointer cast
> current->thread.fault_address = (unsigned long)info->si_addr;
>
> Compare a pointer with TASK_SIZE (1 << 48) to check whether it lies in
> the kernel or in user space. Need to untag the address before
> performing a comparison.
>
> Place 2:
>
> fs/namespace.c:2736:21: warning: user pointer cast
> size = TASK_SIZE - (unsigned long)data;
>
> A similar check performed by subtracting a pointer from TASK_SIZE.
> Need to untag before subtracting.
>
> Place 3:
>
> drivers/usb/core/devio.c:1407:29: warning: user pointer cast
> unsigned long uurb_start = (unsigned long)uurb->buffer;
> drivers/usb/core/devio.c:1636:31: warning: user pointer cast
> unsigned long uurb_start = (unsigned long)uurb->buffer;
> drivers/usb/core/devio.c:1715:30: warning: user pointer cast
> unsigned long uurb_start = (unsigned long)uurb->buffer;
>
> The device keeps list of mmapped areas and searches them for provided
> __user pointer. Need to untag before searching.
>
> There are also a few cases of memory syscalls operating on __user
> pointers instead of unsigned longs like mmap:
>
> ipc/shm.c:1355:23: warning: user pointer cast
> unsigned long addr = (unsigned long)shmaddr;
> ipc/shm.c:1566:23: warning: user pointer cast
> unsigned long addr = (unsigned long)shmaddr;
> mm/migrate.c:1586:10: warning: user pointer cast
> addr = (unsigned long)p;
> mm/migrate.c:1660:24: warning: user pointer cast
> unsigned long addr = (unsigned long)(*pages);
>
> If we don't add untagging to mmap, we probably don't need it here.
>
> The rest of reported places look fine as is. Full annotated results of
> running the checker are here [2].
>
> I'll add the 3 patches with fixes to v5 of this patchset.
>
> Catalin, WDYT?

ping
