Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39210C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E630721A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSSL1c6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E630721A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbeHFR3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeHFR3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:29:46 -0400
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A41521A52;
        Mon,  6 Aug 2018 15:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568811;
        bh=Ak2PP2n4i5ZzDY9Kr9kA5ITfUSCB1L3UoyTvkbtIuew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WSSL1c6AJzowRgXejPCTCDvlrnS83tQ8LlqYhC8LnMPEoW4YHO8u9Vq54gqirPWfk
         +5MnuB/L8buQQTou2GOXCgcIirNhJjLWLk46AxxxPUr0Pf9q1l1oyIprr3wLIfhHPb
         Y18pmJqbCrDQcPmpHOEXge8bdVTe1sAb7POkiJOA=
Received: by mail-qt0-f179.google.com with SMTP id h4-v6so14195498qtj.7;
        Mon, 06 Aug 2018 08:20:11 -0700 (PDT)
X-Gm-Message-State: AOUpUlHZSCctT67ra953vue4gDddP+gBNrK3h1dPe1LRrV0pxH9kIoDW
        xZ3nnuT/jqgmb6SMzeOqP3Imbjt2FVwzXsEhdw==
X-Google-Smtp-Source: AAOMgpc2XILn0qSCBy+xGWyT97XXZOVaZrovGG2DGVwYFoWAE2v6ZGrCBQCI4BKikn4vBwV+81MfJSds1114L8Dg8LA=
X-Received: by 2002:ac8:96b:: with SMTP id z40-v6mr14821088qth.362.1533568810413;
 Mon, 06 Aug 2018 08:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-3-songjun.wu@linux.intel.com>
In-Reply-To: <20180803030237.3366-3-songjun.wu@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Aug 2018 09:19:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5pFNKyAhTTmNpaSnKa_beY3kS8FGtYim8oTgw6oO9Rw@mail.gmail.com>
Message-ID: <CAL_JsqK5pFNKyAhTTmNpaSnKa_beY3kS8FGtYim8oTgw6oO9Rw@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin zhu <yixin.zhu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>
> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>
> This driver provides PLL clock registration as well as various clock
> branches, e.g. MUX clock, gate clock, divider clock and so on.
>
> PLLs that provide clock to DDR, CPU and peripherals are shown below:
>
>                  +---------+
>             |--->| LCPLL3 0|--PCIe clk-->
>    XO       |    +---------+
> +-----------|
>             |    +---------+
>             |    |        3|--PAE clk-->
>             |--->| PLL0B  2|--GSWIP clk-->
>             |    |        1|--DDR clk-->DDR PHY clk-->
>             |    |        0|--CPU1 clk--+   +-----+
>             |    +---------+            |--->0    |
>             |                               | MUX |--CPU clk-->
>             |    +---------+            |--->1    |
>             |    |        0|--CPU0 clk--+   +-----+
>             |--->| PLLOA  1|--SSX4 clk-->
>                  |        2|--NGI clk-->
>                  |        3|--CBM clk-->
>                  +---------+
>
> Signed-off-by: Yixin Zhu <yixin.zhu@linux.intel.com>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>
> Changes in v2:
> - Rewrite clock driver, add platform clock description details in
>   clock driver.
>
>  drivers/clk/Kconfig                          |   1 +
>  drivers/clk/Makefile                         |   3 +
>  drivers/clk/intel/Kconfig                    |  20 ++
>  drivers/clk/intel/Makefile                   |   7 +
>  drivers/clk/intel/clk-cgu-pll.c              | 166 ++++++++++
>  drivers/clk/intel/clk-cgu-pll.h              |  34 ++
>  drivers/clk/intel/clk-cgu.c                  | 470 +++++++++++++++++++++++++++
>  drivers/clk/intel/clk-cgu.h                  | 259 +++++++++++++++
>  drivers/clk/intel/clk-grx500.c               | 168 ++++++++++

>  include/dt-bindings/clock/intel,grx500-clk.h |  69 ++++

This belongs with the clk binding patch.

Rob
