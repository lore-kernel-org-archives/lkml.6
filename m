Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC80ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8FA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cvghgBR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8FA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbeGXAbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:31:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37148 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbeGXAbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:31:50 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6NNS0AN061577;
        Mon, 23 Jul 2018 18:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532388480;
        bh=q4Vz1U5TRe68UgiMdDBGhW93sc9VoVRgM8CdQziMxnw=;
        h=From:To:CC:Subject:Date;
        b=cvghgBR+698M7PLG9HT20u7P2AaSUjoX55N6qahdGBAWSZRSJ5uDaxLylCII+oz2/
         KG13VmLQx+OoFi2+8IPVKwPwufTysYkdFTz9EMS8I4APzf88tah0PVPPHTNPityXr4
         VQIsIo2eYxPRRAeW6Jd6oaFewVThZIY5x1kdNxk0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6NNS0KL026791;
        Mon, 23 Jul 2018 18:28:00 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 23
 Jul 2018 18:27:59 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 23 Jul 2018 18:27:59 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6NNRx17032294;
        Mon, 23 Jul 2018 18:27:59 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w6NNRxx18421;
        Mon, 23 Jul 2018 18:27:59 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH] remoteproc/davinci: Mark error recovery as disabled
Date:   Mon, 23 Jul 2018 18:27:57 -0500
Message-ID: <20180723232757.9147-1-s-anna@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Davinci remoteproc driver does not support error recovery at
present, so mark the corresponding remoteproc flag appropriately
so that the debugfs flag shows the value as 'disabled' by default.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index b668e32996e2..53160d5ed543 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -284,6 +284,9 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 		goto free_mem;
 	}
 
+	/* error recovery is not supported at present */
+	rproc->recovery_disabled = true;
+
 	drproc = rproc->priv;
 	drproc->rproc = rproc;
 	drproc->dsp_clk = dsp_clk;
-- 
2.18.0

