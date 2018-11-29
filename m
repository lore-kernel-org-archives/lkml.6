Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2A2C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7660220868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="AkqqJqsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7660220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeK3HUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:20:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34327 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeK3HUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:20:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so1586082pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 12:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PqVghbOFRW+RL+62Q8UBfCV6NeETGXcgNZP9Hlz2w4c=;
        b=AkqqJqszkWE7DWc7uxHOyQ0GbQqnm52sZKwHuc6m9jVssftPDnUqDGJ9sAro6Dc9kj
         jooRtP2avmXSLvZpdTksIzvbQjtOFbTcw7oECJrUm/u4YAIRofGUcsHRRq30owXtEf/v
         c0zMte1woW3Uk29K9PcJFtKoEYfYCnhtWJbsb8fLfyRiuIqsWB6JM2J97CxZw5nLa6Du
         xrK08LUyWtSli0kAri/KKLINClb/8HkBbeY5bsiuOwMH0l0ODS/Gwb9QTcTlKnkfoYg0
         l5Z4fLyXunLnYfCixe8C8p38UlYlzLm5PH/EAORChFGCYMs+kLuHiFmi+g/lSCxym0Mg
         nzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PqVghbOFRW+RL+62Q8UBfCV6NeETGXcgNZP9Hlz2w4c=;
        b=ZJD+rJbWrvXWZgIIePRGMRFOsYe49ctYwOJ4KeMP4cuOOe1PuHXWSsAvvCkekLHxe3
         uNbi3380UnGwqrLm71Eu3DIQwdqEYx2gbGlN+oWHmhLoaArL6kWewv2qraV2TW4Lg0mQ
         TKqGfE9HLsTpf0hwsH1DssbcmjwWYDIepcykKL/e5GE1BXKv/2V/iQFKl20/kjll7PHJ
         CFXFzv+VR1yu0XPogP47/YyNHGYv9nI+QoDwKcAbZEBHNNttTo6hIj8l01tSPRkqWWvU
         zpxskLDPTz/xVosmNWLQNLyDJYAKWVFhAnWu8Z9plZjgmT/oIqeJ3atfT0vti/crcCzB
         No6g==
X-Gm-Message-State: AA+aEWa0R7y8y4BRIoAzXoIlfrID32JAWTz9L3zD4l0zFnGKLhCadQgY
        VBM10OEEnkoE9tdOrWK1s9t0zg==
X-Google-Smtp-Source: AFSGD/VRa1TXxMBlHflJo7HgBhomBbDWjbkpS3n+wBmuKv6WtbYzKT4VtknF0iP3/Bo9vU3sxCKbRQ==
X-Received: by 2002:a62:b24a:: with SMTP id x71mr2851032pfe.148.1543522446987;
        Thu, 29 Nov 2018 12:14:06 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:e849:445a:3b20:40b8? ([2601:646:c200:7429:e849:445a:3b20:40b8])
        by smtp.gmail.com with ESMTPSA id x2sm7403517pfx.78.2018.11.29.12.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 12:14:06 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181129195551.woe2bl3z3yaysqb6@brauner.io>
Date:   Thu, 29 Nov 2018 12:14:05 -0800
Cc:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com> <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io> <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com> <20181129195551.woe2bl3z3yaysqb6@brauner.io>
To:     Christian Brauner <christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 29, 2018, at 11:55 AM, Christian Brauner <christian@brauner.io> wro=
te:
>=20
>> On Thu, Nov 29, 2018 at 11:22:58AM -0800, Andy Lutomirski wrote:
>>> On Thu, Nov 29, 2018 at 11:17 AM Christian Brauner <christian@brauner.io=
> wrote:
>>>=20
>>>> On November 30, 2018 5:54:18 AM GMT+13:00, Andy Lutomirski <luto@amacap=
ital.net> wrote:
>>>>=20
>>>>=20
>>>>> On Nov 29, 2018, at 4:28 AM, Florian Weimer <fweimer@redhat.com>
>>>> wrote:
>>>>>=20
>>>>> Disclaimer: I'm looking at this patch because Christian requested it.
>>>>> I'm not a kernel developer.
>>>>>=20
>>>>> * Christian Brauner:
>>>>>=20
>>>>>> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl
>>>> b/arch/x86/entry/syscalls/syscall_32.tbl
>>>>>> index 3cf7b533b3d1..3f27ffd8ae87 100644
>>>>>> --- a/arch/x86/entry/syscalls/syscall_32.tbl
>>>>>> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
>>>>>> @@ -398,3 +398,4 @@
>>>>>> 384    i386    arch_prctl        sys_arch_prctl
>>>> __ia32_compat_sys_arch_prctl
>>>>>> 385    i386    io_pgetevents        sys_io_pgetevents
>>>> __ia32_compat_sys_io_pgetevents
>>>>>> 386    i386    rseq            sys_rseq            __ia32_sys_rseq
>>>>>> +387    i386    procfd_signal        sys_procfd_signal
>>>> __ia32_compat_sys_procfd_signal
>>>>>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
>>>> b/arch/x86/entry/syscalls/syscall_64.tbl
>>>>>> index f0b1709a5ffb..8a30cde82450 100644
>>>>>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>>>>>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>>>>>> @@ -343,6 +343,7 @@
>>>>>> 332    common    statx            __x64_sys_statx
>>>>>> 333    common    io_pgetevents        __x64_sys_io_pgetevents
>>>>>> 334    common    rseq            __x64_sys_rseq
>>>>>> +335    64    procfd_signal        __x64_sys_procfd_signal
>>>>>>=20
>>>>>> #
>>>>>> # x32-specific system call numbers start at 512 to avoid cache
>>>> impact
>>>>>> @@ -386,3 +387,4 @@
>>>>>> 545    x32    execveat        __x32_compat_sys_execveat/ptregs
>>>>>> 546    x32    preadv2            __x32_compat_sys_preadv64v2
>>>>>> 547    x32    pwritev2        __x32_compat_sys_pwritev64v2
>>>>>> +548    x32    procfd_signal        __x32_compat_sys_procfd_signal
>>>>>=20
>>>>> Is there a reason why these numbers have to be different?
>>>>>=20
>>>>> (See the recent discussion with Andy Lutomirski.)
>>>>=20
>>>> Hah, I missed this part of the patch.  Let=E2=80=99s not add new x32 sy=
scall
>>>> numbers.
>>>>=20
>>>> Also, can we perhaps rework this a bit to get rid of the compat entry
>>>> point?  The easier way would be to check in_compat_syscall(). The nicer=

>>>> way IMO would be to use the 64-bit structure for 32-bit as well.
>>>=20
>>> Do you have a syscall which set precedence/did this before I could look a=
t?
>>> Just if you happen to remember one.
>>> Fwiw, I followed the other signal syscalls.
>>> They all introduce compat syscalls.
>>>=20
>>=20
>> Not really.
>>=20
>> Let me try to explain.  I have three issues with the approach in your pat=
chset:
>>=20
>> 1. You're introducing a new syscall, and it behaves differently on
>> 32-bit and 64-bit because the structure you pass in is different.
>> This is necessary for old syscalls where compatibility matters, but
>> maybe we can get rid of it for new syscalls.   Could we define a
>> siginfo64_t that is identical to the 64-bit siginfo_t and just use
>> that in all cases?
>>=20
>> 2. Assuming that #1 doesn't work, then we need compat support.  But
>> you're doing it by having two different entry points.  Instead, you
>> could have a single entry point that calls in_compat_syscall() to
>> decide which structure to read.  This would simplify things because
>> x86 doesn't really support the separate compat entry points, which
>> leads me to #3.
>>=20
>> 3. The separate x32 numbers are a huge turd that may have security
>> holes and certainly have comprehensibility holes.  I will object to
>> any patch that adds a new one (like yours).  Fixing #1 or #2 makes
>> this problem go away.
>>=20
>> Does that make any sense?  The #2 fix would be something like:
>>=20
>> if (in_compat_syscall)
>>  copy...user32();
>> else
>>  copy_from_user();
>>=20
>> The #1 fix would add a copy_siginfo_from_user64() or similar.
>=20
> Thanks very much! That all helped a bunch already! I'll try to go the
> copy_siginfo_from_user64() way first and see if I can make this work. If
> we do this I would however only want to use it for the new syscall first
> and not change all other signal syscalls over to it too. I'd rather keep
> this patchset focussed and small and do such conversions caused by the
> new approach later. Does that sound reasonable?

Absolutely. I don=E2=80=99t think we can change old syscalls =E2=80=94 the A=
BI is set in stone. But for new syscalls, I think the always-64-bit behavior=
 makes sense.=
