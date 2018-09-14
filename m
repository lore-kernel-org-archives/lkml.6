Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05212ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29432083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HWYqeV3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29432083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeIOCqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:46:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeIOCqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SJCUjoNMbtfR5curB2L7fQhRtOSkbGeB+rsYxb01Nns=; b=HWYqeV3w3OWBa2LxZN0hLr7Vk
        DrgpvCDG1St7ZCYFG4D7zuHIFpfIME/dgq2WlINj+wLVpiUNv/zRwk7y7+ZVxakpYgFqZHDJ3jOZi
        1JQEL499ihtfq+rQWFh5JWYqbvJiCIfKf5FPsCadU0XyY3NJ/iXy41MRA/qpYdnhYQ4EIkyRtnCUA
        oWKEWCyKC21KWkcpooLNp2SQyeUby9Izj98XQd6rXmPU3GW3+eE3BR2Njc7RX1kDSISkhkhG7ITf2
        gnJA3Bf+sLs6twmXZEiinK2UiYL+g8z8NUY8MNGkjzesmU50pzyJ2ugAB6orQMcBJEvtoZgrIqhkE
        PtwfEgFHg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0vfJ-0000yx-CP; Fri, 14 Sep 2018 21:30:13 +0000
Subject: Re: [PATCH v2 3/4] iio: adc: Add Xilinx AMS driver
To:     Manish Narani <manish.narani@xilinx.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        michal.simek@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com,
        sudeep.holla@arm.com, amit.kucheria@linaro.org, leoyang.li@nxp.com,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        eugen.hristev@microchip.com, geert@linux-m68k.org,
        ak@it-klinger.de, freeman.liu@spreadtrum.com, lukas@wunner.de,
        vilhelm.gray@gmail.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org
Cc:     sgoud@xilinx.com, anirudh@xilinx.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
 <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f169ebb6-6c2c-6f30-d59c-e89561622ecb@infradead.org>
Date:   Fri, 14 Sep 2018 14:30:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/18 12:18 AM, Manish Narani wrote:
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/iio/adc/Kconfig      |   10 +
>  drivers/iio/adc/Makefile     |    1 +
>  drivers/iio/adc/xilinx-ams.c | 1337 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1348 insertions(+)
>  create mode 100644 drivers/iio/adc/xilinx-ams.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 4a75492..405ea00 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -941,4 +941,14 @@ config XILINX_XADC
>  	  The driver can also be build as a module. If so, the module will be called

oops (some other driver:)
	                         built

>  	  xilinx-xadc.
>  
> +config XILINX_AMS
> +	tristate "Xilinx AMS driver"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Say yes here to have support for the Xilinx AMS.
> +
> +	  The driver can also be build as a module. If so, the module will be called

	                         built

> +	  xilinx-ams.
> +
>  endmenu


-- 
~Randy
