Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E77C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22D12175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYmcCNnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBGQKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:10:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43094 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:10:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id z18so218899qkj.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 08:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nLKu2Ce48SbsIOliZjWYYBEGchd5P2cptNKDEpsxe7A=;
        b=kYmcCNnkuY2iAEyigKxDmit5+sQ0ZmcHHX2MwM9w1yNdosCIQBv/a1itlAepYXa13L
         6CBHHD+WcFY4s6gwO/5j+dC9Mwqr8mXOCHnwAD4+/I7AQv06md31uLmxfDzRDzVn+XH9
         9o0uFd3wx/1Oume2taJpqiAY2jAZmMI7kZwz95mYRrVWQoPUGsEAdZKeOjvBStVgNcwH
         oXJy9vy2oICkAivcxtgacsxAhOsl3n7+OUADosxdaS4h3sj56EqXRpPvZ1VndcVcaXUv
         rFrnHQ4gnnaCSnAjVn2d1PJphptAJQ5SajZUPlO8hOf/9y7n2H2EQfbGm+ekP8tmGQWs
         pAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nLKu2Ce48SbsIOliZjWYYBEGchd5P2cptNKDEpsxe7A=;
        b=Mra1nNTk8kz2eCjvjxJDaMrM4f35Yy246jpwQRC8aFe+Fbej8+ZJRi5A6LlBCwByyK
         x5ZL/5XTZPnpxpR7yu7Igjp2ZaklFfNmwrxAF+DbXKO/ASIFxaUHSEvCIhgpYukqHMYx
         EesmToISjFfh+CQDmpuUtMIAm43z8IYQOEfNUm4GWNuHtd8jP4mptNIBOnD5bk02B0x9
         Xsk8DmkpG1nLLZ98n8iBc07gV1KuhIpnsfcNdXxPdvnZjfPLXtv6kBBV6Ml2u6Lxf5UD
         gadcZnqzmD9zV5U24ZPZWlHD/Ktflh1x9zcKTYxYS0RSNxEXTibFq5IV6PkpE6xXpiSX
         xH3Q==
X-Gm-Message-State: AHQUAua07RzePlBF7krgOtSw2Z0xIrJlYnvfN9XyHylWPLQDBnp1FANx
        ScBPSbmarXDXI38cQYnPzB4plA==
X-Google-Smtp-Source: AHgI3Ib8wHs2EOKVBWXcyiIIYAhB852YPrAyjvKSHZs1Vt2ESLuqCOGBW1yI+jCL2rTXi3mN81wLyA==
X-Received: by 2002:a37:e406:: with SMTP id y6mr11995955qkf.216.1549555819238;
        Thu, 07 Feb 2019 08:10:19 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id a185sm24550182qkb.1.2019.02.07.08.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 08:10:17 -0800 (PST)
Date:   Thu, 7 Feb 2019 11:10:16 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     linux@armlinux.org.uk, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] ARM: use unified assembler in headers
In-Reply-To: <b670feebd5e0bbc4c93d3f31f45bd0243b32425f.1549532513.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1902071055380.2213@knanqh.ubzr>
References: <cover.1549532513.git.stefan@agner.ch> <b670feebd5e0bbc4c93d3f31f45bd0243b32425f.1549532513.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019, Stefan Agner wrote:

> Use unified assembler syntax (UAL) in headers. Divided syntax is
> considered depricated. This will also allow to build the kernel
> using LLVM's integrated assembler.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/include/asm/assembler.h | 8 ++++----
>  arch/arm/include/asm/vfpmacros.h | 8 ++++----
>  arch/arm/lib/bitops.h            | 8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 28a48e0d4cca..60465b55683c 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -376,7 +376,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	.macro	usraccoff, instr, reg, ptr, inc, off, cond, abort, t=TUSER()
>  9999:
>  	.if	\inc == 1
> -	\instr\cond\()b\()\t\().w \reg, [\ptr, #\off]
> +	\instr\()b\cond\()\t\().w \reg, [\ptr, #\off]

Similar comment here: you added a \() between \instr and b as needed, 
but the one between \cond and \t (which was already redundant before) 
may go.


Nicolas
