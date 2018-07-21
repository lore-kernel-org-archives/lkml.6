Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E32ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9690620868
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbIoSiS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9690620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeGUWsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 18:48:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeGUWsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 18:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kg7riErWsPeGTSsN6u7PcBYS0Nshft/icJK1Qd94QuU=; b=MbIoSiS7iXDoa15fNUfP5f0aX
        WmSEHFBr+RcC50qED0/qWqvs12G8AZ+QiHS5HCHwsB6ROMH1TDqXvC74o5T61xncUbngQ0kpY35gK
        5uyO9116t7nrPoV8TqWIxgLD7/PifxapsHZzqwA7VeF7s7RIqsHHz6OTv2GWXH2P9lFQFXPwmF6Yg
        IuE0/RDPF0J4O37eDEGydgoxUNTJN8dK9Iqvup/Q1Z5SS3TM1VMPeY0BjN4vXyPUwzBbO0lugEBIy
        kDiZ2gBAIxtHAxsuHbdEQbKx8M+nZjSfwt3g4AWw298mvX80JAFkiDiJv3ibkMydbpayh/3jgUz88
        LWuhB+LMQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgzoy-0007da-Dv; Sat, 21 Jul 2018 21:53:48 +0000
Subject: Re: [PATCH] drivers/memory/Kconfig: Add CONFIG_OF dependency
To:     Anders Roxell <anders.roxell@linaro.org>,
        miquel.raynal@bootlin.com, boris.brezillon@bootlin.com
Cc:     linux-kernel@vger.kernel.org
References: <20180721200049.7553-1-anders.roxell@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a83ff193-be57-f566-cafb-132075025b56@infradead.org>
Date:   Sat, 21 Jul 2018 14:53:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180721200049.7553-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/2018 01:00 PM, Anders Roxell wrote:
> JZ4780_NEMC doesn't depend on OF, and if OF isn't enabled we get this
> error:
> drivers/memory/jz4780-nemc.c: In function ‘jz4780_nemc_num_banks’:
> drivers/memory/jz4780-nemc.c:72:10: error: implicit declaration of
>  function ‘of_read_number’; did you mean ‘down_read_nested’?
>  [-Werror=implicit-function-declaration]
>    bank = of_read_number(prop, 1);
>           ^~~~~~~~~~~~~~
>           down_read_nested
> 
> Make JZ4780_NEMC depend on OF.
> 
> Fixes: ab99e11062c1 ("memory: jz4780-nemc: Allow selection of this driver when COMPILE_TEST=y")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/memory/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index a642552dfdc9..63389f075f1d 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -123,7 +123,7 @@ config JZ4780_NEMC
>  	bool "Ingenic JZ4780 SoC NEMC driver"
>  	default y
>  	depends on MACH_JZ4780 || COMPILE_TEST
> -	depends on HAS_IOMEM
> +	depends on HAS_IOMEM && OF
>  	help
>  	  This driver is for the NAND/External Memory Controller (NEMC) in
>  	  the Ingenic JZ4780. This controller is used to handle external
> 


-- 
~Randy
