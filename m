Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C14FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0433A218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VlNtAkml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfAYN0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:26:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39980 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYN0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:26:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0PDNlxa141111;
        Fri, 25 Jan 2019 13:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uD1NORlCeQhZxfmPF2/YqS9dFy+x7wKZsm8z1Uj6Fpw=;
 b=VlNtAkmlNLVAoz8VaLsNn+sv6bSrsSoQo6SztcrbKX5OB45n0aTnA7jogUxsIcNwDRvU
 CHQKmwSrvXUAbNrGDfKgku7aSOKdEFge+TYwf9ftxvDHzdBPZeoJx2R0j9gEAsXu2Zxh
 woqo3tOU0cmz53X0UyTeJ4aWfw1W8TdaCRQ/bYRu4OmAtkC8mCpIr1tMJnLQHO45LNmK
 nSBVZaDD3QYnxlfQIuuVT/3vT5rCqjF18FesghFRAluFak0b6hwTbH+LlxCyDClocjJG
 xrO35XK4XCd5NcnE7AoguA+s1dVpF9gFaNI9y/a3jdIwSGRo0wX0FEcEd4jNL+HsbCxY lA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2q3uav5u6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 13:26:33 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0PDQRiV021151
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 13:26:27 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0PDQQpv027277;
        Fri, 25 Jan 2019 13:26:26 GMT
Received: from kadam (/41.202.241.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jan 2019 05:26:25 -0800
Date:   Fri, 25 Jan 2019 16:26:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 1/2] staging: erofs: use xattr_prefix to wrap up
Message-ID: <20190125132614.GB1795@kadam>
References: <20190125115103.47250-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125115103.47250-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9146 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=834
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901250110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 07:51:03PM +0800, Gao Xiang wrote:
> Let's use xattr_prefix instead of open code.
> No logic changes.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
> index 1c9498e38f0e..eca65df46133 100644
> --- a/drivers/staging/erofs/xattr.c
> +++ b/drivers/staging/erofs/xattr.c
> @@ -521,7 +521,7 @@ static int xattr_entrylist(struct xattr_iter *_it,
>  		return 1;
>  
>  	/* Note that at least one of 'prefix' and 'name' should be non-NULL */

The comment is sort of confusing now.

> -	prefix = h->prefix != NULL ? h->prefix : h->name;
> +	prefix = xattr_prefix(h);
>  	prefix_len = strlen(prefix);

regards,
dan carpenter

