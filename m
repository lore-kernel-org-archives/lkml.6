Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7036BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205B721476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="GqUdLUQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205B721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeJSWgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:36:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39040 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbeJSWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:36:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so15848569pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=reKol3Kt1XrJOxvg6Nseeg8Juwj5XurAilRn4PiWeHU=;
        b=GqUdLUQxxvOEDnh0yMkS6Ww+/JldYLx0t4//MQPaln/hOnP7oNxwfzjNM56O/x0Yg7
         UCebtr51g2WFohQTSLbOiL/W0QunmjNJ0Sa8n3ngGsHK3WGdPqZJr0kksuoLHDdsFeeJ
         LTPI9ZPYBn5AMDb2yrk/mFMXG0Z49ZXDnhIOu/Vpdf96c2YPsJilWygpGn1p3gKOq566
         oLCWsOYt5vNmevzFO3Hd3D27uZVUDnH6OcJoV6an7th7q6N5T9+w34EVdDJYAV8ixtHW
         SFRsBMqQwWDy+DwkCZYR/mVZ4TsMSlHNyffLhtdmiyk7fKM69R0ZpfIc7R9hS/fhZHRZ
         +E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=reKol3Kt1XrJOxvg6Nseeg8Juwj5XurAilRn4PiWeHU=;
        b=H4/Hi8+b1PhkiYHbYd32g58vIfSqFvSZ3PlftjswxRZ46m1baBv+sQO8dSGw0FbKNi
         sfQrZx9QfCTr61ENg0B1SJL7qsqlVkf9DyuthtwAj33irkLmKsD1GTEhK8Flt/gL6/0k
         PVMiGecdSj0Ih1E9hWrrsH9e5VE1yNsBuanKyfCibBmEWeHITYHtp5nU9hzqQeyVxNet
         K2lLcYTHF4Nv7PlufkKkraEZZt1jXeiuZOauJJOEJlmi63azxv7buZUx1VSKk5mxduUl
         ha9nOIKLEks0QuCMObQbvIsTpj84H90vLnOhzvYcxlUeuKz1r4IGuQScSzRywEAZ9mdv
         9OdA==
X-Gm-Message-State: ABuFfogpXFnRcZ0Eclmnzkhag8xtCuaF0r/CePRWXjuSIcHuwu0l2npD
        US6UZfF+U1D4X7NM/O2Nj5HcjkLKrBE=
X-Google-Smtp-Source: ACcGV60trMfQPOMwjYfdFL+hQO+3hIz2iwAC2kFDpk6tqWzNBi7p5+kxJMrTK3ZmOjIuXcTozVYqWA==
X-Received: by 2002:a62:f715:: with SMTP id h21-v6mr33959748pfi.169.1539959388012;
        Fri, 19 Oct 2018 07:29:48 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:746e:dce6:68de:332d? ([2601:646:c200:7429:746e:dce6:68de:332d])
        by smtp.gmail.com with ESMTPSA id t22-v6sm33515563pfk.141.2018.10.19.07.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:29:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181019083325.GC3121@hirez.programming.kicks-ass.net>
Date:   Fri, 19 Oct 2018 07:29:45 -0700
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1F3B914-2630-41ED-B205-BBA50F94B64F@amacapital.net>
References: <20181018005420.82993-1-namit@vmware.com> <20181018005420.82993-2-namit@vmware.com> <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net> <07255D2B-0243-4254-B62A-37050C44207E@vmware.com> <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com> <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com> <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net> <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com> <20181019083325.GC3121@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 19, 2018, at 1:33 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Fri, Oct 19, 2018 at 01:08:23AM +0000, Nadav Amit wrote:
>> Consider for example do_int3(), and see my inlined comments:
>>=20
>> dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)=

>> {
>>    ...
>>    ist_enter(regs);        // =3D> preempt_disable()
>>    cond_local_irq_enable(regs);    // =3D> assume it enables IRQs
>>=20
>>    ...
>>    // resched irq can be delivered here. It will not caused rescheduling
>>    // since preemption is disabled
>>=20
>>    cond_local_irq_disable(regs);    // =3D> assume it disables IRQs
>>    ist_exit(regs);            // =3D> preempt_enable_no_resched()
>> }
>>=20
>> At this point resched will not happen for unbounded length of time (unles=
s
>> there is another point when exiting the trap handler that checks if
>> preemption should take place).
>>=20
>> Another example is __BPF_PROG_RUN_ARRAY(), which also uses
>> preempt_enable_no_resched().
>>=20
>> Am I missing something?
>=20
> Would not the interrupt return then check for TIF_NEED_RESCHED and call
> schedule() ?

The paranoid exit path doesn=E2=80=99t check TIF_NEED_RESCHED because it=E2=80=
=99s fundamentally atomic =E2=80=94 it=E2=80=99s running on a percpu stack a=
nd it can=E2=80=99t schedule. In theory we could do some evil stack switchin=
g, but we don=E2=80=99t.

How does NMI handle this?  If an NMI that hit interruptible kernel code over=
flows a perf counter, how does the wake up work?

(do_int3() is special because it=E2=80=99s not actually IST.  But it can hit=
 in odd places due to kprobes, and I=E2=80=99m nervous about recursing incor=
rectly into RCU and context tracking code if we were to use exception_enter(=
).)

>=20
> I think (and this certainly wants a comment) is that the ist_exit()
> thing hard relies on the interrupt-return path doing the reschedule.
