Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB12C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001DF2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001DF2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeHXODW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:03:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbeHXODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:03:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7OATIu9143201
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 06:29:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m2dwrd9p8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 06:29:21 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 24 Aug 2018 11:29:10 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 11:29:05 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7OAT3M726869952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 10:29:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ACABAE055;
        Fri, 24 Aug 2018 13:28:39 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0252AE045;
        Fri, 24 Aug 2018 13:28:33 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.145.34.127])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 13:28:33 +0100 (BST)
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
To:     David Hildenbrand <david@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>, pmorel@linux.ibm.com,
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
 <95e6ee74-69aa-9805-3233-b9ec81fce516@redhat.com>
 <7e7a35f5-d1eb-7719-c5e8-57d6f19db675@linux.ibm.com>
 <f5ec13ae-75b4-918e-aaf1-ed97944ff16e@redhat.com>
 <fec90446-7f94-da28-d958-427a0446854e@linux.ibm.com>
 <ef6082b7-da96-3a0b-77a0-f41d113d058a@redhat.com>
 <8d6ae58f-967b-5e4e-0e54-8fb4962cb843@linux.ibm.com>
 <be13d8fa-1ff7-6800-36b9-7f8320724cbf@redhat.com>
 <049c5e8a-4f21-a079-0eb6-abe78d812de7@linux.ibm.com>
 <1721a153-13f0-e695-6c01-cf6b65e1bbfa@linux.ibm.com>
 <e782de8d-45d8-79fd-165c-c84f431e1d34@redhat.com>
 <cd00d49a-f6d0-a911-8cda-8f95f58beb27@linux.ibm.com>
 <79ae3a9c-70c3-7b08-09ee-0b8308cbca56@linux.ibm.com>
 <a228497a-ce48-28bd-0244-b557405c0a84@redhat.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Fri, 24 Aug 2018 12:28:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a228497a-ce48-28bd-0244-b557405c0a84@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18082410-0028-0000-0000-000002EF24B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082410-0029-0000-0000-000023A86E01
Message-Id: <35f38ac1-caa2-9cb3-2f72-10c2b1bf7486@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/23/2018 07:40 PM, David Hildenbrand wrote:
> On 23.08.2018 19:35, Tony Krowiak wrote:
>> On 08/23/2018 10:59 AM, Pierre Morel wrote:
>>> On 23/08/2018 15:38, David Hildenbrand wrote:
>>>> On 23.08.2018 15:22, Halil Pasic wrote:
>>>>>
>>>>>
>>>>> On 08/23/2018 02:47 PM, Pierre Morel wrote:
>>>>>> On 23/08/2018 13:12, David Hildenbrand wrote:
>>>>> [..]
>>>>>>>>>>
>>>>>>>>>> I'm confused, which 128 bit?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Me too :) , I was assuming this block to be 128bit, but the qci
>>>>>>>>> block
>>>>>>>>> has 128 bytes....
>>>>>>>>>
>>>>>>>>> And looking at arch/s390/include/asm/ap.h, there is a lot of
>>>>>>>>> information
>>>>>>>>> contained that is definitely not of interest for CPU models...
>>>>>>>>>
>>>>>>>>> I wonder if there is somewhere defined which bits are reserved for
>>>>>>>>> future features/facilities, compared to ap masks and such.
>>>>>>>>>
>>>>>>>>> This is really hard to understand/plan without access to
>>>>>>>>> documentation.
>>>>>>>>>
>>>>>>>>> You (Halil, Tony, Pier, ...) should have a look if what I described
>>>>>>>>> related to PQAP(QCI) containing features that should get part of
>>>>>>>>> the CPU
>>>>>>>>> model makes sense or not. For now I was thinking that there is
>>>>>>>>> some part
>>>>>>>>> inside of QCI that is strictly reserved for facilities/features
>>>>>>>>> that we
>>>>>>>>> can use.
>>>>>
>>>>> No there is no such part. The architecture documentation is quite
>>>>> confusing
>>>>> with some aspects (e.g. persistence) of how exactly some of these
>>>>> features
>>>>> work and are indicated. I'm having a hard time finding my opinion. I
>>>>> may
>>>>> end up asking some questions later, but for now i have to think first.
>>>>>
>>>>> Just one hint. There is a programming note stating that if bit 2 of the
>>>>> QCI block is one there is at least one AP card in the machine that
>>>>> actually
>>>>> has APXA installed.
>>>>>
>>>>> I read the architecture so that the APXA has a 'cpu part' (if we are
>>>>> doing APXA the cpu can't spec exception on certain bits not being zor9)
>>>>> and a 'card(s) part'.
>>>>>
>>>>> Since the stuff seems quite difficult to sort out properly, I ask
>>>>> myself
>>>>> are there real problems we must solve?
>>>>>
>>>>> This ultimately seems to be  about the migration, right? You say
>>>>> 'This helps
>>>>> to catch nasty migration bugs (e.g. APXA suddenly disappearing).' at
>>>>> the very
>>>>> beginning of the discussion. Yes, we don't have to have an vfio_ap
>>>>> device,
>>>>> he guest can and will start looking for AP resources if
>>>>> only the cpu model features installed. So the guest could observe
>>>>> a disappearing APXA, but I don't think that would lead to problems
>>>>> (with
>>>>> Linux at least).
>>>>>
>>>>> And there ain't much AP a guest can sanely do without if no AP
>>>>> resources
>>>>> are there.
>>>>>
>>>>> I would really prefer not rushing a solution if we don't have to.
>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> What is apsc, qact, rc8a in the qci blocks? are the facility bits?
>>>>>>
>>>>>> Yes, facility bits concerning the AP instructions
>>>>>>
>>>>>
>>>>> According to the current AR document rc8a ain't a facility but bits
>>>>> 0-2 and 4-7 kind of are.
>>>>>
>>>>
>>>> Easy ( :) ) answer. Everything that is the CPU part should get into the
>>>> CPU model. Everything that is AP specific not. If APXA is not a CPU
>>>> facility, fine with me to leave it out.
>>>>
>>>> Ack to not rushing, but also ack to not leaving out important things.
>>>> Ack that this stuff is hard to ficure out.
>>>
>>> APXA is not a CPU part, it is a machine part (SIE) and a AP part
>>> (QCI,TAPQ),
>>> it has no influence on CPU instructions but on the AP instructions.
>>> Consequently, if I understood the definition correctly, it should not
>>> go in the CPU model.
>>
>> The APXA bit returned via the PQAP(QCI) instruction indicates the APXA
>> facility is
>> installed in the CPUs of the configuration. This means that the facility is
>> installed in one or more adjunct processors but not necessarily all.
>> Given that
>> it indicates a CPU property, maybe it does belong in the CPU model?
>>
> 
> Hmmm, I tend to agree - especially as it affects SIE behavior. But as
> this is not a feature block (compared to what I thought), this clould be
> model as a CPU feature like AP.
> 

There is certainly a CPU aspect to APXA: before APXA the APQN had to
have zeros in certain bits (otherwise specification exception). When
running with APXA we have a guarantee that there won't be any
specification exception flying because such an bit is set. The interesting
question is, is APXA constant let's say as long as an LPAR partition is
activated?

Regards,
Halil

