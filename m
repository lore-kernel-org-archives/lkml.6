Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B516FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9CB20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9CB20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbeGaWdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:33:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40497 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeGaWdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:33:13 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so6302948ita.5;
        Tue, 31 Jul 2018 13:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+z2DbmO16+CWPxLboxYsTF+DBpoa43xDdA9XOZoBoYM=;
        b=oSYAHciptKaUqkDi/Fy8i020vHg4rU0deF/qTJxQfHi6t9pK2cMXnohEN3KXgmwLib
         Mflc87c1xUuv7Q9qHNzypbuIfiRrVNdY2XFsBf6lrraq9pI09BIpLZTj4QTrs2oFbf7+
         azirScxnUWiXhG3ui6qsGawMLRaPHBBTumcNTU10EpVv1lH6UA65w/XsER3WQI2AePTL
         yQTarn5SjzF5RqIDyks/7+O5CQtWdVWeRy/ou9WQ0pUIBNsdHLOK9Yq1uFb2Mu3QoSpr
         D6/U3CyF/T4+Vr+7b0Pt7yreFyYWs9pz8Rn54TyxXF8FFmy7+ifrrQs70uVDN+3L4XXu
         aNzw==
X-Gm-Message-State: AOUpUlE/Khh1pA4B+ivKp15tOi78rJYKg2cwQdK31CqAKj5r0qnOLjKz
        0bxTNQI8Q5/3HWKWhle22g==
X-Google-Smtp-Source: AAOMgpc240gJvm/8Rfv1yCrWwHz/xUVAztMBS8vc01zmRIUn3QWMilhy5qNqAAjMIcejpwsfswp3JA==
X-Received: by 2002:a24:be8f:: with SMTP id i137-v6mr1149792itf.61.1533070263992;
        Tue, 31 Jul 2018 13:51:03 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id p84-v6sm1708047itc.2.2018.07.31.13.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:51:03 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:51:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     djw@t-chip.com.cn
Cc:     linux-rockchip@lists.infradead.org, Wayne Chou <zxf@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add support for ROC-RK3399-PC
 board
Message-ID: <20180731205102.GA13177@rob-hp-laptop>
References: <1532916721-24117-1-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532916721-24117-1-git-send-email-djw@t-chip.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:12:01AM +0800, djw@t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> ROC-RK3399-PC is a power efficient 4GB LPDDR4 single board
> computer with USB 3.0 and Gigabit Ethernet in a form factor
> compatible with the Raspberry Pi. It is based on the Rockchip
> RK3399 SoC, powered by the Type-C port.
> 
> The devicetree currently supports peripherals of:
> 
> - Ethernet
> - HDMI
> - SD Card
> - UART2 debug
> - Type-C
> - eMMC
> 
> USB3 in Type-C port currently only works with normal orientation,
> not flip one.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> 
> ---
> 
> Changes in v2:
> - remove custom brightness-levels (use calculated one in pwm_bl driver)
> - remove redundant 'dr_mode="otg"' in usbdrd_dwc3_0
> 
> Changes in v1:
> - remove bootargs
> - use interpolation for brightness level
> - add vcc_vbus_typec1 regulator
> - fix phy-supply of u2phy0_otg and u2phy1_otg
> - remove vcc_hub_en dummy regualtor
> - add hub_rst (changed to output high) to pinctrl status of vcc5v0_host
> - remove vsel-gpios props in fan53xx
> - remove mp8859 in i2c
> - fusb302: fix interrupt setting
> - fusb302: add vbus-supply
> - remove extcon in tcphy0 and tcphy1
> - remove #sound-dai-cells in i2s*
> - use RK_PXX style bit number for cd-gpios in SDMMC
> - clean commented status lines
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts     | 682 +++++++++++++++++++++
>  3 files changed, 687 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts

Reviewed-by: Rob Herring <robh@kernel.org>
