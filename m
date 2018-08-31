Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C012083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C012083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeHaQCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:02:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:29446 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbeHaQCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:02:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 04:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="67426419"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2018 04:54:58 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1fvi0v-0003kc-US; Fri, 31 Aug 2018 14:54:57 +0300
Date:   Fri, 31 Aug 2018 14:54:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>
Subject: Re: [PATCH] spi: dw-mmio: avoid hardcoded field mask
Message-ID: <20180831115457.GX11447@smile.fi.intel.com>
References: <20180831114046.27094-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831114046.27094-1-alexandre.belloni@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 01:40:46PM +0200, Alexandre Belloni wrote:
> Define a mask for the IF_SI_OWNER field.
> 

Thanks!

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 351f49976161..a768461614a0 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -36,6 +36,7 @@ struct dw_spi_mmio {
>  #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
>  #define OCELOT_IF_SI_OWNER_OFFSET		4
>  #define JAGUAR2_IF_SI_OWNER_OFFSET		6
> +#define MSCC_IF_SI_OWNER_MASK			GENMASK(1, 0)
>  #define MSCC_IF_SI_OWNER_SISL			0
>  #define MSCC_IF_SI_OWNER_SIBM			1
>  #define MSCC_IF_SI_OWNER_SIMC			2
> @@ -102,7 +103,7 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
>  
>  	/* Select the owner of the SI interface */
>  	regmap_update_bits(dwsmscc->syscon, MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL,
> -			   0x3 << if_si_owner_offset,
> +			   MSCC_IF_SI_OWNER_MASK << if_si_owner_offset,
>  			   MSCC_IF_SI_OWNER_SIMC << if_si_owner_offset);
>  
>  	dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
> -- 
> 2.19.0.rc1
> 

-- 
With Best Regards,
Andy Shevchenko


