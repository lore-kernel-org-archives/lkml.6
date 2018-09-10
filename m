Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA7F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW/yTjGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA7F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeIJVzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:55:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37354 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbeIJVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:55:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so18011688lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5BKtTLrTCHfcmFaAzlx61dPaZ6ZBXaTF5ZmiyXBuLU=;
        b=DW/yTjGeX23LXavqa/G/1u7E2B1wld+YVDgWkRtya3hfFLlu5tU/jzCrhGrM+8OFIq
         S740x3jAw5X1Ew5owDkR7bsH7DsH/OqIppm1arAUyqQYuAtdjpRSL4LWcAWgLVcwH60d
         ADY/S43QveDduzFwOxLRKlUbo6XLBPtepwOg+vgMHkkW+HeaQhdHYN2pe1joX5f2Fm8W
         nbxQdnTgWOqlY6agf0cz4EMn13L6I5Ll1mc4xiFxHHrYSsiTi82wR5EbBZIkHtJaTR5e
         gJxEr1chdab6KhIUE5H5OVhzlmgBK5n8DIQGHmm61awuiJf6BK8xUugtPkJf52IQbJVw
         yZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5BKtTLrTCHfcmFaAzlx61dPaZ6ZBXaTF5ZmiyXBuLU=;
        b=LX9kPotlOamoAYM6yeefkXKLA3DbaKlRYJJnp52CMOx9U9GacACOKLgsOiZjl+2GGE
         pYeLSMxrSEQbh2VMBD0fOPEZ6viVap18jj7FLjOedBKANbFjV9crw7PJLaYaTFUtYjGf
         Ql+iCouKSY8OIMzuvBw0EeSzZBwd9xwlW6+amTDxdEofE06wnVZ6cTDYBDCgKW/y/WT2
         Qyn/P1Kd/OvchUD0rkE2pY2gAgjjioO3oqYO/mwsmQce6v9H4Z1DTyxgTYxDI9MK6DWu
         JVdZ6K8kdOnjMe6nr3g77SHNFMRtQwDc21wSpmGn50Dst3pe+ErxMcoEOgoXX0UvvB/P
         3sQw==
X-Gm-Message-State: APzg51CBj13+f0LT5DVBZ7pMKbYlb/5IBY06CM2nVsTeCF0AXLMCZqAp
        DAgVxTwGdGSKPrj7w5+M2us=
X-Google-Smtp-Source: ANB0Vdb6nQaqtUAFaDdmmXOknSnbfivCIeZYKHOmhC9RCB3htp/GQROLFxw+Gp2AQfCqh/LBrUWSZg==
X-Received: by 2002:a19:e307:: with SMTP id a7-v6mr12882831lfh.125.1536598812948;
        Mon, 10 Sep 2018 10:00:12 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id e30-v6sm2873404ljb.86.2018.09.10.10.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 10:00:11 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
Date:   Mon, 10 Sep 2018 19:01:31 +0200
Message-ID: <2015775.cKlHUi0ia0@z50>
In-Reply-To: <20180906122436.25610-1-linus.walleij@linaro.org>
References: <20180906122436.25610-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thursday, September 6, 2018 2:24:36 PM CEST Linus Walleij wrote:
> As we augmented the regulator core to accept a GPIO descriptor instead
> of a GPIO number, we can augment the fixed GPIO regulator to look up
> and pass that descriptor directly from device tree or board GPIO
> descriptor look up tables.
> 
> Some boards just auto-enumerate their fixed regulator platform devices
> and I have assumed they get names like "fixed-regulator.0" but it's
> pretty hard to guess this. I need some testing from board maintainers to
> be sure. Other boards are straight forward, using just plain
> "fixed-regulator" (ID -1) or "fixed-regulator.1" hammering down the
> device ID.
> 
> It seems the da9055 and da9211 has never got around to actually passing
> any enable gpio into its platform data (not the in-tree code anyway) so we
> can just decide to simply pass a descriptor instead.
> 
> The fixed GPIO-controlled regulator in mach-pxa/ezx.c was confusingly named
> "*_dummy_supply_device" while it is a very real device backed by a GPIO
> line. There is nothing dummy about it at all, so I renamed it with the
> infix *_regulator_* as part of this patch set.
> 
> Intel MID portions tested by Andy.
> 
> Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com> # OMAP1
> Cc: Alexander Shiyan <shc_work@mail.ru> # i.MX boards user
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com> # MMP2 maintainer
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi> # OMAP1 maintainer
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com> # EM-X270 maintainer
> Cc: Robert Jarzmik <robert.jarzmik@free.fr> # EZX maintainer
> Cc: Philipp Zabel <philipp.zabel@gmail.com> # Magician maintainer
> Cc: Daniel Mack <zonque@gmail.com> # Raumfeld maintainer
> Cc: Marc Zyngier <marc.zyngier@arm.com> # Zeus maintainer
> Cc: Jacopo Mondi <jacopo@jmondi.org> # SH Ecovec24
> Cc: Geert Uytterhoeven <geert+renesas@glider.be> # SuperH pinctrl/GPIO maintainer
> Cc: Russell King <rmk+kernel@armlinux.org.uk> # SA1100
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # Check the x86 BCM stuff
> Acked-by: Tony Lindgren <tony@atomide.com> # OMAP1,2,3 maintainer
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v6->v7:
> - As the autobuilder churned along, after 24+ hours it was testing
>   SH and found a bug in the ecovec24 boardfile. It does test a
>   SH arch byt default, sh7763rdp_defconfig, sadly not this one.
>   So it discovers more obscure boards in later testing.
> - Shaked out this bug too and re-pushed and posted.
> ChangeLog v5->v6:
> - New code appeared in the OMAP1 AMS delta board that added a
>   new user of the removed .gpio member. The build robot was first
>   happy, then came back later and was not happy.
> - Fixed up the offending .gpio, now rebuilt for this OMAP1
>   board specifically to make sure it really really work now.
> ChangeLog v4->v5:
> - Rebased on v4.19-rc1
> - Put the OMAP1 AMD delta GPIO table addition in the *TOP*
>   of the ams_delta_gpio_tables[] so Janusz can add any
>   new addtions on the *BOTTOM*
> - Hopefully we can merge this now.
> ChangeLog v3->v4:
> - Rebase and adapt the OMAP1 changes for the GPIO descriptor
>   look-up tables deployed by Janusz.
> - Add two calls to add the GPIO descriptor tables properly on
>   the Super-H Ecovec24 board as pointed out by Geert.
> - Go over all patches to board files and make sure we pass
>   a NULL descriptor instead of an "enable" descriptor. The code
>   is looking for unnamed GPIOs as the device tree also just pass
>   gpio[s] = <&foo> so board files also need to use anonymous
>   GPIOs.
> - Fold in an EZX fix from Arnd Bergmann.
> - Add Andy's Tested-by tag.
> - Send this patch *ALONE* as I realized I need to take smaller
>   steps so things do not blow up left and right.
> ChangeLog v2->v3:
> - Resending.
> ChangeLog v1->v2:
> - Rebase the patch on mainline with Blackfin gone and other changes.
> - Fix up the new users that appeared in sa1100
> - Drop some suplus comments in x86.
> ---
>  arch/arm/mach-imx/mach-mx21ads.c              | 12 ++++++-
>  arch/arm/mach-imx/mach-mx27ads.c              | 12 ++++++-
>  arch/arm/mach-mmp/brownstone.c                | 12 ++++++-
>  arch/arm/mach-omap1/board-ams-delta.c         | 12 +++++--
>  arch/arm/mach-omap2/pdata-quirks.c            | 16 ++++++++-
>  arch/arm/mach-pxa/em-x270.c                   |  1 -
>  arch/arm/mach-pxa/ezx.c                       | 33 ++++++++++++-------
>  arch/arm/mach-pxa/magician.c                  |  2 +-
>  arch/arm/mach-pxa/raumfeld.c                  | 12 +++++--
>  arch/arm/mach-pxa/zeus.c                      | 23 +++++++++++--
>  arch/arm/mach-s3c64xx/mach-crag6410.c         |  1 -
>  arch/arm/mach-s3c64xx/mach-smdk6410.c         |  1 -
>  arch/arm/mach-sa1100/assabet.c                | 21 ++++++++----
>  arch/arm/mach-sa1100/generic.c                |  5 +--
>  arch/arm/mach-sa1100/generic.h                |  3 +-
>  arch/arm/mach-sa1100/shannon.c                |  4 +--
>  arch/sh/boards/mach-ecovec24/setup.c          | 27 +++++++++++++--
>  .../intel-mid/device_libs/platform_bcm43xx.c  | 17 ++++++++--
>  drivers/regulator/fixed-helper.c              |  1 -
>  drivers/regulator/fixed.c                     | 33 +++++++++----------
>  include/linux/regulator/fixed.h               |  3 --
>  21 files changed, 188 insertions(+), 63 deletions(-)

For arch/arm/mach-omap1/board-ams-delta.c:
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks,
Janusz



