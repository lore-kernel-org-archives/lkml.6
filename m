Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeEEPiX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 11:38:23 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33369 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbeEEPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 11:38:22 -0400
X-Google-Smtp-Source: AB8JxZr0LnTSkBWmGYPOKFyteKAG3Y75euqE83sDix0yl3AJMbZgWEhJ1QLtd538pxHv2bNY0/N4kQ==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Sat, 5 May 2018 11:38:16 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: perf: fuzzer causes stack going in wrong direction warnings
In-Reply-To: <20180504162557.iodmglq3duomz6c2@treble>
Message-ID: <alpine.DEB.2.21.1805051134230.11518@macbook-air>
References: <20180109170716.bqmexpmywwr4bwuv@treble> <20180111052538.2qhj6oxnc24xumhk@treble> <alpine.DEB.2.21.1801111358580.22460@macbook-air> <20180111192112.d35nkotzklicd27c@treble> <alpine.DEB.2.21.1805010925140.19413@macbook-air> <20180501135850.enx4waqd5d7yowlj@treble>
 <alpine.DEB.2.21.1805011557240.19937@macbook-air> <20180501220458.p3rgwzh3jcqt4jmm@treble> <20180502205009.codkvscnh4j4hm6b@treble> <alpine.DEB.2.21.1805041033230.6376@macbook-air> <20180504162557.iodmglq3duomz6c2@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018, Josh Poimboeuf wrote:
> 
> The 'nmi_restore' warning points to a bug in my patch, but the others
> are head scratchers.  Here's a patch which combines the first two
> patches, plus improves the existing warnings a bit.  Can you try it?

with that updated patch I hit

May  4 21:51:20 haswell kernel: [19245.450607] WARNING: stack recursion on stack type 2
May  4 22:21:29 haswell kernel: [21055.268717] WARNING: can't dereference registers at 000000006546ba71 for ip ret_from_intr+0x6/0x1d
May  4 22:36:22 haswell kernel: [21948.106762] WARNING: stack going in the wrong direction? ip=native_sched_clock+0xe/0x90
May  4 22:36:22 haswell kernel: [21948.115377] WARNING: stack going in the wrong direction? ip=native_sched_clock+0xe/0x90
May  4 22:36:22 haswell kernel: [21948.124086] WARNING: stack going in the wrong direction? ip=native_sched_clock+0xd/0x90
May  4 22:36:22 haswell kernel: [21948.124088] WARNING: stack going in the wrong direction? ip=intel_pmu_handle_irq+0x12/0x4a0
May  4 22:36:22 haswell kernel: [21948.124097] WARNING: stack going in the wrong direction? ip=native_sched_clock+0xe/0x90
May  4 22:36:22 haswell kernel: [21948.150189] WARNING: stack going in the wrong direction? ip=native_sched_clock+0xe/0x90
May  4 22:36:22 haswell kernel: [21948.150199] WARNING: stack going in the wrong direction? ip=intel_pmu_handle_irq+0xe/0x4a0

the last bit repeated for a few minutes (flooding the log with a few 
thousand entries that look mostly similar)

Vince
