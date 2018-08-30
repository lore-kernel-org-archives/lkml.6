Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0417C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785E320658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t73M7XEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785E320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeH3Tjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:39:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeH3Tjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qvLTcBynxe7YytLApWsWiTzPBK6DQmOsHsc5IehBWDw=; b=t73M7XEuoQJCxrPJbRUc3bOad
        x8JOGZR/Un7nGNItBJClwjO6XcMiAm6MU5VNm+LdKIOHwaMpwXkbkB6Xj6heMyGvJOa38aUKLI3/L
        wII3FIqIc8kPmKXZiHpBUE7MSnCOa3Y1ZOZpPL2/KrFcwKpuP6OoDe5kn4l9SwGhZmLCrjbVGSaii
        2qE0G+ILdDGtnVDx/TnLwHc/9Mkr8KP7kphOWGF6DAsNr8vP/MoYLxED1/QMAYulPqBiWdXOhNcr7
        AZIYkkI8o+KJ5XdzZpJBNJn1UKisYE4/MXUkxf3zsORbU5Qp8lJm8r/EVFDrpN5rFitXFUsddXuJ6
        qTuWb0iww==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvP0B-0006MF-Vu; Thu, 30 Aug 2018 15:36:56 +0000
Subject: Re: [PATCH 2/3] iio: adc: Add Xilinx AMS driver
To:     Manish Narani <manish.narani@xilinx.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        leoyang.li@nxp.com, sudeep.holla@arm.com, amit.kucheria@linaro.org,
        broonie@kernel.org, arnaud.pouliquen@st.com, geert@linux-m68k.org,
        eugen.hristev@microchip.com, lukas@wunner.de,
        freeman.liu@spreadtrum.com, vilhelm.gray@gmail.com,
        tglx@linutronix.de, baolin.wang@linaro.org,
        gregkh@linuxfoundation.org
Cc:     sgoud@xilinx.com, anirudh@xilinx.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
 <1535624539-7839-3-git-send-email-manish.narani@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <378c10f8-9760-b36a-431d-4ce4339d7345@infradead.org>
Date:   Thu, 30 Aug 2018 08:36:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535624539-7839-3-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 03:22 AM, Manish Narani wrote:
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 4a75492..405ea00 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -941,4 +941,14 @@ config XILINX_XADC
>  	  The driver can also be build as a module. If so, the module will be called
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
