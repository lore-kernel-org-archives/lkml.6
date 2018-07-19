Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA857C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F9020693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T2rirjU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F9020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeGSJjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:39:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35792 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeGSJjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:39:37 -0400
Received: by mail-oi0-f68.google.com with SMTP id i12-v6so14157574oik.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I+JK3renuCFlAw9ZwiTA11KqBcnC3e0sol3C3ZezJ+o=;
        b=T2rirjU6q3CKuHa5dXHfF+NfX6/lPiGsqX3NQ34Jf3AxfMRDprAhJRYP7cdhkGczI5
         xgrQ3QP3QpA+TdQgoxj8AQsKuZ6qhyXh73VJEvBw+iFNg26MOra53oD6JIVCnujZfovF
         H5R0XtvHabOd8nVpwYisq5+UPv/AVBFFgYjB+Qk7qTF/cZhENMzOIjCBGyeGaU1AUGnK
         Hbm8QCGH99wKSF8qaX94xpdb6idH8lvmDvpht+PBq4TGloVpL7uf50SRKAWH3TnbTM2G
         zvzoUNCNGBC2RgBeSfqy3OQhRlN03aF1rcbGtkbbTQXR5qhKnOgYPwBTUzXJk14u84DY
         u77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I+JK3renuCFlAw9ZwiTA11KqBcnC3e0sol3C3ZezJ+o=;
        b=UR3t2x4VXLjvJWudK/dLvB3ztw7ZXsoUCQ6UNYaMWMbRN11nddDXSzr61eNxIu2Htl
         VfW65H6VbhZWXBIved3OOzwRXasMzYjZMLJof2CzSSlQaCfVPoML5K0tiTAMKQtw/YbH
         AjkZChomIJVP/e17sc9ucKFDIbLgjHgWWBVvYy9vKjX17v4b2rKvcASSbw53yH2y9gxu
         ocrbDdK2uMyLtOm2s2RYDM01aGFxG7yWpuarbz+C/muIXyIgXEVdIWVEA5QPlLKNpdZr
         kcuDfuRnvGqvuJ3D9SMBg4OruqOe20KHdDf+XOvpEtYT/SPJ9x/woFPzHg1LXaA9vBnr
         lL7Q==
X-Gm-Message-State: AOUpUlHgN6uADD7RRAiWv+EmMrqhSjaKZs/6aHdLYlPUO3P4GzMinMPv
        zwLZlakqa5zfnC6CZNQbcT10/83uNNeqSv0jAq1j5Q==
X-Google-Smtp-Source: AAOMgpcuOb4CanAPzkoPZMb/1spyxmZAo/2+6/QSFRYJSASMjY9Z1NrrCeF1mu+xDgvISKfsE8FhQiTckNFFGJVlR00=
X-Received: by 2002:aca:6b51:: with SMTP id g78-v6mr10491248oic.290.1531990647882;
 Thu, 19 Jul 2018 01:57:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2c15:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 01:57:27
 -0700 (PDT)
In-Reply-To: <20180719084503.tfv6jllsukk2zv3f@mwanda>
References: <20180719082028.26116-1-brgl@bgdev.pl> <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 19 Jul 2018 10:57:27 +0200
Message-ID: <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] net: add support for nvmem to eth_platform_get_mac_address()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-19 10:48 GMT+02:00 Dan Carpenter <dan.carpenter@oracle.com>:
> On Thu, Jul 19, 2018 at 10:20:27AM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Many non-DT platforms read the MAC address from EEPROM. Usually it's
>> either done with callbacks defined in board files or from SoC-specific
>> ethernet drivers.
>>
>> In order to generalize this, try to read the MAC from nvmem in
>> eth_platform_get_mac_address() using a standard lookup name:
>> "mac-address".
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  net/ethernet/eth.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
>> index 39af03894598..af3b4b1b77eb 100644
>> --- a/net/ethernet/eth.c
>> +++ b/net/ethernet/eth.c
>> @@ -54,6 +54,7 @@
>>  #include <linux/if_ether.h>
>>  #include <linux/of_net.h>
>>  #include <linux/pci.h>
>> +#include <linux/nvmem-consumer.h>
>>  #include <net/dst.h>
>>  #include <net/arp.h>
>>  #include <net/sock.h>
>> @@ -527,8 +528,11 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>>
>>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>  {
>> +     unsigned char addrbuf[ETH_ALEN];
>>       const unsigned char *addr;
>> +     struct nvmem_cell *nvmem;
>>       struct device_node *dp;
>> +     size_t alen;
>>
>>       if (dev_is_pci(dev))
>>               dp = pci_device_to_OF_node(to_pci_dev(dev));
>> @@ -541,6 +545,29 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>       if (!addr)
>>               addr = arch_get_platform_mac_address();
>>
>> +     if (!addr) {
>> +             nvmem = nvmem_cell_get(dev, "mac-address");
>> +             if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
>> +                     /* We may have a lookup registered for MAC address but
>> +                      * the corresponding nvmem provider hasn't been
>> +                      * registered yet.
>> +                      */
>> +                     return -EPROBE_DEFER;
>> +
>> +             if (!IS_ERR(nvmem)) {
>> +                     addr = nvmem_cell_read(nvmem, &alen);
>> +                     if (!IS_ERR(addr)) {
>                                     ^^^^
> Never do success handling.  Always error handling.  Otherwise the code
> is indent a lot and the error handling is far from the call.
>
>> +                             if (alen == ETH_ALEN)
>> +                                     ether_addr_copy(addrbuf, addr);
>> +
>> +                             kfree(addr);
>> +                             addr = alen == ETH_ALEN ? addrbuf : NULL;
>> +                     }
>> +
>> +                     nvmem_cell_put(nvmem);
>> +             }
>> +     }
>> +
>>       if (!addr || !is_valid_ether_addr(addr))
>                                           ^^^^
> Instead of handling the error we dereference the error pointer here.
>

True - we should add a check for IS_ERR(addr) here.

> *frowny face*
>
>>               return -ENODEV;
>>
>> --
>
> Maybe this?
>
>         if (!addr) {
>                 nvmem = nvmem_cell_get(dev, "mac-address");
>                 if (PTR_ERR(nvmem) == -EPROBE_DEFER)
>                         return -EPROBE_DEFER;
>                 if (IS_ERR(nvmem))
>                         return -ENODEV;
>                 addr = nvmem_cell_read(nvmem, &alen);
>                 if (IS_ERR(addr))
>                         return PTR_ERR(addr);
>                 if (alen != ETH_ALEN) {
>                         kfree(addr);
>                         return -ENODEV;
>                 }
>                 ether_addr_copy(addrbuf, addr);
>                 kfree(addr);
>                 addr = addrbuf;
>         }
>         if (!is_valid_ether_addr(addr))
>                 return -ENODEV;
>         ether_addr_copy(mac_addr, addr);
>         return 0;
>

I would normally go this way but here we don't want to bail out when
we encounter an error but rather continue on to the next possible
source of a MAC address. We'll get -ENODEV from nvmem_cell_get() if
the lookup fails for "mac-address" but instead of returning an error
code we should then check if we can read the MAC from MTD.

Bart
