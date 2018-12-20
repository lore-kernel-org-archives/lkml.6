Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF75DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8317421741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbeLTKKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:10:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728687AbeLTKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:10:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBKA9LB7046007
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:10:01 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pg795n6km-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:10:01 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 20 Dec 2018 10:09:59 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Dec 2018 10:09:57 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBKA9t1C5177808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 10:09:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83D985204F;
        Thu, 20 Dec 2018 10:09:55 +0000 (GMT)
Received: from [9.152.224.123] (unknown [9.152.224.123])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2394452051;
        Thu, 20 Dec 2018 10:09:55 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v5 05/15] KVM: s390: unify pending_irqs() and
 pending_irqs_no_gisa()
To:     KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-6-mimu@linux.ibm.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Thu, 20 Dec 2018 11:09:54 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181219191756.57973-6-mimu@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18122010-0020-0000-0000-000002FA359F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122010-0021-0000-0000-0000214A4654
Message-Id: <5fbd4e59-c177-20de-4be5-6891398a2984@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.12.18 20:17, Michael Mueller wrote:
>   
> -static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
> -{
> -	return pending_irqs_no_gisa(vcpu) |
> -		kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
> +	if (irq_flags & IRQ_FLAG_LOCAL)
> +		pending_irqs |= vcpu->arch.local_int.pending_irqs;
> +	if (irq_flags & IRQ_FLAG_FLOATING)
> +		pending_irqs |= vcpu->kvm->arch.float_int.pending_irqs;
> +	if (irq_flags & IRQ_FLAG_GISA)


Fix crash under vsie:

                 pending_irqs |= vcpu->kvm->arch.float_int.pending_irqs;
-       if (irq_flags & IRQ_FLAG_GISA)
+       if (vcpu->kvm->arch.gisa && irq_flags & IRQ_FLAG_GISA)
                 pending_irqs |= get_ipm(vcpu->kvm->arch.gisa, irq_flags)


> +		pending_irqs |= kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) <<
> +			IRQ_PEND_IO_ISC_7;
> +	return pending_irqs;
>   }

-- 
Mit freundlichen Grüßen / Kind regards
Michael Müller

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

