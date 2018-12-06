Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A555C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C530C21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544122461;
	bh=KnXbT3lr38Q1FlPwwiq2uSCrY+8HSNulIIaUpUqMkj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lj61EcQvJXxh4ggn7weEg/5BN8HGBKBvnzc9WlUl5uEMsydbk0i4rS8RM8MXV/+v6
	 NVPRXEBVLFdNJhcJXF+2Y0v4h/uhYDsFMap9KbouWEwK3uZMcjlgJ12H2pxMBP/yUL
	 I0mo1Pf/gPCq0CFowL4bVSlhEZXWXVl1rQ0aBvrM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C530C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLFSyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:54:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLFSyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:54:18 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543EC214F1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 18:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544122456;
        bh=KnXbT3lr38Q1FlPwwiq2uSCrY+8HSNulIIaUpUqMkj0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HqrxaB13+ZAdFk1V6ad3CpmZk02RP91GmGbVAopoC0rHpIz133Hz65XDiB9EYp/Me
         423AuJM+opJoY1MK5+wZWC4Nn2AzMP0kcZpY08beJpGZ6ye5vlArqbxOUIVqnDwRfh
         Vn5vjn8GBh1mcZFnkgwh597+ESBMSJ4SAHXCA/oU=
Received: by mail-wr1-f46.google.com with SMTP id r10so1507340wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:54:16 -0800 (PST)
X-Gm-Message-State: AA+aEWZPUdQ3HyOcSGwcdbKSR/vwZNhawi3VSoK/TpwEMecr5EAsyyqN
        VzlmsXHs6FL3moO4/VJpBClYn+RQ2GmkrdR4Y+h+ug==
X-Google-Smtp-Source: AFSGD/VuCQmtMgT+H4B0Ln1j+ZvLkV4nM6O4NiEe6fYyRRiH139VCy3xcxFqDqJR49r71lLncnJnyzyR1ETp9tDq0pE=
X-Received: by 2002:adf:8323:: with SMTP id 32mr25261943wrd.176.1544122454807;
 Thu, 06 Dec 2018 10:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io> <20181202100304.labt63mzrlr5utdl@brauner.io>
 <8736rebl9s.fsf@oldenburg.str.redhat.com> <20181203180224.fkvw4kajtbvru2ku@brauner.io>
 <874lbtjvtd.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <874lbtjvtd.fsf@oldenburg2.str.redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 10:54:02 -0800
X-Gmail-Original-Message-ID: <CALCETrViXJ0gD34yVd8QpB-CSeKZzzncvkPHReycTiQin4r4WQ@mail.gmail.com>
Message-ID: <CALCETrViXJ0gD34yVd8QpB-CSeKZzzncvkPHReycTiQin4r4WQ@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 4, 2018, at 4:55 AM, Florian Weimer <fweimer@redhat.com> wrote:
>
> * Christian Brauner:
>
>>> On Mon, Dec 03, 2018 at 05:57:51PM +0100, Florian Weimer wrote:
>>> * Christian Brauner:
>>>
>>>> Ok, I finally have access to source code again. Scratch what I said ab=
ove!
>>>> I looked at the code and tested it. If the process has exited but not
>>>> yet waited upon aka is a zombie procfd_send_signal() will return 0. Th=
is
>>>> is identical to kill(2) behavior. It should've been sort-of obvious
>>>> since when a process is in zombie state /proc/<pid> will still be arou=
nd
>>>> which means that struct pid must still be around.
>>>
>>> Should we make this state more accessible, by providing a different
>>> error code?
>>
>> No, I don't think we want that. Imho, It's not really helpful. Signals
>> are still delivered to zombies. If zombie state were to always mean that
>> no-one is going to wait on this thread anymore then it would make sense
>> to me. But given that zombie can also mean that someone put a
>> sleep(1000) right before their wait() call in the parent it seems odd to
>> report back that it is a zombie.
>
> It allows for error checking that the recipient of a signal is still
> running.  It's obviously not reliable, but I think it could be helpful
> in the context of closely cooperating processes.
>
>>> Will the system call ever return ESRCH, given that you have a handle fo=
r
>>> the process?
>>
>> Yes, whenever you signal a process that has already been waited upon:
>> - get procfd handle referring to <proc>
>> - <proc> exits and is waited upon
>> - procfd_send_signal(procfd, ...) returns -1 with errno =3D=3D ESRCH
>
> I see, thanks.
>
>>> Do you want to land all this in one kernel release?  I wonder how
>>> applications are supposed to discover kernel support if functionality i=
s
>>> split across several kernel releases.  If you get EINVAL or EBADF, it
>>> may not be obvious what is going on.
>>
>> Sigh, I get that but I really don't want to have to land this in one big
>> chunk. I want this syscall to go in in a as soon as we can to fulfill
>> the most basic need: having a way that guarantees us that we signal the
>> process that we intended to signal.
>>
>> The thread case is easy to implement on top of it. But I suspect we will
>> quibble about the exact semantics for a long time. Even now we have been
>> on multiple - justified - detrous. That's all pefectly fine and
>> expected. But if we have the basic functionality in we have time to do
>> all of that. We might even land it in the same kernel release still. I
>> really don't want to come of as tea-party-kernel-conservative here but I
>> have time-and-time again seen that making something fancy and cover ever
>> interesting feature in one patchset takes a very very long time.
>>
>> If you care about userspace being able to detect that case I can return
>> EOPNOTSUPP when a tid descriptor is passed.
>
> I suppose that's fine.  Or alternatively, when thread group support is
> added, introduce a flag that applications have to use to enable it, so
> that they can probe for support by checking support for the flag.
>
> I wouldn't be opposed to a new system call like this either:
>
>  int procfd_open (pid_t thread_group, pid_t thread_id, unsigned flags);
>
> But I think this is frowned upon on the kernel side.

I have no problem with it, except that I think it shouldn=E2=80=99t return =
an
fd that can be used for proc filesystem access.
