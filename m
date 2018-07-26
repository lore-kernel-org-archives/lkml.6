Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7ADC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE89920673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcwxjnZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE89920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbeGZPNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:13:31 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38635 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729894AbeGZPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:13:31 -0400
Received: by mail-qk0-f193.google.com with SMTP id 126-v6so1032755qke.5;
        Thu, 26 Jul 2018 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oSMktVM3OssOAue1EE1XSU1vqnJqkA/LqLuJ0zq00xE=;
        b=vcwxjnZbiFI5JaKOapsOid18AVBD2X3zxWjsJRqDKFZ5gaCee/jA7WX2zTWdocMEH6
         U2l9A+eP1s/DS2uvpgQFa7DsBBppftl6T/KplUnh1PoKLw5DpfvdMPe507eW8LB1alBq
         zPFm9dceKEvKraSpx9ZXxqNh81AQwyr3jJolFBaac4GfF4TlBREa17y98YtO/YpiFaGh
         lNUzsjzvyjJajWWRquI26vAcHdCxNMXSK8JHPbCH3nwOrvuVT3J3JlPhJPLtTjoI4Gw+
         N2DF1xTfLXCOAbbJrVyfHOxqobfVi4jlur609Fk5Rh/1Yw1yb2Usekun0OHXERxpxnNg
         vwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oSMktVM3OssOAue1EE1XSU1vqnJqkA/LqLuJ0zq00xE=;
        b=B/jOKV1plGAbqlPfZ1ajgD0iytGbc/95EP9iaWAtBiwuH3syvDY4sKdUESN9BkLtCx
         xIujc0GUi9mDtWR1t0fhn70UhYmReBC4s9FbTdCCbND/yvmp0fa6DjhL8SO/74L8FTnL
         lSiOG+mhx7bg0BJNBNvJlCfckBeeSsbMD/1x4qFDGdwZXPPdfJpE6t6AP6MzG+khJp6p
         D+DNRdwe/xO3JeLE2g06r1/C34X1h2/82q6zrbsHsmucWkujc35YRfpAq7p7sLpH6G2i
         k0O406rpUqXa9i0lYsDpLgLGhhHcxT4fXQQrUEi0phB1+MFIdnfQVaa45wVE2P66Spfh
         LKxA==
X-Gm-Message-State: AOUpUlH/ep4NsDg2UyPL/ccWTcBnWV8m8UVOtDTcBuRy37/m5liKHiGn
        XoJEJc0LiEUPwESteP/UPPfuI9xf3JI=
X-Google-Smtp-Source: AAOMgpdbPmnNRAVy6skRIG5HA4lsRX00do6ooRfyzS8jA35zv8MDdIVDcjZfl3W4gWbwvrchCW4Pig==
X-Received: by 2002:a37:16d1:: with SMTP id 78-v6mr1847922qkw.271.1532613391151;
        Thu, 26 Jul 2018 06:56:31 -0700 (PDT)
Received: from [192.168.44.96] (42.sub-174-226-17.myvzw.com. [174.226.17.42])
        by smtp.gmail.com with ESMTPSA id p64-v6sm1055198qkl.30.2018.07.26.06.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 06:56:30 -0700 (PDT)
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
To:     Stefan Agner <stefan@agner.ch>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180712073904.4705-1-stefan@agner.ch>
 <20180712073904.4705-3-stefan@agner.ch>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <430c718d-9ede-d47a-44c0-b8e47e297720@gmail.com>
Date:   Thu, 26 Jul 2018 09:56:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180712073904.4705-3-stefan@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 03:39 AM, Stefan Agner wrote:
> It seems that SD3.0 advertisement needs to be set for higher eMMC
> speed modes (namely DDR52) as well. The TRM states that the SD3.0
> advertisement bit should be set for all controller instances, even
> for those not supporting UHS-I mode...
> 
> When specifying vqmmc-supply as a fixed 1.8V regulator on a Tegra
> SD/MMC instance which is connected to a eMMC device, the stack
> enables SD3.0. However, enabling it has consequences: If SDHCI 3.0
> support is advertised the stack enables Auto-CMD23. Unfortunately
> Auto-CMD23 seems not to work well with Tegra 3 currently. It leads
> to regular warnings:
>    mmc2: Got command interrupt 0x00010000 even though no command operation was in progress.
> 
> It is not entirely clear why those errors happens. It seems that
> a Linux 3.1 based downstream kernel which has Auto-CMD23 support
> does not show those warnings.
> 
> Use quirk SDHCI_QUIRK2_ACMD23_BROKEN to prevent Auto-CMD23 being
> used for now. With this the eMMC works stable on high-speed mode
> while still announcing SD3.0.
> 
> This allows to use mmc-ddr-1_8v to enables DDR52 mode. In DDR52
> mode read speed improves from about 42MiB/s to 72MiB/s on an
> Apalis T30.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 888a1ad511db..11c0b2069c7c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -336,7 +336,15 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>   		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>   		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>   	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		   SDHCI_QUIRK2_BROKEN_HS200,
> +		   SDHCI_QUIRK2_BROKEN_HS200 |
> +		   /*
> +		    * Auto-CMD23 leads to "Got command interrupt 0x00010000 even
> +		    * though no command operation was in progress."
> +		    *
> +		    * The exact reason is unknown, as the same hardware seems
> +		    * to support Auto CMD23 on a downstream 3.1 kernel.
> +		    */
> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
>   	.ops  = &tegra_sdhci_ops,
>   };
>   

I finally got around to testing this on the Ouya (Tegra 3).

I found that the "Got command interrupt 0x00010000 even though no 
command operation was in progress." error occurred when the interface is 
unstable.
I've had a lot of problems with sdmmc4 stability on the Ouya above 34 
Mhz, probably due to the fact that they are using the internal cmd and 
clock pull-up resistors, against the TRM's instruction.
At 39Mhz, I saw the error this patch corrects.
With the patch, the error went away, but the interface is still unstable 
under load.

Lowering down to 32Mhz, without the patch there are no errors.

