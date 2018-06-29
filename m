Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDEFC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E6727C1D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tswr+RH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E6727C1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755486AbeF2UAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:00:32 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39207 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753338AbeF2UA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:00:29 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so782179oib.6;
        Fri, 29 Jun 2018 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7cYQb8eAwyMw6qlt0sH5RKGd9N0sDSpkLU1Y3AdKV9A=;
        b=Tswr+RH+2bfEcmRoFqbriLYeasvB0g9bpysLECnFGYJxVR2ddYJmVQLUGZgSGTDim5
         KViGApzC8vJCuliI4k/eVbZTvNt1S4ux7l/PZFeMaExBZbXBl7IMPQVR+gveF9Ib8ygT
         a2c7Kvu9j3jpEoTfsjrW0YazIxFFCz8S0LuisSDn8sBiTAWJ4eP+f0j4ixe1mo0321L9
         mTXTHpc49Qr5+ui1qXpZnRtYhufOGI1xn+AeKeXD7rXN4TFWLp/Gn9o2TtpHMbY8qWxG
         ZVIQ+fJuIqmks1cdmwOanoGUoGimJpmerdk5fSwc6hrWuVX1fWhy16cj+wbg9icBnxn0
         KirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7cYQb8eAwyMw6qlt0sH5RKGd9N0sDSpkLU1Y3AdKV9A=;
        b=DlL4EWLq4sdf0+X0uPjPGIVj/s1OzcMpNpVyVB5D2qU2dD0UfJmxzXJnb34NYjcj7J
         /DY08N1V2DEuwHZVTntsWQ4ObLmzVEPGhLDw7jfa90AZfzeY6SRtd3AfawE02Ks0X2Fj
         D1OKXRZgGg7AMIBOYiPnanJy0wGNLVuCAg06amA20t9lATQrdhvx1zdwdKWXdOeHAiFU
         W8IWOeR2gKNPcvrDPhq5chP7qxHHm4y1bs5jyGFsou03oyXKNhAz5clIxXUky7j5UjKb
         qjZLDyal048w/E/yByDaRa8N7zT9i4bu19cSGO1FUD/W3BnLmLpiFLvckkLe2vB7zQNg
         xcdA==
X-Gm-Message-State: APt69E2PR2eEX4qFduK1CkDii5aVRenM7qMV7v/XbIRQaUu6uWZDp7Al
        gWMh6shcFtkdCvS8Als8gv3raXawvEUetn8tejI=
X-Google-Smtp-Source: AAOMgpfEfmWo8NxaEwDV0aWLpNn0pLPbNO2x1E+w0p1/klBWp2PFW9cUbnqfHUD8hetjpAGXceOEH8vasDFxC7kBSTI=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr9563262oif.9.1530302428524;
 Fri, 29 Jun 2018 13:00:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:00:27
 -0700 (PDT)
In-Reply-To: <1530236132-7968-1-git-send-email-Anson.Huang@nxp.com>
References: <1530236132-7968-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 29 Jun 2018 17:00:27 -0300
Message-ID: <CAOMZO5BnvwB5rUr2H0=tp9wWnePoMWyfX86CT15jxsi_PaFG0Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: cd_label must be last entry of mmc_gpio struct
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        evgreen@chromium.org, Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Thu, Jun 28, 2018 at 10:35 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
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
> Making "char cd_label[0]" the last entry of mmc_gpio struct,
> the result is correct as below:
>
> 144:          0  gpio-mxc  22 Edge      2198000.mmc cd
> 161:          0  gpio-mxc   7 Edge      2190000.mmc cd

Please add a Fixes: tag.

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/mmc/core/slot-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index ef05e00..1ccf9dc 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -27,8 +27,8 @@ struct mmc_gpio {
>         bool override_cd_active_level;
>         irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
>         char *ro_label;
> -       char cd_label[0];
>         u32 cd_debounce_delay_ms;
> +       char cd_label[0];

Thanks for the fix.

A more robust solution would be:

--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,8 +27,8 @@ struct mmc_gpio {
        bool override_cd_active_level;
        irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
        char *ro_label;
-       char cd_label[0];
        u32 cd_debounce_delay_ms;
+       char cd_label[];
 };

This way if someone tries to rearrange the struct members in the
future, then GCC will complain with the following error:
error: flexible array member not at end of struct

Please see a158531f3c92 ("gpio: 74x164: Fix crash during .remove()")
which provides a nice explanation for this same kind of problem.

Then you can add:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
