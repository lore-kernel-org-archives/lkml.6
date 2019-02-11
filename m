Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A40C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909CD2080F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfCgJXnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfBKWiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:38:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42058 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfBKWiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:38:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id n74so242175pfi.9;
        Mon, 11 Feb 2019 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JQuk6gaSYidWAupxn52YYTluQwwumv4EPvoIuLpowtU=;
        b=RfCgJXnCWdzS85qc+00rbkQDV/XnUQ1VaAfLf8i3nuoe8inm5OLyShnpZlhkyfAWP1
         3DnWa1PRbN5mm+IkXdFI7aVTXZ50NsxytPM1ifPjOnYbQst+S35h28QhomH+2gS0br2w
         xiZM2zvuS5pDuPhFdqFNK//g9BV8T0XGwb19YKXtKtNbbm4fl3qGzB69i6WXi85aMQKO
         Hd3IDGv2kqj5RTIUOL7jXmfEKhpC/DeSSJmG+8d5F/q39vwPRQ69VjM2ocxDZKLDhmbE
         fC3hT4ZaIJOpHOQQscC5Hx/y0MSSLIIPS3jamaOA0H+e9ol+MLsU1xFnCCXYERR04UQ1
         +d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JQuk6gaSYidWAupxn52YYTluQwwumv4EPvoIuLpowtU=;
        b=JXyoz6chehH1aQzI6KgbTrfFjPGMV2udaYYF02383bA4jbPzDQZYM2cSNQ5nwy2mN1
         o9YjacWDmBtUaTeyD2W8aW+KJQCIRrpPH3NIIfy+D2y7QMfdPj/AAhla/0X9gH19NAt6
         AL1PqjXJ+EAJFyKUvAeTfoDLw5bxiWnVW5kOTMKRRaaFbHwqmbe+XYu7ZAaGodtB+1MV
         L75xbtUiehQ1zxy4tXGzDgRRwU1A92gfMJLFOG6WrKOC5wi1u9gbalOBwYTltGyLQV4n
         x8ZQ4xy4y6HwiU9jJw2K51EL3xnLMws1KbTiXDZ99TuJv2nXbuGQ/z7uzKVoeYAvQ9Io
         xEyA==
X-Gm-Message-State: AHQUAuaypTSNAAOkBg/Y9aDfT5sfU5Ut2suHix9a9s9PVm+7bObsklUb
        4X26iugoQhVIWNA16UAm+dk=
X-Google-Smtp-Source: AHgI3IZRVjTNPdMXIoDgwoxFPgjsDMfUUsh4/IV90ummd7I2jVERh9++6zH3rcxT7jc/wXmxUNFJWw==
X-Received: by 2002:a62:62c5:: with SMTP id w188mr630010pfb.160.1549924729501;
        Mon, 11 Feb 2019 14:38:49 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id z186sm15275018pfz.119.2019.02.11.14.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 14:38:48 -0800 (PST)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Joris Gutjahr <joris.gutjahr@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: kernel-doc: typo "if ... if" -> "if ... is"
Date:   Mon, 11 Feb 2019 14:38:04 -0800
Message-Id: <1549924684-2148-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

"If no *function* if specified" should instead be
"If no *function* is specified".

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/doc-guide/kernel-doc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 6513c16b7e4f..f96059767c8c 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -490,7 +490,7 @@ doc: *title*
 
 functions: *[ function ...]*
   Include documentation for each *function* in *source*.
-  If no *function* if specified, the documentation for all functions
+  If no *function* is specified, the documentation for all functions
   and types in the *source* will be included.
 
   Examples::
-- 
Frank Rowand <frank.rowand@sony.com>

