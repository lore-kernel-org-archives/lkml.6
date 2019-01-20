Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F8EC7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117482084A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfATRJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:09:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbfATRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:09:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0KH9iwN016288
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 12:09:45 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q4hn191c1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 12:09:45 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 20 Jan 2019 17:09:27 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 20 Jan 2019 17:09:24 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0KH9NQ36619554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Jan 2019 17:09:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F4E9A405C;
        Sun, 20 Jan 2019 17:09:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4813DA4054;
        Sun, 20 Jan 2019 17:09:22 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 20 Jan 2019 17:09:22 +0000 (GMT)
Date:   Sun, 20 Jan 2019 19:09:20 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Yang Fan <nullptr.cpp@gmail.com>
Cc:     akpm@linux-foundation.org, will.deacon@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/mmap.c: Remove some redundancy in
 arch_get_unmapped_area_topdown()
References: <cover.1547966629.git.nullptr.cpp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547966629.git.nullptr.cpp@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012017-0028-0000-0000-0000033BAD50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012017-0029-0000-0000-000023F8E007
Message-Id: <20190120170919.GB28141@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-20_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901200139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 20, 2019 at 09:12:26AM +0100, Yang Fan wrote:
> This patchset remove some redundancy in function 
> arch_get_unmapped_area_topdown().
> 
> [PATCH 1/2] mm/mmap.c: Remove redundant variable 'addr' in 
> arch_get_unmapped_area_topdown()
> [PATCH 2/2] mm/mmap.c: Remove redundant const qualifier of the no-pointer 
> parameters
> 
> Yang Fan (2):
>   mm/mmap.c: Remove redundant variable 'addr' in
>     arch_get_unmapped_area_topdown()
>   mm/mmap.c: Remove redundant const qualifier of the no-pointer
>     parameters

I think it would be better to merge these patches into one.
For the merged patch feel free to add

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
 
>  mm/mmap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

