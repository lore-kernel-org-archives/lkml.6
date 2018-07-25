Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3066C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9528220852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NeXr4D29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9528220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeGYDgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:36:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41304 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbeGYDgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:36:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so4187120pgu.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 19:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9sRMs/xmZxtAtQw8ridkS3kEyku51daT/ouW+1iEgx8=;
        b=NeXr4D29iL5ovXmMQcJenuxAu6qdhgepynzEugSdwXu+MEwBT2eXYvWtU832w7HtdU
         wlpF1xxbZ81+VXEk4ZKbA6uzo0Nx3BrdGBPPjcn22MRiUz13pGQNfzhFTL/SXv+UOgKL
         1o7AUTkC3pw5Xf7eaG1woW2IJpAS4xnpPIFXHbcwzEgrdtasISeGmPDF6awj2TBkrN5j
         QHRxvjVKuESvT3r+wUhNwtYyn/nXfqb3yk9cevJC8iIHIhC4h3o/qkn72AAeNX5eeNUL
         1uJ7SyTyRHLs05NY6lT/kuYOy6CqGrwAllzyZRO+bCqS9SSGJpx3QdWE6545bbiBzV79
         Dl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9sRMs/xmZxtAtQw8ridkS3kEyku51daT/ouW+1iEgx8=;
        b=AJVmfCtxkwoz/XIDzvPCTfqO6CnmD3nBM2v3VvE/RC5aSKB//pjWr1vCja16VW+id0
         SDmIMo59i2/lhT4BkOssAEWALLCq7JAOMz642fpWn0/lYpOf1//aI/S0exDVw/JDW3e3
         5bOzfTNtZvCYyX8gT45Jionb3+zaGNzZOkHHD3qGUPq63UzmP9rImUbtSvBW86u4fiDg
         QNRIixuQcbLZjpLz44fEBfsMvLNBsLDmHU2meeog1SV03r2rpXf7dErnG+HG8BLmYYzd
         I5C4HLocFRlZyLvSOCIzlOFmlLlid46dCr7C//bv3h/9tda++vhhWsZhKnrm1MFwCYgu
         2OSQ==
X-Gm-Message-State: AOUpUlE/UBJ68k9MdZ/lVnNrUDuamtAlJA8aMBI0zvo5ai1XhM6GKUSH
        os9rHinSPdhM19cUFfJieWCpMQ==
X-Google-Smtp-Source: AAOMgpezmMKGmJDChv+esaueIY1hUuPhAWM296QYQ4eM71BVsLKFaEu++taBXHZtJDjP5Ge2SBcn8w==
X-Received: by 2002:a62:591a:: with SMTP id n26-v6mr20167713pfb.94.1532485609000;
        Tue, 24 Jul 2018 19:26:49 -0700 (PDT)
Received: from js-desktop.svl.corp.google.com ([2620:15c:2cb:1:cdad:b4d5:21d1:e91e])
        by smtp.gmail.com with ESMTPSA id q28-v6sm23658507pfg.144.2018.07.24.19.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 19:26:47 -0700 (PDT)
Subject: Re: [PATCH] KVM/MMU: Combine flushing remote tlb in mmu_set_spte()
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
References: <1532420205-29930-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1aaaecab-0e18-f504-5465-06db9d852cc5@redhat.com>
From:   Junaid Shahid <junaids@google.com>
Organization: Google
Message-ID: <8b07e487-0d7c-a8c5-5109-461ffea6e0a5@google.com>
Date:   Tue, 24 Jul 2018 19:26:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1aaaecab-0e18-f504-5465-06db9d852cc5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 07:35 AM, Paolo Bonzini wrote:
> On 24/07/2018 10:17, Tianyu Lan wrote:
>> mmu_set_spte() flushes remote tlbs for drop_parent_pte/drop_spte()
>> and set_spte() separately. This may introduce redundant flush. This
>> patch is to combine these flushes and check flush request after
>> calling set_spte().
>>
>> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> Looks good, but I'd like a second opinion.  Guangrong, Junaid, can you
> review this?
> 
> Thanks,
> 
> Paolo
> 
>> ---
>>  arch/x86/kvm/mmu.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
>> index 22a7984..8f21632 100644
>> --- a/arch/x86/kvm/mmu.c
>> +++ b/arch/x86/kvm/mmu.c
>> @@ -2901,6 +2901,7 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep, unsigned pte_access,
>>  	int rmap_count;
>>  	int set_spte_ret;
>>  	int ret = RET_PF_RETRY;
>> +	bool flush = false;
>>  
>>  	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
>>  		 *sptep, write_fault, gfn);
>> @@ -2917,12 +2918,12 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep, unsigned pte_access,
>>  
>>  			child = page_header(pte & PT64_BASE_ADDR_MASK);
>>  			drop_parent_pte(child, sptep);
>> -			kvm_flush_remote_tlbs(vcpu->kvm);
>> +			flush = true;
>>  		} else if (pfn != spte_to_pfn(*sptep)) {
>>  			pgprintk("hfn old %llx new %llx\n",
>>  				 spte_to_pfn(*sptep), pfn);
>>  			drop_spte(vcpu->kvm, sptep);
>> -			kvm_flush_remote_tlbs(vcpu->kvm);
>> +			flush = true;
>>  		} else
>>  			was_rmapped = 1;
>>  	}
>> @@ -2934,7 +2935,7 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep, unsigned pte_access,
>>  			ret = RET_PF_EMULATE;
>>  		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
>>  	}
>> -	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
>> +	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH || flush)
>>  		kvm_flush_remote_tlbs(vcpu->kvm);
>>  
>>  	if (unlikely(is_mmio_spte(*sptep)))
>>
> 

Reviewed-by: Junaid Shahid <junaids@google.com>
