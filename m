Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5BDC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FCA2157F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fo99QRPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FCA2157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbeHHCLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:11:09 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35105 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeHHCLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:11:08 -0400
Received: by mail-yw1-f67.google.com with SMTP id s68-v6so279994ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 16:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=shW1j8Nve8HjOw0OXc/Ta5QIlupsgez7p57QhHiMQhI=;
        b=fo99QRPQm3heevDIH0lBjnidyaaGDJwu4ieDwYtqT+I18B1bud4ksc3+eC+rtj+R4p
         yd5dizSm6uK6TBPE85LzqorSbG40K9BZToTTlKuAlHUgJFNdpiiDFdMZs007YDTqqZG9
         1eqrNuK8R+OB3fznfCUu9Bx4asrI71Z+cLUVTR6Sqlgt1Iduu/e3YtCem7uxTGL+vVhH
         jQ48arq1nA6RYOGnk24gLwBkNTRer1YEXALo2w+yhwOQ/HL6kcSoVO8XxK8SOJGsoTqM
         Au6e7Lv7vMmEEsvxugLbTksnHzqbRtckI9+dR/Hmoxrrtfx8z6DoguE2MEhaqarO9rnS
         vd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=shW1j8Nve8HjOw0OXc/Ta5QIlupsgez7p57QhHiMQhI=;
        b=jQ8pYMKl1C4acr6c7M9Z5YqZWEW/pC0P9hLln/zF2cHNuM7uXNcPL1dU7G7Kz+bLgu
         IlD3xm2cFdOD4LVRaEISINqR9iP9HP2uYxgr2lnEe0X+7KtuvAu3JG+Bkw43jDN1e25B
         x8xMkcQL2cN+cNY6/SXFWOVQ2OLzH6oTcnaT0OtgBPL9mUzyk1xi/zKxSZHRNtoDqzLx
         NRoLxZFYMn0/GaHncvql9kXvOpBllhV7p5edUS+EsG15pSuu8H+mz3zG9lmE8b2du7SD
         QacQZXWds5MEdeufU6oScw/bc7CPnPAZe3zMYMOcH8Kp18A7VOuGebfl4GTUqzTWEJ/L
         O4Mg==
X-Gm-Message-State: AOUpUlEttUek+x5TdO5ZQOwHuhFAO/j5pjYPl/XbbRF4SEv63Rn4ezfO
        SFDGg0FpON0wySr1e2tm6O4jy3LRuQ4=
X-Google-Smtp-Source: AA+uWPxPuUGO50SZygkKxtqvJzvNXPiV/27kc0w9Gav3mUBDhxJQ+jakDa4Z7kz0AebV7X6rLsBDGg==
X-Received: by 2002:a25:aa8d:: with SMTP id t13-v6mr258700ybi.465.1533686057038;
        Tue, 07 Aug 2018 16:54:17 -0700 (PDT)
Received: from ?IPv6:2601:5c2:201:936:3cea:8a4f:718c:ecff? ([2601:5c2:201:936:3cea:8a4f:718c:ecff])
        by smtp.gmail.com with ESMTPSA id p134-v6sm1074660ywe.30.2018.08.07.16.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 16:54:16 -0700 (PDT)
Date:   Tue, 07 Aug 2018 19:54:13 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20180807194515.4e549c1a@gandalf.local.home>
References: <20180730222423.196630-1-joel@joelfernandes.org> <20180730222423.196630-4-joel@joelfernandes.org> <20180806155058.5ee875f4@gandalf.local.home> <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com> <20180806214300.13e63523@gandalf.local.home> <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com> <20180807094954.5137972d@gandalf.local.home> <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com> <20180807103410.4fe203cb@gandalf.local.home> <C1CB990F-8232-4168-89A8-E8C13B660B0B@google.com> <20180807110906.3a1b0ac4@gandalf.local.home> <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com> <20180807194515.4e549c1a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and unify their usage
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
From:   Joel Fernandes <joelaf@google.com>
Message-ID: <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 7, 2018 7:45:15 PM EDT, Steven Rostedt <rostedt@goodmis=2Eorg> w=
rote:
>On Tue, 07 Aug 2018 11:24:13 -0400
>Joel Fernandes <joelaf@google=2Ecom> wrote:
>
>> On August 7, 2018 11:09:06 AM EDT, Steven Rostedt
><rostedt@goodmis=2Eorg> wrote:
>> >On Tue, 07 Aug 2018 10:48:05 -0400
>> >Joel Fernandes <joelaf@google=2Ecom> wrote:
>> > =20
>> >> >You mean if someone add a tracepoint callback to the irq disable
>> >> >tracepoint, and did a lockdep assert to make sure interrupts are
>> >> >disabled?   =20
>> >>=20
>> >> Yes that's what I meant=2E =20
>> >
>> >That sounds like a "Doctor, it hurts me when I do this" problem ;-)=20
>
>>=20
>> Haha, yes true=2E But just to clarify, I didn't do this to see the
>problem but noticed it with turning on existing things=2E :-) but I see
>your point=2E=2E=2E
>>=20
>
>OK, I hit this bug, but it's not because of the partial revert=2E This
>bug seems it needs to be another partial revert=2E I like you movement of
>the code, but I'm starting to doubt that we can use a trace event as a
>hook for critical areas yet=2E Well, not until we can use srcu in NMI=2E
>

I sent a patch to use srcu for all tracepoints including nmi=2E That patch=
 also removes this warning and fixes the one other issue masami reported (h=
ot plug causing a warning)=2E

If Paul and Mathieu can confirm SRCU works on offline CPUs that would be g=
reat=2E

It's just this one warning or anything else that makes you feel tracepoint=
s for critical paths isn't feasible?

Thanks=2E




>#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
>	do {								\
>		struct tracepoint_func *it_func_ptr;			\
>		void *it_func;						\
>		void *__data;						\
>		int __maybe_unused idx =3D 0;				\
>									\
>		if (!(cond))						\
>			return;						\
>									\
>		/* srcu can't be used from NMI */			\
>
>		WARN_ON_ONCE(rcuidle && in_nmi()); <=3D=3D WARN_ON_ONCE hit!
>
>WARNING: CPU: 3 PID: 3727 at
>/work/build/trace/nobackup/linux-test=2Egit/include/trace/events/preempti=
rq=2Eh:38
>trace_irq_disable_rcuidle+0x2a/0x6c
>Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6
>nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 crc_ccitt r8169 ppdev
>parport_pc parport
>CPU: 3 PID: 3727 Comm: trace-cmd Not tainted 4=2E18=2E0-rc6-test+ #14
>Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1=2E6 02/22/2014
>EIP: trace_irq_disable_rcuidle+0x2a/0x6c
>Code: e9 01 00 00 00 c3 64 8b 0d 24 e1 50 c1 0f a3 0d e0 f1 3f c1 73 55
>55 89 e5 57 56 53 51 64 8b 0d cc 37 51 c1 0f ba e1 14 73 02 <0f> 0b 89
>d7 89 c6 b8 e0 d8 2e c1 e8 8e 5b fa ff 8b 1d 9c 27 3d c1=20
>EAX: c0401509 EBX: efa43680 ECX: 80110000 EDX: c0dc81f3
>ESI: ed823d44 EDI: efa43680 EBP: ed823cd0 ESP: ed823cc0
>DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010047
>CR0: 80050033 CR2: b7f06000 CR3: 30513b00 CR4: 001406f0
>Call Trace:
> trace_hardirqs_off_caller+0x23/0x2d
> trace_hardirqs_off_thunk+0xc/0x10
>EIP: default_do_nmi+0x1/0x157
>
>
>-- Steve

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
