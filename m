Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130C9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0931208D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbeLNOIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:08:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730046AbeLNOIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:08:16 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBEE5ZFx082958
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:08:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pcdykg4v4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:08:15 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 14 Dec 2018 14:08:12 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 14:08:10 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBEE88n99044430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 14:08:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 650FAAE055;
        Fri, 14 Dec 2018 14:08:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C8CDAE056;
        Fri, 14 Dec 2018 14:08:08 +0000 (GMT)
Received: from [9.145.23.224] (unknown [9.145.23.224])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 14:08:07 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 6/6] vfio: ccw: serialize the write system calls
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     pasic@linux.vnet.ibm.com, farman@linux.ibm.com,
        alifm@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
 <1543408867-16465-7-git-send-email-pmorel@linux.ibm.com>
 <20181213163953.5b534e6b.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 14 Dec 2018 15:08:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213163953.5b534e6b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121414-0020-0000-0000-000002F6FA68
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121414-0021-0000-0000-0000214733C1
Message-Id: <62caa2ce-9830-ff6f-def3-495c3a040dac@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2018 16:39, Cornelia Huck wrote:
> On Wed, 28 Nov 2018 13:41:07 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> When the user program is QEMU we rely on the QEMU lock to serialize
>> the calls to the driver.
>>
>> In the general case we need to make sure that two data transfer are
>> not started at the same time.
>> It would in the current implementation resul in a overwriting of the
>> IO region.
>>
>> We also need to make sure a clear or a halt started after a data
>> transfer do not win the race agains the data transfer.
>> Which would result in the data transfer being started after the
>> halt/clear.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_ops.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>> index eb5b49d..b316966 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -267,22 +267,31 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>>   {
>>   	unsigned int index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
>>   	struct vfio_ccw_private *private;
>> +	static atomic_t serialize  = ATOMIC_INIT(0);
>> +	int ret = -EINVAL;
>> +
>> +	if (!atomic_add_unless(&serialize, 1, 1))
>> +		return -EBUSY;
> 
> I think that hammer is far too big: This serializes _all_ write
> operations across _all_ devices.

Right, much too much.
This should go inside the device.
(Don't know what I was thinking of).


> 
> There are various cases of simultaneous writes that may happen
> (assuming any userspace; QEMU locking will prevent some of them from
> happening):
> 
> - One thread does a write for one mdev, another thread does a write for
>    another mdev. For example, if two vcpus issue an I/O instruction on
>    two different devices. This should be fine.
> - One thread does a write for one mdev, another thread does a write for
>    the same mdev. Maybe a guest has confused/no locking and is trying to
>    do ssch on the same device from different vcpus. There, we want to
>    exclude simultaneous writes; the desired outcome may be that one ssch
>    gets forwarded to the hardware, and the second one either gets
>    forwarded after processing for the first one has finished, or
>    userspace gets an error immediately (hopefully resulting in a
>    appropriate condition code for that second ssch in any case). Both
>    handing the second ssch to the hardware or signaling device busy
>    immediately are probably sane in that case.

should be.

> - If those writes for the same device involve hsch/csch, things get
>    more complicated. First, we have two different regions, and allowing
>    simultaneous writes to the I/O region and to the async region should
>    not really be a problem, so I don't think fencing should be done in
>    the generic write handler. Second, the semantics for device busy are
>    different: a hsch immediately after a ssch should not give device
>    busy, and csch cannot return device busy at all.

The lock should be done in the device and only for SSCH.
We did not have CSCH or HSCH at the moment I sent the patch.

It is clear that CSCH or HSCH should not be blocked.

> 
> I don't think we'll be able to get around some kind of "let's retry
> sending this" logic for hsch/csch; maybe we should already do that for
> ssch. (Like the -EINVAL logic I described in the other thread.)
> 
> 

As I wrote in the cover letter this (stupid) patch is decoupled from the 
series.
I made the mistake to attach it here but I hope you will consider the 
rest of the serie which I think is much more important.

The handling of a lock / busy waiting here should wait for your serie on 
HSCH/CSCH anyway.

Regards,
Pierre




-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

