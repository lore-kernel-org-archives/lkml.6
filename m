Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeBDK6y (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 05:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbeBDK6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 05:58:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5287C217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 4 Feb 2018 10:58:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Archana Patni <archana.patni@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/pressure: Delete an error message for a failed
 memory allocation in hid_press_probe()
Message-ID: <20180204105839.606f8d2e@archlinux>
In-Reply-To: <e7dfe444-616a-e156-31d5-8ed626434d1f@users.sourceforge.net>
References: <e7dfe444-616a-e156-31d5-8ed626434d1f@users.sourceforge.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018 22:04:11 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 29 Jan 2018 21:55:08 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Whilst the error message doesn't add a lot, it does add some information
over a simple memory copy failed error.

Hence I think we should keep it.

Jonathan

> ---
>  drivers/iio/pressure/hid-sensor-press.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index 4c437918f1d2..9de7590d50b0 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -280,10 +280,8 @@ static int hid_press_probe(struct platform_device *pdev)
>  
>  	indio_dev->channels = kmemdup(press_channels, sizeof(press_channels),
>  				      GFP_KERNEL);
> -	if (!indio_dev->channels) {
> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
> +	if (!indio_dev->channels)
>  		return -ENOMEM;
> -	}
>  
>  	ret = press_parse_report(pdev, hsdev,
>  				 (struct iio_chan_spec *)indio_dev->channels,
