Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9E2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A08F20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OknFUT0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A08F20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755268AbeFRJkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:40:32 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:38081 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965662AbeFRIXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:03 -0400
Received: by mail-vk0-f43.google.com with SMTP id b77-v6so9003718vkb.5;
        Mon, 18 Jun 2018 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rbw6qFzddhXd99LjyW8P10WgW6Qg+GLTzMTWA859hE=;
        b=OknFUT0wDsvBuZs5pWQPO1lOfNHiddI2NSlLFBxiznUFz8qMEM01y55Q5v+rHN+h16
         O4DhMYmGxysdyjmwTAYn5F3frQPEIPy9LPdnIXE1Hv3ejiKxf5NwpKCFTvQHIcukkmKI
         KT+HbFQvFOVnKwWeCV8HqpQmysN9B4c8jjzy1KJEE5eeot1e0Q/BfFYTRrjaLcv6fYzF
         zR32cPNVjAonPf5LEQlr3bAVEG2iQiG+yq242cSCb9nFNOyO6cteXw8CuoQrea8J9wgu
         480wt6Uw+rA9HcCFpxRTEMIcrmxxW9n2ZeHd0Vvt/bPEVwsTHOFJCEBZwJFFahWwu/XN
         bfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rbw6qFzddhXd99LjyW8P10WgW6Qg+GLTzMTWA859hE=;
        b=QYekLhIrBMJ6Xus4XoXEg0kzEKkA+q8izQ8Xvzt35OAzb1WtVave6p/EPcrPWv8XMv
         pMCu949SK5HXwv6BpDs/kSN6tYGzncrVs1ALqldr4xhsuYoQTODEaTH89eS+ct1Ek2CS
         ypP2Q7EsmL5Ri8TVpeMSgx/tv7BcqO580NnUeVjMUgn3Gwi0PWZLn+FRu5qZpHxj9rDN
         aQ5hDn6A8rojRaecUz6iUzs9OEk/PmBGkwTgKYNGv9yspoz6aKywFj2XW74f+i84GcMk
         pK/D7xQ5YtF1AEsrjnYcqFAvEKGLCKfWfS0QmvJFBhIE73yuw96E2WPXBKnGvJFfCq8c
         KEdg==
X-Gm-Message-State: APt69E0OmOa2yfrw+s8BK3KCxRSPaEC0vKSxxh1ZZrKn9rNuVFqjrdL/
        jtNTDVvJXDsNpFwEkhovTWie/p7DJ6iKtE6RXozyTzF6
X-Google-Smtp-Source: ADUXVKLqytsoW9Wf70iEcLvP2EK1LTODQWZzRebc18yVZjn121Gn/o0XXzznCdPZb3Th1SC4VIPR5CCHOWdY0dpK6E8=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr6464695vkd.15.1529310182715;
 Mon, 18 Jun 2018 01:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <F20BD6B3-D4D7-4D5D-B464-64402650BDE5@goldelico.com>
 <20180614120157.GE112168@atomide.com> <FC373DE9-6D6B-40C5-ACED-C07B1B524469@goldelico.com>
 <20180615065810.GI112168@atomide.com> <20180615111318.GJ112168@atomide.com>
 <029F115C-480E-485A-B547-9D5873925CEF@goldelico.com> <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com>
In-Reply-To: <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jun 2018 11:22:50 +0300
Message-ID: <CAHp75Vf7-xcsoSJ--9nJYbxpwSfDv201UwnxJHoFbwtD187SPw@mail.gmail.com>
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in pinctrl_groups
 and deferred probing
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 2:08 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> [    0.739501] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_hsusb2_pins selector=0
> [    0.741638] pinctrl_generic_add_group: pctldev=ee481f80 name=pinmux_hsusb2_2_pins selector=0
> [    0.742401] pinctrl_generic_add_group: pctldev=ee481e00 name=pinmux_mcbsp1_devconf0_pins selector=0
> [    0.743072] pinctrl_generic_add_group: pctldev=ee481d00 name=pinmux_tv_acbias_devconf1_pins selector=0
> [    0.760437] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_uart1_pins selector=1
> [    0.762268] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_uart2_pins selector=2
> [    0.763610] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_uart3_pins selector=3
> [    1.790527] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_twl4030_pins selector=4
> [    1.799835] pinctrl_generic_add_group: pctldev=ee3cd000 name=pinmux_twl4030_vpins selector=0
> [    1.969635] pinctrl_generic_add_group: pctldev=ee481f80 name=spi_gpio_pinmux selector=1
> [    2.164093] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_mmc1_pins selector=5
> [    2.198242] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_wlan_irq_pin selector=6
> [    2.374328] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_gpmc_pins selector=7
> [    2.769989] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_wlan_pins selector=8
> [    2.785888] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_bt_pins selector=9
> [    2.802154] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_wlan_irq_pin selector=10
> [    5.415222] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_dss_dpi_pins selector=11
> [    6.080566] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_mcbsp1_pins selector=12
> [    6.182617] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_mcbsp2_pins selector=13
> [    6.271240] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_mcbsp3_pins selector=14
> [    6.330718] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_penirq_pins selector=15
> [    6.368927] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_mcbsp4_pins selector=16
> [    6.616546] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=17
> [    6.835418] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=18
> [    6.874694] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=19
> [    6.900299] pinctrl_generic_add_group: pctldev=ee3cd180 name=hdq_pins selector=20
> [    6.937042] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=21
> [    7.062744] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=22
> [    7.108032] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=23
> [    7.145080] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=24
> [    7.197723] pinctrl_generic_add_group: pctldev=ee3cd180 name=backlight_pins_pinmux selector=25
> [    7.427398] pinctrl_generic_add_group: pctldev=ee3cd180 name=modem_pins selector=26
> [    7.476562] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=27
> [    7.505981] pinctrl_generic_add_group: pctldev=ee3cd180 name=backlight_pins_pinmux selector=28
> [    7.564910] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=29
> [    7.894439] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=30
> [    8.207489] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=31
> [    8.311096] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_pps_pins selector=32
> [    8.340667] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=33
> [    8.414428] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=34
> [    9.231445] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=35
> [    9.446716] pinctrl_generic_add_group: pctldev=ee3cd180 name=pinmux_camera_pins selector=36
> root@letux:~#
>
> But it looks as if we still have duplicate assignments by deferred probing, i.e. some cleanup is
> missing (or is this intended behaviour?).

> But I think the fundamental problem is that the same driver assigns multiple slots if
> probing is deferred.

Indeed.

I think there is a simple way to clean up pinctrl stuff on failed probe. See
https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/base/dd.c#L416

We only bind pins, and do not perform any actions when failure happens later on.

> 3.  I could not observe calls to pinctrl_generic_remove_group()
> 4.  this means a stale pointer to the group_desc is still stored in the radix tree
>     if driver probing fails

Exactly.

-- 
With Best Regards,
Andy Shevchenko
