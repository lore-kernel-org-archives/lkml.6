Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04662C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42272184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="BlPpUj5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfBLFFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 00:05:41 -0500
Received: from sonic307-8.consmr.mail.gq1.yahoo.com ([98.137.64.32]:38229 "EHLO
        sonic307-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfBLFFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 00:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1549947939; bh=O43EgA4KPwj9jseo80KLpwDJ2LipJuxfwJoBHEg931Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=BlPpUj5HfY6BUtrDcNuUkjBnNpgKejImRnfVwLSWl9ShHyTY0aZqmoUBe8ZxWIV+qB9x0nRyx7JQXnyIfGcUxD6IbS5Ti46d8Wajpb8N+fkqor1XshdquivyNKCV5F8OS9fK/GHT9uCh7i+x+f1b1Qz0G9ulOCgaq77xuwHNospj/I+zQ1/ShpnBJ4pRFldqzYxFOyUxgBoIaN1Hg3E7HOOeLl3GUuzGYN7ook2BjEzPfEmobDVgEPGBjf4KsaAK1UAMMuGd6imMQnGX0PUIhB9xmW4zZ711KmrJQ6cmiiPhpml5ujjW+aXL0x8PbLK2S/fOZ1Zwjel/LsJEOgnhOQ==
X-YMail-OSG: Y17UrpEVM1k.AQbf0ocD7bJj9wemYqpqBxzhxVeR2UxJrqveQMWwwgG7cBhKVXM
 3W0iBGE0wPk3jhuB5g_R6kkhhUgjxdsA5ZnHEBz6O7lVHtsXw6kWpYTUQLmyixJ9.gKEkQ1lz_Vl
 OUc.r1yL7PMAMO9G3gDek95St3eVGrfNCo_a77ivlRE3HKQAn5D1SZT7tBaBPC26Qcx5EGy3jTYJ
 NsowsQ_Cy.Q728a0MiaCLhf3SBER.CakR7nITFQDFzCyM8aINO.71FE1YV8V_HmMQTJr0WSvozWu
 JPcEgU98V4N0LOexvHIp1DL1_B10PN6CdpT6Qwby2xhM.IeE_GAHQ8ODUar80BcpteWpRd0Pp2on
 Rx2qQvhN5cbR091q.zfeuy_ca0VKb2H0_Vcf_UIT31xDRT6KmUTWXkGgS.ZIp_YjK5D8SSk0OIPe
 QiHiylMAnulGJCsMT_L998TCtEE6nYniudFOwtliJ7XOz4d4vZLN97u.B8p_CGzy6bfJOsDTcT_Y
 FwC21gMjyRnkKgEkBWPrZOleIJpKLMJErQ25aJr5g7j1timIvwhB4.7itWIyBlF_mGIWNhkZcnhD
 ZPLMTCXv4EJEaoARuvD90xtohAXfK1pxoDUe_35rXqM_v_vCYuwjO0PLKhNWr7oXDz5iKZB.fy5c
 Io4cx0rMgU2BRAosrcSqV7jCrTD5fpp6vDyxtyq1U1U9UoCrTaEkuGNHjltcq.ehAlvSGB6cURLa
 0hxtbR2p5B5nndX5fMRi4b3HJQ8lZFJTlMXAXlRdR86UF5rdTJR51GTZ9vpZczbHnWjbqDAEpGmv
 kILcnSS_QDdhmgjkni7unHJgoJ3Qt1cQzuDcnsV7YPq.7a_zZPnOWmp9THB1OftBdaE3dwWv4At7
 fnRiyciII2PYvN0baCdgu_i0qdxOwceC_EN.5zBGsbyJyMY5TH9vi2L5.TtSoyH9XWhMgqrwmv03
 AHJf.K3zznFRjmQ6h6HwEWtePDRbQiH9HHCZgiwunRGjc4ZpLdoW3N_DUztuIVT_DHsP5dHp5Nc0
 fcxY2aNxX29Uyh8I8AYIfpoogZxn.WkSLq9wK6Sb43YK3frpvxVZ8XKdhHBuL5NM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Tue, 12 Feb 2019 05:05:39 +0000
Received: from 125.120.229.177 (EHLO [10.1.1.220]) ([125.120.229.177])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 125c43a692d34ae3e14932790e5f554f;
          Tue, 12 Feb 2019 05:05:37 +0000 (UTC)
Subject: Re: [PATCH v2] staging: erofs: keep corrupted fs from crashing kernel
 in erofs_namei()
To:     Chao Yu <yuchao0@huawei.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
References: <20190201121631.15179-1-gaoxiang25@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <00ce8e48-23cd-cfbe-997b-31311079bb61@aol.com>
Date:   Tue, 12 Feb 2019 13:05:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190201121631.15179-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping... some ideas about this patch v2? Thanks,

On 2019/2/1 20:16, Gao Xiang wrote:
> As Al pointed out, "
> ... and while we are at it, what happens to
> 	unsigned int nameoff = le16_to_cpu(de[mid].nameoff);
> 	unsigned int matched = min(startprfx, endprfx);
>
> 	struct qstr dname = QSTR_INIT(data + nameoff,
> 		unlikely(mid >= ndirents - 1) ?
> 			maxsize - nameoff :
> 			le16_to_cpu(de[mid + 1].nameoff) - nameoff);
>
> 	/* string comparison without already matched prefix */
> 	int ret = dirnamecmp(name, &dname, &matched);
> if le16_to_cpu(de[...].nameoff) is not monotonically increasing?  I.e.
> what's to prevent e.g. (unsigned)-1 ending up in dname.len?
>
> Corrupted fs image shouldn't oops the kernel.. "
>
> Revisit the related lookup flow to address the issue.
>
> Fixes: d72d1ce60174 ("staging: erofs: add namei functions")
> Cc: <stable@vger.kernel.org> # 4.19+
> Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> [ It should be better get reviewed first and for linux-next... ]
>
> change log v2:
>  - fix the missing "kunmap_atomic" pointed out by Dan;
>  - minor cleanup;
>
>  drivers/staging/erofs/namei.c | 187 ++++++++++++++++++++++--------------------
>  1 file changed, 99 insertions(+), 88 deletions(-)
>
> diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
> index 5596c52e246d..321c881d720f 100644
> --- a/drivers/staging/erofs/namei.c
> +++ b/drivers/staging/erofs/namei.c
> @@ -15,74 +15,77 @@
>  
>  #include <trace/events/erofs.h>
>  
> -/* based on the value of qn->len is accurate */
> -static inline int dirnamecmp(struct qstr *qn,
> -	struct qstr *qd, unsigned int *matched)
> +struct erofs_qstr {
> +	const unsigned char *name;
> +	const unsigned char *end;
> +};
> +
> +/* based on the end of qn is accurate and it must have the trailing '\0' */
> +static inline int dirnamecmp(const struct erofs_qstr *qn,
> +			     const struct erofs_qstr *qd,
> +			     unsigned int *matched)
>  {
> -	unsigned int i = *matched, len = min(qn->len, qd->len);
> -loop:
> -	if (unlikely(i >= len)) {
> -		*matched = i;
> -		if (qn->len < qd->len) {
> -			/*
> -			 * actually (qn->len == qd->len)
> -			 * when qd->name[i] == '\0'
> -			 */
> -			return qd->name[i] == '\0' ? 0 : -1;
> +	unsigned int i = *matched;
> +
> +	/*
> +	 * on-disk error, let's only BUG_ON in the debugging mode.
> +	 * otherwise, it will return 1 to just skip the invalid name
> +	 * and go on (in consideration of the lookup performance).
> +	 */
> +	DBG_BUGON(qd->name > qd->end);
> +
> +	/* qd could not have trailing '\0' */
> +	/* However it is absolutely safe if < qd->end */
> +	while (qd->name + i < qd->end && qd->name[i] != '\0') {
> +		if (qn->name[i] != qd->name[i]) {
> +			*matched = i;
> +			return qn->name[i] > qd->name[i] ? 1 : -1;
>  		}
> -		return (qn->len > qd->len);
> +		++i;
>  	}
> -
> -	if (qn->name[i] != qd->name[i]) {
> -		*matched = i;
> -		return qn->name[i] > qd->name[i] ? 1 : -1;
> -	}
> -
> -	++i;
> -	goto loop;
> +	*matched = i;
> +	/* See comments in __d_alloc on the terminating NUL character */
> +	return qn->name[i] == '\0' ? 0 : 1;
>  }
>  
> -static struct erofs_dirent *find_target_dirent(
> -	struct qstr *name,
> -	u8 *data, int maxsize)
> +#define nameoff_from_disk(off, sz)	(le16_to_cpu(off) & ((sz) - 1))
> +
> +static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
> +					       u8 *data,
> +					       unsigned int dirblksize,
> +					       const int ndirents)
>  {
> -	unsigned int ndirents, head, back;
> +	int head, back;
>  	unsigned int startprfx, endprfx;
>  	struct erofs_dirent *const de = (struct erofs_dirent *)data;
>  
> -	/* make sure that maxsize is valid */
> -	BUG_ON(maxsize < sizeof(struct erofs_dirent));
> -
> -	ndirents = le16_to_cpu(de->nameoff) / sizeof(*de);
> -
> -	/* corrupted dir (may be unnecessary...) */
> -	BUG_ON(!ndirents);
> -
> -	head = 0;
> +	/* since the 1st dirent has been evaluated previously */
> +	head = 1;
>  	back = ndirents - 1;
>  	startprfx = endprfx = 0;
>  
>  	while (head <= back) {
> -		unsigned int mid = head + (back - head) / 2;
> -		unsigned int nameoff = le16_to_cpu(de[mid].nameoff);
> +		const int mid = head + (back - head) / 2;
> +		const int nameoff = nameoff_from_disk(de[mid].nameoff,
> +						      dirblksize);
>  		unsigned int matched = min(startprfx, endprfx);
> -
> -		struct qstr dname = QSTR_INIT(data + nameoff,
> -			unlikely(mid >= ndirents - 1) ?
> -				maxsize - nameoff :
> -				le16_to_cpu(de[mid + 1].nameoff) - nameoff);
> +		struct erofs_qstr dname = {
> +			.name = data + nameoff,
> +			.end = unlikely(mid >= ndirents - 1) ?
> +				data + dirblksize :
> +				data + nameoff_from_disk(de[mid + 1].nameoff,
> +							 dirblksize)
> +		};
>  
>  		/* string comparison without already matched prefix */
>  		int ret = dirnamecmp(name, &dname, &matched);
>  
> -		if (unlikely(!ret))
> +		if (unlikely(!ret)) {
>  			return de + mid;
> -		else if (ret > 0) {
> +		} else if (ret > 0) {
>  			head = mid + 1;
>  			startprfx = matched;
> -		} else if (unlikely(mid < 1))	/* fix "mid" overflow */
> -			break;
> -		else {
> +		} else {
>  			back = mid - 1;
>  			endprfx = matched;
>  		}
> @@ -91,12 +94,12 @@ static struct erofs_dirent *find_target_dirent(
>  	return ERR_PTR(-ENOENT);
>  }
>  
> -static struct page *find_target_block_classic(
> -	struct inode *dir,
> -	struct qstr *name, int *_diff)
> +static struct page *find_target_block_classic(struct inode *dir,
> +					      struct erofs_qstr *name,
> +					      int *_ndirents)
>  {
>  	unsigned int startprfx, endprfx;
> -	unsigned int head, back;
> +	int head, back;
>  	struct address_space *const mapping = dir->i_mapping;
>  	struct page *candidate = ERR_PTR(-ENOENT);
>  
> @@ -105,41 +108,43 @@ static struct page *find_target_block_classic(
>  	back = inode_datablocks(dir) - 1;
>  
>  	while (head <= back) {
> -		unsigned int mid = head + (back - head) / 2;
> +		const int mid = head + (back - head) / 2;
>  		struct page *page = read_mapping_page(mapping, mid, NULL);
>  
> -		if (IS_ERR(page)) {
> -exact_out:
> -			if (!IS_ERR(candidate)) /* valid candidate */
> -				put_page(candidate);
> -			return page;
> -		} else {
> -			int diff;
> -			unsigned int ndirents, matched;
> -			struct qstr dname;
> +		if (!IS_ERR(page)) {
>  			struct erofs_dirent *de = kmap_atomic(page);
> -			unsigned int nameoff = le16_to_cpu(de->nameoff);
> -
> -			ndirents = nameoff / sizeof(*de);
> +			const int nameoff = nameoff_from_disk(de->nameoff,
> +							      EROFS_BLKSIZ);
> +			const int ndirents = nameoff / sizeof(*de);
> +			int diff;
> +			unsigned int matched;
> +			struct erofs_qstr dname;
>  
> -			/* corrupted dir (should have one entry at least) */
> -			BUG_ON(!ndirents || nameoff > PAGE_SIZE);
> +			if (unlikely(!ndirents)) {
> +				DBG_BUGON(1);
> +				kunmap_atomic(de);
> +				put_page(page);
> +				page = ERR_PTR(-EIO);
> +				goto out;
> +			}
>  
>  			matched = min(startprfx, endprfx);
>  
>  			dname.name = (u8 *)de + nameoff;
> -			dname.len = ndirents == 1 ?
> -				/* since the rest of the last page is 0 */
> -				EROFS_BLKSIZ - nameoff
> -				: le16_to_cpu(de[1].nameoff) - nameoff;
> +			if (ndirents == 1)
> +				dname.end = (u8 *)de + EROFS_BLKSIZ;
> +			else
> +				dname.end = (u8 *)de +
> +					nameoff_from_disk(de[1].nameoff,
> +							  EROFS_BLKSIZ);
>  
>  			/* string comparison without already matched prefix */
>  			diff = dirnamecmp(name, &dname, &matched);
>  			kunmap_atomic(de);
>  
>  			if (unlikely(!diff)) {
> -				*_diff = 0;
> -				goto exact_out;
> +				*_ndirents = 0;
> +				goto out;
>  			} else if (diff > 0) {
>  				head = mid + 1;
>  				startprfx = matched;
> @@ -147,47 +152,53 @@ static struct page *find_target_block_classic(
>  				if (likely(!IS_ERR(candidate)))
>  					put_page(candidate);
>  				candidate = page;
> +				*_ndirents = ndirents;
>  			} else {
>  				put_page(page);
>  
> -				if (unlikely(mid < 1))	/* fix "mid" overflow */
> -					break;
> -
>  				back = mid - 1;
>  				endprfx = matched;
>  			}
> +			continue;
>  		}
> +out:		/* free if the candidate is valid */
> +		if (!IS_ERR(candidate))
> +			put_page(candidate);
> +		return page;
>  	}
> -	*_diff = 1;
>  	return candidate;
>  }
>  
>  int erofs_namei(struct inode *dir,
> -	struct qstr *name,
> -	erofs_nid_t *nid, unsigned int *d_type)
> +		struct qstr *name,
> +		erofs_nid_t *nid, unsigned int *d_type)
>  {
> -	int diff;
> +	int ndirents;
>  	struct page *page;
> -	u8 *data;
> +	void *data;
>  	struct erofs_dirent *de;
> +	struct erofs_qstr qn;
>  
>  	if (unlikely(!dir->i_size))
>  		return -ENOENT;
>  
> -	diff = 1;
> -	page = find_target_block_classic(dir, name, &diff);
> +	qn.name = name->name;
> +	qn.end = name->name + name->len;
> +
> +	ndirents = 0;
> +	page = find_target_block_classic(dir, &qn, &ndirents);
>  
> -	if (unlikely(IS_ERR(page)))
> +	if (IS_ERR(page))
>  		return PTR_ERR(page);
>  
>  	data = kmap_atomic(page);
>  	/* the target page has been mapped */
> -	de = likely(diff) ?
> -		/* since the rest of the last page is 0 */
> -		find_target_dirent(name, data, EROFS_BLKSIZ) :
> -		(struct erofs_dirent *)data;
> +	if (ndirents)
> +		de = find_target_dirent(&qn, data, EROFS_BLKSIZ, ndirents);
> +	else
> +		de = (struct erofs_dirent *)data;
>  
> -	if (likely(!IS_ERR(de))) {
> +	if (!IS_ERR(de)) {
>  		*nid = le64_to_cpu(de->nid);
>  		*d_type = de->file_type;
>  	}
