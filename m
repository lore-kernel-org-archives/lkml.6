Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeDORO3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 13:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752460AbeDORO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 13:14:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17912077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 18:14:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: potentiometer: mcp4531: switch to using
 .probe_new
Message-ID: <20180415181423.6df210e2@archlinux>
In-Reply-To: <20180411124915.9587-2-peda@axentia.se>
References: <20180411124915.9587-1-peda@axentia.se>
        <20180411124915.9587-2-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 14:49:15 +0200
Peter Rosin <peda@axentia.se> wrote:

> Use the new probe style for i2c drivers.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiometer/mcp4531.c | 145 ++++++++++++++++++------------------
>  1 file changed, 72 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> index 114ab876fcc6..df894af6cccb 100644
> --- a/drivers/iio/potentiometer/mcp4531.c
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -209,6 +209,75 @@ static const struct iio_info mcp4531_info = {
>  	.write_raw = mcp4531_write_raw,
>  };
>  
> +static const struct i2c_device_id mcp4531_id[] = {
> +	{ "mcp4531-502", MCP453x_502 },
> +	{ "mcp4531-103", MCP453x_103 },
> +	{ "mcp4531-503", MCP453x_503 },
> +	{ "mcp4531-104", MCP453x_104 },
> +	{ "mcp4532-502", MCP453x_502 },
> +	{ "mcp4532-103", MCP453x_103 },
> +	{ "mcp4532-503", MCP453x_503 },
> +	{ "mcp4532-104", MCP453x_104 },
> +	{ "mcp4541-502", MCP454x_502 },
> +	{ "mcp4541-103", MCP454x_103 },
> +	{ "mcp4541-503", MCP454x_503 },
> +	{ "mcp4541-104", MCP454x_104 },
> +	{ "mcp4542-502", MCP454x_502 },
> +	{ "mcp4542-103", MCP454x_103 },
> +	{ "mcp4542-503", MCP454x_503 },
> +	{ "mcp4542-104", MCP454x_104 },
> +	{ "mcp4551-502", MCP455x_502 },
> +	{ "mcp4551-103", MCP455x_103 },
> +	{ "mcp4551-503", MCP455x_503 },
> +	{ "mcp4551-104", MCP455x_104 },
> +	{ "mcp4552-502", MCP455x_502 },
> +	{ "mcp4552-103", MCP455x_103 },
> +	{ "mcp4552-503", MCP455x_503 },
> +	{ "mcp4552-104", MCP455x_104 },
> +	{ "mcp4561-502", MCP456x_502 },
> +	{ "mcp4561-103", MCP456x_103 },
> +	{ "mcp4561-503", MCP456x_503 },
> +	{ "mcp4561-104", MCP456x_104 },
> +	{ "mcp4562-502", MCP456x_502 },
> +	{ "mcp4562-103", MCP456x_103 },
> +	{ "mcp4562-503", MCP456x_503 },
> +	{ "mcp4562-104", MCP456x_104 },
> +	{ "mcp4631-502", MCP463x_502 },
> +	{ "mcp4631-103", MCP463x_103 },
> +	{ "mcp4631-503", MCP463x_503 },
> +	{ "mcp4631-104", MCP463x_104 },
> +	{ "mcp4632-502", MCP463x_502 },
> +	{ "mcp4632-103", MCP463x_103 },
> +	{ "mcp4632-503", MCP463x_503 },
> +	{ "mcp4632-104", MCP463x_104 },
> +	{ "mcp4641-502", MCP464x_502 },
> +	{ "mcp4641-103", MCP464x_103 },
> +	{ "mcp4641-503", MCP464x_503 },
> +	{ "mcp4641-104", MCP464x_104 },
> +	{ "mcp4642-502", MCP464x_502 },
> +	{ "mcp4642-103", MCP464x_103 },
> +	{ "mcp4642-503", MCP464x_503 },
> +	{ "mcp4642-104", MCP464x_104 },
> +	{ "mcp4651-502", MCP465x_502 },
> +	{ "mcp4651-103", MCP465x_103 },
> +	{ "mcp4651-503", MCP465x_503 },
> +	{ "mcp4651-104", MCP465x_104 },
> +	{ "mcp4652-502", MCP465x_502 },
> +	{ "mcp4652-103", MCP465x_103 },
> +	{ "mcp4652-503", MCP465x_503 },
> +	{ "mcp4652-104", MCP465x_104 },
> +	{ "mcp4661-502", MCP466x_502 },
> +	{ "mcp4661-103", MCP466x_103 },
> +	{ "mcp4661-503", MCP466x_503 },
> +	{ "mcp4661-104", MCP466x_104 },
> +	{ "mcp4662-502", MCP466x_502 },
> +	{ "mcp4662-103", MCP466x_103 },
> +	{ "mcp4662-503", MCP466x_503 },
> +	{ "mcp4662-104", MCP466x_104 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp4531_id);
> +
>  #ifdef CONFIG_OF
>  
>  #define MCP4531_COMPATIBLE(of_compatible, cfg) {	\
> @@ -286,8 +355,7 @@ static const struct of_device_id mcp4531_of_match[] = {
>  MODULE_DEVICE_TABLE(of, mcp4531_of_match);
>  #endif
>  
> -static int mcp4531_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int mcp4531_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct mcp4531_data *data;
> @@ -311,7 +379,7 @@ static int mcp4531_probe(struct i2c_client *client,
>  	if (match)
>  		data->cfg = of_device_get_match_data(dev);
>  	else
> -		data->cfg = &mcp4531_cfg[id->driver_data];
> +		data->cfg = &mcp4531_cfg[i2c_match_id(mcp4531_id, client)->driver_data];
>  
>  	indio_dev->dev.parent = dev;
>  	indio_dev->info = &mcp4531_info;
> @@ -322,81 +390,12 @@ static int mcp4531_probe(struct i2c_client *client,
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> -static const struct i2c_device_id mcp4531_id[] = {
> -	{ "mcp4531-502", MCP453x_502 },
> -	{ "mcp4531-103", MCP453x_103 },
> -	{ "mcp4531-503", MCP453x_503 },
> -	{ "mcp4531-104", MCP453x_104 },
> -	{ "mcp4532-502", MCP453x_502 },
> -	{ "mcp4532-103", MCP453x_103 },
> -	{ "mcp4532-503", MCP453x_503 },
> -	{ "mcp4532-104", MCP453x_104 },
> -	{ "mcp4541-502", MCP454x_502 },
> -	{ "mcp4541-103", MCP454x_103 },
> -	{ "mcp4541-503", MCP454x_503 },
> -	{ "mcp4541-104", MCP454x_104 },
> -	{ "mcp4542-502", MCP454x_502 },
> -	{ "mcp4542-103", MCP454x_103 },
> -	{ "mcp4542-503", MCP454x_503 },
> -	{ "mcp4542-104", MCP454x_104 },
> -	{ "mcp4551-502", MCP455x_502 },
> -	{ "mcp4551-103", MCP455x_103 },
> -	{ "mcp4551-503", MCP455x_503 },
> -	{ "mcp4551-104", MCP455x_104 },
> -	{ "mcp4552-502", MCP455x_502 },
> -	{ "mcp4552-103", MCP455x_103 },
> -	{ "mcp4552-503", MCP455x_503 },
> -	{ "mcp4552-104", MCP455x_104 },
> -	{ "mcp4561-502", MCP456x_502 },
> -	{ "mcp4561-103", MCP456x_103 },
> -	{ "mcp4561-503", MCP456x_503 },
> -	{ "mcp4561-104", MCP456x_104 },
> -	{ "mcp4562-502", MCP456x_502 },
> -	{ "mcp4562-103", MCP456x_103 },
> -	{ "mcp4562-503", MCP456x_503 },
> -	{ "mcp4562-104", MCP456x_104 },
> -	{ "mcp4631-502", MCP463x_502 },
> -	{ "mcp4631-103", MCP463x_103 },
> -	{ "mcp4631-503", MCP463x_503 },
> -	{ "mcp4631-104", MCP463x_104 },
> -	{ "mcp4632-502", MCP463x_502 },
> -	{ "mcp4632-103", MCP463x_103 },
> -	{ "mcp4632-503", MCP463x_503 },
> -	{ "mcp4632-104", MCP463x_104 },
> -	{ "mcp4641-502", MCP464x_502 },
> -	{ "mcp4641-103", MCP464x_103 },
> -	{ "mcp4641-503", MCP464x_503 },
> -	{ "mcp4641-104", MCP464x_104 },
> -	{ "mcp4642-502", MCP464x_502 },
> -	{ "mcp4642-103", MCP464x_103 },
> -	{ "mcp4642-503", MCP464x_503 },
> -	{ "mcp4642-104", MCP464x_104 },
> -	{ "mcp4651-502", MCP465x_502 },
> -	{ "mcp4651-103", MCP465x_103 },
> -	{ "mcp4651-503", MCP465x_503 },
> -	{ "mcp4651-104", MCP465x_104 },
> -	{ "mcp4652-502", MCP465x_502 },
> -	{ "mcp4652-103", MCP465x_103 },
> -	{ "mcp4652-503", MCP465x_503 },
> -	{ "mcp4652-104", MCP465x_104 },
> -	{ "mcp4661-502", MCP466x_502 },
> -	{ "mcp4661-103", MCP466x_103 },
> -	{ "mcp4661-503", MCP466x_503 },
> -	{ "mcp4661-104", MCP466x_104 },
> -	{ "mcp4662-502", MCP466x_502 },
> -	{ "mcp4662-103", MCP466x_103 },
> -	{ "mcp4662-503", MCP466x_503 },
> -	{ "mcp4662-104", MCP466x_104 },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(i2c, mcp4531_id);
> -
>  static struct i2c_driver mcp4531_driver = {
>  	.driver = {
>  		.name	= "mcp4531",
>  		.of_match_table = of_match_ptr(mcp4531_of_match),
>  	},
> -	.probe		= mcp4531_probe,
> +	.probe_new	= mcp4531_probe,
>  	.id_table	= mcp4531_id,
>  };
>  
