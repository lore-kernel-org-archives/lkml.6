Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114DB21477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPKIQ6OT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114DB21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIXGq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:46:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35249 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeIXGq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:46:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so8313229pfh.2;
        Sun, 23 Sep 2018 17:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YOOMCH2KwkYbAYwpexjwI99bbfGpSnTLhrWo5MkIH4Y=;
        b=qPKIQ6OTTXw8MbDOh30LTWWB9kBOZVaIfkXenTR4doEmpODTnRFkH5AtgqJJdygb0e
         5atSCL7mH9+HtoRbHTMkD+x5kVzi1lrXzkO1W/Oa1k9Rp8kqBROXeVbYtMkHep6a2+CC
         n/c0HiiZgpm0g4W2UPA6fV5AD5jeoz+a5WXsqYv2Kv+nsTGMMldlPrle66+y95919zUw
         spLXvQHjz0ahR9ccnhL9zN840Hw0UcgZbDe0hnhNkn8HMtEZ0rlqui1d62LXE4WBgWYt
         eyQG566r8YgJwcfDI4BIEoBioCcsy4pQdcZA3xMNqfg9hyKgKMPqXMlQT+DNrNHCcKPf
         Cfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOOMCH2KwkYbAYwpexjwI99bbfGpSnTLhrWo5MkIH4Y=;
        b=RD/m4UNhXuiDUtbuRLAiWkGs+8ylYNomqxgDQSsnGxGkpuKiC9WY4cumkTOG8329BZ
         c/rh7ldKTLoS5BGB9ZsvxPjxtvcttuwBqvN0DnGFJMCt138P7Bg3SZuyIj18BqdQuQMe
         Xv2+b71Kjckd2neNUTTckRUDmLaXCLgyn/KUzmFMo1CwnaiLfFsFVgANGG5iYzIBDCRA
         RpL3fSgOFipjWnX5pk7IQAeW6b7oF6KleZfWb1oBK4+M3CI+mKdnRH3bPEj6w1Xfusbb
         9wKR6lmox/n3XpSRZqdnKyUh62P6npZ8BjlsiFPVkyNvYn8zGyz/kVCb/LeJU6Wgcr9y
         e+zA==
X-Gm-Message-State: APzg51Ah04qqZykfwruh4SpM0DzBkqa+KtxIKQamb/PY0G8Gj/GrP6aT
        FrMYWlmovL9TxurvKeKNZnQ=
X-Google-Smtp-Source: ANB0VdaJDoXVZtelMVWUvHRrxQvGHLYeOajLlC224ubYixe55f1FgQOS4sFEbP/uhfcKbfGVDLtxcQ==
X-Received: by 2002:a62:51c6:: with SMTP id f189-v6mr8084215pfb.7.1537750040893;
        Sun, 23 Sep 2018 17:47:20 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:47:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/20] iommu/tegra: gart: Fix NULL pointer dereference
Date:   Mon, 24 Sep 2018 03:41:47 +0300
Message-Id: <20180924004153.8232-15-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL pointer dereference on IOMMU domain destruction that happens
because clients list is being iterated unsafely and its elements are
getting deleted during the iteration.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index e6fe139576c3..1d45b023adea 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -258,9 +258,9 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 	if (gart) {
 		spin_lock(&gart->client_lock);
 		if (!list_empty(&gart->client)) {
-			struct gart_client *c;
+			struct gart_client *c, *tmp;
 
-			list_for_each_entry(c, &gart->client, list)
+			list_for_each_entry_safe(c, tmp, &gart->client, list)
 				__gart_iommu_detach_dev(domain, c->dev);
 		}
 		spin_unlock(&gart->client_lock);
-- 
2.19.0

