Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1163969-1520619813-2-18209005622468460526
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520619813; b=PJT4AgHCvHtViv4jZizuYr3EdNgvb1gdSzSb2NHtt1wZKig
    Mh9uB1Z7W6nAo4OXES5l7w7nABg9E/9K5L/tx0kjnICDtutJ7MMBPbnZw4LMk9QX
    vuzzwcJ2fTlCFiR+RN4HxcInuerh0QqSwQAbJgXMwGS7xW3XrKPZFa/kJEWimXLH
    7A/j1LSaCo2S6aVPosBppzxq0hHO/I4Z5ntW4jEWqTjn4bIrE3lrsUYIc5AaVrXH
    L8ccyg9hwadP93c6rjf3FLfFloo5YWwTT6aDes0iTOWBmqnOolGkMRnD25IG3M/v
    AjsqwQBdOFCRiPWuSMIbhcae+BSQxOYDI1cZjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1520619813; bh=l9FQ5
    txSPpJkf733dbf+QNMTK7hGsw3v+d+Hs8R5Kuw=; b=DA4O+HfQtA9sINRoGrN5Z
    o1R3Oz46JjnaB8FntUcxkqe0zma9ZivrD5wbmGajX2/sGIAoIAW/fsuHre2E/Kkq
    pfWVD/82S3DisVQNedhbU4HzHQYuoZtHGDPlzS3r4FLLeeCNYK4nduNigK7thKGL
    1SFcxpE9+57B7wTXMpIZnx+5ut5OVkTW7OLxmfZqPX2yvFQIrhb7HPOTU8P09uRg
    vDIqvE4YwYuj85t7vxxgNxybW6cPjdhD11bZjgtakb6DJILeRneAaZyAhY3xsy2v
    Ezqz79hzaSTcp++AMH4UqoaduEj9p/hQbQjRkyHKacTdTcpQL0zcK+qgCcJTocjz
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=rbeBun5+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BEHBDbkL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=rbeBun5+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BEHBDbkL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeCISXb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:23:31 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:37317 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeCISX3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:23:29 -0500
X-Google-Smtp-Source: AG47ELusmFWQFqFtRacl50wuTigatPFLd1Gf89HiN0/OAfq3iL2GZTslK7cSVZShLhKu2t2L0ViEUQ==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15D100)
In-Reply-To: <20180309181527.GA15803@kroah.com>
Date: Fri, 9 Mar 2018 10:23:27 -0800
Cc: Alexei Starovoitov <ast@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E622B120-3C3A-4A15-8E1B-6F7649038623@amacapital.net>
References: <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com> <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com> <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com> <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com> <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net> <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com> <CALCETrWKLB4e8Cw6ZRiDP535=HzoQJczsEMEpytstveO15mAMg@mail.gmail.com> <6d2e31fa-d87b-fea6-c919-b7d066bb0385@fb.com> <CALCETrX+oGQthnk5AR0MUJwLLwguWG_yq_r9QQPhUYjvz9jyPw@mail.gmail.com> <c9388b10-19ac-0bd5-4986-9c306d23046e@fb.com> <20180309181527.GA15803@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On Mar 9, 2018, at 10:15 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> 

> 
> Oh, and for the record, I like Andy's proposal as well as dumping this
> into a kernel module "blob" with the exception that this now would take
> up unswapable memory, which isn't the nicest and is one big reason we
> removed the in-kernel-memory firmware blobs many years ago.
> 

It might not be totally crazy to back it by tmpfs. 
