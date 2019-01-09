Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DF9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289CC206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R+F5cxRm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i0I9uYfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfAIJEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:04:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52844 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfAIJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:04:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 606D560918; Wed,  9 Jan 2019 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547024678;
        bh=0FuryYZjklruzdziuoXE2MTVf+rPH8jOd9Q2fjSPMPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+F5cxRmAE8s/tEEKrJaeesBDRlcTTyj/ssSJkmWrkDg/ht3ZtH3kkFUKBHBVLemk
         apqn/8c9pKU0jKmLaqD/geqL//ZHBy28i/IWZa2t8+4123ImWoOiVdDrdQC2UxRBET
         O9KnXfnU4xgY71QVZoykb7QwonoQ5GBY4T0cw+q8=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32A7C6089D;
        Wed,  9 Jan 2019 09:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547024676;
        bh=0FuryYZjklruzdziuoXE2MTVf+rPH8jOd9Q2fjSPMPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0I9uYfU8OJw6+f/H/bO4WE7gu5JQ3bcSuiExZ68qu4JIarvrLSvww1OgYMSfR9eL
         77lQTKM1VltM+chJuzgJMXlQye794SIbwVtYgQnXN45SDDX6/ceLbqUfkLZxnemoUS
         ZzFZVBOns8OWD+Kzls1V6VkwzFvqhEHI6aSioN/k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32A7C6089D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v10 1/9] dt-bindings: opp: Introduce opp-level bindings
Date:   Wed,  9 Jan 2019 14:34:12 +0530
Message-Id: <20190109090420.8100-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190109090420.8100-1-rnayak@codeaurora.org>
References: <20190109090420.8100-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SoCs (especially from Qualcomm and MediaTek) an OPP
node needs to describe an additional level/corner value
that is then communicated to a remote microprocessor by the CPU, which
then takes some actions (like adjusting voltage values across variousi
rails) based on the value passed.

Add opp-level as an additional property in the OPP node and describe it
in the OPP bindings document.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index c396c4c0af92..e83fb7cbfd58 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -129,6 +129,11 @@ Optional properties:
 - opp-microamp-<name>: Named opp-microamp property. Similar to
   opp-microvolt-<name> property, but for microamp instead.
 
+- opp-level: On some SoC platforms an OPP node can describe a positive value
+  representing a corner/level that's communicated with a remote microprocessor
+  (usually called the power manager) which then translates it into a certain
+  voltage on a voltage rail.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

