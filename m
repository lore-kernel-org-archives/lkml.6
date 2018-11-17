Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8715C04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9762920866
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fUrnAb0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9762920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeKRH1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 02:27:33 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34675 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeKRH1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 02:27:32 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so4100473oig.1;
        Sat, 17 Nov 2018 13:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Du8niyBRXn+iYZcB66ZJ+WKL2QvIqXDgOlBCkGq7LNA=;
        b=fUrnAb0VzBNFTYbXO+N8PPqD3eWhoZIMU82KRnrj4iFfw6VY2F92X0+iwyrXpd0l2j
         uQ7AjKUCsnD961gWAJYXM2oXH2hxkM8U2moX+OGaujcphzhasCh5JFe/DMmox8iazgfa
         9QSEgWn7az3846HMDytZ7Hwxujnhn6z46jghbVb9Mq163YsPFbNc6fqG2wbC/kN+xwkJ
         4YllnWSnoBf8eDd7AFazw8zySuZ9pEMWgNnhWtULDSSRAGrRJV/ni4jcGJajSSiPsNjZ
         RRG+MvO47abfoQYDOxqRUIjS7IpfPD5qZTaHKTN8uh31B5INDRBconzhZMTOuGQjNPYc
         ku7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Du8niyBRXn+iYZcB66ZJ+WKL2QvIqXDgOlBCkGq7LNA=;
        b=I1TJTNJ6tGUIxIILfpPLv9BOzqfnd9c6iJvOqXV4ijZRjsbduvTdz+6Xfd6BVPrJJu
         ys2pM3Z0+5+cGMkZF0kZ0PawnOiTkrpCxpDzpV7hn5RFCDnh4O4jH3NFzwbbeabT7CBo
         ovekuCIveLeiuzXZTzH4/IjcxZmJTqwTHqDq2TW2+ErBEqzaVYc77cDC9PcOPJG0TuG5
         cEIGEPV5i2mboATPafUx3jyi5tQiO1bsHhzke6mDfodMgGzNGtW0P8cchLzApJxv1k0R
         7vnWfeFZf0g8BvYHAEYLGVa2wkTqqNZOnT6iPfIA8bt+FOZ0y/c36fSpTAB3mC7T7Rfu
         190Q==
X-Gm-Message-State: AGRZ1gJggG3g1bYTlDRa/K4qp6lPluCcmSz8DaU84WiDx32y1OMyAf7M
        UsTT/QFhpQMqPBQu1V1sadHbxhrx+df7elnDM2TwPdCLxek=
X-Google-Smtp-Source: AJdET5cNANxsJlqe+kuVWT915TApLbovvWvFMMA/BBrJ/UAp9dn/xE8bpJjUMObwjaxlat1ZOX6b8Wjy7g8R4ceuHvg=
X-Received: by 2002:aca:4202:: with SMTP id p2-v6mr3686474oia.41.1542488974269;
 Sat, 17 Nov 2018 13:09:34 -0800 (PST)
MIME-Version: 1.0
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com> <1541516257-16157-5-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1541516257-16157-5-git-send-email-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 17 Nov 2018 22:09:23 +0100
Message-ID: <CAFBinCBSMNGKB5HSM_x5xgnxXZSymxrLE826AYLqwa3BMG4_KQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] clk: meson-gxbb: Add video clocks
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

On Tue, Nov 6, 2018 at 3:59 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the clocks entries used in the video clock path, the clock path
> is doubled to permit having different synchronized clocks for different
> parts of the video pipeline.
>
> All dividers are flagged with CLK_GET_RATE_NOCACHE, and all gates are flagged
> with CLK_IGNORE_UNUSED since they are currently directly handled by the
> Meson DRM Driver.
> Once the DRM Driver is fully migrated to using the Common Clock Framework
> to handle the video clock tree, the CLK_GET_RATE_NOCACHE and CLK_IGNORE_UNUSED
> will be dropped.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I'm aware that this has been applied already
I only found a few nit-picks - so this is looking good!

> ---
>  drivers/clk/meson/gxbb.c | 722 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 722 insertions(+)
>
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 0fd354b..30fbf8f 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -1558,6 +1558,616 @@ static struct clk_regmap gxbb_vapb = {
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
> +const char *gxbb_vid_pll_parent_names[] = { "vid_pll_div", "hdmi_pll" };
> +
> +static struct clk_regmap gxbb_vid_pll_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_VID_PLL_CLK_DIV,
> +               .mask = 0x1,
> +               .shift = 18,
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
you could get rid of the comment if you inline
gxbb_vid_pll_parent_names and set num_parents to 2 manually

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
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               /*
> +                * bits 16:18 selects from 8 possible parents:
> +                * vid_pll, fclk_div4, fclk_div3, fclk_div5,
> +                * vid_pll, fclk_div7, mp1
> +                */
does it select from 7 or 8 parents? you are listing only 7
the same applies for the usages below

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
for the fclk_divX clocks we use the clk_fixed_factor as parent of the gate
you're doing it the other way around here (as well as for the vclk1
clocks above and the other vclk2 clocks below)
I'm not sure which way is correct though

[snip]


Regards
Martin
