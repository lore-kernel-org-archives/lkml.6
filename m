Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1185227-1520621631-2-12000318676705839588
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
    t=1520621630; b=pjrk2GjjJGYwcGUN4/cYUkk+nzXTPvNF63lbvjEj9JChqBX
    /LJ/skVEqbfyyuEcM9sTVrtLAhJnNa3HFs42A6+vk9xr1iv1PonIeE4A7MmJkHFf
    QTHIfznkA0rs5FpIEpdM0eTmVG3ORXb5R5xils+ifCaI9b7SCCZttzlm9BPqJ6cn
    /AlE7ySzwFl2YFfCSDTg8YDrlk3aP5Nh4zgGISkQCTwe3wuoej5PXoQs1ruF19Nq
    NijrzgWYrXV8GMe77K2FCi3YpB+z+V21S/zTtX/hZj+lqPLsO8AAPvYs7JH2veKc
    tFBeMKqGjTAAZ8pJCrXxcK0+OXvLc7knvgMl4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520621630; bh=/dBoxfi3VtcDD52jpGfA6jpd7nQrnU4/uCL0+j/mkPU=; b=q
    vNgpshpYKEw+YgGKHE+0bINtSsKunirn9btRKRyFnWnuXnACa4+xhjQGaay89dWc
    K/Isc2vhwNOpZX1KyTxhf4SJ6Y/LpFS6WCVY3/7GBTPXnCqxjObMN6Lx75yz1mI+
    r6X3FT5fUgUilU1xvN7mWjzdWCGqHE567jeqJ0aJBtYCCbqwmm9rzbRx9ZZEH/mA
    XLSfy+FXAhtZ283IVaPB0oewv1PSK+S4ZWeleBE2a9z0dxhqIypE0CTGN3RJzhJ7
    wreTMIzTZSi4kMOS/ZrHZIG0sGaIjOo75neT7gDC/K8ZmbHZe622qq8maovt/8+G
    oWvVPW0004dVg5MbmoHmg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EcK3yELX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nxJs2EeF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dj1cE7Eh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EcK3yELX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nxJs2EeF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dj1cE7Eh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeCISxr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:53:47 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:56179 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeCISxq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:53:46 -0500
X-Google-Smtp-Source: AG47ELus5Pz+f0ZEFAUiWTOPNWeUEbEIOzQUQY/Sy0CRnuhEE7NMIkO438hoEpaLTJMnGZaQT3Y/5DzFp2S4AVvdTrU=
MIME-Version: 1.0
In-Reply-To: <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
 <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
 <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com>
 <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
 <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net> <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
 <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com> <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 10:53:45 -0800
X-Google-Sender-Auth: asthy-fRQ9qU4vrMQddzQ8AWMRs
Message-ID: <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Andy Lutomirski <luto@amacapital.net>
Cc: Alexei Starovoitov <ast@fb.com>, Kees Cook <keescook@chromium.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 10:48 AM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
>> On Mar 9, 2018, at 10:17 AM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>>
>> Hmm. I wish we had an "execute blob" model, but we really don't, and
>> it would be hard/impossible to do without pinning the pages in memory.
>>
>
> Why so hard?  We can already execute a struct file for execveat, and Alex=
ei already has this working for umh.
> Surely we can make an immutable (as in even root can=E2=80=99t write it) =
kernel-internal tmpfs file, execveat it, then unlink it.

And what do you think that does? It pins the memory for the whole
time. As a *copy* of the original file.

Anyway, see my other suggestion that makes this all irrelevant. Just
wait synchronously (until the exit), and just use deny_write_access().

The "synchronous wait" means that you don't have the semantic change
(and really., it's *required* anyway for the whole mutual exclusion
against another thread racing to load the same module), and the
deny_write_access() means that we don't neeed to make another copy.

                Linus
