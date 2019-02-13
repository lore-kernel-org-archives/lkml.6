Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9325DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0A7222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMpNSrHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbfBMOgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:36:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37096 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfBMOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:36:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so1261425plr.4;
        Wed, 13 Feb 2019 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3iyM2fZKefZzUUsrwmk4c6GtpEA0z2wk8MdSqpfpz0w=;
        b=qMpNSrHOXOlLOQ3trPq4fuZrqAJtpbb3cQhAACfxARiM74jWIuF+/ixt+8tNgarLUt
         zmTCPqf8+4rHV6hbFFHTbyAVKs3SkbQZBZayMUNKxps/RSPky7u19KC2AVg/llRBv+EG
         ia1t2yZabWcaiOMjoxWGa9IhT/IWJUFW4PM8SRZY8UqBAtAi9bbOycfRCQQYevRkblID
         1+yDN1pbqXZSnVaN+4TKW8d1W6BuYGlI/vCesJjH2mgAtqd1rLUsy4kqW1LSNyZVshJo
         cyUX5UV4WGE/m+7X7wwM0pQ6LTXzBgSHtpK+/1sq/spv0RCcQpQlcFkUb/4lyKevM2CR
         ua3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3iyM2fZKefZzUUsrwmk4c6GtpEA0z2wk8MdSqpfpz0w=;
        b=GIGN9RUgIJLw0/QL5lggIS6DRCtSP3vQPcz/gXsQ3z6k3eL86qa8bF4EOsHHqiNIEH
         S1U+J1KbifqDsBNB5DcctbJSukQ7hOuNZ2Ki7Z4HDDus106meRdi1hXlFIl0oVy3nk+m
         cagjJEjKgtKhBlJr1BKm9UfoN6gnJGfqaCWiY4LSumjCWoxsd8cJyzZV80n4gyzkV6vQ
         af80cx4981iNwETcysXm1KDDTs07LD1Z/l1m+fKFcTqkGVzVbLtm1YDis9NXUx8yZsSP
         Q3dDVHu6Nu8VY7NfNnl8ZXDt7VC5xx+92XwV/emEaIFI6Wcxh4wnlkYgsVkh7tlaBPam
         Xhpg==
X-Gm-Message-State: AHQUAubVbK75BZ3b9XK0691lNVdnasnW88sZHyKU/95kS1O+as76cEEN
        BIJQz70EGhwGNyviPg6lkn8=
X-Google-Smtp-Source: AHgI3Ib8V+FGq+L3wmnjLwIDPezCD6Cx/wa3vkL+mU9nFVgyDD7CF072mzm0DEH/mwAL5PQaMRJAhA==
X-Received: by 2002:a17:902:778d:: with SMTP id o13mr852211pll.234.1550068608736;
        Wed, 13 Feb 2019 06:36:48 -0800 (PST)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 64sm20634564pfl.83.2019.02.13.06.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 06:36:47 -0800 (PST)
Date:   Wed, 13 Feb 2019 22:36:40 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Changbin Du <changbin.du@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kprobe: safely access memory specified by userspace
Message-ID: <20190213143638.y54hghilbyastlpo@mail.google.com>
References: <20190125151051.7381-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125151051.7381-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
I think this is a critical issue. Could you give priority to this fix?

On Fri, Jan 25, 2019 at 11:10:50PM +0800, Changbin Du wrote:
> The userspace can ask kprobe to intercept strings at any memory address,
> including invalid kernel address. In this case, fetch_store_strlen()
> would crash since it uses general usercopy function.
> 
> For example, we can crash the kernel by doing something as below:
> 
> $ sudo kprobe 'p:do_sys_open +0(+0(%si)):string'
> 
> [  103.620391] BUG: GPF in non-whitelisted uaccess (non-canonical address?)
> [  103.622104] general protection fault: 0000 [#1] SMP PTI
> [  103.623424] CPU: 10 PID: 1046 Comm: cat Not tainted 5.0.0-rc3-00130-gd73aba1-dirty #96
> [  103.625321] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-2-g628b2e6-dirty-20190104_103505-linux 04/01/2014
> [  103.628284] RIP: 0010:process_fetch_insn+0x1ab/0x4b0
> [  103.629518] Code: 10 83 80 28 2e 00 00 01 31 d2 31 ff 48 8b 74 24 28 eb 0c 81 fa ff 0f 00 00 7f 1c 85 c0 75 18 66 66 90 0f ae e8 48 63
>  ca 89 f8 <8a> 0c 31 66 66 90 83 c2 01 84 c9 75 dc 89 54 24 34 89 44 24 28 48
> [  103.634032] RSP: 0018:ffff88845eb37ce0 EFLAGS: 00010246
> [  103.635312] RAX: 0000000000000000 RBX: ffff888456c4e5a8 RCX: 0000000000000000
> [  103.637057] RDX: 0000000000000000 RSI: 2e646c2f6374652f RDI: 0000000000000000
> [  103.638795] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [  103.640556] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [  103.642297] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  103.644040] FS:  0000000000000000(0000) GS:ffff88846f000000(0000) knlGS:0000000000000000
> [  103.646019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  103.647436] CR2: 00007ffc79758038 CR3: 0000000463360006 CR4: 0000000000020ee0
> [  103.649147] Call Trace:
> [  103.649781]  ? sched_clock_cpu+0xc/0xa0
> [  103.650747]  ? do_sys_open+0x5/0x220
> [  103.651635]  kprobe_trace_func+0x303/0x380
> [  103.652645]  ? do_sys_open+0x5/0x220
> [  103.653528]  kprobe_dispatcher+0x45/0x50
> [  103.654682]  ? do_sys_open+0x1/0x220
> [  103.655875]  kprobe_ftrace_handler+0x90/0xf0
> [  103.657282]  ftrace_ops_assist_func+0x54/0xf0
> [  103.658564]  ? __call_rcu+0x1dc/0x280
> [  103.659482]  0xffffffffc00000bf
> [  103.660384]  ? __ia32_sys_open+0x20/0x20
> [  103.661682]  ? do_sys_open+0x1/0x220
> [  103.662863]  do_sys_open+0x5/0x220
> [  103.663988]  do_syscall_64+0x60/0x210
> [  103.665201]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  103.666862] RIP: 0033:0x7fc22fadccdd
> [  103.668034] Code: 48 89 54 24 e0 41 83 e2 40 75 32 89 f0 25 00 00 41 00 3d 00 00 41 00 74 24 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff
>  ff 0f 05 <48> 3d 00 f0 ff ff 77 33 f3 c3 66 0f 1f 84 00 00 00 00 00 48 8d 44
> [  103.674029] RSP: 002b:00007ffc7972c3a8 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
> [  103.676512] RAX: ffffffffffffffda RBX: 0000562f86147a21 RCX: 00007fc22fadccdd
> [  103.678853] RDX: 0000000000080000 RSI: 00007fc22fae1428 RDI: 00000000ffffff9c
> [  103.681151] RBP: ffffffffffffffff R08: 0000000000000000 R09: 0000000000000000
> [  103.683489] R10: 0000000000000000 R11: 0000000000000287 R12: 00007fc22fce90a8
> [  103.685774] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
> [  103.688056] Modules linked in:
> [  103.689131] ---[ end trace 43792035c28984a1 ]---
> 
> This can be fixed by using probe_mem_read() instead.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  kernel/trace/trace_kprobe.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index d5fb09ebba8b..9eaf07f99212 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -861,22 +861,14 @@ static const struct file_operations kprobe_profile_ops = {
>  static nokprobe_inline int
>  fetch_store_strlen(unsigned long addr)
>  {
> -	mm_segment_t old_fs;
>  	int ret, len = 0;
>  	u8 c;
>  
> -	old_fs = get_fs();
> -	set_fs(KERNEL_DS);
> -	pagefault_disable();
> -
>  	do {
> -		ret = __copy_from_user_inatomic(&c, (u8 *)addr + len, 1);
> +		ret = probe_mem_read(&c, (u8 *)addr + len, 1);
>  		len++;
>  	} while (c && ret == 0 && len < MAX_STRING_SIZE);
>  
> -	pagefault_enable();
> -	set_fs(old_fs);
> -
>  	return (ret < 0) ? ret : len;
>  }
>  
> -- 
> 2.19.1
> 

-- 
Cheers,
Changbin Du
