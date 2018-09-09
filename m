Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B0EC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7994C20857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w9HaahVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7994C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIIUGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 16:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbeIIUGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 16:06:35 -0400
Received: from [192.168.0.101] (unknown [49.77.179.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA3BB20854;
        Sun,  9 Sep 2018 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536506195;
        bh=xQeLXlHtiY6SVf/ncPXzo1l9YtE8TnEryhPYuKn6LOw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=w9HaahVaEndoXHaMJEKpWsy5LuD2/fVQK2zAdrA5tLoRyNQ7ZeolLuFGHMjSp1uvx
         sEoP1pkiNuShDpb84Ju5SJ7K+SA9EC5TlnApwGogTzww2Rq6ljBzPBspUHw8p+VPV1
         rSxRoUr9plXngg+IJYH86F6DVG4cJdos5xQtKi4w=
Subject: Re: [PATCH v2] staging: erofs: use explicit unsigned int type
To:     Gao Xiang <gaoxiang25@huawei.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180830205605.19492-1-linux@weissschuh.net>
 <20180907163912.3686-1-linux@weissschuh.net>
 <5c44a63b-041d-1fce-0748-53c0b44f5983@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <9f2c06f5-05db-a117-bb11-92c1ae517b09@kernel.org>
Date:   Sun, 9 Sep 2018 23:16:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5c44a63b-041d-1fce-0748-53c0b44f5983@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2018/9/8 11:28, Gao Xiang wrote:
> Hi Thomas,
> 
> Thanks for your new patch.
> 
> It seems that this patch also introduces 2 new 'WARNING: line over 80 characters',
> could you please fix it in the patch?

It will be better to fix that.

Some reviewed cleanup patches are merged before this patch, then I failed to add
this one, so could you rebase on top of erofs dev branch in below link:

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=erofs

Thanks,

> 
> On 2018/9/8 0:39, Thomas Weißschuh wrote:
>> Changes since v1:
>>
>> * Removed changes that conflicted with
>>   [PATCH 1/6] staging: erofs: formatting fix in unzip_vle_lz4.c
>> * Added patch description
>>
>> -- >8 --
>>
>> Fix coding style issue "Prefer 'unsigned int' to bare use of 'unsigned'"
>> detected by checkpatch.pl
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>
>> ---
>>  drivers/staging/erofs/data.c      |  4 +--
>>  drivers/staging/erofs/dir.c       | 14 ++++-----
>>  drivers/staging/erofs/inode.c     |  6 ++--
>>  drivers/staging/erofs/namei.c     | 28 +++++++++---------
>>  drivers/staging/erofs/super.c     |  2 +-
>>  drivers/staging/erofs/unzip_vle.c | 48 +++++++++++++++----------------
>>  drivers/staging/erofs/utils.c     |  2 +-
>>  drivers/staging/erofs/xattr.c     | 40 +++++++++++++-------------
>>  8 files changed, 72 insertions(+), 72 deletions(-)
>>
>> diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
>> index 3c0d9159514e..e1916101ad75 100644
>> --- a/drivers/staging/erofs/data.c
>> +++ b/drivers/staging/erofs/data.c
>> @@ -202,7 +202,7 @@ static inline struct bio *erofs_read_raw_page(
>>  	struct address_space *mapping,
>>  	struct page *page,
>>  	erofs_off_t *last_block,
>> -	unsigned nblocks,
>> +	unsigned int nblocks,
>>  	bool ra)
>>  {
>>  	struct inode *inode = mapping->host;
>> @@ -236,7 +236,7 @@ static inline struct bio *erofs_read_raw_page(
>>  			.m_la = blknr_to_addr(current_block),
>>  		};
>>  		erofs_blk_t blknr;
>> -		unsigned blkoff;
>> +		unsigned int blkoff;
>>  
>>  		err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
>>  		if (unlikely(err))
>> diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
>> index be6ae3b1bdbe..87f12b0f983f 100644
>> --- a/drivers/staging/erofs/dir.c
>> +++ b/drivers/staging/erofs/dir.c
>> @@ -24,8 +24,8 @@ static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
>>  };
>>  
>>  static int erofs_fill_dentries(struct dir_context *ctx,
>> -	void *dentry_blk, unsigned *ofs,
>> -	unsigned nameoff, unsigned maxsize)
>> +	void *dentry_blk, unsigned int *ofs,
>> +	unsigned int nameoff, unsigned int maxsize)
>>  {
>>  	struct erofs_dirent *de = dentry_blk;
>>  	const struct erofs_dirent *end = dentry_blk + nameoff;
>> @@ -36,7 +36,7 @@ static int erofs_fill_dentries(struct dir_context *ctx,
>>  		int de_namelen;
>>  		unsigned char d_type;
>>  #ifdef CONFIG_EROFS_FS_DEBUG
>> -		unsigned dbg_namelen;
>> +		unsigned int dbg_namelen;
>>  		unsigned char dbg_namebuf[EROFS_NAME_LEN];
>>  #endif
>>  
>> @@ -81,15 +81,15 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>  	struct inode *dir = file_inode(f);
>>  	struct address_space *mapping = dir->i_mapping;
>>  	const size_t dirsize = i_size_read(dir);
>> -	unsigned i = ctx->pos / EROFS_BLKSIZ;
>> -	unsigned ofs = ctx->pos % EROFS_BLKSIZ;
>> +	unsigned int i = ctx->pos / EROFS_BLKSIZ;
>> +	unsigned int ofs = ctx->pos % EROFS_BLKSIZ;
>>  	int err = 0;
>>  	bool initial = true;
>>  
>>  	while (ctx->pos < dirsize) {
>>  		struct page *dentry_page;
>>  		struct erofs_dirent *de;
>> -		unsigned nameoff, maxsize;
>> +		unsigned int nameoff, maxsize;
>>  
>>  		dentry_page = read_mapping_page(mapping, i, NULL);
>>  		if (IS_ERR(dentry_page))
>> @@ -109,7 +109,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>  			goto skip_this;
>>  		}
>>  
>> -		maxsize = min_t(unsigned, dirsize - ctx->pos + ofs, PAGE_SIZE);
>> +		maxsize = min_t(unsigned int, dirsize - ctx->pos + ofs, PAGE_SIZE);
> 
> WARNING: line over 80 characters
> #102: FILE: drivers/staging/erofs/dir.c:112:
> +               maxsize = min_t(unsigned int, dirsize - ctx->pos + ofs, PAGE_SIZE);
> 
> 
>>  
>>  		/* search dirents at the arbitrary position */
>>  		if (unlikely(initial)) {
>> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
>> index fbf6ff25cd1b..70d34b0a97fe 100644
>> --- a/drivers/staging/erofs/inode.c
>> +++ b/drivers/staging/erofs/inode.c
>> @@ -19,7 +19,7 @@ static int read_inode(struct inode *inode, void *data)
>>  {
>>  	struct erofs_vnode *vi = EROFS_V(inode);
>>  	struct erofs_inode_v1 *v1 = data;
>> -	const unsigned advise = le16_to_cpu(v1->i_advise);
>> +	const unsigned int advise = le16_to_cpu(v1->i_advise);
>>  
>>  	vi->data_mapping_mode = __inode_data_mapping(advise);
>>  
>> @@ -112,7 +112,7 @@ static int read_inode(struct inode *inode, void *data)
>>   * try_lock since it takes no much overhead and
>>   * will success immediately.
>>   */
>> -static int fill_inline_data(struct inode *inode, void *data, unsigned m_pofs)
>> +static int fill_inline_data(struct inode *inode, void *data, unsigned int m_pofs)
> 
> WARNING: line over 80 characters
> #124: FILE: drivers/staging/erofs/inode.c:115:
> +static int fill_inline_data(struct inode *inode, void *data, unsigned int m_pofs)
> 
> Thanks,
> Gao Xiang
> 
