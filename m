Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993AAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6180A2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMWB5LAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6180A2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeKVBaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:30:11 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33848 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730863AbeKVB3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so5139633ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jZzbzufkijj2Q6XEViuF0h1bEmtCA3b9mtgJuF57c0=;
        b=qMWB5LAKglayGsfhEA3TDkz/Afm278+LyGYblly4kUDDnCqqBg5v8G8lXS2+j+SBMR
         ww0jjukmqejtwc5iegrtnIJnKIY+wxFp9hAzKB+k5HLw2OBhYgUOUJ1c8D2F02HIi3gv
         /xaa7RPVf+cG7ISclavVFCX9gYkW/A9XxMbt0UmvoZgLU9bTFB7UYjpbqcmDT9pFxy1Y
         +HjeZAtmeul4OANr4w5Lfdpm/R+I2oe0mKEvxi4aQCnM4K27/rN6F7qDFlG0rEXRYAE3
         tnBBzzSK2U2d73egMLkvxT5dROKrkuipxhJGjwRWibQwzo0uomDTEulxH5QWwmLyB2Qy
         RajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jZzbzufkijj2Q6XEViuF0h1bEmtCA3b9mtgJuF57c0=;
        b=L/Ot7V4ouZ6PQw9M2J8DQ7Uft160notBZmw4NZD5pwIMXi2U+3NAC0V27RKICb5FX5
         mjjKrDp+dWVty0tJOK76MSOE+anWsJTtlmnL2rrzYx++R4eIN+WKfLXEIFyeH+PmqExv
         WtxjSnHcz41jxNl+9odF4nvocrb+rf0zgdXiJMHerqpG2PbXOacq2FuPCG9R6DHspoKv
         3XT+hsDAOHzt/3vV720883K3TMCFLCJNi9ri5UaiwmJzcra8/s8u1agxBd16W2MYiJzA
         D6DynIu4lPAd1nXNscEK4zBESGx+pk6CrnqwyjasEvlpvIu7a/tyVbcYT7csxUmLt2la
         /U2w==
X-Gm-Message-State: AGRZ1gJlvcSPPiwTdbJ2wxk3yt+Fp9uAvb9ZR4jjnNTag357XpfNy7QZ
        eIV5rMc4TTkIP40uIacl6eDaK6AW
X-Google-Smtp-Source: AJdET5czicEpTzVmWMV2GNTqYQph9xrl+F0OAZSAU4L/UqMc+5/2ozpieVQiUD7ixXWij4pVshDSeg==
X-Received: by 2002:a17:906:2acf:: with SMTP id m15-v6mr5238449eje.180.1542812095221;
        Wed, 21 Nov 2018 06:54:55 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id p36sm3672751edc.78.2018.11.21.06.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:54 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] mailbox: qcom-apcs: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:26 +0100
Message-Id: <20181121145429.7582-17-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121145429.7582-1-thierry.reding@gmail.com>
References: <20181121145429.7582-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index aed23ac9550d..3cf2937be149 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -91,7 +91,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 	apcs->mbox.chans = apcs->mbox_chans;
 	apcs->mbox.num_chans = ARRAY_SIZE(apcs->mbox_chans);
 
-	ret = mbox_controller_register(&apcs->mbox);
+	ret = devm_mbox_controller_register(&pdev->dev, &apcs->mbox);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register APCS IPC controller\n");
 		return ret;
@@ -115,7 +115,6 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 	struct qcom_apcs_ipc *apcs = platform_get_drvdata(pdev);
 	struct platform_device *clk = apcs->clk;
 
-	mbox_controller_unregister(&apcs->mbox);
 	platform_device_unregister(clk);
 
 	return 0;
-- 
2.19.1

