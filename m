Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B9C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653842080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxUrRZkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653842080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeLLUyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:54:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42724 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeLLUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:54:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so8882805pga.9;
        Wed, 12 Dec 2018 12:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8e+kFe+qiuioT/9U25HTRBMffLJQU7a5rkqBRxg8ljQ=;
        b=JxUrRZkIrrU1QX110oMxC2kJK/kYOjm5ceFveGmV9z1+1CX83fePZisrn8VC2Ydfzu
         ee2MfCOGGlLPu7P8IYg0AsO4GwcGwQj9R4pEgxI8fEuM8uiZhnSa0p7YrHgRcg9UTSYi
         PmZP0dNNWbbPSi9bPeh4KvkGgb26CrUatGJEf6dZQbpMt21SLd3dWAJ5EDlEeUUXliPN
         c4GWVLXvsMQgytPDztuaJF85KfCGfd++eCCmbbfJ6gfakvKnXX1gn9ikdMUnDWzgeU7R
         lJCXfu53S9wsgLePWjHR0FJFf0KQ0H8npi8ucQTo9sOGhS3Cpl+vFzPtftWGqjxG7VEf
         jDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8e+kFe+qiuioT/9U25HTRBMffLJQU7a5rkqBRxg8ljQ=;
        b=tqsbYdevTaLkAU2ftnTeQ8ECZ/5S5UPcB5fUJ/RwRt25bfLKHaigYjCIWLDeE/f+8e
         Am2KgY2GZ9IpsmWHHzUNQRKupan6XSc6od8oM5dz1hy89u+UvxdAMICfmKXo9FQStIR9
         JLSo2rqEhBWRsOniKq4EJYsYZvzf/ycdJf39ABaZE84SKeLD0hiAvgpiZTaUY9eGuxQ0
         UY8Sz223XYWPR1/zN2Tlldk+mrWNUxCn5pOoJlzwMGsTzcLUrqojxgosTRGuRbHNrXTe
         /O1mR6skZ2vQDCrekY3i0LGVIDto34lvRQW7awdWsSWfJCRjNL5luEms6TeV7WTnulS2
         5RvQ==
X-Gm-Message-State: AA+aEWbqZSwFsJN6GZRqCttapmmERsaeDeUh1alQlAv7VmJvtJyxLyDe
        9TC+dyjo6PI8dMdopIEnITLmdMNA
X-Google-Smtp-Source: AFSGD/VGH/Jk8y7pfzFxTUjFqI5b3dBQaPW2eujRhf5xqa4XraPOaJtRyalXiK+3ymnQ015fQBE6HA==
X-Received: by 2002:a63:64c:: with SMTP id 73mr19414097pgg.373.1544648050705;
        Wed, 12 Dec 2018 12:54:10 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:54:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 21/24] iommu/tegra: gart: Prepend error/debug messages with "gart:"
Date:   Wed, 12 Dec 2018 23:39:04 +0300
Message-Id: <20181212203907.23461-22-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART became a part of Memory Controller, hence now the drivers device
is Memory Controller and not GART. As a result all printed messages are
prepended with the "tegra-mc 7000f000.memory-controller:", so let's
prepend GART's messages with "gart:" in order to differentiate them
from the MC.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 2e0e6aff8f70..a3ce6918577d 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -19,6 +19,8 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#define dev_fmt(fmt)	"gart: " fmt
+
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
-- 
2.20.0

