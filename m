Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E59FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D0D2175D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D0D2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbeHGTVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:21:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388577AbeHGTVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:21:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w77H4Tb4124753
        for <linux-kernel@vger.kernel.org>; Tue, 7 Aug 2018 13:06:17 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kqeuy1sym-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:06:17 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 7 Aug 2018 18:06:14 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Aug 2018 18:06:12 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w77H6Ae838863096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Aug 2018 17:06:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABA174C04A;
        Tue,  7 Aug 2018 20:06:19 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6648D4C044;
        Tue,  7 Aug 2018 20:06:19 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Aug 2018 20:06:19 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH RFC 1/2] KVM: s390: vsie: simulate VCPU SIE entry/exit
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20180807125131.3606-1-david@redhat.com>
 <20180807125131.3606-2-david@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 7 Aug 2018 19:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807125131.3606-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080717-4275-0000-0000-000002A68225
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080717-4276-0000-0000-000037AF888B
Message-Id: <c23ee2bd-a7b9-bc9d-52b5-cde34a488506@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 14:51, David Hildenbrand wrote:
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
>   arch/s390/kvm/kvm-s390.c |  9 ++++++++-
>   arch/s390/kvm/kvm-s390.h |  1 +
>   arch/s390/kvm/vsie.c     | 20 ++++++++++++++++++--
>   3 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 91ad4a9425c0..c87734a31fdb 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2766,18 +2766,25 @@ static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
>   	exit_sie(vcpu);
>   }
>   
> +bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu)
> +{
> +	return atomic_read(&vcpu->arch.sie_block->prog20) &
> +	       (PROG_BLOCK_SIE | PROG_REQUEST);
> +}
> +
>   static void kvm_s390_vcpu_request_handled(struct kvm_vcpu *vcpu)
>   {
>   	atomic_andnot(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
>   }
>   
>   /*
> - * Kick a guest cpu out of SIE and wait until SIE is not running.
> + * Kick a guest cpu out of (v)SIE and wait until (v)SIE is not running.
>    * If the CPU is not running (e.g. waiting as idle) the function will
>    * return immediately. */
>   void exit_sie(struct kvm_vcpu *vcpu)
>   {
>   	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOP_INT);
> +	kvm_s390_vsie_kick(vcpu);
>   	while (vcpu->arch.sie_block->prog0c & PROG_IN_SIE)
>   		cpu_relax();
>   }
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 981e3ba97461..1f6e36cdce0d 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -290,6 +290,7 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
>   void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
>   void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);
>   void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu);
> +bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu);
>   void exit_sie(struct kvm_vcpu *vcpu);
>   void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu);
>   int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 63844b95c22c..faac06886f77 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -989,6 +989,17 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>   	int rc = 0;
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
>   	while (1) {
>   		rc = acquire_gmap_shadow(vcpu, vsie_page);
>   		if (!rc)
> @@ -1004,10 +1015,14 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   		if (rc == -EAGAIN)
>   			rc = 0;
>   		if (rc || scb_s->icptcode || signal_pending(current) ||
> -		    kvm_s390_vcpu_has_irq(vcpu, 0))
> +		    kvm_s390_vcpu_has_irq(vcpu, 0) ||
> +		    kvm_s390_vcpu_sie_inhibited(vcpu))
>   			break;
>   	}
>   
> +	barrier();
> +	vcpu->arch.sie_block->prog0c &= ~PROG_IN_SIE;
> +
>   	if (rc == -EFAULT) {
>   		/*
>   		 * Addressing exceptions are always presentes as intercepts.
> @@ -1121,7 +1136,8 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
>   	if (unlikely(scb_addr & 0x1ffUL))
>   		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>   
> -	if (signal_pending(current) || kvm_s390_vcpu_has_irq(vcpu, 0))
> +	if (signal_pending(current) || kvm_s390_vcpu_has_irq(vcpu, 0) ||
> +	    kvm_s390_vcpu_sie_inhibited(vcpu))
>   		return 0;
>   
>   	vsie_page = get_vsie_page(vcpu->kvm, scb_addr);

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
Tested-by: Pierre Morel<pmorel@linux.ibm.com>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

