Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeDUQJX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 12:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752819AbeDUQJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 12:09:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1C320C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:09:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 19/61] iio: common: hid-sensors: simplify getting
 .drvdata
Message-ID: <20180421170916.6af36c05@archlinux>
In-Reply-To: <20180419140641.27926-20-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <20180419140641.27926-20-wsa+renesas@sang-engineering.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 16:05:49 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Applied, thanks,

Jonathan

> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index cfb6588565ba..2ce0efd98cc0 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -304,8 +304,7 @@ EXPORT_SYMBOL(hid_sensor_setup_trigger);
>  
>  static int __maybe_unused hid_sensor_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
>  
>  	return _hid_sensor_power_state(attrb, false);
> @@ -313,8 +312,7 @@ static int __maybe_unused hid_sensor_suspend(struct device *dev)
>  
>  static int __maybe_unused hid_sensor_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
>  	schedule_work(&attrb->work);
>  	return 0;
> @@ -322,8 +320,7 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
>  
>  static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
>  	return _hid_sensor_power_state(attrb, true);
>  }
