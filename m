Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbjXn38R"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6F61605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbeFFGmB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:42:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45434 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbeFFGl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:41:59 -0400
X-Google-Smtp-Source: ADUXVKLRStnmdxKbEr2HotjZOQy0XqQFUvCH5Ft6a4+YatgsHiSYcJexkFv02Kvwp1uQIBJ9QE7IJg==
Date: Wed, 6 Jun 2018 07:41:56 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 10/12] mfd: da9063: Register RTC only on DA9063L
Message-ID: <20180606064156.GA21163@dell>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
 <20180605231013.1803-10-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180605231013.1803-10-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2018, Marek Vasut wrote:

> The DA9063L does not contain RTC block, unlike the full DA9063.
> Split the RTC block into separate mfd cell and register it only
> on DA9063.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: No change
> V3: Rework of mfd: da9063: Disallow RTC on DA9063L
> V4: - Change the original failure text
>     - Use PLATFORM_DEVID_NONE in mfd_add_devices
> ---
>  drivers/mfd/da9063-core.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index 9aff815877c0..3443c9321c09 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -76,7 +76,7 @@ static struct resource da9063_hwmon_resources[] = {
>  };
>  
>  
> -static const struct mfd_cell da9063_devs[] = {
> +static const struct mfd_cell da9063_common_devs[] = {
>  	{
>  		.name		= DA9063_DRVNAME_REGULATORS,
>  		.num_resources	= ARRAY_SIZE(da9063_regulators_resources),
> @@ -100,15 +100,19 @@ static const struct mfd_cell da9063_devs[] = {
>  		.resources	= da9063_onkey_resources,
>  		.of_compatible = "dlg,da9063-onkey",
>  	},
> +	{
> +		.name		= DA9063_DRVNAME_VIBRATION,
> +	},
> +};

Still not a fan of multi-line single entries, but seeing as it was
already multi-line and you are just moving it, I'll let it go.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
