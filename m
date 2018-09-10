Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC7C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DE32086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y86nQ739"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DE32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeIJIxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:53:07 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37128 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeIJIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:53:07 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8A40mwv039443;
        Sun, 9 Sep 2018 23:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536552048;
        bh=il9eeY8kaCYfB5txv5IJorCAErFzWSric+0nlahQic8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=y86nQ739NOHbhC7bsG4+/G1pzAMKdjyebaSSQW2G/lSYWeALed6CUciOYFgaY4PnR
         oRW0C8cDn9YwFtbDvwgN6J8yWBAp+Joi/NUjog8rs1qZOJWmgIjw+F1pd875bNe8Hu
         A8TlTZHFYADQwsWcUvGmByTVVL0H5T3frd6sXncc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8A40mbq005106;
        Sun, 9 Sep 2018 23:00:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sun, 9 Sep
 2018 23:00:47 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sun, 9 Sep 2018 23:00:47 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8A40jlD001123;
        Sun, 9 Sep 2018 23:00:45 -0500
Subject: Re: [PATCH] serial: 8250_omap: Make 8250_omap driver driver depend on
 ARCH_K3
To:     Nishanth Menon <nm@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>
References: <20180828010302.2751-1-nm@ti.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <9bc2eab8-af4c-1a90-50da-533087b0314b@ti.com>
Date:   Mon, 10 Sep 2018 09:31:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828010302.2751-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 28 August 2018 06:33 AM, Nishanth Menon wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> Allow 8250 omap serial driver to be used for K3 platforms.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 

Acked-by: Vignesh R <vigneshr@ti.com>

> Now that we have the device tree support merged integrated AND we have ARCH_K3,
> Lets enable the 820 OMAP Driver to build for ARCH_K3 and make it operational.
> 
>  drivers/tty/serial/8250/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index f005eaf8bc57..15c2c5463835 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -375,7 +375,7 @@ config SERIAL_8250_RT288X
>  
>  config SERIAL_8250_OMAP
>  	tristate "Support for OMAP internal UART (8250 based driver)"
> -	depends on SERIAL_8250 && ARCH_OMAP2PLUS
> +	depends on SERIAL_8250 && (ARCH_OMAP2PLUS || ARCH_K3)
>  	help
>  	  If you have a machine based on an Texas Instruments OMAP CPU you
>  	  can enable its onboard serial ports by enabling this option.
> 

-- 
Regards
Vignesh
