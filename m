Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3541274-1520565481-2-14779925994918254516
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
    t=1520565481; b=FSC22uvtgfCN/Bz+lJuyxQ93KA+jr9HFEZsPkUefeavowQS
    Eld/YY9pMALU2LVQpGMUxHfElV1ndgbI6Z2c891SgwqOKOuHvDQmfL0S7V1aW5rx
    kIr++VzLtKflXozx13rBgr7JvrVkFv0Pv0/6xSf75dFM9V6VfbXne7APdEex0FKF
    KOSZGvGD+ZZuxTbcFMx48ZoUXlLa1HcIzROlIpVZuUx6C+SGmO5/dbCopaAdrRVi
    vTkViwb+9yfze8rBdxkiTtDJooAq01O/7IgoLpDFhXbCeIipPKb9/qJ4XYR67KOG
    nnlXMGIaeyXBEtDjY/64mWX3X84DeEkwcFWb2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520565481; bh=c2UYiCu0GoN24EOWu0Bqd9Is3G0knkKf/AcEhR
    U3jmY=; b=uq276sor3F4c3CYPZ/ZD3PqO6Bl5OOBZr7n9Anz5Cj+6NQO7Q7kOos
    TnF0UrQjriWCffPB4tgs2bYJLVOEu8rXjfcVFue8eB1hIKCynOgVzFpOveUiljxf
    B2qerXlKfhQCXfFfCLY5DkopF4S4e+OEB5OnKt/yvslnMEVRlXQCWTb0BK87Y7/8
    IC5xbqyLwiY+P+ZuxErBdKj/pFc30ZwOFjRSUOvVd/rzRfmzU3ooEVM8XsYxEk5H
    EN8EbFH1M4jEdc1YPqhhpbaGF50ryKJhuIPbPYM4vwvyrevMnyo9k93Frdzt0SLW
    IvWiEhbXgNxoBkXm0FtrFOKAT96hQ4ZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QHw4BM18 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JtR2VEOz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fazMTIV6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QHw4BM18 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JtR2VEOz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fazMTIV6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeCIDRm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 22:17:42 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:45474 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeCIDRl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 22:17:41 -0500
X-Google-Smtp-Source: AG47ELueOC8NTe5vVEikupGPPFMFo8Sdm8ZTlxyZse72L4M+zSy8aGfOZ72x0KvuSigUm1AaQVqMLBw5euK2+dj7f+c=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
 <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
 <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com> <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Mar 2018 19:17:39 -0800
X-Google-Sender-Auth: XswQv0HNVUYhGDM3HeZg6Qr0TNU
Message-ID: <CA+55aFy9OoeWpHnLGCiLWxPz8tyzPaK4HS-4OfH6KEhNmsQzDQ@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
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

On Thu, Mar 8, 2018 at 7:06 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I don't like Andy's "let's make it a kernel module and then that
> kernel module can execve() a blob". THAT seems like just stupid
> indirection.
>
> But I do like Andy's "execve a blob" part, because it is the *blob*
> that has had its signature verified, not the file!

To be honest., Andy's approach has the advantage that all the
synchronization we do for modules still works.

In particular, we have module loading logic where we synchronize
loading of modules with the same name, so that two things that do
request_module() concurrently will not lead to two modules being
loaded.

See that whole "module_mutex" thing, and the logic in (for example)
"add_unformed_module()".

Andrei's patch short-circuits the module loading before that, so if
you have two concurrent request_module() calls, you'll end up with no
serialization, and two executables.

So maybe Andy is right. He often is, after all.

             Linus
