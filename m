Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F097FC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D6320665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=astier-eu.20150623.gappssmtp.com header.i=@astier-eu.20150623.gappssmtp.com header.b="SI+biLT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D6320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeJWSab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:30:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37398 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbeJWSaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:30:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id x19-v6so1124643wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=astier-eu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2lGu63PRc1IiqaG5JjRbZANs5k88cp36wl81f1JLXWE=;
        b=SI+biLT6x8fnzl8nEcGcGde6OlmtnkUzg8dvnvVksAzdfV3opYNiOD5/9hthmqXyyY
         G+EJ0mb9WdLN2fK9RMvoPODktJoMj7CnvjicmfLWzm9wlp/2r4QTGc//4TMtrbkUuULO
         pJslCXCzFO1nQO0ghNBRRU6nrKOOXfXUHy64Dp23ZadLdvHqEZWgr61R6eCJsmxIepWF
         b6Pyjr5+U+vykepG/Tuz83Ar+6IKtiVbgmgOb8ChloXkjK9bzSHiqm884f8fBHhQvfU/
         pElvC271Rrz99X/O7mJlB2XzZ499S9jiZ1Rrfnrx//q84ks7coJiS24xSrHITaCw/xeM
         E7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2lGu63PRc1IiqaG5JjRbZANs5k88cp36wl81f1JLXWE=;
        b=PHVdN25Hl48qfmz48zvtegAmusmOIKCBxkkO00JDY4oGZRQFZf+v1ID0nekniE/LG6
         A2yNYCr6MERJ3b/0/V2hOBFKwpUL/0W6dPusowrwCkGrOq8YF7R9Jjd/gQ/FPwOQvWYK
         W3YOQ4Y6vGF519XCerSAreqrMKMfTPE9swa5vqqoJM9WVwwOkzdwoYYAhx1mD4u/b8Ui
         ysGxOCjjVOZPdSrUIR+laUMIrBNEYOfUFatlXH1smpnk3JMFp7p0vIXJCWF8phFJM8vb
         /u7W+IlU4KOMVmTJn2X3BA/fvmHZuMQhGuCtOi43ub3InPT/X0ypckdsrH7/g94+Hdo3
         H3eg==
X-Gm-Message-State: AGRZ1gJ6TcFYH/ix+njks5DPNZqYRjMxYFRopwrP8E2U2AG5iU53W2rP
        VBhzhar4xm9WThThuLPvIzfO+Q==
X-Google-Smtp-Source: ACcGV6390eJA+hhle7tonXD7EiuB+vB5K7iHR/+6t2Q6ip4HUdvFYnjDgiiuf2wJwnJe2Zyrno+fqw==
X-Received: by 2002:a1c:f518:: with SMTP id t24-v6mr1840374wmh.82.1540289264902;
        Tue, 23 Oct 2018 03:07:44 -0700 (PDT)
Received: from jaya.substantiel.local ([92.103.140.194])
        by smtp.gmail.com with ESMTPSA id i13-v6sm910930wrn.62.2018.10.23.03.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:07:44 -0700 (PDT)
From:   Anisse Astier <anisse@astier.eu>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Anisse Astier <anisse@astier.eu>
Subject: [PATCH v2 3/3] mmc: sdhci-pci: only install voltage switch method when useful
Date:   Tue, 23 Oct 2018 12:07:29 +0200
Message-Id: <20181023100729.28864-4-anisse@astier.eu>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181023100729.28864-1-anisse@astier.eu>
References: <20181023100729.28864-1-anisse@astier.eu>
In-Reply-To: <20181022134026.GB18413@jaya>
References: <20181022134026.GB18413@jaya>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there's no ACPI DSM for voltage switch, it will just cause a lot of
debug info down the line, we only need one at startup.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/mmc/host/sdhci-pci-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index f2c1fb339d66..95fdbb883c7e 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -723,6 +723,7 @@ static const struct dmi_system_id board_no_1_8v[] = {
 static void byt_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
+	struct intel_host *intel_host = sdhci_pci_priv(slot);
 
 	byt_read_dsm(slot);
 
@@ -733,6 +734,16 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
 				mmc_hostname(slot->host->mmc));
 		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 	}
+	/* Check if we have the appropriate voltage switch DSM methods */
+	if (!(intel_host->dsm_fns & (1 << INTEL_DSM_V18_SWITCH)) &&
+	    !(intel_host->dsm_fns & (1 << INTEL_DSM_V33_SWITCH))) {
+		/* No voltage switching supported at all, there's no
+		 * point in installing the callback: return.
+		 */
+		pr_debug("%s: No voltage switching ACPI DSM helper\n",
+				mmc_hostname(slot->host->mmc));
+		return;
+	}
 	ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
 }
 
-- 
2.17.2

