Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA85C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21188207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wKXZrEAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfBFImA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:42:00 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46962 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfBFIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:41:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x168fod6114394;
        Wed, 6 Feb 2019 02:41:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549442510;
        bh=XhDoXUadYdFFiUAE/49bF1tB6Vit9OpQpUHGT6ecqf8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=wKXZrEAI/BNC58zIz67nR1h+lQlnRcsD+cCc+XjHQl2SqiV6+c2Ccr3Qz4jJ5b17Q
         JzpNrq2kArhK8Duv+6kOH5xOf3HD0wMnZE3poK9jQYezLHQDYZirl1xnnqYfT2Z0HA
         gvGfun0Tv7CSb6iXEH39Ygun5vU7gMFQcHIynOxc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x168foMA108655
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 02:41:50 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 02:41:50 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 02:41:50 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x168fmgx022406;
        Wed, 6 Feb 2019 02:41:48 -0600
Subject: Re: [PATCH] usb: dwc3: Enable GBit Ethernet on Odroid XU4
To:     Jochen Sprickerhof <git@jochen.sprickerhof.de>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vivek Gautam <gautam.vivek@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20190121140204.GA2360@vis>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C5A9DCB.8040507@ti.com>
Date:   Wed, 6 Feb 2019 10:41:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190121140204.GA2360@vis>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/01/19 16:02, Jochen Sprickerhof wrote:
> Note that it only works with USB_XHCI_PLATFORM=y. Also it needs a hard
> reset when coming from an unpatched kernel.
> 
> This was included in the original patch in
> https://patchwork.kernel.org/patch/9992809/ but got dropped when
> accepted in d8c80bb3b55b phy: exynos5-usbdrd: Calibrate LOS levels for
> exynos5420/5800.
> 
> Old behaviour:
> 
> $ lsusb -t
> /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>    |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 480M
> 
> New behaviour:
> 
> $ lsusb -t
> /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>    |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
> 
> Tested on Debian unstable using u-boot-exynos (2018.11+dfsg-2) and Linux
> 4.19.14.
> 
> Signed-off-by: Jochen Sprickerhof <git@jochen.sprickerhof.de>
> ---
> 
> Hi,
> 
> I'm not sure why this it only works with the driver compiled into the
> kernel nor why it needs a hard reset or why it was the line was dropped
> when the patch was accepted. Would be great to get some feedback of the
> authors.

When XHCI driver is compiled into the kernel are the relevant PHY drivers
compiled in as well?

cheers,
-roger

> 
> Cheers Jochen
> 
> drivers/usb/dwc3/core.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a1b126f90261..0008bccc30aa 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1169,7 +1169,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>                 dev_err(dev, "failed to initialize host\n");
>             return ret;
>         }
> -        phy_calibrate(dwc->usb2_generic_phy);
> +        if (dwc->usb2_generic_phy)
> +            phy_calibrate(dwc->usb2_generic_phy);
>         break;
>     case USB_DR_MODE_OTG:
>         INIT_WORK(&dwc->drd_work, __dwc3_set_mode);

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
