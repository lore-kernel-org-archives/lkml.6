Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D0EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCF92151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7GbROh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCF92151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbeHBVCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:02:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50858 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeHBVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:02:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so3726254wmc.0;
        Thu, 02 Aug 2018 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SuyYwC9IPgiVzQ47tNT1SCsTqUvtuEi/hehfIcxx0wU=;
        b=L7GbROh841hTKQLd4Mi293VwmGvx8CobaCC0UAzTQPRqrwnk1Vpphh9DAuXeURMqw0
         4BOdy/X6fed0esq3SWvx1NiT8rvZSAOsrY2KMq8h/u/RKNe+ycqVQG98wWSmzyLYMV1V
         E7vb3SoL11vsy3u4Z8tw432LXn+83beTA2F3IimjjV6Yo+DW1wgWKpis26EIJadNEzk0
         l7SKkJlW4tQZkGUD+rLeBxHrpBeja2IVynS0jIKpd+JaoSL1E44yTpyuZEQUnHEn8I2F
         v6UePAt2kZM9wtUrIQdDYfD0bBYXyKx4u6VnO7Z0PZ+RkYVZekc/DerQ6BtPOtiIiM5q
         LBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SuyYwC9IPgiVzQ47tNT1SCsTqUvtuEi/hehfIcxx0wU=;
        b=iD2zo4UOsNqvxcdDZ4LBx/HbFa/9l2ckeDQYQfs7sSIJVoA3by+lvxgQ01lh/KhYlL
         frFcjmJT56Gs8725AqSGjCJeGX4+FjYkCBziLe44cfhE2jPj1oQSC1WbsbSyGNTdYoKs
         xGulNMa3DvqiIshhHvyeRQpDudOjqsc4PBefOcUXRaSNIWh7P9uXBDtvAmBeGyRJAQQd
         fAXQpkoBHPZ8npmoo5uus6aj93Oy5nGxckya+hJNfVAdxML9hS444vttGBZtWKi0CcDO
         u22FZ/gISDY/K8aYRlTa8y8xb+AWQC5/5SLOjzUrVBZFeaCyMvNt4mq/2eQLbJgPhm60
         WJww==
X-Gm-Message-State: AOUpUlFYxYQGXDuXlpfcsofmiyozI5xZo8LUMshhhGgBKa1rjoOlZf1f
        Dmix3eLL27eYAK6p84x3YEmjWtyclpE=
X-Google-Smtp-Source: AAOMgpcrGWZ8iyjNyE0WG6fjZVX7Ow6SVb9QArdSHKuzq+uX1R76BGTF4LKaOkUc5YNyFrU0Hq2u7A==
X-Received: by 2002:a1c:ad4:: with SMTP id 203-v6mr2693493wmk.98.1533237013428;
        Thu, 02 Aug 2018 12:10:13 -0700 (PDT)
Received: from sch.bme.hu (ecklm-pi.sch.bme.hu. [152.66.179.182])
        by smtp.gmail.com with ESMTPSA id 200-v6sm276840wmv.6.2018.08.02.12.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 12:10:12 -0700 (PDT)
Date:   Thu, 2 Aug 2018 21:10:11 +0200
From:   =?utf-8?B?TcOhdMOp?= Eckl <ecklm94@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        pablo@netfilter.org
Subject: Re: linux-next: Tree for Aug 2 (netfilter: tproxy)
Message-ID: <20180802191011.ibm2lknbzwm7zjoc@sch.bme.hu>
References: <20180802193111.346fdde9@canb.auug.org.au>
 <0185f82e-4bf5-6c6c-a131-ba2c0197c9a0@infradead.org>
 <20180802190557.sha6wer6gkdgrd6i@sch.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180802190557.sha6wer6gkdgrd6i@sch.bme.hu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 09:05:57PM +0200, Máté Eckl wrote:
> Hi Randy,
> 
> Thanks for reporting!
> 
> Please find the patch attached.

Sorry I made an error in the commit message... See the fix below.

> 
> Regards,
> Mate
> 
> On Thu, Aug 02, 2018 at 09:28:16AM -0700, Randy Dunlap wrote:
> > On 08/02/2018 02:31 AM, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20180801:
> > > 
> > 
> > on i386:
> > 
> > ../net/netfilter/nft_tproxy.c: In function 'nft_tproxy_init':
> > ../net/netfilter/nft_tproxy.c:237:3: error: implicit declaration of function 'nf_defrag_ipv6_enable' [-Werror=implicit-function-declaration]
> >    err = nf_defrag_ipv6_enable(ctx->net);
> > 
> > 
> > Full randconfig file is attached.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > -- 
> > ~Randy

> From 2c3a7d3209ed5e539ecd69192fc0f4186fdc7d99 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?M=C3=A1t=C3=A9=20Eckl?= <ecklm94@gmail.com>
> Date: Thu, 2 Aug 2018 20:46:13 +0200
> Subject: [PATCH] netfilter: nft_tproxy: Add missing config check
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> A config check was missing form the code when using
> nf_defrag_ipv6_enable with NFT_TPROXY != n and NF_DEFRAG_IPV6 = n and
> this caused the following error in case of :

Please change the last line to:
  this caused the following error:

> 
> ../net/netfilter/nft_tproxy.c: In function 'nft_tproxy_init':
> ../net/netfilter/nft_tproxy.c:237:3: error: implicit declaration of function
> +'nf_defrag_ipv6_enable' [-Werror=implicit-function-declaration]
>    err = nf_defrag_ipv6_enable(ctx->net);
> 
> This patch adds a check for NF_TABLES_IPV6 when NF_DEFRAG_IPV6 is
> selected by Kconfig.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 4ed8eb6570a4 ("netfilter: nf_tables: Add native tproxy support")
> Signed-off-by: Máté Eckl <ecklm94@gmail.com>
> ---
>  net/netfilter/nft_tproxy.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
> index c6845f7baa08..eff99dffc842 100644
> --- a/net/netfilter/nft_tproxy.c
> +++ b/net/netfilter/nft_tproxy.c
> @@ -234,9 +234,11 @@ static int nft_tproxy_init(const struct nft_ctx *ctx,
>  		err = nf_defrag_ipv4_enable(ctx->net);
>  		if (err)
>  			return err;
> +#if IS_ENABLED(CONFIG_NF_TABLES_IPV6)
>  		err = nf_defrag_ipv6_enable(ctx->net);
>  		if (err)
>  			return err;
> +#endif
>  		break;
>  	default:
>  		return -EOPNOTSUPP;
> -- 
> ecklm
> 

