Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15478C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42C22148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dRlA39fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbeL1KvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:51:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40208 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbeL1KvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:51:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so17229709edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 02:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gE62p5/59RTzWzc5sJxmZU4FHrcRfBxyqPDK6YvY16Y=;
        b=dRlA39fEGYGrMCSdYxMnu+56HDgaWfjlB0lpUUcTDIbhDhycuAZjsFRsBVekENFUcf
         A7PHCRAw04IH3nBfx6hy1HCoqwpMaH/9V0aM6i/wnUzgNLRrtqgCbNPMIm4E5g+0cNZx
         rPOV3y0yGLu/PvCh6gaV60LjWhDSyKb+ei7LJA1EfYadXQm4X3d+PpBT+3Ku31xaiEgp
         Sh+LTq1Gxlrjon7cNX7BquTilxJiESN+EI6SoLsHlB/J6Qeldds6ugSVX+rNv08AbSiu
         iHc2gGve9ysabdEJGEtaaijTlFiOFm2GwV/XrLLtfE1qZNdWrYUeVyHDNkNbtlBhAnZb
         vWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gE62p5/59RTzWzc5sJxmZU4FHrcRfBxyqPDK6YvY16Y=;
        b=ueyt/nClMSbk3wtbMH8V53Ja7BHNIA/OBb6bmeiAlAmWW8U/i6vCpJMHruBPAt1fgW
         S6tev07A55RSUqQK4NqXSnRaNYEQ4Cxpivaa1bsd7O45DguCiq7GAJmXmQ/J+GSHeLc0
         fnDLS7j0dclrMwwia7dE212ispe1GfqTSGhGQy8Ey3U6Jugefy+YCVqV/rtJhFqnv8Br
         sG9evyw8zpOVUXMWR9DejqT/7A4B7QOjuVVjQDoH/aXrgzSt9zNEu7OoB/oPAosBnQuB
         7s5ylWrhNIMwSRVJatqovpAr7wViNWKVXF388eV2+vqi4Q3zNhJrfuSTG9JB4pnrsdJj
         ge2A==
X-Gm-Message-State: AA+aEWboWss2h2giCFphYv8NYCHS4UCRPcFUdE6WfoUmxEITaMSeLNVc
        TZBy0wsmJnEpWxwDZnrta5AEyQ==
X-Google-Smtp-Source: AFSGD/UgWV6/KGWEQPJEiGDiMrBwzvlFt9oTMCNS79TdGRUIIHzmtWxHx1sANpSRzLgVnuiJr26S+g==
X-Received: by 2002:aa7:d602:: with SMTP id c2mr21740716edr.203.1545994281932;
        Fri, 28 Dec 2018 02:51:21 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.home (anice-157-1-157-17.w83-201.abo.wanadoo.fr. [83.201.132.17])
        by smtp.googlemail.com with ESMTPSA id b45sm12919494eda.34.2018.12.28.02.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Dec 2018 02:51:21 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 2/4] dt-bindings: gnss: add gtop binding
Date:   Fri, 28 Dec 2018 11:50:33 +0100
Message-Id: <1545994235-8309-3-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for GlobalTop GNSS receivers.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
 Documentation/devicetree/bindings/gnss/gtop.txt | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/gtop.txt

diff --git a/Documentation/devicetree/bindings/gnss/gtop.txt b/Documentation/devicetree/bindings/gnss/gtop.txt
new file mode 100644
index 000000000000..24c86703aa46
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/gtop.txt
@@ -0,0 +1,33 @@
+GlobalTop GNSS Receiver DT binding
+
+The GlobalTop GNSS receivers uses UART interfaces.
+
+Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
+properties.
+
+Required properties:
+
+- compatible	: Must be
+
+			"globaltop,pa6h"
+
+- vcc-supply	: Main voltage regulator
+
+Optional properties:
+
+- timepulse-gpios	: Time pulse GPIO
+- v-bckp-supply	: Backup voltage regulator
+
+Example:
+
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>;
+	pinctrl-names = "default";
+
+	gnss {
+		compatible = "globaltop,pa6h";
+		vcc-supply = <&vcc_3v3>;
+		current-speed = <9600>;
+	};
+};
-- 
2.7.4

