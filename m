Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0996C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A2920855
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvJYsg1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfBCJiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 04:38:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55088 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfBCJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 04:38:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so10178589wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 01:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j7kabuj/R/Wl+FA3xMNZwAPZLScIbShlL+vREBiYUc8=;
        b=AvJYsg1gyfGQ6sMDOiYM7qNNMz3foVwr6+25h7H4o9nx1EzSFRijiOTY8MzaozY3K/
         kxMFqkkshGVRA04cUpxSgK5rGpElu12bpGhmCUqh8qqeebtNwY8QoOdObKy4hyRiEJH+
         prmrT7P5TYnQt/g/+EwQxtzgNR2VugYzAO6CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j7kabuj/R/Wl+FA3xMNZwAPZLScIbShlL+vREBiYUc8=;
        b=mGhFn2XD27Dv2/azWWi9gppLY+1WVoDquz1hGw/GGc6i6Hw5jYhbyoOhRXbaqVCuea
         UrlRCWaY0FE5Fy1exz46NZQn5ilo4rRUfQiclf2CPih73qm2TEcHf+1N03cxPYlA6CB0
         E9eNzVvQAZnkpZU/YrCnhbKfnzv852zNd/pSvVT6tiCYGCWD8GVi6ueeqjYUhXOgOmdz
         s+tdf9d9HKEBLO/0JSkye1jX0N3GARRPuBfmDGjOdz3Xoanc+SDYdWJK9uM+7ASaPAIJ
         SJ5ibH9sd6DKmI2GNfCoIiO1MxTmKHdM3AM9gcjofJHIcs2r9kMQdiEOmP+LiNejwoFu
         x+uw==
X-Gm-Message-State: AHQUAuYcYzo8qGnxc4XC0/KT9jrcSOjO3knAUsxFbNF1GWBF4jfvu+O3
        SVaKtD7mW84uYup8UcxobUSjtsPO3KA=
X-Google-Smtp-Source: AHgI3IZzlWSxHbRKnuYfLoF6iLPhaZKVssKrN5nmB0L0dSIkNbOek3ctRXhtTWJZjGq+Vv8aDZPUlw==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr9384528wmf.38.1549186693309;
        Sun, 03 Feb 2019 01:38:13 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y20sm1368299wra.51.2019.02.03.01.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 01:38:12 -0800 (PST)
Subject: Re: [PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, jollys@xilinx.com,
        rajanv@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190204070951.6933-1-nava.manne@xilinx.com>
 <20190204070951.6933-4-nava.manne@xilinx.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <67e2af69-10bc-655c-e730-4c02a6375381@linaro.org>
Date:   Sun, 3 Feb 2019 09:38:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204070951.6933-4-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/2019 07:09, Nava kishore Manne wrote:
>   
> -config SC27XX_EFUSE
> -	tristate "Spreadtrum SC27XX eFuse Support"
> -	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> -	depends on HAS_IOMEM

Why are you removing SC27XX_EFUSE support here?

It does not look right!

> +config NVMEM_ZYNQMP
> +	bool "Xilinx ZYNQMP SoC nvmem firmware support"
> +	depends on ARCH_ZYNQMP
>   	help
> -	  This is a simple driver to dump specified values of Spreadtrum
> -	  SC27XX PMICs from eFuse.
> +	  This is a driver to access hardware related data like
> +	  soc revision, IDCODE... etc by using the firmware
> +	  interface.
>   
> -	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem-sc27xx-efuse.
> +	  If sure, say yes. If unsure, say no.
>   
>   endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 4e8c61628f1a..0b3abd7f5d02 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -39,5 +39,6 @@ obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
>   nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
>   obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
>   nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
> -obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
> -nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o

same here?

> +obj-$(CONFIG_NVMEM_ZYNQMP)     += nvmem_zynqmp_nvmem.o
> +nvmem_zynqmp_nvmem-y           := zynqmp_nvmem.o
> +

--srini
