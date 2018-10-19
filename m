Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514BFECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172B721476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVDKPwkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172B721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJSVnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:43:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36631 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeJSVnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:43:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id u34-v6so38253486qth.3;
        Fri, 19 Oct 2018 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpM5xXLW29RSoZzLA8S0G2+850bYM/4wxXlGzx7dsgM=;
        b=nVDKPwkW/4F51QY7uX4XeF56szuOPqCw429OazPfwej47MAUjU8OlN/GGny1kIQY2t
         u6Yl+GYzovV3Gv4I+5ziwM/optbKyqMeiNpcJchmgEmcpwadOlCSicNL7c3j1TNg/sHu
         sMLprRs99FrgoSM/LAR8DjoRJ8TwXCEH/Xt766hNl8rjMx0Ac+tPaGBqAPkzDUByplTS
         dEIjjPfzmcf3PJfIBWPBlZfgFGocktaerK4kZFulMVqngus0mYuAh47y5m6xnHF1VG78
         egLkm8NX9fdwaHCPBkypllCxzF8FIcx6TrkTeHrq1Tg+EAFmwDyLK89WFlNM+2fQvJkH
         LtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpM5xXLW29RSoZzLA8S0G2+850bYM/4wxXlGzx7dsgM=;
        b=NrOGFJM1c9xQB8V8f7xyME7JZdNsGPXGVmXrgB/XvNhWmlaIjhxPxmATgvwPDxgb2t
         QRDaRtSIfLFO7/TUv77+WRRJiav4f2JhGil9xwyJp5uFDazg+upH1nDAy9qBOXi9mMWK
         U7GnKznQ+61eCNQGqeOX6GGJQXFoUQT+wa/q71caeXJpeiqAYlWQcqFSbojmLKhjqOj8
         B+LzmCQFC2W0LMsQh33HX+fh4qE7N181NvFqw1wOnRQfoKrfVZAqxI9JY2jqnK8ZHy5G
         rLlFsqtSMKxueB/TTUm3qow+A6Q7OXIhqfVHKfkQK2oZm6SnwtQjAu0CPUQ1mowRtBjc
         f/0A==
X-Gm-Message-State: ABuFfoj3E5Yt8NaVmCkeY74E3rWfv5IvwIhOJZvIob5/mCbab9EucKiD
        ijqPRfq8Ttx5Y72Bhix1cVhWpRHvGJxLVnf/Za0=
X-Google-Smtp-Source: ACcGV63ErgqgNl1kCNt88A9JJ0eB8onYoGVhFWjFgNcNXC9kONq9ky2FYt9Mwiy0txuApZYhcPIt93y7t1PQ0mn409U=
X-Received: by 2002:ac8:6784:: with SMTP id b4-v6mr33542907qtp.373.1539956209650;
 Fri, 19 Oct 2018 06:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-9-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-9-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:36:38 +0300
Message-ID: <CAHp75VfVYUyurEkrCuRsuC_jk94e3CqsxPket+DZqNk0VNMPFA@mail.gmail.com>
Subject: Re: [PATCH 08/15] Platform: OLPC: Move EC-specific functionality out
 from x86
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:24 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> It is actually plaform independent. Move it to the olpc-ec driver from
> the X86 OLPC platform, so that it could be used by the ARM based laptops
> too.

What is platform independent exactly?

>  #define OLPC_F_PRESENT         0x01
>  #define OLPC_F_DCON            0x02
> -#define OLPC_F_EC_WIDE_SCI     0x04

I think these lines grouped on purpose. Thus, I don't like this.
Either move either all or none.

> +int olpc_ec_mask_write(u16 bits)
> +{
>  #ifdef CONFIG_DEBUG_FS
>
>  /*
> @@ -277,14 +369,17 @@ static int olpc_ec_probe(struct platform_device *pdev)
>         ec_priv = ec;
>         platform_set_drvdata(pdev, ec);
>

> +       /* EC version 0x5f adds support for wide SCI mask */
> +       if (ec->version >= 0x5f) {
> +               __be16 ec_word = cpu_to_be16(bits);
> +

> +               return olpc_ec_cmd(EC_WRITE_EXT_SCI_MASK, (void *) &ec_word, 2,
> +                                  NULL, 0);

I would leave it on one line.

> +       } else {

> +               unsigned char ec_byte = bits & 0xff;

You may noticed that the parameter is of type u8, which clearly makes
& 0xff part redundant.

> +               return olpc_ec_cmd(EC_WRITE_SCI_MASK, &ec_byte, 1, NULL, 0);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(olpc_ec_mask_write);

I see that the above is inherited from older code, so, no need to
address those comments in here, but consider a follow up fix.


> +int olpc_ec_sci_query(u16 *sci_value)
> +{

> +}
> +EXPORT_SYMBOL_GPL(olpc_ec_sci_query);

Similar comments are applied here.

> +
> -       err = ec_driver->probe ? ec_driver->probe(pdev) : 0;
> +       /* get the EC revision */
> +       err = olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0,
> +               (unsigned char *) &ec->version, 1);

Perhaps version should be defined as u8.

> +/* SCI source values */
> +#define EC_SCI_SRC_EMPTY        0x00
> +#define EC_SCI_SRC_GAME         0x01
> +#define EC_SCI_SRC_BATTERY      0x02
> +#define EC_SCI_SRC_BATSOC       0x04
> +#define EC_SCI_SRC_BATERR       0x08
> +#define EC_SCI_SRC_EBOOK        0x10    /* XO-1 only */
> +#define EC_SCI_SRC_WLAN         0x20    /* XO-1 only */
> +#define EC_SCI_SRC_ACPWR        0x40
> +#define EC_SCI_SRC_BATCRIT      0x80
> +#define EC_SCI_SRC_GPWAKE       0x100   /* XO-1.5 only */

BIT() ?

> +#define EC_SCI_SRC_ALL          0x1FF

GENMASK()?

-- 
With Best Regards,
Andy Shevchenko
