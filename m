Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD5AC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044B0204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jw+p9Zpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044B0204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJLL5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 07:57:43 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:56065 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 07:57:42 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w9C4Pvr1024244;
        Fri, 12 Oct 2018 13:25:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w9C4Pvr1024244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539318358;
        bh=r6sMQiNoO5KqvGnZ0XSOfZjPTL3TyxzVsCnTuYa53nw=;
        h=From:To:Cc:Subject:Date:From;
        b=jw+p9ZpcI6TySV4B+Gx3kjmbh6peO+w16EHC3k1v8yozBSRNsc/trR0hqA+DIIXzr
         +djQekavKYC3pjwQEHqdgG1Ke6yLphspFfL7OvcSsKXKoDYs1Ex+2SpNLOtlrfwsLg
         3McvkkATKcLgPNdTVrbILvcaColnt7wLkdzWll0HLC0zZ/x3scVHAw96/uf6RQSwGi
         /LwyN8dDZZ/ycEZUd8OW53irdmqd6qYxk+Zu0pi13RM3JcRzGx1/GQ32BuIdai9+rT
         qiIUHgXxJ3VnuZ4NnUskra5M07pm7qJjMbUD3mJ5ETFMw4VMthqQN9fhKTQmXh1eGr
         OJkpI1x80g+/A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/2] dt-bindings: uniphier: add bindings for UniPhier SoC family
Date:   Fri, 12 Oct 2018 13:25:23 +0900
Message-Id: <1539318324-4938-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the list of SoCs and boards of UniPhier platform.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  Changes suggested by Rob.
  - Move the file to
    Documentation/devicetree/bindings/arm/socionext/uniphier.txt
  - Group boards by each SoC

Previous posts:
  v1: https://patchwork.ozlabs.org/patch/842010/

 .../devicetree/bindings/arm/socionext/uniphier.txt | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt

diff --git a/Documentation/devicetree/bindings/arm/socionext/uniphier.txt b/Documentation/devicetree/bindings/arm/socionext/uniphier.txt
new file mode 100644
index 0000000..dafc466
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
+      - Reference board: "socionext,uniphier-ld4-ref"
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
index a5c951c..c0c2abb 100644
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

