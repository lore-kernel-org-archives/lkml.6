Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FFFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7681222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KqB6JR8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437085AbfBNHA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:00:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51512 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405695AbfBNHA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:00:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E6wr4O190991;
        Thu, 14 Feb 2019 06:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=MpQOphZSTrSP34GgxJOpR5YSzdoktek9Tb0ZNo8Ds+w=;
 b=KqB6JR8+23mL6M0fVythqeV55lrf8A71gB8zCLs+oqZsYQtrMKehmC+F1whhO9UVkzbD
 PQgt+iclTPCypkrNeEo1d6xXnxF3bi5jhPdg70qReq/Qw5HXdCcc8hKduDv9JEOzuSvP
 RCo8k94Yu2Wvg3rr7tdDD7udfrOvbsEVOWSZoc1QeBajcvBVghPItyM44PJRv1tfYQ1n
 rvcaBVi4claR1i5f8ZgtrogO2rfcO8g/3IKEhUy+eVC6wnn/7KWm3+Jr8tczOlvcgy8p
 gVN9e4OcEM3HWgFxRbm8GQwB3BBTdZZX2g93QmgA7goD2Fw6YMwk1KaKmCH2SUwATKtx LA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qhree6770-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 06:58:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E6wwoY028827
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 06:58:58 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E6wu9Z012923;
        Thu, 14 Feb 2019 06:58:57 GMT
Received: from kadam (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 22:58:56 -0800
Date:   Thu, 14 Feb 2019 09:58:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     coda@cs.cmu.edu, codalist@telemann.coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/coda: get rid of CODA_ALLOC()
Message-ID: <20190214065848.GB21768@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=977 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These days we have kvzalloc() so we can delete CODA_ALLOC().

I made a couple related changes in coda_psdev_write().  First, I
added some error handling to avoid a NULL dereference if the allocation
failed.  Second, I used kvmalloc() instead of kvzalloc() because we
copy over the memory on the next line so there is no need to zero it
first.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/coda/coda_linux.h | 10 ----------
 fs/coda/psdev.c      |  6 +++++-
 fs/coda/upcall.c     |  4 ++--
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index 126155cadfa9..1ea9521e79d7 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -63,16 +63,6 @@ unsigned short coda_flags_to_cflags(unsigned short);
 void coda_sysctl_init(void);
 void coda_sysctl_clean(void);
 
-#define CODA_ALLOC(ptr, cast, size) do { \
-    if (size < PAGE_SIZE) \
-        ptr = kzalloc((unsigned long) size, GFP_KERNEL); \
-    else \
-        ptr = (cast)vzalloc((unsigned long) size); \
-    if (!ptr) \
-	pr_warn("kernel malloc returns 0 at %s:%d\n", __FILE__, __LINE__); \
-} while (0)
-
-
 #define CODA_FREE(ptr, size) kvfree((ptr))
 
 /* inode to cnode access functions */
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index c5234c21b539..49d44a485c9a 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -124,7 +124,11 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 				hdr.opcode, hdr.unique);
 		        nbytes = size;
 		}
-		CODA_ALLOC(dcbuf, union outputArgs *, nbytes);
+		dcbuf = kvmalloc(nbytes, GFP_KERNEL);
+		if (!dcbuf) {
+			retval = -ENOMEM;
+			goto out;
+		}
 		if (copy_from_user(dcbuf, buf, nbytes)) {
 			CODA_FREE(dcbuf, nbytes);
 			retval = -EFAULT;
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 1175a1722411..203f029bcdc3 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -46,7 +46,7 @@ static void *alloc_upcall(int opcode, int size)
 {
 	union inputArgs *inp;
 
-	CODA_ALLOC(inp, union inputArgs *, size);
+	inp = kvzalloc(size, GFP_KERNEL);
         if (!inp)
 		return ERR_PTR(-ENOMEM);
 
@@ -743,7 +743,7 @@ static int coda_upcall(struct venus_comm *vcp,
 	sig_req = kmalloc(sizeof(struct upc_req), GFP_KERNEL);
 	if (!sig_req) goto exit;
 
-	CODA_ALLOC((sig_req->uc_data), char *, sizeof(struct coda_in_hdr));
+	sig_req->uc_data = kvzalloc(sizeof(struct coda_in_hdr), GFP_KERNEL);
 	if (!sig_req->uc_data) {
 		kfree(sig_req);
 		goto exit;
-- 
2.17.1

