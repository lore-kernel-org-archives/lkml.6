Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936045AbeE3Ifp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:35:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38411 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935953AbeE3Ifm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:35:42 -0400
X-Google-Smtp-Source: ADUXVKK+8f6OxCQKKLSQOEXO3Mz5zWayW/+Xw8hdduZPiHWkKPXUQFKSYMSVE/QJj+yO2BBEIJkODg==
Subject: Re: [PATCH 3/3] platform/x86: silead_dmi: Add touchscreen info for
 the Onda V891w tablet
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180529115022.12875-1-hdegoede@redhat.com>
 <20180529115022.12875-3-hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <1c899bd2-cc26-5334-a2b0-a03cbff083ed@redhat.com>
Date: Wed, 30 May 2018 10:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529115022.12875-3-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29-05-18 13:50, Hans de Goede wrote:
> Add touchscreen info for the Onda V891w 8.9" windows tablet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Self-NACK I just learned there are 2 hardware revisions with different
digitizers which need different firmware, so this needs a more
narrow DMI match.

I will send a v2 soonish.

Regards,

Hans



> ---
>   drivers/platform/x86/silead_dmi.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
> index ca49deaa2336..d8d40e981152 100644
> --- a/drivers/platform/x86/silead_dmi.c
> +++ b/drivers/platform/x86/silead_dmi.c
> @@ -309,6 +309,23 @@ static const struct silead_ts_dmi_data teclast_x3_plus_data = {
>   	.properties	= teclast_x3_plus_props,
>   };
>   
> +static const struct property_entry onda_v891w_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-min-x", 46),
> +	PROPERTY_ENTRY_U32("touchscreen-min-y",  8),
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1676),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1130),
> +	PROPERTY_ENTRY_STRING("firmware-name",
> +			      "gsl3680-onda-v891w.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
> +	{ }
> +};
> +
> +static const struct silead_ts_dmi_data onda_v891w_data = {
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= onda_v891w_props,
> +};
> +
>   static const struct dmi_system_id silead_ts_dmi_table[] = {
>   	{
>   		/* CUBE iwork8 Air */
> @@ -517,6 +534,15 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Y8W81"),
>   		},
>   	},
> +	{
> +		/* ONDA V891w */
> +		.driver_data = (void *)&onda_v891w_data,
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ONDA"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONDA Tablet"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V001"),
> +		},
> +	},
>   	{ },
>   };
>   
> 
