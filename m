Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC50C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7E6205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7E6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeK1EpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:45:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731529AbeK1EpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:45:22 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARHhYmo066128
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:46:42 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p18y34u3h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:46:42 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 27 Nov 2018 17:46:39 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 17:46:37 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARHkawX58327256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 17:46:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2248A42045;
        Tue, 27 Nov 2018 17:46:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D8D84204C;
        Tue, 27 Nov 2018 17:46:35 +0000 (GMT)
Received: from [9.152.224.168] (unknown [9.152.224.168])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 17:46:35 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 2/3] vfio: ap: ioctl definitions for AP Queue Interrupt
 Control
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
 <1542906675-7949-3-git-send-email-pmorel@linux.ibm.com>
 <20181127102237.42d8e178@x1.home>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 27 Nov 2018 18:46:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127102237.42d8e178@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112717-0012-0000-0000-000002D10E16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112717-0013-0000-0000-000021064FFF
Message-Id: <b308d46a-45e1-d891-235b-3097e5dd2b08@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2018 18:22, Alex Williamson wrote:
> On Thu, 22 Nov 2018 18:11:14 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We define two VFIO ioctl command to setup and clear
>> the AP Queues interrupt.
>>
>> Arguments passed by the guest are:
>> - the apqn, AP queue number
>> - the Notification by address
>> - the identifier of the previously associated adapter
> 
> 
> We have an extensible VFIO_DEVICE_SET_IRQS ioctl already, why does AP
> need its own?

For no good reason.
Sorry for this.
I will change for the use of the standard VFIO_DEVICE_SET_IRQS.

Thanks Alex.

Regards,
Pierre

> 
> 
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   include/uapi/linux/vfio.h | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 8131028..9a1b350 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -866,6 +866,31 @@ struct vfio_iommu_spapr_tce_remove {
>>   };
>>   #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
>>   
>> +/**
>> + * VFIO_AP_SET_IRQ - _IOWR(VFIO_TYPE, VFIO_BASE + 21, struct vfio_ap_aqic)
>> + *
>> + * Setup IRQ for an AP Queue
>> + * @cmd contains the AP queue number (apqn)
>> + * @status receives the resulting status of the command
>> + * @nib is the Notification Indicator byte address
>> + * @adapter_id allows to retrieve the associated adapter
>> + */
>> +struct vfio_ap_aqic {
>> +	__u32   argsz;
>> +	__u32   flags;
>> +	/* out */
>> +	__u32 status;
>> +	/* in */
>> +	__u32 adapter_id;
>> +	__u64 nib;
>> +	__u16 apqn;
>> +	__u8 isc;
>> +	__u8 reserved[5];
>> +};
>> +#define VFIO_AP_SET_IRQ			_IO(VFIO_TYPE, VFIO_BASE + 21)
>> +#define VFIO_AP_CLEAR_IRQ		_IO(VFIO_TYPE, VFIO_BASE + 22)
>> +
>>   /* ***************************************************************** */
>>   
>> +
>>   #endif /* _UAPIVFIO_H */
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

