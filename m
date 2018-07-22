Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D11C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC31220874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC31220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeGVRrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:51 -0400
Received: from mout.perfora.net ([74.208.4.197]:33587 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbeGVRrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:48 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Mbhzf-1fOvCP2qMn-00J6rK; Sun, 22 Jul 2018 18:50:25 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 20/28] ARM: tegra: apalis_t30: use proper irq-gpio for stmpe811
Date:   Sun, 22 Jul 2018 18:49:28 +0200
Message-Id: <20180722164936.20581-21-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:6Gz2g9WUT4JtKyDJmlOZJFcIgbaeIq4Q1Nqacs4u3JmQW+y9e9V
 OEZTwQQONT1ZmxLlvdC8KLdeNfDnczNGUmptxK0QL5Krk0tWtVFYucPmnZTDlqeA8benQ9j
 i4uVp9E4PW17jq94IIaCdQNdaFhNxkfSam9ng3gtE7rQ55o94JsVOQo/hL1t9n9iBtk0926
 1zE5szhLvqzNv/ZiUZTkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7paoHb5w3go=:6fx4+3I0v+kyNM9a49Fexy
 J4+201wenntzLIQQQDwL5JkcFBxmJSXVyrllxBgWyRpyJ7bJGh5AFAkmzDVtZPXP5ijzTrHXu
 F8vz6rtEm6TXZTyscJHX4cVCHhrUe+n82wGoNaDPVpbQRwDlcrGRVTaxN3Prso4yEjsDPFtwU
 jcDL1Wzh2GE8lx06mmUDaG3JKSk/rGM8IlgzfQwKfUG1uCJ4+VZOMZ4/qbo8W4lnGqPfqKr2t
 +IE+4v8u7/bISIOKddx9kBvlDySVHUZcQ8j3l4Wb/piRMTFtiFIKDXy4BhGYHfXX32dE8CnKf
 QQxsWdtQIBdVywNDkF/61tlbNrUMdi4i4iZWKbCqiNEokS5UdJ3QHGYMeCshsu0giI4OS2DFS
 LHQa/CIjoZuC+YTITHJ8jEEZbyV/nf1pqx8xFIoGhWmwhlcLLgfvVHKh2Aq61iEzBp9d0GVNJ
 5SUVcqepZ44PpXo53O/FnKqHl4fid+gYNNQilVRhkzPLf1L0iD3WNUin4M7xiA8T4p0hlzXZe
 KrcHaNtrG7QIcrXuDkvsovRJB0g53sF7+EIsl7QMJomxqjMvjdu2pkwX8GfsQHsP3KCYeL47E
 ncQgczTRzcYw5TLB1YSa7AvK29+g9TG2RvKMkUi2BUejzY+5gzZz0udeTSp0nT0HD2ANQTV/n
 ud7+xBfPKYAVPtshm+/2Wg6MS/Bbo+0nVn8tHnvGAeRfG8rEKcCIzZaZEh/sSF1Prt8/i4Dju
 NnuGXQIwF/ZLrCpdJ8uQSqUr+VPvXHZjZBWgCtvICArUbfLIfcaXfV2HN0NgWkmgAsZI8lo6y
 RnVE+1HEnI9ghSt5Zvd6vI0iZqggQAt/BQy8b+OWtTMLNvsu/5E3wuXJ0GL6mt5DfVOWrkhWL
 NhJQQeqqrAeWl1DNLunj4uyRxqImKLSxeFYpwy8p8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Use proper irq-gpio for stmpe811 touch controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index ad48b0daa0f8..ab4fe7491bbf 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -959,8 +959,7 @@
 		stmpe811@41 {
 			compatible = "st,stmpe811";
 			reg = <0x41>;
-			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
-			interrupt-parent = <&gpio>;
+			irq-gpio = <&gpio TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
 			id = <0>;
 			blocks = <0x5>;
-- 
2.14.4

