Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9815C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7956C21722
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7956C21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeHULtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:49:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbeHULtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:49:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D8938197001;
        Tue, 21 Aug 2018 08:30:40 +0000 (UTC)
Received: from [10.36.117.96] (ovpn-117-96.ams2.redhat.com [10.36.117.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64B3E104083B;
        Tue, 21 Aug 2018 08:30:34 +0000 (UTC)
Subject: Re: [PATCH v9 20/22] KVM: s390: Handling of Cypto control block in
 VSIE
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Pierre Morel <pmorel@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-21-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <f90d6937-f110-4e57-11d2-e2d3f271d889@redhat.com>
Date:   Tue, 21 Aug 2018 10:30:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534196899-16987-21-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 21 Aug 2018 08:30:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 21 Aug 2018 08:30:40 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.2018 23:48, Tony Krowiak wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> Shadowing the crypto control block now supports APCB shadowing.
> 
> AP instruction interpretation for guest 3 through ECA.28 is shadowed when
> guest 2 ECA.28 is set.
> 
> CRYCB is shadowed for APCB and wrapping keys.
> 
> CRYCB format 0 is now supported for both guests 2 and 3.
> 
> Shadow CRYCB always uses the guest 2 CRYCB format and it
> follows that:
> 
> * Guest 3 CRYCB format 0 is supported with guest 2 CRYCB format 0,1 or 2
> * Guest 3 CRYCB format 1 is supported with guest 2 CRYCB format 1 or 2
> * Guest 3 CRYCB format 2 is supported with guest 2 CRYCB format 2
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/vsie.c |  222 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 files changed, 198 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index aa30b48..e15240e 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -136,17 +136,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	return 0;
>  }
>  
> -/*
> - * Create a shadow copy of the crycb block and setup key wrapping, if
> - * requested for guest 3 and enabled for guest 2.
> - *
> - * We only accept format-1 (no AP in g2), but convert it into format-2
> - * There is nothing to do for format-0.
> - *
> - * Returns: - 0 if shadowed or nothing to do
> - *          - > 0 if control has to be given to guest 2
> - */
> -static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
> +/* Copy keys into shadow crycb, is only called if MSA3 is available.  */
> +static int copy_key_masks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  {
>  	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>  	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
> @@ -155,30 +146,17 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	unsigned long *b1, *b2;
>  	u8 ecb3_flags;
>  
> -	scb_s->crycbd = 0;
> -	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
> -		return 0;
> -	/* format-1 is supported with message-security-assist extension 3 */
> -	if (!test_kvm_facility(vcpu->kvm, 76))
> -		return 0;
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
>  	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
>  		return set_validity_icpt(scb_s, 0x0035U);
>  
>  	scb_s->ecb3 |= ecb3_flags;
> -	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
> -			CRYCB_FORMAT2;
>  
>  	/* xor both blocks in one run */
>  	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
> @@ -189,6 +167,202 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	return 0;
>  }
>  
> +/* Copy masks into apcb when g2 and g3 use format 1 */
> +static int copy_apcb1(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
> +{
> +	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> +	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
> +	const u32 crycb_o = crycbd_o & 0x7ffffff8U;

Can you pass crycb_o instead please to all applicable users from the
initial handler? Otherwise the READ_ONCE() is of no use any more.

> +	struct kvm_s390_crypto_cb *crycb_h = &vcpu->kvm->arch.sie_page2->crycb;
> +	struct kvm_s390_crypto_cb *crycb_s = &vsie_page->crycb;
> +	unsigned long *apcb_s = (unsigned long *) &crycb_s->apcb1;
> +	unsigned long *apcb_h = (unsigned long *) &crycb_h->apcb1;
> +	int i;
> +	u32 src;
> +
> +	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb1);
> +	if (read_guest_real(vcpu, src, apcb_s, sizeof(struct kvm_s390_apcb1)))

can you instead return -EFAULT and handle 0035U for all cases in the caller?

So you might be able to not pass vsie_page in here.

Same applies to the other handlers below. (and also above)

> +		return set_validity_icpt(scb_s, 0x0035U);
> +
> +	for (i = 0; i < sizeof(struct kvm_s390_apcb1); i += sizeof(*apcb_s))
> +		*apcb_s &= *apcb_h;
> +
> +	return 0;
> +}
> +
> +/*
> + * Copy masks into apcb when g2 use format 1 and g3 use format 0
> + * In this case the shadow APCB uses format 1
> + */
> +static int copy_apcb01(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
> +{
> +	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> +	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
> +	const u32 crycb_o = crycbd_o & 0x7ffffff8U;
> +	struct kvm_s390_apcb1 *apcb_h = &vcpu->kvm->arch.sie_page2->crycb.apcb1;
> +	struct kvm_s390_apcb1 *apcb_s = &vsie_page->crycb.apcb1;
> +	u32 src;
> +
> +	memset(apcb_s, 0, sizeof(*apcb_s));
> +
> +	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.apm[0]);
> +	if (read_guest_real(vcpu, src, &apcb_s->apm[0], sizeof(__u64)))
> +		return set_validity_icpt(scb_s, 0x0035U);
> +
> +	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.aqm[0]);
> +	if (read_guest_real(vcpu, src, &apcb_s->aqm[0], sizeof(__u64)))
> +		return set_validity_icpt(scb_s, 0x0035U);
> +
> +	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.adm[0]);
> +	if (read_guest_real(vcpu, src, &apcb_s->adm[0], sizeof(__u64)))
> +		return set_validity_icpt(scb_s, 0x0035U);
> +
> +	apcb_s->apm[0] &= apcb_h->apm[0];
> +	apcb_s->aqm[0] &= apcb_h->aqm[0];
> +	apcb_s->adm[0] &= apcb_h->adm[0];
> +
> +	return 0;
> +}
> +
> +/* Copy masks into apcb when g2 and g3 use format 0 */
> +static int copy_apcb0(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
> +{
> +	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> +	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
> +	const u32 crycb_o = crycbd_o & 0x7ffffff8U;
> +	struct kvm_s390_apcb0 *apcb_h = &vcpu->kvm->arch.sie_page2->crycb.apcb0;
> +	struct kvm_s390_apcb0 *apcb_s = &vsie_page->crycb.apcb0;
> +	u32 src;
> +
> +	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.apm[0]);
> +	if (read_guest_real(vcpu, src, &apcb_s->apm[0], sizeof(__u64)))
> +		return set_validity_icpt(scb_s, 0x0035U);
> +
> +	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.aqm[0]);
> +	if (read_guest_real(vcpu, src, &apcb_s->aqm[0], sizeof(__u64)))
> +		return set_validity_icpt(scb_s, 0x0035U);
> +
> +	src = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0.adm[0]);
> +	if (read_guest_real(vcpu, src, &apcb_s->adm[0], sizeof(__u64)))
> +		return set_validity_icpt(scb_s, 0x0035U);
> +
> +	apcb_s->apm[0] &= apcb_h->apm[0];
> +	apcb_s->aqm[0] &= apcb_h->aqm[0];
> +	apcb_s->adm[0] &= apcb_h->adm[0];
> +
> +	return 0;
> +}
> +
> +/* Shadowing APCB depends on G2 and G3 CRYCB format */
> +static int copy_apcb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
> +		     int g2_fmt, int g3_fmt)
> +{
> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> +	int ret = 0;
> +
> +	switch (g2_fmt) {
> +	case CRYCB_FORMAT0:
> +		switch (g3_fmt) {
> +		case  CRYCB_FORMAT0:
> +			ret = copy_apcb0(vcpu, vsie_page);
> +			break;
> +		default:
> +			return set_validity_icpt(scb_s, 0x0020U);

return -EINVAL and handle it in the caller (like I suggested with -EFAULT).

Try to not pass vsie_page down here. (same applies to copy_key_masks())

> +		}
> +		break;
> +	case CRYCB_FORMAT1:
> +		switch (g3_fmt) {
> +		case CRYCB_FORMAT1:
> +		case CRYCB_FORMAT0:	/* Fall through to copy APCB */
> +			ret = copy_apcb0(vcpu, vsie_page);
> +			break;
> +		default:
> +			return set_validity_icpt(scb_s, 0x0020U);
> +		}
> +		break;
> +	case CRYCB_FORMAT2:
> +		switch (g3_fmt) {
> +		case CRYCB_FORMAT0:
> +		case CRYCB_FORMAT1:
> +			ret = copy_apcb01(vcpu, vsie_page);
> +			break;
> +		case CRYCB_FORMAT2:
> +			ret = copy_apcb1(vcpu, vsie_page);
> +			break;
> +		}
> +		break;
> +	default:
> +	/*
> +	 * Guest 2 format is valid or we can not get to here.
> +	 */
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Create a shadow copy of the crycb block.
> + * - Setup key wrapping, if requested for guest 3 and enabled for guest 2.
> + * - Shadow APCB if requested by guest 3 and enabled for guest 2 through
> + *   ECA_APIE.
> + *
> + * We only accept format-1 (no AP in g2), but convert it into format-2
> + * There is nothing to do for format-0.
> + *
> + * Returns: - 0 if shadowed or nothing to do
> + *          - > 0 if control has to be given to guest 2
> + *          - < 0 if something went wrong on copy
> + */
> +static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
> +{
> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> +	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
> +	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
> +	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
> +	int g2_fmt = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
> +	int g3_fmt = crycbd_o & CRYCB_FORMAT_MASK;

you can make these two const, too.

> +	int g2_apie, g2_msa3, g3_apie, g3_msa3;

you can initialize these all directly and make them const.

> +	int size, ret;
> +
> +	/* crycb should not cross a page boundary */
> +	size = (g3_fmt == CRYCB_FORMAT2) ? 0x100 : 0x80;
> +	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + size) & PAGE_MASK))
> +		return set_validity_icpt(scb_s, 0x003CU);

You are changing the order of checks compared to existing code. E.g. if
we will not be using the crycbo (as !g3_apie and !g3_msa3), you are
still injecting a validity - existing code won't do that.

Also, you would allow to accept a CRYCB_FORMAT2 here (and perform a
check) although the emulated machine might not even be aware of that
(e.g. !g2_apie and ! g2_msa3)

I don't like such subtle changes. If existing code is wrong, please fix
it first (and explain why it is the right thing to do) or stick to
existing handling as close as possible. Not having access to the
documentation makes me rely on the existing code (and assume it is correct).

> +
> +	g2_apie = vcpu->arch.sie_block->eca & ECA_APIE;
> +	g3_apie = scb_o->eca & g2_apie;
> +
> +	g2_msa3 = test_kvm_facility(vcpu->kvm, 76);
> +	g3_msa3 = (g3_fmt != CRYCB_FORMAT0) & g2_msa3;

We should also consider (ECB3_AES | ECB3_DEA) here. because if both are
not set, there is logically no g3_msa3. (existing code does that)

> +
> +	scb_s->crycbd = 0;
> +	/* If no AP instructions and no keys we just set crycbd to 0 */
> +	if (!(g3_apie || g3_msa3))
> +		return 0;
> +
> +	if (!crycb_addr)
> +		return set_validity_icpt(scb_s, 0x0039U);
> +
> +	if (g3_apie) {
> +		ret = copy_apcb(vcpu, vsie_page, g2_fmt, g3_fmt);
> +		if (ret)
> +			return ret;
> +		scb_s->eca |= g3_apie;
> +	}
> +
> +	if (g3_msa3)
> +		ret = copy_key_masks(vcpu, vsie_page);
> +
> +	if (!ret)
> +		scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | g2_fmt;
> +
> +	return ret;
> +}
> +
>  /* shadow (round up/down) the ibc to avoid validity icpt */
>  static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  {
> 


-- 

Thanks,

David / dhildenb
