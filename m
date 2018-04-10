Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeDJGrw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:47:52 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:43973 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeDJGrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:47:51 -0400
X-Google-Smtp-Source: AIpwx4+96w2fHUui5FqFfCPNAAW3RpWRWqdwi3Emy1km1HK2VezpRXBc+n9Gcg4cRyfGno2KMNGLmw==
Date: Mon, 9 Apr 2018 23:47:48 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andi Kleen <ak@linux.intel.com>
cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, mhocko@kernel.org,
        dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: Re: [PATCH v9 21/24] perf tools: Add support for the SPF perf
 event
In-Reply-To: <20180327034936.GO13724@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1804092346090.225864@chino.kir.corp.google.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com> <1520963994-28477-22-git-send-email-ldufour@linux.vnet.ibm.com> <alpine.DEB.2.20.1803261443560.255554@chino.kir.corp.google.com> <20180327034936.GO13724@tassilo.jf.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018, Andi Kleen wrote:

> > Aside: should there be a new spec_flt field for struct task_struct that 
> > complements maj_flt and min_flt and be exported through /proc/pid/stat?
> 
> No. task_struct is already too bloated. If you need per process tracking 
> you can always get it through trace points.
> 

Hi Andi,

We have

	count_vm_event(PGFAULT);
	count_memcg_event_mm(vma->vm_mm, PGFAULT);

in handle_mm_fault() but not counterpart for spf.  I think it would be 
helpful to be able to determine how much faulting can be done 
speculatively if there is no per-process tracking without tracing.
