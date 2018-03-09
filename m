Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1185227-1520621477-2-15021061796719264467
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
    t=1520621477; b=HsfIz5AKenc5ckUZHhrz6D5FGFOFLcDvhfBkvSgEB++0qAf
    dmZceLUTIIz4OLFk04r34FfPobyA1r+MnmgUtBPCTj2tDmLs32O/TJUzAkf8NPU0
    tYOZIdgjHVu8aT7wldL+6zd5YAumaVOcQ1IsssOG2q5cWMoJbUZtadw+MoEfVqtD
    MMH1W7WIiMyrcAINZCy9YD6jSa0kOLDc6try9Qc49lE+h751vKirRz8uVfsMEBqa
    ru9ZTzIZf1imxL1FhJI+2GI3NyKDDXDxefVjpKR+ND6ZA/D+bZl8OUpSXklZbCmz
    tCpR163azQtKUbKzkgvbnTJ5hO5SRXFfOaRkvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520621477; bh=t8O0cL2gtjQMCYEaKwcwpPyO+9nA3LlNUJmkvA
    I+pN4=; b=GQ3+Vjs6n/q78wkEKfrZN7u0zwq9i9YNP4toAHISzm0Hanj58a8xBh
    i5yl5/EubdMq+VHLtbOxS2O2/6h12vofev4jaCC/hfoW2jAad7fZ00iMDXkdKnqF
    8C3FVSWFFozsc6nwZ4wBsnhDiEkMmT0fpL4soKQjI6x6M+sM1Kyg6CbnhTueY5xw
    ZjJJFaZ2fAP1mgoBI/iSkNyOTT4IreDGDCKs9CSzFuc8a4XqL3QBWBoQNswW0k7U
    YrTp/2ljwBN/cVxuMVUr+Lwnyo+4ziBuCkuXunvJrs6e6gThUUU6WzxO/qHaf7iM
    Ya2zqsJh/Yc9pDVkEdUTL027R8hGfLNg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yto8VYIg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oD2bpRZ3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OXnRYrpR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yto8VYIg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oD2bpRZ3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OXnRYrpR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932233AbeCISvC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:51:02 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:38387 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932165AbeCISvB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:51:01 -0500
X-Google-Smtp-Source: AG47ELtEx0FSHjuuYfFSvxaC5I3WfcuGya8nJ5AcAE+Vo905ZOdKh1DFZ64ShD/lkvpcsnCa8qFEDEJYOVuIJ51blo0=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJcuSojm_KN5+JQ3fV6J09V6dmNB6haqu11xkXTq=nxog@mail.gmail.com>
References: <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
 <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com> <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <20180309.133509.1275903267249306409.davem@davemloft.net> <CAGXu5jJcuSojm_KN5+JQ3fV6J09V6dmNB6haqu11xkXTq=nxog@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 10:50:59 -0800
X-Google-Sender-Auth: 0eD574dZ3b_QqaATyGzOuaiRD3g
Message-ID: <CA+55aFzJEkUGfRkKqc8twaDSdSH_r_OWnFm-e4uNQf4SrJy7-A@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Kees Cook <keescook@chromium.org>
Cc: David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@fb.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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

On Fri, Mar 9, 2018 at 10:43 AM, Kees Cook <keescook@chromium.org> wrote:
>
> Module loading (via kernel_read_file()) already uses
> deny_write_access(), and so does do_open_execat(). As long as module
> loading doesn't call allow_write_access() before the execve() has
> started in the new implementation, I think we'd be covered here.

No. kernel_read_file() only does it *during* the read.

So there's a huge big honking gap between the two.

Also, the second part of my suggestion was to be entirely synchronous
with the whole execution of the process, and do it within the "we do
mutual exclusion fo rmodules with the same name" logic.

Note that Andrei's patch uses UMH_WAIT_EXEC. That's basically
"vfork+exec" - it only waits for the exec to have started, it doesn't
wait for the whole thing.

So I'm saying "use UMH_WAIT_PROC, do it in a different place, and make
sure you cover the whole sequence with deny_write_access()".

              Linus
