Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DECC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BCB2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BCB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeJZCUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:20:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:1402 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727465AbeJZCUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:20:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 10:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,425,1534834800"; 
   d="scan'208";a="84466760"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 25 Oct 2018 10:46:40 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gFjiQ-0004iJ-VU; Thu, 25 Oct 2018 20:46:38 +0300
Date:   Thu, 25 Oct 2018 20:46:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v3 2/3] iio: adc128s052: add ACPI _HID AANT1280
Message-ID: <20181025174638.GB10650@smile.fi.intel.com>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
 <1540481742-23596-3-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540481742-23596-3-git-send-email-dan@emutex.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 04:35:41PM +0100, Dan O'Donovan wrote:
> From: Nicola Lunghi <nicola.lunghi@emutex.com>
> 
> ACPI _HID AANT1280 matches an ADC124S101 present on E3940 SKUs of the UP
> Squared board.
> 
> Add it to the driver.
> 
> Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
> [javier@emutex.com: fix up commit message and one checkpatch warning]
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index e6716c3..c2d1453 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -12,10 +12,12 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/err.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
>  #include <linux/iio/iio.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  
>  struct adc128_configuration {
> @@ -135,10 +137,15 @@ static const struct iio_info adc128_info = {
>  static int adc128_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> +	unsigned int config;
>  	struct adc128 *adc;
> -	int config = spi_get_device_id(spi)->driver_data;
>  	int ret;
>  
> +	if (dev_fwnode(&spi->dev))
> +		config = (unsigned long) device_get_match_data(&spi->dev);
> +	else
> +		config = spi_get_device_id(spi)->driver_data;
> +
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -207,10 +214,19 @@ static const struct spi_device_id adc128_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, adc128_id);
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id adc128_acpi_match[] = {

> +	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */

Looking how driver is organized and what ACPI can provide I would highly
recommend to look forward to PTYP field for utilization of the type of the HW.

Maybe it would not work with published BIOSes, but would be good for the future
(in that case anybody can utilize that _HID + PTYP pair on their platforms).

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
> +#endif
> +
>  static struct spi_driver adc128_driver = {
>  	.driver = {
>  		.name = "adc128s052",

>  		.of_match_table = of_match_ptr(adc128_of_match),
> +		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
>  	},
>  	.probe = adc128_probe,
>  	.remove = adc128_remove,
> -- 
> 2.7.4
> 
> 
> ------
> This email has been scanned for spam and malware by The Email Laundry.
> 

-- 
With Best Regards,
Andy Shevchenko


