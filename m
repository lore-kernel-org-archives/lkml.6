Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09923C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07BC2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtvMdPeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07BC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeKFGAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:00:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeKFGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:00:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so11018522wru.9;
        Mon, 05 Nov 2018 12:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8lkbYhVhnvwWz+RGh4ckcfkr/nd+SKhMEzNas34N1tM=;
        b=PtvMdPeSwfRLoEyySe5xziSQwVWcJQ3mgyrVwiIQWFzoQfvUE+qX2O5wHTLSqth6o3
         DFOD4RgWTd0RWFjJ5liJpX6cbHM4NEWuL40+SzWA1ptWwW035mO65SIQ+kVyUfiOXDQ4
         r42aHCWD/yS5es698gNn5FsF05Re5aldmtmE1UGxOLtDHKeGb7taTAVNwCBdJ+PFhQlF
         8MR5LHdlLV/SyqHeh1eb4aZI23Buyj5JJb46OxwnW3lzLjZnnDFwMIEdfkzEFpd6f+ap
         CcTv8TxpQE6xM1P4QqPq0NGHxvU6maxrrPePDoXyz6d/Y2Q2bNQwAS0XH3zHLHgLSjb3
         7nEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8lkbYhVhnvwWz+RGh4ckcfkr/nd+SKhMEzNas34N1tM=;
        b=bHdq2aj+hbTefO5rsgg+Ou+rCj4jskt3rVVubTibYeTGtuki41/X/DW/L1rWfe1hN0
         VArVqGdFc7aFjRETJj987r8iaPd+P8V5YEC9XCfFIgwT53UgWzp4GWvFyjtLvMb5l8gi
         ZCMgDxNt4Vu9BxE1hDRPH47ZzCoaM9B+RIIwGz08yfRjkzSE7ahF0bCopKvLRQomFXji
         2aa94Id1iPsxwPuaOICrsZMouvp41niLT2iiPDgfSccVqOT1qSXgAFmsT01i8C+JBbRp
         cjkT31oCxNFhtfWAE67XGhUtve66eNmGrsaiMOCC1pr7AD2rcEdXzIhp+m5c6B5n5JBN
         nrxQ==
X-Gm-Message-State: AGRZ1gKcWlV0djyzRjgwfZynsKGZyIAM+M1+ScdaDob38Qdri5wQhytC
        uQQgFv/3zjcyx5NujbR/pQ0=
X-Google-Smtp-Source: AJdET5e3pWtuuqBBsoELVtBRsPtgwUEjkq3BLv+aS+aFMfFGVfDFWT+01AAPmlvS/SwueD2tOE5QSw==
X-Received: by 2002:adf:91c3:: with SMTP id 61-v6mr21345180wri.97.1541450352105;
        Mon, 05 Nov 2018 12:39:12 -0800 (PST)
Received: from ubuntu.home ([2a02:8071:6a3:700:456c:50ae:6b7:768d])
        by smtp.gmail.com with ESMTPSA id z17-v6sm14289792wrm.65.2018.11.05.12.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:39:11 -0800 (PST)
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Vasut <marex@denx.de>,
        Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: [PATCH] ARM: dts: socfpga: use tabs for indentation
Date:   Mon,  5 Nov 2018 21:39:00 +0100
Message-Id: <20181105203900.23788-1-simon.k.r.goldschmidt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In two of the gen5 socfpga devicetree files, there are some lines
indented using spaces instead of tabs.

Fix this by correctly indenting them with tabs.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---
 arch/arm/boot/dts/socfpga.dtsi               | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 2458d6707dc5..0a028254b14e 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -759,7 +759,7 @@
 
 		qspi: spi@ff705000 {
 			compatible = "cdns,qspi-nor";
-                        #address-cells = <1>;
+			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xff705000 0x1000>,
 			      <0xffa00000 0x1000>;
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
index e54b5f2af74f..99a71757cdf4 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
@@ -111,9 +111,9 @@
 };
 
 &qspi {
-        status = "okay";
+	status = "okay";
 
-        flash0: n25q512a@0 {
+	flash0: n25q512a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "n25q512a";
-- 
2.17.1

