Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF18C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C031217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cjDxGj6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbeLWWvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 17:51:41 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41350 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeLWWvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 17:51:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBNMnoEw103094;
        Sun, 23 Dec 2018 22:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dB9WeypycoN9rS1T8JgGb9dZqtJ+SThQbCjNqY2v0zw=;
 b=cjDxGj6tZTCPfvp+Lw4JyUvANmJxziukaI7jYs4h38xTg+9u9QJfmX1eqfE6S1MbveJD
 4BQy0VlVzq35OR+6ATDG/MLYaGFtmBV6pQRhz/djN4OSD1j6Q7bvE3J32tTVbxxcLq8F
 CE5WEKX4Tg5/XvSpv/4KR3bx47cO/ZBiqTm8b5wTK7Td3Dj3RnHRaUt3NpDcYXZCA4K9
 4rHxfBLuYZI/1cVB1Ae3SX7FtlIA1QpoBGeC2zKDl83RW4vEW93RlNlYMNKARieAmNBc
 bJPSUTA4A8XavmaLdif6mNpvFVj6a7d7boEI2xkma7KueJ+Q73Jc/yM2fighsltcx2A/ JQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2phasdk2p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Dec 2018 22:51:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBNMpUSK017528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Dec 2018 22:51:30 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBNMpUAI013189;
        Sun, 23 Dec 2018 22:51:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Dec 2018 14:51:29 -0800
Date:   Sun, 23 Dec 2018 14:51:28 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/20] xfs: xfs_fsops: drop useless LIST_HEAD
Message-ID: <20181223225128.GI27208@magnolia>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-10-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545555435-24576-10-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9116 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812230207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 09:57:04AM +0100, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares is never used.
> 
> Commit 0410c3bb2b88 ("xfs: factor ag btree root block
> initialisation") stopped using buffer_list and started using a
> buffer list in an aghdr_init_data structure, but the declaration
> of buffer_list was not removed.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier x;
> @@
> - LIST_HEAD(x);
>   ... when != x
> // </smpl>
> 
> Fixes: 0410c3bb2b88 ("xfs: factor ag btree root block initialisation")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> ---
> Successfully 0-day tested on 151 configurations.
> 
>  fs/xfs/xfs_fsops.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index ec2e63a7963b..f3ef70c542e1 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -40,7 +40,6 @@ xfs_growfs_data_private(
>  	xfs_rfsblock_t		new;
>  	xfs_agnumber_t		oagcount;
>  	xfs_trans_t		*tp;
> -	LIST_HEAD		(buffer_list);
>  	struct aghdr_init_data	id = {};
>  
>  	nb = in->newblocks;
> 
