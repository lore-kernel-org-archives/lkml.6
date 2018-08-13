Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89EAC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4B221767
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xWl6QZ08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4B221767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbeHMNqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:46:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54554 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbeHMNqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:46:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7DAxGKD029115;
        Mon, 13 Aug 2018 11:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=GmdtXyFP4FDw/SQjYO6enCAV8uVXorjxrsBh9Vzv+Dk=;
 b=xWl6QZ08Suh0vn8cWqUbs0bzVysUrRHUt/YeGWDWLwCQbbtrI1ZYWeSzRk8atixS+xH3
 xWG0lKOAC8N4Wjx4XqBu16KT1QeJ0CDYyXLIZvl48XnvNRFCt47i2lYoZyv5RjDJVySN
 pnxzsYGJfe8EDMoG3OcdfkykitnKhe2NDERhWzyhTlSimzZqiIJx6o2o4pVqVBezSztu
 hEOJpvngx5cAnBaDaXMkAIWX251rJKg7BB4TRjLrtEW6jT8gOdeQStGRgzvRs9tr/41k
 N5q07LfoIJnPeQGRUfftLBlxz2o7zhJ/VWhNzkoWap9f19rk1cUfJEEghX5C1DqSWfLF cQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ksrepumj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 11:04:16 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7DB4Gjb017221
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 11:04:16 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7DB4ECH019441;
        Mon, 13 Aug 2018 11:04:14 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 04:04:14 -0700
Date:   Mon, 13 Aug 2018 14:04:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <chao@kernel.org>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] staging: erofs: separate erofs_get_meta_page
Message-ID: <20180813110405.3qoburir3ds5ux33@mwanda>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-3-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812140150.13397-3-chao@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808130120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 10:01:44PM +0800, Chao Yu wrote:
> --- a/drivers/staging/erofs/data.c
> +++ b/drivers/staging/erofs/data.c
> @@ -39,31 +39,44 @@ static inline void read_endio(struct bio *bio)
>  }
>  
>  /* prio -- true is used for dir */
> -struct page *erofs_get_meta_page(struct super_block *sb,
> -	erofs_blk_t blkaddr, bool prio)
> +struct page *__erofs_get_meta_page(struct super_block *sb,
> +	erofs_blk_t blkaddr, bool prio, bool nofail)
>  {
> -	struct inode *bd_inode = sb->s_bdev->bd_inode;
> -	struct address_space *mapping = bd_inode->i_mapping;
> +	struct inode *const bd_inode = sb->s_bdev->bd_inode;
> +	struct address_space *const mapping = bd_inode->i_mapping;
> +	/* prefer retrying in the allocator to blindly looping below */
> +	const gfp_t gfp = mapping_gfp_constraint(mapping, ~__GFP_FS) |
> +		(nofail ? __GFP_NOFAIL : 0);
> +	unsigned int io_retries = nofail ? EROFS_IO_MAX_RETRIES_NOFAIL : 0;
>  	struct page *page;
>  
>  repeat:
> -	page = find_or_create_page(mapping, blkaddr,
> -	/*
> -	 * Prefer looping in the allocator rather than here,
> -	 * at least that code knows what it's doing.
> -	 */
> -		mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL);
> -
> -	BUG_ON(!page || !PageLocked(page));
> +	page = find_or_create_page(mapping, blkaddr, gfp);
> +	if (unlikely(page == NULL)) {
> +		DBG_BUGON(nofail);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	DBG_BUGON(!PageLocked(page));
>  
>  	if (!PageUptodate(page)) {
>  		struct bio *bio;
>  		int err;
>  
> -		bio = erofs_grab_bio(sb, blkaddr, 1, read_endio, true);
> +		bio = erofs_grab_bio(sb, blkaddr, 1, read_endio, nofail);
> +		if (unlikely(bio == NULL)) {
> +			DBG_BUGON(nofail);
> +			err = -ENOMEM;
> +err_out:
> +			unlock_page(page);
> +			put_page(page);
> +			return ERR_PTR(err);


Put this err_out stuff at the bottom of the function so that we don't
have to do backward hops to get to it.

> +		}
>  
>  		err = bio_add_page(bio, page, PAGE_SIZE, 0);
> -		BUG_ON(err != PAGE_SIZE);
> +		if (unlikely(err != PAGE_SIZE)) {
> +			err = -EFAULT;
> +			goto err_out;
                        ^^^^^^^^^^^^
Like this.  Generally avoid backwards hops if you can.

> +		}
>  
>  		__submit_bio(bio, REQ_OP_READ,
>  			REQ_META | (prio ? REQ_PRIO : 0));
> @@ -72,6 +85,7 @@ struct page *erofs_get_meta_page(struct super_block *sb,
>  
>  		/* the page has been truncated by others? */
>  		if (unlikely(page->mapping != mapping)) {
> +unlock_repeat:

The question mark in the "truncated by others?" is a little concerning.
It's slightly weird that we don't check "io_retries" on this path.

>  			unlock_page(page);
>  			put_page(page);
>  			goto repeat;
> @@ -79,10 +93,12 @@ struct page *erofs_get_meta_page(struct super_block *sb,
>  
>  		/* more likely a read error */
>  		if (unlikely(!PageUptodate(page))) {
> -			unlock_page(page);
> -			put_page(page);
> -
> -			page = ERR_PTR(-EIO);
> +			if (io_retries) {
> +				--io_retries;
> +				goto unlock_repeat;
> +			}
> +			err = -EIO;
> +			goto err_out;

regards,
dan carpenter

