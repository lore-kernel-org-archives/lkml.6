Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE26AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876192086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVXao5jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876192086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeIJLQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:16:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43095 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:16:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so9894837pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JF0O4zn/LEpQ/Of9oMm7Pjnzg7UngdrXOP4yvvJEbCU=;
        b=dVXao5jdrcbYa/pAvRMpR9vVDp8yWciCujeAPE1yKGh8aMh1fWJTTxhxxP18vY74jy
         /KptFiua34FHKvaO/V8mYUneU8xJQgkdpEESdxpGJH3QOAQ0n4sAAPKRFfHsxvqIIz+6
         x8MizVHElTK4CA3j1HQ5uvWkxFWkJoyHHyTc30uaZGn0ptLFkWLu9QJnsBuFhXHxcH+e
         X55UEUgs+ucx3VB2QlOj02Miz2uycvnG6me8E0zKvgiReOr6v4Lgl6Hxto7/Z09afC3q
         w6/wC7fMeysjdGCPo/E5OXt29w5C/BwzqwG2x8xtsyOhJFV7qIWM0/4djlaJM3uKryIT
         5zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JF0O4zn/LEpQ/Of9oMm7Pjnzg7UngdrXOP4yvvJEbCU=;
        b=pN8d3F+Wdhb+zBmAotihfP5EMAqYGAVTbPZ6CyQjSNOcYd/OdEmcqoXQbG77vG3sC/
         TmrRLMZQ8L6xzuFrF8ntuQW82SlXMsS1imKjq5faENnLuns+EsWn9X5iGa3KlwoxL1U3
         JOxdDAvrURrnvBtmyPJHkhHhOXXAUuqYlpdX8nm5Zhmvklm0x1su0/X46sDFKU8o43HE
         y6Ps4cfd/3Pjezg8ASQX/+njswn8UJzekOnpyhIT4obkKWsmn5Axu3CsNP5UmPiv2MQW
         HdgsjH1oSon6YH+b0nKuyF0a/zIp43DQgjOJV7MYCuQRPTj4ErMDNJqFbAGus+AIJ247
         xCag==
X-Gm-Message-State: APzg51C9vk846xheSr8Ndm5chLUdmk2BVbjvlSY+igdv4EwmJdRkIKH3
        4QnUG9puXIKm/Wn8VXk6mvEWbLkK
X-Google-Smtp-Source: ANB0VdbASkaicKOnGL6+UsioZtXnGGwHO4TNxNlyJZ1xpvq56/L4LUy8drHngFwzGqkGWyt2AclF0Q==
X-Received: by 2002:a62:9349:: with SMTP id b70-v6mr22010117pfe.193.1536560647863;
        Sun, 09 Sep 2018 23:24:07 -0700 (PDT)
Received: from localhost.localdomain ([104.237.86.186])
        by smtp.gmail.com with ESMTPSA id e190-v6sm29884955pfc.81.2018.09.09.23.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 23:24:07 -0700 (PDT)
From:   Ocean He <oceanhehy@gmail.com>
To:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [PATCH 2/3] libnvdimm, namespace_devs: add function nd_region_reset_ns_seed for namespace seed reset
Date:   Mon, 10 Sep 2018 02:21:47 -0400
Message-Id: <1536560508-24564-3-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536560508-24564-1-git-send-email-oceanhehy@gmail.com>
References: <1536560508-24564-1-git-send-email-oceanhehy@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

During runtime, if a namespace seed is used for new namespace creation
but fail, then it needs to be reset for next namespace creation.

Add function nd_region_reset_ns_seed for namespace seed reset and
declare it in nd-core.h.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/nvdimm/namespace_devs.c | 32 ++++++++++++++++++++++++++++++++
 drivers/nvdimm/nd-core.h        |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 4a42662..6678bbe 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2129,6 +2129,38 @@ void nd_region_create_ns_seed(struct nd_region *nd_region)
 		nd_device_register(nd_region->ns_seed);
 }
 
+void nd_region_reset_ns_seed(struct nd_region *nd_region)
+{
+	struct device *dev = nd_region->ns_seed;
+	unsigned long long val = 0;
+	ssize_t rc;
+	u8 **uuid = NULL;
+
+	rc = __holder_class_store(dev, "");
+	dev_dbg(dev, "%s(%zd)\n", rc < 0 ? "fail to reset claim_class " : "", rc);
+
+	rc = __size_store(dev, val);
+	if (rc >= 0)
+		rc = nd_namespace_label_update(nd_region, dev);
+	dev_dbg(dev, "%s(%zd)\n", rc < 0 ? "fail to reset size " : "", rc);
+
+	if (is_namespace_pmem(dev)) {
+		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
+
+		uuid = &nspm->uuid;
+	} else if (is_namespace_blk(dev)) {
+		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
+
+		uuid = &nsblk->uuid;
+	}
+
+	if (rc == 0 && val == 0 && uuid) {
+		/* setting size zero == 'delete namespace' */
+		kfree(*uuid);
+		*uuid = NULL;
+	}
+}
+
 void nd_region_create_dax_seed(struct nd_region *nd_region)
 {
 	WARN_ON(!is_nvdimm_bus_locked(&nd_region->dev));
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 7fd74d0..3ec6909 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -81,6 +81,7 @@ static inline bool is_memory(struct device *dev)
 void nd_region_probe_success(struct nvdimm_bus *nvdimm_bus, struct device *dev);
 struct nd_region;
 void nd_region_create_ns_seed(struct nd_region *nd_region);
+void nd_region_reset_ns_seed(struct nd_region *nd_region);
 void nd_region_create_btt_seed(struct nd_region *nd_region);
 void nd_region_create_pfn_seed(struct nd_region *nd_region);
 void nd_region_create_dax_seed(struct nd_region *nd_region);
-- 
1.8.3.1

