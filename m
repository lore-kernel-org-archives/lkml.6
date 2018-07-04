Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF9DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DE82086A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DE82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934230AbeGDIcE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:32:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932788AbeGDIcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:32:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w648TdLg115299
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 04:32:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0qmv7cq2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:32:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Wed, 4 Jul 2018 09:31:57 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 09:31:54 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w648VqUT43384918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 08:31:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AE3542041;
        Wed,  4 Jul 2018 11:32:18 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EA8F42042;
        Wed,  4 Jul 2018 11:32:15 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.79.32.113])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jul 2018 11:32:15 +0100 (BST)
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
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
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <49b11ac2-2230-ad74-1583-c6a57f8b31e3@linux.ibm.com>
 <6a330cae-2fe2-54df-edce-c3360117cf3c@linux.ibm.com>
 <89df60be-63d6-3ed9-4724-321e5b55d50d@linux.ibm.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Wed, 4 Jul 2018 10:31:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <89df60be-63d6-3ed9-4724-321e5b55d50d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070408-0028-0000-0000-000002D8075B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070408-0029-0000-0000-0000238F8D0B
Message-Id: <9e0c70b5-b8bf-e64b-19bc-c08765ccf397@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2018 16:56, Tony Krowiak wrote:
> On 07/03/2018 03:46 AM, Harald Freudenberger wrote:
>> On 02.07.2018 18:28, Halil Pasic wrote:
>>>
>>> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>>>> This patch provides documentation describing the AP architecture and
>>>> design concepts behind the virtualization of AP devices. It also
>>>> includes an example of how to configure AP devices for exclusive
>>>> use of KVM guests.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>> [..]
>>>> +
>>>> +Reserve APQNs for exclusive use of KVM guests
>>>> +---------------------------------------------
>>>> +The following block diagram illustrates the mechanism by which APQNs are
>>>> +reserved:
>>>> +
>>>> +                              +------------------+
>>>> +                 remove       |                  |   unbind
>>>> +         +------------------->+ cex4queue driver +<-----------+
>>>> +         |                    |                  |            |
>>>> +         |                    +------------------+            |
>>>> +         |                                                    |
>>>> +         |                                                    |
>>>> +         |                                                    |
>>>> ++--------+---------+ register +------------------+      +-----+------+
>>>> +|                  +<---------+                  | bind |            |
>>>> +|      ap_bus      |          |  vfio_ap driver  +<-----+    admin   |
>>>> +|                  +--------->+                  |      |            |
>>>> ++------------------+  probe   +---+--------+-----+      +------------+
>>>> +                                  |        |
>>>> +                           create |        | store APQN
>>>> +                                  |        |
>>>> +                                  v        v
>>>> +                              +---+--------+-----+
>>>> +                              |                  |
>>>> +                              |  matrix device   |
>>>> +                              |                  |
>>>> +                              +------------------+
>>>> +
>>>> +The process for reserving an AP queue for use by a KVM guest is:
>>>> +
>>>> +* The vfio-ap driver during its initialization will perform the following:
>>>> +  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
>>>> +  * Create the 'matrix' device in the 'vfio_ap' root
>>>> +  * Register the matrix device with the device core
>>>> +* Register with the ap_bus for AP queue devices of type 10 devices (CEX4 and
>>>> +  newer) and to provide the vfio_ap driver's probe and remove callback
>>>> +  interfaces. The reason why older devices are not supported is because there
>>>> +  are no systems available on which to test.
>>>> +* The admin unbinds queue cc.qqqq from the cex4queue device driver. This results
>>>> +  in the ap_bus calling the the device driver's remove interface which
>>>> +  unbinds the cc.qqqq queue device from the driver.
>>> What if the queue cc.qqqq is already in use? AFAIU unbind is almost as radical as
>>> pulling a cable. What is the proper procedure an admin should follow before doing
>>> the unbind?
>> What do you mean on this level with 'in use'? A unbind destroys the association
>> between device and driver. There is no awareness of 'in use' or 'not in use' on this
>> level. This is a hard unbind.
>
> According to my reading of the code, the remove callback for the AP queue drivers
> flushes the queue before it is disconnected from the driver. Do you concur Harald?
Yes, you are right. I checked this. The unbind triggers a zcrypt_cex4_queue_remove()
which calls ap_queue_remove() which calls ap_flush_queue().
The ap_flush_queue() function does:
- for all requests which are queued these are 'received' with -EAGAIN and thus
  the zcrypt api tries to re-schedule these requests on another apqn.
- for all requests which have been sent to the ap but there is no answer yet
  these are 'reveived' with -EAGAIN and the zcrypt_api tries to re-schedule these
  requests. [Well, this may in the end lead to some requests sent double...]
Looks like the unbind is handled in a smooth way :-)
>
>>>> +* The admin binds the cc.qqqq queue to the vfio_ap device driver. This results
>>>> +  in the ap_bus calling the device vfio_ap driver's probe interface to bind
>>>> +  queue cc.qqqq to the driver. The vfio_ap device driver will store the APQN for
>>>> +  the queue in the matrix device
>>>> +
>>> [..]
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>

