Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4796C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71065214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfAJMrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:47:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727704AbfAJMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:47:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0ACctkc130400
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:47:35 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2px4m3cpy6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:47:34 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 10 Jan 2019 12:47:33 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 12:47:29 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0AClSx53015034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 12:47:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4825EA4067;
        Thu, 10 Jan 2019 12:47:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C074A4054;
        Thu, 10 Jan 2019 12:47:28 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 12:47:27 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v1 1/2] vfio:iommu: Use capabilities do report IOMMU
 informations
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        walling@linux.ibm.com, cohuck@redhat.com, david@redhat.com,
        pasic@linux.ibm.com, thuth@redhat.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
References: <1547037714-21592-1-git-send-email-pmorel@linux.ibm.com>
 <1547037714-21592-2-git-send-email-pmorel@linux.ibm.com>
 <20190109083708.1d39234d@x1.home>
 <bd36cddc-cce1-adc1-cab8-d6df2089e931@linux.ibm.com>
 <20190109124337.3e85395e@x1.home>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 10 Jan 2019 13:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109124337.3e85395e@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011012-0008-0000-0000-000002AEEB7F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011012-0009-0000-0000-0000221AF1B1
Message-Id: <891c8f2e-5ac4-e423-d8aa-831fb0c9e97b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2019 20:43, Alex Williamson wrote:
> On Wed, 9 Jan 2019 18:07:19 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 09/01/2019 16:37, Alex Williamson wrote:
>>> On Wed,  9 Jan 2019 13:41:53 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>> We add a new flag, VFIO_IOMMU_INFO_CAPABILITIES, inside the
>>>> vfio_iommu_type1_info to specify the support for capabilities.
>>>>
>>>> We add a new capability, with id VFIO_IOMMU_INFO_CAP_DMA
>>>> in the capability list of the VFIO_IOMMU_GET_INFO ioctl.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>    include/uapi/linux/vfio.h | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>> index 8131028..54c4fcb 100644
>>>> --- a/include/uapi/linux/vfio.h
>>>> +++ b/include/uapi/linux/vfio.h
>>>> @@ -669,6 +669,15 @@ struct vfio_iommu_type1_info {
>>>>    	__u32	flags;
>>>>    #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
>>>>    	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
>>>> +#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
>>>> +	__u64   cap_offset;     /* Offset within info struct of first cap */
>>>> +};
>>>> +
>>>> +#define VFIO_IOMMU_INFO_CAP_DMA 1
>>>> +struct vfio_iommu_cap_dma {
>>>> +	struct vfio_info_cap_header header;
>>>> +	__u64   dma_start;
>>>> +	__u64   dma_end;
>>>>    };
>>>>    
>>>>    #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>>>
>>> Unfortunately for most systems, a simple start and end is not really
>>> sufficient to describe the available IOVA space, there are often
>>> reserved regions intermixed, so this is not really a complete
>>> solution.  Shameer tried to solve this last year[1] but we ran into a
>>> road block that Intel IGD devices impose a reserved range of IOVA
>>> spaces reported to the user that conflict with existing assignment of
>>> this device and we haven't figured out yet how to be more selective of
>>> the enforcement of those reserved ranges.  Thanks,
>>>
>>> Alex
>>>
>>> [1] https://lkml.org/lkml/2018/4/18/293
>>>    
>>
>> I understand that some architecture may be more complex and have special
>> needs.
>> However the IOMMU geometry is a constant for all IOMMU devices and
>> is reported by the geometry in the iommu operations.
>>
>> This makes the IOMMU geometry a special case.
> 
> I'm not so sure that the geometry is a constant for all IOMMU devices,

Sorry, I did not express myself correctly, what I mean is that the IOMMU 
geometry is independent of the system memory map but is a constant of 
the IOMMU device.
May be different for another IOMMU device, as we can have several 
different IOMMU device, typically one per PCI device, in the Z architecture.

> nor am I sure how if that were true and it's part of an in-kernel
> interface that it automatically qualifies it as the right way to expose
> it to userspace.  The fact that we have a reserved region interface to
> augment a basic contiguous range suggests it's known to be insufficient
> even for in-kernel use.
> 
>> It is also a special case because it is an inclusive description of
>> available memory, to oppose to the exclusive description given by the
>> windows.
> 
> Geometry doesn't really have anything to do with available memory, it's
> the minimum and maximum IOVA aperture.  Shameer's proposal gave us an
> IOVA list, which is based on the IOMMU geometry, from which it excludes
> various reserved ranges.  So if you have a less complex architecture,
> you might only have one entry in the list, which gives you the start
> and end of the base geometry.  Move complex architectures might have
> more entries, but the geometry can still be deduced from the absolute
> highest and lowest addresses within the list.  Therefore a basic
> geometry capability is automatically redundant to the interface that's
> already been proposed.
> 
>> Isn't it possible to separate the IOMMU geometry, which is really
>> related to the IOMMU chip, from other windows exclusion related to the
>> system memory mapping?
> 
> Why would we ever have both given the description above?

My idea for this is based on that restrictions are comming from two 
different address spaces:
- One address space is the device view before IOMMU (aperture)
- The other is the physical system view (reserved windows)

which, I thought, makes things difficult to merge.
However reading you and Shameer and the pointers you both sent, I 
understand that there are much more for me to learn, especially about 
other architectures (Intel / RMRR)

> 
>> Retrieving the IOMMU geometry is very important for us because the
>> driver inside the guest must get it and program the IOMMU based on these
>> values.
> 
> So you have motivation to help move the IOVA list proposal forward,
> or some equally inclusive proposal that isn't just a stop-gap ;)
> Thanks,
> 
> Alex
> 

I will be happy to help.
I will need some time to catch up however.
Thanks for your comments.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

