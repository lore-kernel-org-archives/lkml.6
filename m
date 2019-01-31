Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80543C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5084820881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iYyPKWUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfAaXYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:24:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51718 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfAaXYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:24:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0VNOCcG054131;
        Thu, 31 Jan 2019 23:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6pGOPWMmxVCxWs6BV6RmVOg3Xvs2zKVSzXNNmEfSHag=;
 b=iYyPKWUJJVC+YCPo12KmTwr2U8bj+r2oAtdebl1+e/sXRknEzHhCa47gPPt0k27JaVjW
 L5KL5ep9mLKGl4AAkskjBu9Pn2W29zhAY2sVMOBkNBN4PTdgFes2zsHTkKZE+WrzbU7F
 UVSleCfSuClymxMGvc0kXqmWrq9Ey3mPw+3EThUolpp74EvMnj1JDMuYiPImKS2s2czq
 Pzfw1M6pv+N3sVDqcY8fcT1p88VaoyZo1nUvc8kNznhRrlUKo/jR9edLzcbsDCApbHtD
 Sx/6/QYA++baZOffPZJ/HXifSygSdABwdtUvMISvNyAAaJBzxzeatEE4BkUEq+cjruI3 xA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q8g6rkjty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 23:24:12 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0VNO7Ap016639
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 23:24:07 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0VNO6Vj001474;
        Thu, 31 Jan 2019 23:24:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Jan 2019 15:24:06 -0800
Date:   Thu, 31 Jan 2019 15:24:05 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH -next] xfs: remove duplicated xfs_defer.h
Message-ID: <20190131232405.GE5761@magnolia>
References: <20190117070217.12432-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117070217.12432-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9153 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901310168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 03:02:17PM +0800, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Looks fine to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_trans_bmap.c     | 1 -
>  fs/xfs/xfs_trans_extfree.c  | 1 -
>  fs/xfs/xfs_trans_refcount.c | 1 -
>  fs/xfs/xfs_trans_rmap.c     | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_trans_bmap.c b/fs/xfs/xfs_trans_bmap.c
> index 11cff44..e1c7d55 100644
> --- a/fs/xfs/xfs_trans_bmap.c
> +++ b/fs/xfs/xfs_trans_bmap.c
> @@ -17,7 +17,6 @@
>  #include "xfs_alloc.h"
>  #include "xfs_bmap.h"
>  #include "xfs_inode.h"
> -#include "xfs_defer.h"
>  
>  /*
>   * This routine is called to allocate a "bmap update done"
> diff --git a/fs/xfs/xfs_trans_extfree.c b/fs/xfs/xfs_trans_extfree.c
> index 0710434..8ee7a3f 100644
> --- a/fs/xfs/xfs_trans_extfree.c
> +++ b/fs/xfs/xfs_trans_extfree.c
> @@ -18,7 +18,6 @@
>  #include "xfs_alloc.h"
>  #include "xfs_bmap.h"
>  #include "xfs_trace.h"
> -#include "xfs_defer.h"
>  
>  /*
>   * This routine is called to allocate an "extent free done"
> diff --git a/fs/xfs/xfs_trans_refcount.c b/fs/xfs/xfs_trans_refcount.c
> index 6c947ff..8d73472 100644
> --- a/fs/xfs/xfs_trans_refcount.c
> +++ b/fs/xfs/xfs_trans_refcount.c
> @@ -16,7 +16,6 @@
>  #include "xfs_refcount_item.h"
>  #include "xfs_alloc.h"
>  #include "xfs_refcount.h"
> -#include "xfs_defer.h"
>  
>  /*
>   * This routine is called to allocate a "refcount update done"
> diff --git a/fs/xfs/xfs_trans_rmap.c b/fs/xfs/xfs_trans_rmap.c
> index a428909..5c7936b 100644
> --- a/fs/xfs/xfs_trans_rmap.c
> +++ b/fs/xfs/xfs_trans_rmap.c
> @@ -16,7 +16,6 @@
>  #include "xfs_rmap_item.h"
>  #include "xfs_alloc.h"
>  #include "xfs_rmap.h"
> -#include "xfs_defer.h"
>  
>  /* Set the map extent flags for this reverse mapping. */
>  static void
> -- 
> 2.7.0
> 
> 
