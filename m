Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C8CC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537D8218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rOoCDR/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbeLWWvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 17:51:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33840 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeLWWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 17:51:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBNMoj5D108758;
        Sun, 23 Dec 2018 22:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=e0z3DYVyUaMko8BGk6gA5izPjF3giCzJWTcRV7x8W5U=;
 b=rOoCDR/zRVzL+3jqUArdlSfAowLhTvc+26FsWtqT/4APr8ZMbzRnaKZWQsg2Tpvu51k8
 ZUPshHtlQ+4ROjeFKp/tQ7KqYvTfHQ8lM1GjXmJHzbAw6HT8IgikeNlA6Ly+4IvRnLsF
 wohhndxkhbk/tyNU5gI826ZXbYzagQo5htdxaG3NlTFun2Vw6KdKW21l4rx7MA/tFdKg
 d459CHXrjfXVddDtwMXPli3tzCmC9KTuVc/aTt4kt4XXxgyMZTYF8ARV2grQBI+dHOm2
 NtM8yJyWd9Ul2QIFwPjmZimQYZXo0GMSRAqZzO17+PrH96SuYOo80UpYH7wa8kG8BA5g ug== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2phdwqju4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Dec 2018 22:51:21 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBNMpKYH029073
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Dec 2018 22:51:21 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBNMpKZr025254;
        Sun, 23 Dec 2018 22:51:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Dec 2018 14:51:19 -0800
Date:   Sun, 23 Dec 2018 14:51:18 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/20] xfs: xfs_buf: drop useless LIST_HEAD
Message-ID: <20181223225118.GH27208@magnolia>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-9-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545555435-24576-9-git-send-email-Julia.Lawall@lip6.fr>
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

On Sun, Dec 23, 2018 at 09:57:03AM +0100, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares has never
> been used.
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
> Fixes: 26f1fe858f274 ("xfs: reduce lock hold times in buffer writeback")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Looks ok; are you planning to push this whole series directly to Linus
or do you want me to take the two xfs patches through?

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> ---
> Successfully 0-day tested on 151 configurations.
> 
>  fs/xfs/xfs_buf.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index b21ea2ba768d..eedc5e0156ff 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1992,7 +1992,6 @@ xfs_buf_delwri_submit_buffers(
>  	struct list_head	*wait_list)
>  {
>  	struct xfs_buf		*bp, *n;
> -	LIST_HEAD		(submit_list);
>  	int			pinned = 0;
>  	struct blk_plug		plug;
>  
> 
