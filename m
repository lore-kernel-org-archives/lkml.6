Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wy9vLksyGVvwQwAAmS7hNA
	; Thu, 07 Jun 2018 13:25:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A6D8C608BA; Thu,  7 Jun 2018 13:25:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 22758606DD;
	Thu,  7 Jun 2018 13:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22758606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lio96.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753675AbeFGNZn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:25:43 -0400
Received: from port-212-202-251-16.static.qsc.de ([212.202.251.16]:46178 "EHLO
        collaps.dev.collax.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753103AbeFGNZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:25:41 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2018 09:25:40 EDT
Received: from collaps.dev.collax.com (collaps.dev.collax.com [127.0.0.1])
        by localhost (Postfix) with ESMTP id EEF40171BC9;
        Thu,  7 Jun 2018 15:15:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from collaps.dev.collax.com ([127.0.0.1])
        by collaps.dev.collax.com (collaps.dev.collax.com [127.0.0.1]) (amavisd-new, port 10033)
        with ESMTP id v4mqYuUdacQo; Thu,  7 Jun 2018 15:15:51 +0200 (CEST)
Received: from localhost (collaps.dev.collax.com [127.0.0.1])
        by collaps.dev.collax.com (Postfix) with ESMTPS id F0F99171AB6;
        Thu,  7 Jun 2018 15:15:50 +0200 (CEST)
Date: Thu, 7 Jun 2018 15:14:14 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
X-X-Sender: thomas@collaps.dev.collax.com
To: Ben Hutchings <ben@decadent.org.uk>
cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: VMX: Expose SSBD properly to guests.
In-Reply-To: <b92df74ecb0399db0fc1be49361134870d016421.camel@decadent.org.uk>
Message-ID: <alpine.LNX.2.21.1806071510590.7445@collaps.dev.collax.com>
References: <20180521215449.26423-1-konrad.wilk@oracle.com>         <20180521215449.26423-2-konrad.wilk@oracle.com> <b92df74ecb0399db0fc1be49361134870d016421.camel@decadent.org.uk>
User-Agent: Alpine 2.21 (LNX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-458213742-1528377350=:7445"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-458213742-1528377350=:7445
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 23 May 2018, Ben Hutchings wrote:

> On Mon, 2018-05-21 at 17:54 -0400, Konrad Rzeszutek Wilk wrote:
>> The X86_FEATURE_SSBD is an synthetic CPU feature - that is
>> it bit location has no relevance to the real CPUID 0x7.EBX[31]
>> bit position. For that we need the new CPU feature name.
>>
>> Fixes: 52817587e706 ("x86/cpufeatures: Disentangle SSBD enumeration")
>>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> ---
>>  arch/x86/kvm/cpuid.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index ced851169730..598461e24be3 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -407,8 +407,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>>
>>  	/* cpuid 7.0.edx*/
>>  	const u32 kvm_cpuid_7_0_edx_x86_features =
>> -		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) | F(SSBD) |
>> -		F(ARCH_CAPABILITIES);
>> +		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
>> +		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
>>
>>  	/* all calls to cpuid_count() should be made on the same cpu */
>>  	get_cpu();
>
> For 4.9-stable, guest_cpuid_has_spec_ctrl() needs a similar fix.
>
> Ben.

Do you mean something like this?

--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -179,7 +179,7 @@ static inline bool guest_cpuid_has_spec_ctrl(struct 
kvm_vcpu *vcpu)
         if (best && (best->ebx & bit(X86_FEATURE_AMD_IBRS)))
                 return true;
         best = kvm_find_cpuid_entry(vcpu, 7, 0);
-       return best && (best->edx & (bit(X86_FEATURE_SPEC_CTRL) | 
bit(X86_FEATURE_SSBD)));
+       return best && (best->edx & (bit(X86_FEATURE_SPEC_CTRL) | 
bit(X86_FEATURE_SPEC_CTRL_SSBD)));
  }

  static inline bool guest_cpuid_has_arch_capabilities(struct kvm_vcpu 
*vcpu)

--8323328-458213742-1528377350=:7445--
