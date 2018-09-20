Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FD2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561BE214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9fq18hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561BE214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbeITWTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:19:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41955 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeITWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:19:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so4597806plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RaUImUA/EWW8uLbEziQ/hbN/V7rSmhLnNJBYG8L/84I=;
        b=M9fq18hbnrTC95YADaoCw1vKsk3YF6Mm0+MH1/Ie57XW8bRwsGvP5fQAIIeW4c8z43
         W+o40PH5wy2RXw0HivNbT7eE1Rh2TsVFmZ8TZLWnVbRgEix9erPPKMe1e7iJqmKBrPSN
         D+VaFvMnRT4OX5BsRzmeBC6HuCVFzvFOavEZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RaUImUA/EWW8uLbEziQ/hbN/V7rSmhLnNJBYG8L/84I=;
        b=M9yCJcS8KL4FfzWSBwWKO13GpOJWnzrFPKihzZjaPvbzkvOS0NspGCyLvrbDZthGdM
         S4v+mcLkZvkpFxYTKaIqy4cgFppmU6wR0W/YMK1dH2pqpEKCA510oITpZMpsUtR+i1Fm
         0RWjmnfkcILl2h9VCywEhm2AZXY/KTsfzaHwpmz1L/Q6ZP1l85vv3LwDXkLIrO0f0leJ
         VnFWc9CpoLXgHPvWDQ3m/LkM2ca0yEFsxMlzIR5N7sKVq+Tj7Nek4jxDIZOymc792gIT
         P30Pmu/xDVF7agAZFwnI77oGorGuuGSDEigAFAEyxH6Cdzn5usTVoawTTZmMWrfXzbQE
         mrWQ==
X-Gm-Message-State: APzg51CVjnA6/fQQo62VgajbH11YdCTDGFzYy3l4jnA1Rx/JUbKXxuD7
        J0xJUExbLN/W03+G8AFjCyNKCQ==
X-Google-Smtp-Source: ANB0Vdbhv8z+1UXNUhWvq0zWKJGT1C2qQ/OSTf5TF7Ad74PtIwXPU9xf6TXFRQ7MZF3ETyhFbvD1KA==
X-Received: by 2002:a17:902:b491:: with SMTP id y17-v6mr40516890plr.160.1537461296167;
        Thu, 20 Sep 2018 09:34:56 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t141-v6sm34339249pgb.27.2018.09.20.09.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:34:55 -0700 (PDT)
Date:   Thu, 20 Sep 2018 09:39:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/4] devres: provide devm_kstrdup_const()
Message-ID: <20180920163905.GH1367@tuxbook-pro>
References: <20180828093332.20674-1-brgl@bgdev.pl>
 <20180828093332.20674-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828093332.20674-4-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 02:33 PDT 2018, Bartosz Golaszewski wrote:

> Provide a resource managed version of kstrdup_const(). This variant
> internally calls devm_kstrdup() on pointers that are outside of
> .rodata section and returns the string as is otherwise.
> 
> Also provide a corresponding version of devm_kfree().
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/base/devres.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 438c91a43508..48185d57bc5b 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -11,6 +11,8 @@
>  #include <linux/slab.h>
>  #include <linux/percpu.h>
>  
> +#include <asm/sections.h>
> +
>  #include "base.h"
>  
>  struct devres_node {
> @@ -822,6 +824,28 @@ char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(devm_kstrdup);
>  
> +/**
> + * devm_kstrdup_const - resource managed conditional string duplication
> + * @dev: device for which to duplicate the string
> + * @s: the string to duplicate
> + * @gfp: the GFP mask used in the kmalloc() call when allocating memory
> + *
> + * Strings allocated by devm_kstrdup_const will be automatically freed when
> + * the associated device is detached.
> + *
> + * RETURNS:
> + * Source string if it is in .rodata section otherwise it falls back to
> + * devm_kstrdup.
> + */
> +const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp)
> +{
> +	if (is_kernel_rodata((unsigned long)s))
> +		return s;
> +
> +	return devm_kstrdup(dev, s, gfp);
> +}
> +EXPORT_SYMBOL(devm_kstrdup_const);
> +
>  /**
>   * devm_kvasprintf - Allocate resource managed space and format a string
>   *		     into that.
> @@ -895,6 +919,20 @@ void devm_kfree(struct device *dev, const void *p)
>  }
>  EXPORT_SYMBOL_GPL(devm_kfree);
>  
> +/**
> + * devm_kfree_const - Resource managed conditional kfree
> + * @dev: device this memory belongs to
> + * @p: memory to free
> + *
> + * Function calls devm_kfree only if @p is not in .rodata section.
> + */
> +void devm_kfree_const(struct device *dev, const void *p)
> +{
> +	if (!is_kernel_rodata((unsigned long)p))
> +		devm_kfree(dev, p);
> +}
> +EXPORT_SYMBOL(devm_kfree_const);
> +
>  /**
>   * devm_kmemdup - Resource-managed kmemdup
>   * @dev: Device this memory belongs to
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 33f7cb271fbb..79ccc6eb0975 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -693,7 +693,10 @@ static inline void *devm_kcalloc(struct device *dev,
>  	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>  }
>  extern void devm_kfree(struct device *dev, const void *p);
> +extern void devm_kfree_const(struct device *dev, const void *p);
>  extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
> +extern const char *devm_kstrdup_const(struct device *dev,
> +				      const char *s, gfp_t gfp);
>  extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
>  			  gfp_t gfp);
>  
> -- 
> 2.18.0
> 
