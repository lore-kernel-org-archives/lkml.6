Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93333ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEE820856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEE820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeGTOXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:23:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730996AbeGTOXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2E0A402B03F;
        Fri, 20 Jul 2018 13:35:04 +0000 (UTC)
Received: from pdhamdhe.redhat.com (unknown [10.76.0.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 518592026D69;
        Fri, 20 Jul 2018 13:35:03 +0000 (UTC)
From:   Prashant Dhamdhere <pdhamdhe@redhat.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdhamdhe@redhat.com
Subject: [PATCH v2] Documentation: vm.txt: Adding 'nr_hugepages_mempolicy' parameter description.
Date:   Fri, 20 Jul 2018 19:05:00 +0530
Message-Id: <20180720133500.10475-1-pdhamdhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 13:35:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 13:35:04 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pdhamdhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 'nr_hugepages_mempolicy' parameter which is currently missing
in 'vm.txt' file. It also contains a short description of 'nr_hugepages_mempolicy'
parameter.

Signed-off-by: Prashant Dhamdhere <pdhamdhe@redhat.com>
---
 Documentation/sysctl/vm.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 697ef8c225df..b17ceb0e5a47 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -44,6 +44,7 @@ Currently, these files are in /proc/sys/vm:
 - mmap_rnd_bits
 - mmap_rnd_compat_bits
 - nr_hugepages
+- nr_hugepages_mempolicy
 - nr_overcommit_hugepages
 - nr_trim_pages         (only if CONFIG_MMU=n)
 - numa_zonelist_order
@@ -519,6 +520,15 @@ See Documentation/admin-guide/mm/hugetlbpage.rst
 
 ==============================================================
 
+nr_hugepages_mempolicy
+
+Change the size of the hugepage pool at run-time on a specific
+set of NUMA nodes.
+
+See Documentation/admin-guide/mm/hugetlbpage.rst
+
+==============================================================
+
 nr_overcommit_hugepages
 
 Change the maximum size of the hugepage pool. The maximum is
-- 
2.17.1

