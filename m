Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47237C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1110321735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1110321735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeHTW3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:29:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50693 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeHTW3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:29:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9227C20737; Mon, 20 Aug 2018 21:12:48 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 68D362072F;
        Mon, 20 Aug 2018 21:12:48 +0200 (CEST)
Date:   Mon, 20 Aug 2018 21:12:47 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, od@zcrc.me,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: Drop dependency on MACH_INGENIC
Message-ID: <20180820191247.GU21707@piout.net>
References: <20180820180716.1853-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820180716.1853-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2018 20:07:16+0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.

Maybe you could consider dropping the whole dependency as we already
know it will build on every architecture.

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/rtc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index a2ba5db36145..98c7f19256b1 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1608,7 +1608,7 @@ config RTC_DRV_MPC5121
>  
>  config RTC_DRV_JZ4740
>  	tristate "Ingenic JZ4740 SoC"
> -	depends on MACH_INGENIC || COMPILE_TEST
> +	depends on MIPS || COMPILE_TEST
>  	help
>  	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
>  	  controllers.
> -- 
> 2.11.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
