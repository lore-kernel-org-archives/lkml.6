Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656DBC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEF123ABC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD0N948P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEF123ABC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934079AbeFVBFz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:05:55 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37451 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeFVBFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:05:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id r21-v6so2190237pgv.4;
        Thu, 21 Jun 2018 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qVrSMSTzq4VvSXGmgKzIb6xy8AllvSOZgPH/9DmD/dQ=;
        b=pD0N948PCcbOB83x9QMfu9uUzbw9MzQFFa6AY9FMiXQlxy7wNyFYlkydt3UY8k5JSg
         pGfNwMvTAdAjANqEEh2WwC0Jua3Ck+vc0CKSnvgSPqSJhBod+ywkSCNjZyrpqZ4k+Ovj
         htaMGkI+5E2jsi9ql3sCJy36aWqndAkz+H5kGyUtGYHf+uoGntyNgRI94eYiKv4ULmSr
         e169nASI0pnJgaMJHDZSSbAL8nNvp1/cJsy7Zcjr0oShPhHOmOS+GiLPOIrFauBH5HLy
         yHNbNAZqJkZN6LWoV/BPPKYLe27CVYwuv7lHXEcBz/NI5f9K5lb5iH998tDJbP0MmdOs
         V3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qVrSMSTzq4VvSXGmgKzIb6xy8AllvSOZgPH/9DmD/dQ=;
        b=eBj+KbY1qVBiQfpnbrRH50yZ/SwGMu5hNIrBowpB4hPIe8vFIYmhR88GvSQ1km221M
         eqS8x6w6Ei0cX7mByyM53BTv+dhKQG0oBF+15WWySMoJ2wYHmcF1LPqPNzHln5CVXI69
         0E0zAihfOIPvRBuXtyaGSjr4bksOWE8Wa7uO1+9GZfVl7pbEe0nolrdm3riIlMkf49SM
         CVOWC+7wYkrSLgL+n3z8iX0v+yjboZqmA9IGK0wCUifsSvNLgaBU4wnjnd856sn2S3Nz
         UZmfMuJL2XkSCnrLbcMrjmkV27cp3tUcU/8pvcG6OJUepFkjrhs8OUf963H12SHq5CF+
         ikaw==
X-Gm-Message-State: APt69E3fH45Wd9JWZ+E2+Lq4MmmJDR6p1YLJz+7XjoXn6g4zLVj1v273
        DaTDePB+RGCcaNj7MLHKgp4=
X-Google-Smtp-Source: ADUXVKJDX4fYoFn7x9Gm69sn58VzEDUj+6xyDV+aePpbJq9DEWmW4Rx57us7jaIF2uEmKdqEvbFO2Q==
X-Received: by 2002:a63:7d1b:: with SMTP id y27-v6mr24126180pgc.418.1529629553347;
        Thu, 21 Jun 2018 18:05:53 -0700 (PDT)
Received: from [10.10.3.96] (s169.156.222.122.fls.vectant.ne.jp. [122.222.156.169])
        by smtp.gmail.com with ESMTPSA id p20-v6sm9114910pfn.181.2018.06.21.18.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 18:05:52 -0700 (PDT)
Subject: Re: [PATCH] base: fix order of OF initialization
To:     Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Wesley W. Terpstra" <wesley@sifive.com>
References: <20180621133737.14397-1-hch@lst.de>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ed030f7c-ba4d-e20a-352e-aaad45cda792@gmail.com>
Date:   Thu, 21 Jun 2018 18:05:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621133737.14397-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/18 06:37, Christoph Hellwig wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
> 
> This fixes: [    0.010000] cpu cpu0: Error -2 creating of_node link
> ... which you get for every CPU on all architectures that use
> CONFIG_GENERIC_CPU_DEVICES.
> 
> In that case, driver_init() calls cpu_dev_init() before calling
> of_core_init(). Then we get the callchain:
> 
>   cpu_dev_init()
>     -> cpu_dev_register_generic()
>     -> register_cpu(cpu, i)
>     -> device_register(&cpu->dev)
>     -> device_add(dev)
>     -> device_add_class_symlinks(dev)
> 
> ... in device_add_class_symlinks, we we dev->of_node, and call
> sysfs_create_link(), which fails because we haven't called
> of_core_init() to register the sysfs devicetree directory yet.
> 
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [hch: updated the changelog based on review feedback]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Frank Rowand <frowand.list@gmail.com>
> ---
> 
> In case anyone is wondering why I send out this patch - I'm digging
> through the RISC-V tree and trying to the patches required to let
> a RISC-V kernel boot on qemu upstream.  I also got the previously
> missing signoff from Wes offlist.
> 
>  drivers/base/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/init.c b/drivers/base/init.c
> index dd85b05a6a16..908e6520e804 100644
> --- a/drivers/base/init.c
> +++ b/drivers/base/init.c
> @@ -30,9 +30,9 @@ void __init driver_init(void)
>  	/* These are also core pieces, but must come after the
>  	 * core core pieces.
>  	 */
> +	of_core_init();
>  	platform_bus_init();
>  	cpu_dev_init();
>  	memory_dev_init();
>  	container_dev_init();
> -	of_core_init();
>  }
> 

The updated patch comment looks good.  It would be good to get this into
-next while we are still early in the release cycle.

For those trying to find the previous version of this patch, it was cced
to the devicetree list on 06/07/17.

-Frank
