Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823A0C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD7320693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD7320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeFTANF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:13:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeFTANC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:13:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0Cti93296139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:12:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0Ct8X3296136;
        Tue, 19 Jun 2018 17:12:55 -0700
Date:   Tue, 19 Jun 2018 17:12:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-83c258a428647a19d5928b9db38b0f8eebdf5cf1@git.kernel.org>
Cc:     reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: reinette.chatre@intel.com, mingo@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <cc1e6234f80e07eef65529bd6c25db0a688bba12.1527593970.git.reinette.chatre@intel.com>
References: <cc1e6234f80e07eef65529bd6c25db0a688bba12.1527593970.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Document new mode, size, and
 bit_usage
Git-Commit-ID: 83c258a428647a19d5928b9db38b0f8eebdf5cf1
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

Commit-ID:  83c258a428647a19d5928b9db38b0f8eebdf5cf1
Gitweb:     https://git.kernel.org/tip/83c258a428647a19d5928b9db38b0f8eebdf5cf1
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:26 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:27 +0200

x86/intel_rdt: Document new mode, size, and bit_usage

By default resource groups allow sharing of their cache allocations.  There
is nothing that prevents a resource group from configuring a cache
allocation that overlaps with that of an existing resource group.

To enable resource groups to specify that their cache allocations cannot be
shared a resource group "mode" is introduced to support two possible modes:
"shareable" and "exclusive". A "shareable" resource group allows sharing of
its cache allocations, an "exclusive" resource group does not. A new
resctrl file "mode" associated with each resource group is used to
communicate its (the associated resource group's) mode setting and allow
the mode to be changed.  The new "mode" file as well as two other resctrl
files, "bit_usage" and "size", are introduced in this series.

Add documentation for the three new resctrl files as well as one example
demonstrating their use.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/cc1e6234f80e07eef65529bd6c25db0a688bba12.1527593970.git.reinette.chatre@intel.com

---
 Documentation/x86/intel_rdt_ui.txt | 99 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index a16aa2113840..de913e00e922 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -65,6 +65,27 @@ related to allocation:
 			some platforms support devices that have their
 			own settings for cache use which can over-ride
 			these bits.
+"bit_usage":		Annotated capacity bitmasks showing how all
+			instances of the resource are used. The legend is:
+			"0" - Corresponding region is unused. When the system's
+			      resources have been allocated and a "0" is found
+			      in "bit_usage" it is a sign that resources are
+			      wasted.
+			"H" - Corresponding region is used by hardware only
+			      but available for software use. If a resource
+			      has bits set in "shareable_bits" but not all
+			      of these bits appear in the resource groups'
+			      schematas then the bits appearing in
+			      "shareable_bits" but no resource group will
+			      be marked as "H".
+			"X" - Corresponding region is available for sharing and
+			      used by hardware and software. These are the
+			      bits that appear in "shareable_bits" as
+			      well as a resource group's allocation.
+			"S" - Corresponding region is used by software
+			      and available for sharing.
+			"E" - Corresponding region is used exclusively by
+			      one resource group. No sharing allowed.
 
 Memory bandwitdh(MB) subdirectory contains the following files
 with respect to allocation:
@@ -163,6 +184,16 @@ When control is enabled all CTRL_MON groups will also contain:
 	A list of all the resources available to this group.
 	Each resource has its own line and format - see below for details.
 
+"size":
+	Mirrors the display of the "schemata" file to display the size in
+	bytes of each allocation instead of the bits representing the
+	allocation.
+
+"mode":
+	The "mode" of the resource group dictates the sharing of its
+	allocations. A "shareable" resource group allows sharing of its
+	allocations while an "exclusive" resource group does not.
+
 When monitoring is enabled all MON groups will also contain:
 
 "mon_data":
@@ -502,7 +533,71 @@ siblings and only the real time threads are scheduled on the cores 4-7.
 
 # echo F0 > p0/cpus
 
-4) Locking between applications
+Example 4
+---------
+
+The resource groups in previous examples were all in the default "shareable"
+mode allowing sharing of their cache allocations. If one resource group
+configures a cache allocation then nothing prevents another resource group
+to overlap with that allocation.
+
+In this example a new exclusive resource group will be created on a L2 CAT
+system with two L2 cache instances that can be configured with an 8-bit
+capacity bitmask. The new exclusive resource group will be configured to use
+25% of each cache instance.
+
+# mount -t resctrl resctrl /sys/fs/resctrl/
+# cd /sys/fs/resctrl
+
+First, we observe that the default group is configured to allocate to all L2
+cache:
+
+# cat schemata
+L2:0=ff;1=ff
+
+We could attempt to create the new resource group at this point, but it will
+fail because of the overlap with the schemata of the default group:
+# mkdir p0
+# echo 'L2:0=0x3;1=0x3' > p0/schemata
+# cat p0/mode
+shareable
+# echo exclusive > p0/mode
+-sh: echo: write error: Invalid argument
+# cat info/last_cmd_status
+schemata overlaps
+
+To ensure that there is no overlap with another resource group the default
+resource group's schemata has to change, making it possible for the new
+resource group to become exclusive.
+# echo 'L2:0=0xfc;1=0xfc' > schemata
+# echo exclusive > p0/mode
+# grep . p0/*
+p0/cpus:0
+p0/mode:exclusive
+p0/schemata:L2:0=03;1=03
+p0/size:L2:0=262144;1=262144
+
+A new resource group will on creation not overlap with an exclusive resource
+group:
+# mkdir p1
+# grep . p1/*
+p1/cpus:0
+p1/mode:shareable
+p1/schemata:L2:0=fc;1=fc
+p1/size:L2:0=786432;1=786432
+
+The bit_usage will reflect how the cache is used:
+# cat info/L2/bit_usage
+0=SSSSSSEE;1=SSSSSSEE
+
+A resource group cannot be forced to overlap with an exclusive resource group:
+# echo 'L2:0=0x1;1=0x1' > p1/schemata
+-sh: echo: write error: Invalid argument
+# cat info/last_cmd_status
+overlaps with exclusive group
+
+Locking between applications
+----------------------------
 
 Certain operations on the resctrl filesystem, composed of read/writes
 to/from multiple files, must be atomic.
@@ -510,7 +605,7 @@ to/from multiple files, must be atomic.
 As an example, the allocation of an exclusive reservation of L3 cache
 involves:
 
-  1. Read the cbmmasks from each directory
+  1. Read the cbmmasks from each directory or the per-resource "bit_usage"
   2. Find a contiguous set of bits in the global CBM bitmask that is clear
      in any of the directory cbmmasks
   3. Create a new directory
