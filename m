Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933032AbeBMAYd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:24:33 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:50513 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932994AbeBMAYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:24:30 -0500
X-Google-Smtp-Source: AH8x226b84sLfpTN++r5YZG9X3gOGngWbviWucholJgrsfVDAZKWZwj1hvgV+/Q17rcdhn0V1sszDw==
Date: Mon, 12 Feb 2018 16:24:28 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>
cc: Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: [patch 2/2] mm, page_alloc: move mirrored_kernelcore to
 __meminitdata
In-Reply-To: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.10.1802121623280.179479@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mirrored_kernelcore can be in __meminitdata, so move it there.

At the same time, fixup section specifiers to be after the name of the 
variable per checkpatch.
---
 mm/page_alloc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -264,19 +264,19 @@ int min_free_kbytes = 1024;
 int user_min_free_kbytes = -1;
 int watermark_scale_factor = 10;
 
-static unsigned long __meminitdata nr_kernel_pages;
-static unsigned long __meminitdata nr_all_pages;
-static unsigned long __meminitdata dma_reserve;
+static unsigned long nr_kernel_pages __meminitdata;
+static unsigned long nr_all_pages __meminitdata;
+static unsigned long dma_reserve __meminitdata;
 
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
-static unsigned long __meminitdata arch_zone_lowest_possible_pfn[MAX_NR_ZONES];
-static unsigned long __meminitdata arch_zone_highest_possible_pfn[MAX_NR_ZONES];
-static unsigned long __initdata required_kernelcore;
+static unsigned long arch_zone_lowest_possible_pfn[MAX_NR_ZONES] __meminitdata;
+static unsigned long arch_zone_highest_possible_pfn[MAX_NR_ZONES] __meminitdata;
+static unsigned long required_kernelcore __initdata;
 static unsigned long required_kernelcore_percent __initdata;
-static unsigned long __initdata required_movablecore;
+static unsigned long required_movablecore __initdata;
 static unsigned long required_movablecore_percent __initdata;
-static unsigned long __meminitdata zone_movable_pfn[MAX_NUMNODES];
-static bool mirrored_kernelcore;
+static unsigned long zone_movable_pfn[MAX_NUMNODES] __meminitdata;
+static bool mirrored_kernelcore __meminitdata;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
 int movable_zone;
