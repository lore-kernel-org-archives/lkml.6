Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A267C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F6A208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F6A208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeHWLyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:54:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729063AbeHWLyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:54:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7N8JbVM049033
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:26:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1rtn1n52-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:26:14 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 23 Aug 2018 09:26:11 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 09:26:07 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7N8Q6wK34406570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 08:26:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 704424C046;
        Thu, 23 Aug 2018 11:26:07 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B64AA4C052;
        Thu, 23 Aug 2018 11:26:06 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 11:26:06 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
To:     David Hildenbrand <david@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
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
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
 <8f3f3f41-a052-1975-69e2-49e1a662ecab@linux.ibm.com>
 <38b87fc4-9344-70d8-4602-bf8e114769ef@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 23 Aug 2018 10:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <38b87fc4-9344-70d8-4602-bf8e114769ef@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082308-4275-0000-0000-000002AE0C06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082308-4276-0000-0000-000037B713F3
Message-Id: <933db512-fca1-a471-5e2d-b247cfc94fea@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2018 09:48, David Hildenbrand wrote:
>>>>
>>> I really wonder if we should also export the APXA facility.
>>
>> Given this comment is made within the context of the
>> FACILITIES_KVM_CPUMODEL I might point out that APXA is not
>> indicated by a facilities bit. It is indicated by a bit in
>> the QCI control block returned from the PQAP(QCI)
>> instruction to indicate that APXA is installed on all CPUs.
>>
>>> We can probe and allow that CPU feature. However, we cannot disable it
>>> (as of now).
>>
>> Given this patch series implements passthrough devices,
>> the output of the PQAP(QCI) will always be from a real
>> device - i.e., there will be no way to disable it.
>>
> 
> see below
> 
>>>
>>> We have other CPU features where it is the same case (basically all
>>> subfunctions). See kvm_s390_get_processor_subfunc(). We probe them and
>>> export them, but support to disable them has never been implemented.
>>>
>>> On a high level, we could then e.g. deny to start a QEMU guest if APXA
>>> is available but has been disabled. (until we know that disabling it
>>> actually works - if ever).
>>>
>>> This helps to catch nasty migration bugs (e.g. APXA suddenly
>>> disappearing). Although unlikely, definitely possible.
>>
>> Migration of AP devices is not supported by this patch series, so this
>> should
>> not be an issue.
> 
> Might not be a problem now, but could be later. As I said in a different
> reply, the CPU model in QEMU does not care about KVM.
> 
> I want the QEMU CPU model and the KVM interfaces to be clean and future
> proof. That's why my opinion is to handle PQAP(QCI) just like all the
> other "feature blocks" we already have.
> 

Don't you mix with the TAPQ instruction which has
a T bit to specify interception.
It indeed is not in the subfunction list even it
has a T bit to indicate interception.

TAPQ-t is indicated through the APFT facility.

We can use this bit as an indication of the presence
of APXA, the documentation mention that both are implemented together.

regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

