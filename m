Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851BAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A52620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTNTcHks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A52620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeKJFtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:49:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37947 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJFtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:49:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id f24so2751691otl.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 12:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUFwZLkG3322nZXRMsXrrVbQjUnjyTIpP7ff0qsSub8=;
        b=GTNTcHksHHTi8ChoQnEk787Gxg5f3rdjV0lM9oXCRRb0rfVz+qNlUbWRYvEIMh3xEE
         uATjNn3RlQ/XC5WcxLHS6B8WKTbk91pWdkWd1XKBq2Xhg1TqH+Ax2VK9Ez8G+Y+vdKcf
         eneJ7pWbt+Gt7R6rU1WzX4VmlbVISw7a1htrwzxRiGiRH7o3lAhUhBuP10AzBQsz6jS9
         9UHg+TLVnRv12bttP2FIQhdYfDw3Qz9SWyesREXejsWqczM0wVK/f37qF82amtubknRw
         P0cTbT6frnRjiLkottKRnsezXmCDNpKJVwx3oirzBLYyb5Yyi50VDe8iHfCK2/rB3NGR
         VFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUFwZLkG3322nZXRMsXrrVbQjUnjyTIpP7ff0qsSub8=;
        b=nF/B+ys7vhiyW4UXbXY59SfrB2l1V4Y/iqm0cnMfmXndMYCHBXiZgLsiW6xaRe67SJ
         x4fxDgGs4db5FkE3BJyArhgOS5ZoJa2J7inMGCQ0U43kugjGzxuWS8CHzWWQox6AdzYB
         O/+xlGfrqothBGRdcR8kOBCfzdx6/p1wcWVPe1h+gMNF1KkTfrFw3adcJTbTLrj6Xg//
         ZLsRGjK7co3SRWTgAF+EMeFTfNL+aNDCky/B4mdXGM/cyCE2QaEZlWEbW6lYqHJRQYAl
         MAUno8/I1vaL226jcvhC0YveW2C/Uxowg5LxoVwjmXy7mU6hACsYlLgo1Y94uoEPhj0q
         6kkQ==
X-Gm-Message-State: AGRZ1gK6u9FO3nG7SNAo11jt+BvZFqeVv2ed5SwA1tlbh/7ED3zu+Q+B
        lpDhmVfj7UN5XrHhF71Iv8JAopfJxuiEKiVjR9nIpg==
X-Google-Smtp-Source: AJdET5cXjXs2PLvXxsWygz6kywbzJDwHn04YUfcy0v93QqKZU9IwZvla3ETGhspDM0gSH4nZFdv8qzJc99CvBLJMFcA=
X-Received: by 2002:a9d:460e:: with SMTP id y14mr6444829ote.198.1541794013885;
 Fri, 09 Nov 2018 12:06:53 -0800 (PST)
MIME-Version: 1.0
References: <5be58a6e.w0IbLdKsiRknTygq%lkp@intel.com>
In-Reply-To: <5be58a6e.w0IbLdKsiRknTygq%lkp@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 9 Nov 2018 21:06:27 +0100
Message-ID: <CAG48ez2xSLFGjMYSYJTLwEnZoZJuXUfdoCp6_vGrywBU4SQNkQ@mail.gmail.com>
Subject: Re: afaef01c00 ("x86/entry: Add STACKLEAK erasing the kernel stack
 .."): double fault: 0000 [#1]
To:     alex.popov@linux.com, Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     lkp@01.org, lkp@intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Andy, Thomas, Ingo

On Fri, Nov 9, 2018 at 2:24 PM kernel test robot <lkp@intel.com> wrote:
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> commit afaef01c001537fa97a25092d7f54d764dc7d8c1
> Author:     Alexander Popov <alex.popov@linux.com>
> AuthorDate: Fri Aug 17 01:16:58 2018 +0300
> Commit:     Kees Cook <keescook@chromium.org>
> CommitDate: Tue Sep 4 10:35:47 2018 -0700
>
>     x86/entry: Add STACKLEAK erasing the kernel stack at the end of syscalls
[...]
> [  127.808225] double fault: 0000 [#1]
> [  127.808695] CPU: 0 PID: 414 Comm: trinity-main Tainted: G                T 4.19.0-rc2-00001-gafaef01 #1
> [  127.809799] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [  127.810760] RIP: 0010:ftrace_ops_test+0x27/0xa0
> [  127.811289] Code: eb 9a 90 41 54 55 49 89 f4 53 48 89 d3 48 89 fd 48 81 ec b0 00 00 00 65 48 8b 04 25 28 00 00 00 48 89 84 24 a8 00 00 00 31 c0 <e8> 54 df ff ff 48 85 db 74 57 e8 4a df ff ff 48 8b 85 d0 00 00 00
> [  127.813385] RSP: 0018:fffffe0000001fb8 EFLAGS: 00010046
[...]
> [  127.819762] CR2: fffffe0000001fa8 CR3: 000000001579a000 CR4: 00000000000006b0
[...]
> [  127.822234] Call Trace:
> [  127.822530]  <ENTRY_TRAMPOLINE>
> [  127.822914]  ? __ia32_sys_rseq+0x2f0/0x2f0
> [  127.823395]  ftrace_ops_list_func+0xa5/0x1b0
> [  127.823922]  ftrace_call+0x5/0x34
> [  127.824318]  ? stackleak_erase+0x5/0xf0
> [  127.824789]  ? stackleak_erase+0x43/0xf0
> [  127.825260]  stackleak_erase+0x5/0xf0
> [  127.825699]  syscall_return_via_sysret+0x61/0x81
> [  127.826238] WARNING: stack recursion on stack type 4
> [  127.826243] WARNING: can't dereference registers at (____ptrval____) for ip syscall_return_via_sysret+0x61/0x81
> [  127.826246]  </ENTRY_TRAMPOLINE>
> [  127.828342] ---[ end trace e9f96d3f45575499 ]---
> [  127.828911] RIP: 0010:ftrace_ops_test+0x27/0xa0

CR2: fffffe0000001fa8, RSP: 0018:fffffe0000001fb8; this is a pagefault
on the stack. fffffe0000000000 is CPU_ENTRY_AREA_RO_IDT;
fffffe0000001000 is CPU_ENTRY_AREA_PER_CPU; so fffffe0000002000 is the
page with the entry stack for cpu 0, and you overflowed from that into
the readonly gdt at fffffe0000001000, which doubles as a guard page
for the entry stack:

struct cpu_entry_area {
        char gdt[PAGE_SIZE];

        /*
         * The GDT is just below entry_stack and thus serves (on x86_64) as
         * a a read-only guard page.
         */
        struct entry_stack_page entry_stack_page;
[...]
};

In other words: You're calling C code on the entry trampoline stack;
this C code can call into ftrace; and the entry trampoline stack isn't
big enough for ftrace shenanigans. I think you probably shouldn't be
calling C code on the entry stack, but maybe one of the X86 folks has
a different opinion?
