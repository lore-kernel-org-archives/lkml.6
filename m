Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BE3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8662087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Insi8KhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfAGR2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:28:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36196 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfAGR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:28:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so1718816wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5CQKOvPWttDZY0VU1jt6gpwFAxeXcKCJjLZJt7iyGWM=;
        b=Insi8KhDGSFVIYljffZe18Dxn8LST09VxRvMWsG9kIJ1RxN75TQDuLw1b83COfuPWN
         3GHfxhZVKdwQ2RYgZmidcGrWRdrlIYxp+DKUnqTH+v25Ai/adhr9cf73vvY+Pp8ML8tc
         Dh0q9vCNrrXny/3AEQsxrw1QotV2umVNEXDTsEyI+79IRCgN+s9aQRzBr/HawzWGDE1o
         4RuiNf+dN0AFis5Xd0Xp0LWcobGOaCnntFRsqk4dB+awrFIT4IFW1AHJcJ7vuZnmDmNw
         5M5DmH//I8bFCc+MKIckN+r2GM1snjdzAoHv63wKHJLSQxIiq8YmrDabSc1MZ5eorhh8
         RiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5CQKOvPWttDZY0VU1jt6gpwFAxeXcKCJjLZJt7iyGWM=;
        b=nKIGnX1rzE4PjgMI2fvIfZKcMMj7Eh2IIgNey+z8N5n3DHhI1WHi+0O2dT75RTzzgv
         Asdv5T2PtNLeThzjX5giOQaG+s3eRc9vrUAAxhdfapFbuOaS51Skuw+/0cM+WPd94uVr
         6Huopa0xDCKXPc673ce2AJyC8fvXlGvY53p0xSjVfb1SMuQd7wOZ9k+UQruTaiHOvC6D
         UW1u0q0ptRF1FkPVMTZ6L23EdCdl1LSLtjLTiNU/4seLY45m3MHCmZq+8ym2bezQeHcB
         6OtO6zZt/HsGCCsPNAQIjcaIDpFBr+w3kF1RBxoPGZkrlc6hjvKNDOUCQSI4dwtBZewi
         Cw+g==
X-Gm-Message-State: AJcUukfW5UVjWKVi7Ug9V/xGiSlfeNCUP6TJh4vdmts/BJUh8BVesCZQ
        XnUii6q3TzroIvIuCMqLUw==
X-Google-Smtp-Source: ALg8bN6xMpPLbwDg97EYL1DVy6fovHjbzCFdR/D2Veu6YCRVXE8ADjR/kucfujs+GQT55n2pX8yDuQ==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr9281939wmg.55.1546882111098;
        Mon, 07 Jan 2019 09:28:31 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id e16sm59709081wrn.72.2019.01.07.09.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 09:28:30 -0800 (PST)
Date:   Mon, 7 Jan 2019 18:28:29 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] kprobes: Fix kretprobe incorrect stacking order
 problem
Message-ID: <20190107172829.GB1944@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154686789378.15479.2886543882215785247.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:31:34PM +0900, Masami Hiramatsu wrote:
> Hello,
> 
> On recent talk with Andrea, I started more precise investigation on
> the kernel panic with kretprobes on notrace functions, which Francis
> had been reported last year ( https://lkml.org/lkml/2017/7/14/466 ).
> 
> At first, I tried to reproduce the issue. I picked up __fdget and
> ftrace_ops_assist_func as probed functions.
> With CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, I could reproduce the kernel
> panic as below.
> 
> =====
> /sys/kernel/debug/tracing # echo "r:event_1 __fdget" >> kprobe_events 
> /sys/kernel/debug/tracing # echo "r:event_2 ftrace_ops_assist_func" >> kprobe_events
> /sys/kernel/debug/tracing # echo 1 > events/kprobes/enable 
> [   70.491856] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> [   70.493203] PGD 800000001c62e067 P4D 800000001c62e067 PUD 1b5bf067 PMD 0 
> [   70.494247] Oops: 0010 [#1] PREEMPT SMP PTI
> [   70.494918] CPU: 6 PID: 1210 Comm: sh Not tainted 4.20.0-rc3+ #58
> [   70.495931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
> [   70.497906] RIP: 0010:0x10
> [   70.498465] Code: Bad RIP value.
> [   70.499077] RSP: 0018:ffffb1d4c0347e78 EFLAGS: 00010246
> [   70.499959] RAX: 00000000fffffff7 RBX: 0000000000000000 RCX: 0000000000000000
> [   70.501383] RDX: ffff88f19f9c4f80 RSI: ffffffffb7d75e12 RDI: ffffffffb7d0ede7
> [   70.502501] RBP: 00007ffc7061af20 R08: 0000000080000002 R09: ffff88f19f9c4f80
> [   70.503698] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000005401
> [   70.504810] R13: 0000000000000000 R14: ffffb1d4c0347f58 R15: 0000000000000000
> [   70.506028] FS:  0000000000922880(0000) GS:ffff88f19d380000(0000) knlGS:0000000000000000
> [   70.507354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   70.508271] CR2: ffffffffffffffe6 CR3: 000000001f916000 CR4: 00000000000006e0
> [   70.509419] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   70.510803] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   70.511748] Call Trace:
> [   70.512225]  ? ksys_ioctl+0x70/0x70
> [   70.512884]  ? __fdget+0x5/0x10
> [   70.513454]  ? __fdget+0x5/0x10
> [   70.513980]  ? copy_oldmem_page_encrypted+0x20/0x20
> [   70.514815]  ? __x64_sys_ioctl+0x16/0x20
> [   70.515596]  ? do_syscall_64+0x50/0x100
> [   70.516229]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   70.517143] Modules linked in:
> [   70.517806] CR2: 0000000000000010
> [   70.518527] ---[ end trace ece844ac05189f10 ]---
> [   70.519417] RIP: 0010:0x10
> [   70.520026] Code: Bad RIP value.
> [   70.520800] RSP: 0018:ffffb1d4c0347e78 EFLAGS: 00010246
> [   70.521948] RAX: 00000000fffffff7 RBX: 0000000000000000 RCX: 0000000000000000
> [   70.523315] RDX: ffff88f19f9c4f80 RSI: ffffffffb7d75e12 RDI: ffffffffb7d0ede7
> [   70.524515] RBP: 00007ffc7061af20 R08: 0000000080000002 R09: ffff88f19f9c4f80
> [   70.525702] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000005401
> [   70.526715] R13: 0000000000000000 R14: ffffb1d4c0347f58 R15: 0000000000000000
> [   70.527673] FS:  0000000000922880(0000) GS:ffff88f19d380000(0000) knlGS:0000000000000000
> [   70.528896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   70.529851] CR2: ffffffffffffffe6 CR3: 000000001f916000 CR4: 00000000000006e0
> [   70.530922] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   70.531907] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Killed
> =====
> 
> This seems the kernel is trying to execute incorrect address.
> 
> Next, I focused on the combination of probes. From Francis's report,
> this issue caused by the combination of kretprobes, not kprobes.
> I ensured that was true.
> 
> r __fdget & r ftrace_ops_assist_func => NG
> p __fdget & p ftrace_ops_assist_func => OK
> p __fdget & r ftrace_ops_assist_func => OK
> r __fdget & p ftrace_ops_assist_func => OK
> 
> r: kretprobe, p: kprobe
> 
> This gave me a hint of what happened. I can explain the cause of this
> issue as below;
>  
> Correct processing of kretprobe on probed-function.
> 
> <caller>
>  -><probed-function>
>    ->fentry
>     ->ftrace_ops_assist_func()
>      ->kprobe_ftrace_handler()
>       ...->pre_handler_kretprobe()
>            push the return address (caller) of probed-function to top of the
>            kretprobe list and replace it with kretprobe_trampoline.
>     <-(ftrace_ops_assist_func())
>    <-(fentry)
>   <-(probed-function)
> [kretprobe_trampoline]
>  ->tampoline_handler()
>    pop the return address (caller) from top of the kretprobe list
>  <-(trampoline_handler())
> <caller>
> 
> When we put a kretprobe on ftrace_ops_assist_func(), below happens
> 
> <caller>
>  -><probed-function>
>    ->fentry
>     ->ftrace_ops_assist_func()
>      ->int3
>       ->kprobe_int3_handler()
>       ...->pre_handler_kretprobe()
>            push the return address (*fentry*) of ftrace_ops_assist_func() to
>            top of the kretprobe list and replace it with kretprobe_trampoline.
>       <-kprobe_int3_handler()
>      <-(int3)
>      ->kprobe_ftrace_handler()
>       ...->pre_handler_kretprobe()
>            push the return address (caller) of probed-function to top of the
>            kretprobe list and replace it with kretprobe_trampoline.
>      <-(kprobe_ftrace_handler())
>     <-(ftrace_ops_assist_func())
>     [kretprobe_trampoline]
>      ->tampoline_handler()
>        pop the return address (caller) from top of the kretprobe list
>      <-(trampoline_handler())
>     <caller>
>     [run caller with incorrect stack information]
>    <-(<caller>)
>   !!KERNEL PANIC!!
> 
> Therefore, this kernel panic happens only when we put 2 k*ret*probes on
> ftrace_ops_assist_func() and other functions. If we put kprobes, it
> doesn't cause any issue, since it doesn't change the return address.
> 
> To fix (or just avoid) this issue, we can introduce a frame pointer
> verification to skip wrong order entries. And I also would like to
> blacklist those functions because those are part of ftrace-based 
> kprobe handling routine.
> 
> BTW, this is not all of issues. To remove CONFIG_KPROBE_EVENTS_ON_NOTRACE
> I'm trying to find out other notrace functions which can cause
> kernel crash by probing. Mostly done on x86, so I'll post it
> after this series.
> 
> Thank you,

Apart than the missing include <linux/kprobes.h> in PATCH 2/2
everything else looks good to me.

Tested-by: Andrea Righi <righi.andrea@gmail.com>

Thanks!
-Andrea
