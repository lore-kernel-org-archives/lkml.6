Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A23C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A91C2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i/kqVtma";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i/kqVtma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfAJEDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:03:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfAJEDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:03:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 66484608C6; Thu, 10 Jan 2019 04:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092990;
        bh=l8Qx+naGUMK0vxCdn5acoRvtP7BYOkxPyNrfAiktrIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/kqVtma3fMgutE8V5wyHaz9a1+uRGMidf+28h9wunxzPoGENdEdSkVJqIgihx0t1
         Yr2qs93Yyv1hHCPYuyM7PR2NCUBziTucXF4Gou4RcAkaWN9Rur9X1ct67ZFPkq0He+
         AFl4WtOnzBqEav0UNXtl/7wZMiszsWy5mZ1rOqes=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 741796038E;
        Thu, 10 Jan 2019 04:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092990;
        bh=l8Qx+naGUMK0vxCdn5acoRvtP7BYOkxPyNrfAiktrIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/kqVtma3fMgutE8V5wyHaz9a1+uRGMidf+28h9wunxzPoGENdEdSkVJqIgihx0t1
         Yr2qs93Yyv1hHCPYuyM7PR2NCUBziTucXF4Gou4RcAkaWN9Rur9X1ct67ZFPkq0He+
         AFl4WtOnzBqEav0UNXtl/7wZMiszsWy5mZ1rOqes=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 741796038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v11 1/9] dt-bindings: opp: Introduce opp-level bindings
Date:   Thu, 10 Jan 2019 09:32:01 +0530
Message-Id: <20190110040209.6028-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190110040209.6028-1-rnayak@codeaurora.org>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add opp-level as an additional property in the OPP node to describe
the performance level of the device.

On some SoCs (especially from Qualcomm and MediaTek) this value
is communicated to a remote microprocessor by the CPU, which
then takes some actions (like adjusting voltage values across various
rails) based on the value passed.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index c396c4c0af92..76b6c79604a5 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -129,6 +129,9 @@ Optional properties:
 - opp-microamp-<name>: Named opp-microamp property. Similar to
   opp-microvolt-<name> property, but for microamp instead.
 
+- opp-level: A value representing the performance level of the device,
+  expressed as a 32-bit integer.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

