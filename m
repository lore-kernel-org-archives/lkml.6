Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31571C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3ED20844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OJGpH/b8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3ED20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933631AbeGIQjz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:39:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42122 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933601AbeGIQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:39:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69GdgV5044495;
        Mon, 9 Jul 2018 16:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/ZyUKZye7gu+NjWoxbPO3KQ1RUD0cF4+46TnAo6Ilm8=;
 b=OJGpH/b8ahf+DA4B1J6wh4nkL1Xmc1PQjobYMM1QJ9gA+yF+066031BZtvjbnBr81l++
 oV+WGUxgt+DjGY+lGmUThU8mdtfiAsdLFZz3OqkMbz0Pit6Xcy8oJ5GWt0cTghyzaFwT
 +1vNzLKPsdW2zr2JSiyqMEHHwRVeEHoy/VMrHMR/KuntNQOKgPIva02H3oHbIh+PjZsb
 w2oop1c8gHsZnpL9K4fXgG+8KRh1jgQZMeTmRhYmlZOf3Loffn/maZyChOcgSJtrJQwZ
 4F4s3hIRrWAXw2gshBTGmolEiUYESOsf0MwNlN2j6L2hr058ug+syLmJcvxKVaSjj/67 sA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k2p75n1es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 16:39:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69Gdedf015786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 16:39:41 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w69Gdef3023836;
        Mon, 9 Jul 2018 16:39:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 09:39:40 -0700
Date:   Mon, 9 Jul 2018 09:39:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs_bmap_util: use swap macro
Message-ID: <20180709163939.GX32415@magnolia>
References: <20180709140539.GA17517@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709140539.GA17517@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8948 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:05:39AM -0500, Gustavo A. R. Silva wrote:
> Make use of the swap macro and remove some unnecessary variables.
> This makes the code easier to read and maintain. Also, reduces the
> stack usage.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  fs/xfs/xfs_bmap_util.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 83b1e8c..4b0b16f 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -1691,7 +1691,6 @@ xfs_swap_extent_forks(
>  	int			*src_log_flags,
>  	int			*target_log_flags)
>  {
> -	struct xfs_ifork	tempifp, *ifp, *tifp;
>  	xfs_filblks_t		aforkblks = 0;
>  	xfs_filblks_t		taforkblks = 0;
>  	xfs_extnum_t		junk;
> @@ -1733,11 +1732,7 @@ xfs_swap_extent_forks(
>  	/*
>  	 * Swap the data forks of the inodes
>  	 */
> -	ifp = &ip->i_df;
> -	tifp = &tip->i_df;
> -	tempifp = *ifp;		/* struct copy */
> -	*ifp = *tifp;		/* struct copy */
> -	*tifp = tempifp;	/* struct copy */
> +	swap(ip->i_df, tip->i_df);
>  
>  	/*
>  	 * Fix the on-disk inode values

Why not use swap() on the di_nextents and di_format exchange below here
too?

> @@ -1987,14 +1982,10 @@ xfs_swap_extents(
>  
>  	/* Swap the cow forks. */
>  	if (xfs_sb_version_hasreflink(&mp->m_sb)) {
> -		xfs_extnum_t	extnum;
> -
>  		ASSERT(ip->i_cformat == XFS_DINODE_FMT_EXTENTS);
>  		ASSERT(tip->i_cformat == XFS_DINODE_FMT_EXTENTS);
>  
> -		extnum = ip->i_cnextents;
> -		ip->i_cnextents = tip->i_cnextents;
> -		tip->i_cnextents = extnum;
> +		swap(ip->i_cnextents, tip->i_cnextents);
>  
>  		cowfp = ip->i_cowfp;
>  		ip->i_cowfp = tip->i_cowfp;

Same here -- why not use swap on {ip,tip}->i_cowfp?

--D

> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
