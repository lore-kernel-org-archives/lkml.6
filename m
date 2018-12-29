Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6D4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 17:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6362145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 17:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeL2RCl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 12:02:41 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55279 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbeL2RCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 12:02:40 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43Rqd70g3vz9tyyN;
        Sat, 29 Dec 2018 18:02:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pekT2GIuErhr; Sat, 29 Dec 2018 18:02:35 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43Rqd66s6Tz9tyyM;
        Sat, 29 Dec 2018 18:02:34 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id B277E63B; Sat, 29 Dec 2018 18:02:36 +0100 (CET)
Received: from 37.164.147.219 ([37.164.147.219]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sat, 29 Dec 2018 18:02:36 +0100
Date:   Sat, 29 Dec 2018 18:02:36 +0100
Message-ID: <20181229180236.Horde.idY3gOIzkSWywjIrqlXJMA1@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-m68k@lists.linux-m68k.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 20/25] powerpc, fbdev: Use arch_nvram_ops methods
 instead of nvram_read_byte() and nvram_write_byte()
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <7e8eb87ea829c03941c895c968df2ebd0f80512f.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <7e8eb87ea829c03941c895c968df2ebd0f80512f.1545784679.git.fthain@telegraphics.com.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finn Thain <fthain@telegraphics.com.au> a écrit :

> Make use of arch_nvram_ops in device drivers so that the nvram_* function
> exports can be removed.
>
> Since they are no longer global symbols, rename the PPC32 nvram_* functions
> appropriately.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  arch/powerpc/kernel/setup_32.c             | 8 ++++----
>  drivers/char/generic_nvram.c               | 4 ++--
>  drivers/video/fbdev/controlfb.c            | 4 ++--
>  drivers/video/fbdev/imsttfb.c              | 4 ++--
>  drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
>  drivers/video/fbdev/platinumfb.c           | 4 ++--
>  drivers/video/fbdev/valkyriefb.c           | 4 ++--
>  7 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index e0d045677472..bdbe6acbef11 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -152,20 +152,18 @@ __setup("l3cr=", ppc_setup_l3cr);
>
>  #ifdef CONFIG_GENERIC_NVRAM
>
> -unsigned char nvram_read_byte(int addr)
> +static unsigned char ppc_nvram_read_byte(int addr)
>  {
>  	if (ppc_md.nvram_read_val)
>  		return ppc_md.nvram_read_val(addr);
>  	return 0xff;
>  }
> -EXPORT_SYMBOL(nvram_read_byte);
>
> -void nvram_write_byte(unsigned char val, int addr)
> +static void ppc_nvram_write_byte(unsigned char val, int addr)
>  {
>  	if (ppc_md.nvram_write_val)
>  		ppc_md.nvram_write_val(addr, val);
>  }
> -EXPORT_SYMBOL(nvram_write_byte);
>
>  static ssize_t ppc_nvram_get_size(void)
>  {
> @@ -182,6 +180,8 @@ static long ppc_nvram_sync(void)
>  }
>
>  const struct nvram_ops arch_nvram_ops = {
> +	.read_byte      = ppc_nvram_read_byte,
> +	.write_byte     = ppc_nvram_write_byte,
>  	.get_size       = ppc_nvram_get_size,
>  	.sync           = ppc_nvram_sync,
>  };
> diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
> index f32d5663de95..41b76bf9614e 100644
> --- a/drivers/char/generic_nvram.c
> +++ b/drivers/char/generic_nvram.c
> @@ -48,7 +48,7 @@ static ssize_t read_nvram(struct file *file, char  
> __user *buf,
>  	if (*ppos >= nvram_len)
>  		return 0;
>  	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count)
> -		if (__put_user(nvram_read_byte(i), p))
> +		if (__put_user(arch_nvram_ops.read_byte(i), p))

Instead of modifying all drivers (in this patch and previous ones  
related to other arches), wouldn't it be better to add helpers like  
the following in nvram.h:

Static inline unsigned char nvram_read_byte(int addr)
{
         return arch_nvram_ops.read_byte(addr);
}

Christophe

>  			return -EFAULT;
>  	*ppos = i;
>  	return p - buf;
> @@ -68,7 +68,7 @@ static ssize_t write_nvram(struct file *file,  
> const char __user *buf,
>  	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count) {
>  		if (__get_user(c, p))
>  			return -EFAULT;
> -		nvram_write_byte(c, i);
> +		arch_nvram_ops.write_byte(c, i);
>  	}
>  	*ppos = i;
>  	return p - buf;
> diff --git a/drivers/video/fbdev/controlfb.c  
> b/drivers/video/fbdev/controlfb.c
> index 9cb0ef7ac29e..27ff33ccafcb 100644
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -413,7 +413,7 @@ static int __init init_control(struct fb_info_control *p)
>  	/* Try to pick a video mode out of NVRAM if we have one. */
>  #ifdef CONFIG_NVRAM
>  	if (default_cmode == CMODE_NVRAM) {
> -		cmode = nvram_read_byte(NV_CMODE);
> +		cmode = arch_nvram_ops.read_byte(NV_CMODE);
>  		if(cmode < CMODE_8 || cmode > CMODE_32)
>  			cmode = CMODE_8;
>  	} else
> @@ -421,7 +421,7 @@ static int __init init_control(struct fb_info_control *p)
>  		cmode=default_cmode;
>  #ifdef CONFIG_NVRAM
>  	if (default_vmode == VMODE_NVRAM) {
> -		vmode = nvram_read_byte(NV_VMODE);
> +		vmode = arch_nvram_ops.read_byte(NV_VMODE);
>  		if (vmode < 1 || vmode > VMODE_MAX ||
>  		    control_mac_modes[vmode - 1].m[full] < cmode) {
>  			sense = read_control_sense(p);
> diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
> index 8d231591ff0e..e9f3b8914145 100644
> --- a/drivers/video/fbdev/imsttfb.c
> +++ b/drivers/video/fbdev/imsttfb.c
> @@ -1393,12 +1393,12 @@ static void init_imstt(struct fb_info *info)
>  		int vmode = init_vmode, cmode = init_cmode;
>
>  		if (vmode == -1) {
> -			vmode = nvram_read_byte(NV_VMODE);
> +			vmode = arch_nvram_ops.read_byte(NV_VMODE);
>  			if (vmode <= 0 || vmode > VMODE_MAX)
>  				vmode = VMODE_640_480_67;
>  		}
>  		if (cmode == -1) {
> -			cmode = nvram_read_byte(NV_CMODE);
> +			cmode = arch_nvram_ops.read_byte(NV_CMODE);
>  			if (cmode < CMODE_8 || cmode > CMODE_32)
>  				cmode = CMODE_8;
>  		}
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c  
> b/drivers/video/fbdev/matrox/matroxfb_base.c
> index cac5865d461c..3fecc628752c 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -1876,7 +1876,7 @@ static int initMatrox2(struct matrox_fb_info  
> *minfo, struct board *b)
>  			default_vmode = VMODE_640_480_60;
>  #if defined(CONFIG_PPC32) && defined(CONFIG_NVRAM)
>  		if (default_cmode == CMODE_NVRAM)
> -			default_cmode = nvram_read_byte(NV_CMODE);
> +			default_cmode = arch_nvram_ops.read_byte(NV_CMODE);
>  #endif
>  		if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
>  			default_cmode = CMODE_8;
> diff --git a/drivers/video/fbdev/platinumfb.c  
> b/drivers/video/fbdev/platinumfb.c
> index bf6b7fb83cf4..3efceaf38f98 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
> @@ -347,7 +347,7 @@ static int platinum_init_fb(struct fb_info *info)
>  	printk(KERN_INFO "platinumfb: Monitor sense value = 0x%x, ", sense);
>  	if (default_vmode == VMODE_NVRAM) {
>  #ifdef CONFIG_NVRAM
> -		default_vmode = nvram_read_byte(NV_VMODE);
> +		default_vmode = arch_nvram_ops.read_byte(NV_VMODE);
>  		if (default_vmode <= 0 || default_vmode > VMODE_MAX ||
>  		    !platinum_reg_init[default_vmode-1])
>  #endif
> @@ -360,7 +360,7 @@ static int platinum_init_fb(struct fb_info *info)
>  		default_vmode = VMODE_640_480_60;
>  #ifdef CONFIG_NVRAM
>  	if (default_cmode == CMODE_NVRAM)
> -		default_cmode = nvram_read_byte(NV_CMODE);
> +		default_cmode = arch_nvram_ops.read_byte(NV_CMODE);
>  #endif
>  	if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
>  		default_cmode = CMODE_8;
> diff --git a/drivers/video/fbdev/valkyriefb.c  
> b/drivers/video/fbdev/valkyriefb.c
> index 8022316ee9c9..81f66d69d9dd 100644
> --- a/drivers/video/fbdev/valkyriefb.c
> +++ b/drivers/video/fbdev/valkyriefb.c
> @@ -283,7 +283,7 @@ static void __init valkyrie_choose_mode(struct  
> fb_info_valkyrie *p)
>  	/* Try to pick a video mode out of NVRAM if we have one. */
>  #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
>  	if (default_vmode == VMODE_NVRAM) {
> -		default_vmode = nvram_read_byte(NV_VMODE);
> +		default_vmode = arch_nvram_ops.read_byte(NV_VMODE);
>  		if (default_vmode <= 0
>  		 || default_vmode > VMODE_MAX
>  		 || !valkyrie_reg_init[default_vmode - 1])
> @@ -296,7 +296,7 @@ static void __init valkyrie_choose_mode(struct  
> fb_info_valkyrie *p)
>  		default_vmode = VMODE_640_480_67;
>  #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
>  	if (default_cmode == CMODE_NVRAM)
> -		default_cmode = nvram_read_byte(NV_CMODE);
> +		default_cmode = arch_nvram_ops.read_byte(NV_CMODE);
>  #endif
>
>  	/*
> --
> 2.19.2


