Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF4BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C964222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407961AbfBNQbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:31:53 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45385 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfBNQbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:31:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id d9so5491564edh.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9grveRsqO712zIw4qbL8fSko2kKqLzz71APxw/15F6g=;
        b=Ceq145V9MKues3IaLQ92i14ibkc8zc4TeybHDbekhSsxWfqsBf0kC14TcdNaTqPrH5
         DE0P9JVHfbn9H2BwfkBLsLt9dNF7emNC0ULjiWZvtv7J3SfHTUhjow2DMyMqepBULklO
         KVDL/Gg56r1n0j8jDpZQHPjQtLj9dNINNBll74b29DbrDy/z3OoXgldwRojH+mrl1lR1
         XuaV/fDTmQN/UYT3Y54rkEUO+jSoNv3s916FJv6cjv9hmMw+9a3Ok3iofI1lxPzqaflU
         qqvuGX2ZOULvODg8KYxZN5J8EMxl9BBrOU4LcoX2C9yophK3xdiSHPxLm52ms95XPs/n
         Skqg==
X-Gm-Message-State: AHQUAuYVLKx6NxQQtzPlrF+pUHysIm/QYDql93cbINAW+7uC5uZxnGj2
        jiyySzWTXPbevZp2z7DkpGxSuw==
X-Google-Smtp-Source: AHgI3IY+8Rmq971LF+7S+1lbmksXoBHap8ScslUKAVQLEg960IVmwtb0bOa/acLYgNNRWH/ptGxfrQ==
X-Received: by 2002:a50:9f6b:: with SMTP id b98mr3906398edf.290.1550161909752;
        Thu, 14 Feb 2019 08:31:49 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id v10sm618561ejj.55.2019.02.14.08.31.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:31:49 -0800 (PST)
Subject: Re: [PATCH 2/2] extcon intel-cht-wc: Enable external charger
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <20190210203649.21691-3-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1b2f04fc-05a0-4f09-c84e-dc7adc63ec63@redhat.com>
Date:   Thu, 14 Feb 2019 17:31:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190210203649.21691-3-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-02-19 21:36, Yauhen Kharuzhy wrote:
> In some configuration external charge "#charge enable" signal is
> connected to PMIC. Enable it at device probing to allow charging.
> 
> Tested at Lenovo Yoga Book (YB1-X91L).
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>   drivers/extcon/extcon-intel-cht-wc.c | 33 ++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 4f6ba249bc30..00cb3084955e 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -57,6 +57,11 @@
>   #define CHT_WC_USBSRC_TYPE_OTHER	8
>   #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY	9
>   
> +#define CHT_WC_CHGDISCTRL		0x5e2f
> +#define CHT_WC_CHGDISCTRL_CCSM_DIS	0x11
> +#define CHT_WC_CHGDISCTRL_CCSM_EN	0x00

Hmm, the enable mask here does not match the enable mask from:

https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/EM-Charger-Disable-battery-charging-in-S3-and-enable.patch

Which has:

#define CHGDISFN_EN_CCSM_VAL           0x50
#define CHGDISFN_DIS_CCSM_VAL          0x11
#define CHGDISFN_CCSM_MASK             0x51

Where as on my hardware, the PMIC comes up with 0x50
in the 0x5e2f register, exactly matching the values
from that patch.

Why did you change this value ?

It would be interesting to get a dump of the
charger's i2c registers using i2cdump before
and after writing this new value to register
0x5e2f. Note you can simply leave the patch adding
the write out of the kernel, and then do:

i2cdump <charger>
i2cget -y -f 6 0x5e 0x2f
# check 0x00 is the correct val
i2cset -y -f 6 0x5e 0x2f 0x00
i2cdump <charger>

To see if any reg values of the charger-ic have changed.

Note bus 6 is the right bus for the PMIC on my systems,
but it might be different, to find the right bus do:

ls -l /sys/bus/devices/i2c-INT34D3:00

And look at what the i2c bus-number is in that symlink.


Also can you please provide i2cdump output for the
0x5e and 0x6e devices of the PMIC, preferably from a
clean boot, without your patches, so that we can
see what the value of the 0x5e2f register is before
your code modifies it.

i2cdump -y -f 6 0x5e
i2cdump -y -f 6 0x6e

Regards,

Hans





> +#define CHT_WC_CHGDISCTRL_CCSM_MASK	0x51
> +
>   #define CHT_WC_PWRSRC_IRQ		0x6e03
>   #define CHT_WC_PWRSRC_IRQ_MASK		0x6e0f
>   #define CHT_WC_PWRSRC_STS		0x6e1e
> @@ -230,6 +235,31 @@ static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
>   			"Error writing CHGRCTRL1 OTG mode bit: %d\n", ret);
>   }
>   
> +static void cht_wc_extcon_enable_charging(struct cht_wc_extcon_data *ext,
> +					  bool enable)
> +{
> +	unsigned int chgdisctrl;
> +	int ret;
> +
> +	ret = regmap_read(ext->regmap, CHT_WC_CHGDISCTRL, &chgdisctrl);
> +	if (ret) {
> +		dev_err(ext->dev, "Error reading CHGDISCTRL reg: %d\n", ret);
> +		return;
> +	}
> +
> +	chgdisctrl &= CHT_WC_CHGDISCTRL_CCSM_MASK;
> +
> +	if (enable)
> +		chgdisctrl |= CHT_WC_CHGDISCTRL_CCSM_EN;
> +	else
> +		chgdisctrl |= CHT_WC_CHGDISCTRL_CCSM_DIS;
> +
> +	dev_dbg(ext->dev, "Writing CHGDISCTRL: 0x%02x\n", chgdisctrl);
> +	ret = regmap_write(ext->regmap, CHT_WC_CHGDISCTRL, chgdisctrl);
> +	if (ret)
> +		dev_err(ext->dev, "Error writing CHGDISCTRL: %d\n", ret);
> +}
> +
>   /* Small helper to sync EXTCON_CHG_USB_SDP and EXTCON_USB state */
>   static void cht_wc_extcon_set_state(struct cht_wc_extcon_data *ext,
>   				    unsigned int cable, bool state)
> @@ -362,6 +392,9 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>   	 */
>   	cht_wc_extcon_set_5v_boost(ext, false);
>   
> +	/* Allow charging by external battery charger*/
> +	cht_wc_extcon_enable_charging(ext, true);
> +
>   	/* Enable sw control */
>   	ret = cht_wc_extcon_sw_control(ext, true);
>   	if (ret)
> 
