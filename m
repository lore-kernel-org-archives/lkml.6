Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AD6C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E915E20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhtbR/bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E915E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754808AbeFTJMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:12:55 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43452 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbeFTJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:12:52 -0400
Received: by mail-lf0-f67.google.com with SMTP id x13-v6so3801942lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G9Kchxbk9/V6Z07/A08CNjXWkkmI1DwS2V3LPOvPzmo=;
        b=JhtbR/bxy08tTkrzoGefcH6z3Egwu97ycBnxhOudBjsbsn2J9y0o0AjD8eVqP4pepe
         hm2pmzza4Y5qUYzOYeTPI/Paxq9vRBiHMS+z62+2yo3zC5Go5GzjS1lOvFKv9k79zAdA
         /9B0O+GJezs0dnlcrz5bCdvGx5INYUYp6v/J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G9Kchxbk9/V6Z07/A08CNjXWkkmI1DwS2V3LPOvPzmo=;
        b=shcztyaKTOa6KDyn3hHRgNTcbHQ6LMz7Yqhz/e9PvEB0FJsUNUt6srhqeTm0qLKYDa
         /YVUggMEQ8h6P8jtGbgmYZPgiLcIXGDjQyBd0abquwySNw2HzZp/5hDLtkiTlyeN/2v+
         WlNyH7UgIkWCJZ0FFGlK3BhHieoe6qhYMTXpqQhGY5446WJu0StYpmarYVqrqAzd/S8v
         MxgbXxoiYtQnA6cluQjQdOM6lf1tzDEUmEipDN+H1haQbkmR49UpWO8c6OpJubNh50ac
         Zk13UA0DDh+/1C1aPDpngy5DA6GoTH7k1M4qFjnsKOKQNpFcV2XcKMc2+6zvpsN0j1MB
         0Hxw==
X-Gm-Message-State: APt69E0w1Lx9f6ocX1t5IHgMo1LwTxQnsS3U1cgeIkolsVv10MdMojx8
        Wx5Vl5y7ej12mQvhn1HzK0xuBK8kras=
X-Google-Smtp-Source: ADUXVKJkS1+gJ6YxzETtCWydmF3+s+EhuBYx47nsa5nDwBtU/OGdVE/aPERDzmjR+pWg2ZEzQjmgrg==
X-Received: by 2002:a2e:19cc:: with SMTP id 73-v6mr13028357ljz.35.1529485970653;
        Wed, 20 Jun 2018 02:12:50 -0700 (PDT)
Received: from jax.urgonet (h-84-45.A175.priv.bahnhof.se. [79.136.84.45])
        by smtp.gmail.com with ESMTPSA id l16-v6sm313737lji.40.2018.06.20.02.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 02:12:50 -0700 (PDT)
Date:   Wed, 20 Jun 2018 11:12:47 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sahil Malhotra <sahil.malhotra@nxp.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable
 via Kconfig
Message-ID: <20180620091246.GA31818@jax.urgonet>
References: <20180608070813.27263-1-sahil.malhotra@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608070813.27263-1-sahil.malhotra@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 12:38:13PM +0530, Sahil Malhotra wrote:
> This change adds KCONFIG option to set number of pages out of
> whole shared memory to be used for OP-TEE driver private data
> structures.
> 
> Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> ---
>  drivers/tee/optee/Kconfig | 8 ++++++++
>  drivers/tee/optee/core.c  | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index 524c7a80fde4..f425c960a5a2 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -12,3 +12,11 @@ config OPTEE_BENCHMARK
>  	help
>  	  This enables benchmarking feature in the OP-TEE Trusted
>  	  Execution Environment (TEE) driver.
> +
> +config OPTEE_SHM_NUM_PRIV_PAGES
> +	int "Private Shared Memory Pages"
> +	default 1
> +	depends on OPTEE
> +	help
> +	  This sets the number of private shared memory pages to be
> +	  used by OP-TEE TEE driver.
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 4a2c420d4fe4..8d3be6b1bb96 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -33,7 +33,7 @@
>  
>  #define DRIVER_NAME "optee"
>  
> -#define OPTEE_SHM_NUM_PRIV_PAGES	1
> +#define OPTEE_SHM_NUM_PRIV_PAGES	CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
>  
>  /**
>   * optee_from_msg_param() - convert from OPTEE_MSG parameters to
> -- 
> 2.17.0
> 

Looks good to me, I'll pick it up.

Thanks,
Jens
