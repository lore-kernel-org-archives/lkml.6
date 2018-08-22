Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C63C41535
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B868214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B868214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeHVT3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:29:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726192AbeHVT3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:29:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7MFxVuD136880
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 12:03:52 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1ax2gb95-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 12:03:51 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 22 Aug 2018 16:53:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 16:53:39 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7MFrcZ741549876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 15:53:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5095A4053;
        Wed, 22 Aug 2018 18:53:37 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29011A404D;
        Wed, 22 Aug 2018 18:53:37 +0100 (BST)
Received: from [9.152.224.111] (unknown [9.152.224.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 18:53:37 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820162317.08bd7d23.cohuck@redhat.com>
 <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
 <20180821172548.57a6c758.cohuck@redhat.com>
 <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
 <a43ef10f-aa91-cb4c-a8aa-cd3ce9cfebf2@linux.ibm.com>
 <20180822114250.59a250aa.cohuck@redhat.com>
 <8bc5f207-f913-825c-f9fc-0a2c7fd280aa@linux.ibm.com>
 <e36abc22-9daf-e0f4-c6b3-7adbb28db4c3@de.ibm.com>
 <f84dbcc0-f627-be02-9933-3baa953adc09@linux.ibm.com>
 <219b352b-d5a2-189c-e205-82e7f9ae3d64@de.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 22 Aug 2018 17:53:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <219b352b-d5a2-189c-e205-82e7f9ae3d64@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082215-4275-0000-0000-000002ADB47C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082215-4276-0000-0000-000037B6BA2D
Message-Id: <7a03a9dd-2747-3a35-3048-a0b719edb955@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2018 17:48, Christian Borntraeger wrote:
> On 08/22/2018 05:34 PM, Pierre Morel wrote:
>> On 22/08/2018 17:11, Christian Borntraeger wrote:
>>>
>>>
>>> On 08/22/2018 01:03 PM, Pierre Morel wrote:
>>>>> That's interesting.
>>>>>
>>>>>> IMHO this quote is quite a half-full half-empty cup one:
>>>>>> * it mandates the set of usage domains is a subset of the set
>>>>>> of the control domains, but
>>>>>> * it speaks of independent controls, namely about the 'usage domain index'
>>>>>> and the 'control domain index list' and makes the enforcement of the rule
>>>>>> a job of the administrator (instead of codifying it in the controls).
>>>>> I'm wondering if a configuration with a usage domain that is not also a
>>>>> control domain is rejected outright? Anybody tried that? :)
>>>>
>>>> Yes, and no it is not.
>>>> We can use a queue (usage domain) to a AP card for SHA-512 or RSA without
>>>> having to define the queue as a control domain.
>>>
>>> Huh? My HMC allows to add a domain as
>>> - control only domain
>>> - control and usage domain.
>>>
>>> But I am not able to configure a usage-only domain for my LPAR. That seems to match
>>> the current code, no?
>>>
>>
>> Yes, it may not be configurable by the HMC but if we start a guest with no control domain it is not a problem to access the hardware through the usage domain.
>>
>> I tested this a long time ago, but tested again today to be sure on my LPAR.
>>
>> AFAIU adding a control only domain and a control and usage domain
>> allows say:
>> control and usage domain 1
>> control only domain 2
>>
>> Allow to send a message to domain 2 using queue 1
>>
>> Allow also to send a domain modifying message to domain 1 using queue 1
>>
>> control domain are domain which are controlled
> 
> So you have changed the code to not automatically make a usage domain a
> control domain in the bitfield (and you could still use it as a usage
> domain). Correct?

yes
and I used Harald's libica tests to verify it in the guest.

> I think this is probably expected. the "usage implies control" seems to
> be a convention implemented by HMC (lpar) and z/VM but millicode offers
> the bits to have usage-only domains. As LPAR and z/VM will always enable
> any usage-domain to also be a control domain we should do the same.
> 
> 
>> It seems that the HMC enforce the LPARs to have access to their usage domain (AFAIU from Harald)


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

