Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1634197-1517936296-2-6085299421198964284
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517936296; b=KRID+5Tp4/BRTL0o9HSvkFSAusZQ6pbHgveT/dSweW/phlO
    WdB+EgkUuXCWlVUXHREhXMgHY6WL5RoRRJE7HrwjBTcNZruEhYWMJ5et5+1JydcS
    0t6WgSnhcz8nU+8b39F3lRRIyigWlr4Z8RcDyTACcX54uEdGg7Y8UDvGBKsaMLHe
    Do0IgAzpjFv46VmbRHuSnO4AHISCNJlq/V/KHaZnIplFOq6pGP4BmiEfkNM6jOqD
    7UgU0zDZyAovRIkUW2fq9YSzi0tnaNGHbhUGkTNhF35mz/ojzJFsHaNAv8zwxTlY
    Ff0YmrIJRLF8Rw/38YC8chF4ABfvpcNiI7Sgp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517936296; bh=fLC2nFjAYgepxZhjRmS78Uq2P4PqaCofgVmsLSR1QuM=; b=x
    EM7A/i1/402BhiaNVS7YXCoBa8UAjNn2dR5Ntdh1jfVni1EwmUcizdHjcQ+OwXjf
    yT9hw42G9BMfpeI2Fl7jlFQ8mz4QQaIhEu4CcJ8ERmFlRA2Sd3KGzKKScD24Nuh0
    qyNY8v4u38NlzZ7BthiB30kkwRUudbPG6dOtID2vb2MuuFPM/HuDLfemyRwKs790
    U078IelKSCEHu/G9ppPEoWqmb1FIFhJWn8elHVBfOSKWIIfvXv8lIOu4eqPbqSBc
    QqNNCD4ZRxNT4KzzwuXDXees0AIuYoNAE1bbJ9V5cqxxjtz2Bo9HKUw6dVN8SxDA
    D95RdGoPWO+mzhySvNtiA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752977AbeBFQ6M (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 11:58:12 -0500
Received: from mail.efficios.com ([167.114.142.141]:40934 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeBFQ5e (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Feb 2018 11:57:34 -0500
Date: Tue, 6 Feb 2018 16:58:04 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        maged michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        linux-api <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <939962083.17018.1517936284383.JavaMail.zimbra@efficios.com>
In-Reply-To: <1517935908-19474-1-git-send-email-mathieu.desnoyers@efficios.com>
References: <1517935908-19474-1-git-send-email-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] membarrier-sync-core: Document architecture support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Topic: membarrier-sync-core: Document architecture support
Thread-Index: GaPiPkGpUOkhS+THRkP8ODe0XY15LA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Feb 6, 2018, at 11:51 AM, efficios efficios@ubuntu.efficios.com wrote:

> Ensure we gather architecture requirements about each architecture supporting
> the "sync_core" membarrier command in a single file under
> Documentation/features.
> 
> [ This patch applies on top of tip sched/core. ]

please disregard this email. I will fix my git config on this dev machine and
re-send.

Thanks,

Mathieu

> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Andrew Hunter <ahh@google.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Avi Kivity <avi@scylladb.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Dave Watson <davejwatson@fb.com>
> Cc: David Sehr <sehr@google.com>
> Cc: Greg Hackmann <ghackmann@google.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Maged Michael <maged.michael@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-api@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> ---
> .../sched/membarrier-sync-core/arch-support.txt    | 62 ++++++++++++++++++++++
> 1 file changed, 62 insertions(+)
> create mode 100644
> Documentation/features/sched/membarrier-sync-core/arch-support.txt
> 
> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> new file mode 100644
> index 0000000..2c815a7
> --- /dev/null
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -0,0 +1,62 @@
> +#
> +# Feature name:          membarrier-sync-core
> +#         Kconfig:       ARCH_HAS_MEMBARRIER_SYNC_CORE
> +#         description:   arch supports core serializing membarrier
> +#
> +# Architecture requirements
> +#
> +# * arm64
> +#
> +# Rely on eret context synchronization when returning from IPI handler, and
> +# when returning to user-space.
> +#
> +# * x86
> +#
> +# x86-32 uses IRET as return from interrupt, which takes care of the IPI.
> +# However, it uses both IRET and SYSEXIT to go back to user-space. The IRET
> +# instruction is core serializing, but not SYSEXIT.
> +#
> +# x86-64 uses IRET as return from interrupt, which takes care of the IPI.
> +# However, it can return to user-space through either SYSRETL (compat code),
> +# SYSRETQ, or IRET.
> +#
> +# Given that neither SYSRET{L,Q}, nor SYSEXIT, are core serializing, we rely
> +# instead on write_cr3() performed by switch_mm() to provide core serialization
> +# after changing the current mm, and deal with the special case of kthread ->
> +# uthread (temporarily keeping current mm into active_mm) by issuing a
> +# sync_core_before_usermode() in that specific case.
> +#
> +    -----------------------
> +    |         arch |status|
> +    -----------------------
> +    |       alpha: | TODO |
> +    |         arc: | TODO |
> +    |         arm: | TODO |
> +    |       arm64: |  ok  |
> +    |    blackfin: | TODO |
> +    |         c6x: | TODO |
> +    |        cris: | TODO |
> +    |         frv: | TODO |
> +    |       h8300: | TODO |
> +    |     hexagon: | TODO |
> +    |        ia64: | TODO |
> +    |        m32r: | TODO |
> +    |        m68k: | TODO |
> +    |       metag: | TODO |
> +    |  microblaze: | TODO |
> +    |        mips: | TODO |
> +    |     mn10300: | TODO |
> +    |       nios2: | TODO |
> +    |    openrisc: | TODO |
> +    |      parisc: | TODO |
> +    |     powerpc: | TODO |
> +    |        s390: | TODO |
> +    |       score: | TODO |
> +    |          sh: | TODO |
> +    |       sparc: | TODO |
> +    |        tile: | TODO |
> +    |          um: | TODO |
> +    |   unicore32: | TODO |
> +    |         x86: |  ok  |
> +    |      xtensa: | TODO |
> +    -----------------------
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
