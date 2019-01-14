Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE87C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF82F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EcpMw11E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfANDVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:21:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43410 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfANDVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 22:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7E5SGxR4bEFCBD6qxts7SUz99Ls5pIxf2mzpClj3tFc=; b=EcpMw11EDbVoqGWIK9JI29htv5
        wExni+kmKRyP5puw0uwogg/FBnHJ7tN4Osrp/H1Ds9MrotVC6+ywW2NPHqDNV4AnaZ9eSuD5pjhsm
        jGP9BgtYvzujoSMZ8fgQL4FbPO6efnAcdvwlzPRf598wYgBOTvvZ1iegaruPogQliow5qSfEXlC8H
        sW7A4HR+6MBgDKHhkT8SP4aUekPwItxR3pGfs5wAclfgCsn/CI+JjmpCGyKHEdMIMXP30MvOGAcME
        ssZ/vQDp9677Fz8IC/QM1OSomneOta8IOwJoz7WjZd8DLvmY3PJ2TqZHPWOE/lVB1c9NqOqOt8Dy8
        k74jqB1A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gisow-0000Vj-Nx; Mon, 14 Jan 2019 03:21:50 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Royer <seroyer@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: add ibmvmc to toctree(index) and fix warnings
Message-ID: <bd222e7e-33cd-37ce-f702-238a8e93dfc8@infradead.org>
Date:   Sun, 13 Jan 2019 19:21:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx warnings in ibmvmc.rst, add an index.rst file in
Documentation/misc-devices/, and insert that index file into the
top-level index file.

Documentation/misc-devices/ibmvmc.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
Documentation/misc-devices/ibmvmc.rst:: WARNING: document isn't included in any toctree

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Royer <seroyer@linux.ibm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/index.rst               |    1 +
 Documentation/misc-devices/ibmvmc.rst |    1 +
 Documentation/misc-devices/index.rst  |   17 +++++++++++++++++
 3 files changed, 19 insertions(+)

--- lnx-50-rc2.orig/Documentation/misc-devices/ibmvmc.rst
+++ lnx-50-rc2/Documentation/misc-devices/ibmvmc.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0+
+
 ======================================================
 IBM Virtual Management Channel Kernel Driver (IBMVMC)
 ======================================================
--- lnx-50-rc2.orig/Documentation/index.rst
+++ lnx-50-rc2/Documentation/index.rst
@@ -90,6 +90,7 @@ needed).
    filesystems/index
    vm/index
    bpf/index
+   misc-devices/index
 
 Architecture-specific documentation
 -----------------------------------
--- /dev/null
+++ lnx-50-rc2/Documentation/misc-devices/index.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+Assorted Miscellaneous Devices Documentation
+============================================
+
+This documentation contains information for assorted devices that do not
+fit into other categories.
+
+.. class:: toc-title
+
+	   Table of contents
+
+.. toctree::
+   :maxdepth: 2
+
+   ibmvmc


