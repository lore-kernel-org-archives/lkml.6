Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1269C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BE82081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BE82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeLKLra convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:47:30 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:31372 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbeLKLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:47:29 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 09/52-12141-BC3AF0C5; Tue, 11 Dec 2018 11:47:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRWlGSWpSXmKPExsVy8IPnUd3Ti/l
  jDBbc0rQ4OyHQov31VkaLy7vmsFk8WXiGyYHFY+f3BnaP9Vuusnh83iQXwBzFmpmXlF+RwJqx
  +qFZwXzvivabv1kaGJsduxi5OIQEljFKbGl4zt7FyMnBJmAoMe/Ne0YQW0RATaL5VAsbSBGzw
  FZGifV/prKBJIQF0iW2PP4AVZQhcWvffnYI20ji17ROVhCbRUBVYvXCVWA2r0CAxK3jU8FqhA
  SqJTqPPQLr5RRwkXj5+gELiM0oICvxpXE1M4jNLCAucevJfCYQW0JAQGLJnvPMELaoxMvH/1g
  hbHmJu2uWQNXYS7y+944FwtaXePQYYr4E0DOrph2AiptLXN29jAVivo7Egt2f2CBsbYllC18z
  Q9wpKHFy5hOWCYzis5CcMQtJyywkLbOQtCxgZFnFaJFUlJmeUZKbmJmja2hgoGtoaKRraGmpa
  2RkoZdYpZukl1qqW55aXKJrqJdYXqxXXJmbnJOil5dasokRGK0pBcef7GD835V+iFGSg0lJlH
  fra64YIb6k/JTKjMTijPii0pzU4kOMMhwcShK8FsDoFxIsSk1PrUjLzAGmDZi0BAePkgjvnUV
  Aad7igsTc4sx0iNQpRkUpcd43IAkBkERGaR5cGyxVXWKUlRLmZWRgYBDiKUgtys0sQZV/xSjO
  wagkzLsFZApPZl4J3PRXQIuZgBbnbGECWVySiJCSamAU/75V5Y/d3xVf7a/tW+DxnOHKZ+krd
  dOMDi+8FaVyaJauRNIjh4TSxTGvfqz7tCXV/uVB469V7ZnL1drvVs43ux3rYXT1e7JAy8uEM3
  8fvTjZbrb02W9+xb91d+eIrNm3zL42x2J9wlbhNqnZ5eeVJm2yEhFef39lnJWgucWV7r8H35R
  OO2bbr8RSnJFoqMVcVJwIAHJcKflQAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-8.tower-288.messagelabs.com!1544528843!3971917!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3945 invoked from network); 11 Dec 2018 11:47:23 -0000
Received: from unknown (HELO sw-ex-cashub02.diasemi.com) (193.240.73.197)
  by server-8.tower-288.messagelabs.com with AES128-SHA256 encrypted SMTP; 11 Dec 2018 11:47:23 -0000
Received: from SW-EX-MBX02.diasemi.com ([169.254.4.108]) by
 sw-ex-cashub02.diasemi.com ([10.20.16.142]) with mapi id 14.03.0382.000; Tue,
 11 Dec 2018 11:46:36 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 21/30] hwmon: (da9052-hwmon) Use permission specific
 SENSOR[_DEVICE]_ATTR variants
Thread-Topic: [PATCH 21/30] hwmon: (da9052-hwmon) Use permission specific
 SENSOR[_DEVICE]_ATTR variants
Thread-Index: AQHUkNVBr/A+CnAINUaR5/cGghffNqV5aJGQ
Date:   Tue, 11 Dec 2018 11:47:18 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7021C50E52E@SW-EX-MBX02.diasemi.com>
References: <1544479728-30077-1-git-send-email-linux@roeck-us.net>
 <1544479728-30077-22-git-send-email-linux@roeck-us.net>
In-Reply-To: <1544479728-30077-22-git-send-email-linux@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.87]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 11/12/2018 07:58:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter, 

On 10 December 2018 22:09, Guenter Roeck wrote:

> Subject: [PATCH 21/30] hwmon: (da9052-hwmon) Use permission specific
> SENSOR[_DEVICE]_ATTR variants
> 
> Use SENSOR[_DEVICE]_ATTR[_2]_{RO,RW,WO} to simplify the source code,
> to improve readbility, and to reduce the chance of inconsistencies.
> 
> Also replace any remaining S_<PERMS> in the driver with octal values.
> 
> The conversion was done automatically with coccinelle. The semantic patches
> and the scripts used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches/hwmon/.
> 
> This patch does not introduce functional changes. It was verified by
> compiling the old and new files and comparing text and data sizes.
> 
> Cc: Support Opensource <support.opensource@diasemi.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/da9052-hwmon.c | 105 ++++++++++++++++------------------------

Thanks,

I am assuming this previous patch [01/10] hwmon: Introduce SENSOR_DEVICE_ATTR_{RO,RW,WO} and variants
from this set, https://patchwork.kernel.org/patch/9489915/ and, 
+ #define SENSOR_DEVICE_ATTR_RO(_name, _func, _index)            \
+        SENSOR_DEVICE_ATTR(_name, 0444, _func##_show, NULL, _index)

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

> ---
>  1 file changed, 39 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
> index a973eb6a2890..8ec5bf4ce392 100644
> --- a/drivers/hwmon/da9052-hwmon.c
> +++ b/drivers/hwmon/da9052-hwmon.c
> @@ -87,7 +87,7 @@ static inline int da9052_disable_vddout_channel(struct
> da9052 *da9052)
>  				 DA9052_ADCCONT_AUTOVDDEN, 0);
>  }
> 
> -static ssize_t da9052_read_vddout(struct device *dev,
> +static ssize_t da9052_vddout_show(struct device *dev,
>  				  struct device_attribute *devattr, char *buf)
>  {
>  	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> @@ -119,7 +119,7 @@ static ssize_t da9052_read_vddout(struct device *dev,
>  	return ret;
>  }
> 
> -static ssize_t da9052_read_ich(struct device *dev,
> +static ssize_t da9052_ich_show(struct device *dev,
>  			       struct device_attribute *devattr, char *buf)
>  {
>  	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> @@ -133,7 +133,7 @@ static ssize_t da9052_read_ich(struct device *dev,
>  	return sprintf(buf, "%d\n", DIV_ROUND_CLOSEST(ret * 39, 10));
>  }
> 
> -static ssize_t da9052_read_tbat(struct device *dev,
> +static ssize_t da9052_tbat_show(struct device *dev,
>  				struct device_attribute *devattr, char *buf)
>  {
>  	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> @@ -141,7 +141,7 @@ static ssize_t da9052_read_tbat(struct device *dev,
>  	return sprintf(buf, "%d\n", da9052_adc_read_temp(hwmon->da9052));
>  }
> 
> -static ssize_t da9052_read_vbat(struct device *dev,
> +static ssize_t da9052_vbat_show(struct device *dev,
>  				struct device_attribute *devattr, char *buf)
>  {
>  	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> @@ -154,7 +154,7 @@ static ssize_t da9052_read_vbat(struct device *dev,
>  	return sprintf(buf, "%d\n", volt_reg_to_mv(ret));
>  }
> 
> -static ssize_t da9052_read_misc_channel(struct device *dev,
> +static ssize_t da9052_misc_channel_show(struct device *dev,
>  					struct device_attribute *devattr,
>  					char *buf)
>  {
> @@ -242,9 +242,8 @@ static ssize_t __da9052_read_tsi(struct device *dev, int
> channel)
>  	return da9052_get_tsi_result(hwmon, channel);
>  }
> 
> -static ssize_t da9052_read_tsi(struct device *dev,
> -			       struct device_attribute *devattr,
> -			       char *buf)
> +static ssize_t da9052_tsi_show(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
>  {
>  	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
>  	int channel = to_sensor_dev_attr(devattr)->index;
> @@ -260,7 +259,7 @@ static ssize_t da9052_read_tsi(struct device *dev,
>  		return sprintf(buf, "%d\n", input_tsireg_to_mv(hwmon, ret));
>  }
> 
> -static ssize_t da9052_read_tjunc(struct device *dev,
> +static ssize_t da9052_tjunc_show(struct device *dev,
>  				 struct device_attribute *devattr, char *buf)
>  {
>  	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> @@ -282,7 +281,7 @@ static ssize_t da9052_read_tjunc(struct device *dev,
>  	return sprintf(buf, "%d\n", 1708 * (tjunc - toffset) - 108800);
>  }
> 
> -static ssize_t da9052_read_vbbat(struct device *dev,
> +static ssize_t da9052_vbbat_show(struct device *dev,
>  				 struct device_attribute *devattr, char *buf)
>  {
>  	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
> @@ -295,7 +294,7 @@ static ssize_t da9052_read_vbbat(struct device *dev,
>  	return sprintf(buf, "%d\n", vbbat_reg_to_mv(ret));
>  }
> 
> -static ssize_t show_label(struct device *dev,
> +static ssize_t label_show(struct device *dev,
>  			  struct device_attribute *devattr, char *buf)
>  {
>  	return sprintf(buf, "%s\n",
> @@ -324,61 +323,35 @@ static umode_t da9052_channel_is_visible(struct
> kobject *kobj,
>  	return attr->mode;
>  }
> 
> -static SENSOR_DEVICE_ATTR(in0_input, 0444, da9052_read_vddout, NULL,
> -			  DA9052_ADC_VDDOUT);
> -static SENSOR_DEVICE_ATTR(in0_label, 0444, show_label, NULL,
> -			  DA9052_ADC_VDDOUT);
> -static SENSOR_DEVICE_ATTR(in3_input, 0444, da9052_read_vbat, NULL,
> -			  DA9052_ADC_VBAT);
> -static SENSOR_DEVICE_ATTR(in3_label, 0444, show_label, NULL,
> -			  DA9052_ADC_VBAT);
> -static SENSOR_DEVICE_ATTR(in4_input, 0444, da9052_read_misc_channel,
> NULL,
> -			  DA9052_ADC_IN4);
> -static SENSOR_DEVICE_ATTR(in4_label, 0444, show_label, NULL,
> -			  DA9052_ADC_IN4);
> -static SENSOR_DEVICE_ATTR(in5_input, 0444, da9052_read_misc_channel,
> NULL,
> -			  DA9052_ADC_IN5);
> -static SENSOR_DEVICE_ATTR(in5_label, 0444, show_label, NULL,
> -			  DA9052_ADC_IN5);
> -static SENSOR_DEVICE_ATTR(in6_input, 0444, da9052_read_misc_channel,
> NULL,
> -			  DA9052_ADC_IN6);
> -static SENSOR_DEVICE_ATTR(in6_label, 0444, show_label, NULL,
> -			  DA9052_ADC_IN6);
> -static SENSOR_DEVICE_ATTR(in9_input, 0444, da9052_read_vbbat, NULL,
> -			  DA9052_ADC_VBBAT);
> -static SENSOR_DEVICE_ATTR(in9_label, 0444, show_label, NULL,
> -			  DA9052_ADC_VBBAT);
> -
> -static SENSOR_DEVICE_ATTR(in70_input, 0444, da9052_read_tsi, NULL,
> -			  DA9052_ADC_TSI_XP);
> -static SENSOR_DEVICE_ATTR(in70_label, 0444, show_label, NULL,
> -			  DA9052_ADC_TSI_XP);
> -static SENSOR_DEVICE_ATTR(in71_input, 0444, da9052_read_tsi, NULL,
> -			  DA9052_ADC_TSI_XN);
> -static SENSOR_DEVICE_ATTR(in71_label, 0444, show_label, NULL,
> -			  DA9052_ADC_TSI_XN);
> -static SENSOR_DEVICE_ATTR(in72_input, 0444, da9052_read_tsi, NULL,
> -			  DA9052_ADC_TSI_YP);
> -static SENSOR_DEVICE_ATTR(in72_label, 0444, show_label, NULL,
> -			  DA9052_ADC_TSI_YP);
> -static SENSOR_DEVICE_ATTR(in73_input, 0444, da9052_read_tsi, NULL,
> -			  DA9052_ADC_TSI_YN);
> -static SENSOR_DEVICE_ATTR(in73_label, 0444, show_label, NULL,
> -			  DA9052_ADC_TSI_YN);
> -
> -static SENSOR_DEVICE_ATTR(curr1_input, 0444, da9052_read_ich, NULL,
> -			  DA9052_ADC_ICH);
> -static SENSOR_DEVICE_ATTR(curr1_label, 0444, show_label, NULL,
> -			  DA9052_ADC_ICH);
> -
> -static SENSOR_DEVICE_ATTR(temp2_input, 0444, da9052_read_tbat, NULL,
> -			  DA9052_ADC_TBAT);
> -static SENSOR_DEVICE_ATTR(temp2_label, 0444, show_label, NULL,
> -			  DA9052_ADC_TBAT);
> -static SENSOR_DEVICE_ATTR(temp8_input, 0444, da9052_read_tjunc, NULL,
> -			  DA9052_ADC_TJUNC);
> -static SENSOR_DEVICE_ATTR(temp8_label, 0444, show_label, NULL,
> -			  DA9052_ADC_TJUNC);
> +static SENSOR_DEVICE_ATTR_RO(in0_input, da9052_vddout,
> DA9052_ADC_VDDOUT);
> +static SENSOR_DEVICE_ATTR_RO(in0_label, label, DA9052_ADC_VDDOUT);
> +static SENSOR_DEVICE_ATTR_RO(in3_input, da9052_vbat, DA9052_ADC_VBAT);
> +static SENSOR_DEVICE_ATTR_RO(in3_label, label, DA9052_ADC_VBAT);
> +static SENSOR_DEVICE_ATTR_RO(in4_input, da9052_misc_channel,
> DA9052_ADC_IN4);
> +static SENSOR_DEVICE_ATTR_RO(in4_label, label, DA9052_ADC_IN4);
> +static SENSOR_DEVICE_ATTR_RO(in5_input, da9052_misc_channel,
> DA9052_ADC_IN5);
> +static SENSOR_DEVICE_ATTR_RO(in5_label, label, DA9052_ADC_IN5);
> +static SENSOR_DEVICE_ATTR_RO(in6_input, da9052_misc_channel,
> DA9052_ADC_IN6);
> +static SENSOR_DEVICE_ATTR_RO(in6_label, label, DA9052_ADC_IN6);
> +static SENSOR_DEVICE_ATTR_RO(in9_input, da9052_vbbat,
> DA9052_ADC_VBBAT);
> +static SENSOR_DEVICE_ATTR_RO(in9_label, label, DA9052_ADC_VBBAT);
> +
> +static SENSOR_DEVICE_ATTR_RO(in70_input, da9052_tsi,
> DA9052_ADC_TSI_XP);
> +static SENSOR_DEVICE_ATTR_RO(in70_label, label, DA9052_ADC_TSI_XP);
> +static SENSOR_DEVICE_ATTR_RO(in71_input, da9052_tsi,
> DA9052_ADC_TSI_XN);
> +static SENSOR_DEVICE_ATTR_RO(in71_label, label, DA9052_ADC_TSI_XN);
> +static SENSOR_DEVICE_ATTR_RO(in72_input, da9052_tsi, DA9052_ADC_TSI_YP);
> +static SENSOR_DEVICE_ATTR_RO(in72_label, label, DA9052_ADC_TSI_YP);
> +static SENSOR_DEVICE_ATTR_RO(in73_input, da9052_tsi,
> DA9052_ADC_TSI_YN);
> +static SENSOR_DEVICE_ATTR_RO(in73_label, label, DA9052_ADC_TSI_YN);
> +
> +static SENSOR_DEVICE_ATTR_RO(curr1_input, da9052_ich, DA9052_ADC_ICH);
> +static SENSOR_DEVICE_ATTR_RO(curr1_label, label, DA9052_ADC_ICH);
> +
> +static SENSOR_DEVICE_ATTR_RO(temp2_input, da9052_tbat,
> DA9052_ADC_TBAT);
> +static SENSOR_DEVICE_ATTR_RO(temp2_label, label, DA9052_ADC_TBAT);
> +static SENSOR_DEVICE_ATTR_RO(temp8_input, da9052_tjunc,
> DA9052_ADC_TJUNC);
> +static SENSOR_DEVICE_ATTR_RO(temp8_label, label, DA9052_ADC_TJUNC);
> 
>  static struct attribute *da9052_attrs[] = {
>  	&sensor_dev_attr_in0_input.dev_attr.attr,
> --
> 2.7.4

