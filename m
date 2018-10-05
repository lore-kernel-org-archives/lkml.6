Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC8AC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824DF213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beRsK5HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824DF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeJEWhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37215 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbeJEWhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id a82-v6so9672661lfa.4;
        Fri, 05 Oct 2018 08:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZHpftr3JSRuEiiI9LoXz1EWRn5YkY8aK0AfN/Lg3qU=;
        b=beRsK5HLfk7ef+GH66rRGsLw0jY6BoicGoJvVLy61Ccvk2ZsAn98F1m/+nhD3Yztjc
         J1x85KKZIiZMoHxRhSFcYL6KuNE3MqbyJ8o5VuOvBiLuNTA/h0bg9wL5rBDKnz+6HAbC
         PyOsmqGlTvzywQ5LZoz04RblKyBG2fdid59MHl3P3jxjg/I+aDxVh5MilqwQdhpZUBZ0
         GcZyL2hnDr3WfT+wGHTkujvr7G6LzXyHJPhpjZlUaqov2lVUJeDQvFFQPNOr0vNKkc0q
         zf67CpKc/xAJuz4brxAuYU7ZTW8ihAaaG+J+DxbvwiztWYiYKgEuoqP4rULNdRNb8hrQ
         8zHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZHpftr3JSRuEiiI9LoXz1EWRn5YkY8aK0AfN/Lg3qU=;
        b=F86sX6V4hrcbC7fXKfDQI/jLopzEedxvVp6RQiwfNyIhxM+9fk4RYxnJGCy7fUt0eM
         4GCAxcnMP+e701Ki/45NKz30zqJ5RFm/z4MTfxBdhdbHFnmiR31dyDZ/SBDBTfCDn0S1
         4OsQbVUhkhbaJ17L9sT8ipkf+C9pyKgc/FEAH7Y8XCq355/ANn9ChkRE6eUvkfe0HH7D
         6K+3hQGDJA/JVEP6RrOxAJ0ltkCF4U0JCLV1d6RV2txmSJ15ruF6G7RTO8zCBsoIrNsF
         w9jSHw64oyjALn+4t9qMvcER0EgkjiXvG2sZQ6qmVC1WeyFNXJJ4S0OPwyYjnDz7oxiT
         G74g==
X-Gm-Message-State: ABuFfogYR+vz2JZP5WfEypdn03bqlCSvLN+WWvJ0+bnxRCQpGlvVFWKX
        c58hZi/9uvxU0YT/oKXvxAM=
X-Google-Smtp-Source: ACcGV62/aQ0mOeWHjKv3Vc+cgbZ8RvPlRMWhzEY4FL5C55MZSawrxPO3uU3eS8IIjCILVqTHigmOFg==
X-Received: by 2002:ac2:4299:: with SMTP id m25-v6mr6873095lfh.115.1538753886533;
        Fri, 05 Oct 2018 08:38:06 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:38:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 11/11] regulator: core: Properly handle case where supply is the couple
Date:   Fri,  5 Oct 2018 18:36:38 +0300
Message-Id: <20181005153638.1886-12-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether supply regulator is the couple to avoid infinite recursion
during of locking.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a3448636f334..46e816cb80b5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -233,6 +233,21 @@ static void regulator_unlock(struct regulator_dev *rdev)
 	mutex_unlock(&regulator_nesting_mutex);
 }
 
+static bool regulator_supply_is_couple(struct regulator_dev *rdev)
+{
+	struct regulator_dev *c_rdev;
+	int i;
+
+	for (i = 1; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
+
+		if (rdev->supply->rdev == c_rdev)
+			return true;
+	}
+
+	return false;
+}
+
 static void regulator_unlock_recursive(struct regulator_dev *rdev,
 				       unsigned int n_coupled)
 {
@@ -245,7 +260,7 @@ static void regulator_unlock_recursive(struct regulator_dev *rdev,
 		if (!c_rdev)
 			continue;
 
-		if (c_rdev->supply)
+		if (c_rdev->supply && !regulator_supply_is_couple(c_rdev))
 			regulator_unlock_recursive(
 					c_rdev->supply->rdev,
 					c_rdev->coupling_desc.n_coupled);
@@ -283,7 +298,7 @@ static int regulator_lock_recursive(struct regulator_dev *rdev,
 			*old_contended_rdev = NULL;
 		}
 
-		if (c_rdev->supply) {
+		if (c_rdev->supply && !regulator_supply_is_couple(c_rdev)) {
 			err = regulator_lock_recursive(c_rdev->supply->rdev,
 						       new_contended_rdev,
 						       old_contended_rdev,
-- 
2.19.0

