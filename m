Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7F7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D65821582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sNEqv/HI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D65821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeI0PaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:30:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37514 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbeI0P37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:29:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id e17-v6so639233oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxZYuTJ8sgQSDFx0gLxfx2SYjG1+0qoKg1cL16ZelF4=;
        b=sNEqv/HIp3OQ0s4ev/6bw1YcePyRgpryzjTTJ7aQQGu+YtvA5q7E8SU4hk9VlS5V3V
         mk9F4StIdsS/aAhg48kDBYJOiqdxHMWlbLGDth/hbHvS9xDIW7cOqud+9z5vdXLJecxE
         oLX+RG3vtGuW7RSumbjgX0seGJPgJVSZFiHH6P4JEGGk6cptIBfh0fVYone5jko6u+s+
         iBBWEOozRPJifqEsbM4WF8FDoRqaEgGmIN5POk/duSUK6ad2qH4LvsGfQnTXAlIcISK5
         /tMmHopfs1KWBogbxonTs8xVRmxUKcJVK8Y874Wzx8qY8raC/NJ9AnWc+6otoZjv0iIt
         ynzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxZYuTJ8sgQSDFx0gLxfx2SYjG1+0qoKg1cL16ZelF4=;
        b=V+StK8klNXfEI3HA68uvJ6zuuKzU86ZjFKZdqgUEf8tiincoY20IfgWMB7OuHJRzNN
         sCHbnHfjqQcGtQw+sGQeBJ8sfXifsRgzpWr3P8gQAnV7jc346yDKSZq1rb4ERfLp8k8i
         JjvUIe8ohJo0qV7rf1EGz7S19tMOsQw75NottOQvJ+kHXLW09L6Bzyp/ObXYbAWW9oIg
         w4QJFD5pBymHjRmnm/7i39W/+tl2UeADaV3HyplUioKl29BYH5r+XiYhrZ1RCTynsbRc
         rXUvlycTEr7CpTXB4pfLSjHaK6WFJkv1OT9wPykmY9P+UXH4OKlzeAwjayieRHFPoGVl
         CIOA==
X-Gm-Message-State: ABuFfoiA2OYA5ru2iVSZmICjgnluQG0nzjBbtDAZT6TfhxSngwgiy78r
        c0XVp0omIp9PZnxchO9c58FVpIQDPu7I489TkTk=
X-Google-Smtp-Source: ACcGV627qrq5ntTPaFLiw8tpDnooCQpgAthyelnL78lx/IbB6LgPJ9MONfoCgLJf2HaqyspopQ99krlnFelsDOI6veo=
X-Received: by 2002:aca:338a:: with SMTP id z132-v6mr2820284oiz.184.1538039563368;
 Thu, 27 Sep 2018 02:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
 <1537433449-65213-3-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCAaphyifUNyDQr7th2Mt=A+UQnzai0edKLCPNbxhh2w+Q@mail.gmail.com> <f75b6f23-6d58-2145-30f3-b23e4b69966b@amlogic.com>
In-Reply-To: <f75b6f23-6d58-2145-30f3-b23e4b69966b@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 27 Sep 2018 11:12:32 +0200
Message-ID: <CAFBinCBLfoqnLK_hu6fufO4MXKKoRDPDuJgLasCNYWeuL6tCKw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     liang.yang@amlogic.com
Cc:     jianxin.pan@amlogic.com, boris.brezillon@bootlin.com,
        linux-mtd@lists.infradead.org, yixun.lan@amlogic.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, jbrunet@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>, carlo@caione.org,
        khilman@baylibre.com, robh@kernel.org, jian.hu@amlogic.com,
        hanjie.lin@amlogic.com, victor.wan@amlogic.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Liang,

On Thu, Sep 27, 2018 at 10:19 AM Liang Yang <liang.yang@amlogic.com> wrote:
>
> Hello Martin,
>
> On 9/22/2018 11:32 PM, Martin Blumenstingl wrote:
> > Hello,
> >
> > On Thu, Sep 20, 2018 at 10:51 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> > [snip]
> >> +static int meson_nfc_clk_init(struct meson_nfc *nfc)
> >> +{
> >> +       int ret;
> >> +
> >> +       /* request core clock */
> >> +       nfc->core_clk = devm_clk_get(nfc->dev, "core");
> >> +       if (IS_ERR(nfc->core_clk)) {
> >> +               dev_err(nfc->dev, "failed to get core clk\n");
> >> +               return PTR_ERR(nfc->core_clk);
> >> +       }
> >> +
> >> +       nfc->device_clk = devm_clk_get(nfc->dev, "device");
> >> +       if (IS_ERR(nfc->device_clk)) {
> >> +               dev_err(nfc->dev, "failed to get device clk\n");
> >> +               return PTR_ERR(nfc->device_clk);
> >> +       }
> >> +
> >> +       nfc->phase_tx = devm_clk_get(nfc->dev, "tx");
> >> +       if (IS_ERR(nfc->phase_tx)) {
> >> +               dev_err(nfc->dev, "failed to get tx clk\n");
> >> +               return PTR_ERR(nfc->phase_tx);
> >> +       }
> >> +
> >> +       nfc->phase_rx = devm_clk_get(nfc->dev, "rx");
> >> +       if (IS_ERR(nfc->phase_rx)) {
> >> +               dev_err(nfc->dev, "failed to get rx clk\n");
> >> +               return PTR_ERR(nfc->phase_rx);
> >> +       }
> > neither the "rx" nor the "tx" clock are documented in the dt-bindings patch
> >
>
> ok, i will add them later.
>
> >> +       /* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
> >> +       regmap_update_bits(nfc->reg_clk, 0,
> >> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK,
> >> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK);
> > clk_set_rate also works for clocks that are not enabled yet (except if
> > they have the flag CLK_SET_RATE_UNGATE)
> > this should help you to remove CLK_DIV_MASK here
> >
>
> if not set clk_div_mask here, the value 0x00 of divider means nand clock
> off, even read/write nand register is forbidden.
ah, now I see the pattern here.
Jerome has written a "sclk-div" driver (which is currently only used
for the audio clocks on AXG). based on reading the code it seems that
switching the driver of the divider clock to sclk-div would allow you
to remove setting CLK_DIV_MASK here:
- the  "hi" parameter in struct meson_sclk_div_data is optional ->
then the sclk-div clock won't try to change the duty cycle
- sclk_div_init reads the divider at initialization time - if it's 0
it takes the maximum possible divider value
- sclk_div_enable (which you're going to call anyways, through
clk_prepare_enable) will then set the divider to the greatest possible
value

> > is CLK_SELECT_NAND a bit that switches the clock output from the sdmmc
> > controller to the NAND controller?
> > if so: can this be modeled as a mux clock?
> >
>
> it seems to like a gate. 1: nand is selected; 0: emmc is selected.
> Is it suitable for making it as a mux clock?
my understanding of a gate is:
- register value X = OFF, value Y = ON

but in your case it's:
- 0 = eMMC is ON but NAND is OFF
- 1 = eMMC is OFF but NAND is ON
(so both values mean "on", just for different contexts)

I believe you need to set this value for eMMC as well:
what if the bootloader (or hardware defaults, etc.) incorrectly sets
the value to 1 but the Linux .dts is configured to use eMMC?

> > the public S905 datasheet doesn't mention CLK_ALWAYS_ON at bit 28 but
> > uses bit 24 instead. the description from the datasheet:
> > Cfg_always_on:
> > 1: Keep clock always on
> > 0: Clock on/off controlled by activities.
> >      Any APB3 access or descriptor execution will turn clock on.
> > Recommended value: 0
> >
> > can you please explain what CLK_ALWAYS_ON does and why it has to be 1?
> >
>
> em , it is the same as bit 24 in S905 datasheet, only moves to bit 28.
> it means keeping internal clock on whether nand wroks or not.
> it doesn't have to be 1; i have tried 0 successfully on AXG platform.
my preference would be to use the recommended value from the datasheet
unless there's a good argument why it has to be different


Regards
Martin
