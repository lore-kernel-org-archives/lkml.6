Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A8FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C66120684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GDOoiHLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C66120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbeGQRsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:48:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57700 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbeGQRsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:48:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HHECg2188817;
        Tue, 17 Jul 2018 17:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TYoc6Kmf3ok2lVrsYqwt3TfX/vwoXp/cYegNF2dw6Hk=;
 b=GDOoiHLQcOHY063+NF6LJI1kqb69W4W+OlCC4YCp7QW3PFx+ohU1R4FUIlj6X6iLxla5
 aky+g9gDaElJfTLmPmqCzwnGJZ2OiAloiW8SO/Nvmt8hZZW5dpBaNH5wHNZKfrHjN45y
 U0i44TJBuGNtrxV6IA6iK5OzS5LAmphem4SlKr99qqPLadWKFUyb7zoM2u2KSB637qGB
 8b2ViBDRcbTvvuT04yOsygOHr3ElvJS6y4Q29ZTY9u7+gQeaOBwl7x4tii7kVb3c5Ml0
 v73qT98TFbCzlBmTPkuyhULFQN5l1Y/SHjOO01tdsUoEJwauTzhrKypGJ9nkKOSwYUk8 ZA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k7a3jsr24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 17:14:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6HHEgQv016284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 17:14:42 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6HHEfPA014012;
        Tue, 17 Jul 2018 17:14:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 10:14:41 -0700
Date:   Tue, 17 Jul 2018 10:14:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: use swap macro in xfs_dir2_leafn_rebalance
Message-ID: <20180717171433.GU32415@magnolia>
References: <20180717161127.GA16337@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717161127.GA16337@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:11:27AM -0500, Gustavo A. R. Silva wrote:
> Make use of the swap macro and remove unnecessary variable *tmp*. This
> makes the code easier to read and maintain. Also, slightly refactor some
> code.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Looks ok, will test...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/libxfs/xfs_dir2_node.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
> index 2daf874..f1bb343 100644
> --- a/fs/xfs/libxfs/xfs_dir2_node.c
> +++ b/fs/xfs/libxfs/xfs_dir2_node.c
> @@ -1012,7 +1012,7 @@ xfs_dir2_leafn_rebalance(
>  	int			oldstale;	/* old count of stale leaves */
>  #endif
>  	int			oldsum;		/* old total leaf count */
> -	int			swap;		/* swapped leaf blocks */
> +	int			swap_blocks;	/* swapped leaf blocks */
>  	struct xfs_dir2_leaf_entry *ents1;
>  	struct xfs_dir2_leaf_entry *ents2;
>  	struct xfs_dir3_icleaf_hdr hdr1;
> @@ -1023,13 +1023,10 @@ xfs_dir2_leafn_rebalance(
>  	/*
>  	 * If the block order is wrong, swap the arguments.
>  	 */
> -	if ((swap = xfs_dir2_leafn_order(dp, blk1->bp, blk2->bp))) {
> -		xfs_da_state_blk_t	*tmp;	/* temp for block swap */
> +	swap_blocks = xfs_dir2_leafn_order(dp, blk1->bp, blk2->bp);
> +	if (swap_blocks)
> +		swap(blk1, blk2);
>  
> -		tmp = blk1;
> -		blk1 = blk2;
> -		blk2 = tmp;
> -	}
>  	leaf1 = blk1->bp->b_addr;
>  	leaf2 = blk2->bp->b_addr;
>  	dp->d_ops->leaf_hdr_from_disk(&hdr1, leaf1);
> @@ -1093,11 +1090,11 @@ xfs_dir2_leafn_rebalance(
>  	 * Mark whether we're inserting into the old or new leaf.
>  	 */
>  	if (hdr1.count < hdr2.count)
> -		state->inleaf = swap;
> +		state->inleaf = swap_blocks;
>  	else if (hdr1.count > hdr2.count)
> -		state->inleaf = !swap;
> +		state->inleaf = !swap_blocks;
>  	else
> -		state->inleaf = swap ^ (blk1->index <= hdr1.count);
> +		state->inleaf = swap_blocks ^ (blk1->index <= hdr1.count);
>  	/*
>  	 * Adjust the expected index for insertion.
>  	 */
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
