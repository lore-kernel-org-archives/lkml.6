Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C78BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDB3217B7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oi9ea9Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDB3217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeHMOn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:43:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59572 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeHMOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:43:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7DBsPH6068413;
        Mon, 13 Aug 2018 12:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yZ1ePF1X9sN2+PKHlyQgROwwnxZWd9VxLphQ5Ggm/qc=;
 b=Oi9ea9PaOm77dyUyeeevohz58HtX7FaQ+AwbsCqtW5AmVwCHtkMGx+HCorJTBct+DAhz
 oDcXsXFb9cqOxUt0p0nekQgtGbnrE4Ool9uqIiY1c6AtoHgkFywCVRYteAf0ukZpOwaI
 s5B3ivpfSmYoUiwqGXsRTk4UJmiPAeZmXkvBe24KkwFERVZh+1hbwwXX8NntcZZaBmu9
 SB+ha1UcwTDRP0znVz+1zF6eq/UnumyGCM2eQDsrv7snGFJ1HnA6dl0XwMR002HA/Ykx
 56sCadimDaXt7Yin4yAHxxz6PJUflF41LW9rtuUaGofap60a9GwGiex9DfiecCNqZ7jU 0Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ksrepuss7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 12:01:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7DC155Z025414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 12:01:05 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7DC14BO014431;
        Mon, 13 Aug 2018 12:01:04 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 05:01:04 -0700
Date:   Mon, 13 Aug 2018 15:00:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <chao@kernel.org>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] staging: erofs: cleanup z_erofs_vle_work_{lookup,
 register}
Message-ID: <20180813120057.6grkpue6h7dtmpt2@mwanda>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-5-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812140150.13397-5-chao@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808130130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 10:01:46PM +0800, Chao Yu wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> This patch introduces 'struct z_erofs_vle_work_finder' to clean up
> arguments of z_erofs_vle_work_lookup and z_erofs_vle_work_register.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  drivers/staging/erofs/unzip_vle.c | 89 ++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index b2e05e2b4116..5032b3b05de1 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -271,36 +271,42 @@ static inline bool try_to_claim_workgroup(
>  	return true;	/* lucky, I am the followee :) */
>  }
>  
> +struct z_erofs_vle_work_finder {
> +	struct super_block *sb;
> +	pgoff_t idx;
> +	unsigned pageofs;
> +
> +	struct z_erofs_vle_workgroup **grp_ret;
> +	enum z_erofs_vle_work_role *role;
> +	z_erofs_vle_owned_workgrp_t *owned_head;
> +	bool *hosted;
> +};
> +
>  static struct z_erofs_vle_work *
> -z_erofs_vle_work_lookup(struct super_block *sb,
> -			pgoff_t idx, unsigned pageofs,
> -			struct z_erofs_vle_workgroup **grp_ret,
> -			enum z_erofs_vle_work_role *role,
> -			z_erofs_vle_owned_workgrp_t *owned_head,
> -			bool *hosted)
> +z_erofs_vle_work_lookup(const struct z_erofs_vle_work_finder *f)
>  {
>  	bool tag, primary;
>  	struct erofs_workgroup *egrp;
>  	struct z_erofs_vle_workgroup *grp;
>  	struct z_erofs_vle_work *work;
>  
> -	egrp = erofs_find_workgroup(sb, idx, &tag);
> +	egrp = erofs_find_workgroup(f->sb, f->idx, &tag);
>  	if (egrp == NULL) {
> -		*grp_ret = NULL;
> +		*f->grp_ret = NULL;

All these pointers to pointer seem a bit messy.  Just do this:

	struct z_erofs_vle_workgroup *grp;

Then replace "grp" in z_erofs_vle_work_iter_begin() with finder.grp;

regards,
dan carpenter

