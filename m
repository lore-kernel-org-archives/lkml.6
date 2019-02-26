Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950382173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162102;
	bh=dkIhAle8qX76xmaTiBwFHb7qvyHAQhRDuefdwArOvsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Br9+2Gq80mgvEATg7kwlQf43R/8IhMdquyN4mloBYWgWe84PalNkPTE1ETrTYuVT/
	 WyYBob6d91bchGSUlKMoOoFo1cxd1tj7LaVmrSntGFTjbfsfjuq9g6zVvV8uJxrn2Q
	 8dGZ3LLPtPuzatb4FeY+2Eq7EofvvSg8NEeBUDMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfBZGVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:21:41 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34442 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfBZGU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:26 -0500
Received: by mail-io1-f68.google.com with SMTP id e1so9654243iok.1;
        Mon, 25 Feb 2019 22:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=J4b7TkIYUMmkQjs+CQkshNUOKz4889qj9fmJ7q/gBYo=;
        b=MMeKIz/mUkEOpqYtzBJYRSMu5lV61kS5RDQy5d3vk/m3Pu4ipqIJ7xV9K2sSWpkd5g
         GSm5B7Oerpj4WSklwqAg/R5+lIBm58aB3bGiX5iNz1rxEZAUNkjUcTo6a7/pOFJ77k5f
         pNey1qoQ3gcheRMjfe87PJ9WeH66QvXPgyanjloamO/urmklqGdeBykvvBj0qcrs+obI
         HDpvQDgORTkcqqFr5HgBbTahd2UPo+drWEcwDpsjOBc2Ap0bDfPmkVm0tXIL+H2vm2X/
         POY0ux+I0eJeOLHjlWFYTo3TcmVouDXsFD/OzR90OXLXKr8hhs90KdVq3GYtBmKB696c
         Wf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=J4b7TkIYUMmkQjs+CQkshNUOKz4889qj9fmJ7q/gBYo=;
        b=mmcZibeyWNf4SUzC68WM7o5ZFz7E3Vxu/6sCSE2zyFVetiltS29Kl9RDp8mmTlqzdb
         YEHip7eUmQhvE63RwZCvfGi73bphmCSaai3x3R+IFSW0hByKf2e/Q4+1m7+xhKgsP64Y
         RYNTPuSMONrUnXq/ys4mIAEq8V0K0vA5HmxvgGLv8VIYVljpM+brlhLBIaEul2Kig7wt
         JpfIZCdzAqi2JdXiCeSyioiSpb5wlt/wD6ic8H5Q///GgzG7mOHNkyhaEhDmA5ln5gl6
         8eE1FohLT0Gq/Fo5CaragNE5HsBf6xVlC36DX75aDXjERpnTTT21ydc9qlkpkQEAMFfy
         xPug==
X-Gm-Message-State: AHQUAuYgwLoaAWT0RwkWqoX/OR6ji42kc04OafyYTJ6kad4C0AUqfk4a
        pMFP3eSl2t0H8TbU7mRe/SA=
X-Google-Smtp-Source: AHgI3IbWV3KaSTz+bh9KdpXpaOuLgu67dBExXcNV3gDuTkcdEwf2C2hX2W1AWarviCvf7FtQzNpXPQ==
X-Received: by 2002:a6b:6b0e:: with SMTP id g14mr12622938ioc.120.1551162025415;
        Mon, 25 Feb 2019 22:20:25 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:24 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 02/14] topolgy: Simplify cputopology.txt formatting and wording
Date:   Tue, 26 Feb 2019 01:20:00 -0500
Message-Id: <1ca56f8ea922a67f0017bd645912ea02a65a85ec.1551160674.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax only, no functional or semantic change.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/cputopology.txt | 46 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index c6e7e9196a8b..cb61277e2308 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -3,79 +3,79 @@ How CPU topology info is exported via sysfs
 ===========================================
 
 Export CPU topology info via sysfs. Items (attributes) are similar
-to /proc/cpuinfo output of some architectures:
+to /proc/cpuinfo output of some architectures.  They reside in
+/sys/devices/system/cpu/cpuX/topology/:
 
-1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
+physical_package_id:
 
 	physical package id of cpuX. Typically corresponds to a physical
 	socket number, but the actual value is architecture and platform
 	dependent.
 
-2) /sys/devices/system/cpu/cpuX/topology/core_id:
+core_id:
 
 	the CPU core ID of cpuX. Typically it is the hardware platform's
 	identifier (rather than the kernel's).  The actual value is
 	architecture and platform dependent.
 
-3) /sys/devices/system/cpu/cpuX/topology/book_id:
+book_id:
 
 	the book ID of cpuX. Typically it is the hardware platform's
 	identifier (rather than the kernel's).	The actual value is
 	architecture and platform dependent.
 
-4) /sys/devices/system/cpu/cpuX/topology/drawer_id:
+drawer_id:
 
 	the drawer ID of cpuX. Typically it is the hardware platform's
 	identifier (rather than the kernel's).	The actual value is
 	architecture and platform dependent.
 
-5) /sys/devices/system/cpu/cpuX/topology/thread_siblings:
+thread_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	core as cpuX.
 
-6) /sys/devices/system/cpu/cpuX/topology/thread_siblings_list:
+thread_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	core as cpuX.
 
-7) /sys/devices/system/cpu/cpuX/topology/core_siblings:
+core_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	physical_package_id.
 
-8) /sys/devices/system/cpu/cpuX/topology/core_siblings_list:
+core_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	physical_package_id.
 
-9) /sys/devices/system/cpu/cpuX/topology/book_siblings:
+book_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	book_id.
 
-10) /sys/devices/system/cpu/cpuX/topology/book_siblings_list:
+book_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	book_id.
 
-11) /sys/devices/system/cpu/cpuX/topology/drawer_siblings:
+drawer_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	drawer_id.
 
-12) /sys/devices/system/cpu/cpuX/topology/drawer_siblings_list:
+drawer_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	drawer_id.
 
-To implement it in an architecture-neutral way, a new source file,
-drivers/base/topology.c, is to export the 6 to 12 attributes. The book
-and drawer related sysfs files will only be created if CONFIG_SCHED_BOOK
-and CONFIG_SCHED_DRAWER are selected.
+Architecture-neutral, drivers/base/topology.c, exports these attributes.
+However, the book and drawer related sysfs files will only be created if
+CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
 
-CONFIG_SCHED_BOOK and CONFIG_DRAWER are currently only used on s390, where
-they reflect the cpu and cache hierarchy.
+CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
+where they reflect the cpu and cache hierarchy.
 
 For an architecture to support this feature, it must define some of
 these macros in include/asm-XXX/topology.h::
@@ -98,10 +98,10 @@ To be consistent on all architectures, include/linux/topology.h
 provides default definitions for any of the above macros that are
 not defined by include/asm-XXX/topology.h:
 
-1) physical_package_id: -1
-2) core_id: 0
-3) sibling_cpumask: just the given CPU
-4) core_cpumask: just the given CPU
+1) topology_physical_package_id: -1
+2) topology_core_id: 0
+3) topology_sibling_cpumask: just the given CPU
+4) topology_core_cpumask: just the given CPU
 
 For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
 default definitions for topology_book_id() and topology_book_cpumask().
-- 
2.18.0-rc0

