Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 099C1C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986EA208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edited-us.20150623.gappssmtp.com header.i=@edited-us.20150623.gappssmtp.com header.b="Uq3tlamE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986EA208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=edited.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935289AbeFMSDi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:03:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55185 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934979AbeFMSDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:03:37 -0400
Received: by mail-it0-f68.google.com with SMTP id 76-v6so4904832itx.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edited-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hmx49JA4SdV0v55lcbbTrnyvgfCJ34NupkA+KHaUE5c=;
        b=Uq3tlamEHcV4caYocvWHKtpGSp2nCyMUmnH1sAU+l+fzktFp+PON0tzvK4sqTMcTYU
         Dk9Zs4yU8B/ayy0JkmaXwAU7O1K/MJUeeFirTdU/4WRvX6MKGpXsyrouCqnqwWy1Q+81
         /4jCL2kZyYGn63v2StVrAoaqHefbJJdOFJJ9aB2/Dd2mjF1921CkKoo5xMjh0YGzpp2S
         yNam6a4PdDhxka596ZE8PoGXGJr69C6oXETPzpHhg4MfhhuMaXLFwh7ZHa7QVWEeIzTH
         mOD1AMBPne0ENC+oZe/8ra0+y6GVP7hI7M9nPTdXn5LsF54qUscAkk0s2WXlA8ZevIWQ
         a+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hmx49JA4SdV0v55lcbbTrnyvgfCJ34NupkA+KHaUE5c=;
        b=ojJRqPpSYpNs8ZNib+HjQOFjvZhOFTIUASBlPwqiPWRnH+QmasiaBZVpX2FlLp9Xc6
         zmHb6FgvhhkY+rr7WKqyfNEAU8ObAfUAVGl0egpWNL2tirA16ydOkTKvYBapbB+bJ6GN
         kVM/z+PIuP7etARNJkge1oKbu2Kr7sLCoxVrXa25GYFxUEmFCmXfZWg+/sOOoTZkkyTI
         l5wZ9Nf873hvQya1UMEC2IP7QNoECYgh5E4cdQIDsWFO9j2yRVWtIeLCezd6bVdm0PRy
         MHJ3uqeopsiEB5guRCd11lhLZ0DKPz1fer1mFZ+3SLdQ3Uh/nCCCh5Jll183V0UzKR2b
         dfjQ==
X-Gm-Message-State: APt69E2TAoVm8Z60pxdkaRovtBCrfARVQuspDbS5olmuMdlxcfjkxkes
        kajl21JeiEIScSXHPkxJw9zwIDsitAg=
X-Google-Smtp-Source: ADUXVKKpTGGEm+s1c9vkmpXQI2A7APDHD7tf5ZcoLA6EIieMEDe+FTWSsc7dS/iGAryDES0fFVNofg==
X-Received: by 2002:a24:83c2:: with SMTP id d185-v6mr5937579ite.152.1528913016353;
        Wed, 13 Jun 2018 11:03:36 -0700 (PDT)
Received: from localhost.localdomain (ip-17-240-239-173.midwest.us.northamericancoax.com. [173.239.240.17])
        by smtp.gmail.com with ESMTPSA id y18-v6sm1082518ioa.10.2018.06.13.11.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 11:03:35 -0700 (PDT)
From:   Ryan Grachek <ryan@edited.us>
Cc:     valentin.schneider@arm.com, Ryan Grachek <ryan@edited.us>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hikey960: Define wl1837 power capabilities
Date:   Wed, 13 Jun 2018 13:03:21 -0500
Message-Id: <20180613180321.16745-1-ryan@edited.us>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These properties are required for compatibility with runtime PM.
Without these properties, MMC host controller will not be aware
of power capabilities. When the wlcore driver attempts to power
on the device, it will erroneously fail with -EACCES. This fixes
a regression found here: https://lkml.org/lkml/2018/6/12/930

Signed-off-by: Ryan Grachek <ryan@edited.us>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index c6999624ed8a..68c5a6c819ae 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -585,6 +585,8 @@
 	vmmc-supply = <&wlan_en>;
 	ti,non-removable;
 	non-removable;
+	cap-power-off-card;
+	keep-power-in-suspend;
 	#address-cells = <0x1>;
 	#size-cells = <0x0>;
 	status = "ok";
-- 
2.11.0

