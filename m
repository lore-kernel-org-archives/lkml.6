Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2828099-1519259134-2-2416879524419586572
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
    t=1519259133; b=ehVRRXHLVt32GuH3jouw/EBONaIfVqjpXvoINpdB+GTA71u
    e9Omer719j0Ahd1n6ST0POW8AxPuQuaQ5CKKaFAqet82J+eVBEZCQTWl0cJOvFzL
    xDPBHYXO1ykHhT/N+04dCVM3sfX3HOViSvIP+GaoqYrv6kqZld2mhcs22c7AU9AW
    e4fok6DrPYKFXDNmzZuqMlleITtsMEieI5WFAtxf8pNUSoEp98BNUdfCx/Tgyzkb
    uMUHr8zD/GfVn4GLK5UKFWFUDUgDQZpzZ3OkKzExXcp3ys20uhJNdqHM4La4FD4h
    UVAPlTsiTXua9vehZkky3LHk+RVoO6D94zNyvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519259133; bh=qrOmNZ6g9j2ddo43Zo525sEL9zAXAWdsOkCiP+lDUC8=; b=M
    aTCLCmPX0g339SvQjbAEu8zC/VBoKXWSA/pQ0BnBP42StnfVhu8UrqyernzRjZtA
    5X8ankhYFI15071JwJjIkWYx4iLt18AFVuHHwaf4bSQ01fkVV4YiYPD3WY5up/2n
    3ooD/vzACAPiG5xyLyTtMhsgxlh6fr25+DiAbr0QePblzhfSdDyYJxsAovmoZcvL
    4Wu8+Wx183SgQ/krw0qfVQxHZz5kndGnqfMPIHqLQh2DVcRexRAc0vt7ZhS/9Zj2
    Fu9YILcWJwilyGE2SjrMmYoaAFDkiW3rS6TdUeJolvjEUCxLwwQj3yk03EqojWUT
    sPoSyE8p2QoRO/A754Euw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=JRLlZ2tR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qKr15zSf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=JRLlZ2tR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qKr15zSf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeBVAZS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 19:25:18 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:41554 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeBVAZR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 19:25:17 -0500
X-Google-Smtp-Source: AG47ELtJILhkdRnRAcJtPQJ/78oXWbU+6IYO/4oLe7ZD0aComymwVGqbrbM3NKUzk+DKJMhhE3zfjAxeJa5uAjC9zyQ=
MIME-Version: 1.0
In-Reply-To: <1519249297-73718-4-git-send-email-pbonzini@redhat.com>
References: <1519249297-73718-1-git-send-email-pbonzini@redhat.com> <1519249297-73718-4-git-send-email-pbonzini@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 21 Feb 2018 16:25:15 -0800
Message-ID: <CALMp9eSGYFA6vRDGDOrOEp4uwwWpm-FVAzfD=9ypj3vC6Bss8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: VMX: mark RDMSR path as unlikely
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
> vmx_vcpu_run and svm_vcpu_run are large functions, and this can actually
> make a substantial cycle difference by keeping the fast path contiguous
> in memory.  Without it, the retpoline guest/retpoline host case is about
> 50 cycles slower.
>
> Cc: x86@kernel.org
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Jim Mattson <jmattson@google.com>
