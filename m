Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BD9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77D025D0D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U56n9zGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77D025D0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030724AbeGBLmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:42:43 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52787 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030707AbeGBLmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:42:38 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so11680227itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=saIqLOPvwRJWVTv55+gmP2/Kn7dzHTktH2Bg8CKQkmQ=;
        b=U56n9zGSINQfDgMYIA1evHoTL4tKoRhy8znCvZZ+jIogbVNkc7SEpnemQ/Oni7zUW0
         Xvjox1snpDMAnCDDaiRk66h/4zx7Zyt9kz5TOQ+MonjB4Y1Z0i/YU/kFOF11C0sq2sck
         ueo/hMwyoza525t0q8dyrbKYLtk3QnILx1UMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=saIqLOPvwRJWVTv55+gmP2/Kn7dzHTktH2Bg8CKQkmQ=;
        b=m1dccD/WjlRhQtipkHWRe/93bHU1aA+glDCdFakvY9vfblIhiLS3cDKG97GqDHbhZo
         KeZFLUwOhF/NC0DfHWm+YZ3gF+Y5PymjtbcEwdcCqre7BNJNKAlC+MSlLJbAVk3bWunt
         hhYFEQBNhCA03y8ODtSGOskAaoM/noGwbKYQUeTaeXPycv5FEOqW5vw/Evz1aT4LRM/3
         QVigPbI0OtkBQfXaodLvOJ2JlBP2LSk+J8cLG4xJOttNBb52x7FLaT9ila2H9D8ySutt
         NNzBAqcCB8X5C/kUTTPtca1VFlg0++oyOeSBUk2WxlHQQ9JxdtSzIIH2ulrswRkJpkqa
         ePKA==
X-Gm-Message-State: APt69E0G9tsJ6ZAkxwEDwelSF4zf3NmU4+WC2FkeLve2nePWa4G7u5eK
        JNWOtPSw69R1xVc+0LKm1TtI2ku5vnZXQhx9icHNSg==
X-Google-Smtp-Source: AAOMgpdh5IZdaWK3qYGicLwXvkDUrJdkAlSdBwE5AjE3QlWw/H1+wCIh9tlCuiEiEY6OHzZsS4BbeI/FnK3ZP1WmeNQ=
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr5240612itf.70.1530531757933;
 Mon, 02 Jul 2018 04:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Jul 2018 13:42:26 +0200
Message-ID: <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>, evgreen@chromium.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 3:32 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> commit bfd694d5e21c ("mmc: core: Add tunable delay
> before detecting card after card is inserted") adds
> "u32 cd_debounce_delay_ms" to the last of mmc_gpio
> struct and cause "char cd_label[0]" NOT work as string
> pointer of card detect label, when "cat /proc/interrupts",
> the devname for card detect gpio is incorrect as below:
>
> 144:          0  gpio-mxc  22 Edge      =E2=96=92
> 161:          0  gpio-mxc   7 Edge      =E2=96=92
>
> Move the cd_label field down to fix this, and drop the
> zero from the array size to prevent future similar bugs,
> the result is correct as below:
>
> 144:          0  gpio-mxc  22 Edge      2198000.mmc cd
> 161:          0  gpio-mxc   7 Edge      2190000.mmc cd
>
> Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card =
after card is inserted")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Tested-by: Fabio Estevam <fabio.estevam@nxp.com>

Curious.

> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -27,8 +27,8 @@ struct mmc_gpio {
>         bool override_cd_active_level;
>         irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
>         char *ro_label;
> -       char cd_label[0];
>         u32 cd_debounce_delay_ms;
> +       char cd_label[];

Not that I am the smartest in the world when it comes to how the
C compilers work this out.

But isn't that equivalent to:
char *cd_label;
?

Look at this from drivers/mmc/core/slot-gpio.c:

ctx->ro_label =3D ctx->cd_label + len;
ctx->cd_debounce_delay_ms =3D 200;
snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
host->slot.handler_priv =3D ctx;
host->slot.cd_irq =3D -EINVAL;

So now that ro_label is char * that points len chars into the
struct and that is all fine as the ctx is allocated like that:

struct mmc_gpio *ctx =3D devm_kzalloc(host->parent,
                               sizeof(*ctx) + 2 * len, GFP_KERNEL);

And I've seen this being done to allocate a state with
some dynamic strings after it.

But I just don't like this, it seems fragile and now it broke.

What about this:

From facb3799f479bfd4dad99c25c9c5d4c77b14c9b0 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Jul 2018 13:35:01 +0200
Subject: [PATCH] mmc: slot-gpio: Allocate GPIO labels dynamically

The use of string pointers in the MMC slot GPIO context is
pretty dubious, allocating some 2*len extra bytes for each
label of the ro and wp pins.

Tidy this up using kasprintf() with dynamic allocation of
labels for these strings.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/slot-gpio.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index ef05e0039378..c417801b366e 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,7 +27,7 @@ struct mmc_gpio {
     bool override_cd_active_level;
     irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
     char *ro_label;
-    char cd_label[0];
+    char *cd_label;
     u32 cd_debounce_delay_ms;
 };

@@ -47,13 +47,18 @@ int mmc_gpio_alloc(struct mmc_host *host)
 {
     size_t len =3D strlen(dev_name(host->parent)) + 4;
     struct mmc_gpio *ctx =3D devm_kzalloc(host->parent,
-                sizeof(*ctx) + 2 * len,    GFP_KERNEL);
+                        sizeof(*ctx), GFP_KERNEL);

     if (ctx) {
-        ctx->ro_label =3D ctx->cd_label + len;
         ctx->cd_debounce_delay_ms =3D 200;
-        snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
-        snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
+        ctx->cd_label =3D devm_kasprintf(host->parent, GFP_KERNEL,
+                "%s cd", dev_name(host->parent));
+        if (!ctx->cd_label)
+            return -ENOMEM;
+        ctx->ro_label =3D devm_kasprintf(host->parent, GFP_KERNEL,
+                "%s ro", dev_name(host->parent));
+        if (!ctx->ro_label)
+            return -ENOMEM;
         host->slot.handler_priv =3D ctx;
         host->slot.cd_irq =3D -EINVAL;
     }
--=20
2.17.0

I can send it as a separate patch if you like it.

Yours,
Linus Walleij
