Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D1EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE30B208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="di2BA9Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE30B208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbeHAKrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:47:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40054 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbeHAKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:47:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w718v9FY059965;
        Wed, 1 Aug 2018 09:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ZYRALe7c82nqu7xw7Wbt6qptIfJChNTjhmSYnBKVFSQ=;
 b=di2BA9Pt6LYgawoOKp8J3EvXCKxKC68JUX867ESu90RrJH9Lw1fbpeVpbbGHCCYhZYca
 Src7ds96ST6TxLzcO033BZgVBs/xb1cBtOq3+0i/auVOGUuo69BWXP3+x22Bxk6BFtsV
 a0fdhok7k95oJPqoKznyL9B/ZGtS3r5zS4MNpZOvd01WxyTTxVAYzjlwv5P+rbURBfIg
 GRmHDg7+3iuTqB/guFK2gejZNflQp3sJfVaWyppBcRPKfNZk31kZBJzf8zdzCUSsnQx3
 UpR4oJarNo19xBOPVAEe6s0h6GHE7gNX/KCZCp/BTKxiQCMOwyaXx3kaDfqIKkynMb9x Sw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kgh4q4j1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 09:02:54 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7192rVP005889
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 09:02:53 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7192p4T019549;
        Wed, 1 Aug 2018 09:02:52 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 02:02:51 -0700
Date:   Wed, 1 Aug 2018 12:02:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, yuchao0@huawei.com,
        linux-erofs@lists.ozlabs.org, hsiangkao@aol.com,
        linux-kernel@vger.kernel.org, weidu.du@huawei.com,
        miaoxie@huawei.com, chao@kernel.org
Subject: Re: [PATCH 1/2] staging: erofs: add the missing break in
 z_erofs_map_blocks_iter
Message-ID: <20180801090243.ah7lhj2h6hjtvn4a@mwanda>
References: <1532915461-2512-1-git-send-email-gaoxiang25@huawei.com>
 <1533105511-26197-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533105511-26197-1-git-send-email-gaoxiang25@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=959
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 02:38:30PM +0800, Gao Xiang wrote:
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index bd2d7a8..6d3ab31 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -1596,10 +1596,10 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  	cluster_type = vle_cluster_type(di);
>  
>  	switch (cluster_type) {
> -	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:	/* fallthrough */

This fallthrough comment is in the wrong place.  It should be at the end
where the break would have been.  Like this:

	switch (cluster_type) {
	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
		frob();
		frob();
		frob();
		/* fallthrough */
	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
		frob();

regards,
dan carpenter

