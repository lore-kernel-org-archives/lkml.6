Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A1DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449C920700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550863218;
	bh=Zir8+AgmPOQ7b5huwSNLe82SQfH4bXQoSPho4owU5AQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CvBlCA4mzXRT7/3822201ck+a8xKhA9UdyJmxRGy6ml0RnngYRxrvIiIMQv7FqAeX
	 TjosmbPrH6lqUIbja6XgVbb8AzIMnVFtajHSpuDnLizaHO9zwd22Yt53iB+KLnCzqt
	 45lC+nIRyDtyEExh0TbAzGXTTPOTRmS2iGWpS48Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfBVTUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBVTUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:20:16 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38672070B;
        Fri, 22 Feb 2019 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550863215;
        bh=Zir8+AgmPOQ7b5huwSNLe82SQfH4bXQoSPho4owU5AQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dpNqPE51vhh0XVSEJ9CEPRIbLXsVc5nTCZt2xA76pARmV0Ur2J28puD03JQYeEq9t
         Ia+69DazROBkFb4KFZ2aaLSdKb9EL2PT1YObLmEk27727ml0NuyUfLjbCSMQVRQa+V
         TRg2mVd4lZGdAbdVZPh2pKUREvUk/KUyy6oRi8sI=
Received: by mail-qt1-f180.google.com with SMTP id o6so3776378qtk.6;
        Fri, 22 Feb 2019 11:20:15 -0800 (PST)
X-Gm-Message-State: AHQUAuY4LGBZ23Y/yi7peAbMzR5rI4OIXT5TmWbf7gexBZ5H8aTvgPbX
        QZZg1Z8dJGUK5LNWz9biaZhSJxfVT6fAkKQFlQ==
X-Google-Smtp-Source: AHgI3Ibv14C87kkUH1h+yaWSUpiaOTiXeO8xNObwnN8X2cyeecw4FMUAKWGO1I0GbAb4XN8s7S9yddtjNoo33qz7JaQ=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr4408248qvb.218.1550863204950;
 Fri, 22 Feb 2019 11:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20190222184419.14469-1-aballier@gentoo.org>
In-Reply-To: <20190222184419.14469-1-aballier@gentoo.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Feb 2019 13:19:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLubJ2BwpgyzDFPUzyqjZZNO9spdXTuHHyTRsx_kxMfgg@mail.gmail.com>
Message-ID: <CAL_JsqLubJ2BwpgyzDFPUzyqjZZNO9spdXTuHHyTRsx_kxMfgg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add support for the Orange Pi
 RK3399 board.
To:     Alexis Ballier <aballier@gentoo.org>
Cc:     devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:46 PM Alexis Ballier <aballier@gentoo.org> wrote:
>
> This adds basic support for the Orange Pi RK3399 board.
> What works:
> - SD card / emmc.
> - Debug UART
> - Ethernet
> - USB: Type C, internal USB3 for SATA, 4 USB 2.0 ports
> - Sensors: All of them but the Hall sensor.
> - Buttons
> - Wifi, Bluetooth
> - HDMI out
>
> Signed-off-by: Alexis Ballier <aballier@gentoo.org>
> Cc: devicetree@vger.kernel.org
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
>
> The board is heavily based on the Sapphire one, hence this patch is also
> based on this DT. This is why I kept the copyrights of the sapphire DT.
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-orangepi.dts     | 778 ++++++++++++++++++
>  3 files changed, 784 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts

Reviewed-by: Rob Herring <robh@kernel.org>
