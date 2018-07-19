Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19EE205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rblFLWIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19EE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbeGSQTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:19:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34866 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731775AbeGSQTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:19:24 -0400
Received: by mail-it0-f66.google.com with SMTP id q20-v6so10511557ith.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fpjT7LGURvaHnPeD63JRN66HubRrDYEim016IoZqmxA=;
        b=rblFLWIFFbmqsU0RLZTSCr+Oo26aomVVWshVESWGGzSU6ZpFM3iKWqnhacIhoGAq5r
         5khRDzcCqWMF4USiuNgZAckrI3oq3SybGQzSKl1zkxv3H0JUjvaRB9Q6nln8EOD3Yt99
         40QvEnE1xZFxwpCko6LV3f8xPW5Lw0RYPeYm5Z8AqvDyUqIGCtR2mtwy6obiVUJZKG3G
         YX+AQmVYMONYyv8UU5l/QWR1fSOAjiMRIeSeAn7x/ZHxUYfTEg6lGK/2aXdBmXoCezxy
         8tsoTvj1qjcEVfaEKixbB6fkmFAmStOPLpjAnhlxMi5gyEe+4jmez4FakUM8Bnbp1j1N
         CrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fpjT7LGURvaHnPeD63JRN66HubRrDYEim016IoZqmxA=;
        b=Yam7p4jgt4SnLRulz0EaS3vvSZWON3sw0UUMX/CuGLQk5ApacdC5y68ZB+zHb7Yvx2
         e+Gyrc59n4KthkFAr1Lxxt9SJWcqBq6a+/MBV0tUwdm+EuGTXpZ2jxvybpO+dMh6EQ6Z
         ASF8qCRT3cDMtfQf+ExmLPqXiiTIGkW//MKTq39xANF9J7CF+UdXIFi9x0+hEWiQowxt
         52Wl6YH//fE9FZ+vwxVk+cheBk1P4tPjfaQUXDoH9DC0eGRq1ud7zw2etF9mM/8D4tla
         8svPeU5hquZ2Jtcnuc3DdSMKmyX5II1+2kPFyXuWk0kAu6pdFHDMQ2vnGLRaFiWCY3RJ
         cX/w==
X-Gm-Message-State: AOUpUlHDGLZoFlK8hzhZBMHrF/diguwmMQDRM2+WMu1CkaLsn0+fWWdX
        fImuJwX0OMsjxKa8yhx/wyStNMbNowQGlZXPgZxqzQ==
X-Google-Smtp-Source: AAOMgpd46AkoQnaHaW7T9NscUwjy2j8aiTwSdbHfVwlZia64pOiPqIvy9yh8lrbGGCIM2x5/L4PGTXHycvFUf1aEgOo=
X-Received: by 2002:a24:e48c:: with SMTP id o134-v6mr5161662ith.125.1532014540903;
 Thu, 19 Jul 2018 08:35:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 08:35:40
 -0700 (PDT)
In-Reply-To: <20180719123722.sk5fcih6pufy4wpd@mwanda>
References: <20180719082028.26116-1-brgl@bgdev.pl> <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda> <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
 <20180719090929.arbysqo2bk3esoar@mwanda> <CAMRc=Mdu5CLA99p48nNFZBSFHBKiERzp-m59vKDDe5STjjKZNA@mail.gmail.com>
 <20180719123722.sk5fcih6pufy4wpd@mwanda>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 19 Jul 2018 17:35:40 +0200
Message-ID: <CAMRc=MeuoHcnRKc4uP8F5MEripV_w3gT9Eg1LPMRZc479vUHBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] net: add support for nvmem to eth_platform_get_mac_address()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
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

2018-07-19 14:37 GMT+02:00 Dan Carpenter <dan.carpenter@oracle.com>:
> On Thu, Jul 19, 2018 at 12:06:51PM +0200, Bartosz Golaszewski wrote:
>> It looks simpler as long as you don't add all the new routines
>> resulting from this approach. I've just tried to quickly implement
>> this solution and it resulted in much bigger and duplicated code
>> (checking the validity of mac_addr, copying it etc.). I would prefer
>> the current approach and would like to read someone else's opinion on
>> that.
>
> It's not too bad.  There is two extra ether_addr_copy() calls and one
> extra is_valid_ether_addr().  There are two extra alen declarations and
> one extra addr declaration.  The functions don't share *that* much code.
>
> regards,
> dan carpenter
>
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index fd8faa0dfa61..8ab7289a5069 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -54,6 +54,8 @@
>  #include <linux/if_ether.h>
>  #include <linux/of_net.h>
>  #include <linux/pci.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/mtd/mtd.h>
>  #include <net/dst.h>
>  #include <net/arp.h>
>  #include <net/sock.h>
> @@ -525,7 +527,7 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>         return NULL;
>  }
>
> -int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
> +static int of_eth_get_mac_address(struct device *dev, u8 *mac_addr)
>  {
>         const unsigned char *addr;
>         struct device_node *dp;
> @@ -547,4 +549,82 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>         ether_addr_copy(mac_addr, addr);
>         return 0;
>  }
> +
> +static int nvmem_eth_get_mac_address(struct device *dev, u8 *mac_addr)
> +{
> +       struct nvmem_cell *nvmem;
> +       unsigned char *addr;
> +       size_t alen;
> +       int ret = 0;
> +
> +       nvmem = nvmem_cell_get(dev, "mac-address");
> +       if (PTR_ERR(nvmem) == -EPROBE_DEFER)
> +               /* We may have a lookup registered for MAC address but the
> +                * corresponding nvmem provider hasn't been registered yet.
> +                */
> +               return -EPROBE_DEFER;
> +       if (IS_ERR(nvmem))
> +               return PTR_ERR(nvmem);
> +       addr = nvmem_cell_read(nvmem, &alen);
> +       if (IS_ERR(addr)) {
> +               ret = PTR_ERR(addr);
> +               goto put_nvmem;
> +       }
> +       if (alen != ETH_ALEN || !is_valid_ether_addr(addr)) {
> +               ret = -EINVAL;
> +               goto free_addr;
> +       }
> +       ether_addr_copy(mac_addr, addr);
> +free_addr:
> +       kfree(addr);
> +put_nvmem:
> +       nvmem_cell_put(nvmem);
> +       return ret;
> +}
> +
> +static int mtd_eth_get_mac_address(struct device *dev, u8 *mac_addr)
> +{
> +       struct mtd_info *mtd;
> +       u8 addrbuf[ETH_ALEN];
> +       size_t alen;
> +       int ret;
> +
> +       /* This function should go away as soon as MTD gets nvmem support. */
> +       if (!IS_ENABLED(CONFIG_MTD))
> +               return -ENODEV;
> +
> +       mtd = get_mtd_device_nm("MAC-Address");
> +       if (IS_ERR(mtd))
> +               return PTR_ERR(mtd);
> +       ret = mtd_read(mtd, 0, ETH_ALEN, &alen, addrbuf);
> +       if (ret)
> +               goto put_mtd;
> +       if (!is_valid_ether_addr(addrbuf)) {
> +               ret = -EINVAL;
> +               goto put_mtd;
> +       }
> +       ether_addr_copy(mac_addr, addrbuf);
> +put_mtd:
> +       put_mtd_device(mtd);
> +       return ret;
> +}
> +
> +int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
> +{
> +       int ret;
> +
> +       ret = of_eth_get_mac_address(dev, mac_addr);
> +       if (!ret)
> +               return 0;
> +       ret = nvmem_eth_get_mac_address(dev, mac_addr);
> +       if (ret == -EPROBE_DEFER)
> +               return -EPROBE_DEFER;
> +       if (!ret)
> +               return 0;
> +       ret = mtd_eth_get_mac_address(dev, mac_addr);
> +       if (!ret)
> +               return 0;
> +
> +       return -ENODEV;
> +}
>  EXPORT_SYMBOL(eth_platform_get_mac_address);

Please take a look at v3 - I did it a bit differently but the idea is the same.

Bart
