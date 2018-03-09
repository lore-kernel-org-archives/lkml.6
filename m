Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3527705-1520566059-2-15842164711768200975
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520566058; b=Zj9Nkduu2yDIRGJuGPPGg6ssPXAhwj5LwxsVpCki3Owdt8s
    gWwlFn/sMO9EqvoMOFD24qv25p1xCv3JW/tYnmLgjuBCDpfN+UW2GgozfxtC4lWu
    IgnnGgslLwLdN6Xrk+OAmSwHOk9jKRAqZ7OKEyIY7j3Zi/8teXNk2XvA8glFOjKA
    k5hV16WGl56cSI3vJkUuIGQWQfvLeTnOTFzqZT1C28X7S7MPxMT0vqVQDyf7R8Sf
    KsvljsZu5WEu9mh77giTwUxIbmDlY2NWbZ7SVK9ZNCYg6XWdgAl2xPyD4gh3QAEM
    d2L3sMWgcxn7hULsKB6ulRUFQBAv9v7rOVuWdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520566058; bh=Vho0LiFaFgeBiqgdHZcT9UW/ek
    KHXSCw4D2Os44htIA=; b=klAza9aiPf0Uf55cVSD77KhDQZnam2gGfGXQF64a3T
    Dohh1hV2tgrrTjjnQyZ7oySEkEODg03zRHA5L+mJJU7CLGwDoG2YLtYeb3cw/rHY
    hXiwiH8zA/OTbPxiOV9IfGYEKdl3/+STn/TvL0fRLmke1NWdNejHlDdAXpCLK0SH
    FE2JH/3sTo0ZTRBpNuWDyUZ+GFXQYePnxfqlMIy8UNb5GUYKPO3qU3g/hoUx+aB7
    SCVfS4rDPEoRNUVFs/qCY2vy5CC2qZXm+OH4p5sXGIL2CLkUixM/FmcZ7r3WfUkk
    0bd4xxdSG86wEn00vCLod0VnbMELZ1yR9ovm0z3m/+VA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tsJdIRxw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IpFy0LQL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tsJdIRxw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IpFy0LQL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbeCID1h (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 22:27:37 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46653 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeCID1g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 22:27:36 -0500
X-Google-Smtp-Source: AG47ELttZJ0nw2faVZUGg7UFVsYRtsLOBszneB4DeB9T4KHdRBvPYwiCZmcojaMZL8fyHWVeOLd0Rw==
Date: Thu, 8 Mar 2018 19:27:32 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andy Lutomirski <luto@kernel.org>
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
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Message-ID: <20180309032730.qaqsv3hc6t4wghxc@ast-mbp>
References: <20180306013457.1955486-1-ast@kernel.org>
 <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
 <20180309012046.6kcivmzzkap3a4xc@ast-mbp>
 <CALCETrV8nPo=_rsSzy3Dt+y09mNgRi2+aYRk0Pj45j6BLRXgAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV8nPo=_rsSzy3Dt+y09mNgRi2+aYRk0Pj45j6BLRXgAA@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 02:12:24AM +0000, Andy Lutomirski wrote:
> On Fri, Mar 9, 2018 at 1:20 AM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Fri, Mar 09, 2018 at 12:59:36AM +0000, Andy Lutomirski wrote:
> >>
> >> Alexei, can you give an example use case?  I'm sure it's upthread
> >> somewhere, but I'm having trouble finding it.
> >
> > at the time of iptable's setsockopt() the kernel will do
> > err = request_module("bpfilter");
> > once.
> > The rough POC code:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/tree/net/ipv4/bpfilter/sockopt.c?h=ipt_bpf#n25
> 
> Here's what I gather from reading that code: you have a new kernel
> feature (consisting of actual kernel code) that wants to defer some of
> its implementation to user mode.  I like this idea a lot.  But I have
> a suggestion for a slightly different way of accomplishing the same
> thing.  Rather than extending init_module() to accept ELF input,
> except the call_umh code to be able to call blobs.  You'd use it it
> very roughly like this:
> 
> First, compile your user code and emit a staitc binary.  Use objdump
> fiddling or a trivial .S file to make that static binary into a
> variable.  Then write a tiny shim module like this:
> 
> extern unsigned char __begin_user_code[], __end_user_code[];
> 
> int __init init_shim_module(void)
> {
>   return call_umh_blob(__begin_user_code, __end_user_code - __begin_user_code);
> }
> 
> By itself, this is clearly a worse solution than yours, but it has two
> benefits, one small and two big.  The small benefit is that it is
> completely invisible to userspace: the .ko file is a bona fide module.

Unfortunately it's not quite the case.
The normal .ko that does call_umh_blob is indeed seen in lsmod,
but the umh process is a separate task.
It could have been oomed or killed by admin and
this normal .ko wouldn't notice it, so health check of umh process
by the kernel is needed regardless.
Right now bpfilter has trivial fuse-like protocol. This part
is still to be designed cleanly.

No doubt that visibility and debuggability into this umh processes
is must have, but lsmod/rmmod interface doesn't quite fit.
As you said letting this priv tasks register themselves in lsmod
is certainly no-go.
I think if they will be in lsmod, kernel has to register them
and establish health check with umh at the same time.
I think worrying about restarting is not necessary.
This is still kernel code with the same high standards and
review process. If they crash it's really a kernel bug.
It only doesn't take the system down.

> I think we don't want to end up in a situation where we ship a program
> with a .ko extension that opens something in /dev, for example.

this part I don't get. What's wrong with open of /dev ?
I don't see a use case for it, but technically why not?

> call_umh_blob() would create an anon_inode or similar object backed by
> the blob and exec it.

Interesting. I haven't considered such approach.

For full context it all started from the idea of 'unprivileged kernel modules'
or 'hardened kernel modules'. Something that kernel can easily
interact with, but much safer than traditional kernel module.

I've tried a bunch of crappy ideas first:
1. have a piece of kernel .text vm_mmap-ed into user process that
doing iptables setsockopt and on return to user space force handle_signal
to execute that code. Sort of like forced ld_preload where parasite
code is provided by the kernel but runs in user space
2. have a special set of kernel page tables in read-only mode while
iptable->bpf conversion is happening
3. have load_module() fork a user task and load real kernel .ko into it

trying to hack #3 realized that I'm mainly copy-pasting a lot of
load_elf_binary() code without elf_interpreter bits,
so figured it's much easier and simpler to blend sys_finit_module
with load_elf_binary via tweaking do_execveat_common and keeping
that .ko as normal elf which is implemented in this patch.
Debugging of that fake .ko is so much better.
If it's done via call_umh_blob() the process that starts
will indeed be a user mode process, but you won't be able to
attach gdb to it. Whereas in this patch it's normal elf and
standard debugging techniques apply. A developer can
do gdb breakpoints, debug info, etc.
That is huge advantage of keeping it as normal elf.

