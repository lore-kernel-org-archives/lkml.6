Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BA1C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E4121A00
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aadu5mYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E4121A00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeHKS7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 14:59:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33701 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbeHKS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 14:59:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id r24-v6so3937296wmh.0;
        Sat, 11 Aug 2018 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U8atxoDARTOymvVutyPnTGrPJcjy1C6NjzNC5Zs7LFw=;
        b=aadu5mYesDcxt3xzFXe8KlJMyqsXxtc7p0YY3qXVwVyEVxKRFwDpbFurcRi607DaUt
         MlrezVbFv2i7J63U7NQuPg7KO8/etobrSEE13uoZLyhgZtW2DibpqpYcu/4g0Om+KxWV
         EELwIkEdvz7YJwVRPUkiXVfbzYw8JlqeHc0WBorz2cjM05QJx4pSrPSB/olrhcJ4GNhC
         PaXRWlrdVAdWRwfdq6v1WzhGNFVup4qRTN/HMhwJ072jtq83+MbmzPw0HYORMIY4jix0
         YfVXQ0CbVlFdGoCWWRJc/b6mOtLTc7BeCOdv3Beadew4P84ZIvGMYt7kyDCKfhUWxXZY
         V6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U8atxoDARTOymvVutyPnTGrPJcjy1C6NjzNC5Zs7LFw=;
        b=M8wciMWCZlWDPnuCxdnenGAic1+Kt5RI4oJItyeFfhnLilJ/R01gLsTKL5XiyEfVfV
         3nGRitumSk5cndukJPihlxe/MdQhUarSWdja6+9zUf8Guk41TbxewA3J9OQA+kI53D/s
         Mj7At9pFfWby8cMLCJEAKXdd0mHEa7hfDuywDHOmUbvG7J+6j90hHGVAA8vbfwy+0kiJ
         rr7pZJyzu5xRYXmN/C6HIGy6mX5KBhMcfuheHYpZ3Fp2qmlCumaB+YzqR5XPIpTAXQYa
         sfDX5oKFcZ/oYBfmua3ybtA//Sfd9bmKtAEaAydbSob3m/xYIprn5QquH4L9elPcHmkm
         Btvw==
X-Gm-Message-State: AOUpUlEQzicVIgYkhI6gQaFJGecEuf8ffjvW7ur8zaCZtohFqbyRkaHb
        //9/prHU/9gKgDiiVOPr7A==
X-Google-Smtp-Source: AA+uWPybL093e1P711QuTpmfe8pF6YmREHyq6HsibFYUzu6eBSSm7lBn1eqqMpJjlHmZILf18iATzw==
X-Received: by 2002:a1c:cbc1:: with SMTP id b184-v6mr4341914wmg.149.1534004666703;
        Sat, 11 Aug 2018 09:24:26 -0700 (PDT)
Received: from localhost.localdomain (host86-141-127-107.range86-141.btcentralplus.com. [86.141.127.107])
        by smtp.googlemail.com with ESMTPSA id z8-v6sm10308142wrp.54.2018.08.11.09.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 09:24:25 -0700 (PDT)
From:   Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: smd-rpm: Add sdm660 compatible
Date:   Sat, 11 Aug 2018 17:24:17 +0100
Message-Id: <20180811162417.10143-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for the RPM in SDM660, so that rpm resources can be
made available.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt | 1 +
 drivers/soc/qcom/smd-rpm.c                                  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
index 89e1cb9212f6..c38d2b91aadb 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
@@ -23,6 +23,7 @@ resources.
 		    "qcom,rpm-msm8916"
 		    "qcom,rpm-msm8974"
 		    "qcom,rpm-msm8998"
+		    "qcom,rpm-sdm660"
 
 - qcom,smd-channels:
 	Usage: required
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 93517ed83355..05d4dec15572 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -227,6 +227,7 @@ static const struct of_device_id qcom_smd_rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-msm8974" },
 	{ .compatible = "qcom,rpm-msm8996" },
 	{ .compatible = "qcom,rpm-msm8998" },
+	{ .compatible = "qcom,rpm-sdm660" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
-- 
2.18.0

