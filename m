Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3425EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D410A21C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D410A21C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbeHIRni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:43:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732330AbeHIRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:43:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w79FFvMO051548
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 11:18:13 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2krnmef8nq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:18:13 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 9 Aug 2018 11:18:12 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 11:18:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w79FI6F610879286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 15:18:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 102F3B2066;
        Thu,  9 Aug 2018 11:17:29 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69461B2064;
        Thu,  9 Aug 2018 11:17:28 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 11:17:28 -0400 (EDT)
Subject: Re: [PATCH v8 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180809110645.33b20c1f.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 9 Aug 2018 11:18:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180809110645.33b20c1f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080915-0052-0000-0000-0000031C3344
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009514; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01071330; UDB=6.00551657; IPR=6.00850999;
 MB=3.00022614; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-09 15:18:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080915-0053-0000-0000-00005DAB8798
Message-Id: <10a23890-5ad4-38bd-aece-def5940fec89@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 05:06 AM, Cornelia Huck wrote:
> On Wed,  8 Aug 2018 10:44:14 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Harald Freudenberger <freude@de.ibm.com>
>>
>> Move all the inline functions from the ap bus header
>> file ap_asm.h into the in-kernel api header file
>> arch/s390/include/asm/ap.h so that KVM can make use
>> of all the low level AP functions.
>>
>> Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> You should add your own s-o-b if you are sending on patches written by
> others (even if it does not matter in the end, when they are merged
> through a different path anyway.)

That's rather ironic given I was told in an internal review that I should
not sign off on patches I did not write.

>
>> ---
>>   arch/s390/include/asm/ap.h     |  284 ++++++++++++++++++++++++++++++++++++----
>>   drivers/s390/crypto/ap_asm.h   |  261 ------------------------------------
>>   drivers/s390/crypto/ap_bus.c   |   21 +---
>>   drivers/s390/crypto/ap_bus.h   |    1 +
>>   drivers/s390/crypto/ap_card.c  |    1 -
>>   drivers/s390/crypto/ap_queue.c |    1 -
>>   6 files changed, 259 insertions(+), 310 deletions(-)
>>   delete mode 100644 drivers/s390/crypto/ap_asm.h
>>
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index c1bedb4..046e044 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -47,6 +47,50 @@ struct ap_queue_status {
>>   };
>>   
>>   /**
>> + * ap_intructions_available() - Test if AP instructions are available.
>> + *
>> + * Returns 0 if the AP instructions are installed.
> Stumbled over this when I was looking at the usage in patch 7: if I see
> a function called '_available' return 0, I'd assume that whatever the
> function tests for is *not* available.
>
> Rather call this function ap_instructions_check_availability() (and
> keep the return code convention), or switch this to return 0 if not
> available and !0 if available?
>
>> + */
>> +static inline int ap_instructions_available(void)
>> +{
>> +	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
>> +	register unsigned long reg1 asm ("1") = -ENODEV;
>> +	register unsigned long reg2 asm ("2");
>> +
>> +	asm volatile(
>> +		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
>> +		"0: la    %0,0\n"
>> +		"1:\n"
>> +		EX_TABLE(0b, 1b)
>> +		: "+d" (reg1), "=d" (reg2)
>> +		: "d" (reg0)
>> +		: "cc");
>> +	return reg1;
>> +}


