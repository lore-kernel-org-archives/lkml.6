Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ABAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F59218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMge/El5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393573AbfBNAFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:05:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43698 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbfBNAFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:05:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so1978098pgk.10;
        Wed, 13 Feb 2019 16:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IWNzrhnWsOtFmrqgVZfY3etgZbEBnuJKm9LIeVbuayc=;
        b=IMge/El58EM3BMbL4pLKlLZEGyIVlM16RbGQ5EmW1vQT4OsbVgWt/quiXdAlrf0MQA
         D/fQsbgiQFiUPefKIEFBFecL4T12rXrmKoKovB2aMngppfbLLGkjSMnalSrRA5DAgY1q
         dYGHpe75rHO+r4HtFSTaou0i+kdFxpbMInTkSXd2ymE37vDInEZOeYwt4+MGUW4sUw3V
         WVycc6JrtmkWDJl9aIaavxKlrAwp7mvO23YQeQltVS+j9BX44WqeZ9yulo10y0yZpXIE
         HAFMx3KXSdlodWNjlwj2NNONJvxCg2zqbEvMRQ3yiCLuUYRedZtS+9bOahXN2QMnvn1v
         oxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IWNzrhnWsOtFmrqgVZfY3etgZbEBnuJKm9LIeVbuayc=;
        b=Jc7H2ZXmpfCFFajCOI5Q3gotI2N9HDfUiGayb+nP3sJxaDU3jos0jLd7nif9bBB+Ai
         H9to9gFeendEr4WtQWtNz98zgzkJL4C6E5Kndox7yJ4kiDH1qQxR7wxT4bxZ5FFfmAJD
         WlhFgy23vJkpIALc0ywiDlRXcuR+i8+/o6MMBU876Wy3V4NDys8wCHW6IsjnCxJwEyv4
         kphN90+lLM5woBlSwiRhKqzd25rKAAVY0d9DrC5+Gy3FM+8jZvGYQYD7Icb4K33Ja2K4
         3dS8AQppNyqggBYxO3LvV3ZIXN6oyvBr49LSFuoS5jb+gwGUAnQl81YY9TxEJ84WR5vk
         eJaQ==
X-Gm-Message-State: AHQUAubvnbocCtG16t0xct8axsNzhf95WukKz5+vbF8QyZ6gZ3gpzevs
        EKLtXh2k7GThqiwg7nfrBEo=
X-Google-Smtp-Source: AHgI3Ibiml7m64iUKof20jufv8aMO4Kzjt+t1gOSC93A0p3y9fin2uWrD0+nFnSDumWjiH0OthsIvg==
X-Received: by 2002:a63:360b:: with SMTP id d11mr848563pga.156.1550102731527;
        Wed, 13 Feb 2019 16:05:31 -0800 (PST)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id q1sm575488pfb.96.2019.02.13.16.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 16:05:30 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:05:24 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kprobe: safely access memory specified by userspace
Message-ID: <20190214000522.n7ltwbnjl3kufdsn@mail.google.com>
References: <20190125151051.7381-1-changbin.du@gmail.com>
 <20190213143638.y54hghilbyastlpo@mail.google.com>
 <20190213104143.5c390b28@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213104143.5c390b28@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:41:43AM -0500, Steven Rostedt wrote:
> On Wed, 13 Feb 2019 22:36:40 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > Hi Steven,
> > I think this is a critical issue. Could you give priority to this fix?
> > 
> > On Fri, Jan 25, 2019 at 11:10:50PM +0800, Changbin Du wrote:
> > > The userspace can ask kprobe to intercept strings at any memory address,
> > > including invalid kernel address. In this case, fetch_store_strlen()
> > > would crash since it uses general usercopy function.
> > > 
> > > For example, we can crash the kernel by doing something as below:
> > > 
> > > $ sudo kprobe 'p:do_sys_open +0(+0(%si)):string'
> 
> Note, I'm not able to reproduce this.
> 
> I just get:
> 
>         sendmail-1085  [001] ....   277.344573: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1550  [003] ....   279.879011: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1550  [003] ....   279.879056: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1550  [003] ....   279.879079: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1550  [003] ....   279.879132: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1550  [003] ....   279.879683: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1550  [003] ....   279.881521: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1550  [003] ....   279.881541: open: (do_sys_open+0x0/0x210) arg1=""
>            <...>-1597  [005] ....   280.907662: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1597  [005] ....   280.907694: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1597  [005] ....   280.907772: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1597  [005] ....   280.907825: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1597  [005] ....   280.907891: open: (do_sys_open+0x0/0x210) arg1=(fault)
>            <...>-1597  [005] ....   280.907947: open: (do_sys_open+0x0/0x210) arg1=(fault)
> 
> 
> > > 
> > > [  103.620391] BUG: GPF in non-whitelisted uaccess (non-canonical address?)
> > > [  103.622104] general protection fault: 0000 [#1] SMP PTI
> > > [  103.623424] CPU: 10 PID: 1046 Comm: cat Not tainted 5.0.0-rc3-00130-gd73aba1-dirty #96
> > > [  103.625321] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-2-g628b2e6-dirty-20190104_103505-linux 04/01/2014
> > > [  103.628284] RIP: 0010:process_fetch_insn+0x1ab/0x4b0
> 
> What line number is the RIP on?
>
I still can reproduce this bug on mainline (1f947a7a011fcceb14cb912f5481a53b18f1879a).
But it seems your linux has already fix this issue.

Panic msg:
i440FX-PIIX login: [  265.640531] BUG: GPF in non-whitelisted uaccess (non-canonical address?)
[  265.644365] general protection fault: 0000 [#1] SMP PTI
[  265.645227] CPU: 0 PID: 2044 Comm: cat Not tainted 5.0.0-rc6+ #25
[  265.646251] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-4-g29ba89e 04/01/2014
[  265.647754] RIP: 0010:process_fetch_insn+0x1a3/0x450
[  265.648498] Code: ff f0 80 48 03 80 83 80 88 21 00 00 01 31 c9 eb 10 48 83 c2 01 85 c0 75 1f 81 f9 ff 0f 00 00 7f 17 0f 01 cb 0f ae e8 44 89 e0 <40> 8a 32 0f 01 ca 83 c1 01 40 84 f6 75 d9 65 48 8b 14 25 40 5c 01
[  265.651117] RSP: 0018:ffffc90001b1fd00 EFLAGS: 00050246
[  265.651862] RAX: 0000000000000000 RBX: ffff88812d4a9100 RCX: 0000000000000000
[  265.652917] RDX: 2e646c2f6374652f RSI: 00007ff31f818430 RDI: 00007ffffffff000
[  265.653918] RBP: 0000000000000000 R08: 2e646c2f6374652f R09: 0000000000000000
[  265.654881] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  265.655815] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  265.656746] FS:  0000000000000000(0000) GS:ffff88807d600000(0000) knlGS:0000000000000000
[  265.657838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  265.658680] CR2: 00007fff979b8038 CR3: 000000002e7b0005 CR4: 00000000003606f0
[  265.659748] Call Trace:
[  265.660225]  kprobe_trace_func+0x278/0x360
[  265.661119]  ? trace_hardirqs_on+0x2c/0xd0
[  265.661824]  ? kmem_cache_free+0x1a7/0x1d0
[  265.662366]  ? do_sys_open+0x5/0x220
[  265.662858]  kprobe_dispatcher+0x36/0x50
[  265.663362]  ? do_sys_open+0x1/0x220
[  265.663832]  kprobe_ftrace_handler+0x92/0xf0
[  265.664376]  ftrace_ops_assist_func+0x81/0xf0
[  265.664957]  ? __call_rcu.constprop.49+0xca/0x210
[  265.665583]  0xffffffffc00040bf
[  265.665990]  ? __ia32_sys_open+0x20/0x20
[  265.666502]  ? do_sys_open+0x1/0x220
[  265.667041]  do_sys_open+0x5/0x220
[  265.667483]  do_syscall_64+0x60/0xf0
[  265.667971]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  265.668613] RIP: 0033:0x7ff31f813cdd
[  265.669088] Code: 48 89 54 24 e0 41 83 e2 40 75 32 89 f0 25 00 00 41 00 3d 00 00 41 00 74 24 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 33 f3 c3 66 0f 1f 84 00 00 00 00 00 48 8d 44
[  265.671330] RSP: 002b:00007fff978d8448 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
[  265.672206] RAX: ffffffffffffffda RBX: 000056396c8afa21 RCX: 00007ff31f813cdd
[  265.673065] RDX: 0000000000080000 RSI: 00007ff31f818428 RDI: 00000000ffffff9c
[  265.673887] RBP: ffffffffffffffff R08: 0000000000000000 R09: 0000000000000000
[  265.674680] R10: 0000000000000000 R11: 0000000000000287 R12: 00007ff31fa200a8
[  265.675465] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[  265.676258] Modules linked in:
[  265.676972] ---[ end trace b0d3ddba0b051f18 ]---

The location is:
changbin@laptop:/home/work/linux$ scripts/faddr2line --list vmlinux process_fetch_insn+0x1a3
process_fetch_insn+0x1a3/0x450:

raw_copy_from_user at arch/x86/include/asm/uaccess_64.h:75
 70 		if (!__builtin_constant_p(size))
 71 			return copy_user_generic(dst, (__force void *)src, size);
 72 		switch (size) {
 73 		case 1:
 74 			__uaccess_begin_nospec();
>75<			__get_user_asm_nozero(*(u8 *)dst, (u8 __user *)src,
 76 				      ret, "b", "b", "=q", 1);
 77 			__uaccess_end();
 78 			return ret;
 79 		case 2:
 80 			__uaccess_begin_nospec();

(inlined by) __copy_from_user_inatomic at include/linux/uaccess.h:63
 58 	static __always_inline unsigned long
 59 	__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 60 	{
 61 		kasan_check_write(to, n);
 62 		check_object_size(to, n, false);
>63<		return raw_copy_from_user(to, from, n);
 64 	}
 65 	
 66 	static __always_inline unsigned long
 67 	__copy_from_user(void *to, const void __user *from, unsigned long n)
 68 	{

(inlined by) fetch_store_strlen at kernel/trace/trace_kprobe.c:873
 868 		old_fs = get_fs();
 869 		set_fs(KERNEL_DS);
 870 		pagefault_disable();
 871 	
 872 		do {
>873<			ret = __copy_from_user_inatomic(&c, (u8 *)addr + len, 1);
 874 			len++;
 875 		} while (c && ret == 0 && len < MAX_STRING_SIZE);
 876 	
 877 		pagefault_enable();
 878 		set_fs(old_fs);

(inlined by) process_fetch_insn_bottom at kernel/trace/trace_probe_tmpl.h:91
 86 		s3 = code;
 87 	stage3:
 88 		/* 3rd stage: store value to buffer */
 89 		if (unlikely(!dest)) {
 90 			if (code->op == FETCH_OP_ST_STRING) {
>91<				ret += fetch_store_strlen(val + code->offset);
 92 				code++;
 93 				goto array;
 94 			} else
 95 				return -EILSEQ;
 96 		}

(inlined by) process_fetch_insn at kernel/trace/trace_kprobe.c:954
 949 		default:
 950 			return -EILSEQ;
 951 		}
 952 		code++;
 953 	
>954<		return process_fetch_insn_bottom(code, val, dest, base);
 955 	}
 956 	NOKPROBE_SYMBOL(process_fetch_insn)
 957 	
 958 	/* Kprobe handler */
 959 	static nokprobe_inline void

process_fetch_insn+0x1a3/0x410:

adjust_stack_addr at kernel/trace/trace_uprobe.c:116
 111 		return addr - (n * sizeof(long));
 112 	}
 113 	#else
 114 	static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
 115 	{
>116<		return addr + (n * sizeof(long));
 117 	}
 118 	#endif
 119 	
 120 	static unsigned long get_user_stack_nth(struct pt_regs *regs, unsigned int n)
 121 	{

(inlined by) get_user_stack_nth at kernel/trace/trace_uprobe.c:125
 120 	static unsigned long get_user_stack_nth(struct pt_regs *regs, unsigned int n)
 121 	{
 122 		unsigned long ret;
 123 		unsigned long addr = user_stack_pointer(regs);
 124 	
>125<		addr = adjust_stack_addr(addr, n);
 126 	
 127 		if (copy_from_user(&ret, (void __force __user *) addr, sizeof(ret)))
 128 			return 0;
 129 	
 130 		return ret;

(inlined by) process_fetch_insn at kernel/trace/trace_uprobe.c:212
 207 		switch (code->op) {
 208 		case FETCH_OP_REG:
 209 			val = regs_get_register(regs, code->param);
 210 			break;
 211 		case FETCH_OP_STACK:
>212<			val = get_user_stack_nth(regs, code->param);
 213 			break;
 214 		case FETCH_OP_STACKP:
 215 			val = user_stack_pointer(regs);
 216 			break;
 217 		case FETCH_OP_RETVAL:

> -- Steve
> 
> 
-- 
Cheers,
Changbin Du
