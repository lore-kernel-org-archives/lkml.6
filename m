Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeFAQJG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:09:06 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:53113 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbeFAQJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:09:04 -0400
Date: Fri, 1 Jun 2018 09:09:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Colin King <colin.king@canonical.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (k10temp) Make function get_raw_temp static
Message-ID: <20180601160903.GA4178@roeck-us.net>
References: <20180601133713.8817-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601133713.8817-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:37:13PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function get_raw_temp is local to the source and does not need to
> be in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/hwmon/k10temp.c:149:14: warning: symbol 'get_raw_temp' was not
> declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/k10temp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index d3fae5a8e508..17c6460ae351 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -146,7 +146,7 @@ static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
>  		     F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
>  }
>  
> -unsigned int get_raw_temp(struct k10temp_data *data)
> +static unsigned int get_raw_temp(struct k10temp_data *data)
>  {
>  	unsigned int temp;
>  	u32 regval;
> -- 
> 2.17.0
> 
