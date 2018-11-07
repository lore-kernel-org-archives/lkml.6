Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440A5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0904C20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="2IrFGC3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0904C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeKHFwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:52:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41239 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeKHFwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:52:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so2210193pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 12:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aTSdqSiYp+KdAMuJ0/e9Op27AaHrrLnICcOTCUsBIPw=;
        b=2IrFGC3bbxEf6URp0PHTh6IhVM/Pr1ruUG3hO05zR9NuQDemmtRDg296DoyCSVZqzZ
         dx46orFC4FCu94Q3y/aeFwzdeUgirvA7kIugf04dzGN+3L/QzCIDAsk1eWGtrRvDZ39Q
         VlVW2qvT0k67+/+cRbLgpaOSSWd2x1vaqf7fm2tkLVdG+0nohxqQRX6ETBIo6PcgjyS7
         V08LFDnr/fcWsUk06If+/EC+Mp2pbp8TNZmQZKiP932m7RikiGtKRG5/gQOOIbeYpZF2
         YOTm8+flkEqAUVaBflWgq7Vozhzk+mAN1Or0hX/Ieb+BVlnVQEr6NTAfeq4N7J5X9nvk
         SEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aTSdqSiYp+KdAMuJ0/e9Op27AaHrrLnICcOTCUsBIPw=;
        b=mBd/sKt59cZbuXaDT2WORnpHDjdDa4o/iMGYmJ2t3sSODfQ/EntEytsTcJVE70uNKn
         MKeoj2fr36xICWW4nQAkchp6HgumN+rusfpulv12FkjPCtf9NRvEb3AtRBfMPO6033zH
         KExyqL5paOFdLGRW+GSLX3lQp4skITCaDEChva5nrinqXewDeUstVdcixCX1pOeT8fRu
         b+nx/Sv3ADPqbZldmsAphtmnpEOnJ8rh1luOQee8UV3UdcaEG1xDl9gmwoW5YteeNsJH
         BjJwy8BsaPk0znkE6JrsTAE0IyxRTKoTgthQWROdMaBfZBUWtiJ1e3+1Dv3VrRY/RVdn
         K3Ow==
X-Gm-Message-State: AGRZ1gKhY1MSU+4hnaL89Gy27LqScF+yGQkRgZUDJ3TRhXGrrHCxTx6F
        GDbiNsomt86nG/wWIZMkvCgGNA==
X-Google-Smtp-Source: AJdET5cKzxHpQlEWfvW4PVAw8RVT+hbhhKYw6iEgZ1oZ/uyXqchJm1OTS1W2rW7unY+ivK985KGZHQ==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr1467614pgc.25.1541622020368;
        Wed, 07 Nov 2018 12:20:20 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:6091:ffb6:696b:95fe? ([2601:646:c200:7429:6091:ffb6:696b:95fe])
        by smtp.gmail.com with ESMTPSA id 196-v6sm4714617pfc.71.2018.11.07.12.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:20:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181107164443.GA8726@redhat.com>
Date:   Wed, 7 Nov 2018 12:20:18 -0800
Cc:     Elvira Khabirova <lineprinter@altlinux.org>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, ldv@altlinux.org,
        esyr@redhat.com, luto@kernel.org, strace-devel@lists.strace.io
Content-Transfer-Encoding: quoted-printable
Message-Id: <35B601B0-4D56-4706-B7A1-C9A522AB2D6F@amacapital.net>
References: <20181107042751.3b519062@akathisia> <20181107112100.GA20419@redhat.com> <3BDB914D-12F3-4703-A033-EBE02226EC45@amacapital.net> <20181107164443.GA8726@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 7, 2018, at 8:44 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
>> On 11/07, Andy Lutomirski wrote:
>>=20
>>=20
>>>> On Nov 7, 2018, at 3:21 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>>=20
>>>> On 11/07, Elvira Khabirova wrote:
>>>>=20
>>>> In short, if a 64-bit task performs a syscall through int 0x80, its tra=
cer
>>>> has no reliable means to find out that the syscall was, in fact,
>>>> a compat syscall, and misidentifies it.
>>>> * Syscall-enter-stop and syscall-exit-stop look the same for the tracer=
.
>>>=20
>>> Yes, this was discussed many times...
>>>=20
>>> So perhaps it makes sense to encode compat/is_enter in ->ptrace_message,=

>>> debugger can use PTRACE_GETEVENTMSG to get this info.
>>=20
>> As I said before, I strongly object to the use of =E2=80=9Ccompat=E2=80=9D=
 here.
>=20
> Not sure I understand you... I do not like "compat" too, but this patch us=
es
> is_compat/etc and I agree with any naming.

My point is: returning a value to user code that is:

0 if the kernel and tracee are 32-bit
0 if the kernel and tracer are 64-but
1 if the kernel is 64-bit and the tracer is 32-bit
? If the tracer is arm64 ILP32

Is not a good design.  And 32-bit builds of strace will not appreciate it.

The API should return a value that, at least on a given overall architecture=
 and preferably globally, indicates the syscall arch.  While oddly named, au=
dit_arch fits the bill nicely, and we already require it to have the right s=
emantics for seccomp support.

