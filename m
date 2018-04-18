Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDRSRh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:17:37 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:42138 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeDRSRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:17:35 -0400
Date: Wed, 18 Apr 2018 20:17:29 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v3] tracing/x86: Update syscall trace events to handle
 new prefixed syscall func names
Message-ID: <20180418181729.GA4816@light.dominikbrodowski.net>
References: <20180418114509.5a76847d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418114509.5a76847d@gandalf.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Apr 18, 2018 at 11:45:09AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Arnaldo noticed that the latest kernel is missing the syscall event system
> directory in x86. I bisected it down to d5a00528b58c ("syscalls/core,
> syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()").
> 
> The system call trace events are special, as there is only one trace event
> for all system calls (the raw_syscalls). But a macro that wraps the system
> calls creates meta data for them that copies the name to find the system
> call that maps to the system call table (the number). At boot up, it does a
> kallsyms lookup of the system call table to find the function that maps to
> the meta data of the system call. If it does not find a function, then that
> system call is ignored.
> 
> Because the x86 system calls had "__x64_", or "__ia32_" prefixed to the
> "sys" for the names, they do not match the default compare algorithm. As
> this was a problem for power pc, the algorithm can be overwritten by the
> architecture. The solution is to have x86 have its own algorithm to do the
> compare and this brings back the system call trace events.
> 
> Link: http://lkml.kernel.org/r/20180417174128.0f3457f0@gandalf.local.home
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Fixes: d5a00528b58c ("syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
