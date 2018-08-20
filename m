Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D4C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D9A20C0F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D9A20C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeHTXda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:33:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726585AbeHTXda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:33:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7KK8Z8d081307
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 16:16:28 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m00bmsvr9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 16:16:28 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 20 Aug 2018 14:16:27 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Aug 2018 14:16:23 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7KKGKhF9110012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Aug 2018 13:16:20 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A92D6A04D;
        Mon, 20 Aug 2018 14:16:20 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17EF66A047;
        Mon, 20 Aug 2018 14:16:15 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.233.6])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Aug 2018 14:16:15 -0600 (MDT)
Subject: Re: [PATCH v9 22/22] s390: doc: detailed specifications for AP
 virtualization
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
 <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820180359.38cc4af3.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 20 Aug 2018 16:16:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180820180359.38cc4af3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082020-0036-0000-0000-00000A2669D9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009580; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01076397; UDB=6.00554879; IPR=6.00856367;
 MB=3.00022832; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-20 20:16:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082020-0037-0000-0000-000048A6F1B2
Message-Id: <a305a39b-1196-ae64-97fd-f970387d82d4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808200207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 12:03 PM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:19 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> This patch provides documentation describing the AP architecture and
>> design concepts behind the virtualization of AP devices. It also
>> includes an example of how to configure AP devices for exclusive
>> use of KVM guests.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   Documentation/s390/vfio-ap.txt |  615 ++++++++++++++++++++++++++++++++++++++++
>>   MAINTAINERS                    |    1 +
>>   2 files changed, 616 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/s390/vfio-ap.txt
>>
>> +AP Architectural Overview:
>> +=========================
>> +To facilitate the comprehension of the design, let's start with some
>> +definitions:
>> +
>> +* AP adapter
>> +
>> +  An AP adapter is an IBM Z adapter card that can perform cryptographic
>> +  functions. There can be from 0 to 256 adapters assigned to an LPAR. Adapters
>> +  assigned to the LPAR in which a linux host is running will be available to
>> +  the linux host. Each adapter is identified by a number from 0 to 255. When
>> +  installed, an AP adapter is accessed by AP instructions executed by any CPU.
>> +
>> +  The AP adapter cards are assigned to a given LPAR via the system's Activation
>> +  Profile which can be edited via the HMC. When the system is IPL'd, the AP bus
> There's lots of s390 jargon in here... but one hopes that someone
> trying to understand AP is already familiar with the basics...

I'm not quite sure how one can describe s390-specific devices that can 
be installed
only on an s390 system without using s390 jargon. I would think that one 
who is
administering a linux host or guest running on an s390 system would have 
some
basic knowledge of s390. If you have any suggestions, I'd be happy to 
entertain them.

>
>> +  module is loaded and detects the AP adapter cards assigned to the LPAR. The AP
>> +  bus creates a sysfs device for each adapter as they are detected. For example,
>> +  if AP adapters 4 and 10 (0x0a) are assigned to the LPAR, the AP bus will
>> +  create the following sysfs entries:
>> +
>> +    /sys/devices/ap/card04
>> +    /sys/devices/ap/card0a
>> +
>> +  Symbolic links to these devices will also be created in the AP bus devices
>> +  sub-directory:
>> +
>> +    /sys/bus/ap/devices/[card04]
>> +    /sys/bus/ap/devices/[card04]
>> +
>> +* AP domain
>> +
>> +  An adapter is partitioned into domains. Each domain can be thought of as
>> +  a set of hardware registers for processing AP instructions. An adapter can
>> +  hold up to 256 domains. Each domain is identified by a number from 0 to 255.
>> +  Domains can be further classified into two types:
>> +
>> +    * Usage domains are domains that can be accessed directly to process AP
>> +      commands.
>> +
>> +    * Control domains are domains that are accessed indirectly by AP
>> +      commands sent to a usage domain to control or change the domain; for
>> +      example, to set a secure private key for the domain.
>> +
>> +  The AP usage and control domains are assigned to a given LPAR via the system's
>> +  Activation Profile which can be edited via the HMC. When the system is IPL'd,
>> +  the AP bus module is loaded and detects the AP usage and control domains
>> +  assigned to the LPAR. The domain number of each usage domain will be coupled
>> +  with the adapter number of each AP adapter assigned to the LPAR to identify
>> +  the AP queues (see AP Queue section below). The domain number of each control
>> +  domain will be represented in a bitmask and stored in a sysfs file
>> +  /sys/bus/ap/ap_control_domain_mask created by the bus. The bits in the mask,
>> +  from most to least significant bit, correspond to domains 0-255.
>> +
>> +  A domain may be assigned to a system as both a usage and control domain, or
>> +  as a control domain only. Consequently, all domains assigned as both a usage
>> +  and control domain can both process AP commands as well as be changed by an AP
>> +  command sent to any usage domain assigned to the same system. Domains assigned
>> +  only as control domains can not process AP commands but can be changed by AP
>> +  commands sent to any usage domain assigned to the system.
> I'm struggling a bit with this paragraph. Does that mean that you can
> use control domains as the target of an instruction changing
> configuration on the system? (Or on the VM, if they are listed in the
> relevant control block?)

Only usage domains can be the target of an AP command request message. 
If an AP message
sent to a usage domain is a request to change a domain, the number of 
the domain to
be changed will be contained in the command request message. That domain 
number
must be configured as a control domain or the AP command will fail.

The fact you are struggling with understanding the last paragraph leads 
me to believe
it should probably be rewritten, or eliminated. Allow me to reconsider 
this section.

>
>> +
>> +* AP Queue
>> +
>> +  An AP queue is the means by which an AP command-request message is sent to a
>> +  usage domain inside a specific adapter. An AP queue is identified by a tuple
>> +  comprised of an AP adapter ID (APID) and an AP queue index (APQI). The
>> +  APQI corresponds to a given usage domain number within the adapter. This tuple
>> +  forms an AP Queue Number (APQN) uniquely identifying an AP queue. AP
>> +  instructions include a field containing the APQN to identify the AP queue to
>> +  which the AP command-request message is to be sent for processing.
>> +
>> +  The AP bus will create a sysfs device for each APQN that can be derived from
>> +  the cross product of the AP adapter and usage domain numbers detected when the
>> +  AP bus module is loaded. For example, if adapters 4 and 10 (0x0a) and usage
>> +  domains 6 and 71 (0x47) are assigned to the LPAR, the AP bus will create the
>> +  following sysfs entries:
>> +
>> +    /sys/devices/ap/card04/04.0006
>> +    /sys/devices/ap/card04/04.0047
>> +    /sys/devices/ap/card0a/0a.0006
>> +    /sys/devices/ap/card0a/0a.0047
>> +
>> +  The following symbolic links to these devices will be created in the AP bus
>> +  devices subdirectory:
>> +
>> +    /sys/bus/ap/devices/[04.0006]
>> +    /sys/bus/ap/devices/[04.0047]
>> +    /sys/bus/ap/devices/[0a.0006]
>> +    /sys/bus/ap/devices/[0a.0047]
>> +
>> +* AP Instructions:
>> +
>> +  There are three AP instructions:
>> +
>> +  * NQAP: to enqueue an AP command-request message to a queue
>> +  * DQAP: to dequeue an AP command-reply message from a queue
>> +  * PQAP: to administer the queues
> So, NQAP/DQAP need usage domains, while PQAP needs a control domain? Or
> is it that all of them need usage domains, but PQAP can target a control
> domain as well?

All AP instructions - the lone exception being the PQAP(QCI) subfunction -
identify the usage domain that is the target of the instruction. I think
using the term 'control domain' is the source of much confusion. It makes
it seem as if there are two types of domains that serve different purposes.
That is simply not true. A domain is a partition within an AP adapter that
can process AP command request messages. All AP commands are sent to a
domain. Configuring a domain as a usage domain means it can be used to
process AP commands; in other words, it can be the target of an AP
instruction. Configuring a domain as a control domain means it can be
changed by an AP command. AP commands that change a domain are sent to
a usage domain, but the domain to be changed is specified in the payload
of the AP command message. The domain thus specified must be
identified via the AP configuration as a control domain, or the AP command
will be rejected.

>
> [I don't want to dive deeply into the AP architecture here, just far
> enough to really understand the design implications.]

Are you suggesting some of the above should be removed? If so, what?

>
>> +
>> +AP and SIE:
>> +==========
>> +Let's now take a look at how AP instructions executed on a guest are interpreted
>> +by the hardware.
>> +
>> +A satellite control block called the Crypto Control Block (CRYCB) is attached to
>> +our main hardware virtualization control block. The CRYCB contains three fields
>> +to identify the adapters, usage domains and control domains assigned to the KVM
>> +guest:
>> +
>> +* The AP Mask (APM) field is a bit mask that identifies the AP adapters assigned
>> +  to the KVM guest. Each bit in the mask, from most significant to least
>> +  significant bit, corresponds to an APID from 0-255. If a bit is set, the
>> +  corresponding adapter is valid for use by the KVM guest.
>> +
>> +* The AP Queue Mask (AQM) field is a bit mask identifying the AP usage domains
>> +  assigned to the KVM guest. Each bit in the mask, from most significant to
>> +  least significant bit, corresponds to an AP queue index (APQI) from 0-255. If
>> +  a bit is set, the corresponding queue is valid for use by the KVM guest.
>> +
>> +* The AP Domain Mask field is a bit mask that identifies the AP control domains
>> +  assigned to the KVM guest. The ADM bit mask controls which domains can be
>> +  changed by an AP command-request message sent to a usage domain from the
>> +  guest. Each bit in the mask, from least significant to most significant bit,
>> +  corresponds to a domain from 0-255. If a bit is set, the corresponding domain
>> +  can be modified by an AP command-request message sent to a usage domain
>> +  configured for the KVM guest.
> OK, that seems to imply that you modify a control domain by sending a
> request to (any) usage domain?

That is a true statement. I reality, you are just modifying a domain. 
The control
domain designation identifies a domain that can be controlled as opposed 
to used.
Maybe if you think of these bitmasks as access control masks it would 
clarify
things. The AQM specifies domains to which AP commands can be sent and the
ADM specifies domains that can be changed by an AP command.

>   I do not doubt that, but the whole
> architecture is really confusing :)

I couldn't agree more. It took me a while to wrap my head around it.

>
>> +
>> +If you recall from the description of an AP Queue, AP instructions include
>> +an APQN to identify the AP adapter and AP queue to which an AP command-request
>> +message is to be sent (NQAP and PQAP instructions), or from which a
>> +command-reply message is to be received (DQAP instruction). The validity of an
>> +APQN is defined by the matrix calculated from the APM and AQM; it is the
>> +cross product of all assigned adapter numbers (APM) with all assigned queue
>> +indexes (AQM). For example, if adapters 1 and 2 and usage domains 5 and 6 are
>> +assigned to a guest, the APQNs (1,5), (1,6), (2,5) and (2,6) will be valid for
>> +the guest.
> How does the control domain mask interact with that?

The control domain mask does not interact with the other two masks. It
merely specifies which domains can be modified by an AP command. In fact,
the ADM can have bits set that are not included in the AQM; in other words,
a guest can be used to control domains that it can not use.

> Can you send a
> command to an APQN valid for the guest to modify any control domain
> specified in the mask?

Yes.

> Does the SIE complain if you specify a control
> domain that the host does not have access to (I'd guess so)?

The SIE does not complain if you specify a domain to which the host - or a
lower level guest - does not have access. The firmware performs a logical
AND of the guest's and hosts's - or lower level guest's - APMs, AQMs and 
ADMs
to create effective masks EAPM, EAQM and EADM. Only devices corresponding to
the bits set in the EAPM, EAQM and EADM will be accessible by the guest.

>
>> +
>> +The APQNs can provide secure key functionality - i.e., a private key is stored
>> +on the adapter card for each of its domains - so each APQN must be assigned to
>> +at most one guest or to the linux host.
>> +
>> +   Example 1: Valid configuration:
>> +   ------------------------------
>> +   Guest1: adapters 1,2  domains 5,6
>> +   Guest2: adapter  1,2  domain 7
>> +
>> +   This is valid because both guests have a unique set of APQNs: Guest1 has
>> +   APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQNs (1,7) and (2,7).
>> +
>> +   Example 2: Invalid configuration:
>> +   Guest1: adapters 1,2  domains 5,6
>> +   Guest2: adapter  1    domains 6,7
>> +
>> +   This is an invalid configuration because both guests have access to
>> +   APQN (1,6).
> So, the adapters or the domains can overlap , but the cross product
> mustn't? If I had
>
> Guest1: adapters 1,2 domains 5,6
> Guest2: adapters 3,4 domains 5,6
>
> would that be fine?

Yes, that would be fine because Guest1 would have access to APQNs
(1,5), (1,6), (2,5) and (2,6) while Guest2 would have access to
(3,5), (3,6), (4,5) AND (4,6), but neither would have access to
the same APQN.

>
> Is there any rule about shared control domains?

AFAIK there isn't, but I will consult with Reinhard about that.

>
> (...)
>
>> +Limitations
>> +===========
>> +* The KVM/kernel interfaces do not provide a way to prevent unbinding an AP
>> +  queue that is still assigned to a mediated device. Even if the device
>> +  'remove' callback returns an error, the device core detaches the AP
>> +  queue from the VFIO AP driver. It is therefore incumbent upon the
>> +  administrator to make sure there is no mediated device to which the
>> +  APQN - for the AP queue being unbound - is assigned.
>> +
>> +* Hot plug/unplug of AP devices is not supported for guests.
> Not sure what that sentence means. Adding/removing devices by the
> hypervisor is not supported? Or some guest actions, respectively
> injecting notifications that would trigger some actions on the real
> hardware?

No means is provided to modify a guest's AP matrix - i.e., APM, AQM
and ADM - while a guest is running. Once a guest is running, its AP
configuration can not be changed dynamically.

>
> Do you want to add (some of) this in the future?

Yes, we plan to introduce dynamic configurations in future releases.

>
>> +
>> +* Live guest migration is not supported for guests using AP devices.
> Migration and vfio is an interesting area in general :) Would be great
> if vfio-ap could benefit from any generic efforts in that area, but
> that probably requires that someone with access to documentation and
> hardware keeps an eye on developments.

I have briefly looked at some of the articles talking about live migration
of passthrough devices, but nothing seemed applicable to AP architecture.
 From my limited perspective, it would seem that architectural changes
would have to be implemented to fully support live migration of in-process
AP queues.

>
>> \ No newline at end of file
> Please add one :)

Will do.

>

