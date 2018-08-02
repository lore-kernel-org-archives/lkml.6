Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD3FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE3321571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bNQ72riw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE3321571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbeHCAwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:52:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeHCAwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=csHd2QQAlkwbAfCB5AfzsSIhwcvgDEQSrPMsy+81g7I=; b=bNQ72riwdxOTKXMW5px03IgAX
        rmizJffELFGWf4CymPvUFhR7mrcUDRZGD0nVkHzV5gDk6erWsknwcP2B2T01lnh7M49Js59iW0i4Y
        3kI5Oigt4Fe9lP00gMhgEqz4pVfVb5NVY3E9FYW9M+/Xy0ToctxZlDeRwgpzi+qventbHThrZpZ8U
        K2nTg1Fovtw+rsR42MEUlRT9xsWmp2tRWaMZ+IyuC7nA5NiRjYjhOgAhfSWqEKv4DP+OkbeZ9T7wC
        icbOmUuqgDQ3FtJXqxe5E6HN+5Ej+Hv1wOFUrWsHj94BA2seVL76Vfrhx8sspY55F2bthZBVWYByX
        5sQR7OQdA==;
Received: from 189.27.18.116.dynamic.adsl.gvt.net.br ([189.27.18.116] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flMY8-00018K-F0; Thu, 02 Aug 2018 22:58:28 +0000
Date:   Thu, 2 Aug 2018 19:58:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: platform: cros-ec-cec: fix dependency on
 MFD_CROS_EC
Message-ID: <20180802195824.26a9720a@coco.lan>
In-Reply-To: <20180724093624.1670671-1-arnd@arndb.de>
References: <20180724093624.1670671-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 24 Jul 2018 11:35:59 +0200
Arnd Bergmann <arnd@arndb.de> escreveu:

> Without the MFD driver, we run into a link error:

Weird... I'm not seeing this driver at the media tree... was it merged via
some other tree?

> 
> drivers/media/platform/cros-ec-cec/cros-ec-cec.o: In function `cros_ec_cec_transmit':
> cros-ec-cec.c:(.text+0x474): undefined reference to `cros_ec_cmd_xfer_status'
> drivers/media/platform/cros-ec-cec/cros-ec-cec.o: In function `cros_ec_cec_set_log_addr':
> cros-ec-cec.c:(.text+0x60b): undefined reference to `cros_ec_cmd_xfer_status'
> drivers/media/platform/cros-ec-cec/cros-ec-cec.o: In function `cros_ec_cec_adap_enable':
> cros-ec-cec.c:(.text+0x77d): undefined reference to `cros_ec_cmd_xfer_status'
> 
> As we can compile-test all the dependency, the extra '| COMPILE_TEST' is
> not needed to get the build coverage, and we can simply turn MFD_CROS_EC
> into a hard dependency to make it build in all configurations.
> 
> Fixes: cd70de2d356e ("media: platform: Add ChromeOS EC CEC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/platform/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 92b182da8e4d..018fcbed82e4 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -535,7 +535,7 @@ if CEC_PLATFORM_DRIVERS
>  
>  config VIDEO_CROS_EC_CEC
>  	tristate "ChromeOS EC CEC driver"
> -	depends on MFD_CROS_EC || COMPILE_TEST
> +	depends on MFD_CROS_EC
>  	select CEC_CORE
>  	select CEC_NOTIFIER
>  	---help---



Thanks,
Mauro
