Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA9C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C1E213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZGSZ75l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C1E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeJEWhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43152 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbeJEWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id r8-v6so11967404ljc.10;
        Fri, 05 Oct 2018 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MX5kdyZdQhku6iZxytVgwR1XNHtQY92eJ2ce4w79WA=;
        b=UZGSZ75liUNB+Djc4oaGJ5flzeHbrvtqV4KFpXRdMiy4uSVRN5e3bOYsrbUTYi6LdQ
         Q5rufLg3DnyCWL0XhCZCkhp/sInJf8qzWVy6Ot/u7mGNo90Hma4kJViDfeST/LsxiLIu
         TL3nLysh/5VwbN7lTwgk9ARI+CYvefmZxYJhrY2M0H4yQhuFRJtf6zVlntb+DOL/w34U
         gnRQ7wY5tJSuR1cK8i7DHOHg2vqT3rw0d6HKMYtao90NIZrUJvIFdayWaHshZpl5t7RU
         a0AHJbCGvXj966Oqm/sGc4YEP2erIMIhlRl4oaOBwpKhRbP/svNGk9RpsnIs3k5PjMnA
         TvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MX5kdyZdQhku6iZxytVgwR1XNHtQY92eJ2ce4w79WA=;
        b=ZX/QJwAwE78Z/saT7mHpILJt0epFrJFDg2R4joVTISF8nw/igGWkYnLn0qmcKqRj9A
         BZpX3yD+bfrh0b78AkGtIgH7FZmNTdk9P9g+SAIF4jp+XuV2WhNg302CIroYK+yEr6tD
         TIckw7tS4CbGaAxm6v9FfQCUOYFY6KiCZAvVPx3en/fcHCjLgAfX/1NJLq2HaK5VSOfU
         XzmrMqTBqIbbTJ+EZIczY50kVQmHbPXwWx6NBcF8EuT9taa5fy6rceuVmXWP/MRZTMo3
         7RiDEek8VIukojpodXHGdA29jy1iBcbL231uuTsZvcQqZNRuSzERl5/jC0wkAE8/Wc8U
         dwKg==
X-Gm-Message-State: ABuFfojLfmO8TfzXxrA16Vkf/pqOmrgjOhdC8ovM9syHQdMszzr7d4EC
        b3IKgTA/L2Vt90g8mSZhKus=
X-Google-Smtp-Source: ACcGV60erpHzvkfdVBlfA2CPXO7xQcJZzk1+GfVXag0/QPiQ/5XuudPqvEawVp9FD4wloQ/m5JrugA==
X-Received: by 2002:a2e:9d7:: with SMTP id 206-v6mr8113774ljj.127.1538753878000;
        Fri, 05 Oct 2018 08:37:58 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:37:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 04/11] regulator: core: Don't allow to get regulator until all couples resolved
Date:   Fri,  5 Oct 2018 18:36:31 +0300
Message-Id: <20181005153638.1886-5-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow to get regulator until all of its couples resolved because
consumer will get EPERM and coupling shall be transparent for the drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 925df9e6f1e3..089e8ad8ef57 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1747,6 +1747,16 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		return regulator;
 	}
 
+	mutex_lock(&regulator_list_mutex);
+	ret = (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled);
+	mutex_unlock(&regulator_list_mutex);
+
+	if (ret != 0) {
+		regulator = ERR_PTR(-EPROBE_DEFER);
+		put_device(&rdev->dev);
+		return regulator;
+	}
+
 	ret = regulator_resolve_supply(rdev);
 	if (ret < 0) {
 		regulator = ERR_PTR(ret);
-- 
2.19.0

