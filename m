Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D45C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B5E208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B5E208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeHQQWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:22:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727037AbeHQQWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:22:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7HDJBUp046869
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:19:16 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kwwj83wy4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:19:12 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 17 Aug 2018 07:19:01 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Aug 2018 07:18:58 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7HDIt4O1769838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Aug 2018 06:18:55 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A9B7136059;
        Fri, 17 Aug 2018 07:18:55 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 958BC13604F;
        Fri, 17 Aug 2018 07:18:52 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.206.50])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 17 Aug 2018 07:18:52 -0600 (MDT)
Subject: Re: [PATCH v9 04/22] s390/zcrypt: Integrate ap_asm.h into
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
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180814104335.4bc3630a.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 17 Aug 2018 09:18:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180814104335.4bc3630a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081713-0012-0000-0000-000016A03039
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009561; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01074831; UDB=6.00553931; IPR=6.00854789;
 MB=3.00022773; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-17 13:19:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081713-0013-0000-0000-00005412D011
Message-Id: <49e99e8a-7de8-abde-6775-af11680db13d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808170146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 04:43 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:01 -0400
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
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/ap.h     |  284 ++++++++++++++++++++++++++++++++++++----
>>   drivers/s390/crypto/ap_bus.c   |   23 +---
>>   drivers/s390/crypto/ap_bus.h   |    1 +
>>   drivers/s390/crypto/ap_card.c  |    1 -
>>   drivers/s390/crypto/ap_queue.c |    1 -
>>   5 files changed, 260 insertions(+), 50 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index c1bedb4..887494a 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -47,6 +47,50 @@ struct ap_queue_status {
>>   };
>>   
>>   /**
>> + * ap_intructions_available() - Test if AP instructions are available.
>> + *
>> + * Returns 1 if the AP instructions are installed, otherwise 0.
>> + */
>> +static inline int ap_instructions_available(void)
>> +{
>> +	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
>> +	register unsigned long reg1 asm ("1") = 0;
>> +	register unsigned long reg2 asm ("2") = 0;
>> +
>> +	asm volatile(
>> +		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
>> +		"0: la    %0,1\n"
>> +		"1:\n"
>> +		EX_TABLE(0b, 1b)
>> +		: "+d" (reg1), "+d" (reg2)
>> +		: "d" (reg0)
>> +		: "cc");
>> +	return reg1;
>> +}
> I think upstream this change (have this function return !0 when the
> instructions are installed) will be an addon patch to the one which has
> already made its way into master. Not really relevant for the remainder
> of this patch series, though.

I noticed that Harald's patches showed up in our master branch yesterday
without this change.

>

