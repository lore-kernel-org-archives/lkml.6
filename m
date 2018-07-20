Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D959520671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qvIoHC+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D959520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbeGTTuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:50:18 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46687 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387994AbeGTTuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:50:17 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so23091630oie.13;
        Fri, 20 Jul 2018 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/y2eg+fub4BqyFXILy0cALWpWuQf8PP7fvxGt+2TBI=;
        b=qvIoHC+2txONMDLRGEix2ejnYLdJ43SZtJHL9vM8iOgc0cGMUJfZuIKeolnWPK5iL7
         fylClXJQyEt/7iTQvXGh48lOGgxUtUPiNvURKW6EzwtJeUAL8+x0J9wA5h2mDXJJlEU6
         sDjkXiD35fv66wLdkypo+llecf5DT1epJ6ATp/OjNA1+VPTBDJycMqEe8osaxgL12bUJ
         c4e0+IIsvFRmZR1+z794LxqAw5+GmDK56mMIUQeHfYTwbp3fyip2xDqYsgrpX8MOSJwn
         QFB7GjdY04+A62pdR/0OWmbBsgPZzp7M2Q6TEH/V9G7u8cg+qS+7//WuutQurEoIOqik
         qpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/y2eg+fub4BqyFXILy0cALWpWuQf8PP7fvxGt+2TBI=;
        b=ZGVwNTC4N7RYVbo9K8SF8pHazs+i5N63O6I4bjTsFg3MCVsRe41iA4g4l9fLTU/wSo
         12QdOPUJbGREdZ2iAePVxZebm+zZ9H5QzBo3K0Ne4LJy20gv28RkLwcANNjh3ByxShbC
         YdfIE4YVHX2yfW+P5I/3N44/RWNxa5N1sdfOofIkLXehHhDzPV7cbu/fZcRERdQsVu5S
         YgHYxzz7sInZ7lt6/UdoPWyYYfU0+U2mfjVQ5Z7JNql6Kc5kS7d3T+2BuoeY37nbAn8H
         q3aCB6sL2GomMtfImj7sIm27HNykC7LUQVDpRKRs9VQt+toA+AIvl0VsTLVB1ETBLUmA
         ws5g==
X-Gm-Message-State: AOUpUlEPYlVtVDvlpoVchlYhaZ63o715eLtB9pvLK2EU3ALpPPb9unnk
        kzFxCS2C/rpZIgnZtk63/1i+ijiY96BvQXKLJro=
X-Google-Smtp-Source: AAOMgpeJEVjpLEz6Lke4QWTTH2ibhzTWleuzr9mjMBLsfhUanmXoB0pSkI+zuAXs/sq3mE/S/sPIfbgK13rAphmK3f8=
X-Received: by 2002:aca:e748:: with SMTP id e69-v6mr17325oih.263.1532113241834;
 Fri, 20 Jul 2018 12:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <1532079581-978-1-git-send-email-narmstrong@baylibre.com> <1532079581-978-3-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1532079581-978-3-git-send-email-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 20 Jul 2018 21:00:31 +0200
Message-ID: <CAFBinCAsfJ+5xgFM3mDAPU18N=1VFzjQZNQc5R_Ri5=BsMAKYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: meson-gxbb: Add video clocks
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Jul 20, 2018 at 11:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the clocks entries used in the video clock path, the clock path
> is doubled to permit having different synchronized clocks for different
> parts of the video pipeline.
maybe you can add the comment about CLK_GET_RATE_NOCACHE here as well

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/gxbb.c              | 667 ++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/gxbb.h              |  24 +-
>  include/dt-bindings/clock/gxbb-clkc.h |  17 +
>  3 files changed, 706 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index f79ea33..5fabedf 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -1508,6 +1508,570 @@ static struct clk_regmap gxbb_vapb = {
>         },
>  };
>
> +/* Video Clocks */
> +
> +static struct clk_regmap gxbb_vid_pll_div = {
> +       .data = &(struct meson_vid_pll_div_data){
> +               .val = {
> +                       .reg_off = HHI_VID_PLL_CLK_DIV,
> +                       .shift   = 0,
> +                       .width   = 15,
> +               },
> +               .sel = {
> +                       .reg_off = HHI_VID_PLL_CLK_DIV,
> +                       .shift   = 16,
> +                       .width   = 2,
> +               },
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vid_pll_div",
> +               .ops = &meson_vid_pll_div_ro_ops,
> +               .parent_names = (const char *[]){ "hdmi_pll" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static u32 mux_table_vid_pll[] = { 0, 1 };
you can drop this mux table

> +const char *gxbb_vid_pll_parent_names[] = { "vid_pll_div", "hdmi_pll" };
> +
> +static struct clk_regmap gxbb_vid_pll_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_VID_PLL_CLK_DIV,
> +               .mask = 0x1,
> +               .shift = 18,
> +               .table = mux_table_vid_pll,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vid_pll_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               /*
> +                * bit 18 selects from 2 possible parents:
> +                * vid_pll_div or hdmi_pll
> +                */
> +               .parent_names = gxbb_vid_pll_parent_names,
> +               .num_parents = ARRAY_SIZE(gxbb_vid_pll_parent_names),
> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vid_pll = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_PLL_CLK_DIV,
> +               .bit_idx = 19,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vid_pll",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vid_pll_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static u32 mux_table_vclk[] = { 0, 1, 2, 3, 4, 5, 6 };
you can drop this mux table

> +const char *gxbb_vclk_parent_names[] = {
> +       "vid_pll", "fclk_div4", "fclk_div3", "fclk_div5", "vid_pll",
> +       "fclk_div7", "mpll1",
> +};
> +
> +static struct clk_regmap gxbb_vclk_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .mask = 0x7,
> +               .shift = 16,
> +               .table = mux_table_vclk,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               /*
> +                * bits 16:18 selects from 8 possible parents:
> +                * vid_pll, fclk_div4, fclk_div3, fclk_div5,
> +                * vid_pll, fclk_div7, mp1
> +                */
> +               .parent_names = gxbb_vclk_parent_names,
> +               .num_parents = ARRAY_SIZE(gxbb_vclk_parent_names),
> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .mask = 0x7,
> +               .shift = 16,
> +               .table = mux_table_vclk,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk2_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               /*
> +                * bits 16:18 selects from 8 possible parents:
> +                * vid_pll, fclk_div4, fclk_div3, fclk_div5,
> +                * vid_pll, fclk_div7, mp1
> +                */
> +               .parent_names = gxbb_vclk_parent_names,
> +               .num_parents = ARRAY_SIZE(gxbb_vclk_parent_names),
> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_input = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_DIV,
> +               .bit_idx = 16,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_input",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_input = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_DIV,
> +               .bit_idx = 16,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_input",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_VID_CLK_DIV,
> +               .shift = 0,
> +               .width = 8,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_div",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_names = (const char *[]){ "vclk_input" },
> +               .num_parents = 1,
> +               .flags = CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_VIID_CLK_DIV,
> +               .shift = 0,
> +               .width = 8,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk2_div",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_names = (const char *[]){ "vclk2_input" },
> +               .num_parents = 1,
> +               .flags = CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 19,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk_div" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2 = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 19,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2_div" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div1 = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 0,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_div1",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div2_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 1,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_div2_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div4_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 2,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_div4_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div6_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 3,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_div6_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div12_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 4,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_div12_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div1 = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 0,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_div1",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div2_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 1,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_div2_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div4_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 2,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_div4_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div6_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 3,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_div6_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div12_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 4,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_div12_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk_div2 = {
> +       .mult = 1,
> +       .div = 2,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_div2",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk_div2_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk_div4 = {
> +       .mult = 1,
> +       .div = 4,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_div4",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk_div4_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk_div6 = {
> +       .mult = 1,
> +       .div = 6,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_div6",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk_div6_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk_div12 = {
> +       .mult = 1,
> +       .div = 12,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_div12",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk_div12_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk2_div2 = {
> +       .mult = 1,
> +       .div = 2,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk2_div2",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk2_div2_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk2_div4 = {
> +       .mult = 1,
> +       .div = 4,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk2_div4",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk2_div4_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk2_div6 = {
> +       .mult = 1,
> +       .div = 6,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk2_div6",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk2_div6_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk2_div12 = {
> +       .mult = 1,
> +       .div = 12,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk2_div12",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk2_div12_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
> +const char *gxbb_cts_parent_names[] = {
> +       "vclk_div1", "vclk_div2", "vclk_div4", "vclk_div6",
> +       "vclk_div12", "vclk2_div1", "vclk2_div2", "vclk2_div4",
> +       "vclk2_div6", "vclk2_div12"
> +};
> +
> +static struct clk_regmap gxbb_cts_enci_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_VID_CLK_DIV,
> +               .mask = 0xf,
> +               .shift = 28,
> +               .table = mux_table_cts_sel,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cts_enci_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_names = gxbb_cts_parent_names,
> +               .num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_cts_encp_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_VID_CLK_DIV,
> +               .mask = 0xf,
> +               .shift = 20,
> +               .table = mux_table_cts_sel,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cts_encp_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_names = gxbb_cts_parent_names,
> +               .num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_cts_vdac_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_VIID_CLK_DIV,
> +               .mask = 0xf,
> +               .shift = 28,
> +               .table = mux_table_cts_sel,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cts_vdac_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_names = gxbb_cts_parent_names,
> +               .num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +/* TOFIX: add support for cts_tcon */
> +static u32 mux_table_hdmi_tx_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
> +const char *gxbb_cts_hdmi_tx_parent_names[] = {
> +       "vclk_div1", "vclk_div2", "vclk_div4", "vclk_div6",
> +       "vclk_div12", "vclk2_div1", "vclk2_div2", "vclk2_div4",
> +       "vclk2_div6", "vclk2_div12"
> +};
> +
> +static struct clk_regmap gxbb_hdmi_tx_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_HDMI_CLK_CNTL,
> +               .mask = 0xf,
> +               .shift = 16,
> +               .table = mux_table_hdmi_tx_sel,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "hdmi_tx_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               /*
> +                * bits 31:28 selects from 12 possible parents:
> +                * vclk_div1, vclk_div2, vclk_div4, vclk_div6, vclk_div12
> +                * vclk2_div1, vclk2_div2, vclk2_div4, vclk2_div6, vclk2_div12,
> +                * cts_tcon
> +                */
> +               .parent_names = gxbb_cts_hdmi_tx_parent_names,
> +               .num_parents = ARRAY_SIZE(gxbb_cts_hdmi_tx_parent_names),
> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_cts_enci = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL2,
> +               .bit_idx = 0,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "cts_enci",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "cts_enci_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_cts_encp = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL2,
> +               .bit_idx = 2,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "cts_encp",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "cts_encp_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_cts_vdac = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL2,
> +               .bit_idx = 4,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "cts_vdac",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "cts_vdac_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_hdmi_tx = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL2,
> +               .bit_idx = 5,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "hdmi_tx",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "hdmi_tx_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
>  /* VDEC clocks */
>
>  static const char * const gxbb_vdec_parent_names[] = {
> @@ -1919,6 +2483,43 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
>                 [CLKID_HDMI_PLL_OD2]        = &gxbb_hdmi_pll_od2.hw,
>                 [CLKID_SYS_PLL_DCO]         = &gxbb_sys_pll_dco.hw,
>                 [CLKID_GP0_PLL_DCO]         = &gxbb_gp0_pll_dco.hw,
> +               [CLKID_VID_PLL_DIV]         = &gxbb_vid_pll_div.hw,
> +               [CLKID_VID_PLL_SEL]         = &gxbb_vid_pll_sel.hw,
> +               [CLKID_VID_PLL]             = &gxbb_vid_pll.hw,
> +               [CLKID_VCLK_SEL]            = &gxbb_vclk_sel.hw,
> +               [CLKID_VCLK2_SEL]           = &gxbb_vclk2_sel.hw,
> +               [CLKID_VCLK_INPUT]          = &gxbb_vclk_input.hw,
> +               [CLKID_VCLK2_INPUT]         = &gxbb_vclk2_input.hw,
> +               [CLKID_VCLK_DIV]            = &gxbb_vclk_div.hw,
> +               [CLKID_VCLK2_DIV]           = &gxbb_vclk2_div.hw,
> +               [CLKID_VCLK]                = &gxbb_vclk.hw,
> +               [CLKID_VCLK2]               = &gxbb_vclk2.hw,
> +               [CLKID_VCLK_DIV1]           = &gxbb_vclk_div1.hw,
> +               [CLKID_VCLK_DIV2_EN]        = &gxbb_vclk_div2_en.hw,
> +               [CLKID_VCLK_DIV2]           = &gxbb_vclk_div2.hw,
> +               [CLKID_VCLK_DIV4_EN]        = &gxbb_vclk_div4_en.hw,
> +               [CLKID_VCLK_DIV4]           = &gxbb_vclk_div4.hw,
> +               [CLKID_VCLK_DIV6_EN]        = &gxbb_vclk_div6_en.hw,
> +               [CLKID_VCLK_DIV6]           = &gxbb_vclk_div6.hw,
> +               [CLKID_VCLK_DIV12_EN]       = &gxbb_vclk_div12_en.hw,
> +               [CLKID_VCLK_DIV12]          = &gxbb_vclk_div12.hw,
> +               [CLKID_VCLK2_DIV1]          = &gxbb_vclk2_div1.hw,
> +               [CLKID_VCLK2_DIV2_EN]       = &gxbb_vclk2_div2_en.hw,
> +               [CLKID_VCLK2_DIV2]          = &gxbb_vclk2_div2.hw,
> +               [CLKID_VCLK2_DIV4_EN]       = &gxbb_vclk2_div4_en.hw,
> +               [CLKID_VCLK2_DIV4]          = &gxbb_vclk2_div4.hw,
> +               [CLKID_VCLK2_DIV6_EN]       = &gxbb_vclk2_div6_en.hw,
> +               [CLKID_VCLK2_DIV6]          = &gxbb_vclk2_div6.hw,
> +               [CLKID_VCLK2_DIV12_EN]      = &gxbb_vclk2_div12_en.hw,
> +               [CLKID_VCLK2_DIV12]         = &gxbb_vclk2_div12.hw,
> +               [CLKID_CTS_ENCI_SEL]        = &gxbb_cts_enci_sel.hw,
> +               [CLKID_CTS_ENCP_SEL]        = &gxbb_cts_encp_sel.hw,
> +               [CLKID_CTS_VDAC_SEL]        = &gxbb_cts_vdac_sel.hw,
> +               [CLKID_HDMI_TX_SEL]         = &gxbb_hdmi_tx_sel.hw,
> +               [CLKID_CTS_ENCI]            = &gxbb_cts_enci.hw,
> +               [CLKID_CTS_ENCP]            = &gxbb_cts_encp.hw,
> +               [CLKID_CTS_VDAC]            = &gxbb_cts_vdac.hw,
> +               [CLKID_HDMI_TX]             = &gxbb_hdmi_tx.hw,
>                 [NR_CLKS]                   = NULL,
>         },
>         .num = NR_CLKS,
> @@ -2090,6 +2691,43 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
>                 [CLKID_HDMI_PLL_OD2]        = &gxl_hdmi_pll_od2.hw,
>                 [CLKID_SYS_PLL_DCO]         = &gxbb_sys_pll_dco.hw,
>                 [CLKID_GP0_PLL_DCO]         = &gxl_gp0_pll_dco.hw,
> +               [CLKID_VID_PLL_DIV]         = &gxbb_vid_pll_div.hw,
> +               [CLKID_VID_PLL_SEL]         = &gxbb_vid_pll_sel.hw,
> +               [CLKID_VID_PLL]             = &gxbb_vid_pll.hw,
> +               [CLKID_VCLK_SEL]            = &gxbb_vclk_sel.hw,
> +               [CLKID_VCLK2_SEL]           = &gxbb_vclk2_sel.hw,
> +               [CLKID_VCLK_INPUT]          = &gxbb_vclk_input.hw,
> +               [CLKID_VCLK2_INPUT]         = &gxbb_vclk2_input.hw,
> +               [CLKID_VCLK_DIV]            = &gxbb_vclk_div.hw,
> +               [CLKID_VCLK2_DIV]           = &gxbb_vclk2_div.hw,
> +               [CLKID_VCLK]                = &gxbb_vclk.hw,
> +               [CLKID_VCLK2]               = &gxbb_vclk2.hw,
> +               [CLKID_VCLK_DIV1]           = &gxbb_vclk_div1.hw,
> +               [CLKID_VCLK_DIV2_EN]        = &gxbb_vclk_div2_en.hw,
> +               [CLKID_VCLK_DIV2]           = &gxbb_vclk_div2.hw,
> +               [CLKID_VCLK_DIV4_EN]        = &gxbb_vclk_div4_en.hw,
> +               [CLKID_VCLK_DIV4]           = &gxbb_vclk_div4.hw,
> +               [CLKID_VCLK_DIV6_EN]        = &gxbb_vclk_div6_en.hw,
> +               [CLKID_VCLK_DIV6]           = &gxbb_vclk_div6.hw,
> +               [CLKID_VCLK_DIV12_EN]       = &gxbb_vclk_div12_en.hw,
> +               [CLKID_VCLK_DIV12]          = &gxbb_vclk_div12.hw,
> +               [CLKID_VCLK2_DIV1]          = &gxbb_vclk2_div1.hw,
> +               [CLKID_VCLK2_DIV2_EN]       = &gxbb_vclk2_div2_en.hw,
> +               [CLKID_VCLK2_DIV2]          = &gxbb_vclk2_div2.hw,
> +               [CLKID_VCLK2_DIV4_EN]       = &gxbb_vclk2_div4_en.hw,
> +               [CLKID_VCLK2_DIV4]          = &gxbb_vclk2_div4.hw,
> +               [CLKID_VCLK2_DIV6_EN]       = &gxbb_vclk2_div6_en.hw,
> +               [CLKID_VCLK2_DIV6]          = &gxbb_vclk2_div6.hw,
> +               [CLKID_VCLK2_DIV12_EN]      = &gxbb_vclk2_div12_en.hw,
> +               [CLKID_VCLK2_DIV12]         = &gxbb_vclk2_div12.hw,
> +               [CLKID_CTS_ENCI_SEL]        = &gxbb_cts_enci_sel.hw,
> +               [CLKID_CTS_ENCP_SEL]        = &gxbb_cts_encp_sel.hw,
> +               [CLKID_CTS_VDAC_SEL]        = &gxbb_cts_vdac_sel.hw,
> +               [CLKID_HDMI_TX_SEL]         = &gxbb_hdmi_tx_sel.hw,
> +               [CLKID_CTS_ENCI]            = &gxbb_cts_enci.hw,
> +               [CLKID_CTS_ENCP]            = &gxbb_cts_encp.hw,
> +               [CLKID_CTS_VDAC]            = &gxbb_cts_vdac.hw,
> +               [CLKID_HDMI_TX]             = &gxbb_hdmi_tx.hw,
>                 [NR_CLKS]                   = NULL,
>         },
>         .num = NR_CLKS,
> @@ -2265,6 +2903,35 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
>         &gxbb_hdmi_pll_dco,
>         &gxbb_sys_pll_dco,
>         &gxbb_gp0_pll,
> +       &gxbb_vid_pll,
> +       &gxbb_vid_pll_sel,
> +       &gxbb_vid_pll_div,
> +       &gxbb_vclk,
> +       &gxbb_vclk_sel,
> +       &gxbb_vclk_div,
> +       &gxbb_vclk_input,
> +       &gxbb_vclk_div1,
> +       &gxbb_vclk_div2_en,
> +       &gxbb_vclk_div4_en,
> +       &gxbb_vclk_div6_en,
> +       &gxbb_vclk_div12_en,
> +       &gxbb_vclk2,
> +       &gxbb_vclk2_sel,
> +       &gxbb_vclk2_div,
> +       &gxbb_vclk2_input,
> +       &gxbb_vclk2_div1,
> +       &gxbb_vclk2_div2_en,
> +       &gxbb_vclk2_div4_en,
> +       &gxbb_vclk2_div6_en,
> +       &gxbb_vclk2_div12_en,
> +       &gxbb_cts_enci,
> +       &gxbb_cts_enci_sel,
> +       &gxbb_cts_encp,
> +       &gxbb_cts_encp_sel,
> +       &gxbb_cts_vdac,
> +       &gxbb_cts_vdac_sel,
> +       &gxbb_hdmi_tx,
> +       &gxbb_hdmi_tx_sel,
>  };
>
>  struct clkc_data {
> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
> index 72bc077..171b7d8 100644
> --- a/drivers/clk/meson/gxbb.h
> +++ b/drivers/clk/meson/gxbb.h
> @@ -165,8 +165,28 @@
>  #define CLKID_HDMI_PLL_OD2       163
>  #define CLKID_SYS_PLL_DCO        164
>  #define CLKID_GP0_PLL_DCO        165
> -
> -#define NR_CLKS                          166
> +#define CLKID_VID_PLL_SEL        167
> +#define CLKID_VID_PLL_DIV        168
> +#define CLKID_VCLK_SEL           169
> +#define CLKID_VCLK2_SEL                  170
> +#define CLKID_VCLK_INPUT         171
> +#define CLKID_VCLK2_INPUT        172
> +#define CLKID_VCLK_DIV           173
> +#define CLKID_VCLK2_DIV                  174
> +#define CLKID_VCLK_DIV2_EN       177
> +#define CLKID_VCLK_DIV4_EN       178
> +#define CLKID_VCLK_DIV6_EN       179
> +#define CLKID_VCLK_DIV12_EN      180
> +#define CLKID_VCLK2_DIV2_EN      181
> +#define CLKID_VCLK2_DIV4_EN      182
> +#define CLKID_VCLK2_DIV6_EN      183
> +#define CLKID_VCLK2_DIV12_EN     184
> +#define CLKID_CTS_ENCI_SEL       195
> +#define CLKID_CTS_ENCP_SEL       196
> +#define CLKID_CTS_VDAC_SEL       197
> +#define CLKID_HDMI_TX_SEL        198
> +
> +#define NR_CLKS                          203
>
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/gxbb-clkc.h>
> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
> index 3979d48..9f7b99e 100644
> --- a/include/dt-bindings/clock/gxbb-clkc.h
> +++ b/include/dt-bindings/clock/gxbb-clkc.h
shouldn't this go into a separate patch?

> @@ -128,5 +128,22 @@
>  #define CLKID_VDEC_1           153
>  #define CLKID_VDEC_HEVC                156
>  #define CLKID_GEN_CLK          159
> +#define CLKID_VID_PLL          166
> +#define CLKID_VCLK             175
> +#define CLKID_VCLK2            176
> +#define CLKID_VCLK_DIV1                185
> +#define CLKID_VCLK_DIV2                186
> +#define CLKID_VCLK_DIV4                187
> +#define CLKID_VCLK_DIV6                188
> +#define CLKID_VCLK_DIV12       189
> +#define CLKID_VCLK2_DIV1       190
> +#define CLKID_VCLK2_DIV2       191
> +#define CLKID_VCLK2_DIV4       192
> +#define CLKID_VCLK2_DIV6       193
> +#define CLKID_VCLK2_DIV12      194
at first I was confused why you need to export all the dividers,
instead of simply calling clk_set_rate with "parent_rate (taken vom
VCLK or VCLK2) divided by N"
then I noticed that the four muxes below can use VCLK *or* VCLK2
dividers as input (as far as I remember this is different on Meson8b:
there the muxes below take either the VCLK dividers or the VCLK2
dividers as input, but not both)

> +#define CLKID_CTS_ENCI         199
> +#define CLKID_CTS_ENCP         200
> +#define CLKID_CTS_VDAC         201
> +#define CLKID_HDMI_TX          202
is my assumption correct that you need to choose a specific input
clock (VCLK or VCLK2) for a specific use-case (ENCI, ENCP, VDAC,
HDMI_TX)?
let's say HDMI uses VLKC2 as input (I'm not sure if it really does):
could you skip the VCLK_DIV_* parents in the HDMI_TX clock definition
- or does the selection of a specific parent clock (VCLK or VCLK2)
depend on the output rate?


Regards
Martin
