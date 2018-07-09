Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0715FC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64F320881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b="C5hep2eT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64F320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932583AbeGIJ3G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:29:06 -0400
Received: from letterbox.kde.org ([46.43.1.242]:57574 "EHLO letterbox.kde.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932366AbeGIJ3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:29:04 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 05:29:03 EDT
Received: from archbox.localdomain (p5097754f.dip0.t-ipconnect.de [80.151.117.79])
        (Authenticated sender: bshah)
        by letterbox.kde.org (Postfix) with ESMTPSA id 1F647280A2E;
        Mon,  9 Jul 2018 10:22:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
        t=1531128151; bh=P5AvwFfCiq3/Maor2i1ec2K5nDvrBotulSHP5gLYtvY=;
        h=Date:From:To:Subject:From;
        b=C5hep2eT/QfJrl1RnmZCoyhOOOZslqdjWCgdxFwYWyDz9CEmMspEP0AjUTtk+hm65
         lSuwrFF4LVlMnpEdvk5Of7UomdwY6G8pOz403+xUkGq0SCditPvz1S6u0HMkp51nVS
         kzmqf19ecRWDR4co3V65dv7zxZO+UpggYFDOKdFNThbK8L7OV6WCmseiwL0n9Ow3fk
         ludJ7O46LS+An58Ki8w19wthKBdF+J63BPaHDYVXxKklNgFIgGaT86V1sjTvq+UIer
         MW/xQzVW3wFits49ZEGLx1yme/wKmf9rG/a9xMQLv/qj0ZRgzfk37pVp1IaZMeXwpy
         6OQKMFEKp9I7w==
Date:   Mon, 9 Jul 2018 14:46:28 +0530
From:   Bhushan Shah <bshah@kde.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <masneyb@onstation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] ARM: dts: qcom: msm8974-hammerhead: increase load on l20 for
 sdhci
Message-ID: <20180709091628.GA8854@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel would not boot on the hammerhead hardware due to the
following error:

mmc0: Timeout waiting for hardware interrupt.
mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc0: sdhci: Sys addr:  0x00000200 | Version:  0x00003802
mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000200
mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
mmc0: sdhci: Present:   0x03e80000 | Host ctl: 0x00000034
mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
mmc0: sdhci: Int enab:  0x02ff900b | Sig enab: 0x02ff100b
mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
mmc0: sdhci: Caps:      0x642dc8b2 | Caps_1:   0x00008007
mmc0: sdhci: Cmd:       0x00000c1b | Max curr: 0x00000000
mmc0: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0x00000000
mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc0: sdhci: Host ctl2: 0x00000008
mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x70040220
mmc0: sdhci: ============================================
mmc0: Card stuck in wrong state! mmcblk0 card_busy_detect status: 0xe00
mmc0: cache flush error -110
mmc0: Reset 0x1 never completed.

This patch increases the load on l20 to 0.2 amps for the sdhci
and allows the device to boot normally.

Signed-off-by: Bhushan Shah <bshah@kde.org>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 4dc0b347b1ee..c2dc9d09484a 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -189,6 +189,8 @@
 						regulator-max-microvolt = <2950000>;
 
 						regulator-boot-on;
+						regulator-system-load = <200000>;
+						regulator-allow-set-load;
 					};
 
 					l21 {
-- 
2.17.1

