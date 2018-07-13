Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6352EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1919E20850
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s8Oy50gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1919E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbeGMQm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:42:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbeGMQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CC5wZkA9YcH3GtVEYQ2Y8UKz6IArRPrmiBINLSVJf0w=; b=s8Oy50ghBEyRoBdnndewztyqr
        GJkIfCFxH5aisVhNcE2pOof38IdyzCtaMXpw5XwiSJIVmvZRZ9P6YpfkduZPgPKMgLbafcBoWvMBp
        esYhegxVqdKT+2fjuZSvsWMHExrLR+dQK97KD/F4kYs8RALMbFpeg8ew+AIuGWR73Ztq2cZ8PLdiv
        3SCmYoWBSFLb+KDER9Wt4f7txTN93yklgfQ0GAP9htrP3Fe8u2N8LZlajj8vZjuZXSRGPGwTLCa/O
        3NEP9MK8HUWINmBOPivWtn9Q+aHsxyEGHqkboTCEIVXOC6S/ePOvndtvWBEoVIAqId6ZQVCdv704M
        3btCbfBDA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fe0uu-0004bj-Mu; Fri, 13 Jul 2018 16:27:36 +0000
Subject: =?UTF-8?Q?Re:_[PATCH_1/2]_mux:adgs1408/1409:_New_driver_for_Analog_?=
 =?UTF-8?Q?Devices_ADGS1408/1409_mux_=e2=80=a6?=
To:     Mircea Caprioru <mircea.caprioru@analog.com>, peda@axentia.se
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20180713122738.5888-1-mircea.caprioru@analog.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5ba54993-7069-9d1c-6d97-938a67d43fe7@infradead.org>
Date:   Fri, 13 Jul 2018 09:27:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713122738.5888-1-mircea.caprioru@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 05:27 AM, Mircea Caprioru wrote:
> This patch adds basic support for Analog Device ADGS1408/09 SPI mux
> controller.
> 
> The device is probed and set to a disabled state. It uses the new mux
> controller framework.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
>  MAINTAINERS            |   7 +++
>  drivers/mux/Kconfig    |  12 ++++
>  drivers/mux/Makefile   |   2 +
>  drivers/mux/adgs140x.c | 132 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 153 insertions(+)
>  create mode 100644 drivers/mux/adgs140x.c

> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index 6241678e99af..87b3fda56d8f 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -48,4 +48,16 @@ config MUX_MMIO
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called mux-mmio.
>  
> +config MUX_ADGS140X
> +	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
> +	depends on SPI
> +	help
> +	  ADGS1408 and ADGS1409 4 independent single-pole/single-throw

maybe:
	  ADGS1408 and ADGS1409 have 4 independent single-pole/single-throw

> +	  switches.
> +
> +	  The driver suports driving each switch independently.

	             supports

> +
> +	  To compile the driver as a module, choose M here: the module will
> +	  be called mux-ads140x.

	            mux-adgs140x.

> +
>  endmenu
> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
> index c3d883955fd5..236e7738462a 100644
> --- a/drivers/mux/Makefile
> +++ b/drivers/mux/Makefile
> @@ -5,10 +5,12 @@
>  
>  mux-core-objs			:= core.o
>  mux-adg792a-objs		:= adg792a.o
> +mux-adgs140x-objs		:= adgs140x.o
>  mux-gpio-objs			:= gpio.o
>  mux-mmio-objs			:= mmio.o
>  
>  obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
>  obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
> +obj-$(CONFIG_MUX_ADGS140X)	+= mux-adgs140x.o
>  obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
>  obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o


-- 
~Randy
