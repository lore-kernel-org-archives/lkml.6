Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE65ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2BE2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO/fGK6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2BE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeIYWuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:50:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46161 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeIYWuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:50:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id q4-v6so11968522otf.13;
        Tue, 25 Sep 2018 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wI1RVBlacRvrrVpC6wppEEhOyrG/p26OJ7ywqmCdrds=;
        b=hO/fGK6tQEIfD16zOcXpARb6Y8+s/ay5rrP0RWRoW7caJGoxFUNUATnrNCog9Tz7T0
         g3yOJs8C9OzGynUlo5mrQ5rBwqZ1D5VpyTFGfTnOAJCaZlWxZn5sfCFJ/4DjL80cskR7
         HlXHUFEN6bdg/y16fLPHCoT95M1lVAfflHKFK1fzg3ADGQDSQMiT/W+d5bSSIn59f2s5
         RUBXzN5wtsTHz29pXtkKpzXC1RVguyuSynjon3YcWtNm3atsqCf21IvKsp8BrFcuvczV
         LICYfOZghwBi2thKal/e12YQsp6zNBUhKf+ekbqV/VSdSmPTHDqQsozUK+nhlJbsIqMs
         C16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wI1RVBlacRvrrVpC6wppEEhOyrG/p26OJ7ywqmCdrds=;
        b=ccQTGZMg4XCVM/KX83Iyky0ldBT0ARdbswOzDbN3Nrj66GJOmzv+KIObSfPln8mvME
         Lxa7J3XVQJ3cq50igBn9kllL3g+1tzOhE+eH3b3ng8ggEr7sXGLL65+xn4YKyisYVpHI
         954iCbcZcLSd2MbGKPlIn7yhWnMbwgZg3Lv4ZN2JTwOXRd+mFr55/8UaQimBd+iduAwg
         EaZ3Qem5imGN1rLQrITgAg6st2tG37KzNrrILina5cb/GXH+oZiXu3PoPBf16pB9ypmw
         20ngVNIbTda4ZT2E7q+hHVLse10qAhmDA5cR6k8Y0ZVMgUjAj1p3W1MvoMOKY6yidQ73
         6IkQ==
X-Gm-Message-State: ABuFfoiiNIRw8WvBfq0qYX3VYX2bMwpLeXIbabEEtekDdLz5+Rg9WndD
        7+TRu9hB7lHvwtqSVZz4fqLPVXeaMffjqq6lm9g=
X-Google-Smtp-Source: ACcGV6352YrdW7dFFYc2MSm6wK+1UWdZwR5fRCgfmLggAwkLOBf4tbqIp0KdWDDMcyQyh52xizv7ppWsmZkr+gfTdgQ=
X-Received: by 2002:a9d:3984:: with SMTP id y4-v6mr968813otb.215.1537893732908;
 Tue, 25 Sep 2018 09:42:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d28:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 09:42:12
 -0700 (PDT)
In-Reply-To: <1537785597-26499-5-git-send-email-abel.vesa@nxp.com>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com> <1537785597-26499-5-git-send-email-abel.vesa@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 25 Sep 2018 13:42:12 -0300
Message-ID: <CAOMZO5D7yLUzriOub4RWsq1K8_fTj6c0LFOnSZwHyjqMPYu=0A@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] clk: imx: add imx composite clock
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Mon, Sep 24, 2018 at 7:39 AM, Abel Vesa <abel.vesa@nxp.com> wrote:

> +static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
> +                                               unsigned long rate,
> +                                               unsigned long *prate)
> +{
> +       int prediv_value;
> +       int div_value;
> +
> +       imx_clk_composite_compute_dividers(rate, *prate,
> +                                               &prediv_value, &div_value);
> +
> +       rate = DIV_ROUND_UP_ULL((u64)*prate, prediv_value);

You assing a value to 'rate' here.

> +       rate = DIV_ROUND_UP_ULL((u64)rate, div_value);

And then overwrite it immediately after.

Is this really the intended behavior?
