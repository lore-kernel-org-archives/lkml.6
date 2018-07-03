Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EF8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C7823BFD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X7wskQ2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C7823BFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeGCNWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:22:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55405 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbeGCNV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:21:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so2330164wmv.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tkK3C1UrBnti+H2QppFf2GLhNc93Zu2JdxR+HIhyXEQ=;
        b=X7wskQ2Aq04Ns1AeaHS4WOyzfF8RM2TEBFOHGUXSyufzkiOE4WzDsB2U1Xn4j7ZFe4
         Qm5Q53c4GSZMHy1KqsXFEvWl02FthNM8DBAMCDGkK0jBnPHhOfY1bEqOJ7ayVm4BKt6t
         MZDZgwa08aylClpXJRgwS8/Qm6kxomhvsFJc5qy/SIL8eAR/kfVvCxP6SSwCP4pMRDM2
         AVGG/RrFkcOuyifqsNLqdGyToQ4F0Y62ZSGMay1a2LHwkPPOjgBuJndzgHY+VOVEnL/B
         RZ+widJqSJE0BBdFEpmFrwOHpF/tgCl8zJP3Tir1aFK0REuv6gDokSXGoTcZRwHGY/Xz
         5idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tkK3C1UrBnti+H2QppFf2GLhNc93Zu2JdxR+HIhyXEQ=;
        b=Pw3HjKZL+nLFU6sLu6jKjNbeU7AKkdkmc/A/499r7/06Mbg8c4SljMLE9HQzXOMicN
         x+DN4h4Rrq76DHYe5HNGesdJtY/lEFKEnaLQ+XsHzvd+qWvhO9h7/VrjHmZuN/uqIiQk
         KgqjYJdnqPgvAvhPORZifH5LSeeC04sAzamlJelgineu7WwPACihYVfpjrmRHarDbYRp
         O/olqUcEi8RP34WXrNFXjQhx5laHmg+8wHq6sDuOaP/XRUtn6NSO7okiYtB44opDI30m
         OOWnEnCJF9F99LQFyk73gKVfiTTEes2GvKEsl22TrTnsug79dCM2pVZvfyO6SA6LINPg
         2i0Q==
X-Gm-Message-State: APt69E3wY7H6hhMuv8ebglOY5BBccBn9i6V5Mq4ioRXY3AIbMleUpxgT
        AEsCWUFUonetFjLWjAmDR6dDLw==
X-Google-Smtp-Source: AAOMgpfWSKaIFbALqYPQPZRVXjIafTBYbupUyX3heZTnoN1pmGKgMIfsJRv2XFaKEJ9mnXTdTra3iA==
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr10389774wmh.116.1530624114814;
        Tue, 03 Jul 2018 06:21:54 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l17-v6sm2019844wrh.45.2018.07.03.06.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 06:21:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: amlogic: Add Internal Clock Measurer bindings
Date:   Tue,  3 Jul 2018 15:21:49 +0200
Message-Id: <1530624110-4687-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clock paths frequencies.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/soc/amlogic/clk-measure.txt       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt

diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
new file mode 100644
index 0000000..ba9183a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
@@ -0,0 +1,15 @@
+Amlogic Internal Clock Measurer
+===============================
+
+The Amlogic SoCs contains an IP to measure the internal clocks.
+The precision is multiple of MHz, useful to debug the clock states.
+
+Required properties:
+- compatible: Shall contain "amlogic,meson-gx-clk-measure"
+- reg: base address and size of the Clock Measurer register space.
+
+Example:
+	clock-measure@8758 {
+		compatible = "amlogic,meson-gx-clk-measure";
+		reg = <0x0 0x8758 0x0 0x10>;
+	};
-- 
2.7.4

