Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1127333-1526519716-2-3984662689080664859
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526519715; b=JAPaSQ0y8KkNg4P0ws3U9cB5YKxU1Ef51mySrys6Mr3p3svD4h
    y14zXWkjMylf3ItOPSjbjCx/apl1xW60G5lYJFYXBfaPM/O2zlOJgLvNzsyeuA7W
    r/R8QGlDvLSeL/aefsF2thnh8615yNZKlKRFwiA1kYYw0vYLo0u/oF/QVhBJeesD
    +AxyeLna0md0CCD5KskAwqvpbXyzJN4siudMLmrFoRLvuP9aChf+sQ7GNenyFGax
    11Vex/SUNOcv3lxH5WQ4xMQD+o0QikAkWAWT5SNzfpmYF5UAWxCuMfnIfSbNfS8G
    FgBY3JxmEus/LC89xF/QD+p1gx7uUzeUUGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526519715; bh=DueShaZ7c74bB33a+YmXbThDooASZ4
    wLersU3Ex/Ijw=; b=JXfeP8ZbqEkleZvgHgsQ1B9ssf0BMh2RiouGI/8C3kQHok
    66HAEoKwM0KBmz/g5TEZMYL0SxCxJIuzpwvzfZj0mtZCO8llO0s2PH8hnTRgG9XI
    A2L51qIfMIRl/nwwAXMuOa3mrcwPzClgJAkrTzlJZ9311Sf66PIFsWkaWukqmCQy
    owJiBTShflFDVnjQ8aoxoSefAQWDhFtU2OhzULm34iiDo9ivnwO2lJmraTsWD0yT
    Iv8Qs16Ft4/Lue402wTZxb0wDLyqfxg72YvG/SGce8EoTHbyYAU8aUF377RnFYmC
    ympLmK3gjujyWPO+IWOdmlDT7kIPFQeP0QzRx1Zg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=unFQnbIo x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=howf7xkm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=unFQnbIo x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=howf7xkm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMlmvUUzFf900lZDSzvtW4LK37dY35dImLUWbG6r740J6zdsVcgS2EA4TWbbaq+CQgdbKIi6tP0gu0AAyC9TyaYPvyzDFnWieSGaJz7ouvpQ+TCil41j
    hOK/ENDUjbofoKJ3Lw2jFx4DGBfv3fd4XTdVTwvxsbFvT8MUe4GB81UIw64kKoyLdRqU1+ezZea6fruJOeDFq1g66x/L4D/tJ5MQrFyGRZy+kRhJYz62GHAd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=RT4zlxQfEhcA:10
    a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8 a=7d_E57ReAAAA:8 a=fbonvYegYERXTTM_zRYA:9
    a=7466DE5Fxp-fVtj-:21 a=6h-FroRT27uRmJmQ:21 a=CjuIK1q_8ugA:10
    a=lzdFF2JKXF9NbW0PGMIA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEQBPO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 21:15:14 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43310 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbeEQBPM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 May 2018 21:15:12 -0400
X-Google-Smtp-Source: AB8JxZoDyhEK2ZgycStcIKyyPhuejy61PVmIoNFvIBxDLlvGWJRxtF+MQjLenR1TkvTKoUzBs0bG/Q==
X-ME-Sender: <xms:nNf8WtTKh1-ewk1RPRF1wFLLQs-6fIrnRNs8IjkIa-TlbHkGmQcZvw>
Date: Thu, 17 May 2018 09:19:49 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
Message-ID: <20180517011949.GA1121@tardis>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180430224433.17407-8-mathieu.desnoyers@efficios.com>
 <20180516161837.GI12198@hirez.programming.kicks-ass.net>
 <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 04:13:16PM -0400, Mathieu Desnoyers wrote:
> ----- On May 16, 2018, at 12:18 PM, Peter Zijlstra peterz@infradead.org w=
rote:
>=20
> > On Mon, Apr 30, 2018 at 06:44:26PM -0400, Mathieu Desnoyers wrote:
> >> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> >> index c32a181a7cbb..ed21a777e8c6 100644
> >> --- a/arch/powerpc/Kconfig
> >> +++ b/arch/powerpc/Kconfig
> >> @@ -223,6 +223,7 @@ config PPC
> >>  	select HAVE_SYSCALL_TRACEPOINTS
> >>  	select HAVE_VIRT_CPU_ACCOUNTING
> >>  	select HAVE_IRQ_TIME_ACCOUNTING
> >> +	select HAVE_RSEQ
> >>  	select IRQ_DOMAIN
> >>  	select IRQ_FORCED_THREADING
> >>  	select MODULES_USE_ELF_RELA
> >> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal=
=2Ec
> >> index 61db86ecd318..d3bb3aaaf5ac 100644
> >> --- a/arch/powerpc/kernel/signal.c
> >> +++ b/arch/powerpc/kernel/signal.c
> >> @@ -133,6 +133,8 @@ static void do_signal(struct task_struct *tsk)
> >>  	/* Re-enable the breakpoints for the signal stack */
> >>  	thread_change_pc(tsk, tsk->thread.regs);
> >> =20
> >> +	rseq_signal_deliver(tsk->thread.regs);
> >> +
> >>  	if (is32) {
> >>          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
> >>  			ret =3D handle_rt_signal32(&ksig, oldset, tsk);
> >> @@ -164,6 +166,7 @@ void do_notify_resume(struct pt_regs *regs, unsign=
ed long
> >> thread_info_flags)
> >>  	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
> >>  		clear_thread_flag(TIF_NOTIFY_RESUME);
> >>  		tracehook_notify_resume(regs);
> >> +		rseq_handle_notify_resume(regs);
> >>  	}
> >> =20
> >>  	user_enter();
> >=20
> > Again no rseq_syscall().
>=20
> Same question for PowerPC as for ARM:
>=20
> Considering that rseq_syscall is implemented as follows:
>=20
> +void rseq_syscall(struct pt_regs *regs)
> +{
> +       unsigned long ip =3D instruction_pointer(regs);
> +       struct task_struct *t =3D current;
> +       struct rseq_cs rseq_cs;
> +
> +       if (!t->rseq)
> +               return;
> +       if (!access_ok(VERIFY_READ, t->rseq, sizeof(*t->rseq)) ||
> +           rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
> +               force_sig(SIGSEGV, t);
> +}
>=20
> and that x86 calls it from syscall_return_slowpath() (which AFAIU is
> now used in the fast-path since KPTI), I wonder where we should call

So we actually detect this after the syscall takes effect, right? I
wonder whether this could be problematic, because "disallowing syscall"
in rseq areas may means the syscall won't take effect to some people, I
guess?

> this on PowerPC ?  I was under the impression that PowerPC return to
> userspace fast-path was not calling C code unless work flags were set,
> but I might be wrong.
>=20

I think you're right. So we have to introduce callsite to rseq_syscall()
in syscall path, something like:

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 51695608c68b..a25734a96640 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -222,6 +222,9 @@ system_call_exit:
 	mtmsrd	r11,1
 #endif /* CONFIG_PPC_BOOK3E */
=20
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl	rseq_syscall
+
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-MAX_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TI=
F_PERSYSCALL_MASK)

But I think it's important for us to first decide where (before or after
the syscall) we do the detection.

Regards,
Boqun

> Thoughts ?
>=20
> Thanks!
>=20
> Mathieu
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlr82LEACgkQSXnow7UH
+rigrAf9F+civFS4yvkbV5+5YY7LO3c7DJGBFUVnW4gUwQ14uGxh/pzKh9n2Sz1A
RUVz++oMugIjA3y4/4dLCEjaG8D1qZ96dTJ01vHakA+ieg6rJ0a2/hqrH2lDur9/
HDrrniFt823LtzZrZtg6gAimOXsRS/lAMJftmrbwDgzNjenr4iOOklZRx/vX7W7k
nE/w1BChYNKSqbv8LIGpFLbOdDl1rstDhdAfyq0STjsw15LiL389Ae07MVbibt89
xC06lV+o7EnibHXg7p2K/EJzEG8PYmNRmanayu8Rtw2fwKULbUFiuNJB5L5l27Q+
SdKzROnL22KVhC+kPzLx7l/yI0386Q==
=nkk3
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
