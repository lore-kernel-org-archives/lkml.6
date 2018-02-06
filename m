Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763956-1517940088-2-14143825109600305420
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517940087; b=qSKJG3L8wYWgo5my9Q+kcaTXo6XSPhstDNUQlbcEnQ3t1DO
    w1cxHaDXMYbJyxEzKqnaPsUG539wHz3IKcs/1gJ6gz2m5g+h0PLuZXBpbtj1uIz2
    RSiXaQapJnBmUt+PWd9wJvpu+tUfx2Yl8vD8gshdDzL7JM0sn8uiJ7Xhdu24BlgL
    jiW/qIE5rfAi68kLcVpP35V2SHL4GeUqu7+hXwylzbBc8T0Pr49XBIRGB3RZ+pas
    WPiT6d6iEAXLjCk87Ee5ThDAIGjuwgsOYPXc/9g3R450jOzsCYCJtCCLu0DFajhB
    LLNQElmVtRdHEjd4ArZzeTkW0fk8i1mugrgSGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517940087; bh=3OBiDmJL2CnnyItUwgXmgjVhLMtMurgQ8SPp1++xK74=; b=G
    0P9ieKWkC4Fnkj8aqRJ+QbYQeleyAujd+txNpDrCB8GpaIuICPZToh5rAPxd+sBE
    LeitXuLJnzCgQoQ/xQcyIa72WKD9Qeyd1t/led2bi5ZBVwgamK/qUj9FqAlzt3/2
    gOcz3kodaRbLg6zSjN0KwSmBVa3UmU2AUYLCsBWe7P2rk0bXrq1fkMcROvS74RYq
    PHZNMZ41vCKTVAUzl6mq2b2h5ANYElsqLDmz2jdtxhDo8Xe5AObdHSUiLG9IRxG7
    S/xppJ6dLWiLYr9+kAczioCi9pZMFXnLUZrMJWeXDh3IWmxcQShXO5zXFwAMWQjH
    g7MFkaW5mdH14/+hIWZcg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeBFSBZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 13:01:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753044AbeBFSBR (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 13:01:17 -0500
Subject: Re: [STABLE 4.9.y PATCH 0/9] Backport of KVM Speculation Control
 support
To: David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ea4d52a-7ae6-a179-2f86-1e7b77255387@redhat.com>
Date: Tue, 6 Feb 2018 19:01:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/02/2018 18:29, David Woodhouse wrote:
> I've put together a linux-4.9.y branch at 
> http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y
> 
> Most of it is fairly straightforward, apart from the IBPB on context 
> switch for which Tim has already posted a candidate. I wanted some more
> review on my backports of the KVM bits though, including some extra
> historical patches I pulled in.

Looks good!  Thanks for the work,

Paolo

> Ashok Raj (1):
>   KVM/x86: Add IBPB support
> 
> David Hildenbrand (1):
>   KVM: nVMX: vmx_complete_nested_posted_interrupt() can't fail
> 
> David Matlack (1):
>   KVM: nVMX: mark vmcs12 pages dirty on L2 exit
> 
> Jim Mattson (1):
>   KVM: nVMX: Eliminate vmcs02 pool
> 
> KarimAllah Ahmed (3):
>   KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
>   KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
>   KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL
> 
> Paolo Bonzini (2):
>   KVM: VMX: introduce alloc_loaded_vmcs
>   KVM: VMX: make MSR bitmaps per-VCPU
> 
>  arch/x86/kvm/cpuid.c |  21 +-
>  arch/x86/kvm/cpuid.h |  31 +++
>  arch/x86/kvm/svm.c   | 116 ++++++++
>  arch/x86/kvm/vmx.c   | 730 +++++++++++++++++++++++++++------------------------
>  arch/x86/kvm/x86.c   |   1 +
>  5 files changed, 554 insertions(+), 345 deletions(-)
> 
