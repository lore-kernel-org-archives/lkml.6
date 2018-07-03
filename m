Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F49C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A4623F2A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI5dOY2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A4623F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932777AbeGCOOw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:14:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43040 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932145AbeGCOOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:14:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so4053468oib.10;
        Tue, 03 Jul 2018 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MtV5kLoYkH7+U1cVcQPkdqEyqhnpcOS6rS+a9nFqCxw=;
        b=TI5dOY2vxLpESm976I9ylA8rQDx5TBLPVBNSiWqAwGwy/A0oK8QUFXWYjJuH3SgnpH
         rLAESIkqaU64bFhA8ELRXjOcG/lZBcDmw3+GQ1IdSr6YaZSjBhj6bE38f8sZ5dd9qsb8
         1pudF4FgKOmtRLhBO+dRzoDeHO01mYxGjGfgACC4+wao0iMhP9yHrkJw0d8hFEp0U7BM
         tzNQ3DVhaHRWKxl15K6cLh93snCBi3E3i/Lq75sho+fTc6xxCx/eOvdrj1QolaI86pHy
         2ZkTO9r2T6EWoLAsN8oltPZWDNuUVUlhMzdt6XMJIXy4tX9rL6iTzbYRT5xqfusId+d4
         jHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MtV5kLoYkH7+U1cVcQPkdqEyqhnpcOS6rS+a9nFqCxw=;
        b=IZDP0XMGD7p9rRyRuGUeQBbJT8f+d5xNIN6kQhCT4dNHV6glly/MLTlDbMgWMlRmTx
         eKzWGP+nrpAusXe/kRkyA1S1VC6Y2U7GzSBRaZIu+r/zHKc0yRIBY18rjIGGeUi0f5Fz
         THZzzjHEdQdySkuxiIhyiWDO8j0MkWIV9poXdvCGo88aU3JfGXg7e81yAygiEAM8z9JB
         pzjbxxyWhlPDKkNP8u6FC2MSXTVK7M76F6RqDI8yxwKUl95/pU1mN8vTl79BIzKoFXPN
         AjTdkKoWmfQAqgfpYnc87w0QdfA6qdEd5DV3y5iGKaIJht1kCpkGhyHD9h9xpEzNAH6J
         VgeA==
X-Gm-Message-State: APt69E3bIsESd+R+QGWFrdvJNbxLNwJbnJW507PCYtFJnfVJeQrOMEH7
        E1e3ygqNGKwN4zcz/FVq7k11W4TaDNOivx9cmxM=
X-Google-Smtp-Source: AAOMgpclft4pRke3qdAR/9GhQ+Ef+X0g0bDyGjxAg3uTVAuAiXHM4KOIEvOzK77bRUPbq92zSxP9Y8oSqWRS9Ysa8O4=
X-Received: by 2002:aca:6144:: with SMTP id v65-v6mr22859927oib.147.1530627289702;
 Tue, 03 Jul 2018 07:14:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 07:14:49 -0700 (PDT)
In-Reply-To: <20180703141114.11609-1-marc.zyngier@arm.com>
References: <20180703141114.11609-1-marc.zyngier@arm.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 11:14:49 -0300
Message-ID: <CAOMZO5AhGi97jkkGCm4hOCBmESHd7TeQifNDOXZdO=--9=V9nQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix struct mmc_gpio corruption
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Jul 3, 2018 at 11:11 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> I recently realised that something was amiss with /proc/interrupts
> on my cubietruck:
>
>  51:          0          0     GICv2  41 Level     mv64xxx_i2c
>  59:       1047          0     GICv2 117 Level     eth0
>  66:          2          0  sunxi_pio_edge   1 Edge   XXXXX
>
> where XXXXX has some non-ASCII characters, while I was expecting:
>
>  66:          0          0  sunxi_pio_edge   1 Edge      1c0f000.mmc cd
>
> It turns out that the cd_debounce_delay_ms field was recently to
> struct mmc_gpio, and carefully placed at the one spot where it could
> cause damage: right *after* the zero-sized array that contains the
> associated label. This label ends up being passed to the IRQ
> subsystem, and then overwritten by the cd_debounce_delay_ms field.
>
> Funky!
>
> Let's move that field to a less crowded location.
>
> Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card after card is inserted")
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/mmc/core/slot-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index ef05e0039378..1ccf9dc07395 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -27,8 +27,8 @@ struct mmc_gpio {
>         bool override_cd_active_level;
>         irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
>         char *ro_label;
> -       char cd_label[0];
>         u32 cd_debounce_delay_ms;
> +       char cd_label[0];

Ulf has already applied a fix for this:
https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=fixes&id=60feca8f59a0bbdee9545ab52775cad0171151ff

which is more robust as it will give a gcc error when cd_label gets
moved in the future.
