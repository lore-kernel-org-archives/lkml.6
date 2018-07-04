Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B410C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E5E2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="o+2A+oT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E5E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934087AbeGDI3x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:29:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35430 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbeGDI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:29:50 -0400
Received: by mail-it0-f65.google.com with SMTP id l16-v6so6927665ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RqlYNwQPbWsN+a2zdho9WzVTcZhRYcPWPoJPELxN0og=;
        b=o+2A+oT6HXRaj/iaaAkfGqe3XnCf4vA+42E1PEJg2Dbym2XUZcvqW97kHIwVgs5W+y
         yvCyptLdCcv5t3OT+dVA/MXsdOkoMO1VQqNt9Dt2gaYZKl7MuqpZYoQzp3CWnEpWh42T
         IT4MI8ChQ8VsRw/Xd7zwrV9naH65mdVp6qrYgkqP4NzqB3GjamknVVS7CBHk7g547Qw1
         JugaESAJucqkHCu2GJKYEgpQ++XHnbFc4OS3gzyumK72cqL2W67guOvmJBEcg/wbOFuM
         /9K++STuwpXq2TVv5g2wWLoiqd15kzfkwmKwW1A8lUHDYSi8/6u30XjTtKBO4GVpeg91
         akzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RqlYNwQPbWsN+a2zdho9WzVTcZhRYcPWPoJPELxN0og=;
        b=ZXlDLiLWI4j6qqon0+8sS86xWj2xD6D5XQrbXTA2ZiTiu4OuVYIjSj1ZmtANpS6Hau
         O1rYfkE83ZJXhNHGHSdTEL9a6/rzd68EACdTFIKIl4OK2WIo2MKTQj64XBF5Clv5fq2/
         253WnhLOAIf+XEhCfu+W5QTu9KXlOO0qXsIGSDE9AsIoVBSAab39vOy40/DDwrcbdJtw
         yrs8gm6VBBvu869c4xhMyHu8ILnR5/GyNoPVJVjvhynuMgD20Vcw0aQqSqeHpA0naqen
         4hqu6lxjTRgqYwxnoLWT4Z+fHsvf1o6CCTsA2sq0Ba3BFqa4MDBFiR75cixNszNg836/
         relQ==
X-Gm-Message-State: APt69E1ulcSzkyQC9tB8yHK6sYeXcRGwsDgNbZ/3arSWrWnxNomRN+Tq
        S8MQIdMP5kQStJlg45t0OUxTRmOCtR3wEmYXK7r41g==
X-Google-Smtp-Source: AAOMgpdRgojc3iDiyeb5lUt20jIm400Ljbnlbf9jTz0XY16zvtJEEEvxYAPKA64swJdKMJZywGXrXc9EyRjz11hLUTI=
X-Received: by 2002:a02:b70b:: with SMTP id g11-v6mr831526jam.34.1530692989510;
 Wed, 04 Jul 2018 01:29:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 01:29:48 -0700 (PDT)
In-Reply-To: <20180704070919.GA14051@lenoch>
References: <20180629094039.7543-1-brgl@bgdev.pl> <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com> <20180704070919.GA14051@lenoch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 4 Jul 2018 10:29:48 +0200
Message-ID: <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-04 9:09 GMT+02:00 Ladislav Michl <ladis@linux-mips.org>:
> On Tue, Jul 03, 2018 at 09:39:51AM -0700, Florian Fainelli wrote:
>>
>>
>> On 06/29/2018 02:40 AM, Bartosz Golaszewski wrote:
>> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> >
>> > On da850-evm board we can read the MAC address from MTD. It's currently
>> > done in the relevant board file, but we want to get rid of all the MAC
>> > reading callbacks from the board file (SPI and NAND). Move the reading
>> > of the MAC address from SPI to the emac driver's probe function.
>>
>> This should be made something generic to all drivers, not just something
>> the davinci_emac driver does, something like this actually:
>>
>> https://lkml.org/lkml/2018/3/24/312
>
> ...and that's would also make it work when MAC address is stored
> in 24c08 EEPROM, which is quite common.
>

This is what the second patch for davinci_emac in this series does. I
agree that this should become more generic at some point - we should
probably have a routine somewhere in net that would try to get the MAC
address from all possible sources (nvmem, of etc.). This is somewhat
related to the work I want to do on nvmem to make the at24 setup()
callback more generic.

Unfortunately we don't have it yet and I will not have time to work on
it before v4.20 so if there are no serious objections, I'd like to get
this series merged for v4.19 and then we can refactor the MAC reading
later.

How does it sound?

Best regards,
Bartosz Golaszewski

>> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> > ---
>> >  drivers/net/ethernet/ti/davinci_emac.c | 20 ++++++++++++++++++--
>> >  1 file changed, 18 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
>> > index a1a6445b5a7e..48e6a7755811 100644
>> > --- a/drivers/net/ethernet/ti/davinci_emac.c
>> > +++ b/drivers/net/ethernet/ti/davinci_emac.c
>> > @@ -67,7 +67,7 @@
>> >  #include <linux/of_irq.h>
>> >  #include <linux/of_net.h>
>> >  #include <linux/mfd/syscon.h>
>> > -
>> > +#include <linux/mtd/mtd.h>
>> >  #include <asm/irq.h>
>> >  #include <asm/page.h>
>> >
>> > @@ -1783,7 +1783,10 @@ static int davinci_emac_probe(struct platform_device *pdev)
>> >     struct cpdma_params dma_params;
>> >     struct clk *emac_clk;
>> >     unsigned long emac_bus_frequency;
>> > -
>> > +#ifdef CONFIG_MTD
>> > +   size_t mac_addr_len;
>> > +   struct mtd_info *mtd;
>> > +#endif /* CONFIG_MTD */
>> >
>> >     /* obtain emac clock from kernel */
>> >     emac_clk = devm_clk_get(&pdev->dev, NULL);
>> > @@ -1815,6 +1818,19 @@ static int davinci_emac_probe(struct platform_device *pdev)
>> >             goto err_free_netdev;
>> >     }
>> >
>> > +#ifdef CONFIG_MTD
>> > +   mtd = get_mtd_device_nm("MAC-Address");
>> > +   if (!IS_ERR(mtd)) {
>> > +           rc = mtd_read(mtd, 0, ETH_ALEN,
>> > +                         &mac_addr_len, priv->mac_addr);
>> > +           if (rc == 0)
>> > +                   dev_info(&pdev->dev,
>> > +                            "Read MAC addr from SPI Flash: %pM\n",
>> > +                            priv->mac_addr);
>> > +           put_mtd_device(mtd);
>> > +   }
>> > +#endif /* CONFIG_MTD */
>> > +
>> >     /* MAC addr and PHY mask , RMII enable info from platform_data */
>> >     memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
>> >     priv->phy_id = pdata->phy_id;
>> >
>>
>> --
>> Florian
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
