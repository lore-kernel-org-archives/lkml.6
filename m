Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB0DC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372F420862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZJevzBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372F420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbeG0Alh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:41:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37326 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbeG0Alh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:41:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so2327266lfb.4;
        Thu, 26 Jul 2018 16:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jpJjsYXIvl23bc0ZxhI6uH2ME068VxWOkU6fnQDiSwM=;
        b=BZJevzBwqvxM8P5rK8hcJmOkDuRLFR9lK9YXf+rnN9kFKbUvZKHEM2uduxVPtBQP9S
         F2h0lTNvdGbjHHR/o8EDPVj/rGMrYCMPK1NH2cdh3BTzzXcBaIEZei4jN/uQyXYqWFHl
         r/9BbuWumRQJchf0ZhM9DQ5oCKqyFYGSEEsFkQvoFSkrFazVPxfLHIHd38J4Qx86gTXY
         AmDLTrdFu8Ztwppcv+8aPxHtPt9tCwgWkdGBRsA79OU4JIK+/HujT5CjRrrmT++Rutzw
         7oZDHKtA0vD9PBxvMwd4D4vVM4P2PcVBKEt69yFsRo8+/mZkUgyHcRbVsDbZwbxXIn6I
         JVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jpJjsYXIvl23bc0ZxhI6uH2ME068VxWOkU6fnQDiSwM=;
        b=W46wov2CrgpdHHowCsxl1ef02HjIJZ4ohx/jeAmGU7uuPmcWDppUIp3lZXRYztfBLN
         RCa1wGLym+QjRVaucNnB0GsskDSKPUMJ3RsyNzCndLS5pPaGZC471w6mlWR2lM7ZwUpE
         Cweghs4FHD38ay6u5AMYHajYXPAVK3uF1D3Q1UkqCCrDvZ1UzSN8wZrmbnT0/66B0LkE
         JhdNHbWxM6HVn+qt+5hiotxccEHQVcDW+hu1ncCWnwo1Slbrz2mtRnXq4NJAdjwnQLJ0
         5hXDAxxdik3xul+AFx0537Y01oS2W7Rlv1tetmGFW7AaHLcs5IwyKh9PdGKgWE8ouk46
         mHsg==
X-Gm-Message-State: AOUpUlFMJooPnqT6+v+SURgEEftaEM6bCanNfddBE82EqjxYg22mMos5
        NHnDxymbpYr7WVcUC8Lcj0k=
X-Google-Smtp-Source: AAOMgpcsBbd+MaQyBLzVEe83DBbkinhMexhJe9u+Bx9P7RrJyyzwBvqtqnGJ2nS4uArkAk5ITFdW+Q==
X-Received: by 2002:a19:a5c5:: with SMTP id o188-v6mr2651924lfe.149.1532647354626;
        Thu, 26 Jul 2018 16:22:34 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q15-v6sm411541ljg.62.2018.07.26.16.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 16:22:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/6] gpu: host1x: Avoid implicit DMA backing with IOMMU
Date:   Fri, 27 Jul 2018 02:16:22 +0300
Message-Id: <20180726231624.21084-5-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726231624.21084-1-digetx@gmail.com>
References: <20180726231624.21084-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host1x driver manages IOMMU by itself, backing DMA with IOMMU by the
drivers core breaks the Host1x driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index afabd33a48d9..0966415d4ccd 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -361,6 +361,7 @@ static int host1x_remove(struct platform_device *pdev)
 static struct platform_driver tegra_host1x_driver = {
 	.driver = {
 		.name = "tegra-host1x",
+		.no_implicit_iommu = true,
 		.of_match_table = host1x_of_match,
 	},
 	.probe = host1x_probe,
-- 
2.18.0

