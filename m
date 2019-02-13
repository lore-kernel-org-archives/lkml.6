Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AA5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AF7222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083558;
	bh=t+M3lScF5bnMHTJ13oNAHmv33+ZpEKcSAQPkAusNzPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dCyo0g+z9fzvwxVDQFueoacugFF7WQb60f9RmH4PTHypoZwYIX8ANbzCi/OkHQRla
	 VsvwRVlFYHSN3jdFRaj9qGuXtpNPPw2OIW27mkyIdalUBqI/itLpxXIE5mKHhY0XfR
	 B9KeJnkRqGRhPplvHOPXxq2YAD6l2hQRZVIgfCic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406295AbfBMSp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:45:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406260AbfBMSpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:45:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421EC20811;
        Wed, 13 Feb 2019 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083552;
        bh=t+M3lScF5bnMHTJ13oNAHmv33+ZpEKcSAQPkAusNzPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fL7BFIYalKy3dmLCc98djGda5ult/oZWc8+L7wd9jh6J1YY3x5EJpPurLn99fM9O+
         c+hXYnI6c0XLNmvQ6k4bILwsfX+Eb5mOoE3MxfkypjFLhxSE9vl3AITiSfQJafNK2j
         JqaJYeuOcXRTPCgzMhHG/RIuc3cEOQTNHXk7lDjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 4.20 31/50] ARM: dts: da850: fix interrupt numbers for clocksource
Date:   Wed, 13 Feb 2019 19:38:36 +0100
Message-Id: <20190213183658.217417594@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit e3966a766865da7ced1dece663697861dd5cf103 upstream.

The timer interrupts specified in commit 3652e2741f42 ("ARM: dts:
da850: Add clocks") are wrong but since the current timer code
hard-codes them, the bug was never spotted.

This patch must go into stable since, once we introduce a proper
clocksource driver, devices with buggy device tree will stop booting.

Fixes: 3652e2741f42 ("ARM: dts: da850: Add clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/da850.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -476,7 +476,7 @@
 		clocksource: timer@20000 {
 			compatible = "ti,da830-timer";
 			reg = <0x20000 0x1000>;
-			interrupts = <12>, <13>;
+			interrupts = <21>, <22>;
 			interrupt-names = "tint12", "tint34";
 			clocks = <&pll0_auxclk>;
 		};


