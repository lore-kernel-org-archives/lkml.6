Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B62C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B85E222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407217AbfBNOXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:23:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38489 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfBNOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:23:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so5147512edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eOP3RTKngQ6sN35Aaohqh9eFSsUryNuX3D1ooG0x6jw=;
        b=iIK17iBloz08L0nKL3u4S2cAEnwwTIicFJ+26SIogqugX0H8g+DAGZlZKYAJNbyJ74
         hT7kA1zJeSbSh3iRP+awwbD/YNOZbRM8rool38ecexMmLPeQ5+yFQurC1xPhrJNKWtJD
         SB/WhDyZI9ceFnXVHuWYWzholdnz2kCksRPXILMacyRN1cM2cPJcFyr5lUax4HXn1lsO
         gL18Vw/G8LqRFaDGFtIm9feQztM3ldec41uMQIpJrCEdQzabQgJg3gqV43UK4nGk0vUb
         nd6S8DinrHYaA12eB09W+GbDfjO9RPB+TYLrfaibsWJjql/SMvmGlH+k4/TxcWwvlHF8
         LUDw==
X-Gm-Message-State: AHQUAuYaAgfKBBHBBqKfpFNyJRBLbgYjbh8+U/j9I+C3ODsQMT8G7jbF
        q+lfGvJr4tMDGaUXb2yfrshAvw==
X-Google-Smtp-Source: AHgI3IY9jKHqq3a+rePedKDv/WivK1FlIhNw5uxNx3rkJCywdVqFxIVUvzQN8UldDqKrhHLXEWIJaw==
X-Received: by 2002:a17:906:741:: with SMTP id z1mr1835032ejb.206.1550154181021;
        Thu, 14 Feb 2019 06:23:01 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k20sm705536eda.71.2019.02.14.06.22.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:22:59 -0800 (PST)
Subject: Re: [PATCH 1/2] extcon-intel-cht-wc: Make charger detection
 co-existed with OTG host mode
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <20190210203649.21691-2-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <963f3096-0c4f-60fc-c34c-9ae41c82d6bb@redhat.com>
Date:   Thu, 14 Feb 2019 15:22:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190210203649.21691-2-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-02-19 21:36, Yauhen Kharuzhy wrote:
> Whiskey Cove Cherry Trail PMIC requires disabling OTG host mode before
> of charger detection procedure. Do this by manipulationg of CHGRCTRL1
> register.
> 
> Source: APCI DSDT code of Lenovo Yoga Book YB1-X91L and open-sourced
> Intel's drivers.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

Ok, so this patch should work fine on the existing cht-wc using devices
I am aware of; and otherwise looks good to:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/extcon/extcon-intel-cht-wc.c | 38 +++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 5ef215297101..4f6ba249bc30 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -29,7 +29,16 @@
>   #define CHT_WC_CHGRCTRL0_DBPOFF		BIT(6)
>   #define CHT_WC_CHGRCTRL0_CHR_WDT_NOKICK	BIT(7)
>   
> -#define CHT_WC_CHGRCTRL1		0x5e17
> +#define CHT_WC_CHGRCTRL1			0x5e17
> +#define CHT_WC_CHGRCTRL1_DBPEN_MASK		BIT(7)
> +#define CHT_WC_CHGRCTRL1_OTGMODE		BIT(6)
> +#define CHT_WC_CHGRCTRL1_FTEMP_EVENT		BIT(5)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_1500	BIT(4)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_900		BIT(3)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_500		BIT(2)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_150		BIT(1)
> +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_100		BIT(0)
> +
>   
>   #define CHT_WC_USBSRC			0x5e29
>   #define CHT_WC_USBSRC_STS_MASK		GENMASK(1, 0)
> @@ -198,6 +207,29 @@ static void cht_wc_extcon_set_5v_boost(struct cht_wc_extcon_data *ext,
>   		dev_err(ext->dev, "Error writing Vbus GPIO CTLO: %d\n", ret);
>   }
>   
> +static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
> +				      bool enable)
> +{
> +	unsigned int chgrctrl1;
> +	int ret;
> +
> +	ret = regmap_read(ext->regmap, CHT_WC_CHGRCTRL1, &chgrctrl1);
> +	if (ret) {
> +		dev_err(ext->dev, "Error reading CHGRCTRL1 reg: %d\n", ret);
> +		return;
> +	}
> +
> +	if (enable)
> +		chgrctrl1 |= CHT_WC_CHGRCTRL1_OTGMODE;
> +	else
> +		chgrctrl1 &= ~(CHT_WC_CHGRCTRL1_OTGMODE);
> +
> +	ret = regmap_write(ext->regmap, CHT_WC_CHGRCTRL1, chgrctrl1);
> +	if (ret)
> +		dev_err(ext->dev,
> +			"Error writing CHGRCTRL1 OTG mode bit: %d\n", ret);
> +}
> +
>   /* Small helper to sync EXTCON_CHG_USB_SDP and EXTCON_USB state */
>   static void cht_wc_extcon_set_state(struct cht_wc_extcon_data *ext,
>   				    unsigned int cable, bool state)
> @@ -222,10 +254,14 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
>   
>   	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
>   	if (id == USB_ID_GND) {
> +		cht_wc_extcon_set_otgmode(ext, true);
> +
>   		/* The 5v boost causes a false VBUS / SDP detect, skip */
>   		goto charger_det_done;
>   	}
>   
> +	cht_wc_extcon_set_otgmode(ext, false);
> +
>   	/* Plugged into a host/charger or not connected? */
>   	if (!(pwrsrc_sts & CHT_WC_PWRSRC_VBUS)) {
>   		/* Route D+ and D- to PMIC for future charger detection */
> 
