Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1230003-1520368038-2-15844593578341006990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520368037; b=QphQt947tKRen3a9mIosB9tGFJ98rcMKbRESiggsVCemHAX
    BPbHpk6e7bx0DVmGu7LzaCo3/X2D4FpYQKrHGPpafzTSazqO/q2gtOvreyBeOu96
    46U//DqDcjATR0lVy7/YeHHcquXifYG2F6oFp0fOO05kC9BbAdQ2vGY2ykYyVa7q
    yFVqChGjbl65rwOvEGokLayzdZjWnjHtX9MIZ3K6x1MoDyZfnikrV6fsD+uyCrh2
    cgAYJKtiI2aoW4Drse26u0MjNhPy5wDkok5ISK3V8oOTf24+22s2sOBxOwEJZf3N
    dzLqI6J0NV2mVN/3RTqQRyB4UdlxvItywaEab3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520368037; bh=xU95xsoz9RvaoYqAflLyALVkS4diTAs/PTuqN2
    l/Ymk=; b=DyBym0upsKfqFAk6ciqsWtQ+6da1uRQVjQZJoiUwGMHmpM0vLTEr8T
    XsElm1UaN1n7hgp1tr4srOPy9jPQ77R0WPnbblCSogkYdzPt/skhb2Zp1rZxZmo8
    SzKQq4Wk+ty9ziYA5APY8uoP9OiJSHX2leGuFA4tGPw5h6xB1JokfCvry7DKkWpw
    fo7aP0x91DwDubvXzpXQ8trGx8bIQAazWMihLZab5Zzx7CLwPBhHve1kPVl4PcLR
    8xSunBz4FdcT8NHug/hBF76CKVVUlyTRWnE7e8EUIvj70PVBqOCLq6nB8C0imMgx
    2GMx9DWYtDrjjAJgAYqOKy/ZwZJvUzAA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QmrxbzhD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZleqpiU1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bV4wOldI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QmrxbzhD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZleqpiU1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bV4wOldI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbeCFU1A (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 15:27:00 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40053 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFU06 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 15:26:58 -0500
X-Google-Smtp-Source: AG47ELs6KTkbZZ2FvIEvPtQPX6HuEhdbk+ATOi7GBXpv76zEyZdPyxqA9Cz2V5dEnq8b8FjjiuAKu9eQ5WjDRchvfbE=
MIME-Version: 1.0
In-Reply-To: <CALCETrVO6dc6Fzf2VPjLF1Z+YHU=di_fh53+EhcRqt3V+wQDuA@mail.gmail.com>
References: <20180306013457.1955486-1-ast@kernel.org> <CALCETrVO6dc6Fzf2VPjLF1Z+YHU=di_fh53+EhcRqt3V+wQDuA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Mar 2018 12:26:56 -0800
X-Google-Sender-Auth: tPpNSNuIQPC5VwFQNywRh4oMSnQ
Message-ID: <CA+55aFzog9eAgkrLF20zXKu7zq3k9Oz6zg0ekiwXZjZZEWLCNA@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Andy Lutomirski <luto@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
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

On Tue, Mar 6, 2018 at 12:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
>
> I assume I'm missing some context here, but why does this need to be
> handled by the kernel rather than, say, a change to how modprobe
> works?

Honestly, the less we have to mess with user-mode tooling, the better.

We've been *so* much better off moving most of the module loading
logic to the kernel, we should not go back in the old broken
direction.

I do *not* want the kmod project that is then taken over by systemd,
and breaks it the same way they broke firmware loading.

Keep modprobe doing one thing, and one thing only: track dependencies
and mindlessly just load the modules. Do *not* ask for it to do
anything else.

Right now kmod is a nice simple project. Lots of testsuite stuff, and
a very clear goal. Let's keep kmod doing one thing, and not even have
to care about internal kernel decisions like "oh, this module might
not be a module, but an executable".

If anything, I think we want to keep our options open, in the case we
need or want to ever consider short-circuiting things and allowing
direct loading of the simple cases and bypassing modprobe entirely.

               Linus
