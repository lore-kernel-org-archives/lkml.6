Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2828099-1519258061-2-12775850753116101281
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
    t=1519258060; b=Z/J2N4LJPS2Vvn+f9nZg6qqm40hewn6rKkoYm75tYfEJmOz
    DPf1jk8SBVfzAQmrngetuhDEOe9igiDVBi3rYxt5I1dHc+Le6IRlB1runK0Wmx2f
    cde2bynFvrgcKiIRJZpva0CgX0ByKeSyOjNUwEEqUGwIXH9ti2WONPkROvRuFW4M
    ILDbaAbVbRhIpv1dxSUqnp2AvQB+EsJCPXmC8DTFX//3OZz/5Q5TPEEUrVyyNHlM
    kGJsMn6F/g9B/TFJnlYBA/XOJISsQw0Zb+9daR1FVHN3Pc4hfruLONr+6nomQ/KP
    zyO9hJ5FiXk+X8wNB2JVe0zBe73iWf35QPldsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519258060; bh=ACKPHDttdk/C/7L1lhLFw0yfiszA0X4oL/I0rps6rmw=; b=C
    dv+dRDWIGyD2Ym+y8v1o4ppRkqOim5rGXS5f6gAm5oCyrq5buW/WBeMjjawujza0
    c76ILhu0NucOJ88XWLhqGQxkXc2I4dLDtkt9B7h/EnKbAnvmabYb3LZspXPWCdWo
    mmiB/oaY1pUxjUbVgYUi48A9cHSBuNhDC1nvQLshmwLGYGfaiB/uioylQTYQ8TDO
    gIMJx1UZuJFRihtBRlWUGY4uccfae/hO9CG5TS9dUJrUktLPVau98JgTyejV6Rkd
    5PuRJdzg5e/8zJnTBYYo0obkUZrj/rtFtwn7B8S9BjgV0XI05bG7oMMJn9ctqnDs
    AonYgaFizjX8fLT+//owA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=mhau9NJM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j+H+I2Yk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=mhau9NJM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j+H+I2Yk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeBVAHh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 19:07:37 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:34795 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeBVAHg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 19:07:36 -0500
X-Google-Smtp-Source: AH8x226o9s6xEOzRYU5EO5YnIp3x/MR269UuPu680vAOrF35snlnCnrUg2LSN8EtLNkDWxgYAtwN3oH76OxqG6MU2Gg=
MIME-Version: 1.0
In-Reply-To: <1519249297-73718-3-git-send-email-pbonzini@redhat.com>
References: <1519249297-73718-1-git-send-email-pbonzini@redhat.com> <1519249297-73718-3-git-send-email-pbonzini@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 21 Feb 2018 16:07:35 -0800
Message-ID: <CALMp9eSbH67rm2vDnuaCjSU0JRsZxT1cW2qoyWQREV_iSAVaTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: nVMX: fix wrong condition for SPEC_CTRL and
 PRED_CMD MSRs
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
> We need to change the default all-1s bitmap if the MSRs are _not_
> intercepted.  However, the code was disabling the intercept when it was
> _enabled_ in the VMCS01.  This is not causing bigger trouble,
> because vmx_vcpu_run checks the VMCS02's MSR bitmap and would do the
> right thing even if fed garbage... but it's obviously a bug and it can
> cause extra MSR reads and writes when running nested guests.
>
> Fixes: d28b387fb74da95d69d2615732f50cceb38e9a4d
> Fixes: 15d45071523d89b3fb7372e2135fbd72f6af9506
> Cc: x86@kernel.org
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Wasn't this already fixed by 206587a9fb76 ("X86/nVMX: Properly set
spec_ctrl and pred_cmd before merging MSRs")?
