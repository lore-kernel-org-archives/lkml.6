Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F6C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6447A20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFZxY7yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6447A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbeG0Alj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:41:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46125 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbeG0Alj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:41:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id l16-v6so2320004lfc.13;
        Thu, 26 Jul 2018 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o9Z7QKLTcb40+ogX2Dsf/MKtwd7NgHqBZYO0RNQo0gA=;
        b=SFZxY7yQsaUzViUage6m1f+FhdaMpooWNFG5n6o7T6+nozHKD7y3nsYTupSY+kjNWz
         UQzpbFg6bVkEyia+4QFXRCsAVJ35rzxUIQ6PadHArq1VOiIFbBxWyG7HUmkkQCty1/cl
         t7xxEt0J2AH7EZHocR1rTH2BOfF6Y1hwUyLX2pXyrSl1VtCBFMxvEUR5BHiG6WP/IdH3
         0bui0wfRKeM5vXH2agZjjVVNpflNMNOFd+39T8upMHBsxGsJJxZlQsjNRHfZ6EAgr8db
         jprwtxcjRrKmarSknFd6xykYKJy96cBoLVJxDrmCQF9sCcY/WpKEllUBOQ5+Ss4dosRl
         KF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o9Z7QKLTcb40+ogX2Dsf/MKtwd7NgHqBZYO0RNQo0gA=;
        b=YSRFSkPOG1tddiE4opZNi0LtLBlR6WQYX/jnWCnLQ866lkgvWl/scwok7QgmQo2bVA
         F3MjVRC2VnYwhdAIVmz8Z7r1gdi3Mt+9MaM9GTva6e+ScV1okPJFGJLObn373l+6GXiD
         /6MeANjBbCzGCYh2HXZZ2WapgxrRvMavvzHj1Xn79loCooTwT5w2CxoE4jxCt3Rayd4H
         SzCy3fy+YyjTG9nzTF2euRlD+FjXdDaKGgHsKuYiJg9Jq2Zdw5exMqIQuj1ynaFeadKA
         OMtZm5Q8bNuxudfqxhhfXFKFNGOjZTZLVzOTNSwrZxSAvyQmSTU1FJoRU2ESsl0wKFN4
         eSjQ==
X-Gm-Message-State: AOUpUlFlPTd50AiaQfKjjrtFvj4Q+h8o0XDe1S/mkFlTR48OTDt4WO+6
        TgjiIFOx/+BtGPuJOZyXwCE=
X-Google-Smtp-Source: AAOMgpdu9glh1S2y4M2AZlthDNe+19L4fyzG3DPMmUo+QfPi4+hJ3wYbwCQ2EgKuE4tKOYoHFiN+6g==
X-Received: by 2002:a19:9fc8:: with SMTP id i191-v6mr2411611lfe.79.1532647355840;
        Thu, 26 Jul 2018 16:22:35 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q15-v6sm411541ljg.62.2018.07.26.16.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 16:22:35 -0700 (PDT)
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
Subject: [RFC PATCH v1 5/6] drm/nouveau: tegra: Universally avoid implicit DMA backing with IOMMU
Date:   Fri, 27 Jul 2018 02:16:23 +0300
Message-Id: <20180726231624.21084-6-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726231624.21084-1-digetx@gmail.com>
References: <20180726231624.21084-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implicit backing DMA with IOMMU breaks Nouveau on Tegra, the current
approach with detaching device from IOMMU that was added in commit
b59fb482b522 ("drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping")
works only for arm32 which has the CONFIG_ARM_DMA_USE_IOMMU, but not for
arm64 which doesn't have that config option. Drivers core now allows to
avoid the implicit backing, that is a universal solution unlike the
current variant with the detaching.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_platform.c b/drivers/gpu/drm/nouveau/nouveau_platform.c
index 039e23548e08..0b57f4f9b638 100644
--- a/drivers/gpu/drm/nouveau/nouveau_platform.c
+++ b/drivers/gpu/drm/nouveau/nouveau_platform.c
@@ -90,6 +90,7 @@ MODULE_DEVICE_TABLE(of, nouveau_platform_match);
 struct platform_driver nouveau_platform_driver = {
 	.driver = {
 		.name = "nouveau",
+		.no_implicit_iommu = true,
 		.of_match_table = of_match_ptr(nouveau_platform_match),
 	},
 	.probe = nouveau_platform_probe,
-- 
2.18.0

