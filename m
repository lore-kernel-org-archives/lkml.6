Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41176C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC27520856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWEK9DFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC27520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeIBVxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 17:53:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44732 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeIBVxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 17:53:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so13610650ljq.11;
        Sun, 02 Sep 2018 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xc2wCKuyj/FJOc6OLHesZ0WrSHz3T0jQ5R0pCqI2Q+4=;
        b=jWEK9DFHJnk6IgTlcwKiqo0GHS6eh9ZugUO2DC8m5rAuedXp9wjHMwnBJugAGaaNfp
         jmGJgkUFCwM5nGzXt6lC8YcVUg1wYT07rbVQhUBSur2lDICaUOEp2+XklHl4LSofWJ8X
         sqISjhi1auEHK7qkEO7SzEWUST860bS8Fhw5NBRSH8CxyQ23VjqybhXn5Nax5od10p56
         +wMoXT2fLg/NdnrOZ2ni5HMuGrRJaxf2Da7GgPuBxgPGe0IszFLeL3f+RjptrUL5gy0c
         CjHwMk+I4Ak5hjszmkkqojL8Aoqdq/uT24akoi/Za+KAJOIyXWSyls/t5LFej5Reyzyq
         IkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xc2wCKuyj/FJOc6OLHesZ0WrSHz3T0jQ5R0pCqI2Q+4=;
        b=RLBcnMj2j36kyuhLdla2cgP8JGYA2qPAsrotfTbDQl1w7Yh4SzPBd/UBzekMgYMJWu
         /afkc1x2duLVnT/Ruk4dfth4sFzJ7v8Zn0jZdXmWfaYwg5UMk0l924BnlqX8LtQaEKCr
         tWk2cbtQmm4V5jwjFY8+6rYLfqkhqgGSxvJHUuFnA3copE9uK2vkZmkTwdUupO+XydQf
         t50hQHApNZtwj4VpVSGFYTqdUntLGRs3CF6nqij7PUGqdkORCRgzvjzmFJFtiTkp/HtX
         Iz9bTnQGU1LVtdLb5hA5kMR9FzXMFuXwQhssuQYREJpeU0DIBpE3Y9zaNHfs1qJ7nCES
         4KFQ==
X-Gm-Message-State: APzg51BmeafSm+OB/DVl3kcWsoXq1Uz5RV4CaGu1aNuLxfeiMcEgTnzJ
        vCJAXXbILbTprngL0xlV7rQ=
X-Google-Smtp-Source: ANB0VdYw62EOQLN9p4pKDGQtdJnW74pJfOg2/gcF8qJJLSZENR+l5Vg6Jkgc1sBTrRprZ+reBzPcLA==
X-Received: by 2002:a2e:8513:: with SMTP id j19-v6mr1502141lji.10.1535909832910;
        Sun, 02 Sep 2018 10:37:12 -0700 (PDT)
Received: from localhost.localdomain (213-238-244-10.customers.ownit.se. [213.238.244.10])
        by smtp.gmail.com with ESMTPSA id t2-v6sm2964546ljj.46.2018.09.02.10.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 10:37:11 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] usb: chipidea: imx: do not use preprocessor conditionals for PM
Date:   Sun,  2 Sep 2018 19:37:04 +0200
Message-Id: <20180902173704.5562-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preprocessor conditionals for CONFIG_PM and CONFIG_PM_SLEEP is
not necessary since SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS does
that internally.

It is also the preferred way according to our coding style guidelines.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 555d398fbfa7..09b37c0d075d 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -364,8 +364,7 @@ static void ci_hdrc_imx_shutdown(struct platform_device *pdev)
 	ci_hdrc_imx_remove(pdev);
 }
 
-#ifdef CONFIG_PM
-static int imx_controller_suspend(struct device *dev)
+static int __maybe_unused imx_controller_suspend(struct device *dev)
 {
 	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
 
@@ -377,7 +376,7 @@ static int imx_controller_suspend(struct device *dev)
 	return 0;
 }
 
-static int imx_controller_resume(struct device *dev)
+static int __maybe_unused imx_controller_resume(struct device *dev)
 {
 	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
 	int ret = 0;
@@ -408,8 +407,7 @@ static int imx_controller_resume(struct device *dev)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ci_hdrc_imx_suspend(struct device *dev)
+static int __maybe_unused ci_hdrc_imx_suspend(struct device *dev)
 {
 	int ret;
 
@@ -431,7 +429,7 @@ static int ci_hdrc_imx_suspend(struct device *dev)
 	return imx_controller_suspend(dev);
 }
 
-static int ci_hdrc_imx_resume(struct device *dev)
+static int __maybe_unused ci_hdrc_imx_resume(struct device *dev)
 {
 	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
 	int ret;
@@ -445,9 +443,8 @@ static int ci_hdrc_imx_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static int ci_hdrc_imx_runtime_suspend(struct device *dev)
+static int __maybe_unused ci_hdrc_imx_runtime_suspend(struct device *dev)
 {
 	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
 	int ret;
@@ -466,13 +463,11 @@ static int ci_hdrc_imx_runtime_suspend(struct device *dev)
 	return imx_controller_suspend(dev);
 }
 
-static int ci_hdrc_imx_runtime_resume(struct device *dev)
+static int __maybe_unused ci_hdrc_imx_runtime_resume(struct device *dev)
 {
 	return imx_controller_resume(dev);
 }
 
-#endif /* CONFIG_PM */
-
 static const struct dev_pm_ops ci_hdrc_imx_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ci_hdrc_imx_suspend, ci_hdrc_imx_resume)
 	SET_RUNTIME_PM_OPS(ci_hdrc_imx_runtime_suspend,
-- 
2.18.0

