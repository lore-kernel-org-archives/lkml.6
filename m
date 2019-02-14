Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCF1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026A921904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iFF7iRXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392743AbfBNBy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:54:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732533AbfBNBy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tllk6kyOZnxM4OK2GORGZeDSIAvi2wtEzhy4pixUJjs=; b=iFF7iRXzh6R0RzIgIfLKi1Y8T
        IS2vVM6SWvLbZPQplEBBXM9pjWhZKrrA7pTagm00PSsXtpdWMJfqaF+XBg/5OLCusf/HTxi2Oe08/
        p69Cg3bQIy6ivtYuUq4V3AnUFnQnQ5e11fAymrVKSH+IDS4c34TjAQYhJcgRuvwlwgPm5Mfh64tqX
        3GuU/0NuC2FM/Pn9zUJrjedR0IZ6M+T2g6XVaVjlMkrTmbNEpKi8lj5Bjpl0tSCwtwBQ/VHhR69Wm
        csjRzM1DZ0O0DU0cV9dKqeNB8Y/uYG3Q8f8SiNtTMzzUVS8nQGk1VlSCagrilpbYCI4n4nvu7H3gP
        dyDAYWU3w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gu6Eq-0004nB-IH; Thu, 14 Feb 2019 01:54:56 +0000
Subject: Re: [PATCH -next 1/3] spmi: pmic-arb: select IRQ_DOMAIN_HIERARCHY in
 Kconfig
To:     Brian Masney <masneyb@onstation.org>, linus.walleij@linaro.org
Cc:     sboyd@kernel.org, lee.jones@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20190214013641.9740-1-masneyb@onstation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3959e53e-d711-8115-4562-c8352a5e3ce8@infradead.org>
Date:   Wed, 13 Feb 2019 17:54:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190214013641.9740-1-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 5:36 PM, Brian Masney wrote:
> Select IRQ_DOMAIN_HIERARCHY for pmic-arb in Kconfig since this driver
> uses the version 2 IRQ interfaces. IRQ_DOMAIN_HIERARCHY selects
> IRQ_DOMAIN, so it can be removed from here.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> This addresses a build failure found by make randconfig in linux-next:
> https://lore.kernel.org/lkml/fb0508f1-131d-ff17-9b5d-123ec75275dd@infradead.org/
> 
>  drivers/spmi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
> index 0d3b70b3bda8..d48ed7c2c6c4 100644
> --- a/drivers/spmi/Kconfig
> +++ b/drivers/spmi/Kconfig
> @@ -12,7 +12,7 @@ if SPMI
>  
>  config SPMI_MSM_PMIC_ARB
>  	tristate "Qualcomm MSM SPMI Controller (PMIC Arbiter)"
> -	select IRQ_DOMAIN
> +	select IRQ_DOMAIN_HIERARCHY
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	default ARCH_QCOM
> 


-- 
~Randy
