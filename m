Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7B7C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61C226629
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HedhvFJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61C226629
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeFZHlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:41:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34462 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeFZHk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:40:59 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so16140984wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jjaFvYRM6ukLBcEzgn6U18bDjsFO+u9xd5Bd8sPjLcs=;
        b=HedhvFJ7peUf5oUxsi3l/wyqR2EUvJFvOp92LNQXkP9hmqbsURjsfP6Yf5te+Xv1XX
         RJGPx+t3DmHV8k7oZ2VOcyrcb+RiY79O+89NOJxYSLvKIsVI7Iqsn4R2Leg0/ubnSInL
         AWegvZ4VCew05nVznOnuozOnEImNaEVGhlpZD3dCtq/cowIXcscwzbWqQ7X9eJmXY4i9
         OUUQYaAySZ43cwaajHGCIUsGXjDksxxHglTJ5V/Q7bKsR3e3VkwmTWnbAPcgGzwmidd5
         xPdME1RR/lJOh8COFBnvJrNguqGL0nC6O6sSWWeIpNfkouCZHgimoJ8RcfZP4z9hwKS2
         D/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jjaFvYRM6ukLBcEzgn6U18bDjsFO+u9xd5Bd8sPjLcs=;
        b=gQjY8b0bRLi/gmBpPqmkNzNu8Bp7mimcC2we7JFuz2wx/GUDgB2AJgZE2p/yvmdtHO
         cGdctHqO8rJoZmVNgmkUWphrsAC4R8IzsX6/k96t9RRAcz/xanpbzeAkrNpl5QihqkXX
         xL+ktS3S/94iwVR01Si3D7452i05seUsHGhPkray5uCNhXTrnJ6dO4Z6hpJoFXqGkkQ/
         auhyXkt8/l7Nbzlg4ciT/PG4gJy8Xb0VmtKuslda1uRG1zMD0idPJGxFeS1l/IJjo1xl
         F63N75Al+GBksSF+/qV+dh+HbXwWpW1DppIFnXJRHFCWQ5SyaCWt6+Wmh1YoLkZm6AcU
         jw0A==
X-Gm-Message-State: APt69E0LpP8bYWS6mhDNwVxH16bG7Jmi6teUoJtjNeI0sRJUP34OnscH
        5mArH5cESOmVahczKLLZ2NqQkQ==
X-Google-Smtp-Source: AAOMgpfDq89xO/XXId7igCifqkW0eBC/6jVJeLetvNC0KWJHydbEZRDzJFHZODwXq0hOJim/ovaBxA==
X-Received: by 2002:adf:9025:: with SMTP id h34-v6mr431528wrh.123.1529998858197;
        Tue, 26 Jun 2018 00:40:58 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g14-v6sm855662wro.86.2018.06.26.00.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:40:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-gxbb-nanopi-k2: Add HDMI, CEC and CVBS nodes
Date:   Tue, 26 Jun 2018 09:40:55 +0200
Message-Id: <1529998855-8098-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GXBB based Nanopi-K2 board has an HDMI connector
with CEC and CVBS available on the 40pin header.
This patch adds the nodes to enable HDMI, CEC and CVBS functionnalities.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 7d5709c..cbe99bd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -106,6 +106,42 @@
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
 	};
+
+	/* CVBS is available on CON1 pin 36, disabled by default */
+	cvbs-connector {
+		compatible = "composite-video-connector";
+		status = "disabled";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+};
+
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
 };
 
 &ethmac {
@@ -137,6 +173,18 @@
 	};
 };
 
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
 &ir {
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
-- 
2.7.4

