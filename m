Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0BAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07E621928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QudLWP+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437925AbfBNR6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:58:11 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55468 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437856AbfBNR6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:58:09 -0500
Received: by mail-it1-f193.google.com with SMTP id z131so6802722itf.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gd56skZROQuoUVaN4sNpxlterBec6i5NZQ5F4gBEN3E=;
        b=QudLWP+sniBzsE8uYjGXuJXcEydbgmJhe/GvRfu9kTa9EIp4Z2eDYZ8REpNLIpE1Zm
         fyaW5eIjNG4/Fzzq+CL+z8f2UIIQqAc0EXYUO/coSwHV5l5bgbqTBH1lZAA+PV32UUS5
         rKgOyUjPR/1hen90tuQTJdD8IJTesj2YRH23g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gd56skZROQuoUVaN4sNpxlterBec6i5NZQ5F4gBEN3E=;
        b=KiM5tzkOxuAEtSGdeMmb+FaIcmaIhZ827a+GYLqQxxXnYUG2zgytNfzSzuJXzaL2Zj
         cBxB1E+h0W7whkhz0obPjVqkoOVXHOSsl3JWrgM7AD78TUgQPMMBbJvtumW5tiOvC+Sj
         xFrXhAlrkgxDPs8J8NKI8wb85Scl/UHil4iW9Ws7HOqtdFFPPlIxODAh8ZClsjRBrxPZ
         UB9dCKNa7P1ZWQXpkG7l0bdyE2oyQPA73aj5MI2Q8FxYoUQYS9hd1BzFD4+sRIUCluDd
         nnLoxCWTBZvfhFSkgfbWymq4efhyxXaTVpI0caqD0llJA9RfD5W8B0bUo0gFjBhXkbiU
         B80Q==
X-Gm-Message-State: AHQUAuYKZ5k0xW33XJZlGZgohQ8AlOxp+ZhE3HNftEniF/S3OwDrJPHp
        Sufu1kkyGykOrEDDdSI15YqmKw==
X-Google-Smtp-Source: AHgI3IbI06wiWDqUs7HRa1Q+9hP8xygHiei3IcNiwtWZlToH3VapRCyZPICy+iKeXQfRl1apGw4DCA==
X-Received: by 2002:a5d:9287:: with SMTP id s7mr2799518iom.295.1550167088620;
        Thu, 14 Feb 2019 09:58:08 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:58:07 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 8/8] arm64: dts: Stingray: Add NIC i2c device node
Date:   Thu, 14 Feb 2019 09:57:25 -0800
Message-Id: <20190214175725.60462-9-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
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

