Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B10CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0692B20842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2JsN3/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0692B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933718AbeGIPys (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:54:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40756 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933781AbeGIPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:51:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id t6-v6so11517310wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Z7eEmJHjemqKmc1XOzTB2TureY7MusYkWywxYsb/f0=;
        b=W2JsN3/Xr8bzOUPlv1X3kEKSz3Q8YMxgHmNzUagwj8xyPIlaLzWZlP5m4+pOhlKenX
         XyO6Qy989rqcP0zQanblLVLXZ/ULxbwoWKinalR65dEuZyZfEda3BZB4hwngPj23zJhT
         PoE20Blg3Rsp92OgX9Ixq9WgTvyzCQhwHjoKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Z7eEmJHjemqKmc1XOzTB2TureY7MusYkWywxYsb/f0=;
        b=IM7xi3lerWu8p1nTGdZLA3mNX67d3gCHqlHrW8N+aJ4QmCgVbg2p2VB03hrpryZf09
         cWtuSHE+e5ev0G5RC7+bCbPJSUnXWuNV0kg+Cu6n4/cXLxTo5Rsmaz8GbsvoQv/xbku5
         SSlW4Ovv9weAL0Nc+OmrODs3BJhEeAY3nJBO53yWx4dE7hjTu2k06n9h2tmFmqUWTTr9
         lsqrnW14h1YidBfoW2/j0STVfoYJu1BPoU3wBqV3Sg/oeVlGuxFYDUD9auC9I0EOwAza
         5EgIKCP7bI8Na3yZI5VsC+2oB+SgSNg7vUYoTV1xxb5Iui5vXakzwhgLjuXBbc5xBzp8
         nsPw==
X-Gm-Message-State: AOUpUlFyxAP/KhCW6rJ7T68g523oFrSWiE19oFcLsNWg64Kyo/hF3tgi
        nI8axllSJJj4b7p8e8Ji6aQAcw==
X-Google-Smtp-Source: AAOMgpfcAqOKmyX1/wik8+nATbYvL28HJlowaUdkvpgmSsL68AUWpSnAuNwnee7xxGzNKo/dHQigvA==
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr6937864wra.90.1531151472892;
        Mon, 09 Jul 2018 08:51:12 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o21-v6sm16229202wmg.28.2018.07.09.08.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:51:12 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, abailon@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v6 3/8] interconnect: Add debugfs support
Date:   Mon,  9 Jul 2018 18:50:59 +0300
Message-Id: <20180709155104.25528-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709155104.25528-1-georgi.djakov@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a functionality to provide information about the current constraints
per each node and provider.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 63707c3c3d48..3f5001f51bb7 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -6,6 +6,7 @@
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -15,10 +16,12 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_provider_list);
 static DEFINE_MUTEX(icc_lock);
+static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -47,6 +50,81 @@ struct icc_path {
 	struct icc_req reqs[];
 };
 
+#ifdef CONFIG_DEBUG_FS
+
+static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
+{
+	if (!n)
+		return;
+
+	seq_printf(s, "%-30s %12d %12d\n",
+		   n->name, n->avg_bw, n->peak_bw);
+}
+
+static int icc_summary_show(struct seq_file *s, void *data)
+{
+	struct icc_provider *provider;
+
+	seq_puts(s, " node                                   avg         peak\n");
+	seq_puts(s, "--------------------------------------------------------\n");
+
+	mutex_lock(&icc_lock);
+
+	list_for_each_entry(provider, &icc_provider_list, provider_list) {
+		struct icc_node *n;
+
+		list_for_each_entry(n, &provider->nodes, node_list) {
+			struct icc_req *r;
+
+			icc_summary_show_one(s, n);
+			hlist_for_each_entry(r, &n->req_list, req_node) {
+				if (!r->dev)
+					continue;
+
+				seq_printf(s, "    %-26s %12d %12d\n",
+					   dev_name(r->dev), r->avg_bw,
+					   r->peak_bw);
+			}
+		}
+	}
+
+	mutex_unlock(&icc_lock);
+
+	return 0;
+}
+
+static int icc_summary_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, icc_summary_show, inode->i_private);
+}
+
+static const struct file_operations icc_summary_fops = {
+	.open		= icc_summary_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init icc_debugfs_init(void)
+{
+	struct dentry *file;
+
+	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
+	if (!icc_debugfs_dir) {
+		pr_err("interconnect: error creating debugfs directory\n");
+		return -ENODEV;
+	}
+
+	file = debugfs_create_file("interconnect_summary", 0444,
+				   icc_debugfs_dir, NULL, &icc_summary_fops);
+	if (!file)
+		return -ENODEV;
+
+	return 0;
+}
+late_initcall(icc_debugfs_init);
+#endif
+
 static struct icc_node *node_find(const int id)
 {
 	return idr_find(&icc_idr, id);
