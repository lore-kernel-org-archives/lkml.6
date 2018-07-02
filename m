Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA357C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526C525187
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fKH6pyoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526C525187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932230AbeGBHlk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:41:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33819 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeGBHlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:41:37 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so2186961ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OxbH/gETGATA9XOTmCf9gQveO0CUa2EhLuIVyOq/FKM=;
        b=fKH6pyoyFPfQOYRpvDRqHrAU2naF/IBjLI7/T3rh/tH5uiO8xbWMTmNY6wxbvVu3jH
         3mRxodnYvwBLZDY+BaULQffw3A5Zecp0/0gJFEYUWiFmc/R2NfeZemtw+XEvA+pdxGSX
         v/3QvTha4FcMrHPWmgzy1aK2iersvdZJKbRwVmn+PwDtJ60ZmK3GfDVHT23gskzdvKDN
         xCdH2Bmf6DuE/KB9sFrcCkx3ZfQiRB9lLlBspeJMJWOgSAWMN/Fu5DIJle/i0XJFeoWY
         lIyaAy2F8+3KnPEpUEpZGf/sacAO4bxoSKeVazzeXlm8b+h/IF6eREIXMw7kZs2Tjd9z
         Ds5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OxbH/gETGATA9XOTmCf9gQveO0CUa2EhLuIVyOq/FKM=;
        b=glvR5kDiluY3Op1atS1v8IJJA+MQx50t86pofECqXvrsjGiNBMFayT+T+tCPYPh5TY
         aCjMutyT+9iEo9l+E+LG21VQs3hcx56HfSUSIiJH9JLYQ5xnijFY7AMW2Rp382H9+sPS
         xoACE+mBphaRZHBpmxDwAD/IrrjsPVoDlVnS6Hl8Ytc4/eQ24bXwfTpYn3hTH+Ddu5z9
         DIz7vzsAaJqJr6FXxMhiWU8QWz1R9TDG7F6EhTUwz1vRqkwncFszKE3vngdsVzHbrHW5
         59GumgUPnK4sVZPzqXrt++VPbbAGpziJp5ZnIQFEwPy+RB/7q60wU2XZJvBXqkgIInaO
         R7rg==
X-Gm-Message-State: APt69E0DbyWs2C0zFW6XcTCaNkwROsIxXBZ4lXlvOPM1/fLlE+L5uZHN
        c9B5R74TednC786uCWTEhuuZdfJPQFpeFREl103PRw==
X-Google-Smtp-Source: AAOMgpcloC/nTbgI0JFh9/zv0JovllDCGiy3bvEcI+H5kf1hoDKENAd2EN2+qv9Vo7c8sOHri3vnvnvzH6fz6Lkmrrw=
X-Received: by 2002:aca:310b:: with SMTP id x11-v6mr12169992oix.74.1530517296598;
 Mon, 02 Jul 2018 00:41:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2c15:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 00:41:36 -0700 (PDT)
In-Reply-To: <ee49a8de-0812-a619-25be-4c6d8a35cc81@lechnology.com>
References: <20180629094039.7543-1-brgl@bgdev.pl> <20180629094039.7543-9-brgl@bgdev.pl>
 <e2579b81-7c66-8be6-fcad-ab7a3a5b0765@lechnology.com> <ee49a8de-0812-a619-25be-4c6d8a35cc81@lechnology.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 2 Jul 2018 09:41:36 +0200
Message-ID: <CAMpxmJV2kC+Na5uiWsTtBtSev65ba3+jZhzzeoktXR0TAQQtKw@mail.gmail.com>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
To:     David Lechner <david@lechnology.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-29 22:35 GMT+02:00 David Lechner <david@lechnology.com>:
> On 06/29/2018 03:09 PM, David Lechner wrote:
>>
>> On 06/29/2018 04:40 AM, Bartosz Golaszewski wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> On da850-evm board we can read the MAC address from MTD. It's currently
>>> done in the relevant board file, but we want to get rid of all the MAC
>>> reading callbacks from the board file (SPI and NAND). Move the reading
>>> of the MAC address from SPI to the emac driver's probe function.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>   drivers/net/ethernet/ti/davinci_emac.c | 20 ++++++++++++++++++--
>>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/ti/davinci_emac.c
>>> b/drivers/net/ethernet/ti/davinci_emac.c
>>> index a1a6445b5a7e..48e6a7755811 100644
>>> --- a/drivers/net/ethernet/ti/davinci_emac.c
>>> +++ b/drivers/net/ethernet/ti/davinci_emac.c
>>> @@ -67,7 +67,7 @@
>>>   #include <linux/of_irq.h>
>>>   #include <linux/of_net.h>
>>>   #include <linux/mfd/syscon.h>
>>> -
>>> +#include <linux/mtd/mtd.h>
>>>   #include <asm/irq.h>
>>>   #include <asm/page.h>
>>> @@ -1783,7 +1783,10 @@ static int davinci_emac_probe(struct
>>> platform_device *pdev)
>>>       struct cpdma_params dma_params;
>>>       struct clk *emac_clk;
>>>       unsigned long emac_bus_frequency;
>>> -
>>> +#ifdef CONFIG_MTD
>>> +    size_t mac_addr_len;
>>> +    struct mtd_info *mtd;
>>> +#endif /* CONFIG_MTD */
>>>       /* obtain emac clock from kernel */
>>>       emac_clk = devm_clk_get(&pdev->dev, NULL);
>>> @@ -1815,6 +1818,19 @@ static int davinci_emac_probe(struct
>>> platform_device *pdev)
>>>           goto err_free_netdev;
>>>       }
>>> +#ifdef CONFIG_MTD
>>
>>
>> What about the case when MTD is compiled as a module?
>>
>>> +    mtd = get_mtd_device_nm("MAC-Address");
>>
>>
>> What about the case when PTR_ERR(mtd) == -EPROBE_DEFER?
>
>
> To answer my own question: because get_mtd_device_nm() doesn't
> ever return -EPROBE_DEFER.
>
> I'm trying to make this work on LCDK, but the emac driver probes
> before any mtd device is registered, so, I just get -ENODEV even
> though I've added a partition to the device tree labeled
> "MAC-Address". You can see in the kernel messages that MTD is
> not probed until later.
>

I tested it on da850-evm - all MTD & SPI related modules need to be
built-in for it to work, so:

CONFIG_MTD=y
CONFIG_MTD_M25P80=y
CONFIG_SPI_DAVINCI=y

Best regards,
Bartosz Golaszewski

>
>>
>>> +    if (!IS_ERR(mtd)) {
>>> +        rc = mtd_read(mtd, 0, ETH_ALEN,
>>> +                  &mac_addr_len, priv->mac_addr);
>>> +        if (rc == 0)
>>> +            dev_info(&pdev->dev,
>>> +                 "Read MAC addr from SPI Flash: %pM\n",
>>> +                 priv->mac_addr);
>>> +        put_mtd_device(mtd);
>>> +    }
>>> +#endif /* CONFIG_MTD */
>>> +
>>>       /* MAC addr and PHY mask , RMII enable info from platform_data */
>>>       memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
>>>       priv->phy_id = pdata->phy_id;
>>>
>>
>
