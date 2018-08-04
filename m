Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3226C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DE3217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZWtgdzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DE3217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeHDQgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39152 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeHDQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so3138601edi.6;
        Sat, 04 Aug 2018 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QwzNCaTcKwdo0mw7n9B9D4sysi6OHDqWMK7azzcgAk=;
        b=vZWtgdzSLtPtdNk0F/1T5CF18+rYXtnwPFjobldWMI4PxwzMx+Ffy7SkvF7Lc8kFQo
         eD68Qq/amCvTMRkrBmEG0+oMlf9+8A1qf7PBK+LpexfqrRVpovJbQFBw7b2XbggECb9Z
         2DMJqYXd37crL4S3Azf6bvLAEOQUCs6baSxsSz1dZw4BI0dBIjH1W1GVzszvk5OpzcV6
         Mp7d9iSRfhVehuWEcTqBihUqax2uLnaFsEJ0bUCISJfhHGTc7b5NS/Qfzx2sYWv2rlry
         GTh81Cb9m2lydTAkcOzg/o9H1m3VHsQ0fqm9B/HiRPpz3+9ZnTzX5adAJldhIHcKi170
         h+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/QwzNCaTcKwdo0mw7n9B9D4sysi6OHDqWMK7azzcgAk=;
        b=rMci3DyrN0tc689WV1WMhxZhi+w72bn9EoQI6G7noI6HWjrKASNe2a/IxYKuSubXBl
         N18vOm69wW4QR1/s2pKpEJAgJgjuxb4T+gtPxxiedFwu8icJbmqPEYYIBCcNNpIaLEKs
         r7sE/S0oQVueF0B6BIj+xQK1LM2HNAJ/9XIOHJD71opgiFFXUxnoGYkLDgKmjeegCREN
         WoKT8vBgCXGGuZgpl8seawDHus6DaWySnChCtRoKIha9EnvsZz+Ofh+clvFHjPl0wNgb
         4WRMAoX4DfweSOmBdC5PjhKA47BG2JyV0BtegHfm5MdUc8B209CMiCWPmVHbD/fChvOy
         q4Hg==
X-Gm-Message-State: AOUpUlHXoVOaRBpeVOiStICrckyZ/KvZr4+zbVuH8D/Jv+R3qMCcMmGe
        fiY26uRQ8p467A/QdXwcwqc=
X-Google-Smtp-Source: AAOMgpdWJU3aN99pTqfZ3QQTK8cXebYFWBWuD0z8WnCF6Td7EFWEKzbnfN5ADd9JQYgm0bwiOHYoJg==
X-Received: by 2002:aa7:d4c1:: with SMTP id t1-v6mr11364322edr.121.1533393328634;
        Sat, 04 Aug 2018 07:35:28 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id y20-v6sm589379edq.55.2018.08.04.07.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] memory: tegra: Provide facility for integration with the GART driver
Date:   Sat,  4 Aug 2018 17:29:56 +0300
Message-Id: <20180804143003.15817-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to report clients name and access direction on GART's page fault,
MC driver need to access GART registers. Add facility that provides access
to the GART.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 26 +++++++++++++++++++++++---
 include/soc/tegra/mc.h    | 13 +++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index e56862495f36..4940d72b5263 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -72,6 +72,8 @@ static const struct of_device_id tegra_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
 
+static struct tegra_mc_gart_handle *gart_handle;
+
 static int terga_mc_block_dma_common(struct tegra_mc *mc,
 				     const struct tegra_mc_reset *rst)
 {
@@ -543,6 +545,11 @@ static irqreturn_t tegra_mc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+void tegra_mc_register_gart(struct tegra_mc_gart_handle *handle)
+{
+	WRITE_ONCE(gart_handle, handle);
+}
+
 static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 {
 	struct tegra_mc *mc = data;
@@ -565,6 +572,7 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 		switch (BIT(bit)) {
 		case MC_INT_DECERR_EMEM:
 			reg = MC_DECERR_EMEM_OTHERS_STATUS;
+			addr = mc_readl(mc, reg + sizeof(u32));
 			value = mc_readl(mc, reg);
 
 			id = value & mc->soc->client_id_mask;
@@ -575,11 +583,24 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 			break;
 
 		case MC_INT_INVALID_GART_PAGE:
-			dev_err_ratelimited(mc->dev, "%s\n", error);
-			continue;
+			if (gart_handle == NULL) {
+				dev_err_ratelimited(mc->dev, "%s\n", error);
+				continue;
+			}
+
+			addr = gart_handle->error_addr(gart_handle);
+			value = gart_handle->error_req(gart_handle);
+
+			id = (value >> 1) & mc->soc->client_id_mask;
+			desc = error_names[2];
+
+			if (value & BIT(0))
+				direction = "write";
+			break;
 
 		case MC_INT_SECURITY_VIOLATION:
 			reg = MC_SECURITY_VIOLATION_STATUS;
+			addr = mc_readl(mc, reg + sizeof(u32));
 			value = mc_readl(mc, reg);
 
 			id = value & mc->soc->client_id_mask;
@@ -596,7 +617,6 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 		}
 
 		client = mc->soc->clients[id].name;
-		addr = mc_readl(mc, reg + sizeof(u32));
 
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s)\n",
 				    client, secure, direction, &addr, error,
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index b43f37fea096..5bf72eb4dd51 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -162,4 +162,17 @@ struct tegra_mc {
 void tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
 unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
 
+struct tegra_mc_gart_handle {
+	u32 (*error_addr)(struct tegra_mc_gart_handle *handle);
+	u32 (*error_req)(struct tegra_mc_gart_handle *handle);
+};
+
+#ifdef CONFIG_TEGRA_MC
+void tegra_mc_register_gart(struct tegra_mc_gart_handle *handle);
+#else
+static inline void tegra_mc_register_gart(struct tegra_mc_gart_handle *handle)
+{
+}
+#endif
+
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.18.0

