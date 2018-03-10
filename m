Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeCJOEw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 09:04:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56616 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbeCJOEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 09:04:50 -0500
Date: Sat, 10 Mar 2018 15:04:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, sb_edac: Remove VLA usage
Message-ID: <20180310140434.GC8261@pd.tnic>
References: <20180309235654.GA9887@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309235654.GA9887@embeddedor.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:02:18PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with a fixed-length array instead.
> 
> Fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
> 
> Notice that due to this change, the field max_interleave is no longer
> used after it has been initialized. Maybe it should be removed?

Yes.

> @@ -110,6 +110,7 @@ static const u32 knl_interleave_list[] = {
>  	0xdc, 0xe4, 0xec, 0xf4, 0xfc, /* 15-19 */
>  	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
>  };
> +#define MAX_INTERLEAVE	ARRAY_SIZE(knl_interleave_list)

define that as the max of all interleave lists array sizes so that
people can update it properly when new interleave lists get added.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
