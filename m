Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeDYJvs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:51:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:41032 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbeDYJvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:51:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,325,1520924400";
   d="scan'208";a="49786020"
Date: Wed, 25 Apr 2018 12:51:41 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Javier Arteaga <javier@emutex.com>
Cc: Lee Jones <lee.jones@linaro.org>, "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 1/3] mfd: upboard: Add UP2 platform controller
 driver
Message-ID: <20180425095141.GL2173@lahna.fi.intel.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <20180421085009.28773-2-javier@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421085009.28773-2-javier@emutex.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 09:50:07AM +0100, Javier Arteaga wrote:
> +static const struct acpi_device_id upboard_acpi_match[] = {
> +	{ "AANT0F01", (kernel_ulong_t) &upboard_up2_data },

No space after cast so write it like,

	{ "AANT0F01", (kernel_ulong_t)&upboard_up2_data },


> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, upboard_acpi_match);
> +
> +static int upboard_probe(struct platform_device *pdev)
> +{
> +	struct upboard *upboard;
> +	const struct acpi_device_id *id;
> +	const struct upboard_data *upboard_data;
> +	int ret;
> +
> +	id = acpi_match_device(upboard_acpi_match, &pdev->dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	upboard_data = (const struct upboard_data *) id->driver_data;

Ditto and to other places.

Otherwise looks good to me.
