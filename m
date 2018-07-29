Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF9C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8163620892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g74F+Qpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8163620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbeG2VJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:09:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45962 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbeG2VIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:36 -0400
Received: by mail-pl0-f65.google.com with SMTP id j8-v6so4501074pll.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pm57v/24+HRgbJ93VzFn1J9XogQIktPrn3/dYpTsnaY=;
        b=g74F+QpkiQpwMad8CoE5O4G2z9WQLYH/76cvGCgzxJmyzrlK4zI1Qjk2ycAadr44g9
         OSQeQotbKEFTKy6UNAXS6H1Vms1pwAvugbp85k08y5CFG8RKjXd6p2kUmUHXSdOwqPRx
         M4HpqMpcDoGXbji3IQraOZXp4GleXpiNuBcTbNqKR8CXHLaGI1kL9SGiJOYTojnU42PG
         kFRzPIRjGEIfPTXPQkDG1swo4fdYnRbAMT6ScIDMzPStKA9Aw8aC4M7YJ7DlFJkhlwl7
         G9mwefVesAjqSqdyR8jDjpjb2y95LS0/xnWDYGC2Xoz1j89JaJR7QI8y8Bm+JSOjKQ+E
         wcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pm57v/24+HRgbJ93VzFn1J9XogQIktPrn3/dYpTsnaY=;
        b=gQL3+ZiqYZG5F9BikrjZcHt6vfrRGr9WOrSpHapxY+bg9ZB1d4GEyhK/EmyllSI431
         X29GQKBCSPXXcq3aFh5XjvtLcnlmt2iG8WLsQKoor8GGnSFuHtm1YnhEOWgIHCbtMytL
         9QLbsZlmxHkNRYwoYDfQ6fJJ0c+A9dVKs9J4ch1qx/EXdkbPFIhNePdMoBUK+PU+puOA
         2+sdhaWocf2JFrZpkHzM31sVdK0chimzgxhWqShHiGSnbRFZ/jfd71OqFggDhnD6y2dG
         yRSnkKJn66RdGwX29AGBKpzVHlU5WCK9ZzSEyOfPlM3dp8k2UPL7RYhiv59L/gV41+AZ
         v+IQ==
X-Gm-Message-State: AOUpUlFpfIHWPH8mv5xJvSdUmCMoTRTvkL+u5ygWWJ0xdWIZcR6jRUJ6
        Xw5szW/NPchp+Sn1zZMLZwo=
X-Google-Smtp-Source: AAOMgpf//JEgi2AyYdiloAn00yXDtuFY7S736sx92BM23djDiRE6ndlsWK46cm8AoQ9fLUYO8pToOA==
X-Received: by 2002:a17:902:342:: with SMTP id 60-v6mr13741308pld.15.1532893024818;
        Sun, 29 Jul 2018 12:37:04 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:37:04 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 07/13] staging: gasket: ioctl: simplify comments for static functions
Date:   Sun, 29 Jul 2018 12:36:40 -0700
Message-Id: <20180729193646.201721-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Static functions don't need kernel doc formatting, can be simplified.
Reformat comments that can be single-line.  Remove extraneous text.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 51 +++++----------------------
 1 file changed, 9 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 78a132a60cc4f..55bdd7bfac866 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -170,14 +170,7 @@ long gasket_is_supported_ioctl(uint cmd)
 	}
 }
 
-/*
- * Permission checker for Gasket ioctls.
- * @filp: File structure pointer describing this node usage session.
- * @cmd: ioctl number to handle.
- *
- * Check permissions for Gasket ioctls.
- * Returns true if the file opener may execute this ioctl, or false otherwise.
- */
+/* Check permissions for Gasket ioctls. */
 static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 {
 	bool alive;
@@ -218,11 +211,7 @@ static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 	return false; /* unknown permissions */
 }
 
-/*
- * Associate an eventfd with an interrupt.
- * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @argp: Pointer to gasket_interrupt_eventfd struct in userspace.
- */
+/* Associate an eventfd with an interrupt. */
 static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
 			       struct gasket_interrupt_eventfd __user *argp)
 {
@@ -237,11 +226,7 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
 		gasket_dev->interrupt_data, die.interrupt, die.event_fd);
 }
 
-/*
- * Reads the size of the page table.
- * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @argp: Pointer to gasket_page_table_ioctl struct in userspace.
- */
+/* Read the size of the page table. */
 static int gasket_read_page_table_size(
 	struct gasket_dev *gasket_dev,
 	struct gasket_page_table_ioctl __user *argp)
@@ -268,11 +253,7 @@ static int gasket_read_page_table_size(
 	return ret;
 }
 
-/*
- * Reads the size of the simple page table.
- * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @argp: Pointer to gasket_page_table_ioctl struct in userspace.
- */
+/* Read the size of the simple page table. */
 static int gasket_read_simple_page_table_size(
 	struct gasket_dev *gasket_dev,
 	struct gasket_page_table_ioctl __user *argp)
@@ -299,11 +280,7 @@ static int gasket_read_simple_page_table_size(
 	return ret;
 }
 
-/*
- * Sets the boundary between the simple and extended page tables.
- * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @argp: Pointer to gasket_page_table_ioctl struct in userspace.
- */
+/* Set the boundary between the simple and extended page tables. */
 static int gasket_partition_page_table(
 	struct gasket_dev *gasket_dev,
 	struct gasket_page_table_ioctl __user *argp)
@@ -340,11 +317,7 @@ static int gasket_partition_page_table(
 	return ret;
 }
 
-/*
- * Maps a userspace buffer to a device virtual address.
- * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @argp: Pointer to a gasket_page_table_ioctl struct in userspace.
- */
+/* Map a userspace buffer to a device virtual address. */
 static int gasket_map_buffers(struct gasket_dev *gasket_dev,
 			      struct gasket_page_table_ioctl __user *argp)
 {
@@ -370,11 +343,7 @@ static int gasket_map_buffers(struct gasket_dev *gasket_dev,
 		ibuf.host_address, ibuf.device_address, ibuf.size / PAGE_SIZE);
 }
 
-/*
- * Unmaps a userspace buffer from a device virtual address.
- * @gasket_dev: Pointer to the current gasket_dev we're using.
- * @argp: Pointer to a gasket_page_table_ioctl struct in userspace.
- */
+/* Unmap a userspace buffer from a device virtual address. */
 static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
 				struct gasket_page_table_ioctl __user *argp)
 {
@@ -402,10 +371,8 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
 }
 
 /*
- * Tell the driver to reserve structures for coherent allocation, and allocate
- * or free the corresponding memory.
- * @dev: Pointer to the current gasket_dev we're using.
- * @argp: Pointer to a gasket_coherent_alloc_config_ioctl struct in userspace.
+ * Reserve structures for coherent allocation, and allocate or free the
+ * corresponding memory.
  */
 static int gasket_config_coherent_allocator(
 	struct gasket_dev *gasket_dev,
-- 
2.18.0.345.g5c9ce644c3-goog

