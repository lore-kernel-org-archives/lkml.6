Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC32C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC3E20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfBUMKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:10:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbfBUMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:10:20 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LC63nC146180
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:10:19 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qst9nvafd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:10:18 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 21 Feb 2019 12:10:15 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 12:10:13 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LCAB5H21823580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 12:10:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BD794C046;
        Thu, 21 Feb 2019 12:10:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE7CD4C040;
        Thu, 21 Feb 2019 12:10:10 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 12:10:10 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
To:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
 <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
 <8e6853ba-12ed-a4f3-1263-0e15f715b644@linux.ibm.com>
 <6cc5b478-4678-9a82-b902-cc9aed22becf@linux.ibm.com>
 <20190220102731.4fca4f91.cohuck@redhat.com>
 <20190220135108.49f8f891@oc2783563651>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 21 Feb 2019 13:10:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220135108.49f8f891@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022112-0028-0000-0000-0000034B46D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022112-0029-0000-0000-000024098B28
Message-Id: <fd574b7b-7c2f-eeea-1d53-caadcd2fed48@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2019 13:51, Halil Pasic wrote:
> On Wed, 20 Feb 2019 10:27:31 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Tue, 19 Feb 2019 22:31:17 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> On 19/02/2019 19:52, Tony Krowiak wrote:
>>>> On 2/18/19 1:08 PM, Pierre Morel wrote:
>>>>> Libudev relies on having a subsystem link for non-root devices. To

...snip...

>>>>> +
>>>>> +static struct device_driver matrix_driver = {
>>>>> +    .name = "vfio_ap",
>>>>
>>>> This is the same name used for the original device driver. I think
>>>> this driver ought to have a different name to avoid confusion.
>>>> How about vfio_ap_matrix or some other name to differentiate the
>>>> two.
>>>
>>> I would like too, but changing this will change the path to the mediated
>>> device supported type.
>>
>> Yes, we don't want to change that.
>>
> 
> Nod.

However if I cannot change the driver name, I can change the bus name to 
matrix.
At least one less "vfio_ap" name

> 
>>>
>>>
>>>>    
>>>>> +    .bus = &matrix_bus,
>>>>> +    .probe = matrix_probe,
>>>>
>>>> I would add:
>>>>       .suppress_bind_attrs = true;
>>>>
>>>> This will remove the sysfs bind/unbind interfaces. Since there is only
>>>> one matrix device and it's lifecycle is controlled herein, there is no
>>>> sense in allowing a root user to bind/unbind it.
>>>>    
>>>
>>> OTOH bind/unbind has no impact.
>>> If no one else ask for this I will not change what has already been
>>> reviewed by Conny and Christian.
>>
>> As we only have one driver, it does not really make sense anyway.
>>
> 
> I see this as a reason to suppress_bind_attrs. It is much easier than to
> think about what should happen when one unbinds the matrix device from
> the vfio_ap driver on the vfio_ap bus. With the code as is it seems to
> just keep working as if nothing happened.
> And /sys/devices/vfio_ap/matrix/mdev_supported_types/ referencing the
> name of the driver that is already gone sounds a bit weird.
> 
> Regards,
> Halil
> 

If there is no objection I will do this,
It seems more logical to me too.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

