Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3D2C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9275420843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9275420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeIAMZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:02 -0400
Received: from mout.perfora.net ([74.208.4.197]:56071 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbeIAMZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:01 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MhTLo-1gHPXB2KbS-00Mf1G; Sat, 01 Sep 2018 10:13:44 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 22/34] ARM: tegra: colibri_t30: enable hda over hdmi
Date:   Sat,  1 Sep 2018 10:12:36 +0200
Message-Id: <20180901081248.22639-23-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:gNbPsO6qtnO9mP2WTPsRfI3xMxlrqhYcwUmeeJ8+Hal1fqXDX8C
 YXlpDVtxKwPheV3fas78IAM1ShmLxHfmJuGIw4CHHROLVhkd6LyI7zpRmDiaKzbawh1JaIs
 mY8JCEq9XswMcD7R/nVyFiik7nPe4tLnPJRAVRTtaYe+iMNYGotRwjU+K14t+hCYAuSDoO7
 oQjvnW99pz0euCzxMh4Pg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1irPXS/MSrk=:OGZTqDuCslqq9L4hWzw2YC
 B/ObDoCWQAhTKtuP0ArQHNuFt92iCFi7P2YXYCrU4lCopLPPSU4nUzVDT7zisB3S06mk0P/Kz
 vBFqfdde/fDg9Ird3ph8/1MTWQmpuSJ1+RvQnRl6aYp+XY7WVrqY8i8BJl3qeyaDf+KPajVn8
 7tLcDLQx3oDugUSGsG61QMtS9IgQ1KhoXPdPkurT4OqV6fOc5P/JJbVKy0u0BiH0yn0NiVB+W
 C7QCXoB4DtgJsjh7N1A9uzPg+BiiSnvOPIFUzlCvcsyEqjygQeSHZE0sNIj+p+Xh3S1BQ0SRS
 7nf2P7+WlRyXBm/a02/1nYjbFKqXVdNhqGsoMXiKCEtCtr4wJVBjxyDd8vcVNX9eXoPvI5x0s
 Puc/UNbcPcvaVEHoteUh3bbgijTV6QGqFzDMWwC/yuJehtciRhvmvwr1E3aqIvHNrl5CCWmoR
 D+eYg0Si5N/SZzR0O9iTAeZ8GW9N7FwWXII5D54cA4W32I5rfPHe6/AmYbm8+0JM/SW32XN1n
 bcrreWIYo3+aXkLtmJVx3R3wmlGivJH+k5fZTSxifSOmRbxOqIMKiPZBgQnL9OpkL0sWfL7UK
 CmimKcGLYPKxRCOw3Jv1PJZ2hDTDmeDMEAiSwUck/AK0S7S2RgUUEEYPaj1x/AZjJam2g4CCp
 D0x7uYbEXPIeWsH9pkgpFxy8wzKRnNJa+xlREBERJYz2bvVCRwKDD0ka6pB28yPy8LYw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable HDA over HDMI.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index aff94707b3fa..1337674c530c 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -919,6 +919,10 @@
 		};
 	};
 
+	hda@70030000 {
+		status = "okay";
+	};
+
 	ahub@70080000 {
 		i2s@70080500 {
 			status = "okay";
-- 
2.14.4

