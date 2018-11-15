Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29032C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA21F21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nZV8RHnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA21F21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeKOOkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 09:40:32 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49136 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeKOOkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 09:40:31 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAF4YBAK100299;
        Wed, 14 Nov 2018 22:34:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542256451;
        bh=4UK8O4R0P/UHnHCnVunUBGNwLBYJD5a0id+AgXMDXbE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nZV8RHnWky2UZ5Dkks1yiEh/ozknzoPo2Zyy6kJD//U0RzQ0k6bqf7JRY1HzMKQHw
         1WZOGRrBJWy/eT2I5YSjAifgVsoUUs/xxADwfsSicayOmFSokRgYyQQioEfFcQtzbO
         wRomdkXiTZTrvXfEDKAb/sIeN2MgoHfMij1LIAbg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAF4YBhV118221
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Nov 2018 22:34:11 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 14
 Nov 2018 22:34:11 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 14 Nov 2018 22:34:11 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAF4Y9oY013041;
        Wed, 14 Nov 2018 22:34:10 -0600
Subject: Re: [PATCH AUTOSEL 4.18 39/59] i2c: omap: Enable for ARCH_K3
To:     Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
 <20181114222335.99339-39-sashal@kernel.org>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <779d8829-c90d-120a-5b7d-749c07d2a2ed@ti.com>
Date:   Thu, 15 Nov 2018 10:05:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114222335.99339-39-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/11/18 3:53 AM, Sasha Levin wrote:
> From: Vignesh R <vigneshr@ti.com>
> 
> [ Upstream commit 5b277402deac0691226a947df71c581686bd4020 ]

This patch depends on c77245722fb4 ("arm64: Add support for TI's K3
Multicore SoC architecture") which adds ARCH_K3 Kconfig symbol and
merged to mainline in v4.19. Since I don't see c77245722fb4 in
stable tree, please drop this commit from stable queues prior to v4.19
(4.18, 4.14, 4.9, 4.4 and 3.18).

> 
> Allow I2C_OMAP to be built for K3 platforms.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 4f8df2ec87b1..fb3a3707a66e 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -754,7 +754,7 @@ config I2C_OCORES
>  
>  config I2C_OMAP
>  	tristate "OMAP I2C adapter"
> -	depends on ARCH_OMAP
> +	depends on ARCH_OMAP || ARCH_K3
>  	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
>  	help
>  	  If you say yes to this option, support will be included for the
> 

-- 
Regards
Vignesh
