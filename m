Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6475DC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117B923EA1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117B923EA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeGEN36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:29:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753155AbeGEN34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:29:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65DTYnM087213
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 09:29:55 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1gw68mdr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:29:55 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 5 Jul 2018 07:29:54 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 07:29:51 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65DTmXf13107556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 06:29:48 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD3316A04F;
        Thu,  5 Jul 2018 07:29:48 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 244436A047;
        Thu,  5 Jul 2018 07:29:45 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.173.170])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 07:29:44 -0600 (MDT)
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
To:     Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>,
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
        pasic@linux.vnet.ibm.com, berrange@redhat.com, buendgen@de.ibm.com
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <753c5e17-c241-580d-6e3a-a3c3159d44a8@linux.ibm.com>
 <0f082b9e-a28c-4354-65eb-3e52304c711e@linux.ibm.com>
 <f3818b46-1cb2-6f2c-ef22-b40233ccdca7@linux.vnet.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 5 Jul 2018 09:29:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <f3818b46-1cb2-6f2c-ef22-b40233ccdca7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070513-0020-0000-0000-00000E3A1B6E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009313; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056915; UDB=6.00542217; IPR=6.00834835;
 MB=3.00022011; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-05 13:29:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070513-0021-0000-0000-0000622D0BC4
Message-Id: <0c04a507-291c-dc3d-41b4-a57cd99ae788@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 12:31 PM, Boris Fiuczynski wrote:
> On 07/03/2018 06:36 PM, Tony Krowiak wrote:
>> On 07/02/2018 07:10 PM, Halil Pasic wrote:
>>>
>>>
>>> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>>>> This patch provides documentation describing the AP architecture and
>>>> design concepts behind the virtualization of AP devices. It also
>>>> includes an example of how to configure AP devices for exclusive
>>>> use of KVM guests.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>
>>> I don't like the design of external interfaces except for:
>>> * cpu model features, and
>>> * reset handling.
>>>
>>> In particular:
>>>
>>> 1) The architecture is such that authorizing access (via APM, AQM 
>>> and ADM)
>>> to an AP queue that is currently not configured (e.g. the card not 
>>> physically
>>> plugged, or just configured off). That seems to be a perfectly 
>>> normal use
>>> case.
>>>
>>> Your assign operations however enforce that the resource is bound to 
>>> your
>>> driver, and thus the existence of the resource in the host.
>>>
>>> It is clear: we need to avoid passing trough resources to guests 
>>> that are not
>>> dedicated for this purpose (e.g. a queue utilized by zcrypt). But IMHO
>>> we need a different mechanism.
>>
>> Interesting that you wait until v6 to bring this up. I agree, this is 
>> a normal
>> use case, but there is currently no mechanism in the AP bus for 
>> drivers to
>> reserve devices that are not yet configured. There is proposed 
>> solution in the
>> works, but until such time that is available the only choice is to 
>> disallow
>> assignment of AP queues to a guest that are not bound to the vfio_ap 
>> device driver.
>>
>>>
>>>
>>> 2) I see no benefit in deferring the exclusivity check to 
>>> vfio_ap_mdev_open().
>>> The downside is however pretty obvious: management software is 
>>> notified about
>>> a 'bad configuration' only at an attempted guest start-up. And your 
>>> current QEMU
>>> patches are not very helpful in conveying this piece of information.
>>
>> It only becomes a 'bad configuration' if the two guests are started 
>> concurrently.
>> Is there value in being able to configure two mediated devices with 
>> the same
>> queue if the intent is to never run two guests using those mediated 
>> devices
>> simultaneously? If so, then the only time the exclusivity check can 
>> be done
>> is when the guest opens the mediated device. If not, then we can 
>> certainly
>> prevent multiple mediated devices from being assigned the same queue.
>>
>> In my view, while a mediated device is used by a guest, it is not a 
>> guest and
>> can be configured any way an administrator prefers. If we get 
>> concurrence
>> that doing an exclusivity check when an adapter or domain is assigned to
>> the mediated device, I'll make that change.
>>
>>>
>>>
>>> I've talked with Boris, and AFAIR he said this is not acceptable to 
>>> him (@Boris
>>> can you confirm).
>>
>> Then I suggest Boris participate in the review and explain why.
>
> [To make things a bit easier I am not going to address the aspect of 
> not-currently-exiting host resources.]
> Your current implementation does provide active configurations that 
> work with existing host resources. These need to be bound to the 
> vfio_ap driver.
> Libvirt allows to define objects (e.g. domains or networks). These are 
> just definitions and do NOT bind any resources. The defined resources 
> are bound once the definition is started.
> Currently I am assuming that an ap matrix device is defined in libvirt 
> outside of a libvirt domain (an ap definition). The mediated device of 
> the ap matrix device is used in a libvirt domain by referencing it via 
> its UID.
> When a libvirt domain is started the mediated device should exist and 
> be configured correctly as every other host resource.
> Therefore there needs to be something new in libvirt that allows one 
> to define, start, stop and undefine an ap matrix device. After a 
> define the ap definition for an ap matrix device would exist in 
> libvirt only.
> Once you start the ap definition the result should be a well 
> configured ready to be used mediated device representing the ap 
> definition which can be used configuration-error free by a libvirt 
> domain. Please not that the start of an ap definition is independent 
> from the start of a libvirt domain using the ap definition.
> Can you explain to me how that can be accomplished?

I can make a similar case for the mediated devices. Mediated devices 
play no role in guest configuration until a vfio-ap
device is specified on the QEMU command line when starting a guest. In 
other words, a mediated device configuration is
independent from the start of a guest using the mediated device. To 
answer your question then, if there are two or more
mediated devices with the same APQN(s) assigned, then only start one 
libvirt domain that uses one of these mediated
devices. This begs the question: Does libvirt preclude one from defining 
a domain that uses a host device (of any kind)
that must be dedicated to a single guest? If not, then isn't it 
incumbent upon the administrator to ensure he doesn't
start two guests with the same dedicated host device? Wouldn't that same 
logic apply to AP devices?

Having said that, I have no problem disallowing assignment of an AP 
queue to more than one mediated device, however; suppose
an administrator - for whatever reason - wants to create multiple 
mediated devices with the same APQN(s) assigned, but
never intends to run more than one guest using one of those mediated 
devices concurrently. The question is - as I have
asked in another response - is there a use case for allowing an 
administrator to configure multiple mediated devices with
the same APQN assigned?

>
>>>
>>>
>>> 3) We indicate the reason for failure due to a configuration problem 
>>> (exclusivity
>>> or resource allocation) via pr_err() that is  via kernel messages. I 
>>> don't think
>>> this is very tooling/management software friendly, and I hope we 
>>> don't expect admins
>>> to work with the sysfs interface long term. I mean the effects of 
>>> the admin actions
>>> are not very persistent. Thus if the interface is a painful one, we 
>>> are talking
>>> about potentially frequent pain.
>>
>> We have multiple layers of software, each with its own logging 
>> facilities. Figuring
>> out what went wrong when a guest fails to start is always a painful 
>> process IMHO.
>> Typically, one has to view the log for each component in the stack to 
>> figure out
>> what went wrong and often times, still can't figure it out. Of 
>> course, we can help
>> out here by having QEMU put out a better message when this problem 
>> occurs. But the
>> bottom line is, does the community think that allowing an 
>> administrator to configure
>> multiple mediated devices with the same queues have value? In other 
>> words, are
>> there potential use cases that would required this?
>>
>>>
>>>
>>> 4) If I were to act out the role of the administrator, I would 
>>> prefer to think of
>>> specifying or changing the access controls of a guest in respect to 
>>> AP (that is
>>> setting the AP matrix) as a single atomic operation -- which either 
>>> succeeds or fails.
>>
>> I don't understand what you are describing here. How would this be 
>> done? Are you
>> suggesting the admin somehow provides the masks en masse?
>>
>>>
>>>
>>> The operation should succeed for any valid configuration, and fail 
>>> for any invalid
>>> on.
>>>
>>> The current piecemeal approach seems even less fitting if we 
>>> consider changing the
>>> access controls of a running guest. AFAIK changing access controls 
>>> for a running
>>> guest is possible, and I don't see a reason why should we 
>>> artificially prohibit this.
>>
>> Setting and clearing bits in the APM/AQM/ADM of a guest's CRYCB is 
>> certainly possible,
>> but there is a lot more to it than merely setting and clearing bits. 
>> What you seem
>> to be describing here is hot plug/unplug which I stated in the cover 
>> letter is
>> forthcoming. It is currently prohibited for good reason.
>>
>>>
>>>
>>> I think the current sysfs interface for manipulating the matrix is 
>>> good for
>>> manual playing around, but I would prefer having an interface that 
>>> is better
>>> suited for programs (e.g. ioctl).
>>
>> That wouldn't be a problem, but do we have a use case for it?
>>
>>>
>>>
>>> Regards,
>>> Halil
>>
>>
>
>

