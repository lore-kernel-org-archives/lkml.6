Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343DEC07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED83B20868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED83B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLHCEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 21:04:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:15324 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeLHCEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 21:04:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 18:04:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,328,1539673200"; 
   d="scan'208";a="124049002"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2018 18:04:19 -0800
Date:   Fri, 7 Dec 2018 18:06:45 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     keith.busch@intel.com, Kirill Shutemov <kirill.shutemov@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/vm/gup_benchmark.c: match gup struct to kernel
Message-ID: <20181208020645.GA28467@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An expansion field was added to the kernel copy of this structure for
future use. See mm/gup_benchmark.c.

Add the same expansion field here, so that the IOCTL command decodes
correctly. Otherwise, it fails with EINVAL.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/selftests/vm/gup_benchmark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 880b96fc80d4..c0534e298b51 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -25,6 +25,7 @@ struct gup_benchmark {
 	__u64 size;
 	__u32 nr_pages_per_call;
 	__u32 flags;
+	__u64 expansion[10];	/* For future use */
 };
 
 int main(int argc, char **argv)
-- 
2.14.1

