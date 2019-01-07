Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05693C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81492173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QHkq57RU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfAGRwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:52:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51160 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfAGRwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:52:42 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x07Hnof5047630;
        Mon, 7 Jan 2019 17:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=s2LBD94hLj5ql9xBoAg9k14arMuYBh89/DHoqGwn6LU=;
 b=QHkq57RUWb5nj7Ukmg4LnvW4N8D8El4jqu2ytwJCteA0V8XxznMdyr/8+tgD9b/2wCiP
 WzVkq+1JZBbfOmLN7dN9Bzro+qZvhVdKtOiEnf3GsrAqrX8l3+XGO9a8QBur+ZTGSi/k
 aB6+bMwLwu+XWjQe3PaeYx1sc1U639zfrOliEVn6Ks+hYt2nUZCYy/GpdYyWs7b8TsrJ
 knH/uR8zczCJmpP7eGyVirQYnjKlZsqu0MFLEvQVjtAytNupPYvXXz2+oCkBXQwX+RN8
 qizbaf8m1iFFqT0QS6+K0HGPrEpAsGEJjFooskZnn8pWaMwrb9nIfAWLgMWZ0IL3okz8 lw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2ptj3dqdvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jan 2019 17:52:37 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x07HqUVK014886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jan 2019 17:52:31 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x07HqU26008758;
        Mon, 7 Jan 2019 17:52:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jan 2019 09:52:30 -0800
Date:   Mon, 7 Jan 2019 09:52:29 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        suyanjun218@gmail.com
Subject: Re: [PATCH] xfs: correct statx's result_mask value
Message-ID: <20190107175229.GJ12689@magnolia>
References: <1546854790-5233-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546854790-5233-1-git-send-email-suyj.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=939
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901070152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:53:10AM -0500, Su Yanjun wrote:
> For statx syscall, xfs return the wrong result_mask.
> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> ---
>  fs/xfs/xfs_iops.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index f48ffd7..3811457 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -521,6 +521,9 @@ xfs_vn_getattr(
>  			stat->btime.tv_nsec = ip->i_d.di_crtime.t_nsec;
>  		}
>  	}
> +	
> +	/* Only return mask that we care */
> +	stat->result_mask &= request_mask;

Why not just:

	stat->result_mask = STATX_BASIC_STATS;

at the top of the function?

I don't see the need to mask off result_mask at all, since we could some
day elect to return more than what's in request_mask...

...waitaminute, are you seeing garbage in the result_mask that's
returned to userspace?  I also noticed the vfs stat functions declare
"struct kstat stat;" without explicitly zeroing the structure fields,
which means (I think) that we can leak stack information if the kernel
isn't built with the stackleak plugin?

--D

>  
>  	if (ip->i_d.di_flags & XFS_DIFLAG_IMMUTABLE)
>  		stat->attributes |= STATX_ATTR_IMMUTABLE;
> -- 
> 2.7.4
> 
> 
> 
