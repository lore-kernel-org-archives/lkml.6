Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE989ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8852620836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VwAllxlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8852620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeJSShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:37:21 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:26827 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeJSShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:37:21 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w9JAUbDf007220;
        Fri, 19 Oct 2018 19:30:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w9JAUbDf007220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539945039;
        bh=NwmoOJjx0RtVYuj7VA4HTG08yvy7iIyJADPelyRgFxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwAllxlWVnfzxkCWCIj5d7btOAhKTMBLBJUy6l5IH+339dBlrNJKSJ5zI0WMFsqgv
         cZVnBvOLp5Z3GL8kcXWwKzlC1qQe5x2r9rhvlTSuCGoiAMozV4V7rBPFQVsCyvyrhO
         0rQMG1DaoK1GUb7DeFosgnDX1cevk6h0ltjGMtHgnR2dAanNzVAyWSHkcQe79Th+zi
         gM63HxQIky8KV5XGRCPo3ypWFy2XZ9TDtdH/d7fiDwE4NuNgMXHRCy1/vv14wK6dp1
         dpqqvfRh4l4qs6sNrAFz/Bzi/xZxp6cX01z798boI06x4HBWXnVC4WqwzKqzickY6T
         t0P4uwwANKMgQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 1/2] dt-bindings: uniphier: add bindings for UniPhier SoC family
Date:   Fri, 19 Oct 2018 19:30:17 +0900
Message-Id: <1539945019-24950-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539945019-24950-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539945019-24950-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the list of SoCs and boards of UniPhier platform.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3:
  - Capitalize 'Board' consistently
  - Add Rob's Reviewed-by

Changes in v2:
  Changes suggested by Rob.
  - Move the file to
    Documentation/devicetree/bindings/arm/socionext/uniphier.txt
  - Group boards by each SoC
  Previous post:
  v1: https://patchwork.ozlabs.org/patch/842010/

 .../devicetree/bindings/arm/socionext/uniphier.txt | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt

diff --git a/Documentation/devicetree/bindings/arm/socionext/uniphier.txt b/Documentation/devicetree/bindings/arm/socionext/uniphier.txt
new file mode 100644
index 0000000..b3ed103
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/socionext/uniphier.txt
@@ -0,0 +1,47 @@
+Socionext UniPhier SoC family
+-----------------------------
+
+Required properties in the root node:
+  - compatible: should contain board and SoC compatible strings
+
+SoC and board compatible strings:
+  (sorted chronologically)
+
+  - LD4 SoC:  "socionext,uniphier-ld4"
+      - Reference Board: "socionext,uniphier-ld4-ref"
+
+  - Pro4 SoC: "socionext,uniphier-pro4"
+      - Reference Board: "socionext,uniphier-pro4-ref"
+      - Ace Board:       "socionext,uniphier-pro4-ace"
+      - Sanji Board:     "socionext,uniphier-pro4-sanji"
+
+  - sLD8 SoC: "socionext,uniphier-sld8"
+      - Reference Board: "socionext,uniphier-sld8-ref"
+
+  - PXs2 SoC: "socionext,uniphier-pxs2"
+      - Gentil Board:    "socionext,uniphier-pxs2-gentil"
+      - Vodka Board:     "socionext,uniphier-pxs2-vodka"
+
+  - LD6b SoC: "socionext,uniphier-ld6b"
+      - Reference Board: "socionext,uniphier-ld6b-ref"
+
+  - LD11 SoC: "socionext,uniphier-ld11"
+      - Reference Board: "socionext,uniphier-ld11-ref"
+      - Global Board:    "socionext,uniphier-ld11-global"
+
+  - LD20 SoC: "socionext,uniphier-ld20"
+      - Reference Board: "socionext,uniphier-ld20-ref"
+      - Global Board:    "socionext,uniphier-ld20-global"
+
+  - PXs3 SoC: "socionext,uniphier-pxs3"
+      - Reference Board: "socionext,uniphier-pxs3-ref"
+
+Example:
+
+/dts-v1/;
+
+/ {
+	compatible = "socionext,uniphier-ld20-ref", "socionext,uniphier-ld20";
+
+	...
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 5e6a1da..87b2c2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2183,6 +2183,7 @@ M:	Masahiro Yamada <yamada.masahiro@socionext.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/arm/socionext/uniphier.txt
 F:	Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
 F:	arch/arm/boot/dts/uniphier*
-- 
2.7.4

