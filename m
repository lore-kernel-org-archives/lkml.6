Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E971ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4AC2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4AC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbeGMRnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:43:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730017AbeGMRnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:43:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B04AE7A7F1;
        Fri, 13 Jul 2018 17:28:11 +0000 (UTC)
Received: from pdhamdhe.redhat.com (unknown [10.76.1.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E7E82026D6B;
        Fri, 13 Jul 2018 17:28:09 +0000 (UTC)
From:   Prashant Dhamdhere <pdhamdhe@redhat.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdhamdhe@redhat.com
Subject: [PATCH v2] Documentation: proc.txt: Adding 'HardwareCorrupted' field and description.
Date:   Fri, 13 Jul 2018 22:58:06 +0530
Message-Id: <20180713172806.17387-1-pdhamdhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 17:28:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 17:28:11 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pdhamdhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch talks about the 'HardwareCorrupted' field currently missing from
the 'meminfo' section of 'proc.txt' file. It also includes short description
of 'HardwareCorrupted' field.

Signed-off-by: Prashant Dhamdhere <pdhamdhe@redhat.com>
---
 Documentation/filesystems/proc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 520f6a84cf50..1605acbb23b6 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -870,6 +870,7 @@ Committed_AS:   100056 kB
 VmallocTotal:   112216 kB
 VmallocUsed:       428 kB
 VmallocChunk:   111088 kB
+HardwareCorrupted:   0 kB
 AnonHugePages:   49152 kB
 ShmemHugePages:      0 kB
 ShmemPmdMapped:      0 kB
@@ -915,6 +916,8 @@ MemAvailable: An estimate of how much memory is available for starting new
        Dirty: Memory which is waiting to get written back to the disk
    Writeback: Memory which is actively being written back to the disk
    AnonPages: Non-file backed pages mapped into userspace page tables
+HardwareCorrupted: The amount of RAM/memory in KB, the kernel identifies as
+	      corrupted.
 AnonHugePages: Non-file backed huge pages mapped into userspace page tables
       Mapped: files which have been mmaped, such as libraries
        Shmem: Total memory used by shared memory (shmem) and tmpfs
-- 
2.17.1

