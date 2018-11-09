Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63440C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B002081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B8U7btgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B002081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeKJJXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:23:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43016 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbeKJJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:23:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA9NblG2047918;
        Fri, 9 Nov 2018 23:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=PXQ6UANhByJAkf90CZvlmze9pAQHX1sFbS1UHhgipNQ=;
 b=B8U7btgGvPb7D5nZAZzlCjlSOivLqq+9dFzV55Mq9/ni1IiTzQugxSi6s61vPlnRLWjz
 bEWKZjoH7i6dZASbNKq3oUjhuUr3PMt4pG5MWerjJRSg4dMGGzQlrVUYSjIKsjlY4xKE
 NKnaTjZAxTB45H1nlFgsxYGm70iQhD1nACpkk47W5kdvIXyjm9tRxMUTj0X6wIJ4wlYc
 xmtSxXLATDAPpgObltJtNJrx3T2uP/TQV1p1VvatLvVrkSmCTkrTMrGykP/V6xJJNKDe
 G3eyZIK2KSNFLgLf4reS1DyJ+oPo5yTg6XfYcRrE0wO8oR7IrGgafIOQ438L3cY4hs7b PA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nh3mq9qgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 23:40:58 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA9NewnE026250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 23:40:58 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA9Nev7b007143;
        Fri, 9 Nov 2018 23:40:57 GMT
Received: from localhost (/10.145.179.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 15:40:57 -0800
Date:   Fri, 9 Nov 2018 15:40:56 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hmsjwzb <weizhefix@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix misspelling issue in fs/xfs/kmem.c
Message-ID: <20181109234056.GH15721@magnolia>
References: <20181109232301.19977-1-weizhefix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109232301.19977-1-weizhefix@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9072 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=919
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 07:23:01AM +0800, hmsjwzb wrote:

Sorry, but all submissions must have a Signed-off-by: to be reviewed.

Also, there's no To: header on this message??

NAK.

--D

> ---
>  fs/xfs/kmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
> index fdd9d6ede25c..73ec1f84e591 100644
> --- a/fs/xfs/kmem.c
> +++ b/fs/xfs/kmem.c
> @@ -45,7 +45,7 @@ kmem_alloc_large(size_t size, xfs_km_flags_t flags)
>  		return ptr;
>  
>  	/*
> -	 * __vmalloc() will allocate data pages and auxillary structures (e.g.
> +	 * __vmalloc() will allocate data pages and auxiliary structures (e.g.
>  	 * pagetables) with GFP_KERNEL, yet we may be under GFP_NOFS context
>  	 * here. Hence we need to tell memory reclaim that we are in such a
>  	 * context via PF_MEMALLOC_NOFS to prevent memory reclaim re-entering
> -- 
> 2.17.1
> 
