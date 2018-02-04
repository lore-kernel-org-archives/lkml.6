Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeBDLBS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 06:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbeBDLBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 06:01:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC4A217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 4 Feb 2018 11:01:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/orientation: Delete an error message for a failed
 memory allocation in two functions
Message-ID: <20180204110107.19861b13@archlinux>
In-Reply-To: <ebf6c923-d641-8bf8-5544-630a5ee39980@users.sourceforge.net>
References: <ebf6c923-d641-8bf8-5544-630a5ee39980@users.sourceforge.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018 22:26:15 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 29 Jan 2018 22:20:07 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Same response as previous patch - it might not be adding much information,
but it is adding some so we should keep it.

Jonathan

> ---
>  drivers/iio/orientation/hid-sensor-incl-3d.c  | 4 +---
>  drivers/iio/orientation/hid-sensor-rotation.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
> index 1e5451d1ff88..742c0e0eb4cf 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -336,10 +336,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
>  
>  	indio_dev->channels = kmemdup(incl_3d_channels,
>  				      sizeof(incl_3d_channels), GFP_KERNEL);
> -	if (!indio_dev->channels) {
> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
> +	if (!indio_dev->channels)
>  		return -ENOMEM;
> -	}
>  
>  	ret = incl_3d_parse_report(pdev, hsdev,
>  				   (struct iio_chan_spec *)indio_dev->channels,
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index a69db2002414..cbf5e406b1ee 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -277,10 +277,8 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
>  	indio_dev->channels = devm_kmemdup(&pdev->dev, dev_rot_channels,
>  					   sizeof(dev_rot_channels),
>  					   GFP_KERNEL);
> -	if (!indio_dev->channels) {
> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
> +	if (!indio_dev->channels)
>  		return -ENOMEM;
> -	}
>  
>  	ret = dev_rot_parse_report(pdev, hsdev,
>  				   (struct iio_chan_spec *)indio_dev->channels,
