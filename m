Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8614DC64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC62205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uht65hWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC62205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeLHQug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:50:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55289 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeLHQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:50:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id z18so7089912wmc.4;
        Sat, 08 Dec 2018 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=umYSWlSr7sstay9sv45lhSgivwtvIUtFs8hUY3ac4fM=;
        b=uht65hWRQ+7gfwV51Z8vRlmN7Xuln9wdYrvwyVA5vlfcuBsoY00yJakXBIy2eI7KMk
         IjzrDB6vpNlPvZ6z6EvU7z+sHbeR5XjW9nO23jtrszkgIBBH2QisI1OlbYKw9nHoexvn
         j1/wdNfBEdVzfWV/wKz8T17Ge52JU+LlT6mA2QX3/lCJ41Qyl+rO6EQaRRNRzskmD/y4
         Ykdt6/yhUnnEEvraf1ras2ZKgKfaZyfVibQmgIYeMEdOAxltz085GJ5uRw6EZGqlu790
         jEed1sTVrG3oqBJSdXYhavTmP/9xT/eeEgcfrr3bNufuQlsa193A+1fNx7OIDRjHKukF
         5CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=umYSWlSr7sstay9sv45lhSgivwtvIUtFs8hUY3ac4fM=;
        b=JcqCXHQEKfdBy8F8dg1I8kYgzWmd7S6lrjBlizqbwLCyn4GGRXFjCR4Y7WlKoLEg3+
         Zjkqw5Vb374KV12dlLIhXKG63BfVY0GcSuojDPDnOlFLT0s+ZMlGFza6ZDO9MBDjJj63
         Fq/OhzdpUAHolEgfjqbtexfFlA9NWSRi9yooiS0iQkReGKUufW/1h8JkpuYb37v9W0K1
         7YGBy6YE9FbZXBhTxuEVKWvsIM5FS8uSXESKFxaLlyPQuMUsPy6Ou0DWa0s3dQcVDj5Z
         Juq/akO72utQM84H2/NYwp/wZv8nR08AocUlrE8VPHLW+4eXSfOAqbOMYort11sRvaJ3
         Gz8w==
X-Gm-Message-State: AA+aEWZA1VuCYTQJBRKuiwS8ST6lLVBohD/zcSSCVhbp3h0FstpOj2zj
        6t0CnUIEmfoCvvKQzYrpsIo=
X-Google-Smtp-Source: AFSGD/UEzK/myWYZLSRcpO61/b6zRQzmLOqEyFZyuMOVCwo+4NK5z8zHXLWkyezC2rI50cK8w8xwHQ==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr5816875wmb.40.1544287832840;
        Sat, 08 Dec 2018 08:50:32 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n15sm11395651wrt.21.2018.12.08.08.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:50:32 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/3] ARM: dts: meson6: add the APB2 bus
Date:   Sat,  8 Dec 2018 17:50:23 +0100
Message-Id: <20181208165025.27689-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mali GPU and the DVB demulator are located in the APB2 bus. Describe
this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index ca978ab952cd..65585255910a 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -70,6 +70,14 @@
 		};
 	};
 
+	apb2: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x40000>;
+	};
+
 	xtal: xtal-clk {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
2.19.2

