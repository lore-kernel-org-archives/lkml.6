Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DB4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893A3218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vN6o3bZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfBLIOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:14:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37247 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfBLION (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:14:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so1609313wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Mu/bNZfcIBvnc3stWwLO6mBsPkEbxA0WRmCDTazCdNI=;
        b=vN6o3bZFRV58qsGtVEEh9HaeeHIV71Fv4mQ3DKqmTlKo9iSdqdHbhITWQZSSu93Wjr
         ZIL8Mo+aPtf2hGaZwVLPpd7c9Y7j1VAxPNV3d15jpdMZfiNv8xSeGgVvdwYULHOnOq9S
         QCYBZjdxky/AUOyTkM5P/zbYp9VnWbudLuwGkaXM3o2WDU5du3sVjxSb/1s0k6azTBJg
         OLbu9Gq5xDB7Kbp7OVAFPdqaeyjQ0lzjyHq+0AUYa/ohCCbpUYiVRDSE+8yweKW0DpGD
         MGRIPRzRCw8fqjZDTcgwFslnOBeBUBMuEx2bOF+qi5wma+YCZrti8aPecPwuJBGyV0mw
         fUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Mu/bNZfcIBvnc3stWwLO6mBsPkEbxA0WRmCDTazCdNI=;
        b=Dj3NKgp9nfvVPvvExTWT1nuC/kFw6ztF683IqEzkw7KUrCT5UPNRdJk55dPywGBAlw
         LLuHu4aW67w55/a6r/TtoB01mah+KS40/OxhwjX+luwL6gJ8D9MfcpMudo+0YLaMa8AJ
         6J6yyeqKAxO8jRw1OARPhAx5QbZgKH2UgtytLdEs8fKysgJRplcQBkps8YRnYyieB/2B
         EggfUhjKgmoiKxHMjcVuhy2ie7ODh+uqebM4qasUoQVNgJEVlDLJEIVvm7kRqMLYNnCs
         YcbhBuZFZe0lXgmVuxk02aDXk0lQronLjE8DUV6DI9P5mssH1FEwNDoiKUPceq2Zo5kf
         NFYQ==
X-Gm-Message-State: AHQUAua9gllo+S41QzW46HMdwl8BRepa3Qc5F1oieC1igJYkkpCfv5S1
        eC5PZLvgTfftVIfwzCDa25HysQ==
X-Google-Smtp-Source: AHgI3IZ30BLVkpgzI5vy9vL+4zB9y26lD0HGEHfFxpF9oloIqeGUtto/fT+rEqsU1CpHE1rslDT9wQ==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr1831034wrp.44.1549959251837;
        Tue, 12 Feb 2019 00:14:11 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id b18sm9744769wrw.83.2019.02.12.00.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:14:11 -0800 (PST)
Date:   Tue, 12 Feb 2019 08:14:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] mfd: Add leds MFD cell for intel_soc_pmic_chtwc
Message-ID: <20190212081409.GN20638@dell>
References: <20190209221213.24052-1-jekhor@gmail.com>
 <20190209221213.24052-3-jekhor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190209221213.24052-3-jekhor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019, Yauhen Kharuzhy wrote:

> Add MFD cell for LEDs driver to the Intel Cherry Trail Whiskey Cove PMIC
> mfd device driver.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/mfd/intel_soc_pmic_chtwc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
> index 64a3aece9c5e..68b54173edd8 100644
> --- a/drivers/mfd/intel_soc_pmic_chtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_chtwc.c
> @@ -60,6 +60,8 @@ static struct mfd_cell cht_wc_dev[] = {
>  		.resources = cht_wc_ext_charger_resources,
>  	},
>  	{	.name = "cht_wcove_region", },
> +

Nit: No need for the blank line, please remove it.

> +	{	.name = "cht_wcove_leds", },
>  };
>  
>  /*

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
