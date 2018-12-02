Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87508C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 16:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAE420892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 16:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLSGk6b+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAE420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbeLBQlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 11:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbeLBQlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 11:41:12 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E8820851;
        Sun,  2 Dec 2018 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543768870;
        bh=qcnJ1ynZFQp8ZBJeUIHAu3ZZoT0Ph/WMfI/qwNzObao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FLSGk6b+7mG4n5/QBdibZQUmXzPoRzvf5HjShzHl8OBLDomTxYGAFRjXBi6rcGw8k
         WEr3vVR1iOqL9WsPRmiwMJ5Hg/xx4KDKnWFwVwq1FNyzQSquI3mUscfwihke3kUsMV
         bydojegu1G4m0yt0ahTByIv57gaOz77jwvU8Gy2A=
Date:   Sun, 2 Dec 2018 16:41:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 15/15] iio: inv_mpu6050: Use
 i2c_acpi_get_i2c_resource() helper
Message-ID: <20181202164105.17155c72@archlinux>
In-Reply-To: <20181128114535.80223-16-andriy.shevchenko@linux.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
        <20181128114535.80223-16-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+CC linux-iio mostly so I can track it and because others may care.

On Wed, 28 Nov 2018 13:45:35 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> ACPI provides a generic helper to get I2C Serial Bus resources.
> Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> index d78a10403bac..a961b5a06fe6 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> @@ -91,18 +91,14 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
>  
>  static int acpi_i2c_check_resource(struct acpi_resource *ares, void *data)
>  {
> +	struct acpi_resource_i2c_serialbus *sb;
>  	u32 *addr = data;
>  
> -	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> -		struct acpi_resource_i2c_serialbus *sb;
> -
> -		sb = &ares->data.i2c_serial_bus;
> -		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> -			if (*addr)
> -				*addr |= (sb->slave_address << 16);
> -			else
> -				*addr = sb->slave_address;
> -		}
> +	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
> +		if (*addr)
> +			*addr |= (sb->slave_address << 16);
> +		else
> +			*addr = sb->slave_address;
>  	}
>  
>  	/* Tell the ACPI core that we already copied this address */

