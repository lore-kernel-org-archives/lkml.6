Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3342454-1520558657-2-10708988345464743713
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520558656; b=kf4p+rycrIGfgXgjTz8eoKaz9e61jlR8BI1ioBun43InpLg
    gxvpN8EQNCCom8X3HO577p7/22pbNo+wTTZhXA9p3UbOfychKfIoyFwIzyNxkqPg
    CVZewJf05SZ6L6O89g5piIfYPlOXJBYHxffa2EuCbzR5kDn9mjytE7t/2zaIs+UB
    W35+f1v9s/WBvOsc7hYAuL5c0ar1ju1lMOFQXgv8L0tllJa/9V/HMJwQCtrXKw1A
    aarm6rne+MG2TD7wARlaMgU3oiagquTZ0zkibodm0gE/UAt9F1VVkUPjvB7IGG/L
    d9/joLJEPfFWCXVYXqTrahzIVoda84raCGuPpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520558656; bh=xbXrcyHq2pTNbbtVQOg2jWT0SctUD7KSN7lE5p
    Z4KX8=; b=bdPM5mhv+AzoUduPfHBxpi34jaRMDNMkDLHnM7l3Fwsbp21hRewMWz
    uCUzqXjd7nDSV3TVzV1X3DD5/IJCms5jLI2tqo5u2hWUB2P5ipdtZKHfxq1Ak5en
    yM77qkocyiXcO92c9rGgpHexcLB26kU40s+eE/gsPhKvhetv//33jjNXy+58tn4U
    UMX4sJ+PcT5PwHAQBMUcFK9LtV67BhG7kDhg5xpwkbHAQ2rlUW3vylCHN3kg+i1J
    VR6ROi7GperZXkyY7NPEXc7jd/6Z73fHSJGu25J+RWDj9ZteevpzmryLNqm8Y+DV
    Z33avKgjSDas4FTXZ6SY3Ds4qlQoDZYg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=UEAVHk/Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=bI59rta+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SnuJpFY+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=UEAVHk/Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=bI59rta+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SnuJpFY+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeCIBYO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 20:24:14 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41050 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbeCIBYN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 20:24:13 -0500
X-Google-Smtp-Source: AG47ELthzkyhcC8Vi8OP8La1HMfzH+dLbcCu2O2aEbYsXRTZxlIvl6RvlpuMpLxadEvG5vUOoLdZcD0Jsi+JC7/ObDo=
MIME-Version: 1.0
In-Reply-To: <357c330f-0165-b7a4-7ecc-4cd797e61e15@fb.com>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <357c330f-0165-b7a4-7ecc-4cd797e61e15@fb.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 17:24:11 -0800
X-Google-Sender-Auth: D_IR42H8ayeCUfO0OokZm1Odnl8
Message-ID: <CAGXu5j+tL-3BM70kfY-XfEovKB30XuSFCaom5yaGHOD-ngokFA@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Alexei Starovoitov <ast@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Linux API <linux-api@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Paul Moore <pmoore@redhat.com>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 4:57 PM, Alexei Starovoitov <ast@fb.com> wrote:
> The above are three paragraphs of security paranoia without single
> concrete example of a security issue.

How is running an arbitrary ELF as full init_ns root from a container
not a concrete example?

I'm not saying this approach can never happen. And this isn't
paranoia. There are very real security boundary violations in this
model, IMO. Though, as Andy says, it's more about autoloading than umh
itself. I just don't want to extend that problem further.

>> As Andy asked earlier, why not DYN too to catch PIE executables? Seems
>> like forcing the userspace helper to be non-PIE would defeat some of
>> the userspace defenses in use in most distros.
>
>
> because we don't add features without concrete users.

It's just a two-line change, and then it would work on distros that
build PIE-by-default. That seems like a concrete use-case.

>> The exec.c changes should be split into a separate patch. Something
>> feels incorrectly refactored here, though. Passing all three of fd,
>> filename, and file to __do_execve_file() seems wrong; perhaps the fd
>> to file handling needs to happen externally in what you have here as
>> do_execveat_common()? The resulting __do_execve_file() has repeated
>> conditionals on filename... maybe what I object to is being able to
>> pass a NULL filename at all. The filename can be (painfully)
>> reconstructed from the struct file.
>
> reconstruct the path and instantly introduce the race between execing
> something by path vs prior check that it's actual elf of already
> opened file ?!
> excellent suggestion to improve security.

I'm not sure why you're being so hostile. We're both interested in
improving the kernel.

Path names aren't stable, but they provide good _debugging_ about
things when needed. For example, the LSM hooks, if they report on one
of these loads, can produce a hint to the user about what happened.
Passing "/dev/null" around is confusing at the very least. The ELF is
absolutely not /dev/null. Why make someone guess?

>>> [...]
>>> diff --git a/kernel/module.c b/kernel/module.c
>>> index ad2d420024f6..6cfa35795741 100644
>>> --- a/kernel/module.c
>>> +++ b/kernel/module.c
>>> [...]
>>> @@ -3870,14 +3896,21 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char
>>> __user *, uargs, int, flags)
>>>                       |MODULE_INIT_IGNORE_VERMAGIC))
>>>                 return -EINVAL;
>>>
>>> -       err = kernel_read_file_from_fd(fd, &hdr, &size, INT_MAX,
>>> -                                      READING_MODULE);
>>> +       f = fdget(fd);
>>> +       if (!f.file)
>>> +               return -EBADF;
>>> +
>>> +       err = kernel_read_file(f.file, &hdr, &size, INT_MAX,
>>> READING_MODULE);
>>
>>
>> For the LSM subsystem, I think this should also get it's own enum
>> kernel_read_file_id. This is really no longer a kernel module...
>
>
> at this point it's a _file_. It could have been text file just well.
> If lsm is thinking that at this point kernel is processing
> kernel module that lsm is badly broken.

Again, this is about making things more discoverable. We already know
if we're loading a kernel module or a umh ELF. Passing this
information to the LSM is valuable to the LSM to distinguish between
types of files. They have very different effects on the system, for
example. The issue is about validating intent with target. "Is this
kernel module allowed?" and "Is this umh ELF allowed?" are better
questions that "Is something loaded through finit_module() allowed?"
Note already that the LSM distinguishes between many other file types
in kernel_read_file*().

-Kees

-- 
Kees Cook
Pixel Security
