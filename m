Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73353C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4430E2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4430E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJ3XL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:11:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55956 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbeJ3XL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:11:57 -0400
Received: from wd0370.dip.tu-dresden.de ([141.76.109.114] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gHUqN-0000An-Mt; Tue, 30 Oct 2018 15:18:07 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH V2] DT: rockchip: Fix stability issues with the 'performance' governor on rock960
Date:   Tue, 30 Oct 2018 15:18:06 +0100
Message-ID: <10930709.0rTHelch2x@phil>
In-Reply-To: <1539767918-26587-1-git-send-email-daniel.lezcano@linaro.org>
References: <1539767918-26587-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 17. Oktober 2018, 11:18:30 CET schrieb Daniel Lezcano:
> When the performance governor is set as default, the rock960 hangs
> around one minute after booting, whatever the activity is (idle, key
> pressed, loaded, ...).
> 
> Based on the commit log found at https://patchwork.kernel.org/patch/10092377/
> 
> "vdd_log has no consumer and therefore will not be set to a specific
> voltage. Still the PWM output pin gets configured and thence the vdd_log
> output voltage will changed from it's default. Depending on the idle
> state of the PWM this will slightly over or undervoltage the logic supply
> of the RK3399 and cause instability with GbE (undervoltage) and PCIe
> (overvoltage). Since the default value set by a voltage divider is the
> correct supply voltage and we don't need to change it during runtime we
> remove the rail from the devicetree completely so the PWM pin will not
> be configured."
> 
> After removing the vdd-log from the rock960's specific DT, the board
> does no longer hang and shows a stable behavior.
> 
> Apply the same change for the rock960 by removing the vdd-log from the
> DT.
> 
> Fixes: 874846f1fccd ("arm64: dts: rockchip: add 96boards RK3399 Ficus board")
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

applied as fix for 4.20
after including a stable-tag (board entered in previous kernel version)
and modified subject line a bit.


Thanks
Heiko


