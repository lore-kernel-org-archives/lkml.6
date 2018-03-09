Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932114AbeCIPyW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:54:22 -0500
Received: from verein.lst.de ([213.95.11.211]:41341 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751246AbeCIPyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:54:21 -0500
Date: Fri, 9 Mar 2018 16:54:12 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH 2/2] ppc64le save_stack_trace_tsk_reliable (Was:
 HAVE_RELIABLE_STACKTRACE)
Message-ID: <20180309165412.78646b45@blackhole.lan>
In-Reply-To: <20180309084333.23287074@gmail.com>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
        <20171005124313.GA25100@lst.de>
        <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
        <20171017144733.GB2136@lst.de>
        <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
        <20171020120739.GA20306@lst.de>
        <1508547548.5662.2.camel@gmail.com>
        <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
        <20171212113912.GA1907@lst.de>
        <alpine.LSU.2.21.1712121308440.21907@pobox.suse.cz>
        <20180227160924.GA19111@lst.de>
        <20180309084333.23287074@gmail.com>
Organization: LST e.V.
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018 08:43:33 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On Tue, 27 Feb 2018 17:09:24 +0100
> Torsten Duwe <duwe@lst.de> wrote:

> > +save_stack_trace_tsk_reliable(struct task_struct *tsk,
> > +                              struct stack_trace *trace)  
> 
> Just double checking this is called under the task_rq_lock, so its
> safe to call task_stack_page() as opposed to try_get_task_stack()

Yes. IIRC a comment at the call site mentioned it.

[...]
> > +	if (sp < stack_page + sizeof(struct thread_struct)
> > +	    || sp > stack_page + THREAD_SIZE -
> > STACK_FRAME_OVERHEAD)
> > +		return 1;  
> 
> Some of this is already present in validate_sp(), it also validates
> irq stacks, should we just reuse that?

This goes a bit along one of Josh's points; I'll answer there, OK?

[...]

> Looks good to me otherwise.
> 
> Acked-by: Balbir Singh <bsingharora@gmail.com>
Thanks.

	Torsten
