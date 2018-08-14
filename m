Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FC5C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4051421729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkNAGkj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4051421729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeHNWEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730004AbeHNWEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:04:15 -0400
Received: from localhost.localdomain (unknown [192.55.54.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F0E2172B;
        Tue, 14 Aug 2018 19:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534274138;
        bh=pWWMwnbd02elfRJzVpfdowZMWmN32d+r/R5GZjcXNpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkNAGkj9FLYTMGDrXEV4r0wTJmQ+CG+HrzzRnMEatVh5fQm57GV/SS2V1bygBnuXD
         yqAJuSA5HJaFTP9uk/xqMoWqYN+SY/J2Es7nFMrMDkw14jEtm7pat3nprZYvucgM50
         d5gliufK1BgVWQCT5Kl2izCDFU4nsENmFCTfZ00Q=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 7/8] docs: fpga: document fpga manager flags
Date:   Tue, 14 Aug 2018 14:15:25 -0500
Message-Id: <20180814191526.3247-8-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180814191526.3247-1-atull@kernel.org>
References: <20180814191526.3247-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flags #defines to kerneldoc documentation in a
useful place.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 Documentation/driver-api/fpga/fpga-mgr.rst |  5 +++++
 include/linux/fpga/fpga-mgr.h              | 18 ++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 431556d..db8885e 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -183,6 +183,11 @@ API for implementing a new FPGA Manager driver
 API for programming an FPGA
 ---------------------------
 
+FPGA Manager flags
+
+.. kernel-doc:: include/linux/fpga/fpga-mgr.h
+   :doc: FPGA Manager flags
+
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_image_info
 
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 1ca02ce..777c502 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -53,12 +53,18 @@ enum fpga_mgr_states {
 	FPGA_MGR_STATE_OPERATING,
 };
 
-/*
- * FPGA Manager flags
- * FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
- * FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
- * FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
- * FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+/**
+ * DOC: FPGA Manager flags
+ *
+ * Flags used in the &fpga_image_info->flags field
+ *
+ * %FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
+ *
+ * %FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
+ *
+ * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
+ *
+ * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
-- 
2.7.4

