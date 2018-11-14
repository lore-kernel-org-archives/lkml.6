Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE24EC07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D0C22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aY3gUgK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D0C22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbeKNXTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:19:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39600 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbeKNXTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:19:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so14747368wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 05:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6byBe9Al5tAC5NstU3tZ5zh348CSZIw2l0zT1ZAN88=;
        b=aY3gUgK1VqOiJyFbuySLbyRUgLQLb973zDN8JI8a2/+3XFmsjsspToDZ11s475G9sO
         /F1qnHs3nc67BMxm5k9xRl3uiV4LWKRnnS3b0mkTads5HwMNtbFhVgF8Rxs9tNIVx2K9
         fxjvk3qbMUCvU/KH8Dl81BFwLmWxQlD/nufoDkVXLkeLzT7RTy1DD7xrG85Y6XdN9Up1
         axXFtLdQHQBM6t5j7VSCYsFUgM245WnfAK0MtkE4h243R8i5K7oPjCIR+Iiw1wpgAFO2
         es2Uj3spaUDHX6vTxKg9AzdHf/yUizxpUzjtRZ3349GdjgvFTNj4te+dQ9hiU+x8EGVh
         Ym5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6byBe9Al5tAC5NstU3tZ5zh348CSZIw2l0zT1ZAN88=;
        b=mYL6VA4MbgvmnEvRSQXaQSKMXQi1J+MMTxDAm9hzpZgIWTTO1jedrHKhXiTnFzjCQ7
         oLP3M05tn42l758KmzvAu1jZLER7IcRWibl/LKJ7fQ3zCESmoHG3cuAbgIbCQTgrshZS
         LBWzaDXqFUpotVRuf0Gv7RBFNmfF4bwP9xHi7iuMp/QNRYjdEsSX6XY/LnptQLu4gM64
         MJxakaweQpV8bXaaIKu6A0GOOtFhfaYpR/KxyyH6Wam/5xQr/dXMeg46zQ8/gtojDR+m
         Z9SG3ttTxU5PCSv6X+N8pv1uu06e8Vv4+QswcIwuYftfCJP6RgAM/pkIuDRTCjxHIgdn
         riqg==
X-Gm-Message-State: AGRZ1gK3rkWuWzNrxBGTmNAovG594+cKYEogE4mJP7OYXlhZ6MWEfhay
        ha/O+Roc5RgyOudhT75S+Vubtw==
X-Google-Smtp-Source: AJdET5cT5noX5Z24TSDlbfpGKr46Fzbd2z9R23ntFeaYAcs/fJlnJTPzmyw8wBB192M6wXLHuH+uAw==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11-v6mr1980133wmj.10.1542201392123;
        Wed, 14 Nov 2018 05:16:32 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z7-v6sm22715225wrv.21.2018.11.14.05.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 05:16:31 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ARM64: dts: meson-gx: Add Internal Clock Measurer node
Date:   Wed, 14 Nov 2018 14:16:27 +0100
Message-Id: <20181114131627.17766-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114131627.17766-1-narmstrong@baylibre.com>
References: <20181114131627.17766-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clock paths frequencies.
This patch adds the node in the top-level meson-gx dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index f1e5cdbade5e..ed336c7a98a7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -262,6 +262,11 @@
 				status = "disabled";
 			};
 
+			clock-measure@8758 {
+				compatible = "amlogic,meson-gx-clk-measure";
+				reg = <0x0 0x8758 0x0 0x10>;
+			};
+
 			i2c_B: i2c@87c0 {
 				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
 				reg = <0x0 0x087c0 0x0 0x20>;
-- 
2.19.1

