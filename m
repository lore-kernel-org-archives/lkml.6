Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeDUQKU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 12:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752880AbeDUQKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 12:10:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04ADE20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:07:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/61] iio: common: cros_ec_sensors: simplify getting
 .drvdata
Message-ID: <20180421170754.4f3ab554@archlinux>
In-Reply-To: <20180419140641.27926-19-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <20180419140641.27926-19-wsa+renesas@sang-engineering.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 16:05:48 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Applied, thanks.

Jonathan

> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index a620eb5ce202..3df6c0e09832 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -448,8 +448,7 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
>  
>  static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  
>  	if (st->curr_sampl_freq == 0)
> @@ -471,8 +470,7 @@ static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
>  
>  static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  
>  	if (st->curr_sampl_freq == 0)
