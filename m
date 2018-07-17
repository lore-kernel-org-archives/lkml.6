Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDE7C468C6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0A82075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOX2W2e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0A82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeGQWEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:04:46 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32887 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbeGQWEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:04:46 -0400
Received: by mail-vk0-f68.google.com with SMTP id y70-v6so1397965vkc.0;
        Tue, 17 Jul 2018 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ePT1hv7iWzZgRWhg3eMMNq4TEXwmNCubXlnVUnxU2Rw=;
        b=jOX2W2e4jw/ObrtQAgG9qdFfL9e3OpQoXMNlhGKopzGB4pg9I2C8Ew2giWyBzuj1cf
         4uSkc7IM9xqLgccC+JwjZfXXzOEZK1S7sO3kzV+P0o3oJluDwz+/ZY50xDFkUe6aT/fU
         D4wtBetW2bNfMYG1RP0uysbRtniakTnwf7P8bPOf8qjYlSABE4MLIPcC23F3y/rF1z8p
         RQ55U2zl5kj9bfORAbtaHekTkKAGWrwoYZglTD/kbpjBGRKXv5ytO78WScPfpuPa/8Oq
         3NDIHjaJYttBe85dGpxxabPfdehhPpO5/g79uT7/bMGG1J7reLXG1rGnR6HlVZDML1V9
         tU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ePT1hv7iWzZgRWhg3eMMNq4TEXwmNCubXlnVUnxU2Rw=;
        b=W3MOwlwMqPRqK2jZONKLDvNm6aDOdC7BLU2faSRnXH6osf425Y7yIr9KmbuR5uWEsN
         /0XQiyNU/mCopCDqpOUPM24Hlae+wQMzCdXqs62rL178qTCZShkHNI7Dcud3oo8KiZCq
         amgx8RlpRUKQDuTLW2F9l61bNRMk7DfRe1SNkL1GQZeMB9oq8pWgftmEKNiss/QE8t+Y
         RtwGWqigI50yDvL9vlKiNfBSkci4dJ4NsN0bePPLkpcWhnOei6Ak9+z3M7s70osGZCQ3
         h1oyLPYANJhflJ23zV+uhillYTkvxgOTs0XwHv76fv4hZiO5LW0tcA5QgMJG8lPJPkAG
         pUTQ==
X-Gm-Message-State: AOUpUlEbA7Xn7r5nMHtOT58VICNziWJnslNiADUSEWOnEXPnd8Cc+Nr7
        zxRLp3Ixem28p8uHFl25JrSC7EXHW5xxbN7hY0g=
X-Google-Smtp-Source: AAOMgpds2pqSKsUp0uht1mnLgHHkYkAQg67SgI7J1wRAVZs92pUiZFX26Kyq0UrjjZOD+r/wTgCIBzIKoZEnCM3w6rA=
X-Received: by 2002:a1f:8e4d:: with SMTP id q74-v6mr2029446vkd.161.1531863011909;
 Tue, 17 Jul 2018 14:30:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 14:30:11
 -0700 (PDT)
In-Reply-To: <20180717142314.32337-2-alexandre.belloni@bootlin.com>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com> <20180717142314.32337-2-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 00:30:11 +0300
Message-ID: <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> It is possible to get an interrupt as soon as it is requested.  dw_spi_irq
> does spi_controller_get_devdata(master) and expects it to be different than
> NULL. However, spi_controller_set_devdata() is called after request_irq(),
> resulting in the following crash:
>
> CPU 0 Unable to handle kernel paging request at virtual address 00000030, epc == 8058e09c, ra == 8018ff90
> [...]
> Call Trace:
> [<8058e09c>] dw_spi_irq+0x8/0x64
> [<8018ff90>] __handle_irq_event_percpu+0x70/0x1d4
> [<80190128>] handle_irq_event_percpu+0x34/0x8c
> [<801901c4>] handle_irq_event+0x44/0x80
> [<801951a8>] handle_level_irq+0xdc/0x194
> [<8018f580>] generic_handle_irq+0x38/0x50
> [<804c6924>] ocelot_irq_handler+0x104/0x1c0
> [<8018f580>] generic_handle_irq+0x38/0x50
> [<8075c1d8>] do_IRQ+0x18/0x24
> [<804c4714>] plat_irq_dispatch+0xa4/0x150
> [<80106ba8>] except_vec_vi_end+0xb8/0xc4
> [<8075ba5c>] _raw_spin_unlock_irqrestore+0x14/0x20
> [<801926c8>] __setup_irq+0x53c/0x8e0
> [<80192e28>] request_threaded_irq+0xf4/0x1e8
> [<8058ed18>] dw_spi_add_host+0x264/0x2c4
> [<8058f2ec>] dw_spi_mmio_probe+0x258/0x27c
> [<8051f4a4>] platform_drv_probe+0x58/0xbc
> [<8051daa8>] driver_probe_device+0x308/0x40c
> [<8051dc9c>] __driver_attach+0xf0/0xf8
> [<8051b698>] bus_for_each_dev+0x78/0xcc
> [<8051c2c0>] bus_add_driver+0x1b4/0x228
> [<8051e840>] driver_register+0x84/0x154
> [<801001d8>] do_one_initcall+0x54/0x1ac
> [<80880e90>] kernel_init_freeable+0x1ec/0x2ac
> [<80755310>] kernel_init+0x14/0x110
> [<80106698>] ret_from_kernel_thread+0x14/0x1c
> Code: 00000000  8ca40050  8c820008 <8c420030> 0000000f  3042003f  10400007  00000000  8ca20230
>

Good catch!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/spi/spi-dw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index f693bfe95ab9..a087464efdd7 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -485,6 +485,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>         dws->dma_inited = 0;
>         dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
>
> +       spi_controller_set_devdata(master, dws);
> +
>         ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
>                           master);
>         if (ret < 0) {
> @@ -518,7 +520,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>                 }
>         }
>
> -       spi_controller_set_devdata(master, dws);
>         ret = devm_spi_register_controller(dev, master);
>         if (ret) {
>                 dev_err(&master->dev, "problem registering spi master\n");
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
