Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9BBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7747421557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7747421557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeHYDPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:15:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbeHYDPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:15:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7ONYDOH129979
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 19:39:06 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m2rbrec7r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 19:39:06 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 24 Aug 2018 17:39:05 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 17:39:02 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7ONd19V24838340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 16:39:01 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D61AA7805E;
        Fri, 24 Aug 2018 17:39:01 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA17378063;
        Fri, 24 Aug 2018 17:38:58 -0600 (MDT)
Received: from morokweng.localdomain (unknown [9.85.162.69])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Aug 2018 17:38:58 -0600 (MDT)
References: <20180824025933.24319-1-bauerman@linux.ibm.com> <20180824025933.24319-11-bauerman@linux.ibm.com> <20180824060055.GB13689@lst.de>
User-agent: mu4e 1.0; emacs 25.3.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 10/11] powerpc/svm: Force the use of bounce buffers
In-reply-to: <20180824060055.GB13689@lst.de>
Date:   Fri, 24 Aug 2018 20:38:54 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18082423-0016-0000-0000-000009210D97
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009605; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01078377; UDB=6.00556070; IPR=6.00858352;
 MB=3.00022917; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-24 23:39:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082423-0017-0000-0000-0000401E11E1
Message-Id: <87o9drxrld.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Christoph,

Thanks for your quick review.

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Aug 23, 2018 at 11:59:32PM -0300, Thiago Jung Bauermann wrote:
>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>
>> SWIOTLB checks range of incoming CPU addresses to be bounced and see if the
>> device can access it through it's DMA window without requiring bouncing. In
>> such cases it just chooses to skip bouncing. But for cases like secure
>> guests on powerpc platform all addresses need to be bounced into the shared
>> pool of memory because the host cannot access it otherwise. Hence the need
>> to do the bouncing is not related to device's DMA window. Hence force the
>> use of bouncing by setting the swiotlb_force variable on secure guests.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  arch/powerpc/kernel/svm.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
>> index 1af5caa955f5..f0576ad65cd0 100644
>> --- a/arch/powerpc/kernel/svm.c
>> +++ b/arch/powerpc/kernel/svm.c
>> @@ -17,6 +17,7 @@ static int __init init_svm(void)
>>  		return 0;
>>
>>  	ppc_swiotlb_enable = 1;
>> +	swiotlb_force = SWIOTLB_FORCE;
>>  	swiotlb_update_mem_attributes();
>
> This needs a comment.

Good point. Will add one.

If in the new scheme of things (with bus_dma_mask?) dma_capable() on a
virtio device running in a secure guest returns false, then this patch
becomes unnecessary and can be dropped.

--
Thiago Jung Bauermann
IBM Linux Technology Center

