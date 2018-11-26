Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18114C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB96620672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fRapLphJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB96620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeK0ASL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:18:11 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42782 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeK0ASL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:18:11 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQDNxcq027720;
        Mon, 26 Nov 2018 07:23:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543238639;
        bh=VGc6pzNgvur8ZWNw3Z3Dfu+jy5KWvlnRLWF5dhbGDpw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fRapLphJwbTKuqkI7vhOMko/G/6YyJR1TmPZCkaGlvubSFRaDHO6HwRmMaI/pKIS6
         1sNd1UBSWvkDAdn0p/TRZnhS8KVdR4/PdUdo+MiDjJ59ozGJoSo8b6eTGiyP18Fg9g
         QTKZDlRSi4UytgmjdfomVW8R1U6471blikX4nkRw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQDNxnc012044
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 07:23:59 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 07:23:58 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 07:23:58 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQDNuEl005766;
        Mon, 26 Nov 2018 07:23:57 -0600
Subject: Re: [PATCH 4.14 32/62] i2c: omap: Enable for ARCH_K3
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <stable@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
References: <20181126105050.592727680@linuxfoundation.org>
 <20181126105053.367583470@linuxfoundation.org>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <3c9dbe29-1fa0-9e2d-7fe2-6049dd38716f@ti.com>
Date:   Mon, 26 Nov 2018 18:54:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126105053.367583470@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 26/11/18 4:21 PM, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.


This patch depends on c77245722fb4 ("arm64: Add support for TI's K3
Multicore SoC architecture") which adds ARCH_K3 Kconfig symbol and
merged to mainline in v4.19. Since I don't see c77245722fb4 in
stable tree, could you please drop this patch from _all prior versions_
i.e 4.14, 4.9, 4.4 and 3.18. Thanks!


> 
> ------------------
> 
> [ Upstream commit 5b277402deac0691226a947df71c581686bd4020 ]
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
> index 45a3f3ca29b3..75ea367ffd83 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -759,7 +759,7 @@ config I2C_OCORES
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
