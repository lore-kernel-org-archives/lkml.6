Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1E3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB7320849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Swy/WrV8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A8ZKWrHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB7320849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeLKJt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:49:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLKJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:49:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD287607DC; Tue, 11 Dec 2018 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544521793;
        bh=M/OyVjfWsE/bzaZp5l1+nWJQBalw47tF3PBUHjtfmb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Swy/WrV88TvJu3aNMzO1Kxv7ibu7PtRlnru06efknhg8XHeXy4DsKJctjlS9g5TJm
         6yPcNmSUplMA+CdA9TvBv5gQI6xeBXP61m3eqM7hx+j15q8+Ehls5hWm5ggBnIFEna
         PHegWQ3zv4UF9Ohsk+BZUV+WIKFPAy3SvcH06uB4=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F987607DC;
        Tue, 11 Dec 2018 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544521792;
        bh=M/OyVjfWsE/bzaZp5l1+nWJQBalw47tF3PBUHjtfmb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8ZKWrHEr9gq9UHgXcaZVfLp2YDTRak47sDJLTSslM1KTpgxwt3AmsVV5vVUvyllT
         g8K9RMkQV9u38pr7P5scsySdo3awZCLOEhYHr+ck+O7AlVIXuIrOS9vJMxutF/WeF6
         IP/FI3rpi4qpYU6N8nxQuhvT2xoVDeHiaAhOjyiU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F987607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 01/10] dt-bindings: opp: Introduce qcom-opp bindings
Date:   Tue, 11 Dec 2018 15:19:29 +0530
Message-Id: <20181211094938.25086-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181211094938.25086-1-rnayak@codeaurora.org>
References: <20181211094938.25086-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm Technologies, Inc. platforms, an OPP node needs
to describe an additional level/corner value that is then communicated
to a remote microprocessor by the CPU, which then takes some
actions (like adjusting voltage values across various rails)
based on the value passed.

Describe these bindings in the qcom-opp bindings document.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/opp/qcom-opp.txt      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
new file mode 100644
index 000000000000..db4d970c7ec7
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
@@ -0,0 +1,25 @@
+Qualcomm OPP bindings to descibe OPP nodes with corner/level values
+
+OPP tables for devices on Qualcomm platforms require an additional
+platform specific corner/level value to be specified.
+This value is passed on to the RPM (Resource Power Manager) by
+the CPU, which then takes the necessary actions to set a voltage
+rail to an appropriate voltage based on the value passed.
+
+The bindings are based on top of the operating-points-v2 bindings
+described in Documentation/devicetree/bindings/opp/opp.txt
+Additional properties are described below.
+
+* OPP Table Node
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2-qcom-level"
+
+* OPP Node
+
+Required properties:
+- qcom,level: On Qualcomm platforms an OPP node can describe a positive value
+representing a corner/level that's communicated with a remote microprocessor
+(usually called the RPM) which then translates it into a certain voltage on
+a voltage rail.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

