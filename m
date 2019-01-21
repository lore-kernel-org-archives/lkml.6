Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F1DC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3552085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfAULvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:51:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727544AbfAULvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:51:22 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LBnUd6139957
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:51:21 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q5chmayat-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:51:21 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 21 Jan 2019 11:51:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 11:51:16 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LBpFPh20971522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 11:51:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0008942045;
        Mon, 21 Jan 2019 11:51:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9754D42047;
        Mon, 21 Jan 2019 11:51:14 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jan 2019 11:51:14 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, gerald.schaefer@de.ibm.com
Cc:     linux-s390@vger.kernel.org, walling@linux.ibm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
 <cc070df1-e7dc-8cce-f443-879e0e5e2903@arm.com>
 <3cd790d6-aa6f-e817-27ce-56d7a9b6b6e5@linux.ibm.com>
 <668fe734-e4bf-0342-ab8c-df54d9022db4@arm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 21 Jan 2019 12:51:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <668fe734-e4bf-0342-ab8c-df54d9022db4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012111-0020-0000-0000-000003094932
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012111-0021-0000-0000-0000215A77EF
Message-Id: <d180bb2d-354f-0d05-8773-7a196a4de3cb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2019 14:51, Jean-Philippe Brucker wrote:
> Hi Pierre,
> 
> On 18/01/2019 13:29, Pierre Morel wrote:
>> On 17/01/2019 14:02, Robin Murphy wrote:
>>> On 15/01/2019 17:37, Pierre Morel wrote:
>>>> The s390 iommu can only allow DMA transactions between the zPCI device
>>>> entries start_dma and end_dma.
>>>>

...

>>
>> I already posted a patch retrieving the geometry through
>> VFIO_IOMMU_GET_INFO using a specific capability for the geometry [1],
>> and AFAIU, Alex did not agree with this.
> 
> On arm we also need to report the IOMMU geometry to userspace (max IOVA
> size in particular). Shameer has been working on a solution [2] that
> presents a unified view of both geometry and reserved regions into the
> VFIO_IOMMU_GET_INFO call, and I think we should go with that. If I
> understand correctly it's currently blocked on the RMRR problem and
> we're waiting for Jacob or Ashok to take a look at it, as Kevin pinged
> them on thread [1]?
> 
> [2] https://lkml.org/lkml/2018/4/18/293
> 
> Thanks,
> Jean
> 

Hi Jean,

I hopped that this proposition went in the same direction based on the 
following assumptions:


- The goal of the get_resv_region is defined in iommu.h as:
-----
* @get_resv_regions: Request list of reserved regions for a device
-----

- A iommu reserve region is a region which should not be mapped.
Isn't it exactly what happens outside the aperture?
Shouldn't it be reported by the iommu reserved region?

- If we use VFIO and want to get all reserved region we will have the 
VFIO_IOMMU_GET_INFO call provided by Shameer and it can get all reserved 
regions depending from the iommu driver itself at once by calling the 
get_reserved_region callback instead of having to merge them with the 
aperture.

- If there are other reserved region, depending on the system 
configuration and not on the IOMMU itself, the VFIO_IOMMU_GET_INFO call 
will have to merge them with the region gotten from the iommu driver.

- If we do not use QEMU nor VFIO at all, AFAIU, the standard way to 
retrieve the reserved regions associated with a device is to call the 
get_reserved_region callback from the associated iommu.

Please tell me were I am wrong.

Regards,
Pierre


>>
>> What is different in what you propose?
>>
>> @Alex: I was hoping that this patch goes in your direction. What do you
>> think?
>>
>> Thanks,
>> Pierre
>>
>> [1]: https://lore.kernel.org/patchwork/patch/1030369/
>>
>>>
>>>>
>>>> This seems to me related with the work Shameer has started on
>>>> vfio_iommu_type1 so I add Alex and Shameer to the CC list.
>>>>
>>>>
>>>> Pierre Morel (1):
>>>>     iommu/s390: Declare s390 iommu reserved regions
>>>>
>>>>    drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>>>>    1 file changed, 29 insertions(+)
>>>>
>>>
>>
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

