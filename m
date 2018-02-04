Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeBDLYC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 06:24:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeBDLXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 06:23:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585C6217AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 4 Feb 2018 11:23:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] hid-sensor-accel-3d: Delete an error message for a
 failed memory allocation in hid_accel_3d_probe()
Message-ID: <20180204112346.0977e938@archlinux>
In-Reply-To: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2018 22:26:14 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 31 Jan 2018 22:20:56 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Marcus,

If making changes like this I would suggest only sending one until
you have have a response from the relevant maintainer.

It would save you time as often these sorts of changes are
a matter of personal taste and weighing up of costs vs gains
- hence it is not obvious that they will be accepted.

Jonathan

> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index c066a3bdbff7..3d0acde40285 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -383,11 +383,9 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  	indio_dev->channels = kmemdup(channel_spec, channel_size, GFP_KERNEL);
> -
> -	if (!indio_dev->channels) {
> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
> +	if (!indio_dev->channels)
>  		return -ENOMEM;
> -	}
> +
>  	ret = accel_3d_parse_report(pdev, hsdev,
>  				(struct iio_chan_spec *)indio_dev->channels,
>  				hsdev->usage, accel_state);
