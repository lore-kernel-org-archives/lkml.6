Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE30C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270352083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYlFIv/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270352083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933383AbeFTXnP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:43:15 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:58184 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933012AbeFTXmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:42:05 -0400
Received: by mail-it0-f73.google.com with SMTP id 13-v6so1122865itl.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Fy6bOjKKTweFLCCTIlnpZiRcE4qX5oDENmYHoVBVYu0=;
        b=EYlFIv/X1rwRRvH6HBeswuuq9mXdgp0FFxajLAYbWnE5gdZ3zbN/3KuG+dYegpkryT
         33KcDXWW9Lrv6VIS5f2ji35/kqebqU6s20jnc9zEoSMAFnGvVORwm+EUsjKxVMC0KfLu
         NWa4tTAp9re+zcIBdEX5Ahj0aOQahK0xUzKHYHG7YEutzcLODtodLH5MkhdcojOaQOtF
         v1kRJd3ajlizIlHm7FYi3ICF/LuKO/awN40MRlT/ZixXUa2CWWanaIg2kaxl9cJScqEq
         ZSXjizzronzg5ZP8GwSe128Wqbt7hOS9qnvDZ8JFNZBurxAsxJsc9spgo8vX2hMDBx5e
         CDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Fy6bOjKKTweFLCCTIlnpZiRcE4qX5oDENmYHoVBVYu0=;
        b=m/IfsJsle7hAxblPXbV3J5ez92GNyON97RNwZOqNw5vqiu4z8GheSbLjeklf0WmKqm
         yFST/aTBQoG3XERB4hH32kkLf6rud6VUrQVYlXtk6o0keXbyRAonsch5OfQ6aaSrp7fT
         lYblWzwjFPZlO3LRP9B7VK69HKRf12D2EGl8T4hn1KZG5CdItGPaJN9t51OyTr+8nsTq
         kmb33d9ETKEJ7bpGZjhA8oQXrgP22V0uD/PSnHxhN0HuvrP7p1NFEQheszOSznnb3bvd
         kRrL7FqscRPPESXMjVdXKPz9jZ9o+U+mKzvkY8qhFeu9qAie8azbGZU0G667ZJjc99GY
         S2Ig==
X-Gm-Message-State: APt69E01ysqK1HxbKfVIGEfbbu3k+U4/a5vA4o0rpXFKl+PbnMKGDqtK
        kz4Q/A/Lc42Sapqh4dI3r/nUGRTqSGm8
X-Google-Smtp-Source: ADUXVKJ3hxZ4qN9tudZm+AqJulChSfUbtz2CoSjp7A+IreDXcm/tXvB56R8D5nvz+iubhXg5MwWKysptnwsg
MIME-Version: 1.0
X-Received: by 2002:a24:28c7:: with SMTP id h190-v6mr1716242ith.20.1529538124185;
 Wed, 20 Jun 2018 16:42:04 -0700 (PDT)
Date:   Wed, 20 Jun 2018 16:41:45 -0700
In-Reply-To: <20180620234147.48438-1-rajatja@google.com>
Message-Id: <20180620234147.48438-3-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com> <20180620234147.48438-1-rajatja@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v5 3/5] PCI/AER: Add sysfs attributes to provide breakdown of AERs
From:   Rajat Jain <rajatja@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com,
        helgaas@kernel.org
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs attributes to provide breakdown of the AERs seen,
into different type of correctable or uncorrectable errors:

dev_breakdown_correctable
dev_breakdown_uncorrectable

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v5: Fix the signature
v4: use "%llu" in place of "%llx"
v3: Merge everything in aer.c

 drivers/pci/pcie/aer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ce0d675d7bd3..c989bb5bb6f1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -587,10 +587,38 @@ aer_stats_aggregate_attr(dev_total_cor_errs);
 aer_stats_aggregate_attr(dev_total_fatal_errs);
 aer_stats_aggregate_attr(dev_total_nonfatal_errs);
 
+#define aer_stats_breakdown_attr(field, stats_array, strings_array)	\
+	static ssize_t							\
+	field##_show(struct device *dev, struct device_attribute *attr,	\
+		     char *buf)						\
+{									\
+	unsigned int i;							\
+	char *str = buf;						\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	u64 *stats = pdev->aer_stats->stats_array;			\
+	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
+		if (strings_array[i])					\
+			str += sprintf(str, "%s = 0x%llu\n",		\
+				       strings_array[i], stats[i]);	\
+		else if (stats[i])					\
+			str += sprintf(str, #stats_array "bit[%d] = 0x%llu\n",\
+				       i, stats[i]);			\
+	}								\
+	return str-buf;							\
+}									\
+static DEVICE_ATTR_RO(field)
+
+aer_stats_breakdown_attr(dev_breakdown_correctable, dev_cor_errs,
+			 aer_correctable_error_string);
+aer_stats_breakdown_attr(dev_breakdown_uncorrectable, dev_uncor_errs,
+			 aer_uncorrectable_error_string);
+
 static struct attribute *aer_stats_attrs[] __ro_after_init = {
 	&dev_attr_dev_total_cor_errs.attr,
 	&dev_attr_dev_total_fatal_errs.attr,
 	&dev_attr_dev_total_nonfatal_errs.attr,
+	&dev_attr_dev_breakdown_correctable.attr,
+	&dev_attr_dev_breakdown_uncorrectable.attr,
 	NULL
 };
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

