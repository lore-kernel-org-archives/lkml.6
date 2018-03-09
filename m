Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3342454-1520559872-2-12441576957671619154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520559871; b=rLdx3BHqUJOoGUHYSbCSP3qofbExDFQeDdcMqepabnRtmkP
    3bEkMcHSheMt6Wjh4AlfFPnSKdUFO8Z+DFJ82buGkZ2QKS8b2AyBov8eayuIwdgY
    rmSVXDV/67yL3hJz2NWh5tsfmukjXTxBLDTwkaFIt805MNcqq4zFZSpuM+AqecLT
    StVl6ei3lnLe60uCQGTZPcuXNCyRzdXaRxtD+54R7E9ErVG27MnrILXyZ5W29JVW
    CTBq0l8dsFFI42se95aprgwl/PRJ83jcE9yzgOgr/QKZPkppuAjbF0Z8GiiI9qv7
    0dcxtP0HdUvs5bF+P/XD5i1OHPP25CaoGtAvfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520559871; bh=Je51jQGGZlbNMY+7ktRfIYTtH6iI0EP+QiOOn2
    ai+aI=; b=JXs6imSfhupvuVeMseDwrGw3bFHRKqhhMLJJ9fel54WQitzgYxPpa0
    Rwdj2OGppNssTFzOl4UlnCnYv95GcoZlhtMxYKiCi55uyC2G+xngTNg7SV9H9Ivs
    PNOUcatRJ2vg0gnYKXZQK99Vgx5pCfoI2+d9EzXw5eNSOIbdk5OhNEL+GQpc4qGL
    MUIDXTV02oVu9N36O8O/IuhWji5bOsUKaIQ7sb1y5GwzzLEzqflTeUGmCF6GBZkO
    Sh312h0dvhs7kNNgBKgL+vnhz8vBOx+2FnlFUCrmuGasUo5Pqou9OfD3ZTVsn+rL
    O+PTrVWtJchcikKQUf/5AKsn4Rxfl22g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=n6p9Cbr6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Cf6vQJro x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Vn9dLK7g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=n6p9Cbr6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Cf6vQJro x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Vn9dLK7g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeCIBoP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 20:44:15 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41745 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbeCIBoN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 20:44:13 -0500
X-Google-Smtp-Source: AG47ELv1TiMcq2qZAW6nQ5RDWn2XznZ3M+sqnFaB3tQ023gzEEFWG+G4E/nxTYkMyzDBti4GiPoKZj7KVh4a73ONjec=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com> <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 17:44:11 -0800
X-Google-Sender-Auth: 1zOOJGdak4Hlt3i-vBPTre3KJag
Message-ID: <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Linus Torvalds <torvalds@linux-foundation.org>
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

On Thu, Mar 8, 2018 at 5:38 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Mar 8, 2018 at 4:59 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>
>> Also, I don't see how this is any more exploitable than any other
>> init_module().
>
> Absolutely. If Kees doesn't trust the files to be loaded, an
> executable - even if it's running with root privileges and in the
> initns - is still fundamentally weaker than a kernel module.
>
> So I don't understand the security argument AT ALL. It's nonsensical.
> The executable loading does all the same security checks that the
> module loading does, including the signing check.
>
> And the whole point is that we can now do things with building and
> loading a ebpf rule instead of having a full module.

My concerns are mostly about crossing namespaces. If a container
triggers an autoload, the result runs in the init_ns. So, really,
there's nothing new from my perspective, except that it's in userspace
instead of in the kernel.

Perhaps it's an orthogonal concern.

-Kees

-- 
Kees Cook
Pixel Security
