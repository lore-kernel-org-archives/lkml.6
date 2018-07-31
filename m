Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB61C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398B20685
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iq5d2rnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4398B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbeGaRz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:55:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35506 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeGaRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:54:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so17268505wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MstRtlbSy22PdLRbN/kTddePgmsV5+WAQ27NH2SPrJw=;
        b=Iq5d2rnL9lMSwZ3/x3Y+anfMCcAWqd5FbNsH+M7x3YUq+PIWFp6fm7Gtt3sSOLZnJK
         w+2UbbNc7mYNqmV/QolqNbuUwqYAviFMEwq6C2uwRpKhQ0a17biFifBrvIChVYesRAz0
         e+6oM2sdEKaLU6EAcpTl22PnPXJWy5zki/6zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MstRtlbSy22PdLRbN/kTddePgmsV5+WAQ27NH2SPrJw=;
        b=UPCkmR+TPpbOi3iOqh4eFzcpTwXIHhq0OHAa7q1ArkWXbMfwljJXBZ4X3F+TFQOCLZ
         CPGRDNFcQf1O2/51e7AVlRahq5Zg3UZuoGCz6bBqmZFZZstYHBNkwDkGeDaCki+821Sf
         wxauwBLyfFkxCEs4UoorsbTdGA3UTWTTdC5iW5UYneQwn8Ez+Q6tyGKIVddrXousL21Y
         gukpiQ4gNjL8yfWefQTuIYWRecJddMhqms1BGrb7i1rA3ohTd0V5zOVAoR6agcWzYzjk
         8lZWj01qVRla06G3sYujCtP+3lUnci0AxnunhPvZwLz16sOjQuAntzw10B70wqbA+6F+
         0KOA==
X-Gm-Message-State: AOUpUlFxrcrIjkLCFNkzfSNQrCnEa3fK+twzIFmbfeFHAleBUkPG2fC/
        e81LOtcwasPvqB9d5x6m57vKLg==
X-Google-Smtp-Source: AAOMgpfoHfrlEuSVqvvZ5ZSoKEKcZ3PBbEZTbHbZ2Oi5QnFdpyOUjIYnyHrSVN8ikwQIG4zQinRiIA==
X-Received: by 2002:adf:fe8f:: with SMTP id l15-v6mr22111546wrr.165.1533053628052;
        Tue, 31 Jul 2018 09:13:48 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id t186-v6sm3643457wmf.14.2018.07.31.09.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 09:13:47 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v7 3/8] interconnect: Add debugfs support
Date:   Tue, 31 Jul 2018 19:13:35 +0300
Message-Id: <20180731161340.13000-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731161340.13000-1-georgi.djakov@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
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
index 1de4997bc75a..9fef180cf77e 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -6,6 +6,7 @@
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -16,10 +17,12 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/overflow.h>
+#include <linux/uaccess.h>
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_provider_list);
 static DEFINE_MUTEX(icc_lock);
+static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -48,6 +51,62 @@ struct icc_path {
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
+#endif
+
 static struct icc_node *node_find(const int id)
 {
 	return idr_find(&icc_idr, id);
@@ -564,6 +623,25 @@ int icc_provider_del(struct icc_provider *provider)
 }
 EXPORT_SYMBOL_GPL(icc_provider_del);
 
+static int __init icc_init(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
+	debugfs_create_file("interconnect_summary", 0444,
+			    icc_debugfs_dir, NULL, &icc_summary_fops);
+#endif
+	return 0;
+}
+
+static void __exit icc_exit(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(icc_debugfs_dir);
+#endif
+}
+module_init(icc_init);
+module_exit(icc_exit);
+
 MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
 MODULE_DESCRIPTION("Interconnect Driver Core");
 MODULE_LICENSE("GPL v2");
