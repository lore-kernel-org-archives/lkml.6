Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B5ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EA8206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlvJSfjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EA8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbeITHWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:22:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41139 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeITHWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:22:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so3598718pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6FcYZH3kgXMrtoZIN4ktequDdJH21aWnwcqbcgnDuEU=;
        b=AlvJSfjXXgbN/9JSzGBjfaAbDE+Icbr6IantTNRAuEYRpPb5/M0QQYGAKykWcLdWq3
         y+pHxB1bIPE/EzVQuss5hg4Vl1mecvZmKudtbx2xQb0q/R9WK79NsYBin++CIwm9Rxck
         aOKR+3Xzje8i1ggtn0nJkszVRtqZspPzcpBmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6FcYZH3kgXMrtoZIN4ktequDdJH21aWnwcqbcgnDuEU=;
        b=fTlTRHASV2w3L85oE0qITa1M+RAxW7FeqwpwzuKy0L+tgj2N5bBhDzFRb0c3iMCvTY
         PqqSn5QbRSXsS+Ci9+WX93FERgRL944oguB4LNhs91qSL1f+5tp8riM4UQ6nKWmyz+dn
         mvkUoF3+YYdyBUZumZVvrhOou9FjDa/77P7O7L7zXEgKybPTMIEqtEKABSSY0dTJSXY3
         lLmmgRXMUqs4hc+RV6G26nH2A7flwg9JzN9PSQ5gbaq6uyh35BNl5nRNwBOntOzNiVuM
         +IZr+D3px7R0oXJiBAUzde4oJx4m1KaomYYH73XH7jWOP8pMQFvnQKspI8gOgsZomeWd
         XfcQ==
X-Gm-Message-State: APzg51C128RPQlLDjC45HfL2iaGoeBTbrzBrpOFzrzpYzL0WNg1xTiCf
        TYNVAqD21H8+csO2ur8oP4zXaA==
X-Google-Smtp-Source: ANB0VdZLbfo9Q9DNDLvq3sGMwuswaXUvohQsevoJWu8ayr5YUl8mb89qNKKqUacdS35a1PsmY4atZg==
X-Received: by 2002:aa7:881a:: with SMTP id c26-v6mr27033994pfo.82.1537407711162;
        Wed, 19 Sep 2018 18:41:51 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l3-v6sm28036809pff.8.2018.09.19.18.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:41:50 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] mailbox: qcom: Add QCS404 APPS Global compatible
Date:   Wed, 19 Sep 2018 18:44:08 -0700
Message-Id: <20180920014408.14645-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the QCS404 APPS Global block with IPC register at offset
8.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt        | 1 +
 drivers/mailbox/qcom-apcs-ipc-mailbox.c                          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
index 6e8a9ab0fdae..1232fc9fc709 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
@@ -11,6 +11,7 @@ platforms.
 		    "qcom,msm8916-apcs-kpss-global",
 		    "qcom,msm8996-apcs-hmss-global"
 		    "qcom,msm8998-apcs-hmss-global"
+		    "qcom,qcs404-apcs-apps-global"
 		    "qcom,sdm845-apss-shared"
 
 - reg:
diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 333ed4a9d4b8..aed23ac9550d 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -126,6 +126,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = (void *)8 },
 	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = (void *)16 },
 	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = (void *)8 },
+	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = (void *)8 },
 	{ .compatible = "qcom,sdm845-apss-shared", .data = (void *)12 },
 	{}
 };
-- 
2.18.0

