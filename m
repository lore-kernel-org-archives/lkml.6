Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1120109-1520363588-2-15329680238134899198
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
    t=1520363587; b=d7eXJyDcSO5wXykIxkgnRGCmDA0n1lCYe4h0KQdhs+N+Uql
    GqyOOfBWPYVN9WrZieIAJDIpg9vXXK/3+DffstZgb3yKIBifbqLT7hScA3oSVOzZ
    ZWDCIsRym3a3rnWy89trUMo3NQXXlVip5Pn9yaj6CuEaLQ5PVUJ/An9NzrijqIEC
    XmnSw8wkbMM32aJe7s8ggNwMIrtyLTzPJtFUUBRsPkp1vUNceQfjCL3vs5EQAg5O
    Y5j9LOwW8nlWrWHVAYqqzZ0d9hK2Fkk6TAnZPiOcIEY82bKKQg2VMvowv+lvOUZm
    xru1QP+RneIVH/PZ+X14DU/9V5vUWgwMXzl6mBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520363587; bh=auHaP2vCw7YoXqCJgTcQQQBSFODcF+/0yfJNA/
    BGUcs=; b=ao7XGKhheuS5Y15CNVW1+7MK16P3cwVqpPWN+XPBb73q8m5JAxieBa
    xTtD3XiP3lh24dEGLtdCPKNtAwfuSZwDZgxDKgF0fv7btEzekpwTpRX6Sj7gouHZ
    5A9WpCGTbi1+PYXrthjNWHCVHBvNLYUdUjCth/d87NA1ufvAhc386HQfoj99ctBP
    LDAWzIeC3xorDn/QMiI/BsG0TWd4BkCX92XS15h6aahZf7jeDBwZ59qCLLkjbjem
    0hJhd4EiHsYRRaToHsFq8m0w4o7HAU2qx/kKZWkKrXgcLYjzkZgWSDcHvuLLubOL
    kV5egewP29tjm17yS2jUBTEx9CmkPNPw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NTkjdWxr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=EW+cZrS+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jI4tKCEx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NTkjdWxr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=EW+cZrS+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jI4tKCEx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeCFTM2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 14:12:28 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40952 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbeCFTMZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 14:12:25 -0500
X-Google-Smtp-Source: AG47ELuG6w424sUiVCP4WIwCgcage+k80g5InLrNO6gyJFgGm4k8uHU1vWFmWfiECN+YrPNyQ/2EXhcd1EEAOadssgc=
MIME-Version: 1.0
In-Reply-To: <20180306013457.1955486-1-ast@kernel.org>
References: <20180306013457.1955486-1-ast@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Mar 2018 11:12:24 -0800
X-Google-Sender-Auth: D2_eZzdGHg-RtDffp08f36Xo0Qk
Message-ID: <CA+55aFx5Q8D3cmuoXJFV9Ok_vc3fd3rNP-5onqFTPTtfZgi=HQ@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Alexei Starovoitov <ast@kernel.org>
Cc: David Miller <davem@davemloft.net>,
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

On Mon, Mar 5, 2018 at 5:34 PM, Alexei Starovoitov <ast@kernel.org> wrote:
> As the first step in development of bpfilter project [1] the request_module()
> code is extended to allow user mode helpers to be invoked. Idea is that
> user mode helpers are built as part of the kernel build and installed as
> traditional kernel modules with .ko file extension into distro specified
> location, such that from a distribution point of view, they are no different
> than regular kernel modules. Thus, allow request_module() logic to load such
> user mode helper (umh) modules via:
[,,]

I like this, but I have one request: can we make sure that this action
is visible in the system messages?

When we load a regular module, at least it shows in lsmod afterwards,
although I have a few times wanted to really see module load as an
event in the logs too.

When we load a module that just executes a user program, and there is
no sign of it in the module list, I think we *really* need to make
that event show to the admin some way.

.. and yes, maybe we'll need to rate-limit the messages, and maybe it
turns out that I'm entirely wrong and people will hate the messages
after they get used to the concept of these pseudo-modules, but
particularly for the early implementation when this is a new thing, I
really want a message like

     executed user process xyz-abc as a pseudo-module

or something in dmesg.

I do *not* want this to be a magical way to hide things.

                  Linus
