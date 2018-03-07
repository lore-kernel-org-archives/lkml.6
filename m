Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933183AbeCGCAo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 21:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932078AbeCGCAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 21:00:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9697F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Mar 2018 21:00:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Kao <alankao@andestech.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "sw-dev@groups.riscv.org" <sw-dev@groups.riscv.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greentime Ying-Han =?UTF-8?B?SHU=?=(=?UTF-8?B?6IOh6Iux5ryi?=)"
        <greentime@andestech.com>,
        "Zong Zong-Xian =?UTF-8?B?TGk=?=( =?UTF-8?B?5p2O5a6X5oay?=)"
        <zong@andestech.com>
Subject: Re: ftrace: Proposal for an Alternative RecordMcount framework
Message-ID: <20180306210041.56736b13@vmware.local.home>
In-Reply-To: <20180307014746.GA25460@andestech.com>
References: <20180227100425.GB20904@andestech.com>
        <20180227161252.25162d81@vmware.local.home>
        <20180301020507.GA24550@andestech.com>
        <20180307014746.GA25460@andestech.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2018 09:47:47 +0800
Alan Kao <alankao@andestech.com> wrote:


> > Please allow me to state the problem more clearly here.  I hope this helps.
> > 
> > 1. locations of mcount are recorded in a per-file basis.
> > 2. to optimize the binary, the linker turns on some aggressive
> >    options, including relaxation.
> > 3. the optimizations changes the original offset.
> > 4. already recorded mcount call-sites no longer point to their
> >    real positions.
> > 5. still a linked vmlinux is made.
> > 6. dynamic ftrace breaks the real logic in the kernel space,
> >    panics happen.
> > 
> > Thanks,
> > Alan  
> 
> Any comments on this?

Sorry, I've been traveling and falling behind in this. I did read this
when I was offline but forgot to reply when I was back online.

> 
> BTW, the introduced framework has no effects on any other architectures that
> works fine.  This feature should be configurable and turned on only when the
> arch has aggressive link-time optimizations.
> 
> If you consider this appropriate, I will send the patch to this once it gets 
> ready.  Currently this is targeting at RISC-V and upcoming NDS32.

I see the issue you explained above and it makes sense. Perhaps make it
an option that can be enabled by anyone, and archs that require
aggressive link time optimizations would just select it.

-- Steve
