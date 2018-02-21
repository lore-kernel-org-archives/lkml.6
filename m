Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795532-1519257005-2-18005449657796783523
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519257005; b=mzFg3vbbQJ2OgLog636YnJV0V5PFlpLPmMZ7jR4dxRlaD0N
    drSBKUKUB9YcqG3FhQaTC6iCgwjFfLJJJcI10/6pmScMCTzcsO59zb2c6kMc5YrM
    BOLwoPpyJTCsCkHWULB9vZ4Hx+b8xrKzBMQ1uFAExY5LdcwW0gVEA5eKQyiGyopW
    DbtelhBGXtzC3UN8K5Apa/s++SXRE7V4ffsli7cQfrxxJ9XktWfTUws17VdkrgGt
    vFukbpQli6Vo4YW5/MZJ3LmsS0rKSbPR7+nu60xy52256mv3jLOSEuQunrS1MBCK
    lIZ2BZoKDJeh94FADc/GnDsHWDKqyOtuVnSrG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519257005; bh=rDfk4cIevBtm/7c+pybsQL3bZ8LOVCUGVF7LvoT6Yd4=; b=q
    6nJzUE3lxZuzQOHJKncEQDceGrizxqTLRMvdIIEHMe+ixIV2I8VgW7jOBg0LsIcc
    U5pAYEZhXF1ZOsPTEQPAOTe1MRBGrb1+uj0sOU7SMwL4CqBObkFM+/oYmOzxIM/I
    BhPb16qDzM63nFNaZRSAhObEeZO+YTzxqjPenFW3N0OXTryw/Cz6vMgztaJDi5aP
    L3T6XFRrDafadqnVxhj8r7UzqhFTJEgCXy4uD79sjnsYQJpmK/gETg+KRguttvbl
    YXT6wLOjsMzu81D2xw6vQHjXXckBddf7PeNh2OJD6FZ46YyMpQ8R69J6PfaknbtL
    nkSCugGUozZIXpTDxm37w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=JPqoCQBK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rtRr2ydN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=JPqoCQBK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rtRr2ydN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeBUXuC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 18:50:02 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:34367 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBUXuB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 18:50:01 -0500
X-Google-Smtp-Source: AG47ELtNMTIromWpeS/acJK7mOlgbquInrvEnxEFGqOCNpWZzJHZFHWD/N3oTeU9e1WooO/WlJ0vxnzhGFOVN+t4iAk=
MIME-Version: 1.0
In-Reply-To: <1519249297-73718-2-git-send-email-pbonzini@redhat.com>
References: <1519249297-73718-1-git-send-email-pbonzini@redhat.com> <1519249297-73718-2-git-send-email-pbonzini@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 21 Feb 2018 15:49:59 -0800
Message-ID: <CALMp9eQX6DQ8qUZ2+Ri4V6cxaFx-C-ysz9sq=j6LXzs+prNciQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: x86: use native MSR ops for SPEC_CTRL
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 1:41 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Having a paravirt indirect call in the IBRS restore path is not a
> good idea, since we are trying to protect from speculative execution
> of bogus indirect branch targets.  It is also slower, so use
> native_wrmsrl on the vmentry path too.
>
> Fixes: d28b387fb74da95d69d2615732f50cceb38e9a4d
> Cc: x86@kernel.org
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Seems like there ought to be a native_rdmsrl, but otherwise this looks fine=
.

Reviewed-by: Jim Mattson <jmattson@google.com>
