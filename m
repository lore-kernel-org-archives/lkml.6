Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3488798-1520562721-2-14185644260681197322
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520562721; b=v/eWeOAJC2cmuuoI6xOX8/sgpCAaPJIaxXsE8AuZevD9vqn
    Zxr3cWUwvSyOuCSg8jJmXC4opUjdXuNDfHmzvIUSoNdYdCbMwZxuwG2+DmIH0ta5
    acuU7cNm6vy1tPAlZdkwHeb4h/uFMRkVOKDJWX7KXUjtwbbb5EKTTQePkb4cOIKf
    t06OIcRF9cvifW5iTpD78CGpVQN/KaVIDhNA5A2Y5Sr1AqyleXzDmzVpCmsTxahG
    ybrbJuNY30PjWu3nyb1EXMB8ZMxx007v5dYThgfFksxhY30yjCa9tsU5uIB1wtQ+
    lK7FWY3qnljQQe1zG4YL6VBkZEwcCxLVJK4XQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520562721; bh=rF9Vu5mMEqA0plRW0nRwzdJdoEYOP18DHTD+eoYzkfE=; b=T
    nhXdRxE2ay5z28WowDCQhyH5Lp1CEsoM7aaVmsZBGkyKFiJffiVgNUQ2KDyAL/ce
    oxEVBlS2dJVVT48t1GnwOzzdTdBGSDdDpLuW7JgfKbNy65evqnkyR4ZxGfdMDwLu
    n0cm34LZGmXjB32MNaRAVJRsfVJ4gUNYTcXC3WXWVfyjrpywC+m0pjdFt3oAJvVY
    YUSTNu277ExtMqirHJrkGS7pgevRI+HifCFm4lNAOWDC3JboxR4qi+guNurH0wh1
    1r9YKP9d1bwNBGOi4Q86y4l20nHHlJRdt4fjRPgscKwOSrMxWS3n9jdrqQllwqrs
    n2xZk30GXAaooMHGhOEsA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbeCICb7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 21:31:59 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:46172 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbeCICb6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 21:31:58 -0500
Date: Thu, 08 Mar 2018 21:31:53 -0500 (EST)
Message-Id: <20180308.213153.2003279953084099668.davem@davemloft.net>
To: luto@kernel.org
Cc: alexei.starovoitov@gmail.com, keescook@chromium.org,
        ast@kernel.org, tixxdz@gmail.com, viro@zeniv.linux.org.uk,
        daniel@iogearbox.net, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, mcgrof@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
From: David Miller <davem@davemloft.net>
In-Reply-To: <CALCETrV8nPo=_rsSzy3Dt+y09mNgRi2+aYRk0Pj45j6BLRXgAA@mail.gmail.com>
References: <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
        <20180309012046.6kcivmzzkap3a4xc@ast-mbp>
        <CALCETrV8nPo=_rsSzy3Dt+y09mNgRi2+aYRk0Pj45j6BLRXgAA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 9 Mar 2018 02:12:24 +0000

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

Anything you try to do which makes these binaries "special" is a huge
negative.

> The big benefits are:

I don't see those things as benefits at all, and Alexei's scheme can
easily be made to work in your benefit #1 case too.

It's a user binary.  It's shipped with the kernel and it's signed.

If we can't trust that, we can't trust much else.

And this whole container argument..  It's a mirage.

Kernel modules are 1000 times worse, since they can access any
container and any namespace they want.
