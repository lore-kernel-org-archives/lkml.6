Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-209660-1517512357-2-2299962974256883689
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='utf-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517512357; b=juAqeJ7UuFszN19Oxo/jMUnLBRNSdoNyqGBWYHNpbgaJ8X5
    JE1ADPJus2eCgCRs2pgJTt2vUtzh8mTH0hFuuQg1z+0SlBgtSwLEpmwWtFi8mobW
    UUrSSV1N19OmcUfFyL7Ld3bgX/6RhXSzT5eFb3Qa6MDJw+BTZPSfjQlV/srCFukG
    qyJ831CVXGBxSICFH4YpZnh5yXJeotslzmuRL7kOOS3DTcz1pl5jKYHHxeHxf1bs
    emRHrtH2FKJU8bEPQAbUQO5ZyN+rRkaKMb+nSa1uUADPgqr5R9qdj73LZZCdL9cx
    L7v8RmBumEcUZmFksXI7zrKhrZBAmfkm0mdsXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517512357; bh=rXid/O/
    MI8KMqR12r4KnxoiLqQ8EnEg512Q8MHLg5SQ=; b=VZfHtMOsamMIX18y/UdwCLg
    yVB+xsUIwL0ib25X11FH+ByB7ZB6fTeMZ4+YBe9hBvnxNcxVr1e9jRzQ5VP17bIL
    1HI7afavn91or3Ymb2JNDw75z2Pdgsu19lPun/ba4ibdfTsdIOehWQ7Taresqnky
    0KlZqCpGkm4Ki2YimAeVeSxwHJsIpCn2LnOPS3vYLSKwmyu6A03eANVbNKP3yRYJ
    qc6x00TfJ+eGFIOsre6xlqW13HKak/EkrL27VKpFrKI0+MQ0/JTlJRaFv5pLOE7l
    ERElpEa2PoG6ezWqI3LtHmszNa4CczrjMhWFM9ghAptn8qJoA2/z10pGuIugbXw=
    =
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
        id S1753126AbeBATK4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 14:10:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752973AbeBATK4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Feb 2018 14:10:56 -0500
Date: Thu, 1 Feb 2018 20:10:41 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Wanpeng Li <wanpeng.li@hotmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: fix backward migration with async_PF
Message-ID: <20180201191040.GD26932@flask>
References: <20180201175022.25011-1-rkrcmar@redhat.com>
 <a4fa9a87-cc4e-73d6-e248-192ab167b2c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4fa9a87-cc4e-73d6-e248-192ab167b2c2@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-01 13:09-0500, Paolo Bonzini:
> On 01/02/2018 12:50, Radim Krčmář wrote:
> > Guests on new hypersiors might set KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
> > bit when enabling async_PF, but this bit is reserved on old hypervisors,
> > which results in a failure upon migration.
> > 
> > Guests at least expect that KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT might not
> > be present when booting, so we allow userspace to handle migration
> > compatibility by adding a KVM CPUID flag that determines the presence of
> > KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT.
> > 
> > Fixes: 52a5c155cf79 ("KVM: async_pf: Let guest support delivery of async_pf from guest mode")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> 
> This has to be documented in Documentation/virtual/kvm/cpuid.txt.

Will add, also to the MSR if we agree on v2.

> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 4c3103f449a3..c16740a06f0c 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -2139,8 +2139,10 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
> >  {
> >  	gpa_t gpa = data & ~0x3f;
> >  
> > -	/* Bits 3:5 are reserved, Should be zero */
> > -	if (data & 0x38)
> > +	/* Bits 3:5 are reserved, Should be zero. */
> > +	if (data & 0x38 ||
> > +	    (data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT &&
> > +	     !guest_kvm_cpuid_has(vcpu, KVM_FEATURE_ASYNC_PF_VMEXIT)))
> >  		return 1;
> >  
> >  	vcpu->arch.apf.msr_val = data;
> > 
> 
> This check will break migration if the source guest and host both have
> the recent kernels which support KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT, so
> I am not sure about it.  Otherwise, the patch is okay!

Good point, breaking forward migration is worse than doing nothing.

A compromise solution would be to drop the feature check from the
hypervisor.  Newer guests would work everywhere and there would be no
change to old systems, so v4.13-v4.15 guests could at least upgrade.

Slightly better than doing nothing, IMO,

thanks.
