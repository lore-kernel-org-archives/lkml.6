Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07572C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B359520C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lOrlT2fX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B359520C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeHWPaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:30:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37041 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbeHWPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:30:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so5531195wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 05:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nX1kFI+OBSY8KCvRMNvb8nOKApKadpAZ6iu1gy94dM0=;
        b=lOrlT2fXZet9Q7afiYSvIrYCfQiqH+uVJwONnfB/2MSgTcrhm0z9BFFa2YmVp+OoFo
         YsuHaXnRWnHo3nvpHKzmrNBfX5RRMYY1erXebQAGjThsfJvgxuzyApBxZqlRi3H3HxKl
         wFJtlOuOBm590vqd/MnlUIHLlh9Vtn+QLfmGRf4P6cE9HyK6G8MIa6WKfZlMd6YXIFhJ
         wg8fQzHqyyexjBM1DjNKw5tEZpRp9ZlZSnlVhOs5bWnoiPJNqMG+cGKxaXzTIJUEbske
         vj4cSZREqowc3GOKPhuEuJAvT/mR40Wp6f6UBNAiugwj1FC4vwwGxzhpd+QSC+LMDhgP
         YL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nX1kFI+OBSY8KCvRMNvb8nOKApKadpAZ6iu1gy94dM0=;
        b=Lfm85NVDXVhDhxJQnbfdS+UkvSbDJCv0o+TB7IeDhWecTR36a83hiB/GTm2Wyw7+Nh
         qYA3q34O6dx0t/Wh9GgBB9WrsexJK+MvEFoQ8IfzZ7pIwPt2jW6Ppz+opnh4RfGSQF8C
         gqLQLTaGvk/IfcmJ9KdnF68HsPFgVw4Qt8mbZsf8Fj/Jv0kcpGtnDh2kfDIA2VhUEaiM
         n68k+X6DmOUL6N6Yqivuohlx5LpppcHayKVrAs65wk60H/pDeEe1INDhRA5eZfAIUYSR
         FK2OUDG1CXIkNUriHWd/3SFbizDq4w7rLkRCp6Nr5XlkhhsMMp7l/o8SXQrWNYarVOVn
         s5lA==
X-Gm-Message-State: APzg51CgshgnoTLcX0P8jaFK7JUcb508vtc/1p42fLM1SPYrIU3K7pa9
        edTFNJMxDcqRqfmUcL7j9N2DSNnaZuw=
X-Google-Smtp-Source: ANB0VdZpZimp+3beeBcrTZmLDrMTBEdo8QlRaCWtSH4bcZqxdI/70phavMF0aDqJJXsDldGBuchxXw==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr4900605wma.85.1535025648449;
        Thu, 23 Aug 2018 05:00:48 -0700 (PDT)
Received: from localhost.localdomain (81-67-76-113.rev.numericable.fr. [81.67.76.113])
        by smtp.gmail.com with ESMTPSA id y10-v6sm2830419wrl.87.2018.08.23.05.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 05:00:47 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
Date:   Thu, 23 Aug 2018 13:49:54 +0200
Message-Id: <20180823114954.30704-4-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823114954.30704-1-mjourdan@baylibre.com>
References: <20180823114954.30704-1-mjourdan@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMC is a small memory region with various registers,
including the ones needed for the canvas module.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index b8dc4dbb391b..5dd63ecf8b05 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -423,6 +423,19 @@
 			};
 		};
 
+		dmcbus: bus@c8838000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xc8838000 0x0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xc8838000 0x0 0x400>;
+
+			canvas: video-lut@48 {
+				compatible = "amlogic,canvas";
+				reg = <0x0 0x48 0x0 0x14>;
+			};
+		};
+
 		hiubus: bus@c883c000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc883c000 0x0 0x2000>;
-- 
2.18.0

