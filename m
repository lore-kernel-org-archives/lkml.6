Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F768C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0918B20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGkWmsOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0918B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeIJLQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:16:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42304 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJLQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:16:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so9226787plq.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fHMI+xukBON89nXvZYMkVDi6OYKOCbycFLQGiP1LgNU=;
        b=lGkWmsODnzacGztU7q5LQsZn9aKq550tNmkWbHvANLe/cPvSn9JsM+U0OsudZB3jgr
         dFJgZvfOtiWdG+qfQO9a0A73ZS5/MrhBIAZO5jbEN+wzHdZtU5M5vpIWkL4216SFgM9+
         TgB9zJPwM59H7umPCG1Miv4gIcbk5QKm3BwWOQNjradVbXmT+AvPGA/13XxeEyvW8oCT
         5jMHRJMjc6haZgZWXmC24yslELdcZi1Xveh/ixjFjjEE6gQeIYbZwNgS4KIyx8fWBNFA
         tkU+17DcXdpGKIcY54LPGkchRYlET0aUghZ2zkab6A3v4XIJIqM1v5HYzx8xC+nqqdWu
         A+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fHMI+xukBON89nXvZYMkVDi6OYKOCbycFLQGiP1LgNU=;
        b=mUQNi6HxO9SjHHTeI79B48OnnMiuGU1jfl23bNGdcPEQCOLZ8k/ETszxfz5wo51IGd
         LlS18R2d+w25kHFBWnb9/0a9uS8JaRgbXg+ovigETCZOmeEhYWaZie/moECSIsktE5jh
         hheAZe7vt6DZvL+ctxqHDIfPtGSXHlM7n9yJHhmNBEgn+K5jTq02FRXq1Bv/mqy3x8tj
         /eU4mjThREWQqLpqNAa/fG9D/fU8MFnJ2KN8QuPl29VPYUPPwTHmKxn0zhAAVoo+KgRl
         bve4wr1nymlOiP9eaIC5jtgOiy+32Cach2Lc0Hv/6CbGaAHB0Xizhaoszukrthtjs8aJ
         i+Dg==
X-Gm-Message-State: APzg51C3D+h4YQn4duNVfdviDU1VzSGREtgropx5f7vZom3Tj4uZ5pNj
        D4oGkUVnJ9OE9djTI2TAXbs=
X-Google-Smtp-Source: ANB0Vdanr0ZwDB8k65v4PQhQy8gJsV9jqtnA3Sd3QYhkEBBGczdUB0dsPKlLfwWmhas7whwGT8Q2Pg==
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr20030244plf.320.1536560645127;
        Sun, 09 Sep 2018 23:24:05 -0700 (PDT)
Received: from localhost.localdomain ([104.237.86.186])
        by smtp.gmail.com with ESMTPSA id e190-v6sm29884955pfc.81.2018.09.09.23.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 23:24:04 -0700 (PDT)
From:   Ocean He <oceanhehy@gmail.com>
To:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [PATCH 1/3] libnvdimm, claim: remove static attribute of nd_detach_and_reset
Date:   Mon, 10 Sep 2018 02:21:46 -0400
Message-Id: <1536560508-24564-2-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536560508-24564-1-git-send-email-oceanhehy@gmail.com>
References: <1536560508-24564-1-git-send-email-oceanhehy@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

The function nd_detach_and_reset needs to be called externally, so
remove the static attribute and declare it in nd-core.h.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/nvdimm/claim.c   | 2 +-
 drivers/nvdimm/nd-core.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index fb667bf..46e56ecf 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -117,7 +117,7 @@ struct nd_pfn *to_nd_pfn_safe(struct device *dev)
 	return NULL;
 }
 
-static void nd_detach_and_reset(struct device *dev,
+void nd_detach_and_reset(struct device *dev,
 		struct nd_namespace_common **_ndns)
 {
 	/* detach the namespace and destroy / reset the device */
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index ac68072..7fd74d0 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -123,6 +123,7 @@ struct resource *nsblk_add_resource(struct nd_region *nd_region,
 resource_size_t __nvdimm_namespace_capacity(struct nd_namespace_common *ndns);
 void nd_detach_ndns(struct device *dev, struct nd_namespace_common **_ndns);
 void __nd_detach_ndns(struct device *dev, struct nd_namespace_common **_ndns);
+void nd_detach_and_reset(struct device *dev, struct nd_namespace_common **_ndns);
 bool nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
 		struct nd_namespace_common **_ndns);
 bool __nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
-- 
1.8.3.1

