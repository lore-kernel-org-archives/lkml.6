Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeCCPXl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751940AbeCCPXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:23:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C672133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 15:23:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, daniel.baluta@nxp.com,
        kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:magnetometer: Replace magic number 0 by
 IIO_CHAN_INFO_RAW
Message-ID: <20180303152335.4c287ede@archlinux>
In-Reply-To: <20180227144755.ifbzn5gekm345nk5@smtp.gmail.com>
References: <20180227144755.ifbzn5gekm345nk5@smtp.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 11:47:55 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The function magn_3d_read_raw has a switch statement handling multiple
> cases per channel. The first case statement uses the magic number 0,
> which means IIO_CHAN_INFO_RAW. Additionally, the iio_chan_spec for
> magn_3d_channels is configured to be IIO_CHAN_INFO_RAW. Therefore, this
> patch replaces the magic number 0 for the appropriate IIO_CHAN_INFO_RAW.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index a1fd9d591818..d55c4885211a 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -167,7 +167,7 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
>  	*val = 0;
>  	*val2 = 0;
>  	switch (mask) {
> -	case 0:
> +	case IIO_CHAN_INFO_RAW:
>  		hid_sensor_power_state(&magn_state->magn_flux_attributes, true);
>  		report_id =
>  			magn_state->magn[chan->address].report_id;
