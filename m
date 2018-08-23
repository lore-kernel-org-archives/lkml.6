Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686F4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED2921557
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED2921557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeHWVGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:06:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbeHWVGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:06:17 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NHUVsU085300
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:35:31 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1y8wnyrn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:35:31 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 23 Aug 2018 11:35:30 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 11:35:27 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NHZOjW19857550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 10:35:24 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3B9E136063;
        Thu, 23 Aug 2018 11:35:24 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16FCB136060;
        Thu, 23 Aug 2018 11:35:21 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 11:35:21 -0600 (MDT)
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
To:     pmorel@linux.ibm.com, David Hildenbrand <david@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
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
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 23 Aug 2018 13:35:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <cd00d49a-f6d0-a911-8cda-8f95f58beb27@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082317-0036-0000-0000-00000A288EE3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009599; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077777; UDB=6.00555710; IPR=6.00857751;
 MB=3.00022890; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-23 17:35:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082317-0037-0000-0000-000048AFFBA3
Message-Id: <79ae3a9c-70c3-7b08-09ee-0b8308cbca56@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 10:59 AM, Pierre Morel wrote:
> On 23/08/2018 15:38, David Hildenbrand wrote:
>> On 23.08.2018 15:22, Halil Pasic wrote:
>>>
>>>
>>> On 08/23/2018 02:47 PM, Pierre Morel wrote:
>>>> On 23/08/2018 13:12, David Hildenbrand wrote:
>>> [..]
>>>>>>>>
>>>>>>>> I'm confused, which 128 bit?
>>>>>>>
>>>>>>>
>>>>>>> Me too :) , I was assuming this block to be 128bit, but the qci 
>>>>>>> block
>>>>>>> has 128 bytes....
>>>>>>>
>>>>>>> And looking at arch/s390/include/asm/ap.h, there is a lot of 
>>>>>>> information
>>>>>>> contained that is definitely not of interest for CPU models...
>>>>>>>
>>>>>>> I wonder if there is somewhere defined which bits are reserved for
>>>>>>> future features/facilities, compared to ap masks and such.
>>>>>>>
>>>>>>> This is really hard to understand/plan without access to 
>>>>>>> documentation.
>>>>>>>
>>>>>>> You (Halil, Tony, Pier, ...) should have a look if what I described
>>>>>>> related to PQAP(QCI) containing features that should get part of 
>>>>>>> the CPU
>>>>>>> model makes sense or not. For now I was thinking that there is 
>>>>>>> some part
>>>>>>> inside of QCI that is strictly reserved for facilities/features 
>>>>>>> that we
>>>>>>> can use.
>>>
>>> No there is no such part. The architecture documentation is quite 
>>> confusing
>>> with some aspects (e.g. persistence) of how exactly some of these 
>>> features
>>> work and are indicated. I'm having a hard time finding my opinion. I 
>>> may
>>> end up asking some questions later, but for now i have to think first.
>>>
>>> Just one hint. There is a programming note stating that if bit 2 of the
>>> QCI block is one there is at least one AP card in the machine that 
>>> actually
>>> has APXA installed.
>>>
>>> I read the architecture so that the APXA has a 'cpu part' (if we are
>>> doing APXA the cpu can't spec exception on certain bits not being zor9)
>>> and a 'card(s) part'.
>>>
>>> Since the stuff seems quite difficult to sort out properly, I ask 
>>> myself
>>> are there real problems we must solve?
>>>
>>> This ultimately seems to be  about the migration, right? You say 
>>> 'This helps
>>> to catch nasty migration bugs (e.g. APXA suddenly disappearing).' at 
>>> the very
>>> beginning of the discussion. Yes, we don't have to have an vfio_ap 
>>> device,
>>> he guest can and will start looking for AP resources if
>>> only the cpu model features installed. So the guest could observe
>>> a disappearing APXA, but I don't think that would lead to problems 
>>> (with
>>> Linux at least).
>>>
>>> And there ain't much AP a guest can sanely do without if no AP 
>>> resources
>>> are there.
>>>
>>> I would really prefer not rushing a solution if we don't have to.
>>>
>>>>
>>>>
>>>>>
>>>>> What is apsc, qact, rc8a in the qci blocks? are the facility bits?
>>>>
>>>> Yes, facility bits concerning the AP instructions
>>>>
>>>
>>> According to the current AR document rc8a ain't a facility but bits
>>> 0-2 and 4-7 kind of are.
>>>
>>
>> Easy ( :) ) answer. Everything that is the CPU part should get into the
>> CPU model. Everything that is AP specific not. If APXA is not a CPU
>> facility, fine with me to leave it out.
>>
>> Ack to not rushing, but also ack to not leaving out important things.
>> Ack that this stuff is hard to ficure out.
>
> APXA is not a CPU part, it is a machine part (SIE) and a AP part 
> (QCI,TAPQ),
> it has no influence on CPU instructions but on the AP instructions.
> Consequently, if I understood the definition correctly, it should not 
> go in the CPU model.

The APXA bit returned via the PQAP(QCI) instruction indicates the APXA 
facility is
installed in the CPUs of the configuration. This means that the facility is
installed in one or more adjunct processors but not necessarily all. 
Given that
it indicates a CPU property, maybe it does belong in the CPU model?

>
> Regards,
> Pierre
>
>
>
>

