Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC94C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89A32190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378914;
	bh=zG6uJLl6gi0R7ZQZJVG4gL/fedY3fZXjBR2w/yWAFts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TbsDdHuxqraPU5nuQ4P0ve5kQMgKUK6JsMoVfEBiHtVQR0ynMLMc24CHi4/L+yecT
	 r3unq2ChT6PYRAYX62Tya4FHqWnwacBBd26c43gnMgUZvaeVSkeX2iVeqW9X2T/gpr
	 OgLO/7FUWdaRs7G5qdujbqUICWVtDJpp5mrIv4q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbeLUHzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:55:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730539AbeLUHzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:55:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8122321908;
        Fri, 21 Dec 2018 07:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378911;
        bh=zG6uJLl6gi0R7ZQZJVG4gL/fedY3fZXjBR2w/yWAFts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0Xph9eoREmKXrEKrXzcKmDLVh8wvrGaUpTEy/Sh1Wx1TzVprslwlI2byOvoTEgvB
         yaafMaQiXAb0aIYdozsk3FeVc3tyDr4hBV2UASwtGtvZ4psBT0WT+srcvY4hXZrv/4
         0y0loeXQVSG4PhwIaxs3vHcQ2dYSz9IAQ9VfvJNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 08/10] Documentation: driver core: remove use of BUS_ATTR
Date:   Fri, 21 Dec 2018 08:54:40 +0100
Message-Id: <20181221075442.17109-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221075442.17109-1-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are getting rid of the "raw" BUS_ATTR() macro, so fix up the
documentation to not refer to it anymore.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-model/bus.txt  | 8 ++++----
 Documentation/filesystems/sysfs.txt | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-model/bus.txt b/Documentation/driver-model/bus.txt
index b577a45b93ea..c247b488a567 100644
--- a/Documentation/driver-model/bus.txt
+++ b/Documentation/driver-model/bus.txt
@@ -124,11 +124,11 @@ struct bus_attribute {
 	ssize_t (*store)(struct bus_type *, const char * buf, size_t count);
 };
 
-Bus drivers can export attributes using the BUS_ATTR macro that works
-similarly to the DEVICE_ATTR macro for devices. For example, a definition 
-like this:
+Bus drivers can export attributes using the BUS_ATTR_RW macro that works
+similarly to the DEVICE_ATTR_RW macro for devices. For example, a
+definition like this:
 
-static BUS_ATTR(debug,0644,show_debug,store_debug);
+static BUS_ATTR_RW(debug);
 
 is equivalent to declaring:
 
diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.txt
index a1426cabcef1..41411b0c60a3 100644
--- a/Documentation/filesystems/sysfs.txt
+++ b/Documentation/filesystems/sysfs.txt
@@ -344,7 +344,9 @@ struct bus_attribute {
 
 Declaring:
 
-BUS_ATTR(_name, _mode, _show, _store)
+static BUS_ATTR_RW(name);
+static BUS_ATTR_RO(name);
+static BUS_ATTR_WO(name);
 
 Creation/Removal:
 
-- 
2.20.1

