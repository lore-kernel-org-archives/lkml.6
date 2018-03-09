Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1071963-1520619469-2-6592825688322446644
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520619468; b=r2I8oPkchjOcRyndQZsesULq9mhaIQElflEEFqjjpE6aW0o
    8O3Hc9GgRBJAEnuQQs4c4SId7EvhRR9rVRZZhcj6IXbPoOezgFHpehycHiaCNhJI
    /tVoLZiYGsAPF/n4GA7Dsj7WBvn25vMQ+tMNnT1EleAiIEYb+TiUREBJ+TSbpA+m
    1MRhHtfDuUp8+YOurHB6XQypfVa7/gV4HzDfGzG94Z2s5Bqx8GMGxKx4mS2qw7VX
    2MfbgX7TZq8+MT1Mv1XwzVGgb4yBwXh81zCtCudvotM3gICN2xgS0aWAL9kErUTZ
    klss5QOcKT9/rNsdT8+DMX4n9Smzz+vQAz4ssAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520619468; bh=/Z9lUP18NApiyut7fHhEYiObUcEeI9zH0Ydljf
    G+MqI=; b=BWVi9+INxkRMqjtwQf+o4+j0ZiDYEMBMfCfnJXg5HjLmPqTZqDUTwr
    rWk7I2JggPtcVziFoN67jk5NDr7RtQ9xgYCC7E0JXUX+R2TZA1ERTeSJdA4I1JGF
    kfDw1upowXYaD9L6iZ1pVe9XmXM2oYLYm3d5jfrEnH6mecEgmqBXgQsaDW4Ovduc
    F4H7nXNX1FDEmD5SJkXt3WL/4WxtwclJwuDEDw0pfn4XRw/mJf75IoLAa5B4rGVX
    IYOhbTSlxbbijRYBfOw6WWvBWWCpsbg5mWlDephWtTcxFUOJvH0emkiGTGrTmw/8
    Gyia47O+fgYGGZZOeABehwWBmb0lx2iw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=amZELCFF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JdCEpEvv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LBLsDtMx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=amZELCFF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JdCEpEvv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LBLsDtMx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeCISRo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:17:44 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:33267 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeCISRo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:17:44 -0500
X-Google-Smtp-Source: AG47ELvjA4FYdrqFYNgMKQm4/BWfqvJDYPIfIwhLiBBs/Wp18418jiSk9Y0HQ798+zxqKDzZegyChYEWdbhZzcSJ+2U=
MIME-Version: 1.0
In-Reply-To: <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
 <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
 <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com>
 <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
 <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net> <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 10:17:42 -0800
X-Google-Sender-Auth: VWvVETAnJPDbj4HFBZM7tjZVP3I
Message-ID: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Alexei Starovoitov <ast@fb.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 9:08 PM, Alexei Starovoitov <ast@fb.com> wrote:
>
> there is not abi breakage and file cannot disappear from running task.
> One cannot umount fs while file is still being used.

I think that "cannot umount" part _is_ the ABI breakage that Andy is
talking about.

> Not only "read twice", but "read many".
> If .text sections of elf that are not yet in memory can be modified
> by malicious user, later they will be brought in with different code.
> I think the easiest fix to tighten this "umh modules" to CAP_SYS_ADMIN.

I don't think it actually fixes anything.  It might just break things.
For all we know, people run modprobe with CAP_SYS_MODULE only, since
that is obviously the only capability it needs.

Hmm. I wish we had an "execute blob" model, but we really don't, and
it would be hard/impossible to do without pinning the pages in memory.

My gut feel is that the right direction to explore is:

 - consider the module loaded for the whole duration of the execve. So
the execution is a *blocking* operation (and we get the correct
exclusion semantics)

 - use deny_write_access() to make sure that we don't have active
writers and cannot get them during the execve.

The above mean that something that executes to load a new ebpf rule
will work very well.  But a "start and forget" will not work (although
you can obviously do so with a internal fork/exec).

Hmm?

                       Linus
