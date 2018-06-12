Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 81514C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36147208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gEshqsMa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PHIb62OA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36147208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932567AbeFLElM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:41:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35398 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbeFLElI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:41:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 10C8060791; Tue, 12 Jun 2018 04:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528778468;
        bh=KCAGd1RvOczUH/aWijumf4oODSSjeRJw3HwytpYLFC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEshqsMayCv9kl2DdEKTsHPh7hZb8wr32scJldsluLsecZwPoLL8OBa3h2xCz0SvF
         47EWLaBCj33u+IfIhmPRUKX8zes1vJwLTgyZuk7BWg38moSvYH8e2qtjH33a4BW94y
         zIGPoL4gT9ZuotkNOVXOXnqAoC7HxlIGrtg6OTj8=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE648606DB;
        Tue, 12 Jun 2018 04:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528778467;
        bh=KCAGd1RvOczUH/aWijumf4oODSSjeRJw3HwytpYLFC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHIb62OAM7XImfRd9IjvuTdMxPe9Ne5/TJopAJRouh6AiE0OcyD+zsJwmdzi3kWny
         VtOYtnpRman2aNdgB51fnAcNewVsO+yYEW1tNYRiOTUkh5f+52TQsYNYkxQTLCggpr
         weICIOiwpA6L4cZ1r+JD7meYSs3jlIv5ySxl9rfk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE648606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v3 1/7] dt-bindings: power: Add qcom rpm power domain driver bindings
Date:   Tue, 12 Jun 2018 10:10:46 +0530
Message-Id: <20180612044052.4402-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612044052.4402-1-rnayak@codeaurora.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings to describe the rpm power domains found on Qualcomm
Technologies, Inc. SoCs. These power domains communicate a performance
state to RPM, which then translates it into corresponding voltage on a
PMIC rail.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.txt  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
new file mode 100644
index 000000000000..61a0e2687940
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -0,0 +1,49 @@
+Qualcomm RPM Power domains
+
+For RPM Power domains, we communicate a performance state to RPM
+which then translates it into a corresponding voltage on a rail
+
+Required Properties:
+ - compatible: Should be one of the following
+	* qcom,msm8996-rpmpd: RPM Power domain for the msm8996 family of SoC
+ - power-domain-cells: number of cells in Power domain specifier
+	must be 1.
+ - operating-points-v2: Phandle to the OPP table for the Power domain.
+	Refer to Documentation/devicetree/bindings/power/power_domain.txt
+	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
+
+Example:
+
+	rpmpd: power-controller {
+		compatible = "qcom,msm8996-rpmpd";
+		#power-domain-cells = <1>;
+		operating-points-v2 = <&rpmpd_opp_table>;
+	};
+
+	rpmpd_opp_table: opp-table {
+		compatible = "operating-points-v2-qcom-level";
+
+		rpmpd_opp1: opp1 {
+			qcom,level = <1>;
+		};
+
+		rpmpd_opp2: opp2 {
+			qcom,level = <2>;
+		};
+
+		rpmpd_opp3: opp3 {
+			qcom,level = <3>;
+		};
+
+		rpmpd_opp4: opp4 {
+			qcom,level = <4>;
+		};
+
+		rpmpd_opp5: opp5 {
+			qcom,level = <5>;
+		};
+
+		rpmpd_opp6: opp6 {
+			qcom,level = <6>;
+		};
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

