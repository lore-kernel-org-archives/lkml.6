Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC005C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B342A20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfAQNCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:02:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726632AbfAQNCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:02:20 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HCxfA1102659
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:02:20 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q2rsquxp6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:02:19 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 17 Jan 2019 13:02:17 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 13:02:14 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HD2Cr16554074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 13:02:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D82442045;
        Thu, 17 Jan 2019 13:02:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60E184204B;
        Thu, 17 Jan 2019 13:02:12 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 13:02:12 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "walling@linux.ibm.com" <walling@linux.ibm.com>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
 <5FC3163CFD30C246ABAA99954A238FA83928BF16@lhreml524-mbs.china.huawei.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 17 Jan 2019 14:02:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83928BF16@lhreml524-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011713-0016-0000-0000-00000246BB29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011713-0017-0000-0000-000032A0DDFF
Message-Id: <c5e7e9c6-15ed-99fb-3cd6-81ec8f2d3dff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2019 10:23, Shameerali Kolothum Thodi wrote:
> Hi Pierre,
> 
>> -----Original Message-----
>> From: Pierre Morel [mailto:pmorel@linux.ibm.com]
>> Sent: 15 January 2019 17:37
>> To: gerald.schaefer@de.ibm.com
>> Cc: joro@8bytes.org; linux-s390@vger.kernel.org;
>> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
>> alex.williamson@redhat.com; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; walling@linux.ibm.com
>> Subject: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
>>
>> The s390 iommu can only allow DMA transactions between the zPCI device
>> entries start_dma and end_dma.
>>
>> Let's declare the regions before start_dma and after end_dma as
>> reserved regions using the appropriate callback in iommu_ops.
>>
>> The reserved region may later be retrieved from sysfs or from
>> the vfio iommu internal interface.
> 
> Just in case you are planning to use the sysfs interface to retrieve the valid
> regions, and intend to use that in Qemu vfio path, please see the discussion
> here [1] (If you haven't seen this already)
> 
> Thanks,
> Shameer
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03651.html
>   
>> This seems to me related with the work Shameer has started on
>> vfio_iommu_type1 so I add Alex and Shameer to the CC list.
>>
>> Pierre Morel (1):
>>    iommu/s390: Declare s390 iommu reserved regions
>>
>>   drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> --
>> 2.7.4
> 

Thanks Shameer,

Interesting discussion indeed.

AFAIK the patch series you are working on will provide a way to retrieve 
the reserved region through the VFIO IOMMU interface, using capabilities 
in the VFIO_IOMMU_GET_INFO.
Before this patch, the iommu_type1 was not able to retrieve the 
forbidden region from the s390_iommu.

See this patch is a contribution, so that these regions will appear in 
the reserved list when the VFIO_IOMM_GET_INFO will be able to report the 
information.

I am expecting to be able to to retrieve this information from the 
VFIO_IOMMU_GET_INFO syscall as soon as it is available.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

