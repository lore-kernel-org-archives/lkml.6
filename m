Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2496537-1522791186-2-14330320660891810848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522791186; b=Ml4nXiGgwdrLeb6qgmLylC40JUY56Vso/e4JYEhLZh4Gc3MeRs
    aSdLSD9kikkYo0khwFp6cYmvqVWy2aj0qJZuX7Gxm/jAWPJeIfgRsq2bPq2aClq2
    VfbIRb4lilBrbhK2zh34x0oSpd9W1YH0BFCfGOG8kAQ4QOcsIlN6M1NNmNVjPBC+
    lJvS0Vx8xE1B/OVBthZ3D9oJDc9zJhx+zmq0Hujo6KsaBNC3W6QtKkzFFgn5AzNM
    JFSpDuxR+LuMZIUxaonbfH1IqgMR+GtvPrvN3lDaH0jgwN+K4B4ukVdZHS7FEXJw
    682BzlWtHu00lxYLG1MR8TReHTJHg2RsTodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522791186; bh=rR6U9UqE+M4Qr+qhdUYHd69C+kv8EBsJOtaPL0LKks
    c=; b=R9adSsBS9BhLqz+4bJKMOI1QjCKTxT1VRfsKiYobwj9vLipLprxxw0MEoX
    Es90ZS/IJFCwvC/W/6I4XKDUcqxtzH4brPA5i+00+WCyA7KpuyCNfbdJDB+rWJTO
    4fF1sqsYH6tLgC/MU4+purkOthhQ9xeEHXuJCkKQnED6bbLkiOZdGUrDfz09k404
    vOoVyrRQJY7t+BsYDlvE8TyBYpRi0/l4IP462Otyf8QwXv/sUVeZL2mY6uxCuxb3
    SSS7BuN2SqJrifUQBbSz4TfKW0mfCeNSwAbNgxgnY3U1MHuEzHqsiDmqTAxBDz5s
    LQOgK4fayd+MzzwKWB+rMv0NjYPg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ZfdqT1WV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jt8U1VG3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ZfdqT1WV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jt8U1VG3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPe492mBTtKh08mkxoPcto3EmMsrvkiOklmwHHqS+YL5H/0/GxoyKW7i4reCq8CpFiOVgKH53vdJVuZBpfo7fC8Dq1NzG5BLht1lq/KicRkZxG7KBlsU
    DSksllHQ99qK+79blvybu1J4LhOSAtVt3TxtR2SVqvT71EZ8m/Y8Cxe++KhRwh9mOXqrH9gDSDkbFjuDt1UucDCSloG4pwuI+UBOe6cua7uNwHI3UYxAR88w
    j/pGBW8lImta0XSnaJh1QQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=wYL7rU8hx2ekRalWP2IA:9
    a=BtPKm84hh6sIuX2K:21 a=YMrxUZVVNyV6d7Eo:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbeDCVdE (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 17:33:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40393 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbeDCVdC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 17:33:02 -0400
X-Google-Smtp-Source: AIpwx4+t44BW1DKM2bkDby7Dc+6Rj111SlPEtGFnqBquu4E3Hhe421cwNqpVkOWqchKk1uJNM3ssaEIB+FflXbrf8kQ=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CA+55aFy5EPxAyqyGGaYUUyakuLbjXHiseWCkz-oNdo=Y-878tg@mail.gmail.com>
 <CACdnJuuXOP5T-BRAwMvc7XF8S49wyvp4ZYgcU=EZkaGNgPAQig@mail.gmail.com>
 <CA+55aFzGFZT68ih446DeQbB69Fyk_wT6b7PGq0iz-gctUGQq_A@mail.gmail.com>
 <CACdnJuvheCbuvTLyDWMQWcUytc4EvuSUaEKywfEX8Kp6qYL9dg@mail.gmail.com> <CA+55aFy4ZVaar3sf7bSVYtU5sRkv18x9W8HMEwF9O9beQK4wbw@mail.gmail.com>
In-Reply-To: <CA+55aFy4ZVaar3sf7bSVYtU5sRkv18x9W8HMEwF9O9beQK4wbw@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 21:32:50 +0000
Message-ID: <CACdnJutFiGDymC1dAdCSQB2aHYKqdRfXBsyvLN6quwg6CzcWmA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: luto@kernel.org, David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 2:26 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> On Tue, Apr 3, 2018 at 2:08 PM, Matthew Garrett <mjg59@google.com> wrote:
> >
> > Secure Boot ensures that the firmware will only load signed
bootloaders. If
> > a signed bootloader loads a kernel that's effectively an unsigned
> > bootloader, there's no point in using Secure Boot

> Bullshit.

> I may want to know that I'm running *my* kernel, but once that is the
> case, I trust it.

If you don't believe that your self-signed kernel is going to be a threat
against your security model then great! Don't turn this on when you build
it. But if you built a kernel that didn't have this lockdown functionality
and got it signed with, say, Red Hat's signing keys, anyone could take Red
Hat's bootloader chain and that kernel and subvert the Secure Boot chain on
any machine that trusts the third party signing key (ie, basically all of
them)

> Yes, on x86 hardware at least at some point MS actually had the rule
> that it has to be something you can turn off. That rule is apparently
> not true on ARM, though.

Correct - there's no requirement that it be something you can disable on
ARM, but since Microsoft won't sign any third-party code for ARM anyway it
makes no difference to this discussion.

> If you want lockdown, fine, enable it. But what the F*CK does that
> have to do with whether you had secure boot or not?

Because a kernel signed with a generally trusted key that doesn't implement
any lockdown functionality is effectively a bootloader that will load
unsigned material on most machines on the market, which reduces the
security of users running those machines with Secure Boot enabled.
