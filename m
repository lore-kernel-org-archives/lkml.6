Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E446EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB48B2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHG52z0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB48B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbeJEWhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45951 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbeJEWhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id m80-v6so9645156lfi.12;
        Fri, 05 Oct 2018 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YhWFQ6MifqW5rbquI58Ij21Y/GKwiXK722JXem6LK/k=;
        b=oHG52z0dhR7/p5KZ36rP2dZnZsUle7uL5yBktPtBE00MaCeCfhJiepQaOW5Ggv6NuW
         nfMkeZFB33qaj2xq5df9gWcEopuB6ATZMhPsir1DrayK3WFUPDiEvBcfb0fXvyavmNUb
         Pf1oZF8A3D7ndtP67BE7Chm1KAMY1zQe0zjqm1r2i8r6Rrieii82mxrEk/cdbmKKDJbg
         bLs+eYs9JQeRBs2q0b46UgjCmJStloq36xi6Jjj7DWQh0OiHER/XTEL6GtzwRCXNs9t2
         t+S9zIrU1p6WuXKoQW2rZNlMSIv4/G+rqrn2JwpMpcIVDo28WogmOP6LCBEtuve1aSyo
         cJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YhWFQ6MifqW5rbquI58Ij21Y/GKwiXK722JXem6LK/k=;
        b=AmYb+/UrpsSX/URzHsz1A88hENYdybaUVQVwVHGzAq5mvT5MRRev7fEuZB3GYF/8GJ
         zQ35A6SisTrnwXYQu5hrA+aYibi5yTGJAQvAiqcxDXfRoj+Rn0qTYp21Ebsiq4+hGhMX
         vq432IXKMFN2DMKkzaaIqL+zWg3f9rJ12ozGyDMcAUPA/O+m4M8xrdHOyTvJhUbctSaT
         O0fjMk+jHzTVP0XGD9VO1M7AJBVFf6XUznd5DibyQSoB53m/cVJPNyntsz3+43ZDzHoZ
         Cs28gRrGz8N35LGqm9fHubdzyG5QeigxfsCF1jxsLpD2wiFdNPEam1oBnjt5DCvt2rPG
         Sksg==
X-Gm-Message-State: ABuFfohryFnUSxaijl4u6NRO/zYrXgJECrt6ZraU7WAFM8STkl1aZqnQ
        Xg0yiKETQIZC4xKuPg7o6Vc=
X-Google-Smtp-Source: ACcGV636v75KX5zEdOIXmHFJ7qtH30ImzIq3L2nwQpaHYucxETvPcvSj60kZaQTTlrqih+nAH/6IsA==
X-Received: by 2002:a19:df43:: with SMTP id q3-v6mr6755419lfj.53.1538753884439;
        Fri, 05 Oct 2018 08:38:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:38:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 09/11] regulator: core: Decouple regulators on regulator_unregister()
Date:   Fri,  5 Oct 2018 18:36:36 +0300
Message-Id: <20181005153638.1886-10-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulators shall be uncoupled if one of the couples disappear.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ba03bdf3716f..783ec9c74104 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4518,6 +4518,43 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
 	}
 }
 
+static void regulator_remove_coupling(struct regulator_dev *rdev)
+{
+	struct coupling_desc *__c_desc, *c_desc = &rdev->coupling_desc;
+	struct regulator_dev *__c_rdev, *c_rdev;
+	unsigned int __n_coupled, n_coupled;
+	int i, k;
+
+	n_coupled = c_desc->n_coupled;
+
+	for (i = 1; i < n_coupled; i++) {
+		c_rdev = c_desc->coupled_rdevs[i];
+
+		if (!c_rdev)
+			continue;
+
+		regulator_lock(c_rdev);
+
+		__c_desc = &c_rdev->coupling_desc;
+		__n_coupled = __c_desc->n_coupled;
+
+		for (k = 1; k < __n_coupled; k++) {
+			__c_rdev = __c_desc->coupled_rdevs[k];
+
+			if (__c_rdev == rdev) {
+				__c_desc->coupled_rdevs[k] = NULL;
+				__c_desc->n_resolved--;
+				break;
+			}
+		}
+
+		regulator_unlock(c_rdev);
+
+		c_desc->coupled_rdevs[i] = NULL;
+		c_desc->n_resolved--;
+	}
+}
+
 static int regulator_init_coupling(struct regulator_dev *rdev)
 {
 	int n_phandles;
@@ -4776,6 +4813,7 @@ void regulator_unregister(struct regulator_dev *rdev)
 	debugfs_remove_recursive(rdev->debugfs);
 	flush_work(&rdev->disable_work.work);
 	WARN_ON(rdev->open_count);
+	regulator_remove_coupling(rdev);
 	unset_regulator_supplies(rdev);
 	list_del(&rdev->list);
 	regulator_ena_gpio_free(rdev);
-- 
2.19.0

