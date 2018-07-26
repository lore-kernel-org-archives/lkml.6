Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA578C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAB420862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJUURC4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAB420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbeG0Ale (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:41:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39170 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbeG0Ale (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:41:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id a134-v6so2326185lfe.6;
        Thu, 26 Jul 2018 16:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZzKlBfHITiaIhtCR4V6lsjIteXVyc3M0dFCxH8acLzM=;
        b=rJUURC4hkzW59G8AUeIUnlBuqHcvcQ/fW1kUdWAkyEolNZPSAHHNF+L4+srdRZnFoL
         srUW6yntwqiB2NGJLZXMs1BKV7tpEMPvXNVmRhrkSXAxWib6WjSJoCyVkOELl6UVXHJ2
         OBjJkRV6vbgWggppqdGdUTqUi8EzugqSUGQof5qvLC4D6vsQHmkFHmq4K6Uq2R8GVxsD
         I4cAm2hEMmBMQx4UiuPIXl0lte+yzVBjpPMcn7R5IP8LrE68B4nyfwyScWGXZxphjPGs
         ZD09HGdo/FoTweYTHhYhY/6u0jatxt67EfD+5MZG8G9oyrWstkIROqoIdsLLB0OM6l0C
         3ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZzKlBfHITiaIhtCR4V6lsjIteXVyc3M0dFCxH8acLzM=;
        b=bsaxmQ6Y8zb1FHflWRMUprwWGyuH6yVKk4eX3CIm8R8ppTEyUqgV2HA7E2qPVGFwey
         /txTkX8swD71DAhYHxkZ1R3QaVQIXfYvHt61uWsoC3F5NuEmfZ8NKShKyng26T6wlUDX
         zEf2TZy9UuGe4dnOtxfLgEoRHRaVW4iPGAYr7ZRJ1dLzxGKnQSlGAanVGPCHSQbgCm6p
         w+2zC5+5UKAkqPVjLjRVzG6mHAZZ/TciwCIdtLrkfmrFRjOlXnov783LRe+GJjjuw1NT
         pJsP2vECApq9ALAr1WnEtXht38QNjKcsjsVSCV4Y23dYjZybzY2P6FYpbh3O37wGjMGV
         WZ7g==
X-Gm-Message-State: AOUpUlHPTdI0lLu5X3pjBUB97oxwdx1ZJDwDJRqjqYAnKH+jA8zn18o2
        MIwSZJA9U5FUTKKU5lKMq1E=
X-Google-Smtp-Source: AAOMgpeZ8ThHp5dveQGg7S7v+EtCA82C+70lNknFeTUoQIbF+mooW1gljvR35DN7sxYDiv2telrhfA==
X-Received: by 2002:a19:9646:: with SMTP id y67-v6mr2420505lfd.130.1532647351075;
        Thu, 26 Jul 2018 16:22:31 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q15-v6sm411541ljg.62.2018.07.26.16.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 16:22:30 -0700 (PDT)
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
Subject: [RFC PATCH v1 1/6] driver core: Add option for disabling of backing devices DMA with IOMMU
Date:   Fri, 27 Jul 2018 02:16:19 +0300
Message-Id: <20180726231624.21084-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726231624.21084-1-digetx@gmail.com>
References: <20180726231624.21084-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows device drivers to convey the drivers core that implicit IOMMU
backing for devices DMA shouldn't happen. It is needed for drivers that
manage IOMMU by themselves, like for example it is needed by the NVIDIA
Tegra GPU driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index ad43a97b50c8..f9e3c1d42abd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -244,6 +244,7 @@ enum probe_type {
  * @bus:	The bus which the device of this driver belongs to.
  * @owner:	The module owner.
  * @mod_name:	Used for built-in modules.
+ * @no_implicit_iommu: Disables backing DMA allocations with IOMMU mapping.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
@@ -281,6 +282,7 @@ struct device_driver {
 	struct module		*owner;
 	const char		*mod_name;	/* used for built-in modules */
 
+	bool no_implicit_iommu;		/* disables implicit IOMMU for DMA */
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
 	enum probe_type probe_type;
 
-- 
2.18.0

