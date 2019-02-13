Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4EDC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68308222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392712AbfBMQja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:39:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:10830 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391852AbfBMQj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:39:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 08:39:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="138320208"
Received: from tstruk-mobl1.ra.intel.com (HELO tstruk-mobl1.jf.intel.com) ([10.7.196.56])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2019 08:39:28 -0800
Subject: [PATCH  v2] selftests/tpm2: Open tpm dev in unbuffered mode
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, PeterHuewe@gmx.de,
        jgg@ziepe.ca
Date:   Wed, 13 Feb 2019 08:39:28 -0800
Message-ID: <155007596864.18677.9373151400257566077.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have control over how many bytes are read or written
the device needs to be opened in unbuffered mode.

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---

v2:
- Changed subject tags to selftests/tpm2:
---
 tools/testing/selftests/tpm2/tpm2.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
index 40ea95ce2ead..c2b9f2b1a0ac 100644
--- a/tools/testing/selftests/tpm2/tpm2.py
+++ b/tools/testing/selftests/tpm2/tpm2.py
@@ -357,9 +357,9 @@ class Client:
         self.flags = flags
 
         if (self.flags & Client.FLAG_SPACE) == 0:
-            self.tpm = open('/dev/tpm0', 'r+b')
+            self.tpm = open('/dev/tpm0', 'r+b', buffering=0)
         else:
-            self.tpm = open('/dev/tpmrm0', 'r+b')
+            self.tpm = open('/dev/tpmrm0', 'r+b', buffering=0)
 
     def close(self):
         self.tpm.close()

