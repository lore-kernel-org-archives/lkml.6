Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D0CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB3D2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b/9icR7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436733AbfBNIis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:38:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59608 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388545AbfBNIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:38:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E8XqHN063543;
        Thu, 14 Feb 2019 08:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=ONw4NsU+NXZKPn+byl+L/TMB3iD6CO1rsuQj/oH32jA=;
 b=b/9icR7KhTLQfO0hcBbgAGfobI7pd1TkxOZxDExjElvAeSmeDE5zpSIBA0crbgeM9wiV
 uhUNLK2AYtidaF6BHFyxXBN9XXSGXaoIqU+pw/4+L+YdSz/ZE7LCS2cCR0oov8hDg2sA
 05zZ8f/4WI52EA/vUGdXJBcg2eELQk+0/FBrBY8+Av8wJYJaFAYZkNyzJbBLbR+djFuc
 DKk9Gjokxn26tm/57eZsuDxdRKzR5uRIE6orOtbpXfbz0/bttc3B64fsJahgFIELK7PG
 9Bugg0Dhu3n7fE8AmwgSk871EnfD8Sdly02cPDA3T8Qf12myPlQf3F15PseEJpSQxV3F 8w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qhrekpj2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 08:38:35 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E8cY0l009287
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 08:38:34 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E8cXIr029327;
        Thu, 14 Feb 2019 08:38:33 GMT
Received: from kadam (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 00:38:32 -0800
Date:   Thu, 14 Feb 2019 11:38:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     coda@cs.cmu.edu, codalist@telemann.coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH 2] coda: get rid of CODA_FREE()
Message-ID: <20190214083822.GA28623@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902140804170.2466@hadrien>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CODA_FREE() macro just calls kvfree().  We can call that directly
instead.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/coda/coda_linux.h |  2 --
 fs/coda/psdev.c      |  8 ++++----
 fs/coda/upcall.c     | 36 ++++++++++++++++++------------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index 1ea9521e79d7..517a363245c9 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -63,8 +63,6 @@ unsigned short coda_flags_to_cflags(unsigned short);
 void coda_sysctl_init(void);
 void coda_sysctl_clean(void);
 
-#define CODA_FREE(ptr, size) kvfree((ptr))
-
 /* inode to cnode access functions */
 
 static inline struct coda_inode_info *ITOC(struct inode *inode)
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 49d44a485c9a..decfbfda6bc4 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -130,7 +130,7 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 		if (copy_from_user(dcbuf, buf, nbytes)) {
-			CODA_FREE(dcbuf, nbytes);
+			kvfree(dcbuf);
 			retval = -EFAULT;
 			goto out;
 		}
@@ -138,7 +138,7 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 		/* what downcall errors does Venus handle ? */
 		error = coda_downcall(vcp, hdr.opcode, dcbuf);
 
-		CODA_FREE(dcbuf, nbytes);
+		kvfree(dcbuf);
 		if (error) {
 			pr_warn("%s: coda_downcall error: %d\n",
 				__func__, error);
@@ -261,7 +261,7 @@ static ssize_t coda_psdev_read(struct file * file, char __user * buf,
 		goto out;
 	}
 
-	CODA_FREE(req->uc_data, sizeof(struct coda_in_hdr));
+	kvfree(req->uc_data);
 	kfree(req);
 out:
 	mutex_unlock(&vcp->vc_mutex);
@@ -323,7 +323,7 @@ static int coda_psdev_release(struct inode * inode, struct file * file)
 
 		/* Async requests need to be freed here */
 		if (req->uc_flags & CODA_REQ_ASYNC) {
-			CODA_FREE(req->uc_data, sizeof(struct coda_in_hdr));
+			kvfree(req->uc_data);
 			kfree(req);
 			continue;
 		}
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 203f029bcdc3..9fa12118f1bc 100644
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
2.17.1

