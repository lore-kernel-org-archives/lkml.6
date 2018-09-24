Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA356208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NenG7WWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA356208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbeIXX3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:29:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40376 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbeIXX3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:29:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id o2-v6so4288476wmh.5;
        Mon, 24 Sep 2018 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63LIMb6KbDrx/QBE3cb2KhMnQMLOmx1TirKP2yjUk+I=;
        b=NenG7WWw0PAIlu5x+XyNteeSQtkM929W+LOtG3LBwA6/AUneVG0gP1wPzYg32J99gz
         NMFimf82E/4pUdVbPIYrxYFwDfbKNZPLWTJ4LKk8A2Vl8OM3gCA+mYIVjyLGTBtEISof
         XiSe2/8y592ARimbmCC7FWI47vov39W3LukoPswilw7HToW1vD/eOEcSumcmgum8Jv36
         nV72ry+q2WZq39D4610YRT3uJDoT05iM3AKv4OtuU6nPip02+pa0Tof7PfYjJN3zZv4/
         ixJ3hDHaOVEXwF6rfu21LzpUvq0dayAKskKblSUAw2v2LHbX5r7mrC4z9PWNMEP+Stuj
         H4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63LIMb6KbDrx/QBE3cb2KhMnQMLOmx1TirKP2yjUk+I=;
        b=gFGX4QA4PaUIzFasQfOih7JuS7FSVAVR9DU7gMTZc3DPuWXIKihD1BiJtaqTpZJnev
         n+116CXwpsTEFQSgDNeKZBobLu8N2yVKennwRrM7sjatpsTx8ESKJzgraF6BVbKpaSev
         5lxq3WKZuVaDjdQ7lWm8MLksySfWhUGMkorQbdU1h7QxEogQjkbRqBcORKMG52aHFvcE
         q9f0xAlNGEzW2KmuKQnivQhAIF96K0OT3n2/HFHPOWTeZTAsow+z+Ms4+UBa0GF/NN45
         RcXvKMNuYlvZatkLDfy74std5AJVO0+oqNwRuz9Yp/tDALOV+bR425ZmmQj7PSYosUMh
         YBYA==
X-Gm-Message-State: ABuFfogH0lAMAXbNjNxX1mMeQHifNPmAwhkUqGqTj2YrXtWVJb8N4iY/
        8warNJNHE4ekzRjGdtASsnw=
X-Google-Smtp-Source: ANB0VdbY9tLqWOSCRCSSNuxPE+m7ZVS/D3E3GlA7aiwgogrX/gug6TxHr9vFb/bmjPTEAURlUe29uw==
X-Received: by 2002:a1c:1584:: with SMTP id 126-v6mr8416852wmv.24.1537809992104;
        Mon, 24 Sep 2018 10:26:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z10-v6sm36480032wrv.22.2018.09.24.10.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:26:31 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] crypto: ccp: Remove forward declaration
Date:   Mon, 24 Sep 2018 10:26:15 -0700
Message-Id: <20180924172615.25591-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang emits a warning about this construct:

drivers/crypto/ccp/sp-platform.c:36:36: warning: tentative array
definition assumed to have one element
static const struct acpi_device_id sp_acpi_match[];
                                   ^
1 warning generated.

Just remove the forward declarations and move the initializations up
so that they can be used in sp_get_of_version and sp_get_acpi_version.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/crypto/ccp/sp-platform.c | 53 +++++++++++++++-----------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 71734f254fd1..b75dc7db2d4a 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -33,8 +33,31 @@ struct sp_platform {
 	unsigned int irq_count;
 };
 
-static const struct acpi_device_id sp_acpi_match[];
-static const struct of_device_id sp_of_match[];
+static const struct sp_dev_vdata dev_vdata[] = {
+	{
+		.bar = 0,
+#ifdef CONFIG_CRYPTO_DEV_SP_CCP
+		.ccp_vdata = &ccpv3_platform,
+#endif
+	},
+};
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id sp_acpi_match[] = {
+	{ "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
+#endif
+
+#ifdef CONFIG_OF
+static const struct of_device_id sp_of_match[] = {
+	{ .compatible = "amd,ccp-seattle-v1a",
+	  .data = (const void *)&dev_vdata[0] },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sp_of_match);
+#endif
 
 static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
 {
@@ -201,32 +224,6 @@ static int sp_platform_resume(struct platform_device *pdev)
 }
 #endif
 
-static const struct sp_dev_vdata dev_vdata[] = {
-	{
-		.bar = 0,
-#ifdef CONFIG_CRYPTO_DEV_SP_CCP
-		.ccp_vdata = &ccpv3_platform,
-#endif
-	},
-};
-
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id sp_acpi_match[] = {
-	{ "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
-#endif
-
-#ifdef CONFIG_OF
-static const struct of_device_id sp_of_match[] = {
-	{ .compatible = "amd,ccp-seattle-v1a",
-	  .data = (const void *)&dev_vdata[0] },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, sp_of_match);
-#endif
-
 static struct platform_driver sp_platform_driver = {
 	.driver = {
 		.name = "ccp",
-- 
2.19.0

