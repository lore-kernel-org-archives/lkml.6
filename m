Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D788B24053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9ASGwtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D788B24053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753961AbeGENzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:55:44 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42464 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753419AbeGENzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:55:42 -0400
Received: by mail-vk0-f67.google.com with SMTP id t4-v6so4815529vke.9;
        Thu, 05 Jul 2018 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IMgAm8RRKt5FpiGtE9QvEQX6a67nHHjwkq9PW2QUk/4=;
        b=l9ASGwtAGegXibaCftodP5JQt30y7Wk0D3C8+XF0JbM1g5jnNT4N5ijdv70KZ5GjWK
         IpliNR7Qi73VJZwE/8Va1VIqvZjXf1ETwZ1atZ4bSDckppfFQB2oUoR6sRd/Sv/eukE7
         +RBIPK0iXubhRgGMCL1Lj+xU83SS/h2sb50c3W6gzRb583oQ2XNw7mIgzCBgH8gl23eX
         V2tS2SSf7bWAtG/DG7Zk6ic51xyQnBS/HxWSAO6JgwS1PB3d1Q3KxYdw7Ah/DSHy2WXP
         u7W4K/nX2yRTwca5mcFp2K0PqYLctrmwEYFZEJ1afGEPaR2QMF+zRQBCK1n0O4QcGOYf
         +qHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IMgAm8RRKt5FpiGtE9QvEQX6a67nHHjwkq9PW2QUk/4=;
        b=H5ZzwdafIPlP/mMorNAyBAn0rxawPzkbEJWyOAvjUDZK1TIbdKONtOMWuxXIXtlMs3
         KadbljcTgP3nDeh9ebYUTBE1BQovacrj+qD5IbZWxjwMR34Mvb2s9uoHJu5hfz0YRYHv
         Xi3ygDU9ZL59/D/QkQbyyAvDg5hs522BGXC9SrfDxtZjvuiCefDRpHnBzIHzXL72pUeh
         As/E0m3zbzOeWhq3ltV3aH7CjwPW/sOdVljpQJrCR/ZKqZM8kKY8AIq25Wn4Ttg7tuQm
         8TcDOhJTTsJyaYtI6vQEj/0Y79hGuEdmDbYksuu1RwX/Wbqx2oy8YnJ4Xk1/Y5lsW/FF
         EGUA==
X-Gm-Message-State: APt69E2aNLeU3cC9IQkw/YNEJiGNKM96bQrjyhVy+0cYy9ECcxK5pp7o
        VDHa6EEpJnBUB3/eLIIvxdTVOzmfXOEDuRo+vJE=
X-Google-Smtp-Source: AAOMgpdt5kVmHJy8BSdZED80bsbmCH0rhrD2hD+svc9ZDbbctwwiCTT9EKkzjzgcHQ3OSGGYR5YigakV8rUYxurPYF0=
X-Received: by 2002:a1f:820e:: with SMTP id e14-v6mr3357846vkd.187.1530798941264;
 Thu, 05 Jul 2018 06:55:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:55:40 -0700 (PDT)
In-Reply-To: <20180705091018.60524-1-tony@atomide.com>
References: <20180705091018.60524-1-tony@atomide.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Jul 2018 16:55:40 +0300
Message-ID: <CAHp75VfR+hKW4sGifOP_UvCf6dAzM_jmZH-fZA61zjVt31iJtA@mail.gmail.com>
Subject: Re: [PATCHv3 0/5] pinctrl fixes for generic functions and groups
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christ van Willegen <cvwillegen@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 12:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> Here is a resend of fixes for a race issues for generic group and
> functions reported by H. Nikolaus Schaller <hns@goldelico.com>.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I think for ACPI case we would use generic helpers, so this change is
quite useful to not screw up with new stuff.

> Regards,
>
> Tony
>
>
> Changes since v2:
>
> - Added Nikolaus to Cc as Reported-by did not do it
>
> Changes since v1:
>
> - Check if a function or group already exists as suggested by
>   Andy Shevchenko
>
> - Make sure we always have a valid name for functions and groups
>   as suggested by Christ van Willegen
>
> - Prettify rza1 variables as suggested by Jacopo Mondi
>
> Tony Lindgren (5):
>   pinctrl: core: Return selector to the pinctrl driver
>   pinctrl: pinmux: Return selector to the pinctrl driver
>   pinctrl: single: Fix group and function selector use
>   pinctrl: rza1: Fix selector use for groups and functions
>   pinctrl: core: Remove broken remove_last group and pinmux functions
>
>  drivers/pinctrl/core.c           | 35 ++++++++++--
>  drivers/pinctrl/core.h           |  6 ---
>  drivers/pinctrl/pinctrl-rza1.c   | 24 +++++----
>  drivers/pinctrl/pinctrl-single.c | 91 +++++++++++++++++++-------------
>  drivers/pinctrl/pinmux.c         | 16 ++++--
>  drivers/pinctrl/pinmux.h         |  7 ---
>  6 files changed, 112 insertions(+), 67 deletions(-)
>
> --
> 2.17.1



-- 
With Best Regards,
Andy Shevchenko
