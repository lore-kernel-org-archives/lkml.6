Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEBJ4W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:56:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40448 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeEBJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:56:19 -0400
X-Google-Smtp-Source: AB8JxZr4VKBBmqLw8Ief6WYAGK0l6iXw9UuBtpKSSjf06mDhMKMegrsNJ+a8iYLL7nsSIw5aj3c20w==
Date: Wed, 2 May 2018 10:56:15 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 1/3] mfd: cros_ec: Add USBPD charger commands and
 struct definitions.
Message-ID: <20180502095615.GR5147@dell>
References: <20180430131403.14296-1-enric.balletbo@collabora.com>
 <20180430131403.14296-2-enric.balletbo@collabora.com>
 <20180501082905.GJ5147@dell>
 <b8fd0545-4baa-ab82-462e-95179aa9b32d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8fd0545-4baa-ab82-462e-95179aa9b32d@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> From: Sameer Nanda <snanda@chromium.org>
> >>
> >> The USBPD charger driver gets information from the ChromeOS EC, this
> >> patch adds the USBPD charger definitions needed by this driver.
> >>
> >> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>
> >> Changes in v2: None
> >>
> >>  include/linux/mfd/cros_ec_commands.h | 132 ++++++++++++++++++++++++++-
> >>  1 file changed, 128 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> >> index f2edd9969b40..94dcf331796c 100644
> >> --- a/include/linux/mfd/cros_ec_commands.h
> >> +++ b/include/linux/mfd/cros_ec_commands.h
> > 
> > [...]
> > 
> >> +struct ec_response_pd_log {
> >> +	uint32_t timestamp; /* relative timestamp in milliseconds */
> >> +	uint8_t type;       /* event type : see PD_EVENT_xx below */
> >> +	uint8_t size_port;  /* [7:5] port number [4:0] payload size in bytes */
> >> +	uint16_t data;      /* type-defined data payload */
> >> +	uint8_t payload[0]; /* optional additional data payload: 0..16 bytes */
> >> +} __packed;
> > 
> > I think this whole file should be converted to Kerneldoc format.
> 
> Ok, is something I can do, let me do this in a separate patchset though.

Yes, that's fine.

> >> +/*
> >> + * PD_EVENT_MCU_CHARGE event definition :
> >> + * the payload is "struct usb_chg_measures"
> >> + * the data field contains the port state flags as defined below :
> >> + */
> >> +/* Port partner is a dual role device */
> >> +#define CHARGE_FLAGS_DUAL_ROLE         (1 << 15)
> > 
> > BIT()?
> > 
> 
> Changed in next version, there are also other places (not in this patch) where
> the BIT() macro is not used. I'll send separate patchset to change it and to
> convert to kerneldoc format.

Also fine.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
