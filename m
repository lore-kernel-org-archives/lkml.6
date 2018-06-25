Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B56EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1370525E1D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="WbSJqvSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1370525E1D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755260AbeFYQUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:20:48 -0400
Received: from vern.gendns.com ([206.190.152.46]:49035 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752161AbeFYQUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=me8FnDlvGoAR/OmXUeAie8+u58fzI4GgPsj3+JhzP6M=; b=WbSJqvSSFrUbrweDctb/PbW5rS
        3MBsSrLIt9+/0cgoAChx+s5ECSjJ+JMRhlLDWkAd7P8nnM8VJ+6fFmgPnrnFgrL0MHO09MJrnx3VE
        3/7SVJPq+iAFefP5zwpb34ivgYVm26TcBVoVhwQuYMYv2pCFBy1kL9hppo50fjrHPv2LeussPnKsy
        2B98WOPHKOugBXxHhJfiS1+fJ6xKBVAk1cTsv6aQfAH8+2AMQYWwp7JHP+tPybWLkSBcjEBenBDPt
        JfO1CFw4a4utPYuVH4U7ZJTs5+8P+nSDaDWblu9fBBYy07I/b3xcXSaoONjAVzXot39ckIxBtmR06
        Zv9a8aaA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:54348 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXUEP-001EDA-I1; Mon, 25 Jun 2018 12:20:45 -0400
Subject: Re: [PATCH 6/9] ARM: davinci: da830-evm: use aemif platform driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-7-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <0e4bc2fb-15fc-6422-a4a3-0918adf0b1b3@lechnology.com>
Date:   Mon, 25 Jun 2018 11:20:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625152920.11549-7-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now support board files in the aemif driver. Register a platform
> device instead of using the handcrafted API in da830-evm.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/board-da830-evm.c | 56 +++++++++++++++++++------
>   1 file changed, 44 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index b2470141dba3..666db3cee08a 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -28,6 +28,7 @@
>   #include <linux/platform_data/mtd-davinci-aemif.h>
>   #include <linux/platform_data/spi-davinci.h>
>   #include <linux/platform_data/usb-davinci.h>
> +#include <linux/platform_data/ti-aemif.h>
>   #include <linux/regulator/machine.h>
>   
>   #include <asm/mach-types.h>
> @@ -333,14 +334,48 @@ static struct resource da830_evm_nand_resources[] = {
>   	},
>   };
>   
> -static struct platform_device da830_evm_nand_device = {
> -	.name		= "davinci_nand",
> -	.id		= 1,
> -	.dev		= {
> -		.platform_data	= &da830_evm_nand_pdata,
> +static struct platform_device da830_evm_aemif_devices[] = {
> +	{
> +		.name		= "davinci_nand",
> +		.id		= 1,

Actually, now that I've thought about it some more. It probably
makes more sense to make all of the "davinci_nand" devices in this
series use id = -1 since there is only one per board. It looks like
da850 is the only one that has a lookup for "davinic_nand.0" already.

I think that we are going to have to add clock lookups for the
"davinci_nand" devices as well. Although the driver doesn't do
clk_get() explicitly, I think some function it calls does get a
clock. I remember that we had to add a clock-ranges property to
device tree to get the davinci_nand driver working, which is why
I think we are going to need a clock lookup for these devices
as well.

> +		.dev		= {
> +			.platform_data	= &da830_evm_nand_pdata,
> +		},
> +		.num_resources	= ARRAY_SIZE(da830_evm_nand_resources),
> +		.resource	= da830_evm_nand_resources,
> +	},
> +};
> +
