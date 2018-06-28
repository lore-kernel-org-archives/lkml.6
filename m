Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D76C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3A8258A0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0J1t7Jq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3A8258A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbeF1B4r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752729AbeF1B41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:56:27 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5DA7258E2;
        Thu, 28 Jun 2018 01:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530150986;
        bh=2gZiQZNg8GFvwxbaUsP5Jvm/jovOd4aQdlQCDvcmPQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0J1t7JqWZRBetSsr0RZyhg6hkGxyNxuKt1EG8iRQ2b8FieGcD7sp3rauEL6ezKHn
         7ngVpnQHh9J7Ly/s6n2S4dw9uOj5cB01ntePdzBHcHgf1c70XgAI5EnAzBuSvcTpiQ
         km019meu2d1ZENd6L05p4rOQjwHnLLrS7CbU82k0=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
Subject: [PATCH 2/2] Documentation: fpga: cleanup
Date:   Wed, 27 Jun 2018 20:56:19 -0500
Message-Id: <1530150979-5693-3-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530150979-5693-1-git-send-email-atull@kernel.org>
References: <1530150979-5693-1-git-send-email-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor fixes including:

* fix some typos
* correct use of a/an
* rephrase explanation of .state ops function
* s/re-use/reuse/ (use only one spelling of 'reuse' in these docs)
* s/cpu/CPU/

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/driver-api/fpga/fpga-mgr.rst    | 12 ++++++------
 Documentation/driver-api/fpga/fpga-region.rst | 12 ++++++------
 Documentation/driver-api/fpga/intro.rst       | 14 +++++++-------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index bcf2dd2..4b3825d 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -83,7 +83,7 @@ The programming sequence is::
  3. .write_complete
 
 The .write_init function will prepare the FPGA to receive the image data.  The
-buffer passed into .write_init will be atmost .initial_header_size bytes long,
+buffer passed into .write_init will be at most .initial_header_size bytes long;
 if the whole bitstream is not immediately available then the core code will
 buffer up at least this much before starting.
 
@@ -98,9 +98,9 @@ scatter list. This interface is suitable for drivers which use DMA.
 The .write_complete function is called after all the image has been written
 to put the FPGA into operating mode.
 
-The ops include a .state function which will read the hardware FPGA manager and
-return a code of type enum fpga_mgr_states.  It doesn't result in a change in
-hardware state.
+The ops include a .state function which will determine the state the FPGA is in
+and return a code of type enum fpga_mgr_states.  It doesn't result in a change
+in state.
 
 How to write an image buffer to a supported FPGA
 ------------------------------------------------
@@ -181,8 +181,8 @@ API for implementing a new FPGA Manager driver
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
 
-API for programming a FPGA
---------------------------
+API for programming an FPGA
+---------------------------
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_image_info
diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index f89e4a3..f30333c 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -4,7 +4,7 @@ FPGA Region
 Overview
 --------
 
-This document is meant to be an brief overview of the FPGA region API usage.  A
+This document is meant to be a brief overview of the FPGA region API usage.  A
 more conceptual look at regions can be found in the Device Tree binding
 document [#f1]_.
 
@@ -31,11 +31,11 @@ fpga_image_info including:
  * pointers to the image as either a scatter-gather buffer, a contiguous
    buffer, or the name of firmware file
 
- * flags indicating specifics such as whether the image if for partial
+ * flags indicating specifics such as whether the image is for partial
    reconfiguration.
 
-How to program a FPGA using a region
-------------------------------------
+How to program an FPGA using a region
+-------------------------------------
 
 First, allocate the info struct::
 
@@ -77,8 +77,8 @@ An example of usage can be seen in the probe function of [#f2]_.
 .. [#f1] ../devicetree/bindings/fpga/fpga-region.txt
 .. [#f2] ../../drivers/fpga/of-fpga-region.c
 
-API to program a FGPA
----------------------
+API to program an FPGA
+----------------------
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_program_fpga
diff --git a/Documentation/driver-api/fpga/intro.rst b/Documentation/driver-api/fpga/intro.rst
index 51cd81d..50d1cab 100644
--- a/Documentation/driver-api/fpga/intro.rst
+++ b/Documentation/driver-api/fpga/intro.rst
@@ -12,18 +12,18 @@ Linux.  Some of the core intentions of the FPGA subsystems are:
 
 * Code should not be shared between upper and lower layers.  This
   should go without saying.  If that seems necessary, there's probably
-  framework functionality that that can be added that will benefit
+  framework functionality that can be added that will benefit
   other users.  Write the linux-fpga mailing list and maintainers and
   seek out a solution that expands the framework for broad reuse.
 
-* Generally, when adding code, think of the future.  Plan for re-use.
+* Generally, when adding code, think of the future.  Plan for reuse.
 
 The framework in the kernel is divided into:
 
 FPGA Manager
 ------------
 
-If you are adding a new FPGA or a new method of programming a FPGA,
+If you are adding a new FPGA or a new method of programming an FPGA,
 this is the subsystem for you.  Low level FPGA manager drivers contain
 the knowledge of how to program a specific device.  This subsystem
 includes the framework in fpga-mgr.c and the low level drivers that
@@ -32,10 +32,10 @@ are registered with it.
 FPGA Bridge
 -----------
 
-FPGA Bridges prevent spurious signals from going out of a FPGA or a
-region of a FPGA during programming.  They are disabled before
+FPGA Bridges prevent spurious signals from going out of an FPGA or a
+region of an FPGA during programming.  They are disabled before
 programming begins and re-enabled afterwards.  An FPGA bridge may be
-actual hard hardware that gates a bus to a cpu or a soft ("freeze")
+actual hard hardware that gates a bus to a CPU or a soft ("freeze")
 bridge in FPGA fabric that surrounds a partial reconfiguration region
 of an FPGA.  This subsystem includes fpga-bridge.c and the low level
 drivers that are registered with it.
@@ -44,7 +44,7 @@ FPGA Region
 -----------
 
 If you are adding a new interface to the FPGA framework, add it on top
-of a FPGA region to allow the most reuse of your interface.
+of an FPGA region to allow the most reuse of your interface.
 
 The FPGA Region framework (fpga-region.c) associates managers and
 bridges as reconfigurable regions.  A region may refer to the whole
-- 
2.7.4

