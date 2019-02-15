Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A32C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05702192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392968AbfBOWC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:02:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729239AbfBOWC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:02:27 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FLnrR3093653
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:02:26 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qp5jsghu6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:02:25 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 15 Feb 2019 22:02:25 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 22:02:21 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1FM2H2B21495870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 22:02:18 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF042AE09F;
        Fri, 15 Feb 2019 22:02:17 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 384AAAE09B;
        Fri, 15 Feb 2019 22:02:17 +0000 (GMT)
Received: from [9.80.239.175] (unknown [9.80.239.175])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Feb 2019 22:02:17 +0000 (GMT)
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 15 Feb 2019 17:02:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021522-0064-0000-0000-000003A97610
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010604; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000280; SDB=6.01161588; UDB=6.00606354; IPR=6.00942149;
 MB=3.00025604; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-15 22:02:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021522-0065-0000-0000-00003C6D9E75
Message-Id: <4b21f059-1d37-f341-bac7-5b1fe0d06521@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=888 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 8:51 AM, Pierre Morel wrote:
> This patch adds interception code for the PQAP instructions,
> and a callback inside the KVM arch structure for s390.
> 
> If a VFIO-AP drivers needs to intercept PQAP/AQIC or PQAP/TAPQ
> instructions, the driver will initialize the callback inside
> the kvm_arch structure to be called when the interception of a
> PQAP instruction occurs.
> 
> If the callback is not initialized, the code still returns
> -EOPNOTSUPP to let userland handle the instruction as it used to.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |  1 +
>   arch/s390/kvm/priv.c             | 50 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index c5f5156..49cc8b0 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -719,6 +719,7 @@ struct kvm_s390_cpu_model {
>   
>   struct kvm_s390_crypto {
>   	struct kvm_s390_crypto_cb *crycb;
> +	int (*pqap_hook)(struct kvm_vcpu *vcpu);
>   	__u32 crycbd;
>   	__u8 aes_kw;
>   	__u8 dea_kw;
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 8679bd7..72fdc21 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -27,6 +27,7 @@
>   #include <asm/io.h>
>   #include <asm/ptrace.h>
>   #include <asm/sclp.h>
> +#include <asm/ap.h>
>   #include "gaccess.h"
>   #include "kvm-s390.h"
>   #include "trace.h"
> @@ -592,6 +593,53 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>   	}
>   }
>   
> +/*
> + * handle_pqap: Handling pqap interception
> + * @vcpu: the vcpu having issue the pqap instruction
> + *
> + * This callback only handles PQAP/AQIC instruction and
> + * calls a dedicated callback for this instruction if
> + * a driver did register one in the CRYPTO satellite of the
> + * SIE block.
> + *
> + * Do not change the behavior if, return -EOPNOTSUPP if:
> + * - the hook is not used do not change the behavior.
> + * - AP instructions are not available or not available to the guest
> + * - the instruction is not PQAP with function code indicating
> + *   AQIC do not change the previous behavior.
> + *
> + * For PQAP/AQIC instruction, verify privilege and specifications
> + *
> + * return the value returned by the callback.
> + */
> +static int handle_pqap(struct kvm_vcpu *vcpu)
> +{
> +	uint8_t fc;
> +
> +	/* Verify that the hook callback is registered */
> +	if (!vcpu->kvm->arch.crypto.pqap_hook)
> +		return -EOPNOTSUPP;
> +	/* Verify that the AP instruction are available */
> +	if (!ap_instructions_available())
> +		return -EOPNOTSUPP;
> +	/* Verify that the guest is allowed to use AP instructions */
> +	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
> +		return -EOPNOTSUPP;
> +	/* Verify that the function code is AQIC */
> +	fc = vcpu->run->s.regs.gprs[0] >> 24;
> +	if (fc != 0x03)
> +		return -EOPNOTSUPP;

This does not belong here. Function code 3 is one of 7 function codes
that can be sent with the PQAP instruction. This belongs in the PQAP
hook code.

> +
> +	/* PQAP instructions are allowed for guest kernel only */
> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> +	/* AQIC instruction is allowed only if facility 65 is available */
> +	if (!test_kvm_facility(vcpu->kvm, 65))
> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	/* All right, call the callback */
> +	return vcpu->kvm->arch.crypto.pqap_hook(vcpu);
> +}
> +
>   static int handle_stfl(struct kvm_vcpu *vcpu)
>   {
>   	int rc;
> @@ -878,6 +926,8 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
>   		return handle_sthyi(vcpu);
>   	case 0x7d:
>   		return handle_stsi(vcpu);
> +	case 0xaf:
> +		return handle_pqap(vcpu);
>   	case 0xb1:
>   		return handle_stfl(vcpu);
>   	case 0xb2:
> 

