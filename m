Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88896C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1B1215B2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1B1215B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeHJMGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:06:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727195AbeHJMGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:06:23 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7A9SwGc089690
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:37:17 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ks5e9xktv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:37:16 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Fri, 10 Aug 2018 10:37:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 Aug 2018 10:37:11 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7A9b9RS41287824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Aug 2018 09:37:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DA0BAE04D;
        Fri, 10 Aug 2018 12:37:00 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 102F0AE055;
        Fri, 10 Aug 2018 12:36:59 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.84.129.94])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Aug 2018 12:36:58 +0100 (BST)
Subject: Re: [PATCH v8 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <aec0af21-270f-c4c5-3aea-f6854ca2fb07@linux.ibm.com>
 <323af125-f078-919c-3117-f9022f5529ae@linux.ibm.com>
 <20180810104929.6d40edef.cohuck@redhat.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Fri, 10 Aug 2018 11:37:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180810104929.6d40edef.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081009-0020-0000-0000-000002B4CA96
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081009-0021-0000-0000-00002101E2F4
Message-Id: <4251c5c4-6330-d391-f37c-c57dd268efe9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808100104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.2018 10:49, Cornelia Huck wrote:
> On Thu, 9 Aug 2018 12:06:56 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 08/09/2018 05:17 AM, Harald Freudenberger wrote:
>>> On 09.08.2018 11:06, Cornelia Huck wrote:  
>>>> On Wed,  8 Aug 2018 10:44:14 -0400
>>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>>  
>>>>> From: Harald Freudenberger <freude@de.ibm.com>
>>>>>
>>>>> Move all the inline functions from the ap bus header
>>>>> file ap_asm.h into the in-kernel api header file
>>>>> arch/s390/include/asm/ap.h so that KVM can make use
>>>>> of all the low level AP functions.
>>>>>
>>>>> Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
>>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>  
>>>> You should add your own s-o-b if you are sending on patches written by
>>>> others (even if it does not matter in the end, when they are merged
>>>> through a different path anyway.)
>>>>  
>>>>> ---
>>>>>   arch/s390/include/asm/ap.h     |  284 ++++++++++++++++++++++++++++++++++++----
>>>>>   drivers/s390/crypto/ap_asm.h   |  261 ------------------------------------
>>>>>   drivers/s390/crypto/ap_bus.c   |   21 +---
>>>>>   drivers/s390/crypto/ap_bus.h   |    1 +
>>>>>   drivers/s390/crypto/ap_card.c  |    1 -
>>>>>   drivers/s390/crypto/ap_queue.c |    1 -
>>>>>   6 files changed, 259 insertions(+), 310 deletions(-)
>>>>>   delete mode 100644 drivers/s390/crypto/ap_asm.h
>>>>>
>>>>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>>>>> index c1bedb4..046e044 100644
>>>>> --- a/arch/s390/include/asm/ap.h
>>>>> +++ b/arch/s390/include/asm/ap.h
>>>>> @@ -47,6 +47,50 @@ struct ap_queue_status {
>>>>>   };
>>>>>   
>>>>>   /**
>>>>> + * ap_intructions_available() - Test if AP instructions are available.
>>>>> + *
>>>>> + * Returns 0 if the AP instructions are installed.  
>>>> Stumbled over this when I was looking at the usage in patch 7: if I see
>>>> a function called '_available' return 0, I'd assume that whatever the
>>>> function tests for is *not* available.
>>>>
>>>> Rather call this function ap_instructions_check_availability() (and
>>>> keep the return code convention), or switch this to return 0 if not
>>>> available and !0 if available?  
>>> Good catch, Cony you are right. I'll fix this to return 1 if AP instructions
>>> are available and 0 if not. However, this patch will come via Martin's pipe
>>> to the Linus Torwald kernel sources.  
>> Is your intent to simply indicate whether the AP instructions are 
>> available or
>> not; or is the intention to indicate whether the AP instructions are 
>> available
>> and if not, they why? In the former, then I agree that a boolean should be
>> returned; however, if the case is the latter, then what you have is fine but
>> maybe the function name should be changed as Connie suggests.
> So, can this actually fail for any reason other than "instructions not
> installed"? Even if it did, the end result is that the instructions are
> not usable -- I don't think the "why" would be interesting at that
> point.
I can not think of any other reason why the PQAP(TAPQ) would fail
other than the AP instructions are not available at all. However,
the old implementation returned -ENODEV on failure and 0 on
success. The new implementation now returns 1 for success
and 0 for failure. This is just one of a couple of functions related
to ap xxx available. I'll rework them all to return a boolean value
soon.
>
>>>>> + */
>>>>> +static inline int ap_instructions_available(void)
>>>>> +{
>>>>> +	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
>>>>> +	register unsigned long reg1 asm ("1") = -ENODEV;
>>>>> +	register unsigned long reg2 asm ("2");
>>>>> +
>>>>> +	asm volatile(
>>>>> +		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
>>>>> +		"0: la    %0,0\n"
>>>>> +		"1:\n"
>>>>> +		EX_TABLE(0b, 1b)
>>>>> +		: "+d" (reg1), "=d" (reg2)
>>>>> +		: "d" (reg0)
>>>>> +		: "cc");
>>>>> +	return reg1;
>>>>> +}  

