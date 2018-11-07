Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F2DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BDE2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="NdXVteev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BDE2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeKGXhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:37:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40732 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKGXhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:37:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id q19-v6so4915892pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Cq44L2Lzc2SYuidGokBvhmfP9O2TQxHES7y8bZuOJVw=;
        b=NdXVteevIYUltfBgsXPByN6Fss6IKTjzMseZhfv/LwZShwtTXbkapQIyZGKHd1kG7E
         M5QCsRQhaDpiEXnnwtAzIAxZQkTf1fOsji9DTrSkBJW6jShlTCtAB4jtHhB60cofBkMQ
         UZPskeuMLR56g1gGUbsUwJzCVOVuKV96CbgoBPPoYYuSjm+wXOouo6Q7kxeqbHGWDWFI
         /QvNGYsOsrhdvSMHPqnjiozTCzRPfnBmBq1sDEzLlH1hRPPW8RfrzjkEFHF6jsddaVvU
         37KUCmIoXIZFhN8tJwIwMEQFUpMVJo2Z46r++kKtgrCI7NasF3IPBdUJNuRUno/bEPgO
         iFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Cq44L2Lzc2SYuidGokBvhmfP9O2TQxHES7y8bZuOJVw=;
        b=dgxEjpC3D6LSPAsDKv+Yn99H1dot6Bf8E2kPEGr+dDyQDAi1lbm/E0Up0RLV+K+uWF
         Lc55VZBb3zQ3XeTIWWJNtfU/CPfseBPNP0gdrLFaTiUKCaTEv6UQ2vn98hVlHOmWg96d
         +2P5cs20q43z1kHnbRQUZW6m3VUQ2LVNUy2U/+swcmGeNEnHQwYPIEnzlvUmSLE4pKqc
         0su40W1AqBIdGBRRPyuEjBvu3unZCVruUwGyfsyeFjUwihVESuIHRUmd9ppCip9l1SxL
         kgmB1rcvHlqCTSAjSh2YJ77dcOd7So1EgR8Z9uTzeYAfyGvJ14u1TViyVgPbIVsyUDSH
         bwVA==
X-Gm-Message-State: AGRZ1gLJGCK/9GoQPXnXPusQfMBzx3xrTZyKrTMLT1wR9/sWN1VD42lR
        K2DH+fh+BnNE4VmXzqYZhfDmvQ==
X-Google-Smtp-Source: AJdET5cenWncAuWFsYDsyaH4A/q3aJWg7R38DaR2NRQKZwQYoxfL1ejy9FImTyxnR4HwTidmktgM5g==
X-Received: by 2002:a17:902:7613:: with SMTP id k19-v6mr372065pll.98.1541599606057;
        Wed, 07 Nov 2018 06:06:46 -0800 (PST)
Received: from [192.168.0.178] (c-71-202-137-17.hsd1.ca.comcast.net. [71.202.137.17])
        by smtp.gmail.com with ESMTPSA id p82-v6sm1069206pfa.47.2018.11.07.06.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:06:45 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181107112100.GA20419@redhat.com>
Date:   Wed, 7 Nov 2018 06:06:43 -0800
Cc:     Elvira Khabirova <lineprinter@altlinux.org>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, ldv@altlinux.org,
        esyr@redhat.com, luto@kernel.org, strace-devel@lists.strace.io
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BDB914D-12F3-4703-A033-EBE02226EC45@amacapital.net>
References: <20181107042751.3b519062@akathisia> <20181107112100.GA20419@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 7, 2018, at 3:21 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
>> On 11/07, Elvira Khabirova wrote:
>>=20
>> In short, if a 64-bit task performs a syscall through int 0x80, its trace=
r
>> has no reliable means to find out that the syscall was, in fact,
>> a compat syscall, and misidentifies it.
>> * Syscall-enter-stop and syscall-exit-stop look the same for the tracer.
>=20
> Yes, this was discussed many times...
>=20
> So perhaps it makes sense to encode compat/is_enter in ->ptrace_message,
> debugger can use PTRACE_GETEVENTMSG to get this info.

As I said before, I strongly object to the use of =E2=80=9Ccompat=E2=80=9D h=
ere.  Compat meant =E2=80=9Cnot the kernel=E2=80=99s native syscall API =E2=80=
=94 uses the 32-bit structure format instead=E2=80=9D.  This does not have a=
 sensible meaning to user code, especially in the case where the tracer is 3=
2-bit.

>=20
>> Secondly, ptracers also have to support a lot of arch-specific code for
>> obtaining information about the tracee. For some architectures, this
>> requires a ptrace(PTRACE_PEEKUSER, ...) invocation for every syscall
>> argument and return value.
>=20
> I am not sure about this change... I won't really argue, but imo this
> needs a separate patch.

Why?  Having a single struct that the tracer can read to get the full state i=
s extremely helpful.

Also, we really want it to work for seccomp events as well as PTRACE_SYSCALL=
, and the event info trick doesn=E2=80=99t make sense for seccomp events.

>=20
>> +#define PT_IN_SYSCALL_STOP    0x00000004    /* task is in a syscall-stop=
 */
> ...
>> -static inline int ptrace_report_syscall(struct pt_regs *regs)
>> +static inline int ptrace_report_syscall(struct pt_regs *regs,
>> +                    unsigned long message)
>> {
>>    int ptrace =3D current->ptrace;
>>=20
>>    if (!(ptrace & PT_PTRACED))
>>        return 0;
>> +    current->ptrace |=3D PT_IN_SYSCALL_STOP;
>>=20
>> +    current->ptrace_message =3D message;
>>    ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
>>=20
>>    /*
>> @@ -76,6 +79,7 @@ static inline int ptrace_report_syscall(struct pt_regs *=
regs)
>>        current->exit_code =3D 0;
>>    }
>>=20
>> +    current->ptrace &=3D ~PT_IN_SYSCALL_STOP;
>>    return fatal_signal_pending(current);
> ...
>=20
>> +    case PTRACE_GET_SYSCALL_INFO:
>> +        if (child->ptrace & PT_IN_SYSCALL_STOP)
>> +            ret =3D ptrace_get_syscall(child, datavp);
>> +        break;
>=20
> Why? If debugger uses PTRACE_O_TRACESYSGOOD it can know if the tracee repo=
rted
> syscall entry/exit or not. PTRACE_GET_SYSCALL_INFO is pointless if not, bu=
t
> nothing bad can happen.
>=20
>=20

I think it=E2=80=99s considerably nicer to the user to avoid reporting garba=
ge if the user misused the API.  (And Elvira got this right in the patch =E2=
=80=94 I just missed it.)

>=20
