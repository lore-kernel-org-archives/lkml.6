Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE08ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25A52147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25A52147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbeIUBsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:48:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:62935 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388340AbeIUBsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:48:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 13:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="264386366"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2018 13:02:05 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 5/7] tools/gup_benchmark: Add parameter for hugetlb
Date:   Thu, 20 Sep 2018 14:03:56 -0600
Message-Id: <20180920200358.31680-6-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180920200358.31680-1-keith.busch@intel.com>
References: <20180920200358.31680-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 tools/testing/selftests/vm/gup_benchmark.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index f2c99e2436f8..5d96e2b3d2f1 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -38,7 +38,7 @@ int main(int argc, char **argv)
 	char *file = NULL;
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:f:tTLU")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:f:tTLUH")) != -1) {
 		switch (opt) {
 		case 'm':
 			size = atoi(optarg) * MB;
@@ -64,6 +64,9 @@ int main(int argc, char **argv)
 		case 'w':
 			write = 1;
 			break;
+		case 'H':
+			flags |= MAP_HUGETLB;
+			break;
 		case 'f':
 			file = optarg;
 			flags &= ~(MAP_PRIVATE | MAP_ANONYMOUS);
-- 
2.14.4

