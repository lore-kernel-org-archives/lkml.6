Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966362AbeBNBA5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:00:57 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:41443 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966258AbeBNBAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:00:54 -0500
X-Google-Smtp-Source: AH8x227F9YDCGtDlbcassCv0VSKxj+o8SSEEroqFho2pILI2bbfaw3MbUaRJ4SX2OegLIsTTjMzqGw==
Date: Tue, 13 Feb 2018 17:00:50 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
cc: Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: [patch -mm] mm, page_alloc: extend kernelcore and movablecore for
 percent fix
In-Reply-To: <alpine.DEB.2.10.1802131651140.69963@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.10.1802131700160.71590@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com> <a064d937-5746-3e14-bb63-5ff9d845a428@oracle.com> <alpine.DEB.2.10.1802131651140.69963@chino.kir.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify that movablecore= can use a percent value.

Remove comment about hugetlb pages not being movable per Mike.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 .../admin-guide/kernel-parameters.txt         | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1837,10 +1837,9 @@
 
 			ZONE_MOVABLE is used for the allocation of pages that
 			may be reclaimed or moved by the page migration
-			subsystem.  This means that HugeTLB pages may not be
-			allocated from this zone.  Note that allocations like
-			PTEs-from-HighMem still use the HighMem zone if it
-			exists, and the Normal zone if it does not.
+			subsystem.  Note that allocations like PTEs-from-HighMem
+			still use the HighMem zone if it exists, and the Normal
+			zone if it does not.
 
 			It is possible to specify the exact amount of memory in
 			the form of "nn[KMGTPE]", a percentage of total system
@@ -2353,13 +2352,14 @@
 	mousedev.yres=	[MOUSE] Vertical screen resolution, used for devices
 			reporting absolute coordinates, such as tablets
 
-	movablecore=nn[KMG]	[KNL,X86,IA-64,PPC] This parameter
-			is similar to kernelcore except it specifies the
-			amount of memory used for migratable allocations.
-			If both kernelcore and movablecore is specified,
-			then kernelcore will be at *least* the specified
-			value but may be more. If movablecore on its own
-			is specified, the administrator must be careful
+	movablecore=	[KNL,X86,IA-64,PPC]
+			Format: nn[KMGTPE] | nn%
+			This parameter is the complement to kernelcore=, it
+			specifies the amount of memory used for migratable
+			allocations.  If both kernelcore and movablecore is
+			specified, then kernelcore will be at *least* the
+			specified value but may be more.  If movablecore on its
+			own is specified, the administrator must be careful
 			that the amount of memory usable for all allocations
 			is not too small.
 
