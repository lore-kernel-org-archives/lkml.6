Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3572086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3572086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeKHIEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:04:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728361AbeKHIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:04:35 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7MSTOJ033976
        for <linux-kernel@vger.kernel.org>; Wed, 7 Nov 2018 17:32:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nm4myaggy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 17:32:07 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 7 Nov 2018 22:32:05 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Nov 2018 22:32:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA7MW01W61603946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 22:32:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 029C142042;
        Wed,  7 Nov 2018 22:32:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FE274204F;
        Wed,  7 Nov 2018 22:31:59 +0000 (GMT)
Received: from [9.145.168.249] (unknown [9.145.168.249])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Nov 2018 22:31:59 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v1 4/7] vfio: ap: AP Queue Interrupt Control VFIO ioctl
 calls
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-5-git-send-email-pmorel@linux.ibm.com>
 <7e4cbc97-8c77-b393-efdd-6fd8550c15f1@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 7 Nov 2018 23:31:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7e4cbc97-8c77-b393-efdd-6fd8550c15f1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110722-0012-0000-0000-000002C6D834
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110722-0013-0000-0000-000020FB24A3
Message-Id: <be66fe05-f728-25b8-a786-4e7bf39965d1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 21:21, Tony Krowiak wrote:
> On 10/31/18 2:12 PM, Pierre Morel wrote:
>> This is the implementation of the VFIO ioctl calls to handle
>> the AQIC interception and use GISA to handle interrupts.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 95 +++++++++++++++++++++++++++++++
>>   1 file changed, 95 insertions(+)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 272ef427dcc0..f68102163bf4 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -895,12 +895,107 @@ static int 
>> vfio_ap_mdev_get_device_info(unsigned long arg)
>>       return copy_to_user((void __user *)arg, &info, minsz);
>>   }
>> +static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
> 
> In keeping with the other function names in this file, how about
> naming this function vfio_ap_mdev_setirq???

OK, agreed.

> 
>> +               struct vfio_ap_aqic *parm)
>> +{
>> +    struct aqic_gisa aqic_gisa = reg2aqic(0);
>> +    struct kvm_s390_gisa *gisa = matrix_mdev->kvm->arch.gisa;
>> +    struct ap_status ap_status = reg2status(0);
>> +    unsigned long p;
>> +    int ret = -1;
>> +    int apqn;
>> +    uint32_t gd;
>> +
>> +    apqn = (int)(parm->cmd & 0xffff);
>> +
>> +    gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
>> +    if (gd & 0x01)
>> +        aqic_gisa.f = 1;
>> +    aqic_gisa.gisc = matrix_mdev->gisc;
> 
> Can't you get this value from parm? I don't see any relationship
> between the mdev device and gisc, why store it there?

The idea is that we may want to report this value to the admin or as 
debug information, so I wanted to keep track of it.

> 
>> +    aqic_gisa.isc = GAL_ISC;
>> +    aqic_gisa.ir = 1;
>> +    aqic_gisa.gisao = gisa->next_alert >> 4;
>> +
>> +    p = (unsigned long) page_address(matrix_mdev->map->page);
>> +    p += (matrix_mdev->map->guest_addr & 0x0fff);
>> +
>> +    ret = ap_host_aqic((uint64_t)apqn, aqic2reg(aqic_gisa), p);
>> +    parm->status = ret;
>> +
>> +    ap_status = reg2status(ret);
>> +    return (ap_status.rc) ? -EIO : 0;
>> +}
>> +
>> +static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
>> +               struct vfio_ap_aqic *parm)
> 
> In keeping with the other function names in this file, how about
> naming this function vfio_ap_mdev_clrirq, or better yet,
> vfio_ap_mdev_clear_irq???

agreed too.

> 
>> +{
>> +    struct aqic_gisa aqic_gisa = reg2aqic(0);
>> +    struct ap_status ap_status = reg2status(0) > +    int apqn;
>> +    int retval;
>> +    uint32_t gd;
>> +
>> +    apqn = (int)(parm->cmd & 0xffff);
>> +
>> +    gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
>> +    if (gd & 0x01)
>> +        aqic_gisa.f = 1;
>> +    aqic_gisa.ir = 0;
>> +
>> +    retval = ap_host_aqic((uint64_t)apqn, aqic2reg(aqic_gisa), 0);
>> +    parm->status = retval;
>> +
>> +    ap_status = reg2status(retval);
>> +    return (ap_status.rc) ? -EIO : 0;
>> +}
>> +
>>   static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
>>                       unsigned int cmd, unsigned long arg)
>>   {
>>       int ret;
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +    struct s390_io_adapter *adapter;
>> +    struct vfio_ap_aqic parm;
>> +    struct s390_map_info *map;
>> +    int apqn, found = 0;
>>       switch (cmd) {
>> +    case VFIO_AP_SET_IRQ:
>> +        if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
>> +            return -EFAULT;
>> +        apqn = (int)(parm.cmd & 0xffff);
>> +        parm.status &= 0x00000000ffffffffUL;
>> +        matrix_mdev->gisc = parm.status & 0x07;
> 
> It seems that the only reason for the 'gisc' field in matrix_mdev
> is to pass the value to the ap_ioctl_setirq() function. Since the
> gisc has nothing to do with the mdev device and the 'parm' is being
> passed to ap_ioctl_setirq(), why not just eliminate the
> matrix_mdev->gisc field and get it from the 'parm' parameter in
> ap_ioctl_setirq()?

OK, seems better.

> 
>> +        /* find the adapter */ap_ioctl_setirq()
>> +        adapter = matrix_mdev->kvm->arch.adapters[parm.adapter_id];
>> +        if (!adapter)
>> +            return -ENOENT;
>> +        down_write(&adapter->maps_lock);
>> +        list_for_each_entry(map, &adapter->maps, list) {
>> +            if (map->guest_addr == parm.nib) {
>> +                found = 1;
>> +                break;
>> +            }
>> +        }
>> +        up_write(&adapter->maps_lock);
>> +
>> +        if (!found)
>> +            return -EINVAL;
>> +
>> +        matrix_mdev->map = map;
> 
> See my comment above about matrix_mdev->gisc. Can't we just get rid
> of the matrix_mdev->map field and pass the map into the
> ap_ioctl_setirq() function?

or calculate it from parm... as we give parm as argument to this function

> 
>> +        ret = ap_ioctl_setirq(matrix_mdev, &parm);
>> +        parm.status &= 0x00000000ffffffffUL;
>> +        if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
>> +            return -EFAULT;
>> +
>> +        break;
> 
> IMHO, the case statements should only determine which ioctl is being
> invoked and call the appropriate function to handle it. All of the above
> code could be in an intermediate function called from this case
> statement, thus reducing the case to calling the intermediate function.

OK, I can do so, however I would like to let the __user access here.

> 
>> +    case VFIO_AP_CLEAR_IRQ:
>> +        if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
>> +            return -EFAULT;
>> +        ret = ap_ioctl_clrirq(matrix_mdev, &parm);
>> +        if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
>> +            return -EFAULT;
>> +        break;
>>       case VFIO_DEVICE_GET_INFO:
>>           ret = vfio_ap_mdev_get_device_info(arg);
>>           break;
>>
> 

Thanks
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

