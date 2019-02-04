Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F56BC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF552081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lhk4SJHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfBDXQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:16:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33343 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfBDXQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:16:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so662434plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 15:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gd56skZROQuoUVaN4sNpxlterBec6i5NZQ5F4gBEN3E=;
        b=Lhk4SJHGMVCTJNkmhvcQ2wIuWaIz+qdkitt8K/xRLjtgx4zHnzR9eyohdgDEdkCbm2
         6jQXqkwwddBP1i8Bkuql6peKqWro1cJQ/ZRQRfpuWFv6geXXdWu7QbVfa+Dst//R9tfW
         +aUfqdqZWa9uBA/SjuJ65oWg1ixqWmURv9vrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gd56skZROQuoUVaN4sNpxlterBec6i5NZQ5F4gBEN3E=;
        b=SPA7F8btgcMJXKHGWcukhSN3Ll/030AWuXs/MNlYj6YR1WpAAN+9pwte3fJWr8lg3a
         BgveMeFkMcXjhA398BfPQCi1PGTUQJ9IYIPS5nk+Hi3rFYiAMKCg/3RcCfBCKqabnv6u
         PTudntp8cgsup0GMDskYIqo23adEouMD5QwoReEm1944uTOFufJK+uZ2DOxQ8fvhH0vF
         QyVE6MbzEmuhh6oUlVgDZjjztr7+Te6XMs0jnN4cc2ZL20PSnAYzJ6UloKAySFvbW3Tp
         gUiqPEyi9IrTGVO6XKgGYaCRTzy76Gqif0Mdxglwx66qcKkiQnHb2TJPVncCMpAl/Arh
         LMKQ==
X-Gm-Message-State: AHQUAubtgIC6/LlOUH0owhIcE7mdKJ15jOpawvl6JYm9gQ9UTBSzahhz
        8X52FVto9h9vq4K+Sov9F78H/w==
X-Google-Smtp-Source: AHgI3IaBcN+lpY9VGFpQ0JPcjcMhkEp0YQzWYYHqGg5NTQQ18M23bDd9+SMaINsjiLZUVqAXDB4QBg==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr1914061plt.98.1549322194366;
        Mon, 04 Feb 2019 15:16:34 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z14sm1281499pgv.47.2019.02.04.15.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 15:16:33 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 8/8] arm64: dts: Stingray: Add NIC i2c device node
Date:   Mon,  4 Feb 2019 15:15:54 -0800
Message-Id: <20190204231554.87666-9-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204231554.87666-1-ray.jui@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add NIC i2c device node.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray.dtsi   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index cfeaa855bd05..67e53768a84a 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -612,4 +612,22 @@
 			status = "disabled";
 		};
 	};
+
+	nic-hsls {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0  0x0 0x7fffffff>;
+
+		nic_i2c0: i2c@60826100 {
+			compatible = "brcm,iproc-nic-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x60826100 0x100>,
+			      <0x60e00408 0x1000>;
+			brcm,ape-hsls-addr-mask = <0x03400000>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.17.1

