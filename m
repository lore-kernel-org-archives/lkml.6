Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1242004-1520624736-2-11491250673716239093
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520624736; b=ecVBxMSA+EG6EpGpCvnnz1hMx3qZQiuQnSCQkDOvJd4zZyE
    x0fXZ65X5YenjyzNGQOzm/ZXd82idSZGCsgdx0GNkmvyuiPUU05VcTDNOD0r7aWq
    stTBo9GDssLHtamT7nBLyJ3fU6G0OG6+dKxJ0dJNigfxL0UL5io0N7JrlNS/52gJ
    uu49/YkgNPx2mCaQB+5fbfBEIyGTh90g1E2AbrmQNN+wdHebe2Yd1h11WCZmfuTw
    4LzNKmFyi+h7x4KUYuoaCv4WCrEUCZDPEbkxOGkUQQV21EpK+Tln4dAqWAvfY55R
    K0kUNPJg/VmLuIO5+Ct0eY2mNMNHQ11nEfceZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520624736; bh=oiO9/G+Ne4pKljjppvntEwQ15uMWvCg3RIi7VR
    ZQZwI=; b=CFeef5rqSFeSs5KfYvlAvbGFhA+4ndGn7T1TAKOCUC9rdWs4vlY9dq
    dUDa0/w1tDm6Bt+o9uzxMMXeXdBLAyODnKDcdx/D8pgUIlB8klVX/PPX06D0Ab2v
    ycH6qIVeCYULGAPQFhtUPZnOKgZ5+PKACxLm9y/nf5axLV6XXsZqn0psF2ikR8EM
    DEDoUJMwp5yZSnyMLDfhN0yJbOPGnZBW7xDun/EQ18MfM9WNXNUUb/sYqipb3nwS
    Vn/4I8q75WYl3vfcGMK+KENW9vYZ69djUQ4I/nL9ze9oVCdGtnaTvj9bOw4Fh3qe
    5a1f/5+uV6Wtvb6eAT1HxO7YAUh8/8jQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=PrS2bg04 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ttSPmu97;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=PrS2bg04 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ttSPmu97;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeCITpd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 14:45:33 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:45669 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932233AbeCITpc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 14:45:32 -0500
X-Google-Smtp-Source: AG47ELsCrPkqMICXYKCAXCiJLK0KY0ZJeQFCM4eTYAxauGaJcq9oC5E8Wm5ShQGu+/PgyaPaON8ykxeMiHGIaeI7388=
MIME-Version: 1.0
In-Reply-To: <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net> <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net> <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
 <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 9 Mar 2018 19:45:11 +0000
Message-ID: <CALCETrUU-456u3R=D08fuJFEiiMLB3n=jdCTxvLqbSGA87r-9A@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 7:38 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 9, 2018 at 11:12 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> How are you going to handle five processes doing the same setup concurrently?
>
> Side note: it's not just serialization. It's also "is it actually up
> and running".
>

I think the right way to solve this would be to take a hint from
systemd's socket activation model.  The current patch had the module
load process kick off an ELF binary that goes an registers itself to
handle something.  We can turn that around.  Make the module init
function create the socket (or pipe or whatever) receives request and
pass it to the user program as stdin.  Then the kernel can start
queueing requests into the socket immediately, and the user program
will get to them whenever it finishes initializing.  Or it can write
some message to the socket saying "hey, I'm ready".

This also completely avoids the issue where some clever user manually
loads the "module" with exec() ("hey, I'm so clever, I can just run
the damn thing instead if using init_module()!" or writes an
out-of-tree program that uses whatever supposedly secret API the
in-kernel binary is supposed to use to register itself (and I know
people who would do exactly that!) and the kernel does
request_module() at roughly the same time.
