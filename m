Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09D7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7945D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfARN33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:29:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727115AbfARN33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:29:29 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0IDSB87068980
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:29:27 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q3cxqen8x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:29:27 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 18 Jan 2019 13:29:25 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 13:29:22 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0IDTLYA64225510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 13:29:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A677A4054;
        Fri, 18 Jan 2019 13:29:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F9FA405B;
        Fri, 18 Jan 2019 13:29:20 +0000 (GMT)
Received: from [9.145.184.65] (unknown [9.145.184.65])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jan 2019 13:29:20 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
To:     Robin Murphy <robin.murphy@arm.com>, gerald.schaefer@de.ibm.com
Cc:     linux-s390@vger.kernel.org, walling@linux.ibm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
 <cc070df1-e7dc-8cce-f443-879e0e5e2903@arm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 18 Jan 2019 14:29:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cc070df1-e7dc-8cce-f443-879e0e5e2903@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011813-0012-0000-0000-000002E9C8D7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011813-0013-0000-0000-00002120E938
Message-Id: <3cd790d6-aa6f-e817-27ce-56d7a9b6b6e5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2019 14:02, Robin Murphy wrote:
> On 15/01/2019 17:37, Pierre Morel wrote:
>> The s390 iommu can only allow DMA transactions between the zPCI device
>> entries start_dma and end_dma.
>>
>> Let's declare the regions before start_dma and after end_dma as
>> reserved regions using the appropriate callback in iommu_ops.
>>
>> The reserved region may later be retrieved from sysfs or from
>> the vfio iommu internal interface.
> 
> For this particular case, I think the best solution is to give VFIO the 
> ability to directly interrogate the domain geometry (which s390 appears 
> to set correctly already). The idea of reserved regions was really for 
> 'unexpected' holes inside the usable address space - using them to also 
> describe places that are entirely outside that address space rather 
> confuses things IMO.
> 
> Furthermore, even if we *did* end up going down the route of actively 
> reserving addresses beyond the usable aperture, it doesn't seem sensible 
> for individual drivers to do it themselves when the core API already 
> describes the relevant information generically.
> 
> Robin.

Robin,

I already posted a patch retrieving the geometry through 
VFIO_IOMMU_GET_INFO using a specific capability for the geometry [1], 
and AFAIU, Alex did not agree with this.

What is different in what you propose?

@Alex: I was hoping that this patch goes in your direction. What do you 
think?

Thanks,
Pierre

[1]: https://lore.kernel.org/patchwork/patch/1030369/

> 
>>
>> This seems to me related with the work Shameer has started on
>> vfio_iommu_type1 so I add Alex and Shameer to the CC list.
>>
>>
>> Pierre Morel (1):
>>    iommu/s390: Declare s390 iommu reserved regions
>>
>>   drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

