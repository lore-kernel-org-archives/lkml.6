Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4106523-1520975806-5-2270167761267438638
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520975805; b=jW1K2Daicbo8cQnyYiKfxBZ0mxJlzogdpSVNbMtiOEgN+35
    nM4TiNMCIkof6maBudhCjSCHbq+iPw+yVKjB80uel5oLEF/PQWLzDxT8O+ku6Qer
    i+HhMFFoi2JrJM0WUS6ORdrpItUcwQJktudbeQ0Rb5VKkEeP4vO6giY/V7hjV5qI
    chW4EHDyqAXRJ81liKVLU1JLPzGMJYyWKOYLjHssqBhSityalGiUURhmHZ7wmQHZ
    Ell6af6anNfLaJKXDH/5AuuABb3z/wRo7dGk1HCsJSfIUAWlcbviBsKAV1qt0I2x
    G1V905g1Lw5lFICttzT/LMj1TZcTAxKENIUrOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520975805; bh=IkXRgfl6RyM1+7Wa6pVbGyGPNy69cwHjhgh/wc
    N+f6k=; b=tmPHxCIkEnSxYbZmRLchDuq/+158y6QSBweNvq7leCyyNKi0EH4Kn9
    2Dx99XQFh655zhjrCR2je1zSoWAbKsWWrBapIhG6PeR6VKHl5bWDozkBfSX/nBwz
    axa/FJlKomNBJkVieNX4HKNMwDFUECdoU9xUlo1ui+CV7PcVQCaGHP7eoh0cdJnO
    aYx/U6RtQxJxMQbzKwxnpn/9q2FadN/bfMKwv0WMxcUjiAKmuzpAX0C/jrkxJ4xT
    8yuqCXwD7JAjcokoRU2nUuEMiW3P153OwbrAlafh1pp5aL+5Gvv0E5zkGWUVWd5J
    sQKkD0sqmCJJY6dOk1O0O6T0TZC9nYgQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=UIiJwDYS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=boYmc8dc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=UIiJwDYS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=boYmc8dc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeCMVQY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 17:16:24 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38395 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752397AbeCMVQX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 17:16:23 -0400
X-Google-Smtp-Source: AG47ELupJ5PLs8HTHMyQY7+lWSoxlmYMjYhzQ4aJQY1SKrRKR4r6ahe1x6+6g7nXNCloWRawd6lV7iMiMwnxX1I5fUM=
MIME-Version: 1.0
In-Reply-To: <14A5C8D0-3F9D-486F-A20C-55849D70FC80@amazon.com>
References: <14A5C8D0-3F9D-486F-A20C-55849D70FC80@amazon.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Mar 2018 14:16:01 -0700
Message-ID: <CAG48ez1RBhBbH8jHwseeZMQwdKciLdjYhoy3O9yDs8WEpMk2TQ@mail.gmail.com>
Subject: Re: [PATCH] x86: always use SYSCALL_DEFINE*
To: "Tautschnig, Michael" <tautschn@amazon.co.uk>
Cc: "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jaswinder Singh <jaswinder@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 12:55 PM, Tautschnig, Michael
<tautschn@amazon.co.uk> wrote:
> All syscall arguments are passed in as types of the same byte size as
> unsigned long (width of full registers). Using a smaller type without a
> cast may result in losing bits of information. SYSCALL_DEFINE* introduce
> adequate type casts. All definitions of syscalls in x86 except for those
> patched here have already been using the appropriate SYSCALL_DEFINE*.
[...]
> diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
> index 2f72330..d98b2a3 100644
> --- a/arch/x86/kernel/ioport.c
> +++ b/arch/x86/kernel/ioport.c
> @@ -23,7 +23,8 @@
>  /*
>   * this changes the io permissions bitmap in the current task.
>   */
> -asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
> +SYSCALL_DEFINE3(sys_ioperm, unsigned long, from, unsigned long, num, int,
> +               turn_on)

Shouldn't this be "SYSCALL_DEFINE3(ioperm, [...]", without the "sys_"?
