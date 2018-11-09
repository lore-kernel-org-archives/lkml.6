Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEA4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2C020883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nOm2ynYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2C020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeKIXpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:45:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40966 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbeKIXpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:45:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id v18-v6so2018826wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/+LTD+fuRT1vJpsOEDqaSSNT5CxZ1kKqaaiFemNQAc=;
        b=nOm2ynYWRy8mJ+DrTVG5b378frSIZWIq+mzRqi1werHbbBd2ouk2kmiA60ndUbxOr1
         8fsx9BokSGX4hyc4xU9N14uWHo/FmTflKqlSsSmQKb07VsD5xgcFu6RZanFE9YiI22NX
         9jJakJuKo+2wYc4ZdDmOhl6lDT8tJ6W6CsQq1E0WkcHmwmMtDc3SUkrhxXR2iqNQ+zwY
         m74KCVcP4uNRJH5uQe6mNCQNNAm8Aj0iE2E36mRV72DasuQEeICeHt06PWjiCSR+dR5c
         Fu6o0VlF01l86iBqtxwHlBrYTPh3KyRCe1MHHSPVj9HEa/MqXiB07tSHTtxZ4okNzg5C
         Y4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/+LTD+fuRT1vJpsOEDqaSSNT5CxZ1kKqaaiFemNQAc=;
        b=dKMNT6aDYPaN3ar1lh9STh2psw5bbGJGoDNlBmx9KEWGUqC1sxOsm6AvfJfP/BDal7
         5fZhaBZx6Ge/44SxJPT4vuALM6R/qpLjvGqXHBkuhPI16YGzBGRD8KX4xdtb9TKufZdP
         Sy+NmmajMktju9roVLXVN9IRD8KEX6lRv8cuOnN2mLM/SYGK3OZ9Zsz+OPm3de+2Q0vS
         lNNC2mveLkS+15nFTDvxuPOPkDLk9pN0iBRACjXp9mUrTVAdLPNWEjc4ThAPOHlkojL0
         VTVHp6VE2Z7jcbwdlj4+aDXqTD44A0D04QIblKAlvikinTlGQ3G0ehEMG1JOgxt0Wdma
         q1XA==
X-Gm-Message-State: AGRZ1gIsj5CLvrr7YTeFbdkbmiHRVbneP73sHJSD/TQRkeVzgifqAh4J
        CJ+PKsmD0bD2SH6OOvP+UI+RWw==
X-Google-Smtp-Source: AJdET5epIfPIkhOvGZCStU7fzGfAT+stqgoM4MHpqUfF34YxLPp5f8heWxtzf/S5da/ygJtFD4GcjQ==
X-Received: by 2002:adf:f24d:: with SMTP id b13-v6mr7646460wrp.142.1541772303455;
        Fri, 09 Nov 2018 06:05:03 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id w18-v6sm15964987wrn.66.2018.11.09.06.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 06:05:02 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: meson: consistently disable pin bias
Date:   Fri,  9 Nov 2018 15:04:45 +0100
Message-Id: <20181109140445.17795-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109140445.17795-1-jbrunet@baylibre.com>
References: <20181109140445.17795-1-jbrunet@baylibre.com>
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
index 7162e0ca05b0..08c54cf5420a 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -163,6 +163,7 @@
 			mux {
 				groups = "uart_tx_ao_a", "uart_rx_ao_a";
 				function = "uart_ao";
+				bias-disable;
 			};
 		};
 
@@ -170,6 +171,7 @@
 			mux {
 				groups = "i2c_mst_sck_ao", "i2c_mst_sda_ao";
 				function = "i2c_mst_ao";
+				bias-disable;
 			};
 		};
 
@@ -177,6 +179,7 @@
 			mux {
 				groups = "remote_input";
 				function = "remote";
+				bias-disable;
 			};
 		};
 
@@ -184,6 +187,7 @@
 			mux {
 				groups = "pwm_f_ao";
 				function = "pwm_f_ao";
+				bias-disable;
 			};
 		};
 	};
@@ -238,6 +242,7 @@
 				groups = "sd_d0_a", "sd_d1_a", "sd_d2_a",
 					"sd_d3_a", "sd_clk_a", "sd_cmd_a";
 				function = "sd_a";
+				bias-disable;
 			};
 		};
 
@@ -246,6 +251,7 @@
 				groups = "sd_d0_b", "sd_d1_b", "sd_d2_b",
 					"sd_d3_b", "sd_clk_b", "sd_cmd_b";
 				function = "sd_b";
+				bias-disable;
 			};
 		};
 
@@ -254,6 +260,7 @@
 				groups = "sd_d0_c", "sd_d1_c", "sd_d2_c",
 					"sd_d3_c", "sd_clk_c", "sd_cmd_c";
 				function = "sd_c";
+				bias-disable;
 			};
 		};
 
@@ -261,6 +268,7 @@
 			mux {
 				groups = "nor_d", "nor_q", "nor_c", "nor_cs";
 				function = "nor";
+				bias-disable;
 			};
 		};
 
@@ -272,6 +280,7 @@
 					 "eth_rxd1", "eth_rxd0", "eth_mdio",
 					 "eth_mdc";
 				function = "ethernet";
+				bias-disable;
 			};
 		};
 
@@ -279,6 +288,7 @@
 			mux {
 				groups = "pwm_e";
 				function = "pwm_e";
+				bias-disable;
 			};
 		};
 
@@ -287,6 +297,7 @@
 				groups = "uart_tx_a1",
 				       "uart_rx_a1";
 				function = "uart_a";
+				bias-disable;
 			};
 		};
 
@@ -295,6 +306,7 @@
 				groups = "uart_cts_a1",
 				       "uart_rts_a1";
 				function = "uart_a";
+				bias-disable;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index cd1ca9dda126..46b3564a6536 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -146,6 +146,7 @@
 			mux {
 				groups = "uart_tx_ao_a", "uart_rx_ao_a";
 				function = "uart_ao";
+				bias-disable;
 			};
 		};
 
@@ -153,6 +154,7 @@
 			mux {
 				groups = "remote_input";
 				function = "remote";
+				bias-disable;
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

