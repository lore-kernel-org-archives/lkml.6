Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF878C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBF5223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDl9T6F8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBF5223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeKNGtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:49:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42567 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNGts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:49:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so2810925pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 12:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L+a+PpzR+nfG0aAKhuAuU4VCxpLWpasx0RwxjXMeCXM=;
        b=CDl9T6F8JsxmWV/KIrVRjPAF16+fNC8FVATaEzA7iusuHJy+SAvVsmm/xw+6ssmGCY
         0yH1GBiLm+RGCaA/KLhO6Jqod3OP769f5PvMWnLzI9Ln/6aE/sTdBl7AmsaH4pkTgPg1
         0/DsbryHTflPFbk7qzwaTHwp3l/ngJWz8qdthRKwNwqp0zpQhar4NMskcnIMWJ9j917q
         Vs+xvBV164lnJj0eqj5lTnpuWyA7S1/v71Fud92LVBSIblKAPso9G2Dcn1o/TorDFEjA
         4PEPnoOhR8/NeTwIN7xt/y5utp/rZ43EipUTZYDJdRaq4Xj457JV7YyInUnaS82apgvR
         wgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+a+PpzR+nfG0aAKhuAuU4VCxpLWpasx0RwxjXMeCXM=;
        b=e7KEJtJsJGdWmUG6dTtL+8lOHR01Ek0AMXExTnJIa68Fwo5qqvUkLv7+gmXBFV8Umf
         hQxrFK1JKXpp1rO7Xqh9twkolRJOY6gh4tUxd44LCmbdTQtGj63veTWTpxw0lYPtLVc7
         1QRc4KhCFYcxMNFLo6EMdbcZQqZYyPbmq0Y7IlCkQDA4ohfCcNaRsSbuQO/oWB4jZHlH
         7/UlP8eme6wLpeZ5Q8CYSzo2ekErgoSNV9nBw3sYWzRCcf3JuOBap1w2OJgp/9wguNgq
         hto4RpumE3dI+R/eer4DMijz4sQOqrz7fG79S8tK9O+GRt+KJmUwE6IH8OkbPu0ayBYq
         Mxsw==
X-Gm-Message-State: AGRZ1gLA80oD11iU1J2DE1rJuJ/3tj40B/63jIxKDdlXPc5g+R9TLLmH
        G2RLUN69n/xzkxm0M0nUvEI=
X-Google-Smtp-Source: AJdET5fNuBmfg1sAVH3kjyHxunmQ0YzIK4z6uhGf/BRZB9OF2p7SF4gT1k52G6r3XhQPHjNWVC8cUQ==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr6784924pfm.253.1542142195307;
        Tue, 13 Nov 2018 12:49:55 -0800 (PST)
Received: from localhost (g148.61-193-223.ppp.wakwak.ne.jp. [61.193.223.148])
        by smtp.gmail.com with ESMTPSA id q8-v6sm31801171pfa.18.2018.11.13.12.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 12:49:54 -0800 (PST)
Date:   Wed, 14 Nov 2018 05:49:53 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] openrisc: make function cache_loop() inline
Message-ID: <20181113204953.GF2718@lianli.shorne-pla.net>
References: <20181112155544.7230-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112155544.7230-1-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:55:44PM +0800, Changbin Du wrote:
> The third operand of mtspr instruction must be a constraint. To guarantee
> this condition, function cache_loop() which uses macro mtspr() must be
> inlined. So let's force it as 'inline'. This is to fix compiling error with
> new option CONFIG_NO_AUTO_INLINE.

Thanks for looking at this.

Do you mean, must be a 'constant'?

I think this fix is fine for now.  Can you add it to your 'kernel hacking: GCC
optimization for better debug experience' series?

> In file included from arch/openrisc/mm/cache.c:17:0:
> arch/openrisc/mm/cache.c: In function 'cache_loop':
> arch/openrisc/include/asm/spr.h:20:27: warning: asm operand 0 probably doesn't match constraints
>                               ^
> arch/openrisc/mm/cache.c:29:3: note: in expansion of macro 'mtspr'
>       mtspr(reg, line);
>       ^~~~~
> arch/openrisc/include/asm/spr.h:20:27: error: impossible constraint in 'asm'
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/mm/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
> index b747bf1fc1b6..4a4b2b6e006b 100644
> --- a/arch/openrisc/mm/cache.c
> +++ b/arch/openrisc/mm/cache.c
> @@ -20,7 +20,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  
> -static void cache_loop(struct page *page, const unsigned int reg)
> +static inline void cache_loop(struct page *page, const unsigned int reg)
>  {
>  	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
>  	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
> -- 
> 2.17.1
> 
