Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97986C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70434218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBKLvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:51:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbfBKLvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:51:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BBjHNB002528
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:51:43 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qk6kanxge-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:51:43 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 11 Feb 2019 11:51:40 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Feb 2019 11:51:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1BBpaYH63832220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 11:51:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E63D011C054;
        Mon, 11 Feb 2019 11:51:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 835D511C04C;
        Mon, 11 Feb 2019 11:51:35 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Feb 2019 11:51:35 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2] s390: vsie: Use effective CRYCBD.31 to check CRYCBD
 validity
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com
References: <1549876849-32680-1-git-send-email-pmorel@linux.ibm.com>
 <20190211104717.21299b01.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 11 Feb 2019 12:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211104717.21299b01.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021111-0016-0000-0000-000002550216
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021111-0017-0000-0000-000032AF1D62
Message-Id: <6283f654-f64b-97f8-7932-b1dc55e1e6eb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2019 10:47, Cornelia Huck wrote:
> On Mon, 11 Feb 2019 10:20:49 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> When facility.76 MSAX3 is present for the guest we must issue a validity
>> interception if the CRYCBD is not valid.
>>
>> The bit CRYCBD.31 is an effective field and tested at each guest
>> level and has for effect to mask the facility.76
>>
>> It follows that if CRYCBD.31 is clear and AP is not in use  we do not
>> have to test the CRYCBD validatity even facility.76 is present in the
> 
> s/even/even if/

yes

> 
>> host.
>>
>> Fixes: 6ee74098201b ("KVM: s390: vsie: allow CRYCB FORMAT-0")
>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/s390/kvm/vsie.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index a153257..d62fa14 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -297,7 +297,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	scb_s->crycbd = 0;
>>   
>>   	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
>> -	if (!apie_h && !key_msk)
>> +	if (!apie_h && (!key_msk || fmt_o == CRYCB_FORMAT0))
>>   		return 0;
>>   
>>   	if (!crycb_addr)
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

