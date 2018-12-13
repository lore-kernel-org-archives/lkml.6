Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907D6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EF020873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544673059;
	bh=ET6G0COmJhTaHrrkYOzyPIJqXpsPaTfQJBYNYMIEw/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ITbs5ixjsrGTwOnQVaEV7Ow5YjI3/HP9+9afaaN21ax61NWEQPhCY3QCiMxjKjwPj
	 vqZqQ5rWPJOCEm0PRCk9KFMLa+Xw9JxurgHvGdcCIVcgRX3m5df56xRca0Gy6KomCX
	 LYhGFxNScm1meRDa6MlWEQ2yO7wRj6c0U0M08d3c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EF020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeLMDu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeLMDu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:50:57 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA01320870;
        Thu, 13 Dec 2018 03:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544673056;
        bh=ET6G0COmJhTaHrrkYOzyPIJqXpsPaTfQJBYNYMIEw/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rw8OQ8ypttR4rIpeFVqVqOlw2t9qTq6yOIA7bZ+GZCrvZaDwlk+a2L7zVG/HPOmY0
         kc4OmQI4w6l4fw+G7M5RzqMhPJn9UtL0yOQMVPpUAI9K/Jtr4Sm2LbE9/WYQLE6E5A
         aoP8BJpsQT0ABnZtWDwesT81ifQp29xUvLfKd1mM=
Date:   Wed, 12 Dec 2018 19:50:56 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yunlong Song <yunlong.song@huawei.com>
Cc:     chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com,
        miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: remove codes of unused wio_mutex
Message-ID: <20181213035056.GA33959@jaegeuk-macbookpro.roam.corp.google.com>
References: <1540368582-14312-1-git-send-email-yunlong.song@huawei.com>
 <1544586620-124300-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544586620-124300-1-git-send-email-yunlong.song@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12, Yunlong Song wrote:
> v1->v2: delete comments in f2fs.h: "/* bio ordering for NODE/DATA */"

It's quite late for me to rebase the repo. Could you please send another patch
for this?

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h  | 2 --
>  fs/f2fs/super.c | 5 +----
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1e03197..195850e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1170,8 +1170,6 @@ struct f2fs_sb_info {
>  
>  	/* for bio operations */
>  	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
> -	struct mutex wio_mutex[NR_PAGE_TYPE - 1][NR_TEMP_TYPE];
> -						/* bio ordering for NODE/DATA */
>  	/* keep migration IO order for LFS mode */
>  	struct rw_semaphore io_order_lock;
>  	mempool_t *write_io_dummy;		/* Dummy pages */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index af58b2c..2d18de5 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2674,7 +2674,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>  static void init_sb_info(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_super_block *raw_super = sbi->raw_super;
> -	int i, j;
> +	int i;
>  
>  	sbi->log_sectors_per_block =
>  		le32_to_cpu(raw_super->log_sectors_per_block);
> @@ -2710,9 +2710,6 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  
>  	INIT_LIST_HEAD(&sbi->s_list);
>  	mutex_init(&sbi->umount_mutex);
> -	for (i = 0; i < NR_PAGE_TYPE - 1; i++)
> -		for (j = HOT; j < NR_TEMP_TYPE; j++)
> -			mutex_init(&sbi->wio_mutex[i][j]);
>  	init_rwsem(&sbi->io_order_lock);
>  	spin_lock_init(&sbi->cp_lock);
>  
> -- 
> 1.8.5.2
