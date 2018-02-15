Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032901AbeBONlp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:41:45 -0500
Received: from smtpweb130.aruba.it ([62.149.158.130]:37858 "EHLO
        smtpweb130.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031726AbeBONln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:41:43 -0500
Subject: Re: [PATCH 1/2] pps-gpio: Avoid flooding syslog
To: Lukas Senger <lukas@fridolin.com>
Cc: linux-kernel@vger.kernel.org
References: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
 <20180215125921.29494-1-lukas@fridolin.com>
 <20180215125921.29494-2-lukas@fridolin.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <6c424674-e8f0-eaf1-c056-889e354b43b7@enneenne.com>
Date: Thu, 15 Feb 2018 14:34:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215125921.29494-2-lukas@fridolin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/18 13:59, Lukas Senger wrote:

^^^^^^^^^^^^^^^^^^^
Missing description and signatures...

> ---
>   drivers/pps/clients/pps-gpio.c | 1 +
>   include/linux/pps-gpio.h       | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index dd7624f1d23f..35c3b14fc9b9 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -196,6 +196,7 @@ static int pps_gpio_probe(struct platform_device *pdev)
>   	data->info.owner = THIS_MODULE;
>   	snprintf(data->info.name, PPS_MAX_NAME_LEN - 1, "%s.%d",
>   		 pdev->name, pdev->id);
> +	data->info.echo = pps_gpio_echo;
>   
>   	/* register PPS source */
>   	pps_default_params = PPS_CAPTUREASSERT | PPS_OFFSETASSERT;
> diff --git a/include/linux/pps-gpio.h b/include/linux/pps-gpio.h
> index 0035abe41b9a..67f50e8dcd11 100644
> --- a/include/linux/pps-gpio.h
> +++ b/include/linux/pps-gpio.h
> @@ -29,4 +29,6 @@ struct pps_gpio_platform_data {
>   	const char *gpio_label;
>   };
>   
> +static void pps_gpio_echo(struct pps_device *pps, int event, void *data){}
> +
>   #endif

Why a void function? You should use it to toggle echoing GPIO... =8-o

Ciao,

Rodolfo

-- 

HCE Engineering                      e-mail: giometti@hce-engineering.it
GNU/Linux Solutions                          giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Cosino Project - the quick prototyping embedded system - www.cosino.it
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
