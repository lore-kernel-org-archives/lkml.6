Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808BCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A39206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfAIRH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:07:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbfAIRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:07:29 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09H4QLV180742
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 12:07:27 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwjvsf8ba-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 12:07:27 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 9 Jan 2019 17:07:25 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 17:07:21 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09H7KUo61210736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 17:07:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 414F64204C;
        Wed,  9 Jan 2019 17:07:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBEBD42042;
        Wed,  9 Jan 2019 17:07:19 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 17:07:19 +0000 (GMT)
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
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 9 Jan 2019 18:07:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109083708.1d39234d@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010917-0012-0000-0000-000002E573E6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010917-0013-0000-0000-0000211C76CC
Message-Id: <bd36cddc-cce1-adc1-cab8-d6df2089e931@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2019 16:37, Alex Williamson wrote:
> On Wed,  9 Jan 2019 13:41:53 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We add a new flag, VFIO_IOMMU_INFO_CAPABILITIES, inside the
>> vfio_iommu_type1_info to specify the support for capabilities.
>>
>> We add a new capability, with id VFIO_IOMMU_INFO_CAP_DMA
>> in the capability list of the VFIO_IOMMU_GET_INFO ioctl.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   include/uapi/linux/vfio.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 8131028..54c4fcb 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -669,6 +669,15 @@ struct vfio_iommu_type1_info {
>>   	__u32	flags;
>>   #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
>>   	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
>> +#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
>> +	__u64   cap_offset;     /* Offset within info struct of first cap */
>> +};
>> +
>> +#define VFIO_IOMMU_INFO_CAP_DMA 1
>> +struct vfio_iommu_cap_dma {
>> +	struct vfio_info_cap_header header;
>> +	__u64   dma_start;
>> +	__u64   dma_end;
>>   };
>>   
>>   #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> 
> Unfortunately for most systems, a simple start and end is not really
> sufficient to describe the available IOVA space, there are often
> reserved regions intermixed, so this is not really a complete
> solution.  Shameer tried to solve this last year[1] but we ran into a
> road block that Intel IGD devices impose a reserved range of IOVA
> spaces reported to the user that conflict with existing assignment of
> this device and we haven't figured out yet how to be more selective of
> the enforcement of those reserved ranges.  Thanks,
> 
> Alex
> 
> [1] https://lkml.org/lkml/2018/4/18/293
> 

I understand that some architecture may be more complex and have special 
needs.
However the IOMMU geometry is a constant for all IOMMU devices and
is reported by the geometry in the iommu operations.

This makes the IOMMU geometry a special case.
It is also a special case because it is an inclusive description of 
available memory, to oppose to the exclusive description given by the 
windows.

Isn't it possible to separate the IOMMU geometry, which is really 
related to the IOMMU chip, from other windows exclusion related to the 
system memory mapping?

Retrieving the IOMMU geometry is very important for us because the 
driver inside the guest must get it and program the IOMMU based on these 
values.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

