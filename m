Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24834C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39A52175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfBEU2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:28:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:52020 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEU2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:28:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 12:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,336,1544515200"; 
   d="scan'208";a="131336533"
Received: from rhazra-x1y7.amr.corp.intel.com (HELO tstruk-mobl1.jf.intel.com) ([10.252.196.214])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2019 12:28:34 -0800
Subject: [PATCH 1/2] selftests: tpm2: Open tpm dev in unbuffered mode
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, PeterHuewe@gmx.de,
        jgg@ziepe.ca
Date:   Tue, 05 Feb 2019 12:28:33 -0800
Message-ID: <154939851385.18477.481518864800562919.stgit@tstruk-mobl1.jf.intel.com>
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

