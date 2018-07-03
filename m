Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9E6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B1824267
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ua5lcL8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B1824267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933442AbeGCJY0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:24:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32781 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbeGCJYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:24:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id k7-v6so1202523wrq.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b79XSTn0KT5R6qicf0lNaldrcYQcu0udrGD2/v8HRP0=;
        b=ua5lcL8nR2GTrPsfBVrgVV3yMiDiRKMmygFGidb92BforDaaxgsM6CyZ7ibrB8KYa0
         +3Ji0kDCW+1dpgNEmmEW9KyZiLR7u02V0J8YULXeJr7hBUC6DGs8nON2WL/Iv0YXAaab
         GS9jbayvnpWDo4gnB9oIArWeJdqeVSsOBQQx5/sVvJHvoMX+zHGMNuh3RTu2yf10aLqP
         tN8JrhwKTpeqoq8S6tGazIlz4rEGaDiz3fDTua/n7sQTgLJQQ/TUlpTyRGCYfy7YFXU/
         GV64vJgIW35DlUHwsaPWEUWxWBuBuxmRTYLMKMs8SS4Xm+rJjdrCBOTmMWp5rOD/LN33
         hUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b79XSTn0KT5R6qicf0lNaldrcYQcu0udrGD2/v8HRP0=;
        b=ULt9BUWqPrTi9ASOFS/iY6eVDqsomzWRVsDrnx8Qu4ip6uJlMQ4gJgLjM2xFg7d6dN
         393coUJWreP1lv5ZdvJFd0wU/dmC7YHgsvQvq7ijNkZ1u8u/z+dg1I9rIQb+9EIEGQDz
         DCtjjpJaWGJG3pZyYZe+328fnzRRvfTOfZ7Tbd6pvrXGQ4549ui6yFgesqRDqowm223K
         GdCLgJgXIF84VmieuaOLoPGr0S5HZvOFa8tehpXUlwYhzQWapPmbpPgXdvnzOTarqNtC
         1yIWrOXF3dnv2RdTz0myIoBppFYje+P/Ij1OoZMXnytQGioJLYCozZokL+/paliMzq6W
         YvCQ==
X-Gm-Message-State: APt69E221zNGE0JrraKIKKEp5hCZmEYln8gndoCfWZKNgzFWKWEeh37q
        yuRzj1dKJkWTopubIsiqu3qz0g==
X-Google-Smtp-Source: AAOMgpfvklOSsFTwz3exl7DfFt/xDVy0vLIm1TSdV7CaZkwZL8aYoK0fcjvHDLL8HFaEycQveyuIWw==
X-Received: by 2002:a5d:44ca:: with SMTP id z10-v6mr22896093wrr.210.1530609863593;
        Tue, 03 Jul 2018 02:24:23 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14-v6sm772420wma.11.2018.07.03.02.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:24:22 -0700 (PDT)
Message-ID: <1530609862.2900.187.camel@baylibre.com>
Subject: Re: [PATCH v2 2/2] clk: meson-axg: add clocks required by pcie
 driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Jianxin Qin <jianxin.qin@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Jul 2018 11:24:22 +0200
In-Reply-To: <20180702213118.19222-3-yixun.lan@amlogic.com>
References: <20180702213118.19222-1-yixun.lan@amlogic.com>
         <20180702213118.19222-3-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 21:31 +0000, Yixun Lan wrote:
> Adding clocks for the pcie driver. Due to the ASIC design,
> the pcie controller re-use part of the mipi clock logic,
> so the mipi clock is also added.
> 
> Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/axg.c | 148 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/axg.h |   6 +-
>  2 files changed, 153 insertions(+), 1 deletion(-)
> 
> 

[...]

> +
> +/* skip the partent 0, it's for debug only */
> +static u32 mux_table_pcie_ref[]	= { 1 };
> +static const char * const pcie_ref_parent_names[] = { "pcie_mux" };

Dropped these symbols.

> +
> +static struct clk_regmap axg_pcie_ref = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_PCIE_PLL_CNTL6,
> +		.mask = 0x1,
> +		.shift = 1,
> +		.table = mux_table_pcie_ref,

Replaced with the table itself

> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pcie_ref",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = pcie_ref_parent_names,
> +		.num_parents = ARRAY_SIZE(pcie_ref_parent_names),

Replaced with the table itself and applied. Thx

> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> 

