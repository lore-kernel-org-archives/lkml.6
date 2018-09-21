Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D253ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AC1206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmUlyyQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AC1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390410AbeIUQOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:14:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36879 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389264AbeIUQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:14:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id n11-v6so2656559wmc.2;
        Fri, 21 Sep 2018 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXDglkcuPDUbyoePYORwBZvkypgLOk81MMzqBdKmW/s=;
        b=VmUlyyQr30Bb/FaqfVKJsQlHGPGjTGfkG+HU4H7SUB3z2kNuuQM2snYubuzZFI/7iq
         vq+wSwLehv6H7+3ovlIOCYROSAH4KLKyyXfqpTsBdA/TQ7aQaFmZqcFv4w3f9QKMOuUK
         QzVZF78T8DprR5yKn53eMpWvrB4GUPHAkLUfXKsbkLSY8moi1BSrpbQZFIOYO8rSCa0p
         a9Y34NQRS8v5ZY2nHwQNSBH1b9GfqTiLfoG+V65Q0UhtkpPdFC6ks6tcoKWsl6jImaY7
         ht1/Jjqw+7KOinvzCvQIQGmkzieo0x9751ZxUmHcFr/VjfrO1PxCNUw8g+McYqVIqaa+
         iCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXDglkcuPDUbyoePYORwBZvkypgLOk81MMzqBdKmW/s=;
        b=Zxsg3zTW9fMI+O3fx/6b01gzorarEY/NDicQlvPgDvMJq2AKTNnyr4Gmtn1crhF1pI
         iggmn3oyRDXF6VVROkwMR2aP54SUPDFpdUlm+KMtZFzrOh44Xi6vPVqeHHfxb1ddm3JH
         NKzAPtY5IUS0tzzX2N0YC1SbvSAf1/ImoxyD7qUfE6RPHjv80qLYqPEtg4omqPSyhfWx
         lRbNevnX2LVzh2bqob2YRI+Q5MWnhwFORXxi1TIk9VpTTqCLjtheRG8iUzQaErn7BnOB
         KXjCZ0agayAoGoItCSC0m1yv3UnJVhBjX6P00+9dPTs8IxLQ6jm37Ve8yjQuC/I10zP6
         hiMA==
X-Gm-Message-State: APzg51AXkuvAw2716PR7MlxPAC2EEbV7fL0S9Ve5DHcmflytoqbMLRnI
        dAN3OvRWUVXQw9BUJuIRihD2rd5N
X-Google-Smtp-Source: ANB0VdaumczRe8fKODXGLICAr3wVqz8H8QmJ1OppqbQfy9Qj57RGGjPnV3hJUqBgE04xFJW3s49Scg==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12-v6mr6339941wmf.57.1537525556144;
        Fri, 21 Sep 2018 03:25:56 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id j44-v6sm45674947wre.40.2018.09.21.03.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:25:55 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] soc/tegra: pmc: Add initial Tegra194 wake events
Date:   Fri, 21 Sep 2018 12:25:42 +0200
Message-Id: <20180921102546.12745-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921102546.12745-1-thierry.reding@gmail.com>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Tegra194 supports 96 wake events in total. Many of them are never used,
so only the most common ones (RTC alarm and power key) are currently
defined.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 42e7deb6de74..efe990985fe6 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -54,6 +54,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
 #include <dt-bindings/gpio/tegra186-gpio.h>
+#include <dt-bindings/gpio/tegra194-gpio.h>
 
 #define PMC_CNTRL			0x0
 #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
@@ -2426,6 +2427,11 @@ static const struct tegra_io_pad_soc tegra194_io_pads[] = {
 	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = UINT_MAX },
 };
 
+static const struct tegra_wake_event tegra194_wake_events[] = {
+	TEGRA_WAKE_GPIO("power", 29, 1, TEGRA194_AON_GPIO(EE, 4)),
+	TEGRA_WAKE_IRQ("rtc", 73, 10),
+};
+
 static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.num_powergates = 0,
 	.powergates = NULL,
@@ -2438,6 +2444,8 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.regs = &tegra186_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+	.num_wake_events = ARRAY_SIZE(tegra194_wake_events),
+	.wake_events = tegra194_wake_events,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.19.0

