Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AEEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202F02250F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202F02250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbeKNEF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:05:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:59581 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732561AbeKNEF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:05:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 10:06:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="279519689"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2018 10:06:43 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
        arnd@arndb.de, corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, todd.riffel@intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv11 7/8] Documentation: driver-api: add stratix10 service layer
Date:   Tue, 13 Nov 2018 12:14:05 -0600
Message-Id: <1542132846-24168-8-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542132846-24168-1-git-send-email-richard.gong@linux.intel.com>
References: <1542132846-24168-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add Intel Stratix10 service layer driver document

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v5: this patch is added in patch set version 5,
    add new file stratix10-svc.rst
    add stratix10-svc.rst to driver-api/index.rst
v6: no change
v7: no change
v8: no change
v9: no change
v10: add stratix10 service layer document to other firmware
     interface, and then remove stratix10-svc.rst file
v11: no change
---
 .../driver-api/firmware/other_interfaces.rst       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 36c47b1..a4ac54b 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -13,3 +13,33 @@ EDD Interfaces
 .. kernel-doc:: drivers/firmware/edd.c
    :internal:
 
+Intel Stratix10 SoC Service Layer
+---------------------------------
+Some features of the Intel Stratix10 SoC require a level of privilege
+higher than the kernel is granted. Such secure features include
+FPGA programming. In terms of the ARMv8 architecture, the kernel runs
+at Exception Level 1 (EL1), access to the features requires
+Exception Level 3 (EL3).
+
+The Intel Stratix10 SoC service layer provides an in kernel API for
+drivers to request access to the secure features. The requests are queued
+and processed one by one. ARM’s SMCCC is used to pass the execution
+of the requests on to a secure monitor (EL3).
+
+.. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
+   :functions: stratix10_svc_command_code
+
+.. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
+   :functions: stratix10_svc_client_msg
+
+.. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
+   :functions: stratix10_svc_command_reconfig_payload
+
+.. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
+   :functions: stratix10_svc_cb_data
+
+.. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
+   :functions: stratix10_svc_client
+
+.. kernel-doc:: drivers/firmware/stratix10-svc.c
+   :export:
-- 
2.7.4

