Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B5ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 07:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CA9204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 07:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CA9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeJUPnt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 11:43:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727086AbeJUPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 11:43:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9L7TKsE043542
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 03:30:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n8htxd95r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 03:30:23 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 21 Oct 2018 08:30:22 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 21 Oct 2018 08:30:20 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9L7UJco22675498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 21 Oct 2018 07:30:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B1DEAE057;
        Sun, 21 Oct 2018 07:30:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAA15AE04D;
        Sun, 21 Oct 2018 07:30:18 +0000 (GMT)
Received: from [9.148.206.95] (unknown [9.148.206.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 21 Oct 2018 07:30:18 +0000 (GMT)
Date:   Sun, 21 Oct 2018 10:30:16 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20181019081729.klvckcytnhheaian@master>
References: <1538067825-24835-1-git-send-email-rppt@linux.vnet.ibm.com> <20181019081729.klvckcytnhheaian@master>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] memblock: remove stale #else and the code it protects
To:     Wei Yang <richard.weiyang@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Mike Rapoport <rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18102107-0016-0000-0000-000002164C98
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102107-0017-0000-0000-0000326DFED1
Message-Id: <6EEAA7EC-75B7-4899-A562-35A58FC037E6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=978 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810210071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 19, 2018 11:17:30 AM GMT+03:00, Wei Yang <richard.weiyang@gmail.com> wrote:
>Which tree it applies?

To mmotm of the end of September.

>On Thu, Sep 27, 2018 at 08:03:45PM +0300, Mike Rapoport wrote:
>>During removal of HAVE_MEMBLOCK definition, the #else clause of the
>>
>>	#ifdef CONFIG_HAVE_MEMBLOCK
>>		...
>>	#else
>>		...
>>	#endif
>>
>>conditional was not removed.
>>
>>Remove it now.
>>
>>Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
>>Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
>>Cc: Michal Hocko <mhocko@suse.com>
>>---
>> include/linux/memblock.h | 5 -----
>> 1 file changed, 5 deletions(-)
>>
>>diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>index d3bc270..d4d0e01 100644
>>--- a/include/linux/memblock.h
>>+++ b/include/linux/memblock.h
>>@@ -597,11 +597,6 @@ static inline void early_memtest(phys_addr_t
>start, phys_addr_t end)
>> {
>> }
>> #endif
>>-#else
>>-static inline phys_addr_t memblock_alloc(phys_addr_t size,
>phys_addr_t align)
>>-{
>>-	return 0;
>>-}
>> 
>> #endif /* __KERNEL__ */
>> 
>>-- 
>>2.7.4

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

