Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD988C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F68A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F68A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbeIYSkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:40:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbeIYSkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:40:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67E967A9;
        Tue, 25 Sep 2018 05:33:18 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 980513F5BD;
        Tue, 25 Sep 2018 05:33:17 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     willy@infradead.org, jgg@mellanox.com, linux-kernel@vger.kernel.org
Subject: [PATCH] IDR: Add missing XArray include
Date:   Tue, 25 Sep 2018 13:30:20 +0100
Message-Id: <20180925123020.52407-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDR now exposes the XArray lock to users, and relies on the xa_* macros
defined in xarray.h. Include this header in idr.h.

Fixes: 3c60e868c31e ("IDR: Expose the XArray lock")
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/linux/idr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 3ec8628ce17f..3b835bf492ab 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -15,6 +15,7 @@
 #include <linux/radix-tree.h>
 #include <linux/gfp.h>
 #include <linux/percpu.h>
+#include <linux/xarray.h>
 
 struct idr {
 	struct radix_tree_root	idr_rt;
-- 
2.18.0

