Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E3BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B4D21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="bpYX4ltB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B4D21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIUE1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:27:09 -0400
Received: from sonic304-50.consmr.mail.gq1.yahoo.com ([98.137.68.232]:36451
        "EHLO sonic304-50.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbeIUE1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1537483282; bh=+mr7lOtk6rA3ohC2jYoNCBiIeKkLWX9kl6c7IbD0yUo=; h=Subject:To:References:From:Cc:Date:In-Reply-To:From:Subject; b=bpYX4ltBKJ0CF37ctPBTcmDvnLUKYiCnWXaV0JyPQJj00R6LWBB265lTAh0xuyHXkn0CkdshlcJnVkKtm8C1Rf5tZUR+GcaBIHdQ4euDO0o6qsqUlqJmWZntien++t0KH5Mpt8NrO67sGWtctNTPBlkH9mVfMBiUWkt23HSO0qX38gO3WYLpHaOF8CUo/iCzStCxKVbXRKvudVrFhJmuJsET2pGWWFvq5kC58GMYHFEKMoOwpuZb+dunoA/wFLfjB99qxJpg4r3/PegWvWKMJEWzvEqj/AUaR9bQX2hRv5KIHGkHfrHzGDUE0plQNfNkrFLtjn2BBfqtCpIamAymxw==
X-YMail-OSG: 2gQUZfYVM1kDaiLNW9jip5LcL2EnI_bRmarXpKcOfz.zt6Y_M1UfOrEtfkoa8qa
 BkVekm_fWoXwn5dWM1kJjh4nRrRfMVXUJBE7g1pmP1lTmxo_snp9_5N5D3XgoZru0U36Mz.Bj9wH
 bhTU53q3hcFXfblELJuMzW18N0SNiVazfNsqb_SEwOSBk1NER6HTXScccRAFGl2gWYLM.lz44Qho
 J78w8G1Bp39zm72VqT9.3ujK68yxwWx493KvQ_vlbUeRQMDsDLyiJEXQi1jdzkseUpr8iOwRVHLj
 hbzZjFwLXhkJtkodqBpT.K1IPnw2Lp4jZCGFfWuTBEmlYuVIto7V3uaKpjkQXjFHuGaLahRj8zYq
 Hr_itZt40RtakdJXI3cPrvrtQJ_vfd5uSnULDiUvcFdHC8F7_BiiswGGWYG2N1vrHlp_uuawXB8S
 Uu9bZHWKD7Ss.ny0vbQoM40J6gWa6jYe4V3z2HsW3Hhrev0ncM8j.kt7N4vDl_s.3mM51XlbwxT7
 ZHgvIuUw3qE3xZ9c3satr.l5Jl3TCHfxzRau8_geQhxg3uQh_GXoW2mW5LItd4vY.4CFtOxmw750
 JsASVuRqJGxqb0Id7e0ALusIv1VlU09rit.1XWuHtHNa1QlNySrWuybrgplnkvF7NLB9pQmwh4S3
 pYO1u6H7b0arQ5BEEVbQnwV_twQoaVftM72KepkXvOp0n_E3nPMXvAEXmQIeUa35vb2bd86H95U7
 uXxhLPgNec.gX66FS5VgtJ7nDstT4kk9YU4v8sJdDErN0m5CSIhpxxrPp5jEv7dN6ZPNaOR64iOy
 I.ZsD09KLiohmC949hi9xtMcIAj_XeOgcVnp05GDo6L7JWyMn_wM8QqL9eCfu5mNw4VqXLX7OFu.
 rqDPn_zH1zrpgCEy6rqfnyz.wsMRpgZlsuhORtn1MHsoNXOH_whkLizvzptlcH4Mgo9Hzfsy_Nc5
 GQWU4bjyoH7AK8yksfNwpFGvvuW4lIyMejiHtSy09F2.Tw9slZGt4DXpw4TfN32Bd2FDwfm8QvkL
 L0YPC
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Thu, 20 Sep 2018 22:41:22 +0000
Received: from 218.108.98.82 (EHLO [192.168.250.210]) ([218.108.98.82])
          by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cde33dac55d4efc9c74ca6ca2b738da5;
          Thu, 20 Sep 2018 22:37:22 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: fix undeclared symbols
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
References: <20180920185856.14322-1-linux@weissschuh.net>
From:   Gao Xiang <hsiangkao@aol.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <d701027e-9050-6e93-0d0e-0534d057929d@aol.com>
Date:   Fri, 21 Sep 2018 06:37:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920185856.14322-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2018/9/21 2:58, Thomas Weißschuh wrote:
> Move all internal symbols to the internal header file and add a missing
> "static" declaration.
> This fixes the sparse warnings like the following:
> 
> drivers/staging/erofs/unzip_lz4.c:230:5: warning: symbol 'z_erofs_unzip_lz4' was not declared. Should it be static?
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/staging/erofs/data.c          |  5 -----
>  drivers/staging/erofs/internal.h      | 14 ++++++++++++++
>  drivers/staging/erofs/super.c         |  5 -----
>  drivers/staging/erofs/unzip_vle.c     |  2 +-
>  drivers/staging/erofs/unzip_vle_lz4.c |  2 --
>  drivers/staging/erofs/utils.c         |  2 --
>  6 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
> index ac263a180253..9bfcc549bbf0 100644
> --- a/drivers/staging/erofs/data.c
> +++ b/drivers/staging/erofs/data.c
> @@ -137,11 +137,6 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_EROFS_FS_ZIP
> -extern int z_erofs_map_blocks_iter(struct inode *,
> -	struct erofs_map_blocks *, struct page **, int);
> -#endif
> -
>  int erofs_map_blocks_iter(struct inode *inode,
>  	struct erofs_map_blocks *map,
>  	struct page **mpage_ret, int flags)
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index 367b39fe46e5..d4c4c87bcd35 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -547,6 +547,20 @@ extern unsigned long erofs_shrink_count(struct shrinker *shrink,
>  	struct shrink_control *sc);
>  extern unsigned long erofs_shrink_scan(struct shrinker *shrink,
>  	struct shrink_control *sc);
> +extern void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
> +
> +#ifdef CONFIG_EROFS_FS_ZIP
> +/* super.c */
> +extern int z_erofs_init_zip_subsystem(void);
> +extern void z_erofs_exit_zip_subsystem(void);
> +
> +/* unzip_vle.c */
> +extern int z_erofs_map_blocks_iter(struct inode *,
> +	struct erofs_map_blocks *, struct page **, int);
> +
> +/* unzip_lz4.c */
> +extern int z_erofs_unzip_lz4(void *in, void *out, size_t inlen, size_t outlen);

Thanks for your patch.

Here z_erofs_unzip_lz4 couldn't be directly declared in internal.h
   --- internal.h means the file system internal but not for the decompression algorithms.
 
Some declarations in *.c are for temporary use.
z_erofs_unzip_lz4 has no related with the file system itself and I planned to cleanup later
after we have more decompression algorithm support such as zstd....

If you want to cleanup now, prefer to introduce "decompressor wrappers" and a new .h
rather than cleanup as simple as what is done in this commit.

> +#endif
>  
>  #ifndef lru_to_page
>  #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index 2df9768edac9..c41d92e0cb3c 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -521,11 +521,6 @@ static struct file_system_type erofs_fs_type = {
>  };
>  MODULE_ALIAS_FS("erofs");
>  
> -#ifdef CONFIG_EROFS_FS_ZIP
> -extern int z_erofs_init_zip_subsystem(void);
> -extern void z_erofs_exit_zip_subsystem(void);
> -#endif
> -
>  static int __init erofs_module_init(void)
>  {
>  	int err;
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index 8721f0a41d15..a0d6c620051f 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -517,7 +517,7 @@ static void __z_erofs_vle_work_release(struct z_erofs_vle_workgroup *grp,
>  	erofs_workgroup_put(&grp->obj);
>  }
>  
> -void z_erofs_vle_work_release(struct z_erofs_vle_work *work)
> +static void z_erofs_vle_work_release(struct z_erofs_vle_work *work)
>  {
>  	struct z_erofs_vle_workgroup *grp =
>  		z_erofs_vle_work_workgroup(work, true);

How about making a separate patch to fix all the missing `static's?
Or How about changing your patch title "staging: erofs: fix undeclared symbols"
to indicate you also add some missing `static's ?

Thanks,
Gao Xiang

> diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
> index f5b665f15be5..e30e6e2ef05b 100644
> --- a/drivers/staging/erofs/unzip_vle_lz4.c
> +++ b/drivers/staging/erofs/unzip_vle_lz4.c
> @@ -99,8 +99,6 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
>  	return 0;
>  }
>  
> -extern int z_erofs_unzip_lz4(void *in, void *out, size_t inlen, size_t outlen);
> -
>  int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
>  				  unsigned clusterpages,
>  				  struct page **pages,
> diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
> index 595cf90af9bb..26b9f97f258a 100644
> --- a/drivers/staging/erofs/utils.c
> +++ b/drivers/staging/erofs/utils.c
> @@ -99,8 +99,6 @@ int erofs_register_workgroup(struct super_block *sb,
>  	return err;
>  }
>  
> -extern void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
> -
>  int erofs_workgroup_put(struct erofs_workgroup *grp)
>  {
>  	int count = atomic_dec_return(&grp->refcount);
> 
