Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C708C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44EE21C3C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44EE21C3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeHIJoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:44:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbeHIJoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:44:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F738402312B;
        Thu,  9 Aug 2018 07:20:30 +0000 (UTC)
Received: from [10.36.117.92] (ovpn-117-92.ams2.redhat.com [10.36.117.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE71B10B7CB5;
        Thu,  9 Aug 2018 07:20:28 +0000 (UTC)
Subject: Re: [PATCH RFC 1/2] KVM: s390: vsie: simulate VCPU SIE entry/exit
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
References: <20180807125131.3606-1-david@redhat.com>
 <20180807125131.3606-2-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <c0de34b7-9ffa-0d59-debf-b82ddb8a3a5c@redhat.com>
Date:   Thu, 9 Aug 2018 09:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807125131.3606-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 07:20:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 07:20:30 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.2018 14:51, David Hildenbrand wrote:
> VCPU requests and VCPU blocking right now don't take care of the vSIE
> (as it was not necessary until now). But we want to have VCPU requests
> that will also be handled before running the vSIE again.
> 
> So let's simulate a SIE entry when entering the vSIE loop and check
> for PROG_ flags. The existing infrastructure (e.g. exit_sie()) will then
> detect that the SIE (in form of the vSIE execution loop) is running and
> properly kick the vSIE CPU, resulting in it leaving the vSIE loop and
> therefore the vSIE interception handler, allowing it to handle VCPU
> requests.
> 
> E.g. if we want to modify the crycb of the VCPU and make sure that any
> masks also get applied to the VSIE crycb shadow (which uses masks from the
> VCPU crycb), we will need a way to hinder the vSIE from running and make
> sure to process the updated crycb before reentering the vSIE again.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/kvm-s390.c |  9 ++++++++-
>  arch/s390/kvm/kvm-s390.h |  1 +
>  arch/s390/kvm/vsie.c     | 20 ++++++++++++++++++--
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 91ad4a9425c0..c87734a31fdb 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2766,18 +2766,25 @@ static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
>  	exit_sie(vcpu);
>  }
>  
> +bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu)
> +{
> +	return atomic_read(&vcpu->arch.sie_block->prog20) &
> +	       (PROG_BLOCK_SIE | PROG_REQUEST);
> +}
> +
>  static void kvm_s390_vcpu_request_handled(struct kvm_vcpu *vcpu)
>  {
>  	atomic_andnot(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
>  }
>  
>  /*
> - * Kick a guest cpu out of SIE and wait until SIE is not running.
> + * Kick a guest cpu out of (v)SIE and wait until (v)SIE is not running.
>   * If the CPU is not running (e.g. waiting as idle) the function will
>   * return immediately. */
>  void exit_sie(struct kvm_vcpu *vcpu)
>  {
>  	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOP_INT);
> +	kvm_s390_vsie_kick(vcpu);
>  	while (vcpu->arch.sie_block->prog0c & PROG_IN_SIE)
>  		cpu_relax();
>  }
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 981e3ba97461..1f6e36cdce0d 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -290,6 +290,7 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
>  void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
>  void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);
>  void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu);
> +bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu);
>  void exit_sie(struct kvm_vcpu *vcpu);
>  void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu);
>  int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 63844b95c22c..faac06886f77 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -989,6 +989,17 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>  	int rc = 0;
>  
> +	/*
> +	 * Simulate a SIE entry of the VCPU (see sie64a), so VCPU blocking
> +	 * and VCPU requests can hinder the whole vSIE loop from running
> +	 * and lead to an immediate exit. We do it at this point (not
> +	 * earlier), so kvm_s390_vsie_kick() works correctly already.
> +	 */
> +	vcpu->arch.sie_block->prog0c |= PROG_IN_SIE;
> +	barrier();
> +	if (kvm_s390_vcpu_sie_inhibited(vcpu))
> +		return 0;
> +
>  	while (1) {
>  		rc = acquire_gmap_shadow(vcpu, vsie_page);
>  		if (!rc)
> @@ -1004,10 +1015,14 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		if (rc == -EAGAIN)
>  			rc = 0;
>  		if (rc || scb_s->icptcode || signal_pending(current) ||
> -		    kvm_s390_vcpu_has_irq(vcpu, 0))
> +		    kvm_s390_vcpu_has_irq(vcpu, 0) ||
> +		    kvm_s390_vcpu_sie_inhibited(vcpu))
>  			break;
>  	}
>  
> +	barrier();
> +	vcpu->arch.sie_block->prog0c &= ~PROG_IN_SIE;
> +

I am thinking about moving this down to the actual sie64 call. We
eventually take locks and even call into MM code (to resolve faults)
inside do_vsie_run(). I think this extra overhead can be avoided (where
any caller - e.g. on prefix unmaps has to wait).


-- 

Thanks,

David / dhildenb
