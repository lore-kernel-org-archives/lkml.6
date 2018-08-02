Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_NUMERIC_HELO,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC12C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74BD21502
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="fzcQ1QvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74BD21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeHBMCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:02:12 -0400
Received: from sonic304-21.consmr.mail.gq1.yahoo.com ([98.137.68.202]:45211
        "EHLO sonic304-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729899AbeHBMCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1533204703; bh=HrtkK0C7kZYvziIO8+wFz35PAuq36ciVOdiM4vLe/m8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=fzcQ1QvJHw4PN1becOD9aQmr5nnDs1rydlpXGvwsvQbKJyqDpriKF35FuGZ6ySg9kA6u8jG/rsB/rO/qbYaY9FvgHtBGpWTsRBRcqh8hkgPYT4PK+smr0zM23fcDWoZfPiK1l/8ZCXwCVFBVJVTwU3yOIPp0lCK3jgKwpDWX/oqf29EAiOJne6jbpAGE6cF008677UlDQyyN7jd1x8fF+O4nfecIyZVMJAwye6rU9VUDrEVELTw3n8I4xNKorDXFKI/LM1UushHNP1JWDGqUYQwSqhowbp+TOMc4UwWbc5PwbhA6+V45eiNE7Cg9QW9n/NRbdDR7DhFf01pH87fIGA==
X-YMail-OSG: NTyMQgsVM1kq24YmcDr9WOpZuClzxunaGPGpPAzyf6CoHsk32wufpt.ozEpY4oo
 Q2zxF.VhuVDVfkqQ.9H.JoVvDh0L.J1Sk4xq6PyldKDHNEkQzB4sInlQBRKJbT0iFozKOPY1pPve
 htL3kaJt2KeTLPKVC03cQEC8xg8XXbd9pX8GxUYYPgnJrR2LE2cGwx53QAQH.w5Gw.59X9zgcvmy
 N8Wb1sohzeuFA8KtNWAHjGRiG9ACPIAaSUeCAyZDTPOUUbm2xC6N5154uQEccOFmsxTQkN9fiW7b
 5zHBuQJ3QppEJMFDfLtdlBflbUttesPggUTyxZbj5k7jlYbyDKlugCFsZLOOu63ptUArBxp_dG8b
 XpbMLnhdboP3hZYpUdgtOY2nx80RhJNOWrd2rVad_lipuiQjqoCuTZrRXpZbIEMQ4V64XaHsNYYl
 S3bADS0msfKWJO7w3MAZNZKP.acqVT03UanxSU6gjqt7lIZcqoyUEbDwgErpIt239b2yXntcHbcp
 MP_9M6pcuAtR_FmrF0aiVfzjFA5dyF5701ODAYH.8nFVOXFrZxQ4eFn3yHAnqo5seGv6NdORBGww
 gS_dIHba2sO0A3A6r5okvfuBNdV6kdY9mQ7gilhXZQWNxoxkyRKb6A36QdbHHIEftsavJ1L5soto
 L0rsmZ.rXVvJnW.0vXPcYylLpewC4s6OCXDxZu_mdWC2pGlu3ZQwDVlFkE.m0zygPt54ZUJiBhEK
 y8bnOrAM4J9ljym5497BOCMnFNIvsNTsMzcyOcBJEinpoYT5PYIpaFQXYSW6ghgVSntB1caHSh68
 BQGIa5LV6Z9CpO1kMmAYuQuQBWCf.rJIHnKFHO9f3z94kuGZxI.LJ1EoTn44hn1y9O6uoDcoYjZr
 hq2vUqB50anZK3PwwdVwsv_7CUotwTCXpKZUTziSAKeU7Nx3Sh92llNljNBzAyx8RJ36WD.N6YfF
 0WzUui.Y3M_vs7HHSXl8gjK3ulQ1ersx69y7B0zVhCFSkBJXVHdi_hkogHoCcQP1_zFQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Thu, 2 Aug 2018 10:11:43 +0000
Received: from 116.226.251.211 (EHLO [192.168.1.7]) ([116.226.251.211])
          by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 96c0ccc3a5e883287c422848c187df51;
          Thu, 02 Aug 2018 10:11:42 +0000 (UTC)
Subject: Re: [PATCH v2] staging: erofs: disable compiling temporarile
To:     Chao Yu <yuchao0@huawei.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, chao@kernel.org
References: <20180802093917.4796-1-yuchao0@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <27867b85-f2d9-2562-73ab-96807ec469a9@aol.com>
Date:   Thu, 2 Aug 2018 18:11:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802093917.4796-1-yuchao0@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2018/8/2 17:39, Chao Yu wrote:
> As Stephen Rothwell reported:
>
> "After merging the staging tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/staging/erofs/super.c: In function 'erofs_read_super':
> drivers/staging/erofs/super.c:343:17: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
>                  ^~~~~~~~~
>                  IS_RDONLY
> drivers/staging/erofs/super.c:343:17: note: each undeclared identifier is reported only once for each function it appears in
> drivers/staging/erofs/super.c:343:29: error: 'MS_NOATIME' undeclared (first use in this function); did you mean 'S_NOATIME'?
>   sb->s_flags |= MS_RDONLY | MS_NOATIME;
>                              ^~~~~~~~~~
>                              S_NOATIME
> drivers/staging/erofs/super.c: In function 'erofs_mount':
> drivers/staging/erofs/super.c:501:10: warning: passing argument 5 of 'mount_bdev' makes integer from pointer without a cast [-Wint-conversion]
>    &priv, erofs_fill_super);
>           ^~~~~~~~~~~~~~~~
> In file included from include/linux/buffer_head.h:12:0,
>                  from drivers/staging/erofs/super.c:14:
> include/linux/fs.h:2151:23: note: expected 'size_t {aka long unsigned int}' but argument is of type 'int (*)(struct super_block *, void *, int)'
>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>                        ^~~~~~~~~~
> drivers/staging/erofs/super.c:500:9: error: too few arguments to function 'mount_bdev'
>   return mount_bdev(fs_type, flags, dev_name,
>          ^~~~~~~~~~
> In file included from include/linux/buffer_head.h:12:0,
>                  from drivers/staging/erofs/super.c:14:
> include/linux/fs.h:2151:23: note: declared here
>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>                        ^~~~~~~~~~
> drivers/staging/erofs/super.c: At top level:
> drivers/staging/erofs/super.c:518:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>   .mount          = erofs_mount,
>                     ^~~~~~~~~~~
> drivers/staging/erofs/super.c:518:20: note: (near initialization for 'erofs_fs_type.mount')
> drivers/staging/erofs/super.c: In function 'erofs_remount':
> drivers/staging/erofs/super.c:630:12: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
>   *flags |= MS_RDONLY;
>             ^~~~~~~~~
>             IS_RDONLY
> drivers/staging/erofs/super.c: At top level:
> drivers/staging/erofs/super.c:640:16: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>   .remount_fs = erofs_remount,
>                 ^~~~~~~~~~~~~
>
> Caused by various commits creating erofs in the staging tree interacting
> with various commits redoing the mount infrastructure in the vfs tree.
>
> I have disabed CONFIG_EROFS_FS for now:"
>
> The reason of compiling error is:
>
> Since -next collects and merges developing patches including common vfs
> stuff from multi-trees, but those patches didn't cover erofs, such as:
>
> ('vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled")
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=109b45090d7d3ce2797bb1ef7f70eead5bfe0ff3
>
> ("vfs: Require specification of size of mount data for internal mounts")
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=0a191e4505a4f255e6513b49426213da69bf0e80
>
> Above vfs related patches has not been merged in staging tree, if we
> submit those erofs patches to staging mailing list and after including
> them in staging-{test,nexts} tree, it can easily cause compiling error.
>
> We worked out some patches to adjust those vfs change, but now we just
> submit them to -next tree temporarily to avoid compiling error.
>
> For potentail conflict in between erofs and vfs changes in incoming
> merge window, Stephen suggested that we can disable CONFIG_EROFS_FS
> temporarily to pass merge window, and after that we can do restore by
> reenabling CONFIG_EROFS_FS and applying those fixing patches. Also
> Greg confirmed this solution.
>
> So, let's disable compiling erofs for a while.
>
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  drivers/staging/erofs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
> index 663b755bf2fb..96f614934df1 100644
> --- a/drivers/staging/erofs/Kconfig
> +++ b/drivers/staging/erofs/Kconfig
> @@ -2,7 +2,7 @@
>  
>  config EROFS_FS
>  	tristate "EROFS filesystem support"
> -	depends on BLOCK
> +	depends on BROKEN

How about remaining "depends on BLOCK" but just adding "depends on BROKEN"?

Thanks
Gao Xiang
>  	help
>  	  EROFS(Enhanced Read-Only File System) is a lightweight
>  	  read-only file system with modern designs (eg. page-sized

