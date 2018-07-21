Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE779ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB2020854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SjCyOZYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB2020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeGUUzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:55:24 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36480 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeGUUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:55:24 -0400
Received: by mail-oi0-f65.google.com with SMTP id n21-v6so11525839oig.3;
        Sat, 21 Jul 2018 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gW4BbMc9Tg7qdqqz/vM1RJ0ttE2+E8A3tJHJOwBOL3w=;
        b=SjCyOZYkgU0xe2Mr1MFo4miLOQ+GfOCVLyahAa/Y8bqdUOtnC+OCJTNTb7r5BowNrL
         HVosgFAxEAoACD9FC/L+4Hcu8+VhlV6fpbB/bEuZsge9LuUfMvb988Re8RpCIsw8z08B
         WbLDoIII3eX41ORYalL2KuZiVrqfKKp82H5RcWw3xFbyKtvW4yxyaMS5543wo7SIKGvQ
         zSm9amst3QZf4RmxkUVIMFKloAbr7TB6Zq5JD6Y3UL9raN8UCB7j8MWfLVvC7hmHa1Y4
         dlj4JfzDOeYU+WQOwpxtp0VQHdIResE55pGV/8fR9atPD5TltY6rKBUgLUmiHF/1o3es
         oF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gW4BbMc9Tg7qdqqz/vM1RJ0ttE2+E8A3tJHJOwBOL3w=;
        b=sRz2zsmh04awZiiF6Mh90wZwUl/0HxE5Vx0/x679w2NSMc16THXt+UwhdM9NlnP5Kh
         KTgpsgYq0aZRIwXq1r5NpYWuPSxu/eo16as9Mz+czy1UMlvy1LZN/1JXno3gRuNR1Jio
         D1aKiD0TtYvwSehBdBBEHQW/GpAPMUq8zGFQHRs4nv2yPEpU+1AS2zcrm71lYro0zv9G
         nvHYnAUpZCwKadOeV2LPgqp9OzgxZMmtXpM4BloLUotFfRXj9+7fKzpanXNqNpA7Gggr
         bxazLg2eY72Xak82ZPtYdwIhVWSlmOg4iLvgcYzSiIz18XYo5vKnTvD28ybisj0pXZAt
         jgvQ==
X-Gm-Message-State: AOUpUlFX8l7qKFgVUVSFDx4MrtDOSFhyZtGfAWlY3IjoFIK1dGMiVDLn
        OLY0wcc8CqEmfNuprIuYHK6e27VeLc7EDogTWpo=
X-Google-Smtp-Source: AAOMgpf9H/L2HmDnaWiIHC8OmUv0OEGMN68IysjbZtY5diTj9eZpJIJy05Ep619VS+KRA8YpchdwFacVSMXaeqrf4lY=
X-Received: by 2002:aca:4d87:: with SMTP id a129-v6mr3255902oib.256.1532203287789;
 Sat, 21 Jul 2018 13:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180717095617.12240-1-jbrunet@baylibre.com> <20180717095617.12240-3-jbrunet@baylibre.com>
In-Reply-To: <20180717095617.12240-3-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 21 Jul 2018 22:01:16 +0200
Message-ID: <CAFBinCAcqwhJUoLF3XkhOR2gnNk3cjEgh=ChTDybeRPLHgzeSg@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: meson: clk-pll: remove od parameters
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Jul 17, 2018 at 11:56 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Remove od parameters from pll clocks and add post dividers clocks
> instead. Some clock, especially the one which feature several ods,
> may provide output between those ods. Also, some drivers, such
> as the hdmi driver, may require a more detailed control of the
> clock dividers, compared to what CCF would perform automatically.
>
> One added benefit of removing ods is that it also greatly reduce the
> size of the rate parameter tables.
>
> In the future, we could possibly take the predivider 'n' out of this
> driver as well. To do so, we will need to understand the constraints
> for the PLL to lock and whether or not it depends on the input clock
> rate.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg.c     | 279 ++++++++++++++------------
>  drivers/clk/meson/axg.h     |   8 +-
>  drivers/clk/meson/clk-pll.c |  40 ++--
>  drivers/clk/meson/clkc.h    |   9 +-
>  drivers/clk/meson/gxbb.c    | 474 +++++++++++++++++++++-----------------------
>  drivers/clk/meson/gxbb.h    |  10 +-
>  drivers/clk/meson/meson8b.c | 148 +++++++-------
>  drivers/clk/meson/meson8b.h |   5 +-
>  8 files changed, 480 insertions(+), 493 deletions(-)
>
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 6d8976554656..572358062459 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -22,7 +22,7 @@
>
>  static DEFINE_SPINLOCK(meson_clk_lock);
>
> -static struct clk_regmap axg_fixed_pll = {
> +static struct clk_regmap axg_fixed_pll_dco = {
>         .data = &(struct meson_clk_pll_data){
>                 .en = {
>                         .reg_off = HHI_MPLL_CNTL,
> @@ -39,11 +39,6 @@ static struct clk_regmap axg_fixed_pll = {
>                         .shift   = 9,
>                         .width   = 5,
>                 },
> -               .od = {
> -                       .reg_off = HHI_MPLL_CNTL,
> -                       .shift   = 16,
> -                       .width   = 2,
> -               },
>                 .frac = {
>                         .reg_off = HHI_MPLL_CNTL2,
>                         .shift   = 0,
> @@ -61,14 +56,29 @@ static struct clk_regmap axg_fixed_pll = {
>                 },
>         },
>         .hw.init = &(struct clk_init_data){
> -               .name = "fixed_pll",
> +               .name = "fixed_pll_dco",
>                 .ops = &meson_clk_pll_ro_ops,
>                 .parent_names = (const char *[]){ "xtal" },
>                 .num_parents = 1,
>         },
>  };
>
> -static struct clk_regmap axg_sys_pll = {
> +static struct clk_regmap axg_fixed_pll = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_MPLL_CNTL,
> +               .shift = 16,
> +               .width = 2,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "fixed_pll",
> +               .ops = &clk_regmap_divider_ro_ops,
> +               .parent_names = (const char *[]){ "fixed_pll_dco" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_regmap axg_sys_pll_dco = {
>         .data = &(struct meson_clk_pll_data){
>                 .en = {
>                         .reg_off = HHI_SYS_PLL_CNTL,
> @@ -85,11 +95,6 @@ static struct clk_regmap axg_sys_pll = {
>                         .shift   = 9,
>                         .width   = 5,
>                 },
> -               .od = {
> -                       .reg_off = HHI_SYS_PLL_CNTL,
> -                       .shift   = 16,
> -                       .width   = 2,
> -               },
>                 .l = {
>                         .reg_off = HHI_SYS_PLL_CNTL,
>                         .shift   = 31,
> @@ -102,7 +107,7 @@ static struct clk_regmap axg_sys_pll = {
>                 },
>         },
>         .hw.init = &(struct clk_init_data){
> -               .name = "sys_pll",
> +               .name = "sys_pll_dco",
>                 .ops = &meson_clk_pll_ro_ops,
>                 .parent_names = (const char *[]){ "xtal" },
>                 .num_parents = 1,
> @@ -110,94 +115,51 @@ static struct clk_regmap axg_sys_pll = {
>         },
>  };
>
> +static struct clk_regmap axg_sys_pll = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_SYS_PLL_CNTL,
> +               .shift = 16,
> +               .width = 2,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "sys_pll",
> +               .ops = &clk_regmap_divider_ro_ops,
> +               .parent_names = (const char *[]){ "sys_pll_dco" },
> +               .num_parents = 1,
> +       },
> +};
> +
>  static const struct pll_rate_table axg_gp0_pll_rate_table[] = {
> -       PLL_RATE(240000000, 40, 1, 2),
> -       PLL_RATE(246000000, 41, 1, 2),
> -       PLL_RATE(252000000, 42, 1, 2),
> -       PLL_RATE(258000000, 43, 1, 2),
> -       PLL_RATE(264000000, 44, 1, 2),
> -       PLL_RATE(270000000, 45, 1, 2),
> -       PLL_RATE(276000000, 46, 1, 2),
> -       PLL_RATE(282000000, 47, 1, 2),
> -       PLL_RATE(288000000, 48, 1, 2),
> -       PLL_RATE(294000000, 49, 1, 2),
> -       PLL_RATE(300000000, 50, 1, 2),
> -       PLL_RATE(306000000, 51, 1, 2),
> -       PLL_RATE(312000000, 52, 1, 2),
> -       PLL_RATE(318000000, 53, 1, 2),
> -       PLL_RATE(324000000, 54, 1, 2),
> -       PLL_RATE(330000000, 55, 1, 2),
> -       PLL_RATE(336000000, 56, 1, 2),
> -       PLL_RATE(342000000, 57, 1, 2),
> -       PLL_RATE(348000000, 58, 1, 2),
> -       PLL_RATE(354000000, 59, 1, 2),
> -       PLL_RATE(360000000, 60, 1, 2),
> -       PLL_RATE(366000000, 61, 1, 2),
> -       PLL_RATE(372000000, 62, 1, 2),
> -       PLL_RATE(378000000, 63, 1, 2),
> -       PLL_RATE(384000000, 64, 1, 2),
> -       PLL_RATE(390000000, 65, 1, 3),
> -       PLL_RATE(396000000, 66, 1, 3),
> -       PLL_RATE(402000000, 67, 1, 3),
> -       PLL_RATE(408000000, 68, 1, 3),
> -       PLL_RATE(480000000, 40, 1, 1),
> -       PLL_RATE(492000000, 41, 1, 1),
> -       PLL_RATE(504000000, 42, 1, 1),
> -       PLL_RATE(516000000, 43, 1, 1),
> -       PLL_RATE(528000000, 44, 1, 1),
> -       PLL_RATE(540000000, 45, 1, 1),
> -       PLL_RATE(552000000, 46, 1, 1),
> -       PLL_RATE(564000000, 47, 1, 1),
> -       PLL_RATE(576000000, 48, 1, 1),
> -       PLL_RATE(588000000, 49, 1, 1),
> -       PLL_RATE(600000000, 50, 1, 1),
> -       PLL_RATE(612000000, 51, 1, 1),
> -       PLL_RATE(624000000, 52, 1, 1),
> -       PLL_RATE(636000000, 53, 1, 1),
> -       PLL_RATE(648000000, 54, 1, 1),
> -       PLL_RATE(660000000, 55, 1, 1),
> -       PLL_RATE(672000000, 56, 1, 1),
> -       PLL_RATE(684000000, 57, 1, 1),
> -       PLL_RATE(696000000, 58, 1, 1),
> -       PLL_RATE(708000000, 59, 1, 1),
> -       PLL_RATE(720000000, 60, 1, 1),
> -       PLL_RATE(732000000, 61, 1, 1),
> -       PLL_RATE(744000000, 62, 1, 1),
> -       PLL_RATE(756000000, 63, 1, 1),
> -       PLL_RATE(768000000, 64, 1, 1),
> -       PLL_RATE(780000000, 65, 1, 1),
> -       PLL_RATE(792000000, 66, 1, 1),
> -       PLL_RATE(804000000, 67, 1, 1),
> -       PLL_RATE(816000000, 68, 1, 1),
> -       PLL_RATE(960000000, 40, 1, 0),
> -       PLL_RATE(984000000, 41, 1, 0),
> -       PLL_RATE(1008000000, 42, 1, 0),
> -       PLL_RATE(1032000000, 43, 1, 0),
> -       PLL_RATE(1056000000, 44, 1, 0),
> -       PLL_RATE(1080000000, 45, 1, 0),
> -       PLL_RATE(1104000000, 46, 1, 0),
> -       PLL_RATE(1128000000, 47, 1, 0),
> -       PLL_RATE(1152000000, 48, 1, 0),
> -       PLL_RATE(1176000000, 49, 1, 0),
> -       PLL_RATE(1200000000, 50, 1, 0),
> -       PLL_RATE(1224000000, 51, 1, 0),
> -       PLL_RATE(1248000000, 52, 1, 0),
> -       PLL_RATE(1272000000, 53, 1, 0),
> -       PLL_RATE(1296000000, 54, 1, 0),
> -       PLL_RATE(1320000000, 55, 1, 0),
> -       PLL_RATE(1344000000, 56, 1, 0),
> -       PLL_RATE(1368000000, 57, 1, 0),
> -       PLL_RATE(1392000000, 58, 1, 0),
> -       PLL_RATE(1416000000, 59, 1, 0),
> -       PLL_RATE(1440000000, 60, 1, 0),
> -       PLL_RATE(1464000000, 61, 1, 0),
> -       PLL_RATE(1488000000, 62, 1, 0),
> -       PLL_RATE(1512000000, 63, 1, 0),
> -       PLL_RATE(1536000000, 64, 1, 0),
> -       PLL_RATE(1560000000, 65, 1, 0),
> -       PLL_RATE(1584000000, 66, 1, 0),
> -       PLL_RATE(1608000000, 67, 1, 0),
> -       PLL_RATE(1632000000, 68, 1, 0),
> +       PLL_RATE(960000000, 40, 1),
> +       PLL_RATE(984000000, 41, 1),
> +       PLL_RATE(1008000000, 42, 1),
> +       PLL_RATE(1032000000, 43, 1),
> +       PLL_RATE(1056000000, 44, 1),
> +       PLL_RATE(1080000000, 45, 1),
> +       PLL_RATE(1104000000, 46, 1),
> +       PLL_RATE(1128000000, 47, 1),
> +       PLL_RATE(1152000000, 48, 1),
> +       PLL_RATE(1176000000, 49, 1),
> +       PLL_RATE(1200000000, 50, 1),
> +       PLL_RATE(1224000000, 51, 1),
> +       PLL_RATE(1248000000, 52, 1),
> +       PLL_RATE(1272000000, 53, 1),
> +       PLL_RATE(1296000000, 54, 1),
> +       PLL_RATE(1320000000, 55, 1),
> +       PLL_RATE(1344000000, 56, 1),
> +       PLL_RATE(1368000000, 57, 1),
> +       PLL_RATE(1392000000, 58, 1),
> +       PLL_RATE(1416000000, 59, 1),
> +       PLL_RATE(1440000000, 60, 1),
> +       PLL_RATE(1464000000, 61, 1),
> +       PLL_RATE(1488000000, 62, 1),
> +       PLL_RATE(1512000000, 63, 1),
> +       PLL_RATE(1536000000, 64, 1),
> +       PLL_RATE(1560000000, 65, 1),
> +       PLL_RATE(1584000000, 66, 1),
> +       PLL_RATE(1608000000, 67, 1),
> +       PLL_RATE(1632000000, 68, 1),
>         { /* sentinel */ },
>  };
>
> @@ -209,7 +171,7 @@ static const struct reg_sequence axg_gp0_init_regs[] = {
>         { .reg = HHI_GP0_PLL_CNTL5,     .def = 0x00078000 },
>  };
>
> -static struct clk_regmap axg_gp0_pll = {
> +static struct clk_regmap axg_gp0_pll_dco = {
>         .data = &(struct meson_clk_pll_data){
>                 .en = {
>                         .reg_off = HHI_GP0_PLL_CNTL,
> @@ -226,11 +188,6 @@ static struct clk_regmap axg_gp0_pll = {
>                         .shift   = 9,
>                         .width   = 5,
>                 },
> -               .od = {
> -                       .reg_off = HHI_GP0_PLL_CNTL,
> -                       .shift   = 16,
> -                       .width   = 2,
> -               },
>                 .frac = {
>                         .reg_off = HHI_GP0_PLL_CNTL1,
>                         .shift   = 0,
> @@ -251,13 +208,29 @@ static struct clk_regmap axg_gp0_pll = {
>                 .init_count = ARRAY_SIZE(axg_gp0_init_regs),
>         },
>         .hw.init = &(struct clk_init_data){
> -               .name = "gp0_pll",
> +               .name = "gp0_pll_dco",
>                 .ops = &meson_clk_pll_ops,
>                 .parent_names = (const char *[]){ "xtal" },
>                 .num_parents = 1,
>         },
>  };
>
> +static struct clk_regmap axg_gp0_pll = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_GP0_PLL_CNTL,
> +               .shift = 16,
> +               .width = 2,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "gp0_pll",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_names = (const char *[]){ "gp0_pll_dco" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>  static const struct reg_sequence axg_hifi_init_regs[] = {
>         { .reg = HHI_HIFI_PLL_CNTL1,    .def = 0xc084b000 },
>         { .reg = HHI_HIFI_PLL_CNTL2,    .def = 0xb75020be },
> @@ -266,7 +239,7 @@ static const struct reg_sequence axg_hifi_init_regs[] = {
>         { .reg = HHI_HIFI_PLL_CNTL5,    .def = 0x00058000 },
>  };
>
> -static struct clk_regmap axg_hifi_pll = {
> +static struct clk_regmap axg_hifi_pll_dco = {
>         .data = &(struct meson_clk_pll_data){
>                 .en = {
>                         .reg_off = HHI_HIFI_PLL_CNTL,
> @@ -283,11 +256,6 @@ static struct clk_regmap axg_hifi_pll = {
>                         .shift   = 9,
>                         .width   = 5,
>                 },
> -               .od = {
> -                       .reg_off = HHI_HIFI_PLL_CNTL,
> -                       .shift   = 16,
> -                       .width   = 2,
> -               },
>                 .frac = {
>                         .reg_off = HHI_HIFI_PLL_CNTL5,
>                         .shift   = 0,
> @@ -309,13 +277,29 @@ static struct clk_regmap axg_hifi_pll = {
>                 .flags = CLK_MESON_PLL_ROUND_CLOSEST,
>         },
>         .hw.init = &(struct clk_init_data){
> -               .name = "hifi_pll",
> +               .name = "hifi_pll_dco",
>                 .ops = &meson_clk_pll_ops,
>                 .parent_names = (const char *[]){ "xtal" },
>                 .num_parents = 1,
>         },
>  };
>
> +static struct clk_regmap axg_hifi_pll = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_HIFI_PLL_CNTL,
> +               .shift = 16,
> +               .width = 2,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "hifi_pll",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_names = (const char *[]){ "hifi_pll_dco" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>  static struct clk_fixed_factor axg_fclk_div2_div = {
>         .mult = 1,
>         .div = 2,
> @@ -645,11 +629,9 @@ static struct clk_regmap axg_mpll3 = {
>
>  static const struct pll_rate_table axg_pcie_pll_rate_table[] = {
>         {
> -               .rate   = 100000000,
> +               .rate   = 1600000000,
>                 .m      = 200,
>                 .n      = 3,
> -               .od     = 1,
> -               .od2    = 3,
>         },
>         { /* sentinel */ },
>  };
> @@ -661,9 +643,10 @@ static const struct reg_sequence axg_pcie_init_regs[] = {
>         { .reg = HHI_PCIE_PLL_CNTL4,    .def = 0xc000004d },
>         { .reg = HHI_PCIE_PLL_CNTL5,    .def = 0x00078000 },
>         { .reg = HHI_PCIE_PLL_CNTL6,    .def = 0x002323c6 },
> +       { .reg = HHI_PCIE_PLL_CNTL,     .def = 0x400106c8 },
>  };
>
> -static struct clk_regmap axg_pcie_pll = {
> +static struct clk_regmap axg_pcie_pll_dco = {
>         .data = &(struct meson_clk_pll_data){
>                 .en = {
>                         .reg_off = HHI_PCIE_PLL_CNTL,
> @@ -680,16 +663,6 @@ static struct clk_regmap axg_pcie_pll = {
>                         .shift   = 9,
>                         .width   = 5,
>                 },
> -               .od = {
> -                       .reg_off = HHI_PCIE_PLL_CNTL,
> -                       .shift   = 16,
> -                       .width   = 2,
> -               },
> -               .od2 = {
> -                       .reg_off = HHI_PCIE_PLL_CNTL6,
> -                       .shift   = 6,
> -                       .width   = 2,
> -               },
>                 .frac = {
>                         .reg_off = HHI_PCIE_PLL_CNTL1,
>                         .shift   = 0,
> @@ -710,13 +683,45 @@ static struct clk_regmap axg_pcie_pll = {
>                 .init_count = ARRAY_SIZE(axg_pcie_init_regs),
>         },
>         .hw.init = &(struct clk_init_data){
> -               .name = "pcie_pll",
> +               .name = "pcie_pll_dco",
>                 .ops = &meson_clk_pll_ops,
>                 .parent_names = (const char *[]){ "xtal" },
>                 .num_parents = 1,
>         },
>  };
>
> +static struct clk_regmap axg_pcie_pll_od = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_PCIE_PLL_CNTL,
> +               .shift = 16,
> +               .width = 2,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "pcie_pll_od",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_names = (const char *[]){ "pcie_pll_dco" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap axg_pcie_pll = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_PCIE_PLL_CNTL6,
> +               .shift = 6,
> +               .width = 2,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "pcie_pll",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_names = (const char *[]){ "pcie_pll_od" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>  static struct clk_regmap axg_pcie_mux = {
>         .data = &(struct clk_regmap_mux_data){
>                 .offset = HHI_PCIE_PLL_CNTL6,
> @@ -1129,6 +1134,12 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
>                 [CLKID_GEN_CLK_SEL]             = &axg_gen_clk_sel.hw,
>                 [CLKID_GEN_CLK_DIV]             = &axg_gen_clk_div.hw,
>                 [CLKID_GEN_CLK]                 = &axg_gen_clk.hw,
> +               [CLKID_SYS_PLL_DCO]             = &axg_sys_pll_dco.hw,
> +               [CLKID_FIXED_PLL_DCO]           = &axg_fixed_pll_dco.hw,
> +               [CLKID_GP0_PLL_DCO]             = &axg_gp0_pll_dco.hw,
> +               [CLKID_HIFI_PLL_DCO]            = &axg_hifi_pll_dco.hw,
> +               [CLKID_PCIE_PLL_DCO]            = &axg_pcie_pll_dco.hw,
> +               [CLKID_PCIE_PLL_OD]             = &axg_pcie_pll_od.hw,
>                 [NR_CLKS]                       = NULL,
>         },
>         .num = NR_CLKS,
> @@ -1207,6 +1218,8 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
>         &axg_fclk_div4,
>         &axg_fclk_div5,
>         &axg_fclk_div7,
> +       &axg_pcie_pll_dco,
> +       &axg_pcie_pll_od,
>         &axg_pcie_pll,
>         &axg_pcie_mux,
>         &axg_pcie_ref,
> @@ -1216,6 +1229,12 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
>         &axg_gen_clk_sel,
>         &axg_gen_clk_div,
>         &axg_gen_clk,
> +       &axg_fixed_pll_dco,
> +       &axg_sys_pll_dco,
> +       &axg_gp0_pll_dco,
> +       &axg_hifi_pll_dco,
> +       &axg_pcie_pll_dco,
> +       &axg_pcie_pll_od,
>  };
>
>  static const struct of_device_id clkc_match_table[] = {
> diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
> index 1d04144a1b2c..0431dabac629 100644
> --- a/drivers/clk/meson/axg.h
> +++ b/drivers/clk/meson/axg.h
> @@ -133,8 +133,14 @@
>  #define CLKID_PCIE_REF                         78
>  #define CLKID_GEN_CLK_SEL                      82
>  #define CLKID_GEN_CLK_DIV                      83
> +#define CLKID_SYS_PLL_DCO                      85
> +#define CLKID_FIXED_PLL_DCO                    86
> +#define CLKID_GP0_PLL_DCO                      87
> +#define CLKID_HIFI_PLL_DCO                     88
> +#define CLKID_PCIE_PLL_DCO                     89
> +#define CLKID_PCIE_PLL_OD                      90
>
> -#define NR_CLKS                                        85
> +#define NR_CLKS                                        91
>
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/axg-clkc.h>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 8aaefe67025f..348a866f09eb 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -11,15 +11,19 @@
>   * In the most basic form, a Meson PLL is composed as follows:
>   *
>   *                     PLL
> - *      +------------------------------+
> - *      |                              |
> - * in -----[ /N ]---[ *M ]---[ >>OD ]----->> out
> - *      |         ^        ^           |
> - *      +------------------------------+
> - *                |        |
> - *               FREF     VCO
> + *        +--------------------------------+
> + *        |                                |
> + *        |             +--+               |
> + *  in >>-----[ /N ]--->|  |      +-----+  |
> + *        |             |  |------| DCO |---->> out
> + *        |  +--------->|  |      +--v--+  |
> + *        |  |          +--+         |     |
> + *        |  |                       |     |
> + *        |  +--[ *(M + (F/Fmax) ]<--+     |
> + *        |                                |
> + *        +--------------------------------+
>   *
> - * out = in * (m + frac / frac_max) / (n << sum(ods))
> + * out = in * (m + frac / frac_max) / n
>   */
>
>  #include <linux/clk-provider.h>
> @@ -46,7 +50,6 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
>                                           struct meson_clk_pll_data *pll)
>  {
>         u64 rate = (u64)parent_rate * pllt->m;
> -       unsigned int od = pllt->od + pllt->od2 + pllt->od3;
>
>         if (frac && MESON_PARM_APPLICABLE(&pll->frac)) {
>                 u64 frac_rate = (u64)parent_rate * frac;
> @@ -55,7 +58,7 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
>                                          (1 << pll->frac.width));
>         }
>
> -       return DIV_ROUND_UP_ULL(rate, pllt->n << od);
> +       return DIV_ROUND_UP_ULL(rate, pllt->n);
>  }
>
>  static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
> @@ -68,15 +71,6 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
>
>         pllt.n = meson_parm_read(clk->map, &pll->n);
>         pllt.m = meson_parm_read(clk->map, &pll->m);
> -       pllt.od = meson_parm_read(clk->map, &pll->od);
> -
> -       pllt.od2 = MESON_PARM_APPLICABLE(&pll->od2) ?
> -               meson_parm_read(clk->map, &pll->od2) :
> -               0;
> -
> -       pllt.od3 = MESON_PARM_APPLICABLE(&pll->od3) ?
> -               meson_parm_read(clk->map, &pll->od3) :
> -               0;
>
>         frac = MESON_PARM_APPLICABLE(&pll->frac) ?
>                 meson_parm_read(clk->map, &pll->frac) :
> @@ -93,8 +87,6 @@ static u16 __pll_params_with_frac(unsigned long rate,
>         u16 frac_max = (1 << pll->frac.width);
>         u64 val = (u64)rate * pllt->n;
>
> -       val <<= pllt->od + pllt->od2 + pllt->od3;
> -
>         if (pll->flags & CLK_MESON_PLL_ROUND_CLOSEST)
>                 val = DIV_ROUND_CLOSEST_ULL(val * frac_max, parent_rate);
>         else
> @@ -242,13 +234,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>
>         meson_parm_write(clk->map, &pll->n, pllt->n);
>         meson_parm_write(clk->map, &pll->m, pllt->m);
> -       meson_parm_write(clk->map, &pll->od, pllt->od);
> -
> -       if (MESON_PARM_APPLICABLE(&pll->od2))
> -               meson_parm_write(clk->map, &pll->od2, pllt->od2);
>
> -       if (MESON_PARM_APPLICABLE(&pll->od3))
> -               meson_parm_write(clk->map, &pll->od3, pllt->od3);
>
>         if (MESON_PARM_APPLICABLE(&pll->frac)) {
>                 frac = __pll_params_with_frac(rate, parent_rate, pllt, pll);
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index c2ee37a78ceb..a2245e857f70 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -47,17 +47,13 @@ struct pll_rate_table {
>         unsigned long   rate;
>         u16             m;
>         u16             n;
> -       u16             od;
> -       u16             od2;
> -       u16             od3;
>  };
>
> -#define PLL_RATE(_r, _m, _n, _od)                                      \
> +#define PLL_RATE(_r, _m, _n)                                           \
>         {                                                               \
>                 .rate           = (_r),                                 \
>                 .m              = (_m),                                 \
>                 .n              = (_n),                                 \
> -               .od             = (_od),                                \
>         }
>
>  #define CLK_MESON_PLL_ROUND_CLOSEST    BIT(0)
> @@ -67,9 +63,6 @@ struct meson_clk_pll_data {
>         struct parm m;
>         struct parm n;
>         struct parm frac;
> -       struct parm od;
> -       struct parm od2;
> -       struct parm od3;
>         struct parm l;
>         struct parm rst;
>         const struct reg_sequence *init_regs;
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 5ed34566917c..e2d94498f098 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -19,163 +19,70 @@
>  static DEFINE_SPINLOCK(meson_clk_lock);
>
>  static const struct pll_rate_table gxbb_gp0_pll_rate_table[] = {
> -       PLL_RATE(96000000, 32, 1, 3),
> -       PLL_RATE(99000000, 33, 1, 3),
> -       PLL_RATE(102000000, 34, 1, 3),
> -       PLL_RATE(105000000, 35, 1, 3),
> -       PLL_RATE(108000000, 36, 1, 3),
> -       PLL_RATE(111000000, 37, 1, 3),
> -       PLL_RATE(114000000, 38, 1, 3),
> -       PLL_RATE(117000000, 39, 1, 3),
> -       PLL_RATE(120000000, 40, 1, 3),
> -       PLL_RATE(123000000, 41, 1, 3),
> -       PLL_RATE(126000000, 42, 1, 3),
> -       PLL_RATE(129000000, 43, 1, 3),
> -       PLL_RATE(132000000, 44, 1, 3),
> -       PLL_RATE(135000000, 45, 1, 3),
> -       PLL_RATE(138000000, 46, 1, 3),
> -       PLL_RATE(141000000, 47, 1, 3),
> -       PLL_RATE(144000000, 48, 1, 3),
> -       PLL_RATE(147000000, 49, 1, 3),
> -       PLL_RATE(150000000, 50, 1, 3),
> -       PLL_RATE(153000000, 51, 1, 3),
> -       PLL_RATE(156000000, 52, 1, 3),
> -       PLL_RATE(159000000, 53, 1, 3),
> -       PLL_RATE(162000000, 54, 1, 3),
> -       PLL_RATE(165000000, 55, 1, 3),
> -       PLL_RATE(168000000, 56, 1, 3),
> -       PLL_RATE(171000000, 57, 1, 3),
> -       PLL_RATE(174000000, 58, 1, 3),
> -       PLL_RATE(177000000, 59, 1, 3),
> -       PLL_RATE(180000000, 60, 1, 3),
> -       PLL_RATE(183000000, 61, 1, 3),
> -       PLL_RATE(186000000, 62, 1, 3),
> -       PLL_RATE(192000000, 32, 1, 2),
> -       PLL_RATE(198000000, 33, 1, 2),
> -       PLL_RATE(204000000, 34, 1, 2),
> -       PLL_RATE(210000000, 35, 1, 2),
> -       PLL_RATE(216000000, 36, 1, 2),
> -       PLL_RATE(222000000, 37, 1, 2),
> -       PLL_RATE(228000000, 38, 1, 2),
> -       PLL_RATE(234000000, 39, 1, 2),
> -       PLL_RATE(240000000, 40, 1, 2),
> -       PLL_RATE(246000000, 41, 1, 2),
> -       PLL_RATE(252000000, 42, 1, 2),
> -       PLL_RATE(258000000, 43, 1, 2),
> -       PLL_RATE(264000000, 44, 1, 2),
> -       PLL_RATE(270000000, 45, 1, 2),
> -       PLL_RATE(276000000, 46, 1, 2),
> -       PLL_RATE(282000000, 47, 1, 2),
> -       PLL_RATE(288000000, 48, 1, 2),
> -       PLL_RATE(294000000, 49, 1, 2),
> -       PLL_RATE(300000000, 50, 1, 2),
> -       PLL_RATE(306000000, 51, 1, 2),
> -       PLL_RATE(312000000, 52, 1, 2),
> -       PLL_RATE(318000000, 53, 1, 2),
> -       PLL_RATE(324000000, 54, 1, 2),
> -       PLL_RATE(330000000, 55, 1, 2),
> -       PLL_RATE(336000000, 56, 1, 2),
> -       PLL_RATE(342000000, 57, 1, 2),
> -       PLL_RATE(348000000, 58, 1, 2),
> -       PLL_RATE(354000000, 59, 1, 2),
> -       PLL_RATE(360000000, 60, 1, 2),
> -       PLL_RATE(366000000, 61, 1, 2),
> -       PLL_RATE(372000000, 62, 1, 2),
> -       PLL_RATE(384000000, 32, 1, 1),
> -       PLL_RATE(396000000, 33, 1, 1),
> -       PLL_RATE(408000000, 34, 1, 1),
> -       PLL_RATE(420000000, 35, 1, 1),
> -       PLL_RATE(432000000, 36, 1, 1),
> -       PLL_RATE(444000000, 37, 1, 1),
> -       PLL_RATE(456000000, 38, 1, 1),
> -       PLL_RATE(468000000, 39, 1, 1),
> -       PLL_RATE(480000000, 40, 1, 1),
> -       PLL_RATE(492000000, 41, 1, 1),
> -       PLL_RATE(504000000, 42, 1, 1),
> -       PLL_RATE(516000000, 43, 1, 1),
> -       PLL_RATE(528000000, 44, 1, 1),
> -       PLL_RATE(540000000, 45, 1, 1),
> -       PLL_RATE(552000000, 46, 1, 1),
> -       PLL_RATE(564000000, 47, 1, 1),
> -       PLL_RATE(576000000, 48, 1, 1),
> -       PLL_RATE(588000000, 49, 1, 1),
> -       PLL_RATE(600000000, 50, 1, 1),
> -       PLL_RATE(612000000, 51, 1, 1),
> -       PLL_RATE(624000000, 52, 1, 1),
> -       PLL_RATE(636000000, 53, 1, 1),
> -       PLL_RATE(648000000, 54, 1, 1),
> -       PLL_RATE(660000000, 55, 1, 1),
> -       PLL_RATE(672000000, 56, 1, 1),
> -       PLL_RATE(684000000, 57, 1, 1),
> -       PLL_RATE(696000000, 58, 1, 1),
> -       PLL_RATE(708000000, 59, 1, 1),
> -       PLL_RATE(720000000, 60, 1, 1),
> -       PLL_RATE(732000000, 61, 1, 1),
> -       PLL_RATE(744000000, 62, 1, 1),
> -       PLL_RATE(768000000, 32, 1, 0),
> -       PLL_RATE(792000000, 33, 1, 0),
> -       PLL_RATE(816000000, 34, 1, 0),
> -       PLL_RATE(840000000, 35, 1, 0),
> -       PLL_RATE(864000000, 36, 1, 0),
> -       PLL_RATE(888000000, 37, 1, 0),
> -       PLL_RATE(912000000, 38, 1, 0),
> -       PLL_RATE(936000000, 39, 1, 0),
> -       PLL_RATE(960000000, 40, 1, 0),
> -       PLL_RATE(984000000, 41, 1, 0),
> -       PLL_RATE(1008000000, 42, 1, 0),
> -       PLL_RATE(1032000000, 43, 1, 0),
> -       PLL_RATE(1056000000, 44, 1, 0),
> -       PLL_RATE(1080000000, 45, 1, 0),
> -       PLL_RATE(1104000000, 46, 1, 0),
> -       PLL_RATE(1128000000, 47, 1, 0),
> -       PLL_RATE(1152000000, 48, 1, 0),
> -       PLL_RATE(1176000000, 49, 1, 0),
> -       PLL_RATE(1200000000, 50, 1, 0),
> -       PLL_RATE(1224000000, 51, 1, 0),
> -       PLL_RATE(1248000000, 52, 1, 0),
> -       PLL_RATE(1272000000, 53, 1, 0),
> -       PLL_RATE(1296000000, 54, 1, 0),
> -       PLL_RATE(1320000000, 55, 1, 0),
> -       PLL_RATE(1344000000, 56, 1, 0),
> -       PLL_RATE(1368000000, 57, 1, 0),
> -       PLL_RATE(1392000000, 58, 1, 0),
> -       PLL_RATE(1416000000, 59, 1, 0),
> -       PLL_RATE(1440000000, 60, 1, 0),
> -       PLL_RATE(1464000000, 61, 1, 0),
> -       PLL_RATE(1488000000, 62, 1, 0),
> +       PLL_RATE(768000000, 32, 1),
> +       PLL_RATE(792000000, 33, 1),
> +       PLL_RATE(816000000, 34, 1),
> +       PLL_RATE(840000000, 35, 1),
> +       PLL_RATE(864000000, 36, 1),
> +       PLL_RATE(888000000, 37, 1),
> +       PLL_RATE(912000000, 38, 1),
> +       PLL_RATE(936000000, 39, 1),
> +       PLL_RATE(960000000, 40, 1),
> +       PLL_RATE(984000000, 41, 1),
> +       PLL_RATE(1008000000, 42, 1),
> +       PLL_RATE(1032000000, 43, 1),
> +       PLL_RATE(1056000000, 44, 1),
> +       PLL_RATE(1080000000, 45, 1),
> +       PLL_RATE(1104000000, 46, 1),
> +       PLL_RATE(1128000000, 47, 1),
> +       PLL_RATE(1152000000, 48, 1),
> +       PLL_RATE(1176000000, 49, 1),
> +       PLL_RATE(1200000000, 50, 1),
> +       PLL_RATE(1224000000, 51, 1),
> +       PLL_RATE(1248000000, 52, 1),
> +       PLL_RATE(1272000000, 53, 1),
> +       PLL_RATE(1296000000, 54, 1),
> +       PLL_RATE(1320000000, 55, 1),
> +       PLL_RATE(1344000000, 56, 1),
> +       PLL_RATE(1368000000, 57, 1),
> +       PLL_RATE(1392000000, 58, 1),
> +       PLL_RATE(1416000000, 59, 1),
> +       PLL_RATE(1440000000, 60, 1),
> +       PLL_RATE(1464000000, 61, 1),
> +       PLL_RATE(1488000000, 62, 1),
>         { /* sentinel */ },
>  };
>
>  static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
> -       PLL_RATE(504000000, 42, 1, 1),
> -       PLL_RATE(516000000, 43, 1, 1),
> -       PLL_RATE(528000000, 44, 1, 1),
> -       PLL_RATE(540000000, 45, 1, 1),
> -       PLL_RATE(552000000, 46, 1, 1),
> -       PLL_RATE(564000000, 47, 1, 1),
> -       PLL_RATE(576000000, 48, 1, 1),
> -       PLL_RATE(588000000, 49, 1, 1),
> -       PLL_RATE(600000000, 50, 1, 1),
> -       PLL_RATE(612000000, 51, 1, 1),
> -       PLL_RATE(624000000, 52, 1, 1),
> -       PLL_RATE(636000000, 53, 1, 1),
> -       PLL_RATE(648000000, 54, 1, 1),
> -       PLL_RATE(660000000, 55, 1, 1),
> -       PLL_RATE(672000000, 56, 1, 1),
> -       PLL_RATE(684000000, 57, 1, 1),
> -       PLL_RATE(696000000, 58, 1, 1),
> -       PLL_RATE(708000000, 59, 1, 1),
> -       PLL_RATE(720000000, 60, 1, 1),
> -       PLL_RATE(732000000, 61, 1, 1),
> -       PLL_RATE(744000000, 62, 1, 1),
> -       PLL_RATE(756000000, 63, 1, 1),
> -       PLL_RATE(768000000, 64, 1, 1),
> -       PLL_RATE(780000000, 65, 1, 1),
> -       PLL_RATE(792000000, 66, 1, 1),
> +       PLL_RATE(1008000000, 42, 1),
> +       PLL_RATE(1032000000, 43, 1),
> +       PLL_RATE(1056000000, 44, 1),
> +       PLL_RATE(1080000000, 45, 1),
> +       PLL_RATE(1104000000, 46, 1),
> +       PLL_RATE(1128000000, 47, 1),
> +       PLL_RATE(1152000000, 48, 1),
> +       PLL_RATE(1176000000, 49, 1),
> +       PLL_RATE(1200000000, 50, 1),
> +       PLL_RATE(1224000000, 51, 1),
> +       PLL_RATE(1248000000, 52, 1),
> +       PLL_RATE(1272000000, 53, 1),
> +       PLL_RATE(1296000000, 54, 1),
> +       PLL_RATE(1320000000, 55, 1),
> +       PLL_RATE(1344000000, 56, 1),
> +       PLL_RATE(1368000000, 57, 1),
> +       PLL_RATE(1392000000, 58, 1),
> +       PLL_RATE(1416000000, 59, 1),
> +       PLL_RATE(1440000000, 60, 1),
> +       PLL_RATE(1464000000, 61, 1),
> +       PLL_RATE(1488000000, 62, 1),
> +       PLL_RATE(1512000000, 63, 1),
> +       PLL_RATE(1536000000, 64, 1),
> +       PLL_RATE(1560000000, 65, 1),
> +       PLL_RATE(1584000000, 66, 1),
>         { /* sentinel */ },
>  };
>
> -static struct clk_regmap gxbb_fixed_pll = {
> +static struct clk_regmap gxbb_fixed_pll_dco = {
>         .data = &(struct meson_clk_pll_data){
>                 .en = {
>                         .reg_off = HHI_MPLL_CNTL,
> @@ -192,11 +99,6 @@ static struct clk_regmap gxbb_fixed_pll = {
>                         .shift   = 9,
>                         .width   = 5,
>                 },
> -               .od = {
> -                       .reg_off = HHI_MPLL_CNTL,
> -                       .shift   = 16,
> -                       .width   = 2,
> -               },
>                 .frac = {
>                         .reg_off = HHI_MPLL_CNTL2,
>                         .shift   = 0,
> @@ -214,7 +116,7 @@ static struct clk_regmap gxbb_fixed_pll = {
>                 },
>         },
>         .hw.init = &(struct clk_init_data){
> -               .name = "fixed_pll",
> +               .name = "fixed_pll_dco",
>                 .ops = &meson_clk_pll_ro_ops,
>                 .parent_names = (const char *[]){ "xtal" },
>                 .num_parents = 1,
> @@ -222,6 +124,21 @@ static struct clk_regmap gxbb_fixed_pll = {
>         },
>  };
>
> +static struct clk_regmap gxbb_fixed_pll = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_MPLL_CNTL,
> +               .shift = 16,
> +               .width = 2,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "fixed_pll",
> +               .ops = &clk_regmap_divider_ro_ops,
> +               .parent_names = (const char *[]){ "fixed_pll_dco" },
> +               .num_parents = 1,
> +       },
> +};
> +
>  static struct clk_fixed_factor gxbb_hdmi_pll_pre_mult = {
>         .mult = 2,
>         .div = 1,
> @@ -233,7 +150,7 @@ static struct clk_fixed_factor gxbb_hdmi_pll_pre_mult = {
>         },
>  };
>
> -static struct clk_regmap gxbb_hdmi_pll = {
> +static struct clk_regmap gxbb_hdmi_pll_dco = {
>         .data = &(struct meson_clk_pll_data){
>                 .en = {
>                         .reg_off = HHI_HDMI_PLL_CNTL,
> @@ -255,21 +172,6 @@ static struct clk_regmap gxbb_hdmi_pll = {
>                         .shift   = 0,
>                         .width   = 12,
>                 },
> -               .od = {
> -                       .reg_off = HHI_HDMI_PLL_CNTL2,
> -                       .shift   = 16,
> -                       .width   = 2,
> -               },
> -               .od2 = {
> -                       .reg_off = HHI_HDMI_PLL_CNTL2,
> -                       .shift   = 22,
> -                       .width   = 2,
> -               },
> -               .od3 = {
> -                       .reg_off = HHI_HDMI_PLL_CNTL2,
> -                       .shift   = 18,
> -                       .width   = 2,
> -               },
>                 .l = {
>                         .reg_off = HHI_HDMI_PLL_CNTL,
>                         .shift   = 31,
> @@ -282,7 +184,7 @@ static struct clk_regmap gxbb_hdmi_pll = {
>                 },
>         },
>         .hw.init = &(struct clk_init_data){
> -               .name = "hdmi_pll",
> +               .name = "hdmi_pll_dco",
>                 .ops = &meson_clk_pll_ro_ops,
>                 .parent_names = (const char *[]){ "hdmi_pll_pre_mult" },
>                 .num_parents = 1,
> @@ -290,70 +192,103 @@ static struct clk_regmap gxbb_hdmi_pll = {
>         },
>  };
>
> +static struct clk_regmap gxbb_hdmi_pll_od = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_HDMI_PLL_CNTL2,
> +               .shift = 16,
> +               .width = 2,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "hdmi_pll_od",
> +               .ops = &clk_regmap_divider_ro_ops,
> +               .parent_names = (const char *[]){ "hdmi_pll_dco" },
> +               .num_parents = 1,
> +               .flags = CLK_GET_RATE_NOCACHE,
why do we need CLK_GET_RATE_NOCACHE here?
also, shouldn't all _od clocks use CLK_SET_RATE_PARENT?
(this applies to all new _od clocks, not just this one)


Regards
Martin
