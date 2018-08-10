Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F49C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A782189B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A782189B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeHJSza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:55:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728997AbeHJSz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:55:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7AGOo2S104993
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 12:24:57 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ksayjrpdk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 12:24:56 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 10 Aug 2018 12:24:55 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 Aug 2018 12:24:52 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7AGOoPH19202462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Aug 2018 16:24:50 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FB4FAC059;
        Fri, 10 Aug 2018 12:25:17 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F164AC060;
        Fri, 10 Aug 2018 12:25:15 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.80.230.146])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 10 Aug 2018 12:25:15 -0400 (EDT)
Subject: Re: [PATCH v8 17/22] s390: vfio-ap: zeroize the AP queues.
To:     Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
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
 <1533739472-7172-18-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180810111445.015fcf2a.cohuck@redhat.com>
 <fa85257e-fda1-8f1d-aa7c-c98e74196d37@linux.ibm.com>
 <20180810131648.4fab1d7a.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 10 Aug 2018 12:24:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180810131648.4fab1d7a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081016-0068-0000-0000-00000326D4D7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009518; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01071704; UDB=6.00551954; IPR=6.00851495;
 MB=3.00022637; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-10 16:24:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081016-0069-0000-0000-000045587C4F
Message-Id: <14983b58-f53b-8bd9-179e-29b9a69c21d8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-10_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808100177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2018 07:16 AM, Cornelia Huck wrote:
> On Fri, 10 Aug 2018 12:49:08 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 10/08/2018 11:14, Cornelia Huck wrote:
>>> On Wed,  8 Aug 2018 10:44:27 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>   
>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>
>>>> Let's call PAPQ(ZAPQ) to zeroize a queue:
>>>>
>>>> * For each queue configured for a mediated matrix device
>>>>     when it is released.
>>>>
>>>> Zeroizing a queue resets the queue, clears all pending
>>>> messages for the queue entries and disables adapter interruptions
>>>> associated with the queue.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>    drivers/s390/crypto/vfio_ap_ops.c     |   29 ++++++++++++++++++++++++++++-
>>>>    drivers/s390/crypto/vfio_ap_private.h |   25 +++++++++++++++++++++++++
>>>>    2 files changed, 53 insertions(+), 1 deletions(-)
>>>>
>>>> @@ -788,7 +812,10 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>>>    {
>>>>    	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>>>    
>>>> -	kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>> +	if (matrix_mdev->kvm)
>>>> +		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>> Confused. Why is the check for matrix_mdev->kvm added here?
>> When using the KVM notifier we can get two notifications:
>> -> KVM is here / is comming
>> -> KVM is not here / disappearing
>>
>> In the first case we initialize matrix_mdev->kvm with a pointer to KVM
>> In the second case we nullify the pointer.
>>
>> During the open of the mediated device, the guest should have been started
>> or we refuse to start.
>>
>> During the close of the mediated device, the guest should be there, but
>> we have no certitude that the guest did not disappear before the VFIO
>> file being closed.
>> Since we do not allow multiple guests using the same mediated device
>> this case should not happen with QEMU. But I am not sure that
>> a rogue user program could not stop KVM before closing the VFIO
>> mediated device.
> I'm not sure why the check is introduced in this patch, though. But
> maybe I just need weekend :)

Good catch, it belongs in patch 15 where the function is introduced.
Is that the only reason for your objection?

>
>> Maybe Alex can confirm this point, if not we can remove the test.


