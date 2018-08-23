Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86C4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7518E208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7518E208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeHWKVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:21:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbeHWKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:21:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7N6ms7k057086
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 02:53:05 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1p1cvbcd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 02:53:05 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 23 Aug 2018 07:53:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 07:52:59 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7N6qwQn21102744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 06:52:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7162242042;
        Thu, 23 Aug 2018 09:52:59 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21D4842041;
        Thu, 23 Aug 2018 09:52:59 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 09:52:59 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 3/5] KVM: s390: vsie: Allow support for a host without
 AP
Reply-To: pmorel@linux.ibm.com
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-4-git-send-email-pmorel@linux.ibm.com>
 <beb38451-8ec9-59c7-2e51-f9a065b769bf@redhat.com>
Date:   Thu, 23 Aug 2018 08:52:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <beb38451-8ec9-59c7-2e51-f9a065b769bf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082306-0012-0000-0000-0000029D86C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082306-0013-0000-0000-000020D0CCF2
Message-Id: <8d506740-9228-a5f7-30ad-4bd181d4385a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2018 19:06, David Hildenbrand wrote:
> On 22.08.2018 18:51, Pierre Morel wrote:
>> Currently the CRYCB format used in the host for the
>> shadowed CRYCB is FORMAT2 while no check is done if
>> AP instructions are supported in the host.
>>
>> We better use the format the host calculated for the
>> guest 1 as the host already tested it against its
>> facility set.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/kvm/vsie.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index 56a9d47..0b12916 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -154,6 +154,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
>>   	unsigned long *b1, *b2;
>>   	u8 ecb3_flags;
>> +	unsigned long g1_fmt;
>>   
>>   	scb_s->crycbd = 0;
>>   	if (!(crycbd_o == CRYCB_FORMAT1))
>> @@ -180,8 +181,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   		return set_validity_icpt(scb_s, 0x0035U);
>>   
>>   	scb_s->ecb3 |= ecb3_flags;
>> -	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
>> -			CRYCB_FORMAT2;
>> +	g1_fmt = vcpu->arch.sie_block->crycbd & 0x03;
>> +	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | g1_fmt;
>>   
>>   	/* xor both blocks in one run */
>>   	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
>>
> 
> This is wrong. I remember that with APXA, if FORMAT2 is available, we
> should always use FORMAT2. That's why we explicitly convert it here.
> 

You are right if FORMAT2 is available we should use FORMAT2
but the intention here is to use what KVM crypto init function did,
assuming it did the right thing.

Eventually we are running on a host without AP and we should use FORMAT1.

Isn't it correct?

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

