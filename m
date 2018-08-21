Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C1CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CF12183D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CF12183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeHUWnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 18:43:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbeHUWnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 18:43:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LJ4IKq107336
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 15:21:40 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m0pp6n7aa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 15:21:40 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 21 Aug 2018 15:21:39 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Aug 2018 15:21:37 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7LJLZcn50659466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 19:21:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 113C5B2064;
        Tue, 21 Aug 2018 15:20:42 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7510B2065;
        Tue, 21 Aug 2018 15:20:40 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.80.223.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Aug 2018 15:20:40 -0400 (EDT)
Subject: Re: [PATCH v9 22/22] s390: doc: detailed specifications for AP
 virtualization
To:     Cornelia Huck <cohuck@redhat.com>
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
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820180359.38cc4af3.cohuck@redhat.com>
 <a305a39b-1196-ae64-97fd-f970387d82d4@linux.ibm.com>
 <20180821181329.1610c3b3.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 21 Aug 2018 15:21:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180821181329.1610c3b3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082119-0068-0000-0000-0000032CFA85
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009587; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01076853; UDB=6.00555155; IPR=6.00856828;
 MB=3.00022852; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-21 19:21:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082119-0069-0000-0000-000045780351
Message-Id: <ab821bc3-4951-3f05-a75e-005fb275d07b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2018 12:13 PM, Cornelia Huck wrote:
> On Mon, 20 Aug 2018 16:16:15 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 08/20/2018 12:03 PM, Cornelia Huck wrote:
>>> On Mon, 13 Aug 2018 17:48:19 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>> +AP Architectural Overview:
>>>> +=========================
>>>> +To facilitate the comprehension of the design, let's start with some
>>>> +definitions:
>>>> +
>>>> +* AP adapter
>>>> +
>>>> +  An AP adapter is an IBM Z adapter card that can perform cryptographic
>>>> +  functions. There can be from 0 to 256 adapters assigned to an LPAR. Adapters
>>>> +  assigned to the LPAR in which a linux host is running will be available to
>>>> +  the linux host. Each adapter is identified by a number from 0 to 255. When
>>>> +  installed, an AP adapter is accessed by AP instructions executed by any CPU.
>>>> +
>>>> +  The AP adapter cards are assigned to a given LPAR via the system's Activation
>>>> +  Profile which can be edited via the HMC. When the system is IPL'd, the AP bus
>>> There's lots of s390 jargon in here... but one hopes that someone
>>> trying to understand AP is already familiar with the basics...
>> I'm not quite sure how one can describe s390-specific devices that can
>> be installed
>> only on an s390 system without using s390 jargon. I would think that one
>> who is
>> administering a linux host or guest running on an s390 system would have
>> some
>> basic knowledge of s390. If you have any suggestions, I'd be happy to
>> entertain them.
> I fear the jargon is mostly unavoidable :(
>
>>>> +* AP Instructions:
>>>> +
>>>> +  There are three AP instructions:
>>>> +
>>>> +  * NQAP: to enqueue an AP command-request message to a queue
>>>> +  * DQAP: to dequeue an AP command-reply message from a queue
>>>> +  * PQAP: to administer the queues
>>> So, NQAP/DQAP need usage domains, while PQAP needs a control domain? Or
>>> is it that all of them need usage domains, but PQAP can target a control
>>> domain as well?
>> All AP instructions - the lone exception being the PQAP(QCI) subfunction -
>> identify the usage domain that is the target of the instruction. I think
>> using the term 'control domain' is the source of much confusion. It makes
>> it seem as if there are two types of domains that serve different purposes.
>> That is simply not true. A domain is a partition within an AP adapter that
>> can process AP command request messages. All AP commands are sent to a
>> domain. Configuring a domain as a usage domain means it can be used to
>> process AP commands; in other words, it can be the target of an AP
>> instruction. Configuring a domain as a control domain means it can be
>> changed by an AP command. AP commands that change a domain are sent to
>> a usage domain, but the domain to be changed is specified in the payload
>> of the AP command message. The domain thus specified must be
>> identified via the AP configuration as a control domain, or the AP command
>> will be rejected.
> Yes, the 'control domain' term is a source of much confusion :(
>
>>> [I don't want to dive deeply into the AP architecture here, just far
>>> enough to really understand the design implications.]
>> Are you suggesting some of the above should be removed? If so, what?
> Not removed. What about an explanation like the following somewhere:
>
> "AP instructions identify the domain that is targeted to process the
> command: This must be one of the usage domains. They may modify a
> domain that is not one of the usage domains, but the modified domain
> must be one of the control domains."
>
> I hope that is both correct and understandable ;)

Yes, it is both correct and understandable.

>
>>> Does the SIE complain if you specify a control
>>> domain that the host does not have access to (I'd guess so)?
>> The SIE does not complain if you specify a domain to which the host - or a
>> lower level guest - does not have access. The firmware performs a logical
>> AND of the guest's and hosts's - or lower level guest's - APMs, AQMs and
>> ADMs
>> to create effective masks EAPM, EAQM and EADM. Only devices corresponding to
>> the bits set in the EAPM, EAQM and EADM will be accessible by the guest.
> OK, so the guest effectively won't see the domain. That makes sense.

It is one of the positive aspects of the architecture.

>
>>>   
>>>> +
>>>> +The APQNs can provide secure key functionality - i.e., a private key is stored
>>>> +on the adapter card for each of its domains - so each APQN must be assigned to
>>>> +at most one guest or to the linux host.
>>>> +
>>>> +   Example 1: Valid configuration:
>>>> +   ------------------------------
>>>> +   Guest1: adapters 1,2  domains 5,6
>>>> +   Guest2: adapter  1,2  domain 7
>>>> +
>>>> +   This is valid because both guests have a unique set of APQNs: Guest1 has
>>>> +   APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQNs (1,7) and (2,7).
>>>> +
>>>> +   Example 2: Invalid configuration:
>>>> +   Guest1: adapters 1,2  domains 5,6
>>>> +   Guest2: adapter  1    domains 6,7
>>>> +
>>>> +   This is an invalid configuration because both guests have access to
>>>> +   APQN (1,6).
>>> So, the adapters or the domains can overlap , but the cross product
>>> mustn't? If I had
>>>
>>> Guest1: adapters 1,2 domains 5,6
>>> Guest2: adapters 3,4 domains 5,6
>>>
>>> would that be fine?
>> Yes, that would be fine because Guest1 would have access to APQNs
>> (1,5), (1,6), (2,5) and (2,6) while Guest2 would have access to
>> (3,5), (3,6), (4,5) AND (4,6), but neither would have access to
>> the same APQN.
> Might be a good idea to add this as an additional example.

Will do

>
>>> Is there any rule about shared control domains?
>> AFAIK there isn't, but I will consult with Reinhard about that.
>>
>>> (...)
>>>   
>>>> +Limitations
>>>> +===========
>>>> +* The KVM/kernel interfaces do not provide a way to prevent unbinding an AP
>>>> +  queue that is still assigned to a mediated device. Even if the device
>>>> +  'remove' callback returns an error, the device core detaches the AP
>>>> +  queue from the VFIO AP driver. It is therefore incumbent upon the
>>>> +  administrator to make sure there is no mediated device to which the
>>>> +  APQN - for the AP queue being unbound - is assigned.
>>>> +
>>>> +* Hot plug/unplug of AP devices is not supported for guests.
>>> Not sure what that sentence means. Adding/removing devices by the
>>> hypervisor is not supported? Or some guest actions, respectively
>>> injecting notifications that would trigger some actions on the real
>>> hardware?
>> No means is provided to modify a guest's AP matrix - i.e., APM, AQM
>> and ADM - while a guest is running. Once a guest is running, its AP
>> configuration can not be changed dynamically.
>>
>>> Do you want to add (some of) this in the future?
>> Yes, we plan to introduce dynamic configurations in future releases.
> What about the following sentence:
>
> "Dynamically modifying the AP matrix for a running guest (which would
> amount to hot(un)plug of AP devices for the guest) is currently not
> supported."

Sounds fine to me.

>
>>>   
>>>> +
>>>> +* Live guest migration is not supported for guests using AP devices.
>>> Migration and vfio is an interesting area in general :) Would be great
>>> if vfio-ap could benefit from any generic efforts in that area, but
>>> that probably requires that someone with access to documentation and
>>> hardware keeps an eye on developments.
>> I have briefly looked at some of the articles talking about live migration
>> of passthrough devices, but nothing seemed applicable to AP architecture.
> Most of the approaches to live migration of vfio devices are focused on
> pci devices; even ccw devices have different needs. Any halfway generic
> approach would need a common part and a backend-specific part anyway, I
> think.

Yes, that would seem to be the case.

>
>>   From my limited perspective, it would seem that architectural changes
>> would have to be implemented to fully support live migration of in-process
>> AP queues.
>  From what I have seen of the AP virtualization architecture, this may
> very well be the case. I'll keep AP in the back of my head, but it's
> probably better to focus on the easier targets first.

That has been our goal from the start.

>

