Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FD7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04478214D9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb0lTvfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04478214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbeK3Bdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbeK3Bdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 325FA21473;
        Thu, 29 Nov 2018 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501690;
        bh=YF7GkbkbNkAhewv4vtaO4KwnREJCfij6/lw51DmWa0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gb0lTvfX08kRhid1H6B0tRjZ1zjEmqKsY/vQd7XVys5uTA61B0Nuw8oHJ+0zx4Gee
         BQMt6bRa/SrvbUczru+u8pMO3BYggrx52TLBlzc7JG85agcEm6mcFeNQZlclDV+Dt1
         D/4pf2vBN8gRj6yWxg+yKr517noRkxvQoRgHVhtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 086/100] ARM: dts: exynos: Fix invalid node referenced by i2c20 alias in Peach Pit and Pi
Date:   Thu, 29 Nov 2018 15:12:56 +0100
Message-Id: <20181129140106.234822932@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 70c3250ac1374688d7963e562fe58b23f70bcba9 upstream.

After moving all nodes under "soc" node in commit 5d99cc59a3c6 ("ARM:
dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc"), the i2c20
alias in Peach Pit and Peach Pi stopped pointing to proper node:

    arch/arm/boot/dts/exynos5420-peach-pit.dtb: Warning (alias_paths):
        /aliases:i2c20: aliases property is not a valid node (/spi@12d40000/cros-ec@0/i2c-tunnel)
    arch/arm/boot/dts/exynos5800-peach-pi.dtb: Warning (alias_paths):
        /aliases:i2c20: aliases property is not a valid node (/spi@12d40000/cros-ec@0/i2c-tunnel)

Fixes: 5d99cc59a3c6 ("ARM: dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |    4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -31,7 +31,7 @@
 
 	aliases {
 		/* Assign 20 so we don't get confused w/ builtin ones */
-		i2c20 = "/spi@12d40000/cros-ec@0/i2c-tunnel";
+		i2c20 = &i2c_tunnel;
 	};
 
 	backlight: backlight {
@@ -952,7 +952,7 @@
 			samsung,spi-feedback-delay = <1>;
 		};
 
-		i2c-tunnel {
+		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
 			#address-cells = <1>;
 			#size-cells = <0>;
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -29,7 +29,7 @@
 
 	aliases {
 		/* Assign 20 so we don't get confused w/ builtin ones */
-		i2c20 = "/spi@12d40000/cros-ec@0/i2c-tunnel";
+		i2c20 = &i2c_tunnel;
 	};
 
 	backlight: backlight {
@@ -921,7 +921,7 @@
 			samsung,spi-feedback-delay = <1>;
 		};
 
-		i2c-tunnel {
+		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
 			#address-cells = <1>;
 			#size-cells = <0>;


