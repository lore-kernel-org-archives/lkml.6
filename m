Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeFEMvO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:51:14 -0400
Received: from mail.efficios.com ([167.114.142.138]:42448 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeFEMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:51:12 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 87150225E49
Date: Tue, 5 Jun 2018 08:51:11 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <570482053.5560.1528203071391.JavaMail.zimbra@efficios.com>
In-Reply-To: <874lihbykr.fsf@concordia.ellerman.id.au>
References: <20180602124408.8430-1-mathieu.desnoyers@efficios.com> <20180602124408.8430-11-mathieu.desnoyers@efficios.com> <874lihbykr.fsf@concordia.ellerman.id.au>
Subject: Re: [RFC PATCH for 4.18 10/16] powerpc: Wire up restartable
 sequences system call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: powerpc: Wire up restartable sequences system call
Thread-Index: pN6BzPNNAeLWTVSDZTr/PQsyIxZcyA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 5, 2018, at 1:18 AM, Michael Ellerman mpe@ellerman.id.au wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> 
>> From: Boqun Feng <boqun.feng@gmail.com>
>>
>> Wire up the rseq system call on powerpc.
>>
>> This provides an ABI improving the speed of a user-space getcpu
>> operation on powerpc by skipping the getcpu system call on the fast
>> path, as well as improving the speed of user-space operations on per-cpu
>> data compared to using load-reservation/store-conditional atomics.
>>
>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Michael Ellerman <mpe@ellerman.id.au>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> CC: linuxppc-dev@lists.ozlabs.org
>> ---
>>  arch/powerpc/include/asm/systbl.h      | 1 +
>>  arch/powerpc/include/asm/unistd.h      | 2 +-
>>  arch/powerpc/include/uapi/asm/unistd.h | 1 +
>>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> Looks fine to me.
> 
> I don't have any other new syscalls in my next, so this should not
> conflict with anything for 4.18.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Added your ack to the series, thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
