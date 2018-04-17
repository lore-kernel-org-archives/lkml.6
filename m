Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755293AbeDQQkX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755118AbeDQQkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:40:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BBB21838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 17 Apr 2018 12:40:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] tracing/x86: Update syscall trace events to handle new
 x86 syscall func names
Message-ID: <20180417124019.1e4350d5@gandalf.local.home>
In-Reply-To: <20180417163527.GA7775@kernel.org>
References: <20180417115440.2145f7f5@gandalf.local.home>
        <20180417163527.GA7775@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 13:35:27 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:


> [root@jouet ~]# perf test openat
>  2: Detect openat syscall event                           : Ok
>  3: Detect openat syscall event on all cpus               : Ok
> 15: syscalls:sys_enter_openat event fields                : Ok
> [root@jouet ~]#
> 
> [root@jouet ~]# perf trace -e nanosleep,syscalls:*nanosleep sleep 1
>      0.000 (         ): syscalls:sys_enter_nanosleep:rqtp: 0x7ffd9f737950, rmtp: 0x00000000
>      0.009 (         ): sleep/7905 nanosleep(rqtp: 0x7ffd9f737950                                        ) ...
>   1000.204 (         ): syscalls:sys_exit_nanosleep:0x0
>      0.009 (1000.217 ms): sleep/7905  ... [continued]: nanosleep()) = 0
> [root@jouet ~]#
> 
> Works, so the regression seems to be fixed, without looking at the code
> that much:
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

But does this still work on x86_32? I'll test that out. Thanks for
testing, but I may have another patch soon.

-- Steve
