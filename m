Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86730C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297BA2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RWpZ+PLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297BA2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbeGSQIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:08:44 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44258 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731810AbeGSQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:08:43 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so15644793oih.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sdGWK01zvDzSx7or2ETxkSK3GK8/l38qM2g0wM3HV0w=;
        b=RWpZ+PLCdS7gPW7P6crbIuLuU0moifnx5+qG8btHzrIMO9KyC4LIQ4C43hdsCSaiX4
         3TnzYvmDBhAgO35RYQs7kxqkz2IQu1iDojud5zUlj8KXVQp1DeEGGKcVHFanO3A2+N07
         iXAeZBnu1Y4OzNquLZES1/cpmb3pGXnxPOPkKylo6mbT1x+0q3AFYPgRItdQ+7Rek15c
         rF3LKW6PFsqUMOcsSn+n2XdserimB0AvHTMHPbUhj9tIcU2X8xcb9l2sF6MgU/2Vgw7o
         4QVTJltK+HU1WpwFEbl7NrLMlAn785zQcUFYVzBOiIgoGVffAuTz5vnniNiAjW3yaW2+
         Fy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sdGWK01zvDzSx7or2ETxkSK3GK8/l38qM2g0wM3HV0w=;
        b=i65n62NpKx2xpQO+hl7Kbd31E8xJLvmZ/UBhaKygJUvpXwGhApxOUvg79qWNMXtg2h
         0g1Euk3AIV/hWXw4diaQqrPF0iQ58WRwstYZEZ1KJMX1xWfN7p+6BVUMb2CSnqx6UQOi
         dSbHU8C4ME1pOL6Q1LFEfps6QqQ6biW1UUOt9On/Htzw8BlbkvA7F1pQ+cChpEQnVwWB
         pLiRbXnpqYpUzwjbdetfOF9tO2GKWaCMy9OghCRDILgBw0Dy8FKYQhoRuQTz8LiJ3Bl5
         wmhOQ35rjwcmUd4yzi1cifyjupn1rcPQwkDbZlDmiNpronCHm3R77qASh9wDpmcQyb3X
         MuBA==
X-Gm-Message-State: AOUpUlH2ohaBzTjfgHwVUXntYqMR5CzDlXlrGdQK9/3E0nS5MpLcfd7Q
        5huoKsbCQPO7wmWM3Kapc3D/M2CocJtDfKtSI3PQYQ==
X-Google-Smtp-Source: AAOMgpcyYFnrClLfackhAuHJnxo6uABAn8DcHhcEYVG38aKB1PwEulVuCk8LSTl/18k5v6FquLC8OTSOG/sSQQmz4TU=
X-Received: by 2002:aca:310b:: with SMTP id x11-v6mr11793311oix.74.1532013902774;
 Thu, 19 Jul 2018 08:25:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2c15:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 08:25:02
 -0700 (PDT)
In-Reply-To: <20180719152222.GD9119@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-5-brgl@bgdev.pl>
 <20180719152222.GD9119@lunn.ch>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 19 Jul 2018 17:25:02 +0200
Message-ID: <CAMpxmJWXLi5XbhJ0a_DcLJcAQK4bjMmKjam4NAn6QW-7nJ0MFA@mail.gmail.com>
Subject: Re: [PATCH 4/5] net: add support for nvmem to eth_platform_get_mac_address()
To:     Andrew Lunn <andrew@lunn.ch>
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
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-19 17:22 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Jul 18, 2018 at 06:10:34PM +0200, Bartosz Golaszewski wrote:
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
>>  net/ethernet/eth.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
>> index 6b64586fd2af..adf5bd03851f 100644
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
>> @@ -530,7 +531,10 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>       struct device_node *dp = dev_is_pci(dev) ?
>>                       pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
>>       const unsigned char *addr = NULL;
>> +     unsigned char addrbuf[ETH_ALEN];
>> +     struct nvmem_cell *nvmem;
>>       const char *from = NULL;
>> +     size_t alen;
>>
>>       if (dp) {
>>               addr = of_get_mac_address(dp);
>> @@ -544,6 +548,31 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>                       from = "arch callback";
>>       }
>>
>> +     if (!addr) {
>> +             nvmem = nvmem_cell_get(dev, "mac-address");
>> +             if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
>
> How does EPROBE_DEFER work here? You say the use case is
> Non-DT. Without having DT, how do you know the cell should exist, but
> does not yet exist? I might be looking at old code, but i only see
> -EPROBE_DEFER inside the if (np) case.
>
>> +                     /* We may have a lookup registered for MAC address but
>> +                      * the corresponding nvmem provider hasn't been
>> +                      * registered yet.
>> +                      */
>> +                     return -EPROBE_DEFER;
>
> You really should return real errors. If i'm reading
> __nvmem_device_get() right, it will return a NULL pointer when the
> cell does not exist. NULL is not an error, so IS_ERR() will return
> false. So you should return all errors from nvmem_cell_get().
>
>        Andrew

We have a patch queued for nvmem for 4.19 which adds a notion of nvmem
cell lookups similar to gpio lookups:
https://patchwork.kernel.org/patch/10496045/

This will work fine with probe deferral.

Bart
