Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeEWEqv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:46:51 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34009 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeEWEqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:46:49 -0400
X-Google-Smtp-Source: AB8JxZqQrNzsU7hMXDIatK3ofDl9Mrd4izsJLSKU2U4Nuzp3zO8IXKwm4bcUoslrqHYQyBm0nxcb+Q==
Subject: Re: [PATCH v2] pinctrl: cherryview: limit Strago DMI workarounds to
 version 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180522204753.GA260493@dtor-ws>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4d8b3dd4-5218-8595-d840-ce8c106e5b08@roeck-us.net>
Date: Tue, 22 May 2018 21:46:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522204753.GA260493@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 01:47 PM, Dmitry Torokhov wrote:
> As Google/Intel will fix the BIOS/Coreboot issues with hardcoding
> virtual interrupt numbers for keyboard/touchpad/touchscreen controllers
> in ACPI tables, they will also update BOARD version number from 1.0
> to 1.1. Let's limit the DMI quirks that try to preserve virtual IRQ
> numbers on Strago boards to those that still carry older BIOSes.
> 
> Note that ideally not BOARD but BIOS version should have been updated.
> However the BIOS version used by Chrome devices has format of
> Google_BUILD.BRANCH.PATCH which is not well suited for DMI matching as
> we do not have "less than" match mode for DMI data.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197953
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> v1->v2:
> 
> - switch from matching on DMI_BIOS_VERSION to DMI_BOARD_VERSION
> 
> 
>   drivers/pinctrl/intel/pinctrl-cherryview.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
> index b1ae1618fefea..44133e6846303 100644
> --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
> +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
> @@ -1527,6 +1527,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
>   			DMI_MATCH(DMI_PRODUCT_FAMILY, "Intel_Strago"),
> +			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
>   		},
>   	},
>   	{
> @@ -1534,6 +1535,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
> +			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
>   		},
>   	},
>   	{
> @@ -1541,6 +1543,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
> +			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
>   		},
>   	},
>   	{
> @@ -1548,6 +1551,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
> +			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
>   		},
>   	},
>   	{}
> 
