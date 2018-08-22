Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7EC208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7EC208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeHVLtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:49:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727797AbeHVLtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:49:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB1FE87916;
        Wed, 22 Aug 2018 08:25:13 +0000 (UTC)
Received: from [10.36.116.232] (ovpn-116-232.ams2.redhat.com [10.36.116.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 189B32166BA1;
        Wed, 22 Aug 2018 08:25:11 +0000 (UTC)
Subject: Re: [PATCH] KVM: s390: vsie: Consolidate CRYCB validation
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <1534925337-18380-1-git-send-email-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <c410ab24-1f83-21f3-1996-7328aeb3f408@redhat.com>
Date:   Wed, 22 Aug 2018 10:25:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534925337-18380-1-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 22 Aug 2018 08:25:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 22 Aug 2018 08:25:13 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2018 10:08, Pierre Morel wrote:
> Currently when shadowing the CRYCB on SIE entrance, the validation
> tests the following:
> - accept only FORMAT1 or FORMAT2
> - test if MSAext facility (76) is installed
> - accept the CRYCB if no keys are used
> - verifies that the CRYCB format1 is inside a page
> - verifies that the CRYCB origin is not 0
> 
> This is not following the architecture.

I have to trust you on that :)

> 
> On SIE entrance, the CRYCB must be validated before accepting
> any of its entries.
> 
> Let's do the validation in the right order and also verify
> correctly the FORMAT2 CRYCB.

With which facility was FORMAT2 introduced?

Does MSA3 imply that FORMAT2 can be used? (even if AP is absent)

FORMAT2 is backwards compatible to FORMAT1,

> 
> The testing of facility MSAext3 (76) is not useful as it is
> already tested by kvm_crypto_init() to set FORMAT1.

Indeed, having FORMAT1 in g1 implies that.

> 
> The testing of a null CRYCB origin must be done what ever
> the format of the guest3 CRYCB is.
> 
> The CRYCB must be contained inside a page, but the CRYCB size
> depends on the CRYCB format.
> Lets test what the guest2 initialized, we can not trust it to have
> done things right.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index a2b28cd..35c3907 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -158,28 +158,43 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	scb_s->crycbd = 0;
>  	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>  		return 0;
> -	/* format-1 is supported with message-security-assist extension 3 */
> -	if (!test_kvm_facility(vcpu->kvm, 76))
> -		return 0;
> +	/*
> +	 * If APIE is set or it the CRYCB Format is FORMAT1 or FORMAT2 with
> +	 * APXA installed, the machine checks the validity of crycb origin.
> +	 * KVM kvm_s390_crypto_init() makes sure that FORMAT2 is only used
> +	 * if APXA is installed.
> +	 * The guest2 hypervizor could have set APIE and Format2 so let's
> +	 * test all these points.
> +	 * We here have always a CRYCB FORMAT1 or FORMAT2 (FORMAT0 was
> +	 * refused in previous test).

Can you shorten that comment and leave out all stuff to be added next?
(APIE, APXA ...). I guess this whole comment is to be left out of this
patch.

> +	 */
> +	if (!crycb_addr)
> +		return set_validity_icpt(scb_s, 0x0039U);
> +
> +	if ((crycbd_o & 0x03) == CRYCB_FORMAT1)

Can you instead of 0x03 define CRYCB_FORMAT_MASK

> +		if ((crycb_addr & PAGE_MASK) !=
> +		   ((crycb_addr + 128) & PAGE_MASK))

please add one space in front of the second line to properly indent

> +			return set_validity_icpt(scb_s, 0x003CU);
> +
> +	if ((crycbd_o & 0x03) == CRYCB_FORMAT2)
> +		if ((crycb_addr & PAGE_MASK) !=
> +		   ((crycb_addr + 256) & PAGE_MASK))

dito

> +			return set_validity_icpt(scb_s, 0x003CU);
> +
>  	/* we may only allow it if enabled for guest 2 */
>  	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>  		     (ECB3_AES | ECB3_DEA);
>  	if (!ecb3_flags)
>  		return 0;
>  
> -	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
> -		return set_validity_icpt(scb_s, 0x003CU);
> -	else if (!crycb_addr)
> -		return set_validity_icpt(scb_s, 0x0039U);
> -
>  	/* copy only the wrapping keys */
>  	if (read_guest_real(vcpu, crycb_addr + 72,
>  			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>  		return set_validity_icpt(scb_s, 0x0035U);
>  
>  	scb_s->ecb3 |= ecb3_flags;
> -	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
> -			CRYCB_FORMAT2;
> +	/* Set the shadow CRYCB format to format 2 */
I don't consider this comment helpful (CRYCB_FORMAT2 below is at least
obvious to me) - CRYCB_FORMAT2 implies CRYCB_FORMAT1 (what the existing
code did not consider)

> +	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
>  
>  	/* xor both blocks in one run */
>  	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
> 

Thanks for looking into this.

-- 

Thanks,

David / dhildenb
