Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13CEECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431A62150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P21/7pGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431A62150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeIVV04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:26:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46939 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeIVV04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:26:56 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so13781593oie.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJUBPvQlv+59yJXa4obXLAMyaSqOoxIliyFJOoC/vHI=;
        b=P21/7pGxWgCYO5aDoHDOqSn41VwhfDWfl5/heqyhgLaat/D56JhDd6uXZqx0f26mdc
         RrxpSh0XjYbHM03P7qfhJ/Zw7m8pUgYA4bWtmmgcK5n7RlRG5KgNCJ8Q3QyksR5VjvVf
         bal2EQcE1LeUUfBNwXG/b4A58jSU+C0aVgHcjyLjjFJ92+FCE3cXOXjgc9BBOGz7lHKZ
         OmM7C61vlBrtxtYIxtrAPZxL8YrhYpTUGqwoKeim4tExTCjsc8UOcMfrBH4Sl8PgaOk8
         9s/bWzEIy1XW3jxS/iALw4IvQphm4iNos/iRGZMf1MldSv9KhlAb5h9OC1/OoBAxEM2Z
         mCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJUBPvQlv+59yJXa4obXLAMyaSqOoxIliyFJOoC/vHI=;
        b=jCf+vBonfCyRFy9THtiEis2reuQXDQD3q34UyKD+eL3xjYQR/IxvtcrKWaKQyFOsV3
         H7/RB81WYqu7lGG9APiq5/9fqQy86tz2sVdTzZaoXj10S9JG1hP32tkeavtHdjkADNoo
         jbC7jgeepScbx2qy5UMoEporXSH1qWDbN0maIF3uCC8B6PM+9BAf3J9ISuUqdgHpyBvi
         8p3ogyDT8zPYSmLVMTylDQ15F7GoBebKuV0qDLksikNEyAu/Hq885kbO42GHtYVGlDsK
         w8QhLJ1RyxHpLcocWOqDdIaKH6tlVNQaep1Qdy06jYuunnkjLu3DT6vW+LwX2nP2uF3b
         WPaw==
X-Gm-Message-State: APzg51Dpo5g1IcbdTTliZODlRXQULCr+B0lx5RaWFR12MWsgbu4uKhne
        Nd57SmLSttixunqOQDl4mwLPHSHYJp62WUohZT0=
X-Google-Smtp-Source: ANB0VdYLDgkC29qe1QzroCFHDaGa3iPLSKqVSB0t/utTe3QYbzqvBLnHSz6oBjFa0SxAjdsK6Z7hCHzNJ+le5iww8t4=
X-Received: by 2002:aca:338a:: with SMTP id z132-v6mr1463872oiz.184.1537630377308;
 Sat, 22 Sep 2018 08:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com> <1537433449-65213-3-git-send-email-jianxin.pan@amlogic.com>
In-Reply-To: <1537433449-65213-3-git-send-email-jianxin.pan@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Sep 2018 17:32:46 +0200
Message-ID: <CAFBinCAaphyifUNyDQr7th2Mt=A+UQnzai0edKLCPNbxhh2w+Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     jianxin.pan@amlogic.com
Cc:     boris.brezillon@bootlin.com, linux-mtd@lists.infradead.org,
        liang.yang@amlogic.com, yixun.lan@amlogic.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, richard@nod.at,
        jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        carlo@caione.org, khilman@baylibre.com, robh@kernel.org,
        jian.hu@amlogic.com, hanjie.lin@amlogic.com,
        victor.wan@amlogic.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 20, 2018 at 10:51 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
[snip]
> +static int meson_nfc_clk_init(struct meson_nfc *nfc)
> +{
> +       int ret;
> +
> +       /* request core clock */
> +       nfc->core_clk = devm_clk_get(nfc->dev, "core");
> +       if (IS_ERR(nfc->core_clk)) {
> +               dev_err(nfc->dev, "failed to get core clk\n");
> +               return PTR_ERR(nfc->core_clk);
> +       }
> +
> +       nfc->device_clk = devm_clk_get(nfc->dev, "device");
> +       if (IS_ERR(nfc->device_clk)) {
> +               dev_err(nfc->dev, "failed to get device clk\n");
> +               return PTR_ERR(nfc->device_clk);
> +       }
> +
> +       nfc->phase_tx = devm_clk_get(nfc->dev, "tx");
> +       if (IS_ERR(nfc->phase_tx)) {
> +               dev_err(nfc->dev, "failed to get tx clk\n");
> +               return PTR_ERR(nfc->phase_tx);
> +       }
> +
> +       nfc->phase_rx = devm_clk_get(nfc->dev, "rx");
> +       if (IS_ERR(nfc->phase_rx)) {
> +               dev_err(nfc->dev, "failed to get rx clk\n");
> +               return PTR_ERR(nfc->phase_rx);
> +       }
neither the "rx" nor the "tx" clock are documented in the dt-bindings patch

> +       /* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
> +       regmap_update_bits(nfc->reg_clk, 0,
> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK,
> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK);
clk_set_rate also works for clocks that are not enabled yet (except if
they have the flag CLK_SET_RATE_UNGATE)
this should help you to remove CLK_DIV_MASK here

is CLK_SELECT_NAND a bit that switches the clock output from the sdmmc
controller to the NAND controller?
if so: can this be modeled as a mux clock?

the public S905 datasheet doesn't mention CLK_ALWAYS_ON at bit 28 but
uses bit 24 instead. the description from the datasheet:
Cfg_always_on:
1: Keep clock always on
0: Clock on/off controlled by activities.
    Any APB3 access or descriptor execution will turn clock on.
Recommended value: 0

can you please explain what CLK_ALWAYS_ON does and why it has to be 1?


Regards
Martin
