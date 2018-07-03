Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645A5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D013204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D013204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeGCPBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:01:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753272AbeGCPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:01:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63EwpCL026815
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 11:01:06 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0b40guqc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 11:01:04 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 3 Jul 2018 11:01:03 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 11:01:00 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63F0wHW56819766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:00:58 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 571ED28059;
        Tue,  3 Jul 2018 11:00:31 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A7E42805C;
        Tue,  3 Jul 2018 11:00:30 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.218])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 11:00:30 -0400 (EDT)
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
To:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <49b11ac2-2230-ad74-1583-c6a57f8b31e3@linux.ibm.com>
 <6a330cae-2fe2-54df-edce-c3360117cf3c@linux.ibm.com>
 <13998e79-9bae-5c55-b83d-85e6db8d3b99@linux.ibm.com>
 <20180703135205.2ebb107f.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 3 Jul 2018 11:00:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180703135205.2ebb107f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070315-0072-0000-0000-0000037961C0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009301; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055985; UDB=6.00541659; IPR=6.00833908;
 MB=3.00021977; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 15:01:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070315-0073-0000-0000-000048941694
Message-Id: <2629b201-8eeb-d726-176f-af588e7d569f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 07:52 AM, Cornelia Huck wrote:
> On Tue, 3 Jul 2018 11:22:10 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> On 07/03/2018 09:46 AM, Harald Freudenberger wrote:
>>> On 02.07.2018 18:28, Halil Pasic wrote:
>>>>
>>>> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>>>>> This patch provides documentation describing the AP architecture and
>>>>> design concepts behind the virtualization of AP devices. It also
>>>>> includes an example of how to configure AP devices for exclusive
>>>>> use of KVM guests.
>>>>>
>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>> ---
>>>> [..]
>>>>> +
>>>>> +Reserve APQNs for exclusive use of KVM guests
>>>>> +---------------------------------------------
>>>>> +The following block diagram illustrates the mechanism by which APQNs are
>>>>> +reserved:
>>>>> +
>>>>> +                              +------------------+
>>>>> +                 remove       |                  |   unbind
>>>>> +         +------------------->+ cex4queue driver +<-----------+
>>>>> +         |                    |                  |            |
>>>>> +         |                    +------------------+            |
>>>>> +         |                                                    |
>>>>> +         |                                                    |
>>>>> +         |                                                    |
>>>>> ++--------+---------+ register +------------------+      +-----+------+
>>>>> +|                  +<---------+                  | bind |            |
>>>>> +|      ap_bus      |          |  vfio_ap driver  +<-----+    admin   |
>>>>> +|                  +--------->+                  |      |            |
>>>>> ++------------------+  probe   +---+--------+-----+      +------------+
>>>>> +                                  |        |
>>>>> +                           create |        | store APQN
>>>>> +                                  |        |
>>>>> +                                  v        v
>>>>> +                              +---+--------+-----+
>>>>> +                              |                  |
>>>>> +                              |  matrix device   |
>>>>> +                              |                  |
>>>>> +                              +------------------+
>>>>> +
>>>>> +The process for reserving an AP queue for use by a KVM guest is:
>>>>> +
>>>>> +* The vfio-ap driver during its initialization will perform the following:
>>>>> +  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
>>>>> +  * Create the 'matrix' device in the 'vfio_ap' root
>>>>> +  * Register the matrix device with the device core
>>>>> +* Register with the ap_bus for AP queue devices of type 10 devices (CEX4 and
>>>>> +  newer) and to provide the vfio_ap driver's probe and remove callback
>>>>> +  interfaces. The reason why older devices are not supported is because there
>>>>> +  are no systems available on which to test.
>>>>> +* The admin unbinds queue cc.qqqq from the cex4queue device driver. This results
>>>>> +  in the ap_bus calling the the device driver's remove interface which
>>>>> +  unbinds the cc.qqqq queue device from the driver.
>>>> What if the queue cc.qqqq is already in use? AFAIU unbind is almost as radical as
>>>> pulling a cable. What is the proper procedure an admin should follow before doing
>>>> the unbind?
>>> What do you mean on this level with 'in use'? A unbind destroys the association
>>> between device and driver. There is no awareness of 'in use' or 'not in use' on this
>>> level. This is a hard unbind.
>>>>   
>>
>> Let me try to invoke the DASD analogy. If one for some reason wants to detach
>> a DASD the procedure to follow seems to be (see
>> https://www.ibm.com/support/knowledgecenter/en/linuxonibm/com.ibm.linux.z.lgdd/lgdd_t_dasd_online.html)
>> the following:
>> 1) Unmount.
>> 2) Offline possibly using safe_offline.
>> 3) Detach.
>>
>> Detaching a disk that is currently doing I/O asks for trouble, so the admin is encouraged
>> to make sure there is no pending I/O.
> I don't think we can use dasd (block devices) as a good analogy for
> every kind of device (for starters, consider network devices).
>
>> In case of AP you can interpret my 'in use' as the queue is not empty. In my understanding
>> unbind is supposed to be hard (I used the word radical). That's why I compared it to pulling
>> a cable. So that's why I ask is there stuff the admin is supposed to do before doing the
>> unbind.
> Are you asking for a kind of 'quiescing' operation? I would hope that
> the crypto drivers already can deal with that via flushing the queue,
> not allowing new requests, or whatever. This is not the block device
> case.

As I stated in Message ID: 
<89df60be-63d6-3ed9-4724-321e5b55d50d@linux.ibm.com>,
I believe the queue is flushed when the remove callback is invoked on the
driver.

>
> Anyway, this is an administrative issue. If you don't have a clear
> concept which devices are for host usage and which for guest usage, you
> already have problems.
>
> Speaking of administrative issues, is there libvirt support for vfio-ap
> under development? It would be helpful to validate the approach.

There is libvirt support under development although it is not very far
along at this point.

>

