Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B41C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48722086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="abwW4XzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48722086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeH1Tee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:34:34 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36793 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1Tee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:34:34 -0400
Received: by mail-yw1-f66.google.com with SMTP id w202-v6so756938yww.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l2TQWKi5FhTqFX0+YXVJ57VSt2UFO1YpKPBaZ5bpbIQ=;
        b=abwW4XzNoEj8CuI8Fo8c0E+0aIkz1Ev5B6Dq6OD1H3cua3uKNBVw5mQmvTIo/s+JMJ
         Vt4b076l36rfwUVuy2OKkFkTN7UatSiI6plIWSNGMFtsdqP16L7iTYU1b9qSroJouTlK
         T75MxJZLIxIkA0v+tsdLlOUA4Ms1YDRazHFL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l2TQWKi5FhTqFX0+YXVJ57VSt2UFO1YpKPBaZ5bpbIQ=;
        b=EoUiSIJKppP6ummAygNHxoL9uFrs9s1qlU+h0u+yMGNKRD1jeFKaDRXjJDH/Mkt84a
         TjEG3fzvziafQSDXnTamX8Y3pedFBvT+++jh1nVwhW/CuEnaEF/0x5fshy+wYoQI52cA
         1P8+/0smkziXp3nQR8Ulc845+pCWFedR7pFWdYbHXTRGtHXVdJDQkWOzmbRNS5MriBfl
         Rsbv4SMNNjJaXkS3HRGgKkAzOe6rIKR7LqDFQ2KIdY0CSwxbDJAe9OcIQmTBzyZUNjpL
         6OUebPsVmNm6Pr1VSh7tRRRNvMzUi4/pO5/kWpH28hfy9OtPUilG/oGmfvxJ1q9U8Nqr
         Dh4Q==
X-Gm-Message-State: APzg51Au7IjFxCu8fmudlokKJhMMARIIdJXUO1NkZ5lkA49ieDyoujfa
        0d7WYITmx36zqd+pAByuJG4gOjzkizU=
X-Google-Smtp-Source: ANB0VdYr+RKv9Y6RZnM6SicnIz0Y6usIIWOE8EZKpBBulLavofE3U2Y0z78IHa7zlrlAmI2PsWoxLg==
X-Received: by 2002:a0d:f586:: with SMTP id e128-v6mr1098999ywf.395.1535470939160;
        Tue, 28 Aug 2018 08:42:19 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id t4-v6sm522094ywa.51.2018.08.28.08.42.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:42:18 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id l9-v6so741682ywc.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:42:17 -0700 (PDT)
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr1167890ywg.288.1535470937331;
 Tue, 28 Aug 2018 08:42:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 08:42:16
 -0700 (PDT)
In-Reply-To: <20180828151805.102263-1-jannh@google.com>
References: <20180828151805.102263-1-jannh@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 28 Aug 2018 08:42:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLMBGGbOp9N232TsvWFs8kxDU8Ewc0fLYAj5CpHX=KuLA@mail.gmail.com>
Message-ID: <CAGXu5jLMBGGbOp9N232TsvWFs8kxDU8Ewc0fLYAj5CpHX=KuLA@mail.gmail.com>
Subject: Re: [PATCH] x86/dumpstack: don't dump kernel memory based on usermode RIP
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 8:18 AM, Jann Horn <jannh@google.com> wrote:
> show_opcodes() is used both for dumping kernel instructions and for dumping
> user instructions. If userspace causes #PF by jumping to a kernel address,
> show_opcodes() can be reached with regs->ip controlled by the user,
> pointing to kernel code. Make sure that userspace can't trick us into
> dumping kernel memory into dmesg.
>
> Cc: stable@vger.kernel.org
> Fixes: 7cccf0725cf7 ("x86/dumpstack: Add a show_ip() function")
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks for finding this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/include/asm/stacktrace.h |  2 +-
>  arch/x86/kernel/dumpstack.c       | 13 ++++++++++---
>  arch/x86/mm/fault.c               |  2 +-
>  3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
> index b6dc698f992a..f335aad404a4 100644
> --- a/arch/x86/include/asm/stacktrace.h
> +++ b/arch/x86/include/asm/stacktrace.h
> @@ -111,6 +111,6 @@ static inline unsigned long caller_frame_pointer(void)
>         return (unsigned long)frame;
>  }
>
> -void show_opcodes(u8 *rip, const char *loglvl);
> +void show_opcodes(struct pt_regs *regs, const char *loglvl);
>  void show_ip(struct pt_regs *regs, const char *loglvl);
>  #endif /* _ASM_X86_STACKTRACE_H */
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 9c8652974f8e..5d2700c98b29 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -89,14 +89,21 @@ static void printk_stack_address(unsigned long address, int reliable,
>   * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
>   * guesstimate in attempt to achieve all of the above.
>   */
> -void show_opcodes(u8 *rip, const char *loglvl)
> +void show_opcodes(struct pt_regs *regs, const char *loglvl)
>  {
>  #define PROLOGUE_SIZE 42
>  #define EPILOGUE_SIZE 21
>  #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
>         u8 opcodes[OPCODE_BUFSIZE];
> +       u8 *prologue = (u8 *)regs->ip - PROLOGUE_SIZE;
> +       /*
> +        * Make sure userspace isn't trying to trick us into dumping kernel
> +        * memory by pointing the userspace instruction pointer at it.
> +        */
> +       bool bad_ip = user_mode(regs) &&
> +                     __range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
>
> -       if (probe_kernel_read(opcodes, rip - PROLOGUE_SIZE, OPCODE_BUFSIZE)) {
> +       if (bad_ip || probe_kernel_read(opcodes, prologue, OPCODE_BUFSIZE)) {
>                 printk("%sCode: Bad RIP value.\n", loglvl);
>         } else {
>                 printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
> @@ -112,7 +119,7 @@ void show_ip(struct pt_regs *regs, const char *loglvl)
>  #else
>         printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
>  #endif
> -       show_opcodes((u8 *)regs->ip, loglvl);
> +       show_opcodes(regs, loglvl);
>  }
>
>  void show_iret_regs(struct pt_regs *regs)
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index b9123c497e0a..47bebfe6efa7 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -837,7 +837,7 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
>
>         printk(KERN_CONT "\n");
>
> -       show_opcodes((u8 *)regs->ip, loglvl);
> +       show_opcodes(regs, loglvl);
>  }
>
>  static void
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>



-- 
Kees Cook
Pixel Security
