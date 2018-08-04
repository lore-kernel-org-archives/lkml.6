Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052C5C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F80208B7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F80208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeHDPTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:19:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:59508 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbeHDPTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:19:19 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1flwS1-0003K8-2t; Sat, 04 Aug 2018 15:18:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     djw@t-chip.com.cn
Cc:     linux-rockchip@lists.infradead.org, Wayne Chou <zxf@t-chip.com.cn>,
        devicetree@vger.kernel.org, David Wu <david.wu@rock-chips.com>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>,
        Joseph Chen <chenjh@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] arm64: dts: rockchip: add sdmmc UHS support for roc-rk3328-cc
Date:   Sat, 04 Aug 2018 15:18:32 +0200
Message-ID: <3379811.jaOMd9KUxU@phil>
In-Reply-To: <1533016762-5268-5-git-send-email-djw@t-chip.com.cn>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn> <1533016762-5268-5-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levin,

Am Dienstag, 31. Juli 2018, 07:59:22 CEST schrieb djw@t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> In roc-rk3328-cc board, the signal voltage of sdmmc is supplied by the
> vcc_sdio regulator, which is a mux between 1.8V and 3.3V, controlled by
> a special output only gpio pin labeled "gpiomut_pmuio_iout",
> corresponding bit 1 of the syscon GRF_SOC_CON10.
> 
> This special pin can now be reference as <&grf_gpio 0>, thanks to the
> gpio-syscon driver, which makes writing regulator-gpio possible.
> 
> If the signal voltage changes, the io domain needs to change
> correspondingly.
> 
> To use this feature, the following options are required in kernel config:
>  - CONFIG_GPIO_SYSCON=y
>  - CONFIG_POWER_AVS=y
>  - CONFIG_ROCKCHIP_IODOMAIN=y
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

[...]

> @@ -277,3 +295,7 @@
>  &usb_host0_ohci {
>  	status = "okay";
>  };
> +
> +&grf_gpio {
> +	status = "okay";
> +};
> 

applied to my dts64 branch after dropping the grf_gpio enablement,
see comment in patch2 regarding the always present pin.


Thanks
Heiko




