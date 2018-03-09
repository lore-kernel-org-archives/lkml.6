Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447271-1520561571-2-14816191630024678232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520561570; b=QtYcM2AY6Acp1FkRmqfiXe58KsUv97Q6e1s24lMwITYPhtY
    SdV4dJP8zZS/3NRLre0y5wY2L/jgtvtHoTFu7Q92+DRv0ih5wOw/WImYzX5sAGr6
    7z67IRJ5aoBmLmS0TPTsmtvqaBtKFg7tY6hk5MCDJaMlwMW4+2N2+SJYVj1Vr5Hp
    sz6R4Z6AweH1lY/Oq6zIIBVymZV5MFnAeNJrVpQmr4JomnD5EwNYOnxkVqAmdVK3
    wzgreIwtnnUlubB0ae2wwAx8plsnVw1egw8YQLBhQ4otNgm2H5jjY7hk+Le4FGty
    5FtSS6cMMu2YYdJGSDzJrkOxeAea1pWbYTxOXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520561570; bh=yA0Bae0HonEPFVlESbHxmiflbYc9Woh8IGoqFI
    8dfSI=; b=kONruCMBTr55p1IAwX64go7CIYtzPdn34SHqhOg5xnYzp6eBTQBMR3
    4C4TeAzrxL8hJGgxw/zaVCMtWhkQKbbEnGdk/rV7UGToRHPTw6tAibemKKh6zYCw
    /FMNsndrJw2bVJzVgUBzW0EzGEAZe9tj37nZUShw588EWmmFa9nY1K2FihqKcrJj
    sjuUbiy0pjq05S4sJf72CmBVIfnYVanXkMVbEcHrkZ4x+wzVJvTFQeudMlosZ6ww
    1lANBubDMhAsHtaUnQmuBtuvZ4CRvR0Ds3IqIX4MSk2w0hwipyzpXjmKHBMTogFC
    2bDhhPq7pCfncnxtb7dY4TB+SuW9mFHw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750996AbeCICMr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 21:12:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbeCICMr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 8 Mar 2018 21:12:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A76621795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELv/eCt/tzC8eoevikzt3vdyBrfq/PdRCw1h9PjwOM7YeaF8/XEUAdFJtvamXp1A/tXMEaO8gFkIMEhYz64NeVg=
MIME-Version: 1.0
In-Reply-To: <20180309012046.6kcivmzzkap3a4xc@ast-mbp>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com> <20180309012046.6kcivmzzkap3a4xc@ast-mbp>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 9 Mar 2018 02:12:24 +0000
X-Gmail-Original-Message-ID: <CALCETrV8nPo=_rsSzy3Dt+y09mNgRi2+aYRk0Pj45j6BLRXgAA@mail.gmail.com>
Message-ID: <CALCETrV8nPo=_rsSzy3Dt+y09mNgRi2+aYRk0Pj45j6BLRXgAA@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 1:20 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri, Mar 09, 2018 at 12:59:36AM +0000, Andy Lutomirski wrote:
>>
>> Alexei, can you give an example use case?  I'm sure it's upthread
>> somewhere, but I'm having trouble finding it.
>
> at the time of iptable's setsockopt() the kernel will do
> err = request_module("bpfilter");
> once.
> The rough POC code:
> https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/tree/net/ipv4/bpfilter/sockopt.c?h=ipt_bpf#n25

Here's what I gather from reading that code: you have a new kernel
feature (consisting of actual kernel code) that wants to defer some of
its implementation to user mode.  I like this idea a lot.  But I have
a suggestion for a slightly different way of accomplishing the same
thing.  Rather than extending init_module() to accept ELF input,
except the call_umh code to be able to call blobs.  You'd use it it
very roughly like this:

First, compile your user code and emit a staitc binary.  Use objdump
fiddling or a trivial .S file to make that static binary into a
variable.  Then write a tiny shim module like this:

extern unsigned char __begin_user_code[], __end_user_code[];

int __init init_shim_module(void)
{
  return call_umh_blob(__begin_user_code, __end_user_code - __begin_user_code);
}

By itself, this is clearly a worse solution than yours, but it has two
benefits, one small and two big.  The small benefit is that it is
completely invisible to userspace: the .ko file is a bona fide module.
The big benefits are:

1. It works even in a non-modular kernel!  (Okay, it probably only
works if you can arrange for the built-in module to be initialized
late enough, but that's straightforward.)

2. It allows future extensions to change the way the glue works.  For
example, maybe you want the module to integrate properly with lsmod,
etc.  Rather than adding a mechanism for general privileged programs
to register themselves with lsmod (ick!), you could do it entirely in
the kernel where lsmod would know that a particular umh task is
special.  More usefully, you could extend call_umh_blob() to pass in
some pre-initialized struct files, which would give a clean way to
*synchronously* create a communication channel to user code for
whatever service the user code provides.  And it would be more
straightforward to make the umh blob do what it needs to do without
relying on any particular filesystems being mounted.

I think we don't want to end up in a situation where we ship a program
with a .ko extension that opens something in /dev, for example.

call_umh_blob() would create an anon_inode or similar object backed by
the blob and exec it.
