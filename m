Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61660C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45402084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qdAJDKj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45402084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeJEWvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:51:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50604 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeJEWu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:50:59 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w95FpEeE126156;
        Fri, 5 Oct 2018 10:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538754674;
        bh=ZmPvNu3g8G7v8TFkysteTYN3mPHsrAm0Y2/Un0qdXKM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qdAJDKj8RF9RZCS7QibxTkiu/ZlVZt4pV28+ejEe3+vBjn9oUuuHnnxLOqs9IFzPl
         5JD8z42zM/sj13kdbX4rV89/r1M29VmQbs/HjY/10YISuyjb/2czQfjCTWeMbqfXz7
         RizrWGjL+xUaaKCcpv45aGcrdwYEFJvETj+xdF3w=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95FpElT028916;
        Fri, 5 Oct 2018 10:51:14 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 5 Oct
 2018 10:51:13 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 5 Oct 2018 10:51:14 -0500
Received: from [172.22.128.128] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95FpDV0018945;
        Fri, 5 Oct 2018 10:51:13 -0500
Subject: Re: [PATCH 2/2] pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
To:     Vignesh R <vigneshr@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20181003170658.3835-1-vigneshr@ti.com>
 <20181003170658.3835-3-vigneshr@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <ef269f60-b92d-c8af-77b2-d3d299814b5c@ti.com>
Date:   Fri, 5 Oct 2018 10:51:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003170658.3835-3-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2018 12:06 PM, Vignesh R wrote:
> K3 devices have the same ECAP IP as OMAP SoC. Enable driver to be built
> for K3 devices.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 504d252716f2..0c7bc6f554cf 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -447,7 +447,7 @@ config PWM_TEGRA
>  
>  config  PWM_TIECAP
>  	tristate "ECAP PWM support"
> -	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE
> +	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3
>  	help
>  	  PWM driver support for the ECAP APWM controller found on AM33XX
>  	  TI SOC
> 

Minor, perhaps calling out AM33XX specifically in the help text is no
longer needed and a bit confusing.

Andrew
