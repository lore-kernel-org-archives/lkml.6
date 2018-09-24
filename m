Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0210B2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0210B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbeIXSkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:40:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388144AbeIXSkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:40:00 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B38A11092;
        Mon, 24 Sep 2018 12:38:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bhushan Shah <bshah@kde.org>,
        Brian Masney <masneyb@onstation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 080/235] ARM: dts: qcom: msm8974-hammerhead: increase load on l20 for sdhci
Date:   Mon, 24 Sep 2018 13:51:06 +0200
Message-Id: <20180924113113.090329077@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bhushan Shah <bshah@kde.org>

[ Upstream commit 03864e57770a9541e7ff3990bacf2d9a2fffcd5d ]

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
Signed-off-by: Brian Masney <masneyb@onstation.org>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -189,6 +189,8 @@
 						regulator-max-microvolt = <2950000>;
 
 						regulator-boot-on;
+						regulator-system-load = <200000>;
+						regulator-allow-set-load;
 					};
 
 					l21 {


