Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483A520657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483A520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJ2Xvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:51:36 -0400
Received: from muru.com ([72.249.23.125]:53024 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbeJ2Xvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:51:35 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B7E2780D4;
        Mon, 29 Oct 2018 15:02:33 +0000 (UTC)
Date:   Mon, 29 Oct 2018 08:02:27 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20181029150227.GA56754@atomide.com>
References: <20181029101401.5687153e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029101401.5687153e@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [181028 23:14]:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in:
> 
>   include/linux/platform_data/gpio-omap.h
> 
> between commit:
> 
>   b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm instead")
> 
> from Linus' tree and commit:
> 
>   26683316c92a ("ARM: OMAP1: ams-delta-fiq: Use <linux/platform_data/gpio-omap.h>")
> 
> from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks it probably makes sense to merge in the immutable gpio branch
also into arm-soc tree that Linus Walleij has set up earlier. That's the
ib-omap branch at commit 5284521a290e ("gpio: omap: Get rid of
pm_runtime_irq_safe()").

Regards,

Tony

> diff --cc include/linux/platform_data/gpio-omap.h
> index 8485c6a9a383,ed071f76b642..000000000000
> --- a/include/linux/platform_data/gpio-omap.h
> +++ b/include/linux/platform_data/gpio-omap.h
> @@@ -205,4 -206,18 +208,6 @@@ struct omap_gpio_platform_data 
>   	int (*get_context_loss_count)(struct device *dev);
>   };
>   
>  -#if IS_BUILTIN(CONFIG_GPIO_OMAP)
>  -extern void omap2_gpio_prepare_for_idle(int off_mode);
>  -extern void omap2_gpio_resume_after_idle(void);
>  -#else
>  -static inline void omap2_gpio_prepare_for_idle(int off_mode)
>  -{
>  -}
>  -
>  -static inline void omap2_gpio_resume_after_idle(void)
>  -{
>  -}
>  -#endif
> + #endif /* __ASSEMBLER__ */
> + 
>   #endif


