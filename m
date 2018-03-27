Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeC0DCR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 23:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752087AbeC0DCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 23:02:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630142175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Mar 2018 23:02:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        =?UTF-8?B?QW3Dg8Kpcmljbw==?= Wang <xiyou.wangcong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] [RFC] init, tracing: Add initcall trace events
Message-ID: <20180326230212.6892a16f@vmware.local.home>
In-Reply-To: <CAEi0qNnm0uor5T7KWVmA9sUg21FJkvP0HWzCPcRz5QzO4M5Fjw@mail.gmail.com>
References: <20180323150241.878778199@goodmis.org>
        <CAEi0qNnm0uor5T7KWVmA9sUg21FJkvP0HWzCPcRz5QzO4M5Fjw@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 18:50:32 -0700
"Joel Fernandes (Google)" <joel.opensrc@gmail.com> wrote:

> > <idle>-0     [000] ...1     0.000000: initcall_level: level=console
> > <idle>-0     [000] ...1     0.000000: initcall_start: func=con_init+0x0/0x224
> > <idle>-0     [000] ...1     0.000000: initcall_finish: func=con_init+0x0/0x224 ret=0
> > <idle>-0     [000] ...1     0.000000: initcall_start: func=hvc_console_init+0x0/0x19
> > <idle>-0     [000] ...1     0.000000: initcall_finish: func=hvc_console_init+0x0/0x19 ret=0
> > <idle>-0     [000] ...1     0.000000: initcall_start: func=xen_cons_init+0x0/0x60
> > <idle>-0     [000] ...1     0.000000: initcall_finish: func=xen_cons_init+0x0/0x60 ret=0
> > <idle>-0     [000] ...1     0.000000: initcall_start: func=univ8250_console_init+0x0/0x2d
> > <idle>-0     [000] ...1     0.000000: initcall_finish: func=univ8250_console_init+0x0/0x2d ret=0  
> 
> Will this make initcall_debug not work if CONFIG_TRACEPOINTS is turned
> off? Although it builds but I think this initcall_debug feature will

Yeah probably.

> fail, maybe CONFIG_TRACEPOINTS should be selected somewhere?

Agreed. Or I can see if I can find a way to have it fall into its old
behavior when tracepoints are not configured.

-- Steve


> 
> I recently ran into some issues like this for my preemptirq
> tracepoints patch (which I will post again soon :D) where lockdep
> needed the tracepoints and I had to select it.
> 
> thanks,
> 
> - Joel
