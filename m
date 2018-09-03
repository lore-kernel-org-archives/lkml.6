Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D5EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A7D20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h1ZXatIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A7D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeIDA5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:57:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39304 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbeIDA5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:57:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w83KYfGi043441;
        Mon, 3 Sep 2018 20:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=f2nsS6++Mzt9Kyr5GKjkCgSLFO1l5fAY1zY33A/5Z0Q=;
 b=h1ZXatIVzHgIShV0nBZ+G0wqzQQmk+7zFyCMRVtX6SrCPhYAbM3o9pRjAJnrPzxGDGC1
 WWU2JT1dvScnKuk9fXTyd5EV8/QXa9E7/yGAmmdE2RoxfmZDE/UJDp6gSwj34OPA294O
 ZbBiAJMHBNZ8YHyTf9hWXJ7/e3OEwyMTz9uJQuLj3gx2NDSm7gU6gJc19Ks8RxPyZibg
 G2ff0RjAiVHh3bhyo07kglRc776+cyUir4MOwGHz0s1PV7NzJiQnYx7ehxNGaBDQk+OS
 8xv+72rwsu3hNbZsSwTh0XKjbsIv5IPtKcqgDCUM15lcI9oT1Bs179D7b/Yp0QImjK92 DA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2m7jqp98j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Sep 2018 20:34:41 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w83KYeu1025357
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Sep 2018 20:34:40 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w83KYbgL006213;
        Mon, 3 Sep 2018 20:34:37 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Sep 2018 20:34:37 +0000
Subject: Re: [Jfs-discussion] [PATCH v2 4/5] jfs: cache NULL when both
 default_acl and acl are NULL
To:     Chengguang Xu <cgxu519@gmx.com>, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        shaggy@kernel.org, hubcap@omnibond.com, martin@omnibond.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        devel@lists.orangefs.org
References: <20180831143352.22970-1-cgxu519@gmx.com>
 <20180831143352.22970-4-cgxu519@gmx.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <0e37733e-9acd-cf82-62f7-420f0fa864eb@oracle.com>
Date:   Mon, 3 Sep 2018 15:34:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180831143352.22970-4-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9005 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809030217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are you pushing these as a series, or would you like this patch pushed
through the jfs tree?

On 8/31/18 9:33 AM, Chengguang Xu wrote:
> default_acl and acl of newly created inode will be initiated
> as ACL_NOT_CACHED in vfs function inode_init_always() and later
> will be updated by calling xxx_init_acl() in specific filesystems.
> Howerver, when default_acl and acl are NULL then they keep the value
> of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
> in this case.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
> v1->v2:
> - Coding style change.
> 
>  fs/jfs/acl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
> index 2e71b6e7e646..8c06a6ea862d 100644
> --- a/fs/jfs/acl.c
> +++ b/fs/jfs/acl.c
> @@ -146,12 +146,16 @@ int jfs_init_acl(tid_t tid, struct inode *inode, struct inode *dir)
>  	if (default_acl) {
>  		rc = __jfs_set_acl(tid, inode, ACL_TYPE_DEFAULT, default_acl);
>  		posix_acl_release(default_acl);
> +	} else {
> +		inode->i_default_acl = NULL;
>  	}
>  
>  	if (acl) {
>  		if (!rc)
>  			rc = __jfs_set_acl(tid, inode, ACL_TYPE_ACCESS, acl);
>  		posix_acl_release(acl);
> +	} else {
> +		inode->i_acl = NULL;
>  	}
>  
>  	JFS_IP(inode)->mode2 = (JFS_IP(inode)->mode2 & 0xffff0000) |
> 
