Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED40CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DDF20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mi4SrYRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DDF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbeLJVGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:06:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41064 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeLJVGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:06:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBAL5ZDc019840;
        Mon, 10 Dec 2018 21:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=A62hSNDQdV2JLTUo3rEJOOvX8Vj0r/iKsccJta4tOCc=;
 b=mi4SrYRZnrw0VXa6YGlQl4Jdh6AN29aXPdEhVKg9G2c4p03zi3niWTZAq+ljvkd8bsQF
 LVF7m2kx3gPUhvCOSPbaK/+dhjDboxPRqCAAoXkZ4JO6uXDkhwwHOWSOQkUsC9byaSTr
 ua+Q28OEMNl0U3kpHq7lUarqx9wl7OYM+mWyg2g8i15/S6rpnhK93mNRhQwV4G2qh0si
 t4V0NNqw59ev5dZ6QH641WExJq8l+zvphVsOa5ylklrkc8SKc380/UZvgECN3YPw6j/c
 ih8G/miEIzlBLC5iO2AjCvArs4lnH8W+HsSh0CQXLYq9qjXD1ZlTX375kAfmDn6DJ0Fn ig== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p86kqrbsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 21:05:53 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBAL5kG7027782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 21:05:47 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBAL5jSJ008316;
        Mon, 10 Dec 2018 21:05:45 GMT
Received: from [10.211.47.70] (/10.211.47.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 13:05:45 -0800
Subject: Re: [PATCH v2 1/2] swiotlb: add debugfs to track swiotlb buffer usage
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
References: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
 <41becd27-8c3a-da2b-e5ed-e361ba20e4d4@linux.intel.com>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <34883ba5-b444-3d37-4d40-9b0a651dd2eb@oracle.com>
Date:   Mon, 10 Dec 2018 13:05:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <41becd27-8c3a-da2b-e5ed-e361ba20e4d4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 12:00 PM, Tim Chen wrote:
>> @@ -528,6 +538,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>>  	return SWIOTLB_MAP_ERROR;
>>  found:
>> +#ifdef CONFIG_DEBUG_FS
>> +	io_tlb_used += nslots;
>> +#endif
> One nit I have about this patch is there are too many CONFIG_DEBUG_FS.
> 
> For example here, instead of io_tlb_used, we can have a macro defined,
> perhaps something like inc_iotlb_used(nslots).  It can be placed in the
> same section that swiotlb_create_debugfs is defined so there's a single
> place where all the CONFIG_DEBUG_FS stuff is located.
> 
> Then define inc_iotlb_used to be null when we don't have
> CONFIG_DEBUG_FS.
> 

Dongli had removed above ifdef/endif on his next patch, "[PATCH v2 2/2]
swiotlb: checking whether swiotlb buffer is full with io_tlb_used"

Thanks,
Joe
