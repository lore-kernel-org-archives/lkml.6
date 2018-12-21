Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A373C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C9A21916
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390822AbeLUN6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:58:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:39395 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390808AbeLUN6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:58:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 05:58:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; 
   d="scan'208";a="103825121"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga008.jf.intel.com with ESMTP; 21 Dec 2018 05:58:11 -0800
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Constify driver data
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
References: <20181218232652.12700-1-andrew.smirnov@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4c01046b-2b83-f124-34c8-a6feac8aca95@intel.com>
Date:   Fri, 21 Dec 2018 15:56:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181218232652.12700-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/18 1:26 AM, Andrey Smirnov wrote:
> Variant specific driver data doesn't change at run-time, so mark it as
> const to reflect that.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f44e49014a44..39ace4f1036b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -148,38 +148,38 @@ struct esdhc_soc_data {
>  	u32 flags;
>  };
>  
> -static struct esdhc_soc_data esdhc_imx25_data = {
> +static const struct esdhc_soc_data esdhc_imx25_data = {
>  	.flags = ESDHC_FLAG_ERR004536,
>  };
>  
> -static struct esdhc_soc_data esdhc_imx35_data = {
> +static const struct esdhc_soc_data esdhc_imx35_data = {
>  	.flags = ESDHC_FLAG_ERR004536,
>  };
>  
> -static struct esdhc_soc_data esdhc_imx51_data = {
> +static const struct esdhc_soc_data esdhc_imx51_data = {
>  	.flags = 0,
>  };
>  
> -static struct esdhc_soc_data esdhc_imx53_data = {
> +static const struct esdhc_soc_data esdhc_imx53_data = {
>  	.flags = ESDHC_FLAG_MULTIBLK_NO_INT,
>  };
>  
> -static struct esdhc_soc_data usdhc_imx6q_data = {
> +static const struct esdhc_soc_data usdhc_imx6q_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING,
>  };
>  
> -static struct esdhc_soc_data usdhc_imx6sl_data = {
> +static const struct esdhc_soc_data usdhc_imx6sl_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
>  			| ESDHC_FLAG_HS200,
>  };
>  
> -static struct esdhc_soc_data usdhc_imx6sx_data = {
> +static const struct esdhc_soc_data usdhc_imx6sx_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
>  };
>  
> -static struct esdhc_soc_data usdhc_imx7d_data = {
> +static const struct esdhc_soc_data usdhc_imx7d_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400,
> 

