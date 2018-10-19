Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A511AECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4252064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4252064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJSQZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:25:11 -0400
Received: from mailrelay101.isp.belgacom.be ([195.238.20.128]:36159 "EHLO
        mailrelay101.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbeJSQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:25:10 -0400
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3Ai2sxkhGDrLY2HQeD3JDb4p1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yrs+wAkXT6L1XgUPTWs2DsrQY07WQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDiwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VD?=
 =?us-ascii?q?K/5KlpVRDokj8KOT4n/m/KhMJ+j6VVrxCvpxFk34LYfJuYOOZkc6/BYd8XQ3?=
 =?us-ascii?q?dKUMZLVyxGB4Oxd4sBAPAaMuZZtYb9oUYFoxukBQayGezg1CVIhn7q0q05zu?=
 =?us-ascii?q?8sFg/G0xY7ENIAq3nUt9b1NacUUe+r0KnE1y7MYO1P1Dr79YPGcQghrOmPUL?=
 =?us-ascii?q?9ya8bcyEgiGxnHg1iUs4DpIjCY2+oLvmOG9eRvT/ivhHQiqwxppzivwdojhZ?=
 =?us-ascii?q?fRi4IOz1DE6T15wIEoJd2kUEJ7YcCrEJ9XtyyCM4t2Rd8tTHtsuCY6zb0Goo?=
 =?us-ascii?q?K7cDIOyJQg2xHQcfiHfJWP4hLmTumRIDF4iGpkeLK5mRmy7VCtx+7+W8Wu0V?=
 =?us-ascii?q?tHrzBJn9vIu3wXyhDe6caKRuN4/ki72DaP0w7T6vtDIUAxjafbJYQuzaU+lp?=
 =?us-ascii?q?cIqkTDHS/3mEPog6+KbEkr4fan5/z9Yrr6vp+cK5N0igbmP6s0mcy/GeE4Px?=
 =?us-ascii?q?MKX2ia/+S8ybLi8VT3QLVNk/02lLTWv4rGJcQaoa65BRVZ0oE56xawFz2mys?=
 =?us-ascii?q?gXnWEbLFJZfxKKl4rpNEvOIP/iF/e/gEqjkCxwyv/aJb3tGInCLn3ekLv7Y7?=
 =?us-ascii?q?ly9lNcwhIpzd9D/5JUFq0BIPXrV0Dts9zXEwU2PheozOb8EtlyyoYeWX+VDq?=
 =?us-ascii?q?CHLazSrEeC5vgzLOmUeI8VpDH9JuAh5/7vi385hFAccbCn3ZsMdX+3AOpmLF?=
 =?us-ascii?q?udYXf3nNcBHnkFvhAkQOzpllKCSzhTaGi2X64m4TE7Eo2mB5/ZRo+xmLyBwD?=
 =?us-ascii?q?u7HppOa2BCC1CMF2rodoqdV/cPdi2SOMlhnSIAVbW6VY8h2g+htBXgx7pkMO?=
 =?us-ascii?q?XU4CsYuozn1NRv4O3Tjx4y/yRuD8uBy2GNU310nmQQSj84xq9wukJ9x0yY0a?=
 =?us-ascii?q?h7g/1YE8Jc5+9TXgghK5GPh9B9XtnxQgfpetaPVUbjTNK7Bz04UtM2xZkJeU?=
 =?us-ascii?q?kuNc+li0Xt1iCrCrlduaaGCJEu86nflyz/Lsxz423Fxa8skx8sT50cZiWdmq?=
 =?us-ascii?q?dj+l2LVMbymEKDmvPyeA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AxAACMkslb/7dPQldjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgQh8gVMSKIwNX41+AYhQjgmBejgBhEAChQMiNA0NAQMBAQI?=
 =?us-ascii?q?BAQIBbCiCNiKCYgYnLyMQUTkeGYMhgXURp1ozg32GJ4cshDqBQT+BEY1qAoh?=
 =?us-ascii?q?pBJVUCYYhiksCFZApLJdpOIFVTSAYgyeCJheOHD0wgQMBPQGKMgEB?=
X-IPAS-Result: =?us-ascii?q?A2AxAACMkslb/7dPQldjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?Qh8gVMSKIwNX41+AYhQjgmBejgBhEAChQMiNA0NAQMBAQIBAQIBbCiCNiKCY?=
 =?us-ascii?q?gYnLyMQUTkeGYMhgXURp1ozg32GJ4cshDqBQT+BEY1qAohpBJVUCYYhiksCF?=
 =?us-ascii?q?ZApLJdpOIFVTSAYgyeCJheOHD0wgQMBPQGKMgEB?=
Received: from 183.79-66-87.adsl-dyn.isp.belgacom.be (HELO localhost.localdomain) ([87.66.79.183])
  by relay.skynet.be with ESMTP; 19 Oct 2018 10:20:06 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     akpm@linux-foundation.org
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fabf@skynet.be
Subject: [PATCH 1/7 linux-next] coda: remove CODA_FREE
Date:   Fri, 19 Oct 2018 10:19:27 +0200
Message-Id: <1539937173-26260-2-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1539937173-26260-1-git-send-email-fabf@skynet.be>
References: <1539937173-26260-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1d5cfdb07628
("tree wide: use kvfree() than conditional kfree()/vfree()")
size in CODA_FREE is no longer used and that macro
hides nothing more than kvfree()

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/coda/coda_linux.h |  2 --
 fs/coda/psdev.c      |  8 ++++----
 fs/coda/upcall.c     | 36 ++++++++++++++++++------------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index 126155c..903f2a3 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -73,8 +73,6 @@ void coda_sysctl_clean(void);
 } while (0)
 
 
-#define CODA_FREE(ptr, size) kvfree((ptr))
-
 /* inode to cnode access functions */
 
 static inline struct coda_inode_info *ITOC(struct inode *inode)
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index c5234c2..cbdddf4 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -126,7 +126,7 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 		}
 		CODA_ALLOC(dcbuf, union outputArgs *, nbytes);
 		if (copy_from_user(dcbuf, buf, nbytes)) {
-			CODA_FREE(dcbuf, nbytes);
+			kvfree(dcbuf);
 			retval = -EFAULT;
 			goto out;
 		}
@@ -134,7 +134,7 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 		/* what downcall errors does Venus handle ? */
 		error = coda_downcall(vcp, hdr.opcode, dcbuf);
 
-		CODA_FREE(dcbuf, nbytes);
+		kvfree(dcbuf);
 		if (error) {
 			pr_warn("%s: coda_downcall error: %d\n",
 				__func__, error);
@@ -257,7 +257,7 @@ static ssize_t coda_psdev_read(struct file * file, char __user * buf,
 		goto out;
 	}
 
-	CODA_FREE(req->uc_data, sizeof(struct coda_in_hdr));
+	kvfree(req->uc_data);
 	kfree(req);
 out:
 	mutex_unlock(&vcp->vc_mutex);
@@ -319,7 +319,7 @@ static int coda_psdev_release(struct inode * inode, struct file * file)
 
 		/* Async requests need to be freed here */
 		if (req->uc_flags & CODA_REQ_ASYNC) {
-			CODA_FREE(req->uc_data, sizeof(struct coda_in_hdr));
+			kvfree(req->uc_data);
 			kfree(req);
 			continue;
 		}
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 1175a17..d0d0fed 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -85,7 +85,7 @@ int venus_rootfid(struct super_block *sb, struct CodaFid *fidp)
 	if (!error)
 		*fidp = outp->coda_root.VFid;
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -104,7 +104,7 @@ int venus_getattr(struct super_block *sb, struct CodaFid *fid,
 	if (!error)
 		*attr = outp->coda_getattr.attr;
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -123,7 +123,7 @@ int venus_setattr(struct super_block *sb, struct CodaFid *fid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-        CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -153,7 +153,7 @@ int venus_lookup(struct super_block *sb, struct CodaFid *fid,
 		*type = outp->coda_lookup.vtype;
 	}
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -173,7 +173,7 @@ int venus_close(struct super_block *sb, struct CodaFid *fid, int flags,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -194,7 +194,7 @@ int venus_open(struct super_block *sb, struct CodaFid *fid,
 	if (!error)
 		*fh = outp->coda_open_by_fd.fh;
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }	
 
@@ -224,7 +224,7 @@ int venus_mkdir(struct super_block *sb, struct CodaFid *dirfid,
 		*newfid = outp->coda_mkdir.VFid;
 	}
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;        
 }
 
@@ -262,7 +262,7 @@ int venus_rename(struct super_block *sb, struct CodaFid *old_fid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -295,7 +295,7 @@ int venus_create(struct super_block *sb, struct CodaFid *dirfid,
 		*newfid = outp->coda_create.VFid;
 	}
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;        
 }
 
@@ -318,7 +318,7 @@ int venus_rmdir(struct super_block *sb, struct CodaFid *dirfid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -340,7 +340,7 @@ int venus_remove(struct super_block *sb, struct CodaFid *dirfid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -370,7 +370,7 @@ int venus_readlink(struct super_block *sb, struct CodaFid *fid,
 		*(buffer + retlen) = '\0';
 	}
 
-        CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -398,7 +398,7 @@ int venus_link(struct super_block *sb, struct CodaFid *fid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -433,7 +433,7 @@ int venus_symlink(struct super_block *sb, struct CodaFid *fid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -449,7 +449,7 @@ int venus_fsync(struct super_block *sb, struct CodaFid *fid)
 	inp->coda_fsync.VFid = *fid;
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -467,7 +467,7 @@ int venus_access(struct super_block *sb, struct CodaFid *fid, int mask)
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -543,7 +543,7 @@ int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
 	}
 
  exit:
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -565,7 +565,7 @@ int venus_statfs(struct dentry *dentry, struct kstatfs *sfs)
 		sfs->f_ffree  = outp->coda_statfs.stat.f_ffree;
 	}
 
-        CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
-- 
2.4.11

