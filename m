Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-499681-1518798571-2-3835244797108892676
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518798571; b=kcyuBRdJzHxYG0e7fbxwVo9lIKMwn6lfKl9K2EkzyXgjlIn
    Y/D9yZdm4qYHV9ixQzqziN9huVUaQRILEA+wn2UamQkLI3CGJCpbii9m8ijdejoT
    5DmcRWF9hk8+C5sNSh+wCluCo4fqLthZ6S/dvMXG3ILVMtZYdu6r13riddKbaesc
    eRdR3MfkMRUG4qUcTJ3WnzRvgwPbKeVy8ppEFhOUDFA26B8qlQJTFdx1vTHurb4t
    rmpEMQtNp6/vfijOxyl9tzUhG5EhTKiggQLqBgjC//sZsrM5XyAFphfDE70ASm+4
    ZEqNARJ0Ee0A90NRscfYBepiYaDxUDOZzGi98sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518798571; bh=7Z0qDSIEB4edDSjt6Pj1F5SfZUD92yAN0uaVN7
    YmtlE=; b=nePbBKG+66C5JNCJB8q9VIGFvSsMwjygRua44R9Rb3vUPE8hdGRRoE
    h5L40erYEGXD5pE6fJ2esnxBiu64yThE8bmv+S6iO2KHH0KnWimBQXSCuiwFBbVy
    2SXRlHJAleG2UuXPLJMRfC2rMVy9VKTGkEEXYTV6T2dQBu7bp050d+8GH0B9Lczt
    FYNOxx8/LaP5Tz58RCHU0Tp8OmuQMjc0IBxblf+ieMs2dXvbPRD9ycwXZZ5DHjcz
    U8+PF51FPpCs/GdL9VjwNpvQvcN0v4M8ZaqePvrSYxRr6uIMhTmb7Rg/2h2oXxa4
    AczwzaOi5gNL7sY7ojMYqSmvZjsz0n3Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=lf766cQi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GkL0viYj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=lf766cQi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GkL0viYj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755500AbeBPQ3a (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 11:29:30 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:36224 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbeBPQ33 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 11:29:29 -0500
X-Google-Smtp-Source: AH8x224Cl4wpDYurh02rz+MtWf4U1hIoOAdb8kWsHSlDqmsqUXYWVc/iBDCcQlD3cfgS9yK5m18PfzrtV55lkid8OEM=
MIME-Version: 1.0
In-Reply-To: <4be4e462-61be-53a9-b0e1-3508466d1645@redhat.com>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
 <1517938181-15317-8-git-send-email-dwmw@amazon.co.uk> <4be4e462-61be-53a9-b0e1-3508466d1645@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 16 Feb 2018 08:29:27 -0800
Message-ID: <CALMp9eQQ-94g=fNanvwpr6b2pmH87RPGr6s9gOv43dUDABFuhw@mail.gmail.com>
Subject: Re: [PATCH 7/9] KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 6:18 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:

> Uhm, taking contents from the hardware is wrong (guess why---live
> migration).  I'll send a revert of those two lines.

Hardware seems like a reasonable place to get the default value (cf.
the VMX capability MSRs). Should these two lines just be moved to
vmx_create_cpu?
