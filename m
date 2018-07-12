Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875CFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B0A21476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="qYQExqvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B0A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbeGLIQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:16:32 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55858 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeGLIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:16:32 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2C8665C205F;
        Thu, 12 Jul 2018 10:07:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531382865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjCVkabvhyb5Cu6v12SG/n9h/qJC6gc/5us2/GUOqHg=;
        b=qYQExqvumN/HQzVPSEUmZS7zV6bphARX25RokI4LFiw0NF8UJvG6zq5yOWc7sULdBwRGuv
        4EtsGFBasLYV2TP917CpMiYwKNsDwzEvJiY8qRlZUjEjnPRGmwTq5VRkSXtVcyD9OAhKdN
        o0hl4hO8pGR89ztwbnEz1DR5gQbT5Cg=
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: fix indent
Date:   Thu, 12 Jul 2018 10:07:25 +0200
Message-Id: <20180712080725.14250-2-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712080725.14250-1-stefan@agner.ch>
References: <20180712080725.14250-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indent. This also makes disable/enable clock blocks look
alike.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index acacd8481473..aa48f4b2541a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	if (esdhc_is_usdhc(imx_data)) {
 		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
-		host->ioaddr + ESDHC_VENDOR_SPEC);
+			host->ioaddr + ESDHC_VENDOR_SPEC);
 	}
 
 	mdelay(1);
-- 
2.18.0

