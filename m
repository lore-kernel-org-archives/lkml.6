Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A614CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA1720892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oqM7QLXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA1720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbeKGUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:15:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44930 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbeKGUPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:15:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id j17-v6so11710975wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tiSj3kDDE5MLQh1ftvIa3L3YTabjXeVmy/fJcc/8Cvw=;
        b=oqM7QLXTbtYihkAzoqMnb8o8pyNi+btsFS4YeFdiyUZ++Pesf42hvYLaksXFRhJrch
         FnLF5bko9PkjeeSA76Fv5sqXw4nnx02roadBzQzgnJDW1HlrA/NBMBGVMp93qeIZWMvX
         7CmN06MFCEpHOnMZIVuMURZAW2BTKn5VCeLHhr5sJJGqleP4LPKD9vqPRsOnbXFWQFGT
         MN2tWEKCJ6b5JRWFuRCMjWLBiguWaNZR9WD+pClTWCBzinb4yFuvxoJ25nUjkKAWlb6J
         o4wwoV0Ja0cTDYXn4RkKdIU275mCKgrtY7WiJVi8Q4LRhJ5Wq6Qb4L8QbWjZGxjtV+TF
         OkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tiSj3kDDE5MLQh1ftvIa3L3YTabjXeVmy/fJcc/8Cvw=;
        b=CiTh65fCO3oEwPq4c1c4dndLEzN++hnrRGSHLNLwShQCamNTfOQp52D8p8my4BmmuW
         QYftILuARRXLvAr/m+Hi8xdx2W/jS8W75n+uldHqsAtqksuEE1Sici+vkxBAP6OoSVmP
         VnUMh1Jt5MowV1XhPiiF+ZuXdAuWSRzmQLXCQBmLjCf3dddK+pERmiTuliZQ/FPDdMj+
         MQ8CvYHcbCGDRWMm2TS6swLbu/EkayL4HhpMXRvvQrjLObZJ8KhhOkKKfmzOHtGOnB3Y
         ojYPl8qQgOtMBny0zz52xzOPEMMJl0yoKdrqciUS2vVjSJQeZcxTYOyiSBJf4Q2QP/l7
         /doA==
X-Gm-Message-State: AGRZ1gJS2YhNTqzh5ZuPg86s2bUH0ENJqatSYMSzqCgPkzxPVQSFPKPr
        sKPZpX83QglkrM6Jf8X+ckdeyw==
X-Google-Smtp-Source: AJdET5cjDte5GZfyzKPi81x6f6m0IsnVT49JXDgbx8HFcmskutRp55KLjrZX+xiMngthMzlN3Cq+Nw==
X-Received: by 2002:a5d:4e83:: with SMTP id e3-v6mr1448180wru.187.1541587556010;
        Wed, 07 Nov 2018 02:45:56 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h125-v6sm314484wmf.48.2018.11.07.02.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 02:45:55 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: meson-gxl-khadas-vim: fix GPIO lines names
Date:   Wed,  7 Nov 2018 11:45:50 +0100
Message-Id: <1541587550-17842-5-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
References: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio line names were set in the pinctrl node instead of the gpio node,
at the time it was merged, it worked, but was obviously wrong.
This patch moves the properties to the gpio nodes.

Fixes: 60795933b709 ("ARM64: dts: meson-gxl-khadas-vim: Add GPIO lines names")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index d32cf38..864ef01 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -112,7 +112,7 @@
 	linux,rc-map-name = "rc-geekbox";
 };
 
-&pinctrl_aobus {
+&gpio_ao {
 	gpio-line-names = "UART TX",
 			  "UART RX",
 			  "Power Key In",
@@ -127,7 +127,7 @@
 			  "";
 };
 
-&pinctrl_periphs {
+&gpio {
 	gpio-line-names = /* Bank GPIOZ */
 			  "", "", "", "", "", "", "",
 			  "", "", "", "", "", "", "",
-- 
2.7.4

