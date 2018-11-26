Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C68C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0572082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HRo6ODsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0572082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeK0JyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:54:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeK0JyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:54:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQMn6W0030269;
        Mon, 26 Nov 2018 22:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=umQuzIlveJO+Wftrn+hwFLZD03vV+6ComziA6mXhCQ8=;
 b=HRo6ODsPje7o32nOblIHaZ7Buv3OW+ahtAjyg1LjODTpg6ZaJatJodp/PQyT/GUJuAy2
 IoWnSIEZEk4OOq7dxsJeyLHl1yfaZK4s3vyuOBFpE+0GzKVxghtEClM/KudGRL2OH5CV
 GHKTGyFAn0Hu4vHIT4HH8OziA0xOFevkdLJx5bN3svrA9KHmLG6TWz0m9rT/XJfEeNCS
 D/ZymxEDUiFzDlL6WiU0E0ZVjfkEy/CH6/pNazxhjZOL0H1BUZwt2DhzZ3FdSmvQHQyI
 vRPkBWOPqs3zbmQn4f0FncnctfWHi+TKhY70zOJ9lTazWx1qhoJk9nsp/1Pue/k9QH+K MA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nxy9r0pp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 22:58:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAQMwRMW003663
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 22:58:27 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAQMwQ7h028070;
        Mon, 26 Nov 2018 22:58:26 GMT
Received: from localhost (/10.159.254.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 14:58:26 -0800
Date:   Mon, 26 Nov 2018 14:58:25 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-xfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: clean up indentation issues, remove an unwanted
 space
Message-ID: <20181126225825.GD6792@magnolia>
References: <20181123165913.26671-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123165913.26671-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=820
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 04:59:13PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a statement that has an unwanted space in the indentation.
> Remove it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 05db9540e459..f21756751540 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2242,7 +2242,7 @@ xfs_ifree_cluster(
>  		 * want it to fail. We can acheive this by adding a write
>  		 * verifier to the buffer.
>  		 */
> -		 bp->b_ops = &xfs_inode_buf_ops;
> +		bp->b_ops = &xfs_inode_buf_ops;
>  
>  		/*
>  		 * Walk the inodes already attached to the buffer and mark them
> -- 
> 2.19.1
> 
