Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77876C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17EA2098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wat6tXjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17EA2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJMU1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeJMU1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:27:51 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CCA2087D;
        Sat, 13 Oct 2018 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539435048;
        bh=kGMlfqa/vylJzv0nlSsKd/79xX6Ttqz9G7pI+xCU+3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wat6tXjWf+yGm02yb9iT81b8V77gzY4YBhoZ2n/dMLlmfNe6F6kksBlOo2qt28sH6
         5qiSr5Zmil0UX/bNLhMFxbNl3Q1gMBu8QFfYXcWEvfkkzwl2Py3+7A7ymYyoft6ftt
         gXZC1blcMac6nP+o8ARmJTZpG0ZLCr107xgX6XA4=
Date:   Sat, 13 Oct 2018 13:50:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, michael.hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3] staging: iio: adt7316: fix parenthesis alignment
Message-ID: <20181013135043.09a5db36@archlinux>
In-Reply-To: <20181008221203.niagdupkgliejja7@renatolg>
References: <20181008221203.niagdupkgliejja7@renatolg>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 19:12:05 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> This patch fixes most "Alignment should match open parenthesis" check
> warnings found by checkpatch.pl in the addac/adt7316 driver.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> ---
Please in future put a description here (below the ---) of the changes
made from earlier versions of the same patch.

Us reviewers are lazy and forgetful so it's really useful to have
a brief note to remind us on what was previously raised and to confirm
you have answered those review comments with changes.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with.

Thanks,

Jonathan

>  drivers/staging/iio/addac/adt7316.c | 462 ++++++++++++++--------------
>  drivers/staging/iio/addac/adt7316.h |   2 +-
>  2 files changed, 233 insertions(+), 231 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 3f22d1088713..2f8a122f475d 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -217,8 +217,8 @@ struct adt7316_limit_regs {
>  };
>  
>  static ssize_t adt7316_show_enabled(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				    struct device_attribute *attr,
> +				    char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -227,7 +227,7 @@ static ssize_t adt7316_show_enabled(struct device *dev,
>  }
>  
>  static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
> -		int enable)
> +				      int enable)
>  {
>  	u8 config1;
>  	int ret;
> @@ -247,9 +247,9 @@ static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
>  }
>  
>  static ssize_t adt7316_store_enabled(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				     struct device_attribute *attr,
> +				     const char *buf,
> +				     size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -272,8 +272,8 @@ static IIO_DEVICE_ATTR(enabled, 0644,
>  		0);
>  
>  static ssize_t adt7316_show_select_ex_temp(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					   struct device_attribute *attr,
> +					   char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -285,9 +285,9 @@ static ssize_t adt7316_show_select_ex_temp(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_select_ex_temp(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -316,8 +316,8 @@ static IIO_DEVICE_ATTR(select_ex_temp, 0644,
>  		0);
>  
>  static ssize_t adt7316_show_mode(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				 struct device_attribute *attr,
> +				 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -329,9 +329,9 @@ static ssize_t adt7316_show_mode(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_mode(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				  struct device_attribute *attr,
> +				  const char *buf,
> +				  size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -357,8 +357,8 @@ static IIO_DEVICE_ATTR(mode, 0644,
>  		0);
>  
>  static ssize_t adt7316_show_all_modes(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				      struct device_attribute *attr,
> +				      char *buf)
>  {
>  	return sprintf(buf, "single_channel\nround_robin\n");
>  }
> @@ -366,8 +366,8 @@ static ssize_t adt7316_show_all_modes(struct device *dev,
>  static IIO_DEVICE_ATTR(all_modes, 0444, adt7316_show_all_modes, NULL, 0);
>  
>  static ssize_t adt7316_show_ad_channel(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				       struct device_attribute *attr,
> +				       char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -382,7 +382,7 @@ static ssize_t adt7316_show_ad_channel(struct device *dev,
>  		return sprintf(buf, "1 - Internal Temperature\n");
>  	case ADT7316_AD_SINGLE_CH_EX:
>  		if (((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) &&
> -			(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
> +		    (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
>  			return sprintf(buf, "2 - AIN1\n");
>  
>  		return sprintf(buf, "2 - External Temperature\n");
> @@ -404,9 +404,9 @@ static ssize_t adt7316_show_ad_channel(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_ad_channel(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -450,8 +450,8 @@ static IIO_DEVICE_ATTR(ad_channel, 0644,
>  		0);
>  
>  static ssize_t adt7316_show_all_ad_channels(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					    struct device_attribute *attr,
> +					    char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -471,8 +471,8 @@ static IIO_DEVICE_ATTR(all_ad_channels, 0444,
>  		adt7316_show_all_ad_channels, NULL, 0);
>  
>  static ssize_t adt7316_show_disable_averaging(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					      struct device_attribute *attr,
> +					      char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -482,9 +482,9 @@ static ssize_t adt7316_show_disable_averaging(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_disable_averaging(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					       struct device_attribute *attr,
> +					       const char *buf,
> +					       size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -510,8 +510,8 @@ static IIO_DEVICE_ATTR(disable_averaging, 0644,
>  		0);
>  
>  static ssize_t adt7316_show_enable_smbus_timeout(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +						 struct device_attribute *attr,
> +						 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -521,9 +521,9 @@ static ssize_t adt7316_show_enable_smbus_timeout(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +						  struct device_attribute *attr,
> +						  const char *buf,
> +						  size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -549,8 +549,8 @@ static IIO_DEVICE_ATTR(enable_smbus_timeout, 0644,
>  		0);
>  
>  static ssize_t adt7316_show_powerdown(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				      struct device_attribute *attr,
> +				      char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -559,9 +559,9 @@ static ssize_t adt7316_show_powerdown(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_powerdown(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				       struct device_attribute *attr,
> +				       const char *buf,
> +				       size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -587,8 +587,8 @@ static IIO_DEVICE_ATTR(powerdown, 0644,
>  		0);
>  
>  static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					  struct device_attribute *attr,
> +					  char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -597,9 +597,9 @@ static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					   struct device_attribute *attr,
> +					   const char *buf,
> +					   size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -625,8 +625,8 @@ static IIO_DEVICE_ATTR(fast_ad_clock, 0644,
>  		0);
>  
>  static ssize_t adt7316_show_da_high_resolution(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					       struct device_attribute *attr,
> +					       char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -642,9 +642,9 @@ static ssize_t adt7316_show_da_high_resolution(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_da_high_resolution(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +						struct device_attribute *attr,
> +						const char *buf,
> +						size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -678,8 +678,8 @@ static IIO_DEVICE_ATTR(da_high_resolution, 0644,
>  		0);
>  
>  static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					      struct device_attribute *attr,
> +					      char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -692,9 +692,9 @@ static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					       struct device_attribute *attr,
> +					       const char *buf,
> +					       size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -724,8 +724,8 @@ static IIO_DEVICE_ATTR(AIN_internal_Vref, 0644,
>  		0);
>  
>  static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					     struct device_attribute *attr,
> +					     char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -735,9 +735,9 @@ static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					      struct device_attribute *attr,
> +					      const char *buf,
> +					      size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -758,13 +758,13 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(enable_proportion_DACA, 0644,
> -		adt7316_show_enable_prop_DACA,
> -		adt7316_store_enable_prop_DACA,
> -		0);
> +		       adt7316_show_enable_prop_DACA,
> +		       adt7316_store_enable_prop_DACA,
> +		       0);
>  
>  static ssize_t adt7316_show_enable_prop_DACB(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					     struct device_attribute *attr,
> +					     char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -774,9 +774,9 @@ static ssize_t adt7316_show_enable_prop_DACB(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					      struct device_attribute *attr,
> +					      const char *buf,
> +					      size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -797,13 +797,13 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(enable_proportion_DACB, 0644,
> -		adt7316_show_enable_prop_DACB,
> -		adt7316_store_enable_prop_DACB,
> -		0);
> +		       adt7316_show_enable_prop_DACB,
> +		       adt7316_store_enable_prop_DACB,
> +		       0);
>  
>  static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					      struct device_attribute *attr,
> +					      char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -813,9 +813,9 @@ static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					       struct device_attribute *attr,
> +					       const char *buf,
> +					       size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -840,13 +840,13 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_2Vref_channels_mask, 0644,
> -		adt7316_show_DAC_2Vref_ch_mask,
> -		adt7316_store_DAC_2Vref_ch_mask,
> -		0);
> +		       adt7316_show_DAC_2Vref_ch_mask,
> +		       adt7316_store_DAC_2Vref_ch_mask,
> +		       0);
>  
>  static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					    struct device_attribute *attr,
> +					    char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -870,9 +870,9 @@ static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					     struct device_attribute *attr,
> +					     const char *buf,
> +					     size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -900,13 +900,13 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_update_mode, 0644,
> -		adt7316_show_DAC_update_mode,
> -		adt7316_store_DAC_update_mode,
> -		0);
> +		       adt7316_show_DAC_update_mode,
> +		       adt7316_store_DAC_update_mode,
> +		       0);
>  
>  static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +						 struct device_attribute *attr,
> +						 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -920,12 +920,12 @@ static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(all_DAC_update_modes, 0444,
> -		adt7316_show_all_DAC_update_modes, NULL, 0);
> +		       adt7316_show_all_DAC_update_modes, NULL, 0);
>  
>  static ssize_t adt7316_store_update_DAC(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -958,13 +958,13 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(update_DAC, 0644,
> -		NULL,
> -		adt7316_store_update_DAC,
> -		0);
> +		       NULL,
> +		       adt7316_store_update_DAC,
> +		       0);
>  
>  static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					      struct device_attribute *attr,
> +					      char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -977,9 +977,9 @@ static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					       struct device_attribute *attr,
> +					       const char *buf,
> +					       size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1003,13 +1003,13 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(DA_AB_Vref_bypass, 0644,
> -		adt7316_show_DA_AB_Vref_bypass,
> -		adt7316_store_DA_AB_Vref_bypass,
> -		0);
> +		       adt7316_show_DA_AB_Vref_bypass,
> +		       adt7316_store_DA_AB_Vref_bypass,
> +		       0);
>  
>  static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					      struct device_attribute *attr,
> +					      char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1022,9 +1022,9 @@ static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					       struct device_attribute *attr,
> +					       const char *buf,
> +					       size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1048,13 +1048,13 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(DA_CD_Vref_bypass, 0644,
> -		adt7316_show_DA_CD_Vref_bypass,
> -		adt7316_store_DA_CD_Vref_bypass,
> -		0);
> +		       adt7316_show_DA_CD_Vref_bypass,
> +		       adt7316_store_DA_CD_Vref_bypass,
> +		       0);
>  
>  static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					      struct device_attribute *attr,
> +					      char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1068,9 +1068,9 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					       struct device_attribute *attr,
> +					       const char *buf,
> +					       size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1109,12 +1109,12 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_internal_Vref, 0644,
> -		adt7316_show_DAC_internal_Vref,
> -		adt7316_store_DAC_internal_Vref,
> -		0);
> +		       adt7316_show_DAC_internal_Vref,
> +		       adt7316_store_DAC_internal_Vref,
> +		       0);
>  
>  static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
> -		int channel, char *buf)
> +			       int channel, char *buf)
>  {
>  	u16 data;
>  	u8 msb, lsb;
> @@ -1122,7 +1122,7 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
>  	int ret;
>  
>  	if ((chip->config2 & ADT7316_AD_SINGLE_CH_MODE) &&
> -		channel != (chip->config2 & ADT7516_AD_SINGLE_CH_MASK))
> +	    channel != (chip->config2 & ADT7516_AD_SINGLE_CH_MASK))
>  		return -EPERM;
>  
>  	switch (channel) {
> @@ -1189,8 +1189,8 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
>  }
>  
>  static ssize_t adt7316_show_VDD(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				struct device_attribute *attr,
> +				char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1200,8 +1200,8 @@ static ssize_t adt7316_show_VDD(struct device *dev,
>  static IIO_DEVICE_ATTR(VDD, 0444, adt7316_show_VDD, NULL, 0);
>  
>  static ssize_t adt7316_show_in_temp(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				    struct device_attribute *attr,
> +				    char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1212,8 +1212,8 @@ static ssize_t adt7316_show_in_temp(struct device *dev,
>  static IIO_DEVICE_ATTR(in_temp, 0444, adt7316_show_in_temp, NULL, 0);
>  
>  static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					 struct device_attribute *attr,
> +					 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1222,12 +1222,12 @@ static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(ex_temp_AIN1, 0444, adt7316_show_ex_temp_AIN1,
> -		NULL, 0);
> +		       NULL, 0);
>  static IIO_DEVICE_ATTR(ex_temp, 0444, adt7316_show_ex_temp_AIN1, NULL, 0);
>  
>  static ssize_t adt7316_show_AIN2(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				 struct device_attribute *attr,
> +				 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1237,8 +1237,8 @@ static ssize_t adt7316_show_AIN2(struct device *dev,
>  static IIO_DEVICE_ATTR(AIN2, 0444, adt7316_show_AIN2, NULL, 0);
>  
>  static ssize_t adt7316_show_AIN3(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				 struct device_attribute *attr,
> +				 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1248,8 +1248,8 @@ static ssize_t adt7316_show_AIN3(struct device *dev,
>  static IIO_DEVICE_ATTR(AIN3, 0444, adt7316_show_AIN3, NULL, 0);
>  
>  static ssize_t adt7316_show_AIN4(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				 struct device_attribute *attr,
> +				 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1259,7 +1259,7 @@ static ssize_t adt7316_show_AIN4(struct device *dev,
>  static IIO_DEVICE_ATTR(AIN4, 0444, adt7316_show_AIN4, NULL, 0);
>  
>  static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
> -		int offset_addr, char *buf)
> +					int offset_addr, char *buf)
>  {
>  	int data;
>  	u8 val;
> @@ -1277,7 +1277,9 @@ static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
>  }
>  
>  static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
> -		int offset_addr, const char *buf, size_t len)
> +					 int offset_addr,
> +					 const char *buf,
> +					 size_t len)
>  {
>  	int data;
>  	u8 val;
> @@ -1300,8 +1302,8 @@ static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
>  }
>  
>  static ssize_t adt7316_show_in_temp_offset(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					   struct device_attribute *attr,
> +					   char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1310,9 +1312,9 @@ static ssize_t adt7316_show_in_temp_offset(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_in_temp_offset(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1322,12 +1324,12 @@ static ssize_t adt7316_store_in_temp_offset(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(in_temp_offset, 0644,
> -		adt7316_show_in_temp_offset,
> -		adt7316_store_in_temp_offset, 0);
> +		       adt7316_show_in_temp_offset,
> +		       adt7316_store_in_temp_offset, 0);
>  
>  static ssize_t adt7316_show_ex_temp_offset(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					   struct device_attribute *attr,
> +					   char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1336,9 +1338,9 @@ static ssize_t adt7316_show_ex_temp_offset(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_ex_temp_offset(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1348,12 +1350,12 @@ static ssize_t adt7316_store_ex_temp_offset(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(ex_temp_offset, 0644,
> -		adt7316_show_ex_temp_offset,
> -		adt7316_store_ex_temp_offset, 0);
> +		       adt7316_show_ex_temp_offset,
> +		       adt7316_store_ex_temp_offset, 0);
>  
>  static ssize_t adt7316_show_in_analog_temp_offset(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +						  struct device_attribute *attr,
> +						  char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1363,9 +1365,9 @@ static ssize_t adt7316_show_in_analog_temp_offset(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_in_analog_temp_offset(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +						struct device_attribute *attr,
> +						const char *buf,
> +						size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1375,12 +1377,12 @@ static ssize_t adt7316_store_in_analog_temp_offset(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(in_analog_temp_offset, 0644,
> -		adt7316_show_in_analog_temp_offset,
> -		adt7316_store_in_analog_temp_offset, 0);
> +		       adt7316_show_in_analog_temp_offset,
> +		       adt7316_store_in_analog_temp_offset, 0);
>  
>  static ssize_t adt7316_show_ex_analog_temp_offset(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +						  struct device_attribute *attr,
> +						  char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1390,9 +1392,9 @@ static ssize_t adt7316_show_ex_analog_temp_offset(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_ex_analog_temp_offset(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +						struct device_attribute *attr,
> +						const char *buf,
> +						size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1402,21 +1404,21 @@ static ssize_t adt7316_store_ex_analog_temp_offset(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(ex_analog_temp_offset, 0644,
> -		adt7316_show_ex_analog_temp_offset,
> -		adt7316_store_ex_analog_temp_offset, 0);
> +		       adt7316_show_ex_analog_temp_offset,
> +		       adt7316_store_ex_analog_temp_offset, 0);
>  
>  static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
> -		int channel, char *buf)
> +				int channel, char *buf)
>  {
>  	u16 data;
>  	u8 msb, lsb, offset;
>  	int ret;
>  
>  	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
> -		(channel == 0 &&
> -		(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
> -		(channel == 1 &&
> -		(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
> +	    (channel == 0 &&
> +	    (chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
> +	    (channel == 1 &&
> +	    (chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
>  		return -EPERM;
>  
>  	offset = chip->dac_bits - 8;
> @@ -1439,17 +1441,17 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
>  }
>  
>  static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
> -		int channel, const char *buf, size_t len)
> +				 int channel, const char *buf, size_t len)
>  {
>  	u8 msb, lsb, offset;
>  	u16 data;
>  	int ret;
>  
>  	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
> -		(channel == 0 &&
> -		(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
> -		(channel == 1 &&
> -		(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
> +	    (channel == 0 &&
> +	    (chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
> +	    (channel == 1 &&
> +	    (chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
>  		return -EPERM;
>  
>  	offset = chip->dac_bits - 8;
> @@ -1476,8 +1478,8 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
>  }
>  
>  static ssize_t adt7316_show_DAC_A(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				  struct device_attribute *attr,
> +				  char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1486,9 +1488,9 @@ static ssize_t adt7316_show_DAC_A(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_DAC_A(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1497,11 +1499,11 @@ static ssize_t adt7316_store_DAC_A(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_A, 0644, adt7316_show_DAC_A,
> -		adt7316_store_DAC_A, 0);
> +		       adt7316_store_DAC_A, 0);
>  
>  static ssize_t adt7316_show_DAC_B(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				  struct device_attribute *attr,
> +				  char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1510,9 +1512,9 @@ static ssize_t adt7316_show_DAC_B(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_DAC_B(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1521,11 +1523,11 @@ static ssize_t adt7316_store_DAC_B(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_B, 0644, adt7316_show_DAC_B,
> -		adt7316_store_DAC_B, 0);
> +		       adt7316_store_DAC_B, 0);
>  
>  static ssize_t adt7316_show_DAC_C(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				  struct device_attribute *attr,
> +				  char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1534,9 +1536,9 @@ static ssize_t adt7316_show_DAC_C(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_DAC_C(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1545,11 +1547,11 @@ static ssize_t adt7316_store_DAC_C(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_C, 0644, adt7316_show_DAC_C,
> -		adt7316_store_DAC_C, 0);
> +		       adt7316_store_DAC_C, 0);
>  
>  static ssize_t adt7316_show_DAC_D(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				  struct device_attribute *attr,
> +				  char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1558,9 +1560,9 @@ static ssize_t adt7316_show_DAC_D(struct device *dev,
>  }
>  
>  static ssize_t adt7316_store_DAC_D(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1569,11 +1571,11 @@ static ssize_t adt7316_store_DAC_D(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_D, 0644, adt7316_show_DAC_D,
> -		adt7316_store_DAC_D, 0);
> +		       adt7316_store_DAC_D, 0);
>  
>  static ssize_t adt7316_show_device_id(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				      struct device_attribute *attr,
> +				      char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1590,8 +1592,8 @@ static ssize_t adt7316_show_device_id(struct device *dev,
>  static IIO_DEVICE_ATTR(device_id, 0444, adt7316_show_device_id, NULL, 0);
>  
>  static ssize_t adt7316_show_manufactorer_id(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					    struct device_attribute *attr,
> +					    char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1606,11 +1608,11 @@ static ssize_t adt7316_show_manufactorer_id(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(manufactorer_id, 0444,
> -		adt7316_show_manufactorer_id, NULL, 0);
> +		       adt7316_show_manufactorer_id, NULL, 0);
>  
>  static ssize_t adt7316_show_device_rev(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				       struct device_attribute *attr,
> +				       char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1627,8 +1629,8 @@ static ssize_t adt7316_show_device_rev(struct device *dev,
>  static IIO_DEVICE_ATTR(device_rev, 0444, adt7316_show_device_rev, NULL, 0);
>  
>  static ssize_t adt7316_show_bus_type(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				     struct device_attribute *attr,
> +				     char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1811,8 +1813,8 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>   * Show mask of enabled interrupts in Hex.
>   */
>  static ssize_t adt7316_show_int_mask(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				     struct device_attribute *attr,
> +				     char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1824,9 +1826,9 @@ static ssize_t adt7316_show_int_mask(struct device *dev,
>   * Set 1 to the mask in Hex to enabled interrupts.
>   */
>  static ssize_t adt7316_set_int_mask(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				    struct device_attribute *attr,
> +				    const char *buf,
> +				    size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1865,8 +1867,8 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
>  }
>  
>  static inline ssize_t adt7316_show_ad_bound(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					    struct device_attribute *attr,
> +					    char *buf)
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
> @@ -1876,7 +1878,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
>  	int ret;
>  
>  	if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX &&
> -		this_attr->address > ADT7316_EX_TEMP_LOW)
> +	    this_attr->address > ADT7316_EX_TEMP_LOW)
>  		return -EPERM;
>  
>  	ret = chip->bus.read(chip->bus.client, this_attr->address, &val);
> @@ -1886,7 +1888,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
>  	data = (int)val;
>  
>  	if (!((chip->id & ID_FAMILY_MASK) == ID_ADT75XX &&
> -		(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)) {
> +	      (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)) {
>  		if (data & 0x80)
>  			data -= 256;
>  	}
> @@ -1895,9 +1897,9 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
>  }
>  
>  static inline ssize_t adt7316_set_ad_bound(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					   struct device_attribute *attr,
> +					   const char *buf,
> +					   size_t len)
>  {
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
> @@ -1907,7 +1909,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
>  	int ret;
>  
>  	if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX &&
> -		this_attr->address > ADT7316_EX_TEMP_LOW)
> +	    this_attr->address > ADT7316_EX_TEMP_LOW)
>  		return -EPERM;
>  
>  	ret = kstrtoint(buf, 10, &data);
> @@ -1915,7 +1917,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
>  		return -EINVAL;
>  
>  	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX &&
> -		(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0) {
> +	    (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0) {
>  		if (data > 255 || data < 0)
>  			return -EINVAL;
>  	} else {
> @@ -1936,8 +1938,8 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
>  }
>  
>  static ssize_t adt7316_show_int_enabled(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					struct device_attribute *attr,
> +					char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -1946,9 +1948,9 @@ static ssize_t adt7316_show_int_enabled(struct device *dev,
>  }
>  
>  static ssize_t adt7316_set_int_enabled(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +				       struct device_attribute *attr,
> +				       const char *buf,
> +				       size_t len)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> @@ -2097,7 +2099,7 @@ static const struct iio_info adt7516_info = {
>   * device probe and remove
>   */
>  int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
> -		const char *name)
> +		  const char *name)
>  {
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
> @@ -2169,7 +2171,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  		return ret;
>  
>  	dev_info(dev, "%s temperature sensor, ADC and DAC registered.\n",
> -			indio_dev->name);
> +		 indio_dev->name);
>  
>  	return 0;
>  }
> diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
> index ec40fbb698a6..b954dcbc92db 100644
> --- a/drivers/staging/iio/addac/adt7316.h
> +++ b/drivers/staging/iio/addac/adt7316.h
> @@ -31,6 +31,6 @@ extern const struct dev_pm_ops adt7316_pm_ops;
>  #define ADT7316_PM_OPS NULL
>  #endif
>  int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
> -		   const char *name);
> +		  const char *name);
>  
>  #endif

