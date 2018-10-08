Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B76C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0BB2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s5iR9zNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0BB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJHXsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:48:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeJHXsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4vXEEhUhuKQKCy1VNrDRy3TVTiGmQPqS1/aNM4oOffE=; b=s5iR9zNWOpnAwz1/pxH2KwqYw
        SE1e4/zcITiOfl+V9ySAx0ebIRZBZZlxUokl9Fz8iuGoHjavWSz7j+rtQuYs0aPnPXvp+v9U3W90s
        Zb7cEcf70ZDj3KEArTp5WfNpzFPY/XU41UwGoBuV475qWSi+uILtTPUx8HAKY5zr7VaSty32MIYEi
        BrZUKZ9wAN1X1cR6XR4CT5CUaNQ/5gup8bKO+FraIpH/m+ytfs6iV87O9U6ViNEoW6u4M56XHYlho
        LGcjvGraluBkhBDaXAyAYHqb7oT3lR5RlLJ9Cmuo8ePKBhadzeOIe5pSnqOJiYs58qhLwSLqdF3d3
        DgM6KMWlw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9YVL-0001PB-C9; Mon, 08 Oct 2018 16:35:35 +0000
Subject: Re: [PATCH v3 8/8] watchdog: stpmic1: add stpmic1 watchdog driver
To:     Pascal PAILLET-LME <p.paillet@st.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
References: <1539016176-4072-1-git-send-email-p.paillet@st.com>
 <1539016176-4072-9-git-send-email-p.paillet@st.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5257d6f9-7481-de33-64a5-0e1188304716@infradead.org>
Date:   Mon, 8 Oct 2018 09:35:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539016176-4072-9-git-send-email-p.paillet@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 9:29 AM, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 PMIC embeds a watchdog which is disabled by default. As soon
> as the watchdog is started, it must be refreshed periodically otherwise
> the PMIC goes off.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v3:
> * Rename struct stpmic1_dev by struct stpmic1.
> * Add nowayout module param.
> * Fix set timeout. 
> * Call watchdog_init_timeout so that the timeout can be set in the devicetree.
> * Add email address in MODULE_AUTHOR.
> 
>  drivers/watchdog/Kconfig       |  12 ++++
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/stpmic1_wdt.c | 138 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 drivers/watchdog/stpmic1_wdt.c

Hi,

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 5ea8909..985781e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -806,6 +806,18 @@ config STM32_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stm32_iwdg.
>  
> +config STPMIC1_WATCHDOG
> +	tristate "STPMIC1 PMIC watchdog support"
> +	depends on MFD_STPMIC1
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include watchdog support embedded into STPMIC1 PMIC.
> +	  If the watchdog timer expires, stpmic1 shut-down all its power

	  If the watchdog timer expires, stpmic1 shuts down all its power
or
	  If the watchdog timer expires, stpmic1 will shut down all its power

> +	  supplies.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called spmic1_wdt.
> +
>  config UNIPHIER_WATCHDOG
>  	tristate "UniPhier watchdog support"
>  	depends on ARCH_UNIPHIER || COMPILE_TEST

cheers.
-- 
~Randy
