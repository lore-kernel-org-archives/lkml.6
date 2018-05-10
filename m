Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966388AbeEJPrj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:47:39 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:38828 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966472AbeEJPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:34 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1345:1359:1381:1437:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3867:4419:5007:6261:6642:7974:10004:10848:11026:11473:11658:11914:12294:12296:12438:12555:12895:13069:13311:13357:14181:14384:14394:14721:21080:21433:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: rest75_1c1af07d16c36
X-Filterd-Recvd-Size: 2276
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 14/18] lib/mpi: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:40 -0700
Message-Id: <d830dbbb914568890f02c99ea6bf71fdd207e3c6.1525964385.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 lib/mpi/mpicoder.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
index eead4b339466..8cd6ea3fbb3d 100644
--- a/lib/mpi/mpicoder.c
+++ b/lib/mpi/mpicoder.c
@@ -47,7 +47,7 @@ MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes)
 
 	nbits = nbytes * 8;
 	if (nbits > MAX_EXTERN_MPI_BITS) {
-		pr_info("MPI: mpi too large (%u bits)\n", nbits);
+		pr_info("mpi too large (%u bits)\n", nbits);
 		return NULL;
 	}
 	if (nbytes > 0)
@@ -89,14 +89,14 @@ MPI mpi_read_from_buffer(const void *xbuffer, unsigned *ret_nread)
 	nbits = buffer[0] << 8 | buffer[1];
 
 	if (nbits > MAX_EXTERN_MPI_BITS) {
-		pr_info("MPI: mpi too large (%u bits)\n", nbits);
+		pr_info("mpi too large (%u bits)\n", nbits);
 		return ERR_PTR(-EINVAL);
 	}
 
 	nbytes = DIV_ROUND_UP(nbits, 8);
 	if (nbytes + 2 > *ret_nread) {
-		pr_info("MPI: mpi larger than buffer nbytes=%u ret_nread=%u\n",
-				nbytes, *ret_nread);
+		pr_info("mpi larger than buffer nbytes=%u ret_nread=%u\n",
+			nbytes, *ret_nread);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -369,7 +369,7 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
 	nbits = nbytes * 8;
 	if (nbits > MAX_EXTERN_MPI_BITS) {
 		sg_miter_stop(&miter);
-		pr_info("MPI: mpi too large (%u bits)\n", nbits);
+		pr_info("mpi too large (%u bits)\n", nbits);
 		return NULL;
 	}
 
-- 
2.15.0
