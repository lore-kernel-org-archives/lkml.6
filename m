Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89A4C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDC821741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDC821741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darmarit.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbeHNOaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:30:14 -0400
Received: from smtp2.goneo.de ([85.220.129.33]:51056 "EHLO smtp2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbeHNOaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:30:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 7E6A423F2D7;
        Tue, 14 Aug 2018 13:43:22 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zxHonyjMQ2cW; Tue, 14 Aug 2018 13:43:21 +0200 (CEST)
Received: from ryzen.fritz.box (host-091-097-242-136.ewe-ip-backbone.de [91.97.242.136])
        by smtp2.goneo.de (Postfix) with ESMTPSA id AF20723F44C;
        Tue, 14 Aug 2018 13:43:20 +0200 (CEST)
From:   Markus Heiser <markus.heiser@darmarit.de>
To:     Thomas Gleixner <tglx@linutronix.de>, Jonas Oberg <jonas@fsfe.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: tidy up TOCs and refs to license-rules.rst
Date:   Tue, 14 Aug 2018 13:43:12 +0200
Message-Id: <20180814114312.23201-1-markus.heiser@darmarit.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation and TOCs are organized in a manner of a tree. Adding a TOC to
the root, which refers to a file which is located in a subfolder forms a
grid. Those TOCs are a bit confusing and thats why we get additional error
messages while building partial documentation::

  $ make SPHINXDIRS=process htmldocs
  ...
  checking consistency... Documentation/process/license-rules.rst: \
  WARNING: document isn't included in any toctree

To fix it, the *root-license-TOC* is replaced by a reference and the
'license-roles.txt' is added to the Documentation/process/index.rst TOC.

BTW: there was an old licences remark in Documentation/process/howto.rst which
is also updated, mentioning SPDX and pointing to the license-rules.rst

Signed-off-by: Markus Heiser <markus.heiser@darmarit.de>
---
 Documentation/index.rst                 |  5 +----
 Documentation/process/howto.rst         | 13 +++++++------
 Documentation/process/index.rst         |  1 +
 Documentation/process/license-rules.rst |  2 ++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 5d310d960f82..eb89d5877cea 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -22,10 +22,7 @@ The following describes the license of the Linux kernel source code
 (GPLv2), how to properly mark the license of individual files in the source
 tree, as well as links to the full license text.
 
-.. toctree::
-   :maxdepth: 2
-
-   process/license-rules.rst
+* :ref:`kernel_licensing`
 
 User-oriented documentation
 ---------------------------
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 130bf0f48875..9a3dc9b63e1b 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -57,12 +57,13 @@ of doing things.
 Legal Issues
 ------------
 
-The Linux kernel source code is released under the GPL.  Please see the
-file, COPYING, in the main directory of the source tree, for details on
-the license.  If you have further questions about the license, please
-contact a lawyer, and do not ask on the Linux kernel mailing list.  The
-people on the mailing lists are not lawyers, and you should not rely on
-their statements on legal matters.
+The Linux kernel source code is released under the GPL.  Please see the file
+COPYING in the main directory of the source tree. The Linux kernel licensing
+rules and how to use `SPDX <https://spdx.org/>`_ identifiers in source code is
+descibed in :ref:`Documentation/process/license-rules.rst <kernel_licensing>`.
+If you have further questions about the license, please contact a lawyer, and do
+not ask on the Linux kernel mailing list.  The people on the mailing lists are
+not lawyers, and you should not rely on their statements on legal matters.
 
 For common questions and answers about the GPL, please see:
 
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 37bd0628b6ee..c0b3bd25dbae 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -19,6 +19,7 @@ Below are the essential guides that every developer should read.
 .. toctree::
    :maxdepth: 1
 
+   license-rules
    howto
    code-of-conflict
    development-process
diff --git a/Documentation/process/license-rules.rst b/Documentation/process/license-rules.rst
index 8ea26325fe3f..2bb8c0fc2238 100644
--- a/Documentation/process/license-rules.rst
+++ b/Documentation/process/license-rules.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _kernel_licensing:
+
 Linux kernel licensing rules
 ============================
 
-- 
2.17.1

