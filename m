Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195E7C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5F420823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="mI9oavZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfAUPxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:53:30 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:45072 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730013AbfAUPxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:53:30 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 502145C0231;
        Mon, 21 Jan 2019 16:53:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548086008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=vgFqHtX8fjLIbergTlpat5cFh3/hh9idcGERWWcWmdw=;
        b=mI9oavZYjpa7ZfZdgDwMnc86XunWhHZ5g0P29oau/kGJA5WAhU5XZJNhWxppuLbMEJI/pk
        MoeVeG0utJiJ6Gqvs+q78fqzKqG1k8csfKepwN5B3JrcEkUVbA55SERAMxFv5wZjhc5LpX
        PktzjaBBfqiqLiEiYES/9B7/qoPTDK0=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
        dev@pschenker.ch, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: dts: colibri: use valid range configuration for weim
Date:   Mon, 21 Jan 2019 16:53:27 +0100
Message-Id: <20190121155327.12554-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A valid WEIM range configuration must specify range entries for
all four chip selects. This fixes an error on boot:
  imx-weim: probe of 21b8000.weim failed with error -22

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index f7bcc1181c4a..5ee2ddedd038 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -238,10 +238,11 @@
 &weim {
 	status = "okay";
 
-	/* weim memory map: 32MB on CS0, 32MB on CS1, 32MB on CS2 */
+	/* weim memory map: 32MB on CS0, CS1, CS2 and CS3 */
 	ranges = <0 0 0x08000000 0x02000000
 		  1 0 0x0a000000 0x02000000
-		  2 0 0x0c000000 0x02000000>;
+		  2 0 0x0c000000 0x02000000
+		  3 0 0x0e000000 0x02000000>;
 
 	/* SRAM on Colibri nEXT_CS0 */
 	sram@0,0 {
-- 
2.20.1

