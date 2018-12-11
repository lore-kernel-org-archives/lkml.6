Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC83C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743452081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743452081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeLKLre convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:47:34 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:45007 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbeLKLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:47:31 -0500
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id 2D/EC-11519-0D3AF0C5; Tue, 11 Dec 2018 11:47:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRWlGSWpSXmKPExsVy8IPnUd0Li/l
  jDPZ9Fbc4OyHQov31VkaLy7vmsFk8WXiGyYHFY+f3BnaP9Vuusnh83iQXwBzFmpmXlF+RwJpx
  d/1ttoLpyhVf/1xibGDcKtfFyMUhJLCMUaJz/3TGLkZODjYBQ4l5b96D2SICahLNp1rYQIqYB
  bYySqz/M5UNJCEskC7xbelqZoiiDInr16dA2UYSr+Z0sIDYLAKqEh3XT4LV8woESEy98pgdxB
  YSqJZY2/iPCcTmFHCR+LZ1HlicUUBW4ksjxExmAXGJW0/mg9VICAhILNlznhnCFpV4+fgfK4Q
  tL3F3zRKoGnuJ1/feAe3lALL1JfoaiyHChhKrph1ggbDNJa7uXsYCMV5HYsHuT2wQtrbEsoWv
  mSHOFJQ4OfMJywRG8VlIrpiFpGUWkpZZSFoWMLKsYrRMKspMzyjJTczM0TU0MNA1NDTWNdE1N
  DHSS6zSTdJLLdVNTs0rKUoEyuollhfrFVfmJuek6OWllmxiBMZrSiFL3w7Gj+3phxglOZiURH
  m3vuaKEeJLyk+pzEgszogvKs1JLT7EKMPBoSTBm7qIP0ZIsCg1PbUiLTMHmDhg0hIcPEoivBN
  B0rzFBYm5xZnpEKlTjIpS4rwJIAkBkERGaR5cGyxZXWKUlRLmZWRgYBDiKUgtys0sQZV/xSjO
  wagkzFsDMoUnM68EbvoroMVMQItztjCBLC5JREhJNTDKqx7tczog8r16UwrPxdfb7bYXdlt7s
  y77+U3Ty+n8BqvEy/orWXs2/9pqLP73plNteoiI+J71/pkJi9pL47e2SxkF5ln1hkl/Omj77k
  Li9Q7rkE1hM+9bspg2THPtODQjnGHnym5bW66Hq98z/XvPKfjpILeakfa0mmtznRfXxaT+3Zu
  5wlaJpTgj0VCLuag4EQCuCd0NUQMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-8.tower-246.messagelabs.com!1544528848!2604776!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25245 invoked from network); 11 Dec 2018 11:47:28 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-8.tower-246.messagelabs.com with AES128-SHA256 encrypted SMTP; 11 Dec 2018 11:47:28 -0000
Received: from SW-EX-MBX02.diasemi.com ([169.254.4.108]) by
 sw-ex-cashub01.diasemi.com ([10.20.16.141]) with mapi id 14.03.0382.000; Tue,
 11 Dec 2018 11:47:27 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 22/30] hwmon: (da9055-hwmon) Use permission specific
 SENSOR[_DEVICE]_ATTR variants
Thread-Topic: [PATCH 22/30] hwmon: (da9055-hwmon) Use permission specific
 SENSOR[_DEVICE]_ATTR variants
Thread-Index: AQHUkNVBAn1JHx544UmtQKXk9ThDIqV5amnA
Date:   Tue, 11 Dec 2018 11:47:26 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7021C50E53C@SW-EX-MBX02.diasemi.com>
References: <1544479728-30077-1-git-send-email-linux@roeck-us.net>
 <1544479728-30077-23-git-send-email-linux@roeck-us.net>
In-Reply-To: <1544479728-30077-23-git-send-email-linux@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.87]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
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

> Subject: [PATCH 22/30] hwmon: (da9055-hwmon) Use permission specific
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

Thanks, 
Same again.

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

... with the patch [01/10] hwmon: Introduce SENSOR_DEVICE_ATTR_{RO,RW,WO} and variants
https://patchwork.kernel.org/patch/9489915/ 

Regards,
Steve


>  drivers/hwmon/da9055-hwmon.c | 41 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
> index f6e159cabe23..4de6de683908 100644
> --- a/drivers/hwmon/da9055-hwmon.c
> +++ b/drivers/hwmon/da9055-hwmon.c
> @@ -140,8 +140,9 @@ static int da9055_disable_auto_mode(struct da9055
> *da9055, int channel)
>  	return da9055_reg_update(da9055, DA9055_REG_ADC_CONT, 1 <<
> channel, 0);
>  }
> 
> -static ssize_t da9055_read_auto_ch(struct device *dev,
> -				struct device_attribute *devattr, char *buf)
> +static ssize_t da9055_auto_ch_show(struct device *dev,
> +				   struct device_attribute *devattr,
> +				   char *buf)
>  {
>  	struct da9055_hwmon *hwmon = dev_get_drvdata(dev);
>  	int ret, adc;
> @@ -176,7 +177,7 @@ static ssize_t da9055_read_auto_ch(struct device *dev,
>  	return ret;
>  }
> 
> -static ssize_t da9055_read_tjunc(struct device *dev,
> +static ssize_t da9055_tjunc_show(struct device *dev,
>  				 struct device_attribute *devattr, char *buf)
>  {
>  	struct da9055_hwmon *hwmon = dev_get_drvdata(dev);
> @@ -199,34 +200,24 @@ static ssize_t da9055_read_tjunc(struct device *dev,
>  							+ 3076332, 10000));
>  }
> 
> -static ssize_t show_label(struct device *dev,
> +static ssize_t label_show(struct device *dev,
>  			  struct device_attribute *devattr, char *buf)
>  {
>  	return sprintf(buf, "%s\n",
>  		       input_names[to_sensor_dev_attr(devattr)->index]);
>  }
> 
> -static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, da9055_read_auto_ch, NULL,
> -			  DA9055_ADC_VSYS);
> -static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, show_label, NULL,
> -			  DA9055_ADC_VSYS);
> -static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, da9055_read_auto_ch, NULL,
> -			  DA9055_ADC_ADCIN1);
> -static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, show_label, NULL,
> -			  DA9055_ADC_ADCIN1);
> -static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, da9055_read_auto_ch, NULL,
> -			  DA9055_ADC_ADCIN2);
> -static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, show_label, NULL,
> -			  DA9055_ADC_ADCIN2);
> -static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, da9055_read_auto_ch, NULL,
> -			  DA9055_ADC_ADCIN3);
> -static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL,
> -			  DA9055_ADC_ADCIN3);
> -
> -static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, da9055_read_tjunc,
> NULL,
> -			  DA9055_ADC_TJUNC);
> -static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,
> -			  DA9055_ADC_TJUNC);
> +static SENSOR_DEVICE_ATTR_RO(in0_input, da9055_auto_ch,
> DA9055_ADC_VSYS);
> +static SENSOR_DEVICE_ATTR_RO(in0_label, label, DA9055_ADC_VSYS);
> +static SENSOR_DEVICE_ATTR_RO(in1_input, da9055_auto_ch,
> DA9055_ADC_ADCIN1);
> +static SENSOR_DEVICE_ATTR_RO(in1_label, label, DA9055_ADC_ADCIN1);
> +static SENSOR_DEVICE_ATTR_RO(in2_input, da9055_auto_ch,
> DA9055_ADC_ADCIN2);
> +static SENSOR_DEVICE_ATTR_RO(in2_label, label, DA9055_ADC_ADCIN2);
> +static SENSOR_DEVICE_ATTR_RO(in3_input, da9055_auto_ch,
> DA9055_ADC_ADCIN3);
> +static SENSOR_DEVICE_ATTR_RO(in3_label, label, DA9055_ADC_ADCIN3);
> +
> +static SENSOR_DEVICE_ATTR_RO(temp1_input, da9055_tjunc,
> DA9055_ADC_TJUNC);
> +static SENSOR_DEVICE_ATTR_RO(temp1_label, label, DA9055_ADC_TJUNC);
> 
>  static struct attribute *da9055_attrs[] = {
>  	&sensor_dev_attr_in0_input.dev_attr.attr,
> --
> 2.7.4

