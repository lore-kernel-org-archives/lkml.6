Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1661265-1522219458-2-15183065094646459024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522219457; b=jXzBixzFf3Nswmdn55VsXT6ebUVkSSK40NbV0ycrRGUbhh9
    8AlcsP6HbsIiICh0tDpG7cVI6hn2my7FtjIgqHg3pDKqLImqvlIY8kkYesLXfJGc
    9k8lOHUt8+cKlfqYZ90LAMhN1a3GoxcKeZ85m0aBdQim47QlVXi3i+x6Ch6Pc7e+
    U4Hw6H1opoa/wty6LdF9Kn15UAEFukyOAgDhvKGBVP9CY+q3APCfrdMM9eX83437
    QffOXMhUvTVF2A6Hc4LUAaCKF+3L94kVY3D5I6N7vIxKd0W9I3VL7tLGWjS/gleT
    0ynOaAu2FcnECXFh78CWcJyafnhfi7ohicMYAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522219457; bh=bdVCautqiGJkZX0nT7sZ9btdA/
    39Ga1A+4dN3aA/YR8=; b=mLewxrtMuR1MMwqZTN7Z/siNZH1kWaA8nBKLz6O4Hv
    yrUMa/j6KstrLPLLJrz1zguftLznDxWRHfVcBPrMfzY1tq3drk2g/+K1ajojrwjR
    Idygr6aw4aao6BJ0T6l500dcuaqgghv9RbVSi2GcJWhSpRuErOzFkhE2hZYx/5m5
    /n7UlT1M9w5hJHrzcgklpfcaBvq1VzMvvGfx7nRz/IQ7GpQLPSxIhuvI0ve/3xuX
    qAhcuJNil3KmNbbr9GN4hKyRtDZ47IfM0D1uYpHFUTZ1YNv8FMBff5Nqyq9AHYEj
    VQa/85APPhVjtOqly3Uqtcej9y6y3y2xLaFgmo8cKugQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=X0YBJ1gM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=adgIqq5D;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=X0YBJ1gM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=adgIqq5D;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF2T3w/hjqIkrRW8/rRZXgGjpBC6ibLLtcV+7eBVE/Lh5dIYE7eKsNlZ1i+qluoKMOxS7au5UIflApQpX60qdJaejr0l2ocNU5c0d7lhcf7Y5f5KY7q2
    jgXEoerQvCOayzsN3RrDgeNgcazu7p93/WwWD2lN55o5s4Uzu9Qgjnwf9GRBKA+q8gEVjJ784iCULQeJ3/1hPYbbcW2EUp/1MZuzWI9NoyP5uyKKM6xzXRiD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=RT4zlxQfEhcA:10
    a=v2DPQv5-lfwA:10 a=n-LROZ2ubZPjNDABMQAA:9 a=CjuIK1q_8ugA:10
    a=IKhNUHuQi34mLC26uu4A:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeC1GoC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 02:44:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40603 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbeC1GoB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 02:44:01 -0400
X-Google-Smtp-Source: AIpwx49M9JfZ5of1fTs5RCvjt16VVnS2Zn5puDjYagoy7tlxXJA2WkkoSomIOlTqCyE1L3Nt2VC6eQ==
X-ME-Sender: <xms:qjm7WrA1oqgwlf9zoqvtjNd425MThxnFk-PAHUZckbPkJf58wXLwnw>
Date: Wed, 28 Mar 2018 14:47:54 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable sequences
 system call (v12)
Message-ID: <20180328064703.56hsuicmikejg7np@tardis>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yzsuj5wf7xcogpl6"
Content-Disposition: inline
In-Reply-To: <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
User-Agent: NeoMutt/20171215
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--yzsuj5wf7xcogpl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
[...]
> Changes since v11:
>=20
> - Replace task struct rseq_preempt, rseq_signal, and rseq_migrate
>   bool by u32 rseq_event_mask.
[...]
> @@ -979,6 +980,17 @@ struct task_struct {
>  	unsigned long			numa_pages_migrated;
>  #endif /* CONFIG_NUMA_BALANCING */
> =20
> +#ifdef CONFIG_RSEQ
> +	struct rseq __user *rseq;
> +	u32 rseq_len;
> +	u32 rseq_sig;
> +	/*
> +	 * RmW on rseq_event_mask must be performed atomically
> +	 * with respect to preemption.
> +	 */
> +	unsigned long rseq_event_mask;

s/unsigned long/u32

> +#endif
> +
>  	struct tlbflush_unmap_batch	tlb_ubc;
> =20
>  	struct rcu_head			rcu;
> @@ -1688,4 +1700,110 @@ extern long sched_getaffinity(pid_t pid, struct c=
pumask *mask);
>  #define TASK_SIZE_OF(tsk)	TASK_SIZE
>  #endif
> =20

[...]

> +
> +static int rseq_ip_fixup(struct pt_regs *regs)
> +{
> +	unsigned long ip =3D instruction_pointer(regs), start_ip =3D 0,
> +		post_commit_offset =3D 0, abort_ip =3D 0;
> +	struct task_struct *t =3D current;
> +	uint32_t cs_flags =3D 0;
> +	bool in_rseq_cs =3D false;

This seems unnecessary? Because..

> +	int ret;
> +
> +	ret =3D rseq_get_rseq_cs(t, &start_ip, &post_commit_offset, &abort_ip,
> +			&cs_flags);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Handle potentially not being within a critical section.
> +	 * Unsigned comparison will be true when
> +	 * ip >=3D start_ip, and when ip < start_ip + post_commit_offset.
> +	 */
> +	if (ip - start_ip < post_commit_offset)
> +		in_rseq_cs =3D true;
> +
> +	/*
> +	 * If not nested over a rseq critical section, restart is
> +	 * useless. Clear the rseq_cs pointer and return.
> +	 */
> +	if (!in_rseq_cs)
> +		return clear_rseq_cs(t);

we can write

	if (ip - start_ip >=3D post_commit_offset)
		return clear_rseq_cs(t);

Regards,
Boqun

> +	ret =3D rseq_need_restart(t, cs_flags);
> +	if (ret <=3D 0)
> +		return ret;
> +	ret =3D clear_rseq_cs(t);
> +	if (ret)
> +		return ret;
> +	trace_rseq_ip_fixup(ip, start_ip, post_commit_offset, abort_ip);
> +	instruction_pointer_set(regs, (unsigned long)abort_ip);
> +	return 0;
> +}
> +
[...]

--yzsuj5wf7xcogpl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlq7OpYACgkQSXnow7UH
+rjwhQf+LeKpKOoiYs2E75v4BONhGBr6S9icQvXV25bXj3nlHUJSOW9yHPtN3wjq
GwR0eZQkCfKm5ir9BDyRe1L5nKYDWVz7qdj6IDN67yPr6fnAFPw1SNIM8RsOBvn2
d5bLKbPAEJIvv0JWH7VQedq4SlQYfCKPrv0ue45QReE1FsxlDXPt1Aq3El4BUMaw
yXEA4xMijOFqk8WOspEjgRkHn/k9jOCKpkVg/dCAu9OZ6Ivqsr4GKvaSpoo9RMfF
EqR0/az/GkdJNEh0QlApYNNhBxB+dHd49bMN1K4ql2G7j1St+g6Vdb/3i6KM9PWJ
alGOemjl4GXknHu6RE4U9ODYpGUBtQ==
=e8tt
-----END PGP SIGNATURE-----

--yzsuj5wf7xcogpl6--
