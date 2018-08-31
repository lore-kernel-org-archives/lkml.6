Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DF9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31ED2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPd5YByl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31ED2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeHaReV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:34:21 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43493 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbeHaReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:34:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so21587553oib.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQNoIA8+6IqkPJRLFnpGWaYQynHpaeV7fIzmGDwesto=;
        b=HPd5YBylJ60fkar91XgRQaAkYNkNuoGfSvgKFWgELeP6CMYCGbXvWFGpk3xBCZ+6Ye
         yKpa8q9+m6uFtktrtxQDiN/MmCYozeOpMAutZwR4ybDdRSBcnEXFnwdq2/M05UgGsqjo
         6xBxuNXhz7VZ4mdwwInoLktKHZLkrhB25JIZTqum8YMM/PZbf9hUdMpPqnsqx8qwEveF
         fZCkr45W1a0CQMskFak2VDZ638SZnqPJ5/TyxVSihNPpc5UlM+EZoghYBtzv/RRwhiN3
         548zL3jj3ipvOD7ERNz7MoO56bAs69qC7hRkAPqKuQVAE7rVqrBAK7r0uHeoqbwF6ohr
         jL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQNoIA8+6IqkPJRLFnpGWaYQynHpaeV7fIzmGDwesto=;
        b=rGMnbBIklU8CABFcKUby8NPoDcJ9ZmOKSefOyNCDgTWtD4nZC5/gfpULZtKqgxpas2
         3ZnRZUVjC3NxhheDwLlmi/EmrjhyGc7MjgtAjpTS+fUgGYdXFZJG2ZS7MtqHwxNUUY2M
         9FsM0LSXRyggODEGM9eQe0Sh2iT9E6yy8Xqjwxy2hKviZxzYpt1jb6fkpeWwkbw3gHXn
         AkGXizkU9jzPx4fXYCfKZ3oiXgZ8/weXbyPp7pu/pTK4Ol+HBHcK5FXVK7ZuHG9ftGqY
         ga/ugAT2TCEo8cru23COEO3YmEfG1ZBA6lSt/tffCWHebW2pzQsgbyBesZWvj6hY7Yct
         CtQA==
X-Gm-Message-State: APzg51CXE/tI7grabcJUj/8ufJUptq7w0N/E6YF2btphNNyAOq91WhAo
        BMlQS0rDIMBzQHRuzK5BLVpyUP6BPaQCPPCxgqaJbcNRr9krtA==
X-Google-Smtp-Source: ANB0VdayTP6tFgzdUkQLdNFCZPzEzPvk6P5wYLLiE56MT6AFmDiVyCHahRSnwvuyGUvLfwMgPessPhTLnY+qUhZrhCg=
X-Received: by 2002:aca:38d5:: with SMTP id f204-v6mr2982580oia.195.1535722011025;
 Fri, 31 Aug 2018 06:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180830194736.210039-1-jannh@google.com> <20180831082712.cbfvv655amizvkfq@ltop.local>
In-Reply-To: <20180831082712.cbfvv655amizvkfq@ltop.local>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 31 Aug 2018 15:26:24 +0200
Message-ID: <CAG48ez1aw=fSfDEp14=d+GxSu=3hLYP70Sd_s1Xux4MPiNM2VA@mail.gmail.com>
Subject: Re: [PATCH] x86/dumpstack: fix address space casting in show_opcodes()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, bp@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 10:27 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Thu, Aug 30, 2018 at 09:47:36PM +0200, Jann Horn wrote:
> > I sloppily passed a kernel-typed pointer to __range_not_ok(), and sparse
> > doesn't like that.
> > Make `prologue` a __user pointer (to protect against accidental
> > dereferences) and force-cast it to a kernel pointer when calling
> > probe_kernel_read(), which will then immediately force-cast it back to a
> > user pointer.
>
> It's a bit sad to have to do this.
> __range_not_ok() explicitly requires a __user pointer (I don't know
> if there is a good reason for it) but  the real job is done by
> __chk_range_not_ok(). Can't you use this later instead?

Yeah, I guess I can do that. Will send a v2 in a bit...


By the way, here are all 60 probe_kernel_read() callers:

arch/arm/kernel/ftrace.c:               if
(probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
arch/arm/kernel/kgdb.c: err = probe_kernel_read(bpt->saved_instr,
(char *)bpt->bpt_addr,
arch/arm64/kernel/insn.c:       ret = probe_kernel_read(&val, addr,
AARCH64_INSN_SIZE);
arch/ia64/kernel/ftrace.c:      if (probe_kernel_read(replaced, (void
*)ip, MCOUNT_INSN_SIZE))
arch/ia64/kernel/ftrace.c:      if (probe_kernel_read(replaced, (void
*)ip, MCOUNT_INSN_SIZE))
arch/mips/kernel/kprobes.c:     if ((probe_kernel_read(&prev_insn, p->addr - 1,
arch/powerpc/kernel/module_64.c:        if (probe_kernel_read(&magic,
&stub->magic, sizeof(magic))) {
arch/powerpc/kernel/module_64.c:        if
(probe_kernel_read(&funcdata, &stub->funcdata, sizeof(funcdata))) {
arch/powerpc/kernel/trace/ftrace.c:     if
(probe_kernel_read(&replaced, (void *)ip, MCOUNT_INSN_SIZE))
arch/powerpc/kernel/trace/ftrace.c:     if (probe_kernel_read(&op,
(void *)ip, sizeof(int))) {
arch/powerpc/kernel/trace/ftrace.c:     if (probe_kernel_read(&op,
(void *)(ip - 4), 4)) {
arch/powerpc/kernel/trace/ftrace.c:     if (probe_kernel_read(&op,
(void *)(ip+4), MCOUNT_INSN_SIZE)) {
arch/powerpc/kernel/trace/ftrace.c:     if (probe_kernel_read(&op,
(void *)ip, MCOUNT_INSN_SIZE))
arch/powerpc/kernel/trace/ftrace.c:     if (probe_kernel_read(jmp,
(void *)tramp, sizeof(jmp))) {
arch/powerpc/kernel/trace/ftrace.c:     if (probe_kernel_read(op, ip,
sizeof(op)))
arch/powerpc/kernel/trace/ftrace.c:     if (probe_kernel_read(&op,
(void *)ip, MCOUNT_INSN_SIZE))
arch/powerpc/kernel/trace/ftrace.c:     if (probe_kernel_read(&op,
(void *)ip, sizeof(int))) {
arch/powerpc/perf/core-book3s.c:                if
(probe_kernel_read(&instr, (void *)addr, sizeof(instr)))
arch/riscv/kernel/ftrace.c:     if (probe_kernel_read(replaced, (void
*)hook_pos, MCOUNT_INSN_SIZE))
arch/s390/kernel/ftrace.c:      if (probe_kernel_read(&old, (void *)
rec->ip, sizeof(old)))
arch/s390/kernel/ftrace.c:      if (probe_kernel_read(&old, (void *)
rec->ip, sizeof(old)))
arch/sh/kernel/ftrace.c:        if (probe_kernel_read(replaced, (void
*)ip, MCOUNT_INSN_SIZE))
arch/sh/kernel/ftrace.c:        if (probe_kernel_read(code, (void
*)ip, MCOUNT_INSN_SIZE))
arch/x86/kernel/dumpstack.c:    if (probe_kernel_read(opcodes, rip -
PROLOGUE_SIZE, OPCODE_BUFSIZE)) {
arch/x86/kernel/ftrace.c:       if (probe_kernel_read(replaced, (void
*)ip, MCOUNT_INSN_SIZE))
arch/x86/kernel/ftrace.c:       if (probe_kernel_read(replaced, (void
*)ip, MCOUNT_INSN_SIZE))
arch/x86/kernel/ftrace.c:       if (probe_kernel_read(ins, (void *)ip,
MCOUNT_INSN_SIZE))
arch/x86/kernel/ftrace.c:       ret = probe_kernel_read(trampoline,
(void *)start_offset, size);
arch/x86/kernel/ftrace.c:       ret = probe_kernel_read(&calc, ptr,
MCOUNT_INSN_SIZE);
arch/x86/kernel/kgdb.c: err = probe_kernel_read(bpt->saved_instr,
(char *)bpt->bpt_addr,
arch/x86/kernel/kgdb.c: err = probe_kernel_read(opc, (char
*)bpt->bpt_addr, BREAK_INSTR_SIZE);
arch/x86/kernel/kgdb.c: err = probe_kernel_read(opc, (char
*)bpt->bpt_addr, BREAK_INSTR_SIZE);
arch/x86/kernel/kprobes/core.c: if (probe_kernel_read(buf, (void *)addr,
arch/x86/kernel/kprobes/core.c: if (probe_kernel_read(dest, (void
*)recovered_insn, MAX_INSN_SIZE))
arch/x86/kernel/kprobes/opt.c:  if (probe_kernel_read(buf, (void *)addr,
arch/x86/xen/enlighten_pv.c:    probe_kernel_read(&dummy, v, 1);
drivers/char/mem.c:                     probe =
probe_kernel_read(bounce, ptr, sz);
drivers/dio/dio.c:                if (probe_kernel_read(&i, (unsigned
char *)va + DIO_IDOFF, 1)) {
drivers/dio/dio.c:                if (probe_kernel_read(&i, (unsigned
char *)va + DIO_IDOFF, 1)) {
drivers/input/serio/hp_sdc.c:   if (!probe_kernel_read(&i, (unsigned
char *)hp_sdc.data_io, 1))
drivers/misc/kgdbts.c:  probe_kernel_read(before, (char *)kgdbts_break_test,
drivers/misc/kgdbts.c:  probe_kernel_read(after, (char *)kgdbts_break_test,
drivers/video/fbdev/hpfb.c:     err = probe_kernel_read(&i, (unsigned
char *)INTFBVADDR + DIO_IDOFF, 1);
fs/proc/kcore.c:                                if
(probe_kernel_read(buf, (void *) start, tsz)) {
include/linux/uaccess.h:        probe_kernel_read(&retval, addr, sizeof(retval))
kernel/debug/debug_core.c:      err =
probe_kernel_read(bpt->saved_instr, (char *)bpt->bpt_addr,
kernel/debug/gdbstub.c: err = probe_kernel_read(tmp, mem, count);
kernel/debug/kdb/kdb_main.c:    if (!p || probe_kernel_read(&tmp,
(char *)p, sizeof(unsigned long)))
kernel/debug/kdb/kdb_support.c: int ret = probe_kernel_read((char
*)res, (char *)addr, size);
kernel/debug/kdb/kdb_support.c: int ret = probe_kernel_read((char
*)addr, (char *)res, size);
kernel/debug/kdb/kdb_support.c: if (!p || probe_kernel_read(&tmp,
(char *)p, sizeof(unsigned long)))
kernel/kthread.c:       probe_kernel_read(&data, &kthread->data, sizeof(data));
kernel/trace/bpf_trace.c:       ret = probe_kernel_read(dst, unsafe_ptr, size);
kernel/workqueue.c:     probe_kernel_read(&fn, &worker->current_func,
sizeof(fn));
kernel/workqueue.c:     probe_kernel_read(&pwq, &worker->current_pwq,
sizeof(pwq));
kernel/workqueue.c:     probe_kernel_read(&wq, &pwq->wq, sizeof(wq));
kernel/workqueue.c:     probe_kernel_read(name, wq->name, sizeof(name) - 1);
kernel/workqueue.c:     probe_kernel_read(desc, worker->desc, sizeof(desc) - 1);
mm/slab.c:              if (probe_kernel_read(&v, dbg_userword(c, p),
sizeof(v)))
mm/slub.c:      probe_kernel_read(&p, (void **)freepointer_addr, sizeof(p));

41 of these (or something like that, I counted by hand) have some sort
of cast in the call expression.
probe_kernel_read() is kinda special in that expected types for the
second argument are both kernel pointers and unsigned longs. It might
make sense to have a wrapper macro around probe_kernel_read() that
accepts anything as long as it's as wide as a pointer... maybe
something for a future refactor.
