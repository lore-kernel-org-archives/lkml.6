Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A3CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A247421872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="drmbuvVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfAWUGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:06:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41914 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfAWUGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:06:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so1710517pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dmgYLytqcXpKiqDSGytx2ByKJQl9jIZrL314W+klkqo=;
        b=drmbuvVj3WrMF7JclWnBaSbxihgt2Ara6mWFHxHLpOjfaYjf7WzHPyXAS7v2cHFbMr
         NEKEHg9rX4a7zDdEuVL44qlSdP3D6d6N4EsefvSaatMXfONBeKoZPmbYQtKAqGrgc1Kw
         vynkJzhWAXb6otx5nK7BLmlHySPf7zQ48nzQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dmgYLytqcXpKiqDSGytx2ByKJQl9jIZrL314W+klkqo=;
        b=gqRK0W2KDkqVK/2ecMHtHYq93XfD0XFmuhT1yfv8Lju0SP4diteEJYbJOUXJZbqbrR
         B6W+ayjzs1BkONj6f2cSzwl2+Q3w84xrd1BCcfGkIwtlT7ptWE+vyq1pbpQkdkyOql4D
         aOXDJ3IadXVoeFqfnNkNKsStcYCSFBFlPJGKBtIj9HqDInbhKd7X4APyDv2WzYK2zH7B
         6DQF5knuuhNdodMXO1in9ue2xjn4T+q/4SfurbF5hYiTXlxsviGDsea/t0sCOex+Qxr8
         tm10upAu08XwJaEHp7MAjpMHLlOGWlOGL9pY+lwWmPY+bcN38ImOtyhmM8DZGs0lYnXM
         Fe8A==
X-Gm-Message-State: AJcUukfK6hYVzNNrPIYPcqjZ9JTXLKAVGb/iUEMS2xJwd98eFbTp4v73
        d2MpKV7VogCjC8lfu7+6Un0KUDBIqMyfxw==
X-Google-Smtp-Source: ALg8bN60lx7LloKEj2l3IH4PQOVBIuD0VpNSKOxXF9ETH+Es3aw+Zn/c1zFENR/+faWopYtiyGFtWQ==
X-Received: by 2002:a63:e950:: with SMTP id q16mr3282071pgj.138.1548273971449;
        Wed, 23 Jan 2019 12:06:11 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id b9sm23258345pfi.118.2019.01.23.12.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 12:06:10 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Alistair Strachan <astrachan@google.com>,
        Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "stable #4 . 17+" <stable@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH] arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
Date:   Wed, 23 Jan 2019 12:06:06 -0800
Message-Id: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Strachan <astrachan@google.com>

This reverts commit abd7d0972a192ee653efc7b151a6af69db58f2bb. This
change was already partially reverted by John Stultz in commit
9c6d26df1fae ("arm64: dts: hikey: Fix eMMC corruption regression").

This change appears to cause controller resets and block read failures
which prevents successful booting on some hikey boards.

Cc: Ryan Grachek <ryan@edited.us>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: stable <stable@vger.kernel.org> #4.17+
Signed-off-by: Alistair Strachan <astrachan@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 6102350..7092460 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -300,7 +300,6 @@
 
 		dwmmc_0: dwmmc0@f723d000 {
 			cap-mmc-highspeed;
-			mmc-hs200-1_8v;
 			non-removable;
 			bus-width = <0x8>;
 			vmmc-supply = <&ldo19>;
-- 
2.7.4

