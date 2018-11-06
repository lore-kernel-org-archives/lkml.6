Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E49C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B3D20830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qe9iQwen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B3D20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbeKGJMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:12:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45936 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbeKGJMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:12:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id o19-v6so6946952pll.12;
        Tue, 06 Nov 2018 15:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bb1htl0Lp8cOf3BA7ZvLVeTZH1h1hfa+x0LneNniiEk=;
        b=qe9iQwen8SO6gdzF+YL11jrxAe1WKzimn8LgW2jtmjGhaC78gvUEacYMd7+lB7tp7R
         Usu9DavONFWC3+ZCdgYga5DQwJHznzLaBtdgKNkt99UO2Mv5lUxW8xsCYIZfGhW/8aXh
         VTLi5l1gWZpoCYBVqFKfZDza4krLiX14o9Rt9NseghL2+kvYSMqMPsQYgv/1N/xT7Xv8
         Z3e6b1jdUnn5y9IyjUYxjJMZMAEXC4M6IFZVCPFAmnXvelFMK+BEUwE92XJxKNKr+CAP
         Es6rB+lJP1DWxLyb5/+GrtQGd0q39JQyxVDQ7oFeRZsm0cTQD1T4VDEVBZ9k33lGwPA+
         8o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bb1htl0Lp8cOf3BA7ZvLVeTZH1h1hfa+x0LneNniiEk=;
        b=cL8OabBQ1kivUxRlaslbOLvOPmLHhEzXzvkRue9WPrIpL6tExUp6eOnxc2zRb2ga5B
         +QKMO38o7nL9gzSGKA9GhTaw7DZJbwAq1wfDtBEOTNpvD6F1kPTitMZCZ8E8V/FfH9lz
         rFCNlgPtLwEzKINT1EBX+Q+9oP3SCQ7FyQX57ZpA0seq8ytoH3Id9VFVyrRyPK4SjvBR
         GvQiXfWBS7+qmCXk68Gyy9oh07ei1W/SK/GoJ4SOwjCX1k8uhXlYQ1rYVIvYwDIxFHCJ
         0GEerSahvVZPddpev6XeDy4e+HSrTihwvQ6GbfTtFtvVkS1uFaXdF0pE1EyQpT5wZWfw
         QuPg==
X-Gm-Message-State: AGRZ1gLpIiYwyoSR09beh3vWr3aamzvdKFVB2dBfANrQc2YjlG6XxPY0
        mqf9egnsmOTC3TCmjZFXFXU=
X-Google-Smtp-Source: AJdET5chqZN5E+/Vfhl6df4z9jUJ936n5miCtPAhgaq4jYfWSGJUKtkTA5+dwzyA2NHmHdE9f17j+Q==
X-Received: by 2002:a17:902:8486:: with SMTP id c6-v6mr8493651plo.119.1541547870870;
        Tue, 06 Nov 2018 15:44:30 -0800 (PST)
Received: from [10.67.49.62] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 3-v6sm52339015pga.12.2018.11.06.15.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 15:44:29 -0800 (PST)
Subject: Re: [PATCH V3 4/6] usb: ohci-platform: Add support for Broadcom STB
 SoC's
To:     Al Cooper <al.cooper@broadcom.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
References: <Pine.LNX.4.44L0.1811061105120.1450-100000@iolanthe.rowland.org>
 <d077971c-d7ef-d630-2d89-5a06fb481b28@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <674c3275-de47-57f4-84aa-58b318aef67b@gmail.com>
Date:   Tue, 6 Nov 2018 15:44:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d077971c-d7ef-d630-2d89-5a06fb481b28@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 1:40 PM, Al Cooper wrote:
> On 11/6/18 11:08 AM, Alan Stern wrote:
>> On Mon, 5 Nov 2018, Al Cooper wrote:
>>
>>> Add support for Broadcom STB SoC's to the ohci platform driver.
>>>
>>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>>> ---
>>
>>> @@ -177,6 +189,8 @@ static int ohci_platform_probe(struct
>>> platform_device *dev)
>>>           ohci->flags |= OHCI_QUIRK_FRAME_NO;
>>>       if (pdata->num_ports)
>>>           ohci->num_ports = pdata->num_ports;
>>> +    if (pdata->suspend_without_phy_exit)
>>> +        hcd->suspend_without_phy_exit = 1;
>>
>> Sorry if I missed this in the earlier discussions...  Is there any
>> possibility of adding a DT binding that could express this requirement,
>> instead of putting it in the platform data?
>>
>> Alan Stern
>>
> 
> Alan,
> 
> That was my original approach but internal review suggested that I use
> pdata instead. Below is my original patch for:

And the reason for that suggestion was really because it was percevied
as encoding a driver behavior as a Device Tree property as opposed to
describing something that was inherently and strictly a hardware
behavior (therefore suitable for Device Tree).

> [PATCH V3 2/6] usb: core: Add ability to skip phy exit on suspend and
> init on resume
> With this patch I can then use ohci_platform.c without any
> modifications. Could you let me know what you think?
> 
> Thanks
> Al
> 
> Add the ability to skip calling the PHY's exit routine on suspend
> and the PHY's init routine on resume. This is to handle a USB PHY
> that should have it's power_off function called on suspend but cannot
> have it's exit function called because on exit it will disable the
> PHY to the point where register accesses to the Host Controllers
> using the PHY will be disabled and the host drivers will crash.
> 
> This is enabled with the HCD flag "suspend_without_phy_exit" which
> can be set from any HCD driver or from the device-tree property
> "suspend-without-phy-exit".
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/usb/core/hcd.c  |  8 ++++----
>  drivers/usb/core/phy.c  | 21 +++++++++++++++------
>  drivers/usb/core/phy.h  |  9 ++++++---
>  include/linux/usb/hcd.h |  3 +++
>  4 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 1c21955fe7c0..e67e4d6b3d21 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2263,7 +2263,7 @@ int hcd_bus_suspend(struct usb_device *rhdev,
> pm_message_t msg)
>          hcd->state = HC_STATE_SUSPENDED;
> 
>          if (!PMSG_IS_AUTO(msg))
> -            usb_phy_roothub_suspend(hcd->self.sysdev,
> +            usb_phy_roothub_suspend(hcd,
>                          hcd->phy_roothub);
> 
>          /* Did we race with a root-hub wakeup event? */
> @@ -2304,7 +2304,7 @@ int hcd_bus_resume(struct usb_device *rhdev,
> pm_message_t msg)
>      }
> 
>      if (!PMSG_IS_AUTO(msg)) {
> -        status = usb_phy_roothub_resume(hcd->self.sysdev,
> +        status = usb_phy_roothub_resume(hcd,
>                          hcd->phy_roothub);
>          if (status)
>              return status;
> @@ -2347,7 +2347,7 @@ int hcd_bus_resume(struct usb_device *rhdev,
> pm_message_t msg)
>          }
>      } else {
>          hcd->state = old_state;
> -        usb_phy_roothub_suspend(hcd->self.sysdev, hcd->phy_roothub);
> +        usb_phy_roothub_suspend(hcd, hcd->phy_roothub);
>          dev_dbg(&rhdev->dev, "bus %s fail, err %d\n",
>                  "resume", status);
>          if (status != -ESHUTDOWN)
> @@ -2744,7 +2744,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>      struct usb_device *rhdev;
> 
>      if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
> -        hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
> +        hcd->phy_roothub = usb_phy_roothub_alloc(hcd);
>          if (IS_ERR(hcd->phy_roothub))
>              return PTR_ERR(hcd->phy_roothub);
> 
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 9879767452a2..0eb12566f1c3 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -45,10 +45,11 @@ static int usb_phy_roothub_add_phy(struct device
> *dev, int index,
>      return 0;
>  }
> 
> -struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
> +struct usb_phy_roothub *usb_phy_roothub_alloc(struct usb_hcd *hcd)
>  {
>      struct usb_phy_roothub *phy_roothub;
>      int i, num_phys, err;
> +    struct device *dev = hcd->self.sysdev;
> 
>      if (!IS_ENABLED(CONFIG_GENERIC_PHY))
>          return NULL;
> @@ -58,6 +59,9 @@ struct usb_phy_roothub *usb_phy_roothub_alloc(struct
> device *dev)
>      if (num_phys <= 0)
>          return NULL;
> 
> +    if (device_property_read_bool(dev, "suspend-without-phy-exit"))
> +        hcd->suspend_without_phy_exit = 1;
> +
>      phy_roothub = devm_kzalloc(dev, sizeof(*phy_roothub), GFP_KERNEL);
>      if (!phy_roothub)
>          return ERR_PTR(-ENOMEM);
> @@ -161,26 +165,30 @@ void usb_phy_roothub_power_off(struct
> usb_phy_roothub *phy_roothub)
>  }
>  EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
> 
> -int usb_phy_roothub_suspend(struct device *controller_dev,
> +int usb_phy_roothub_suspend(struct usb_hcd *hcd,
>                  struct usb_phy_roothub *phy_roothub)
>  {
> +    struct device *controller_dev = hcd->self.sysdev;
> +
>      usb_phy_roothub_power_off(phy_roothub);
> 
>      /* keep the PHYs initialized so the device can wake up the system */
> -    if (device_may_wakeup(controller_dev))
> +    if (device_may_wakeup(controller_dev) ||
> hcd->suspend_without_phy_exit)
>          return 0;
> 
>      return usb_phy_roothub_exit(phy_roothub);
>  }
>  EXPORT_SYMBOL_GPL(usb_phy_roothub_suspend);
> 
> -int usb_phy_roothub_resume(struct device *controller_dev,
> +int usb_phy_roothub_resume(struct usb_hcd *hcd,
>                 struct usb_phy_roothub *phy_roothub)
>  {
> +    struct device *controller_dev = hcd->self.sysdev;
>      int err;
> 
>      /* if the device can't wake up the system _exit was called */
> -    if (!device_may_wakeup(controller_dev)) {
> +    if (!device_may_wakeup(controller_dev) &&
> +        !hcd->suspend_without_phy_exit) {
>          err = usb_phy_roothub_init(phy_roothub);
>          if (err)
>              return err;
> @@ -189,7 +197,8 @@ int usb_phy_roothub_resume(struct device
> *controller_dev,
>      err = usb_phy_roothub_power_on(phy_roothub);
> 
>      /* undo _init if _power_on failed */
> -    if (err && !device_may_wakeup(controller_dev))
> +    if (err && !device_may_wakeup(controller_dev)
> +        && !hcd->suspend_without_phy_exit)
>          usb_phy_roothub_exit(phy_roothub);
> 
>      return err;
> diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
> index 88a3c037e9df..34293e11a917 100644
> --- a/drivers/usb/core/phy.h
> +++ b/drivers/usb/core/phy.h
> @@ -5,13 +5,16 @@
>   * Copyright (C) 2018 Martin Blumenstingl
> <martin.blumenstingl@googlemail.com>
>   */
> 
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +
>  #ifndef __USB_CORE_PHY_H_
>  #define __USB_CORE_PHY_H_
> 
>  struct device;
>  struct usb_phy_roothub;
> 
> -struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev);
> +struct usb_phy_roothub *usb_phy_roothub_alloc(struct usb_hcd *hcd);
> 
>  int usb_phy_roothub_init(struct usb_phy_roothub *phy_roothub);
>  int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
> @@ -19,9 +22,9 @@
>  int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
>  void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
> 
> -int usb_phy_roothub_suspend(struct device *controller_dev,
> +int usb_phy_roothub_suspend(struct usb_hcd *hcd,
>                  struct usb_phy_roothub *phy_roothub);
> -int usb_phy_roothub_resume(struct device *controller_dev,
> +int usb_phy_roothub_resume(struct usb_hcd *hcd,
>                 struct usb_phy_roothub *phy_roothub);
> 
>  #endif /* __USB_CORE_PHY_H_ */
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 97e2ddec18b1..87a104055b5e 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -157,6 +157,9 @@ struct usb_hcd {
>       */
>      unsigned        skip_phy_initialization:1;
> 
> +    /* Some phys don't want the phy's exit/init called on
> suspend/resume */
> +    unsigned        suspend_without_phy_exit:1;
> +
>      /* The next flag is a stopgap, to be removed when all the HCDs
>       * support the new root-hub polling mechanism. */
>      unsigned        uses_new_polling:1;


-- 
Florian
