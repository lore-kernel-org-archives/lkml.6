Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeEFCtA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 22:49:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:35106 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751833AbeEFCs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 22:48:58 -0400
Message-ID: <cafd11f9b594903ff1f0acc4d7e7f7453aeb971f.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] locking/atomics/powerpc: Introduce optimized
 cmpxchg_release() family of APIs for PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, will.deacon@arm.com
Date: Sun, 06 May 2018 11:56:44 +1000
In-Reply-To: <20180505100055.yc4upauxo5etq5ud@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
         <20180504173937.25300-2-mark.rutland@arm.com>
         <20180504180105.GS12217@hirez.programming.kicks-ass.net>
         <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
         <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
         <20180505084721.GA32344@noisy.programming.kicks-ass.net>
         <20180505090403.p2ywuen42rnlwizq@gmail.com>
         <20180505093829.xfylnedwd5nonhae@gmail.com>
         <20180505100055.yc4upauxo5etq5ud@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-05-05 at 12:00 +0200, Ingo Molnar wrote:
> This clearly suggests that PPC_RELEASE_BARRIER is in active use and 'lwsync' is 
> the 'release barrier' instruction, if I interpreted that right.

The closest to one we got.

The semantics are that it orders all load/store pairs to cachable
storage except store+load.

Cheers,
Ben.
