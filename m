Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeEMWVV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 18:21:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41809 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeEMWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 18:21:20 -0400
X-Google-Smtp-Source: AB8JxZqZiRQEuBXmM9bNby2uun+xV7spapUjWEMRw/+HiYYvDC2la8GaEj+7MlI+u2TTNyxIWf7agw==
Date: Sun, 13 May 2018 18:21:18 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Joe Perches <joe@perches.com>
cc: Al Viro <viro@ZenIV.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cramfs: Fix IS_ENABLED typo
In-Reply-To: <6cb70923c547bb95496833593f994f4e2de6b0ab.camel@perches.com>
Message-ID: <nycvar.YSQ.7.76.1805131818520.3749@knanqh.ubzr>
References: <6cb70923c547bb95496833593f994f4e2de6b0ab.camel@perches.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2018, Joe Perches wrote:

> There's an extra C here...
> 
> Fixes: 99c18ce580c6 ("cramfs: direct memory access support")
> Signed-off-by: Joe Perches <joe@perches.com>

Indeed.

Acked-by: Nicolas Pitre <nico@linaro.org>

@Al: could you pick up this one too?


> ---
>  fs/cramfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 017b0ab19bc4..124b093d14e5 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -492,7 +492,7 @@ static void cramfs_kill_sb(struct super_block *sb)
>  {
>  	struct cramfs_sb_info *sbi = CRAMFS_SB(sb);
>  
> -	if (IS_ENABLED(CCONFIG_CRAMFS_MTD) && sb->s_mtd) {
> +	if (IS_ENABLED(CONFIG_CRAMFS_MTD) && sb->s_mtd) {
>  		if (sbi && sbi->mtd_point_size)
>  			mtd_unpoint(sb->s_mtd, 0, sbi->mtd_point_size);
>  		kill_mtd_super(sb);
> 
> 
