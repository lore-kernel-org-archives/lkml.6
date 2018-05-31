Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbeEaJR3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:17:29 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:10874 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbeEaJRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:17:24 -0400
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="14728133"
Subject: Re: usb: host: ohci: fix sfr kernel warning in ohci-at91 driver
To: Prasanthi Chellakumar <Prasanthi.Chellakumar@microchip.com>,
        <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1527285896-12811-1-git-send-email-Prasanthi.Chellakumar@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <525dc6c3-8654-50f8-264f-1b375664204c@microchip.com>
Date: Thu, 31 May 2018 11:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527285896-12811-1-git-send-email-Prasanthi.Chellakumar@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2018 at 00:04, Prasanthi Chellakumar wrote:
> The USB Host Controller driver 'ohci-at91.c' reads a Special Function
> Register - OHCI Interrupt Configuration Register (AT91_SFR_OHCIICR)
> for bits SUSPEND_A/B/C. These bits are defined in sama5d2 alone, so
> sfr register mapping is done with compatible string "atmel,sama5d2-sfr".
> This gives a kernel warning 'failed to find sfr node' with non sama5d2
> cpus which is removed here, thus leaving it up to having a proper DTS.
> 
> Signed-off-by: Prasanthi Chellakumar <prasanthi.chellakumar@microchip.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Prasanthi. Best regards,
   Nicolas

> ---
> 
> The AT91_SFR_OHCIIR register is read for USB suspend and wake
> up control. The OHCI driver has a sfr register mapping for sama5d2
> alone. The USB suspend proceeds only when there is valid sfr regmap.
> So SFR access in boards that it is absent is not required. In such
> boards, USB suspend control requests is processed by usb_hub_control().
> But there is a kernel warning with non sama5d2 cpus. This patch fixes
> the kernel warning, changing to debug message(dev_dbg).
> ---
>   drivers/usb/host/ohci-at91.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index af0566d..ce11c47 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -214,7 +214,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>   
>   	ohci_at91->sfr_regmap = at91_dt_syscon_sfr();
>   	if (!ohci_at91->sfr_regmap)
> -		dev_warn(dev, "failed to find sfr node\n");
> +		dev_dbg(dev, "failed to find sfr node\n");
>   
>   	board = hcd->self.controller->platform_data;
>   	ohci = hcd_to_ohci(hcd);
> 


-- 
Nicolas Ferre
