Return-Path: <kernel-hardening-return-12311-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELssut0kgykrksgyu4P06U9z4vEgw7O3JZhlBczhYEC5JJo5eeh/jd4Na5j49krDK3xaBOcB
ARC-Seal: i=1; a=rsa-sha256; t=1520594880; cv=none;
        d=google.com; s=arc-20160816;
        b=oFDIm8fikEw4ElnisbE3jhNGgouo7E/EPS8jYKX80XsWBK0D/2ZoLrg1Bh4COjWo5i
         nLBQtGYhE0FVyKAVQkM65RZuJwCWmfCVpTZIPYb1PSdFMhguGr4JgIOWfr3bC6wwF7Ta
         eosSRhpZuRkVMUrwTRb4kvNgtXkJ/PUfPy4Bumv1bcnuv/Aaq7JIwIK0fYOJ2A0niaki
         wKeMIoGrCQSSINKqRUCnrYsBw/fVtbx+CsRXg7qQ8UMIkjiQXVEiXi0PkEVS2MAUpIpI
         /tQ94R1+8nc9qmydbJ/meGd2kvyEojx4TFV51Aq01WgvXKmpZJL1KGYae1JZzqqwpKue
         L7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=p/bo8UgyjPjFhzmqdS0LHeu8xJdQ2nNsbDbUVOkQ2Qs=;
        b=mq8DZEMCiDjQ3FwMe1oQi9loeVuERydjfw3MLPjgibdGblNE9q8gXQe9G/bI5r0QNc
         +9mbwPRfz9KI2DuJyw9Njq8H1S4/M/DzvbsJ0cTOuwoWlmXXx/Ds6dTNp3UlSVtyNrxi
         L4wwG/JR2ytPZ5XyPEsmX5s/7VkCy/44Y2iEDFkYflu8iW52S1WZHGaRown2uelY9jT5
         iXi3aFx8ZgzOfp65/8V0RVPRBR0/A56PaOJfE9WhiS+DgjbOYgtHfIOogxJlK8fVmR8H
         CGHkot1cHxn9yOe9tTP7Yp3Hte8XwZC0M5+G9WQB/NhMARuIJ9lKGSHIXQHSXmSU5N/f
         1f1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12311-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12311-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12311-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12311-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 10:59:40 +0000
From: Eric Engestrom <eric.engestrom@imgtec.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC: Emil Velikov <emil.l.velikov@gmail.com>, Florian Tobias Schandinat
	<FlorianSchandinat@gmx.de>, Bartlomiej Zolnierkiewicz
	<b.zolnierkie@samsung.com>, <linux-fbdev@vger.kernel.org>, Kees Cook
	<keescook@chromium.org>, <kernel-hardening@lists.openwall.com>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, "Gustavo
 A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] video: fbdev: via: remove VLA usage
Message-ID: <20180309105940.22hd2uy2mv7wahzb@imgtec.com>
References: <20180308173949.GA19305@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20180308173949.GA19305@embeddedgus>
User-Agent: NeoMutt/20171215
X-Originating-IP: [10.60.4.28]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594392120539391557?=
X-GMAIL-MSGID: =?utf-8?q?1594459297429897186?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thursday, 2018-03-08 11:39:49 -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA usage.
> 
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Sorry for my reply on v1, I missed that Emil already replied to another
post of the same patch (side note on that, making use of `-vX` and
`--in-reply-to` helps track the evolution of patches)

This looks good to me:
Reviewed-by: Eric Engestrom <eric.engestrom@imgtec.com>

> ---
>  drivers/video/fbdev/via/via_aux_sii164.c | 2 +-
>  drivers/video/fbdev/via/via_aux_vt1631.c | 2 +-
>  drivers/video/fbdev/via/via_aux_vt1632.c | 2 +-
>  drivers/video/fbdev/via/via_aux_vt1636.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/via/via_aux_sii164.c b/drivers/video/fbdev/via/via_aux_sii164.c
> index ca1b35f..c27f62c 100644
> --- a/drivers/video/fbdev/via/via_aux_sii164.c
> +++ b/drivers/video/fbdev/via/via_aux_sii164.c
> @@ -36,7 +36,7 @@ static void probe(struct via_aux_bus *bus, u8 addr)
>  		.name	=	name};
>  	/* check vendor id and device id */
>  	const u8 id[] = {0x01, 0x00, 0x06, 0x00}, len = ARRAY_SIZE(id);
> -	u8 tmp[len];
> +	u8 tmp[ARRAY_SIZE(id)];
>  
>  	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
>  		return;
> diff --git a/drivers/video/fbdev/via/via_aux_vt1631.c b/drivers/video/fbdev/via/via_aux_vt1631.c
> index 06e742f..32978a0 100644
> --- a/drivers/video/fbdev/via/via_aux_vt1631.c
> +++ b/drivers/video/fbdev/via/via_aux_vt1631.c
> @@ -36,7 +36,7 @@ void via_aux_vt1631_probe(struct via_aux_bus *bus)
>  		.name	=	name};
>  	/* check vendor id and device id */
>  	const u8 id[] = {0x06, 0x11, 0x91, 0x31}, len = ARRAY_SIZE(id);
> -	u8 tmp[len];
> +	u8 tmp[ARRAY_SIZE(id)];
>  
>  	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
>  		return;
> diff --git a/drivers/video/fbdev/via/via_aux_vt1632.c b/drivers/video/fbdev/via/via_aux_vt1632.c
> index d24f4cd..cec8cc4 100644
> --- a/drivers/video/fbdev/via/via_aux_vt1632.c
> +++ b/drivers/video/fbdev/via/via_aux_vt1632.c
> @@ -36,7 +36,7 @@ static void probe(struct via_aux_bus *bus, u8 addr)
>  		.name	=	name};
>  	/* check vendor id and device id */
>  	const u8 id[] = {0x06, 0x11, 0x92, 0x31}, len = ARRAY_SIZE(id);
> -	u8 tmp[len];
> +	u8 tmp[ARRAY_SIZE(id)];
>  
>  	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
>  		return;
> diff --git a/drivers/video/fbdev/via/via_aux_vt1636.c b/drivers/video/fbdev/via/via_aux_vt1636.c
> index 9e015c1..2b10bc2 100644
> --- a/drivers/video/fbdev/via/via_aux_vt1636.c
> +++ b/drivers/video/fbdev/via/via_aux_vt1636.c
> @@ -36,7 +36,7 @@ void via_aux_vt1636_probe(struct via_aux_bus *bus)
>  		.name	=	name};
>  	/* check vendor id and device id */
>  	const u8 id[] = {0x06, 0x11, 0x45, 0x33}, len = ARRAY_SIZE(id);
> -	u8 tmp[len];
> +	u8 tmp[ARRAY_SIZE(id)];
>  
>  	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
>  		return;
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
