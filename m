Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2l8ZNdkbHVvzOQAAmS7hNA
	; Sun, 10 Jun 2018 12:38:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C3AB960850; Sun, 10 Jun 2018 12:38:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2F6AB606DD;
	Sun, 10 Jun 2018 12:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F6AB606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753898AbeFJMir (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 08:38:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:51818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753431AbeFJMio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 08:38:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56B7EACA3;
        Sun, 10 Jun 2018 12:38:42 +0000 (UTC)
Subject: Re: [PATCH V6 19/30] md/dm/bcache: conver to
 bio_for_each_chunk_segment_all and bio_for_each_chunk_all
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-20-ming.lei@redhat.com>
From: Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5467522a-4bf6-1ec6-6aad-545d9b3da15e@suse.de>
Date: Sun, 10 Jun 2018 20:38:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180609123014.8861-20-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/9 8:30 PM, Ming Lei wrote:
> In bch_bio_alloc_pages(), bio_for_each_chunk_all() is fine because this
> helper can only be used on a freshly new bio.
> 
> For other cases, we conver to bio_for_each_chunk_segment_all() since they needn't
> to update bvec table.
> 
> bio_for_each_segment_all() can't be used any more after multipage bvec is
> enabled, so we have to convert to bio_for_each_chunk_segment_all().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I am OK with the bcache part. Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/btree.c | 3 ++-
>  drivers/md/bcache/util.c  | 2 +-
>  drivers/md/dm-crypt.c     | 3 ++-
>  drivers/md/raid1.c        | 3 ++-
>  4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 2a0968c04e21..dc0747c37bdf 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -423,8 +423,9 @@ static void do_btree_node_write(struct btree *b)
>  		int j;
>  		struct bio_vec *bv;
>  		void *base = (void *) ((unsigned long) i & ~(PAGE_SIZE - 1));
> +		struct bvec_chunk_iter citer;
>  
> -		bio_for_each_segment_all(bv, b->bio, j)
> +		bio_for_each_chunk_segment_all(bv, b->bio, j, citer)
>  			memcpy(page_address(bv->bv_page),
>  			       base + j * PAGE_SIZE, PAGE_SIZE);
>  
> diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
> index fc479b026d6d..2f05199f7edb 100644
> --- a/drivers/md/bcache/util.c
> +++ b/drivers/md/bcache/util.c
> @@ -268,7 +268,7 @@ int bch_bio_alloc_pages(struct bio *bio, gfp_t gfp_mask)
>  	int i;
>  	struct bio_vec *bv;
>  
> -	bio_for_each_segment_all(bv, bio, i) {
> +	bio_for_each_chunk_all(bv, bio, i) {
>  		bv->bv_page = alloc_page(gfp_mask);
>  		if (!bv->bv_page) {
>  			while (--bv >= bio->bi_io_vec)
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index da02f4d8e4b9..637ef1b1dc43 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -1450,8 +1450,9 @@ static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
>  {
>  	unsigned int i;
>  	struct bio_vec *bv;
> +	struct bvec_chunk_iter citer;
>  
> -	bio_for_each_segment_all(bv, clone, i) {
> +	bio_for_each_chunk_segment_all(bv, clone, i, citer) {
>  		BUG_ON(!bv->bv_page);
>  		mempool_free(bv->bv_page, &cc->page_pool);
>  	}
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index bad28520719b..2a4f1037c680 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -2116,13 +2116,14 @@ static void process_checks(struct r1bio *r1_bio)
>  		struct page **spages = get_resync_pages(sbio)->pages;
>  		struct bio_vec *bi;
>  		int page_len[RESYNC_PAGES] = { 0 };
> +		struct bvec_chunk_iter citer;
>  
>  		if (sbio->bi_end_io != end_sync_read)
>  			continue;
>  		/* Now we can 'fixup' the error value */
>  		sbio->bi_status = 0;
>  
> -		bio_for_each_segment_all(bi, sbio, j)
> +		bio_for_each_chunk_segment_all(bi, sbio, j, citer)
>  			page_len[j] = bi->bv_len;
>  
>  		if (!status) {
> 
