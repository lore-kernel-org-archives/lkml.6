Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeDROgK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752687AbeDROgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:36:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966C2204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 10:36:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH v2] tracing/x86: Update syscall trace events to handle
 new x86 syscall func names
Message-ID: <20180418103606.4118b35f@gandalf.local.home>
In-Reply-To: <20180418125322.GB2895@kernel.org>
References: <20180417130702.01575029@gandalf.local.home>
        <20180417172236.GA17342@light.dominikbrodowski.net>
        <20180417180430.GF3625@kernel.org>
        <20180417181304.GA2895@kernel.org>
        <20180417174128.0f3457f0@gandalf.local.home>
        <20180418125322.GB2895@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 09:53:22 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Apr 17, 2018 at 05:41:28PM -0400, Steven Rostedt escreveu:
> > On Tue, 17 Apr 2018 15:13:04 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:  
> > > Yeah, failing:  
> 
> > > [root@jouet ~]# strace -e openat -e file perf test -F -v "mmap interface" |& grep syscalls
> > > openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getsid/format", O_RDONLY) = 3
> > > openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getppid/format", O_RDONLY) = -1 ENOENT (No such file or directory)  
>  
> > It doesn't have to do with the number of parameters, not everything
> > has "__x64" on it.  
>  
> > Try this patch:  
> 
> Trying...

You're keeping me in suspense!

-- Steve
