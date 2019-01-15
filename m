Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870E3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6160E20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfAOFdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:33:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:14301 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfAOFdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:33:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 21:33:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="125954931"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2019 21:32:59 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gjHLO-0000Si-Gz; Tue, 15 Jan 2019 07:32:58 +0200
Date:   Tue, 15 Jan 2019 07:32:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: cherryview: fix Strago DMI workaround
Message-ID: <20190115053258.GA9170@smile.fi.intel.com>
References: <20190115033836.GA150475@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115033836.GA150475@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 07:38:36PM -0800, Dmitry Torokhov wrote:
> Well, hopefully 3rd time is a charm. We tried making that check
> DMI_BIOS_VERSION and DMI_BOARD_VERSION, but the real one is
> DMI_PRODUCT_VERSION.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 86c5dd6860a6 ("pinctrl: cherryview: limit Strago DMI workarounds to version 1.0")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197953
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1631930
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
> index 9b0f4b9ef482..8efe8ea45602 100644
> --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
> +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
> @@ -1507,7 +1507,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
>  			DMI_MATCH(DMI_PRODUCT_FAMILY, "Intel_Strago"),
> -			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
>  		},
>  	},
>  	{
> @@ -1515,7 +1515,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
> -			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
>  		},
>  	},
>  	{
> @@ -1523,7 +1523,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
> -			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
>  		},
>  	},
>  	{
> @@ -1531,7 +1531,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
> -			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
>  		},
>  	},
>  	{}
> -- 
> 2.20.1.97.g81188d93c3-goog
> 
> 
> -- 
> Dmitry

-- 
With Best Regards,
Andy Shevchenko


