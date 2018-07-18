Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AD9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1C02086D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fYG/awXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1C02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeGRRc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:32:59 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43511 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbeGRRc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:32:59 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so4658839ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WJx5781lanfI2RSm+fmId08dZ4YJLSiZTokA3X5W5x8=;
        b=fYG/awXQuJJIJ/hqS0gFZfJZSRGHMz4O/lrxhkP5e29WQcAJQBVUvsM91amFE395LJ
         om4qcmAYLs5Ss+JccwRxSEmMRaSly+1rIJpF9r7dRt64Y8L9HIjzXk3XbnCbA1i02z5Z
         Y04z21pto9FKkm3Z+cafbrUTm05usWMLj3UxBeBlO/RJE24I+rbBnlZfeA1CYKoZGBLd
         9WZQMPGyVumWT4bYpraZGkgzRuYiG9dOQJILjuOSxrLj9Y0Ce0OPqQ+W1B8b39U9Nk5w
         vM2jNaRrNojh04XqAocTj5xW/4NHi0GmeVOVPHr+wqtMJE9c9pa2kor9Su5cW7vhYa1u
         85+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WJx5781lanfI2RSm+fmId08dZ4YJLSiZTokA3X5W5x8=;
        b=iFz2wzxcdngbpqT0ikams2DMa6rtoi4tW4+wZBs9f04GddXTeIbqfNNR9LAqpPmIHA
         fSvb99QRjr+GqNdXASyvXTnrlJvt1Ki8ZLn+9Q9/XPvD4EcgxuaUnfRGSRx9dK/rt0qU
         f/W4Pr4CSAFGeCB3Hykj218RZihiUfzFYpFrYG9bPTFzf36imJyGhRgO4O+XdwAkOQMZ
         ODXOX+GdsELe/wBT0EU31FZmmfriihYF2m6xqdYVLzD3bF0I50bkL0CCY4eM1yk9zuIe
         qDyiIuzBP6gmNDkMNV2d8NPEFKNeLoOO0OwkpOsL0rfCbjXH27sMc7iOyIBbjfAiAVo4
         oJ+g==
X-Gm-Message-State: AOUpUlFTNDPtOG1azinGzfeGa2i4LlmcX/C15NgMVk91sx+zYWgeavTW
        K04U1uy7qxv0YW2vaMCyPjeUi0P3zWMmYC9PY4WTcQ==
X-Google-Smtp-Source: AA+uWPxQzOkJvsn1TWK56mobaRl2JgBEbPDB8Z1N5L1rJnlvhNcYFF0w83D7ERixoXS9bzwn9msYuHhRa0amNFJAGTM=
X-Received: by 2002:a6b:c844:: with SMTP id y65-v6mr5646189iof.187.1531932852524;
 Wed, 18 Jul 2018 09:54:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 09:54:12
 -0700 (PDT)
In-Reply-To: <20180718164737.GE12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 18 Jul 2018 18:54:12 +0200
Message-ID: <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
Subject: Re: [PATCH 5/5] net: add MTD support to eth_platform_get_mac_address()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-18 18:47 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Jul 18, 2018 at 06:10:35PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> MTD doesn't support nvmem yet. Some platforms use MTD to read the MAC
>> address from SPI flash. If we want this function to generalize reading
>> the MAC address, we need to separately try to use MTD.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  net/ethernet/eth.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
>> index adf5bd03851f..f7dbd2cff7f9 100644
>> --- a/net/ethernet/eth.c
>> +++ b/net/ethernet/eth.c
>> @@ -55,6 +55,7 @@
>>  #include <linux/of_net.h>
>>  #include <linux/pci.h>
>>  #include <linux/nvmem-consumer.h>
>> +#include <linux/mtd/mtd.h>
>>  #include <net/dst.h>
>>  #include <net/arp.h>
>>  #include <net/sock.h>
>> @@ -573,6 +574,25 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>               }
>>       }
>>
>> +#ifdef CONFIG_MTD
>> +     /* NOTE: this should go away as soon as MTD gets nvmem support. */
>> +     if (!addr) {
>> +             struct mtd_info *mtd;
>> +             int rv;
>> +
>> +             mtd = get_mtd_device_nm("MAC-Address");
>
> In order for this to go away, you need to keep backwards
> compatibility. When using nvmem, you look for a cell called
> "mac-address". Here you are looking for "MAC-Address". That is going
> to make backwards compatibility harder. How do you plan to do it?
>
>    Andrew

I'm trying to adjust to already existing users. The only user of
get_mtd_device_nm() who calls it to read the MAC address registers a
partition called "MAC-Address". We can't change it since it's visible
from user space. In the future we'd just have to have a list of
supported string that we'd use to do the nvmem lookup.

Bart
