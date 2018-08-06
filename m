Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DCFC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BBE219DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BBE219DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeHFKSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:18:21 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40110 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbeHFKSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:18:20 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fmaam-0001QW-Qn; Mon, 06 Aug 2018 10:10:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     djw@t-chip.com.cn
Cc:     linux-rockchip@lists.infradead.org, Wayne Chou <zxf@t-chip.com.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v0] clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399
Date:   Mon, 06 Aug 2018 10:10:15 +0200
Message-ID: <2499930.7n9Q7JauMx@phil>
In-Reply-To: <1533367862-7212-1-git-send-email-djw@t-chip.com.cn>
References: <1533367862-7212-1-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levin,

Am Samstag, 4. August 2018, 09:31:02 CEST schrieb djw@t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> PWM2 is commonly used to control voltage of PWM regulator of VDD_LOG in
> RK3399. On the Firefly-RK3399 board, PWM2 outputs 40 KHz square wave
> from power on and the VDD_LOG is about 0.9V. When the kernel boots
> normally into the system, the PWM2 keeps outputing PWM signal.
> 
> But the kernel hangs randomly after "Starting kernel ..." line on that
> board. When it happens, PWM2 outputs high level which causes VDD_LOG
> drops to 0.4V below the normal operating voltage.
> 
> By adding "pclk_rkpwm_pmu" to the rk3399_pmucru_critical_clocks array,
> PWM clock is ensured to be prepared at startup and the PWM2 output is
> normal. After repeated tests, the early boot hang is gone.
> 
> This patch works on both Firefly-RK3399 and ROC-RK3399-PC boards.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

applied to my clk-branch

Thanks for tracking that down
Heiko


