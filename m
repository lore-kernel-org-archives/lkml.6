Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A097C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F56208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kVaPTjce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F56208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeKHUTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:19:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51747 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeKHUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:19:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id w7-v6so759339wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 02:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ej2YST9rdgBvI/3S+E/v4xZNuOxlt8n1LsFdJ1JaCwE=;
        b=kVaPTjceCYjCUMMCNJHYyespSLFNykzmSK1sKH6uqlOxEtJmWi2UNBZO30j4GKcFpx
         RzxPfpo9R98AYm+5BP4ut9PcuRPRDwyJ9sv+5OPwfLZ+1DLZ0b2QbGbwJUgSr+CdHvNs
         kjXRPTxXZM4EyAkMfDnZnB4lcYSjqrwMMprPITwokYmrRfJs2t6BBvXY+dd/uDfihurl
         bF6kNAUo8hoYSoVFdRSOv77bdiMTpmbSvgS5nZJ4vp9S1zJh7zCjD+V47L6yKHFfkbQG
         pJfugqOE2/UfsdNpYsPvVZ/4wrGRrcEjczkqhxImNwirc/xJxFZYsQNAerkKIEANAL7B
         w5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ej2YST9rdgBvI/3S+E/v4xZNuOxlt8n1LsFdJ1JaCwE=;
        b=nxjhFdcsbLqzTegCAcEhSAJ56xZEuVgkMoApKDA6u5imL0z65+czJrmH35+yafZ5iH
         YmjdjQ1p9PeNddVoq3ylIE6EC87QElCJ8jGKOjyHh/KvLyZt9HhCTLNrs58bHDFrg7rn
         A/v/jkBIasxU5UpGi+UJQ3K1xWKeMi8loErzBDDKPVMwSQDKy/KMHG0vd1qlRxyS7K29
         KrWfzlvl70GggZFZDWe9JD2ybenl3DQSbb9CjTMHAEq9/OMNg3lIXOyEwYsb9t3Qxl7T
         pHooPbqcJ36ovCZ+bmT6mpUmKljQtbRhbvg3RqOhNbXDxWi5EDOMK9GxPSvQcGyBu886
         GEbQ==
X-Gm-Message-State: AGRZ1gKlhUc+clXDtKomnWneu5WaQSu5hdW0/Qbgoz1VVQ7Z6sesdHNA
        +kEtIRdFx+xFn3DgJfjG22aZag==
X-Google-Smtp-Source: AJdET5fFBtoKY7h6IChvJJVCsOVJDwqX9+4WLhf3+gnaiLkjfu77l90tW7epnk0pLjGRPo34UW9row==
X-Received: by 2002:a1c:8d86:: with SMTP id p128-v6mr746220wmd.48.1541673894163;
        Thu, 08 Nov 2018 02:44:54 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o130-v6sm5884800wmd.11.2018.11.08.02.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 02:44:53 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: meson: consistently disable pin bias
Date:   Thu,  8 Nov 2018 11:44:26 +0100
Message-Id: <20181108104426.1877-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108104426.1877-1-jbrunet@baylibre.com>
References: <20181108104426.1877-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Amlogic chipsets, the bias set through pinconf applies to the pad
itself, not only the GPIO function. This means that even when we change
the function of the pad from GPIO to anything else, the bias previously
set still applies.

As we have seen with the eMMC, depending on the bias type and the function,
it may trigger problems.

The underlying issue is that we inherit whatever was left by previous user
of the pad (pinconf, u-boot or the ROM code). As a consequence, the actual
setup we will get is undefined.

There is nothing mentioned in the documentation about pad bias and pinmux
function, however leaving it undefined is not an option.

This change consistently disable the pad bias for every pinmux functions.
It seems to work well, we can only assume that the necessary bias (if any)
is already provided by the pin function itself.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/boot/dts/meson8.dtsi   | 12 ++++++++++++
 arch/arm/boot/dts/meson8b.dtsi  |  9 +++++++++
 arch/arm/boot/dts/meson8m2.dtsi |  1 +
 3 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 7162e0ca05b0..1e735c0d92e3 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -164,6 +164,7 @@
 				groups = "uart_tx_ao_a", "uart_rx_ao_a";
 				function = "uart_ao";
 			};
+			bias-disable;
 		};
 
 		i2c_ao_pins: i2c_mst_ao {
@@ -171,6 +172,7 @@
 				groups = "i2c_mst_sck_ao", "i2c_mst_sda_ao";
 				function = "i2c_mst_ao";
 			};
+			bias-disable;
 		};
 
 		ir_recv_pins: remote {
@@ -178,6 +180,7 @@
 				groups = "remote_input";
 				function = "remote";
 			};
+			bias-disable;
 		};
 
 		pwm_f_ao_pins: pwm-f-ao {
@@ -185,6 +188,7 @@
 				groups = "pwm_f_ao";
 				function = "pwm_f_ao";
 			};
+			bias-disable;
 		};
 	};
 };
@@ -239,6 +243,7 @@
 					"sd_d3_a", "sd_clk_a", "sd_cmd_a";
 				function = "sd_a";
 			};
+			bias-disable;
 		};
 
 		sd_b_pins: sd-b {
@@ -247,6 +252,7 @@
 					"sd_d3_b", "sd_clk_b", "sd_cmd_b";
 				function = "sd_b";
 			};
+			bias-disable;
 		};
 
 		sd_c_pins: sd-c {
@@ -255,6 +261,7 @@
 					"sd_d3_c", "sd_clk_c", "sd_cmd_c";
 				function = "sd_c";
 			};
+			bias-disable;
 		};
 
 		spi_nor_pins: nor {
@@ -262,6 +269,7 @@
 				groups = "nor_d", "nor_q", "nor_c", "nor_cs";
 				function = "nor";
 			};
+			bias-disable;
 		};
 
 		eth_pins: ethernet {
@@ -273,6 +281,7 @@
 					 "eth_mdc";
 				function = "ethernet";
 			};
+			bias-disable;
 		};
 
 		pwm_e_pins: pwm-e {
@@ -280,6 +289,7 @@
 				groups = "pwm_e";
 				function = "pwm_e";
 			};
+			bias-disable;
 		};
 
 		uart_a1_pins: uart-a1 {
@@ -288,6 +298,7 @@
 				       "uart_rx_a1";
 				function = "uart_a";
 			};
+			bias-disable;
 		};
 
 		uart_a1_cts_rts_pins: uart-a1-cts-rts {
@@ -296,6 +307,7 @@
 				       "uart_rts_a1";
 				function = "uart_a";
 			};
+			bias-disable;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index cd1ca9dda126..6fc129ab4453 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -147,6 +147,7 @@
 				groups = "uart_tx_ao_a", "uart_rx_ao_a";
 				function = "uart_ao";
 			};
+			bias-disable;
 		};
 
 		ir_recv_pins: remote {
@@ -154,6 +155,7 @@
 				groups = "remote_input";
 				function = "remote";
 			};
+			bias-disable;
 		};
 	};
 };
@@ -220,6 +222,7 @@
 					 "eth_txd2",
 					 "eth_txd3";
 				function = "ethernet";
+				bias-disable;
 			};
 		};
 
@@ -235,6 +238,7 @@
 					 "eth_mdio_en",
 					 "eth_mdc";
 				function = "ethernet";
+				bias-disable;
 			};
 		};
 
@@ -242,6 +246,7 @@
 			mux {
 				groups = "i2c_sda_a", "i2c_sck_a";
 				function = "i2c_a";
+				bias-disable;
 			};
 		};
 
@@ -250,6 +255,7 @@
 				groups = "sd_d0_b", "sd_d1_b", "sd_d2_b",
 					"sd_d3_b", "sd_clk_b", "sd_cmd_b";
 				function = "sd_b";
+				bias-disable;
 			};
 		};
 
@@ -257,6 +263,7 @@
 			mux {
 				groups = "pwm_c1";
 				function = "pwm_c";
+				bias-disable;
 			};
 		};
 
@@ -265,6 +272,7 @@
 				groups = "uart_tx_b0",
 				       "uart_rx_b0";
 				function = "uart_b";
+				bias-disable;
 			};
 		};
 
@@ -273,6 +281,7 @@
 				groups = "uart_cts_b0",
 				       "uart_rts_b0";
 				function = "uart_b";
+				bias-disable;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/meson8m2.dtsi
index 3e1f92273d7b..d1a28c2adac5 100644
--- a/arch/arm/boot/dts/meson8m2.dtsi
+++ b/arch/arm/boot/dts/meson8m2.dtsi
@@ -45,6 +45,7 @@
 				 "eth_rxd1", "eth_rxd0",
 				 "eth_mdio", "eth_mdc";
 			function = "ethernet";
+			bias-disable;
 		};
 	};
 };
-- 
2.19.1

