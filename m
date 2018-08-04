Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B87C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05980217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05980217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeHDPQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:16:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:59450 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbeHDPQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:16:53 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1flwPa-0003JK-5Z; Sat, 04 Aug 2018 15:16:02 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     djw@t-chip.com.cn
Cc:     linux-rockchip@lists.infradead.org, Wayne Chou <zxf@t-chip.com.cn>,
        Simon Xue <xxm@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        devicetree@vger.kernel.org,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/4] arm64: dts: rockchip: add GRF GPIO controller to rk3328
Date:   Sat, 04 Aug 2018 15:16:01 +0200
Message-ID: <4016409.aba6YNvtTb@phil>
In-Reply-To: <1533016762-5268-3-git-send-email-djw@t-chip.com.cn>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn> <1533016762-5268-3-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levin,

Am Dienstag, 31. Juli 2018, 07:59:20 CEST schrieb djw@t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> Adding a GRF GPIO controller labled "grf_gpio" to rk3328, currently
> providing access to the GPIO_MUTE pin, which is manupulated by the
> GRF_SOC_CON10 register.
> 
> The GPIO_MUTE pin is referred to as <&grf_gpio 0>.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

applied to my dts64 branch, with 2 changes:
- reordered, please sort nodes without address alphabetically
- removed default disabled status
  The controlled pin is always present on the soc, so doesn't need
  to be enabled on a per-board level


Heiko


