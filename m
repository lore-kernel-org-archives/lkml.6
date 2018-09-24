Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05902ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A747C2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5jEU7fEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A747C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbeIXWvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:51:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40738 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbeIXWvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:51:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8OGcslh062127;
        Mon, 24 Sep 2018 16:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=OHGbEi8kZqVQTXbqOzSysyXY24xP8wbm1EOUpLIv3po=;
 b=5jEU7fEk3VTay9zbnAUIDvRLbgeK8LRwHrwcj5T/d97nPi3WeKbV4PU82R26ENkksRKC
 iVCfIW99EeDrkYR2cjdTLi0aVQmZs4FkDtPBwd1PNVQNjK61mLBr43DH3cOYYuHLeBax
 MpIxyYgIdc81d/0VnBeHTEZG93S7GK3LhiJgS7wdUQAa0kd0t/9gVfIILwFEPBtlitNM
 uUal7xYInQ7YGcm1rRFOerxvXYFWuxt4zck0cMCnH+kmiEHtUh+pQ5d4GC7qywNBhyHv
 8fr4tDfseHSVRIeYzgOyO0FQggt+LKglNqumL3sWEWLA4LfldYJHlsOSM17N74CTMmon jA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mndpp716h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 16:48:12 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8OGm7tV013778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 16:48:07 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8OGm7RX002736;
        Mon, 24 Sep 2018 16:48:07 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Sep 2018 09:48:06 -0700
Subject: Re: [PATCH] mm/hugetlb: Add mmap() encodings for 32MB and 512MB page
 sizes
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     mhocko@kernel.org, punit.agrawal@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org
References: <1537797985-2406-1-git-send-email-anshuman.khandual@arm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <541d31f2-b4b7-e401-2fe9-7965d81b2f0a@oracle.com>
Date:   Mon, 24 Sep 2018 09:48:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1537797985-2406-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9026 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=929
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809240163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 7:06 AM, Anshuman Khandual wrote:
> ARM64 architecture also supports 32MB and 512MB HugeTLB page sizes.
> This just adds mmap() system call argument encoding for them.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/uapi/asm-generic/hugetlb_encode.h | 2 ++
>  include/uapi/linux/mman.h                 | 2 ++
>  2 files changed, 4 insertions(+)

Thanks Anshuman,

However, I think we should also add similar definitions in:
uapi/linux/memfd.h
uapi/linux/shm.h

-- 
Mike Kravetz
