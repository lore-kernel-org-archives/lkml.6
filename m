Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B74C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7F62146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfBSTlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:41:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbfBSTlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:41:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JJenmP039676
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:41:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qrqx38p5x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:41:39 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 19 Feb 2019 19:41:38 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Feb 2019 19:41:35 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1JJfXVV28836052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 19:41:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DC9DAE056;
        Tue, 19 Feb 2019 19:41:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF26DAE053;
        Tue, 19 Feb 2019 19:41:32 +0000 (GMT)
Received: from [9.145.25.7] (unknown [9.145.25.7])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 19:41:32 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 8/9] s390: ap: Cleanup on removing the AP device
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-9-git-send-email-pmorel@linux.ibm.com>
 <e5c18c62-97bd-95d7-1fa4-8b149bd62e6d@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 19 Feb 2019 20:41:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e5c18c62-97bd-95d7-1fa4-8b149bd62e6d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021919-0020-0000-0000-00000318BE8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021919-0021-0000-0000-0000216A0653
Message-Id: <263d3aa9-700e-ad6e-0dfa-69190611d9c0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2019 00:36, Tony Krowiak wrote:
> On 2/14/19 8:51 AM, Pierre Morel wrote:
>> When the device is remove, we must make sure to
>> clear the interruption and reset the AP device.
>>
...snip...

>> @@ -74,6 +159,13 @@ static void vfio_ap_queue_dev_remove(struct 
>> ap_device *apdev)
>>       struct vfio_ap_queue *q;
>>       q = dev_get_drvdata(&apdev->device);
>> +    if (!q)
>> +        return;
>> +
>> +    vfio_ap_update_crycb(q);
> 
> The root user is warned in the Limitations section of the vfio-ap.txt
> doc delivered with the AP pass-through support warns that the
> administrator (i.e., root user) should ensure that AP devices are not
> removed without taking proper care to ensure they are not in use by a
> guest. I am currently working on a patch set to handle this, so this
> may simply get ripped out when those patches are integrated. That may
> very well be simultaneously with this patch series as I plan on posting
> those soon.
> 
> If this call is to remain, then you ought to update the vfio-ap.txt
> document to let users know that when queues are unbound, the guests
> will lose access to them unbeknown to the admin of the guest.

I do not see where is the problem, the admin should still take care the 
APQN are not in use by the guest when he does an unbind.

This just makes sure it is not used anymore by the guest when the admin 
rebound it to the host or another guest.

> 
>> +    vfio_ap_zapq(q);
> 
> One last thing. I've explained before that prior to the AP bus
> invoking this remove callback, it flushes and zeroizes the
> queue. Why do you insist it needs to be done again in the remove
> callback?

The problem is that the AP_BUS is not aware from the CRYCB and let the 
guest play with the queue.

The sequence an be like:

-> AP_BUS remove RESET the queue and zeroes with ZAPQ
-> AP_BUS call remove from driver
	- the APQN still belong to the guest !
		-> the guest issue a NQAP
===> We need to take the queue away from the guest
===> and we need to RESET the queue with ZAPQ and wait
      until no more message is in the queue
-> driver remove ends


Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

