Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84F9C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC6E20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC6E20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeJBQqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:46:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJBQqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:46:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A20Lk1913272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:02:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A20uk1913269;
        Tue, 2 Oct 2018 03:02:00 -0700
Date:   Tue, 2 Oct 2018 03:02:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-9d92cfeaf5215158d26d2991be7f7ff865cb98f3@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        eranian@google.com, torvalds@linux-foundation.org,
        vincent.weaver@maine.edu, mingo@kernel.org, tglx@linutronix.de
Reply-To: jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@redhat.com,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, kan.liang@linux.intel.com,
          torvalds@linux-foundation.org, eranian@google.com,
          tglx@linutronix.de, mingo@kernel.org, vincent.weaver@maine.edu
In-Reply-To: <1537538826-55489-1-git-send-email-kan.liang@linux.intel.com>
References: <1537538826-55489-1-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Fix PCI BDF address of M3UPI
 on SKX
Git-Commit-ID: 9d92cfeaf5215158d26d2991be7f7ff865cb98f3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9d92cfeaf5215158d26d2991be7f7ff865cb98f3
Gitweb:     https://git.kernel.org/tip/9d92cfeaf5215158d26d2991be7f7ff865cb98f3
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Fri, 21 Sep 2018 07:07:06 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:38:02 +0200

perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on SKX

The counters on M3UPI Link 0 and Link 3 don't count properly, and writing
0 to these counters may causes system crash on some machines.

The PCI BDF addresses of the M3UPI in the current code are incorrect.

The correct addresses should be:

  D18:F1	0x204D
  D18:F2	0x204E
  D18:F5	0x204D

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Link: http://lkml.kernel.org/r/1537538826-55489-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snbep.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 53b981dcdb42..c07bee31abe8 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3931,16 +3931,16 @@ static const struct pci_device_id skx_uncore_pci_ids[] = {
 		.driver_data = UNCORE_PCI_DEV_FULL_DATA(21, 5, SKX_PCI_UNCORE_M2PCIE, 3),
 	},
 	{ /* M3UPI0 Link 0 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204C),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 0, SKX_PCI_UNCORE_M3UPI, 0),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 1, SKX_PCI_UNCORE_M3UPI, 0),
 	},
 	{ /* M3UPI0 Link 1 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 1, SKX_PCI_UNCORE_M3UPI, 1),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204E),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 2, SKX_PCI_UNCORE_M3UPI, 1),
 	},
 	{ /* M3UPI1 Link 2 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204C),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 4, SKX_PCI_UNCORE_M3UPI, 2),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 5, SKX_PCI_UNCORE_M3UPI, 2),
 	},
 	{ /* end: all zeroes */ }
 };
