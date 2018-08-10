Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F765C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAADA2245B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aX+USAqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAADA2245B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHJVQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:16:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53112 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeHJVQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:16:46 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7AIcqBF122037;
        Fri, 10 Aug 2018 18:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OuzMpBRxYHnzCtzbFDP8qbj4wFGKCRKlJ5yyBZjBAgg=;
 b=aX+USAqzSYCHFikzFB+CeI1fL7YCfZ6Uv+xyJ42Cn3cpydhcpAmN9gkBeiRZGcutSTUD
 Bk4I4/VcONlEgpe+RmjL3fut9AIYVnYzcwDX7f5cKgnsxFc0dgs0FOSYoF+OhxxYbjY6
 wDl2lqKSiuxIeAEMAIVhCa8e6skUCoYMif/8Sgc53TANgI85kYw6Zi7EMKJ8+nsMv4qK
 Vq2c4013C9sk3aebGkh39zIwoZKnw98aM3AlCSefzSfxlUEpqhO13q2ci5ApZ4YShOq9
 kc3WyGXjHTjTFnvR+Mq3kcCdIhYYYEO2NM05VR47XIAr3PmHABMr4efSyVDsQ6GjkCP+ Ig== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2kn1ndgpmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Aug 2018 18:45:37 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7AIja34003387
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Aug 2018 18:45:36 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7AIjZeg017900;
        Fri, 10 Aug 2018 18:45:36 GMT
Received: from localhost (/10.159.234.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Aug 2018 11:45:35 -0700
Date:   Fri, 10 Aug 2018 11:45:34 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Switch to offset_in_page for clarity
Message-ID: <20180810184534.GG12194@magnolia>
References: <20180810145627.12266-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810145627.12266-1-agruenba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8981 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808100201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add linux-xfs to cc]

On Fri, Aug 10, 2018 at 04:56:27PM +0200, Andreas Gruenbacher wrote:
> Instead of open-coding pos & (PAGE_SIZE - 1) and pos & ~PAGE_MASK, use
> the offset_in_page macro.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks ok, will test...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 13cdcf33e6c0..ae317ac7e925 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -150,7 +150,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  {
>  	struct iomap_readpage_ctx *ctx = data;
>  	struct page *page = ctx->cur_page;
> -	unsigned poff = pos & (PAGE_SIZE - 1);
> +	unsigned poff = offset_in_page(pos);
>  	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
>  	bool is_contig = false;
>  	sector_t sector;
> @@ -280,7 +280,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  	loff_t done, ret;
>  
>  	for (done = 0; done < length; done += ret) {
> -		if (ctx->cur_page && ((pos + done) & (PAGE_SIZE - 1)) == 0) {
> +		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
>  			if (!ctx->cur_page_in_bio)
>  				unlock_page(ctx->cur_page);
>  			put_page(ctx->cur_page);
> @@ -382,9 +382,9 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
>  	loff_t block_size = i_blocksize(inode);
>  	loff_t block_start = pos & ~(block_size - 1);
>  	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
> -	unsigned poff = block_start & (PAGE_SIZE - 1);
> +	unsigned poff = offset_in_page(block_start);
>  	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, block_end - block_start);
> -	unsigned from = pos & (PAGE_SIZE - 1), to = from + len;
> +	unsigned from = offset_in_page(pos), to = from + len;
>  
>  	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE);
>  
> @@ -538,7 +538,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		unsigned long bytes;	/* Bytes to write to page */
>  		size_t copied;		/* Bytes copied from user */
>  
> -		offset = (pos & (PAGE_SIZE - 1));
> +		offset = offset_in_page(pos);
>  		bytes = min_t(unsigned long, PAGE_SIZE - offset,
>  						iov_iter_count(i));
>  again:
> @@ -652,7 +652,7 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		unsigned long offset;	/* Offset into pagecache page */
>  		unsigned long bytes;	/* Bytes to write to page */
>  
> -		offset = (pos & (PAGE_SIZE - 1));
> +		offset = offset_in_page(pos);
>  		bytes = min_t(loff_t, PAGE_SIZE - offset, length);
>  
>  		rpage = __iomap_read_page(inode, pos);
> @@ -744,7 +744,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
>  	do {
>  		unsigned offset, bytes;
>  
> -		offset = pos & (PAGE_SIZE - 1); /* Within page */
> +		offset = offset_in_page(pos);
>  		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
>  
>  		if (IS_DAX(inode))
> @@ -837,7 +837,7 @@ int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  
>  	/* page is wholly or partially inside EOF */
>  	if (((page->index + 1) << PAGE_SHIFT) > size)
> -		length = size & ~PAGE_MASK;
> +		length = offset_in_page(size);
>  	else
>  		length = PAGE_SIZE;
>  
> @@ -1000,7 +1000,7 @@ page_seek_hole_data(struct inode *inode, struct page *page, loff_t *lastoff,
>  		goto out_unlock_not_found;
>  
>  	for (off = 0; off < PAGE_SIZE; off += bsize) {
> -		if ((*lastoff & ~PAGE_MASK) >= off + bsize)
> +		if (offset_in_page(*lastoff) >= off + bsize)
>  			continue;
>  		if (ops->is_partially_uptodate(page, off, bsize) == seek_data) {
>  			unlock_page(page);
> -- 
> 2.17.1
> 
