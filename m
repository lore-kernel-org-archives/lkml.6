Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FA1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A4920661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHVd1liL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A4920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeLIUcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:32:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41988 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeLIUbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so6499377lfh.9;
        Sun, 09 Dec 2018 12:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ur6yZmpOECfjIx1ZyKaCDp3sDOh8eXxt4l9d1E6ThK4=;
        b=rHVd1liLqJeME2WJMppE2AywmTMX+DTS4mXEujIOjMyXy9mkw9hAdYFa3B79ml9v5V
         pw1CKjb0ZW6lvxO+5WGLI/xgoUaV71oMx/rbgsLJbA58U9Av0oNdAW1bwYwsO+FURgSe
         xKo2/2KhbHBKNnjeYailaQ9jzp/rNFfs4unEyGgHFlJBVd06/+nK7dYcR/LUtozHy0pt
         6Z7b4cWb8ckPell9BsUmEp8rttBnYYksPZj/2oTX7z2aIal/oAS7NSv5KoT0giaDjZqw
         XgBWw8Cp6yg61QS8GnWqIWSwNxY3EbtuLKY8AJyhfvcUwQC7UJWvYWnLk2H7SDbcDYue
         ebUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur6yZmpOECfjIx1ZyKaCDp3sDOh8eXxt4l9d1E6ThK4=;
        b=hirSv9SKeGw8o46NZJ/HWVKA4lV4talrwcuTezAlFCFE2wa61S/TKzwhsLBcXFyJ9Y
         V/um2MAsHbwE4urCPQhaxT5To6QdFpxMVjFNsMq2jge3+vuFh1C99OrUFR16QBYYkVN0
         vhO97N9ey7XdH29NsSmtIQbR2S6YnpB0rqYr5anQM8dc3mfceT8Kg2nT4lYqZZYzGCo6
         YnajByfE6S8o0aU1Ux3Vti6MwsaUakyR11zTJYnp5CB02bmEfq04E3J1mvkYbRJ7LjWT
         /Fumbg0wbbgEiOuG1X1UfNdJ9V75Cx9SkAwM0GGzAjmxZ+OYaNsphIslU3U3Wf9dqKxu
         EuZA==
X-Gm-Message-State: AA+aEWYWbxBBKw4okBIvblGrqsR1azwmNnmOLFxdSQx4PYZVaaOYwAjY
        nc7H1WS+uaa6zJEhLBMIcGk=
X-Google-Smtp-Source: AFSGD/VmgMfOckelExF87Bh3hGwTXAhXCERfDAybAITab4vHumHk/GfT5AxfPdLyWcFXAm3rAnIRoQ==
X-Received: by 2002:a19:690d:: with SMTP id e13mr5273429lfc.84.1544387475036;
        Sun, 09 Dec 2018 12:31:15 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:14 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 15/21] iommu/tegra: gart: Fix NULL pointer dereference
Date:   Sun,  9 Dec 2018 23:29:44 +0300
Message-Id: <20181209202950.31486-16-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
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
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index d4a642c636f1..bb5303b06845 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -260,9 +260,9 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
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
2.19.1

