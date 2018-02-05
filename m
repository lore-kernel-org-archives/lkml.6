Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3016244-1517851406-2-14453286886029324288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517851406; b=WtQFhE0/56U5kElGc9zw4qgoKPHuxnND3mjK3q+IpWvhW5x
    qyPCDkD6LY8c2zEYUseGu6OO4HvsKPkr/T4F7RTxMcq0EZRWBTq4p7zWOdsy0TMT
    G6aZgmPTf6JqSScDXJwATtNS0b1xHdBlZYKQiGsJTnuGexjJ8cfZZrhLx4Cgqzfu
    ASw8c6iMIFLFK+AO1pZrHOaaeULeOewJSxf8f+QJIPhGsewBqZSaPjjvYBEZyzTx
    vVdpas2VBX2tS1+sg5txTNApYl3pyTslrO/hp1Fi94fbONfeCx2MyEzHaq0K5AEU
    +HKY+hw7xmtab1ZaBKnlGcnaadt8I5PHwthwJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517851406; bh=cuDKk/YMuRiC/hA8lk14F6QA8dQ/mR1S7eSBz4
    rZZLU=; b=NNWWSv8locf7ugsgwycS5DTB02PkXUv4SDNI3BHWp3IF4/J05VWxrh
    2QW7U2AKCR4xud75r6ghZ5CB5gfNLY7TLXNaeIpE74U0/xh0PRap4z2IZlGiZwC8
    x5bll6yyuqHjj2q/TvwLAkFu6tmiQTYJbJD4TKiqGL9QGnwJ61nGmwxYhXfzm5gH
    a1iB6934Nx3uTU8T0+zeFROhY29ivcukNV+juVypez2BsUBmWE2S2ZP4fSTM/tTY
    aMcn1WA2mtq8tyc8FPKL2BWcYjHvU2cMnD0qnZjZyfKubinOVoBCONi5T4pUXSwp
    oSdoyP8lsAD6CSzsO7Ic/ONLkoqJdZTw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WSUQH7TP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Z6ho+O9W;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WSUQH7TP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Z6ho+O9W;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeBERXX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 12:23:23 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:36431 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeBERXX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Feb 2018 12:23:23 -0500
X-Google-Smtp-Source: AH8x227fsvkpxZga443b1AGtmOrtWleoQT7N+aRiHoYZe5EdnnNtiPdB6SxyZ9WdlcvuPyNfL3WD1MMd0jI9/WzwdCo=
MIME-Version: 1.0
In-Reply-To: <20180205163353.llyamby4o7ajsvt7@gmail.com>
References: <20180123155733.3404-1-mathieu.desnoyers@efficios.com>
 <CA+55aFxdqXJidPLFb--pa8cmJnepzGpLRD=gNXgktkjNW+jJug@mail.gmail.com> <20180205163353.llyamby4o7ajsvt7@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 09:23:21 -0800
X-Google-Sender-Auth: syeWYkYzLCTBbqFbgAm0f-7311Y
Message-ID: <CA+55aFw9r1bLhPZ8bOApD7dBPTtFLBk+A71qLNF+XrEOL8+1oA@mail.gmail.com>
Subject: Re: [PATCH for 4.16 00/11] membarrier updates for 4.16
To: Ingo Molnar <mingo@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Maged Michael <maged.michael@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Watson <davejwatson@fb.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Hackmann <ghackmann@google.com>,
        Will Deacon <will.deacon@arm.com>,
        David Sehr <sehr@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 8:33 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> Yeah, I wanted to apply these bits later today with some minor edits - unless you
> are going to pull it directly.

I have not pulled yet, I wanted to check. But I do want to get it merged.

It gets easier for me if I can just pull.

Mathieu, do you have a git tree? I don't think I've pulled from you,
so in that sense it's more convenient for me if it goes through Ingo.

But if you have a git tree already set up, just holler.

             Linus
