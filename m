Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeEDOf6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:35:58 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46303 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbeEDOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:35:56 -0400
X-Google-Smtp-Source: AB8JxZoSSGdeeEB9zXRG0iDuNAsy59QGF7FQo3MS8cqF9eAKZ4Z7pY8gPilgZ8ZkHa8mraolKnJVWA==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Fri, 4 May 2018 10:35:53 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: perf: fuzzer causes stack going in wrong direction warnings
In-Reply-To: <20180502205009.codkvscnh4j4hm6b@treble>
Message-ID: <alpine.DEB.2.21.1805041033230.6376@macbook-air>
References: <alpine.DEB.2.21.1801091052010.16446@macbook-air> <20180109160551.GK3040@hirez.programming.kicks-ass.net> <20180109170716.bqmexpmywwr4bwuv@treble> <20180111052538.2qhj6oxnc24xumhk@treble> <alpine.DEB.2.21.1801111358580.22460@macbook-air>
 <20180111192112.d35nkotzklicd27c@treble> <alpine.DEB.2.21.1805010925140.19413@macbook-air> <20180501135850.enx4waqd5d7yowlj@treble> <alpine.DEB.2.21.1805011557240.19937@macbook-air> <20180501220458.p3rgwzh3jcqt4jmm@treble>
 <20180502205009.codkvscnh4j4hm6b@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018, Josh Poimboeuf wrote:

> After looking closer, I realized that at least some of these warnings
> are due to bad unwind hints in the entry code.  Can you try this patch
> instead of the last one?

with just this new patch applied I still get warnings such as this:

[  469.436218] WARNING: can't dereference registers at 00000000886d9235 for ip apic_timer_interrupt+0xa/0x20
[  790.499655] WARNING: stack recursion on stack type 2
[  790.907092] WARNING: stack going in the wrong direction? ip=native_sched_clock+0x9/0x90
[ 3632.876656] WARNING: can't dereference iret registers at 000000001754e5aa for ip nmi_restore+0x16/0x2b
[ 3650.161250] WARNING: missing regs for base reg R10 at ip native_sched_clock+0xd/0x90


Vince
