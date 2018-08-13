Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631ACC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B70217B7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x0oisH0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B70217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeHMO3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:29:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57694 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbeHMO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:29:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7DBi92t069623;
        Mon, 13 Aug 2018 11:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lrQZdEQVKZOrwAznS+xOMEMAzIHUSe/dm+4Ql2ttzhs=;
 b=x0oisH0i163WIRBt1h3uqNeWPBJiAmCewC94NnF3AO/um1PpgBw/j85OoH4kwAJUGE5W
 IGnZ3HVLhrGzviwTLXqlz7NviSryzGoqGFgtp0g4y7HQY5tMfDQhD5+6Fsu73g3Clytx
 qSw3jPgwscJFMaeHluxvJec+9/O8+35J8DibSOe+LRsDaUSZki7kDtRwpQSh0o/leFoz
 my2DFiaVfwMHGvBi4N8F8OGcZj6gVw0Va6dMl51Ljn+l7PKHiKD8+z2rgpEQOKUTg46E
 MouTXVAP5DBwcmI1grBRoa012NH2rCYIXKJvd/BPy60HtsgYzIADD3hzcPICuK7J0isr OQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2ksq7t3twq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 11:47:35 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7DBlYsE018140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 11:47:35 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7DBlYLV005576;
        Mon, 13 Aug 2018 11:47:34 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 04:47:32 -0700
Date:   Mon, 13 Aug 2018 14:47:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <chao@kernel.org>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] staging: erofs: add error handling for xattr
 submodule
Message-ID: <20180813114725.kgoupvppcwsw2vyj@mwanda>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-4-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812140150.13397-4-chao@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808130128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static void xattr_iter_fixup(struct xattr_iter *it)
> +static inline int xattr_iter_fixup(struct xattr_iter *it)
>  {
> -	if (unlikely(it->ofs >= EROFS_BLKSIZ)) {
> -		xattr_iter_end(it, true);
> +	if (likely(it->ofs < EROFS_BLKSIZ))
> +		return 0;
>  
> -		it->blkaddr += erofs_blknr(it->ofs);
> -		it->page = erofs_get_meta_page_nofail(it->sb,
> -			it->blkaddr, false);
> -		BUG_ON(IS_ERR(it->page));
> +	xattr_iter_end(it, true);
>  
> -		it->kaddr = kmap_atomic(it->page);
> -		it->ofs = erofs_blkoff(it->ofs);
> +	it->blkaddr += erofs_blknr(it->ofs);
> +
> +	it->page = erofs_get_meta_page(it->sb, it->blkaddr, false);
> +	if (IS_ERR(it->page)) {
> +		it->page = NULL;
> +		return PTR_ERR(it->page);

This is returning PTR_ERR(NULL) which is success.  There is a smatch
test for this and maybe other static checkers as well so it would have
been caught very quickly.

>  	}
> +
> +	it->kaddr = kmap_atomic(it->page);
> +	it->ofs = erofs_blkoff(it->ofs);
> +	return 0;
>  }
>  
>  static int inline_xattr_iter_begin(struct xattr_iter *it,
> @@ -134,22 +154,25 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
>  	it->blkaddr = erofs_blknr(iloc(sbi, vi->nid) + inline_xattr_ofs);
>  	it->ofs = erofs_blkoff(iloc(sbi, vi->nid) + inline_xattr_ofs);
>  
> -	it->page = erofs_get_inline_page_nofail(inode, it->blkaddr);
> -	BUG_ON(IS_ERR(it->page));
> -	it->kaddr = kmap_atomic(it->page);
> +	it->page = erofs_get_inline_page(inode, it->blkaddr);
> +	if (IS_ERR(it->page))
> +		return PTR_ERR(it->page);
>  
> +	it->kaddr = kmap_atomic(it->page);
>  	return vi->xattr_isize - xattr_header_sz;
>  }
>  
>  static int xattr_foreach(struct xattr_iter *it,
> -	struct xattr_iter_handlers *op, unsigned *tlimit)
> +	const struct xattr_iter_handlers *op, unsigned *tlimit)
>  {
>  	struct erofs_xattr_entry entry;
>  	unsigned value_sz, processed, slice;
>  	int err;
>  
>  	/* 0. fixup blkaddr, ofs, ipage */
> -	xattr_iter_fixup(it);
> +	err = xattr_iter_fixup(it);
> +	if (unlikely(err))
> +		return err;
>  
>  	/*
>  	 * 1. read xattr entry to the memory,
> @@ -181,7 +204,9 @@ static int xattr_foreach(struct xattr_iter *it,
>  		if (it->ofs >= EROFS_BLKSIZ) {
>  			BUG_ON(it->ofs > EROFS_BLKSIZ);
>  
> -			xattr_iter_fixup(it);
> +			err = xattr_iter_fixup(it);
> +			if (unlikely(err))
> +				goto out;
>  			it->ofs = 0;
>  		}
>  
> @@ -213,7 +238,10 @@ static int xattr_foreach(struct xattr_iter *it,
>  	while (processed < value_sz) {
>  		if (it->ofs >= EROFS_BLKSIZ) {
>  			BUG_ON(it->ofs > EROFS_BLKSIZ);
> -			xattr_iter_fixup(it);
> +
> +			err = xattr_iter_fixup(it);
> +			if (unlikely(err))
> +				goto out;
>  			it->ofs = 0;
>  		}
>  
> @@ -273,7 +301,7 @@ static void xattr_copyvalue(struct xattr_iter *_it,
>  	memcpy(it->buffer + processed, buf, len);
>  }
>  
> -static struct xattr_iter_handlers find_xattr_handlers = {
> +static const struct xattr_iter_handlers find_xattr_handlers = {
>  	.entry = xattr_entrymatch,
>  	.name = xattr_namematch,
>  	.alloc_buffer = xattr_checkbuffer,
> @@ -294,8 +322,11 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
>  		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
>  		if (ret >= 0)
>  			break;
> +
> +		if (unlikely(ret != -ENOATTR))	/* -ENOMEM, -EIO, etc. */

I have held off commenting on all the likely/unlikely annotations we
are adding because I don't know what the fast paths are in this code.
However, this is clearly an error path here, not on a fast path.

Generally the rule on likely/unlikely is that they hurt readability so
we should only add them if it makes a difference in benchmarking.

> +			break;
>  	}
> -	xattr_iter_end(&it->it, true);
> +	xattr_iter_end_final(&it->it);
>  
>  	return ret < 0 ? ret : it->buffer_size;
>  }
> @@ -318,9 +349,10 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
>  			if (i)
>  				xattr_iter_end(&it->it, true);
>  
> -			it->it.page = erofs_get_meta_page_nofail(sb,
> -				blkaddr, false);
> -			BUG_ON(IS_ERR(it->it.page));
> +			it->it.page = erofs_get_meta_page(sb, blkaddr, false);
> +			if (IS_ERR(it->it.page))
> +				return PTR_ERR(it->it.page);
> +
>  			it->it.kaddr = kmap_atomic(it->it.page);
>  			it->it.blkaddr = blkaddr;
>  		}
> @@ -328,9 +360,12 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
>  		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
>  		if (ret >= 0)
>  			break;
> +
> +		if (unlikely(ret != -ENOATTR))	/* -ENOMEM, -EIO, etc. */
> +			break;
>  	}
>  	if (vi->xattr_shared_count)
> -		xattr_iter_end(&it->it, true);
> +		xattr_iter_end_final(&it->it);
>  
>  	return ret < 0 ? ret : it->buffer_size;
>  }
> @@ -355,7 +390,9 @@ int erofs_getxattr(struct inode *inode, int index,
>  	if (unlikely(name == NULL))
>  		return -EINVAL;
>  
> -	init_inode_xattrs(inode);
> +	ret = init_inode_xattrs(inode);
> +	if (unlikely(ret < 0))
> +		return ret;
>  
>  	it.index = index;
>  
> @@ -498,7 +535,7 @@ static int xattr_skipvalue(struct xattr_iter *_it,
>  	return 1;

Not related to your patch but what does "return 1;" mean here?  It's
weird to me that xattr_skipvalue() doesn't use value_sz at all.  I can't
decide if the function always succeeds or always fails.

The xattr_skipvalue/alloc_buffer function is called like this:

	err = op->alloc_buffer(it, value_sz);
	if (err) {
		it->ofs += value_sz;
		goto out;
	}

It looks like if we hit an error, we increase it->ofs.  All the other
error paths in this function take a negative error and increase it->ofs
so this looks like an error path.  The goto out look like this:

	/* we assume that ofs is aligned with 4 bytes */
	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
	return err;

So we return 1 here and the callers all treat it at success...  There
needs to be some documentation for what positive returns mean.

regards,
dan carpenter
