Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57F1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FA42146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FA42146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeLAFKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:10:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLAFKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:10:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFEBD307D982;
        Fri, 30 Nov 2018 18:00:37 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-126-156.rdu2.redhat.com [10.10.126.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26FAB6870A;
        Fri, 30 Nov 2018 18:00:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@linuxdriverproject.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Banman <andrew.banman@hpe.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Oscar Salvador <osalvador@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>
Subject: [PATCH RFCv2 4/4] mm/memory_hotplug: Drop MEMORY_TYPE_UNSPECIFIED
Date:   Fri, 30 Nov 2018 18:59:22 +0100
Message-Id: <20181130175922.10425-5-david@redhat.com>
In-Reply-To: <20181130175922.10425-1-david@redhat.com>
References: <20181130175922.10425-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 30 Nov 2018 18:00:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have proper types for all users, we can drop this one.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Banman <andrew.banman@hpe.com>
Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Suchánek <msuchanek@suse.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 3 ---
 include/linux/memory.h | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index c5fdca7a3009..a6e524f0ea38 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -388,9 +388,6 @@ static ssize_t type_show(struct device *dev, struct device_attribute *attr,
 	ssize_t len = 0;
 
 	switch (mem->type) {
-	case MEMORY_BLOCK_UNSPECIFIED:
-		len = sprintf(buf, "unspecified\n");
-		break;
 	case MEMORY_BLOCK_BOOT:
 		len = sprintf(buf, "boot\n");
 		break;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index a3a1e9764805..11679622f743 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -50,10 +50,6 @@ int set_memory_block_size_order(unsigned int order);
  *  No memory block is to be created (e.g. device memory). Not exposed to
  *  user space.
  *
- * MEMORY_BLOCK_UNSPECIFIED:
- *  The type of memory block was not further specified when adding the
- *  memory block.
- *
  * MEMORY_BLOCK_BOOT:
  *  This memory block was added during boot by the basic system. No
  *  specific device driver takes care of this memory block. This memory
@@ -103,7 +99,6 @@ int set_memory_block_size_order(unsigned int order);
  */
 enum {
 	MEMORY_BLOCK_NONE = 0,
-	MEMORY_BLOCK_UNSPECIFIED,
 	MEMORY_BLOCK_BOOT,
 	MEMORY_BLOCK_DIMM,
 	MEMORY_BLOCK_DIMM_UNREMOVABLE,
-- 
2.17.2

