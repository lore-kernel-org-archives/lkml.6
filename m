Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04DAC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C233920879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C233920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeLNMMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:12:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38342 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731938AbeLNMMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:35 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gXmKO-0006V2-GU; Fri, 14 Dec 2018 13:12:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>, maxime.ripard@bootlin.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>
Subject: Re: [PATCH RFC v2 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
Date:   Fri, 14 Dec 2018 13:12:23 +0100
Message-ID: <2505786.uGvT2qSv2r@phil>
In-Reply-To: <20181130134301.17963-2-narmstrong@baylibre.com>
References: <20181130134301.17963-1-narmstrong@baylibre.com> <20181130134301.17963-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 30. November 2018, 14:42:54 CET schrieb Neil Armstrong:
> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
> Scrambling when supported or mandatory.
> 
> This patch also adds an helper to setup the control bit to support
> the high TMDS Bit Period/TMDS Clock-Period Ratio as required with
> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
> 
> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
> on the Rockchip 4.4 BSP kernel at [1]
> 
> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
> 
> Cc: Nickey Yang <nickey.yang@rock-chips.com>
> Cc: Huicong Xu <xhc@rock-chips.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

sorry this took a bit longer, but I can confirm that the 4 relevant
patches (1, 4, 5, 6) at least still provide 1080p hdmi output on
rk3288 (with internal hdmiphy) and rk3328 (with external innosilicon
hdmiphy). I don't know how to test newly added features, but at
least the patches don't seem to break existing users, so

on rk3288 and rk3328
Tested-by: Heiko Stuebner <heiko@sntech.de>



