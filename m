Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523852141-2-9880482373244454535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852140; b=RTSjWXhaRW63QuA1xgOQj+0L+MWM0TzNwRYEHC7fFxTmClA9tS
    6BmVjChZhdDQsIx2YfV3BVBqNYMGbieKLb2eJQHty4dRaS2CukKqLat1tUP4sYsI
    CfIyoz+GMkGDsRlAH1xokXxw4y7siqtvsGkqhmYLyNDjFJXWgbrL6xbGGIycITxh
    5okFwafsb3sBwX05wFliUqzfDDzL+GpkDu2MwyTL6Os5QYUo4bn+nnXrh9L0q8pv
    t1v9YW5jBICyZM+qQoGMuk5pt6oPSaFtXhLG8A8A46laLlzBo4oxEFsisoS2AVI5
    MzyOye2CWwiLizERLM3YHZcHy2yp3ui3gE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852140; bh=HZSBi
    XYqBLECI48jncZ4mOBXJdxe7mRItOExD5bhRsQ=; b=npxTvMbyhZJPsFMD6JSbf
    Lxzwxm/N2MY/uOkzciWnS2iy67R+L7lfwY19fRbqgBV3c6O+Md6OOSZjX8oL13Ls
    eIzDHhZaftHGh9U99giPPZ2KHcv0qZIQ0qRDgtyI6F+dMJQueO+quajrpWjqPTpv
    2My6n1srcwyS2c8VUVlxDBXke8RKAlDS1XO45AF2ELfYbrG26Ud2LQ1iy/hlLk/u
    0JAjG1I4ZWRfCD2glPQnfNjvH67+dAZt7hc/nX44PV60ispCI112hYrj3YHRYLdN
    RSx/KfTE82nvFwZnrErqLBTGcCHRTenZfDUy7xzJ8xY89lGCq4Y6fjSRaXeLQLSC
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE3fA/rjG9O2VYtyiDsG51Dt669Zswcwrk8tZkj1iqPkU6X4Uk2k+FfltkN3zz8qzVdMgxS3FLw1kqHAapxfqtnSXHlh9eYSdZV/DWjID/D8/Gl4m97u
    2Gcr3SkNcyP8W/j4ug9QXf/oLEd/TNcRGXdvgagW1urHTELDQcokaGpQApvJ01AfTJYpaMFNZSqPRRyXxE19rqyL0i5FgWrvPqBqb/O4p+wKjtzht+TeMjc1
    KWojO5UiwpPrzPqelfXwvg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=CjxXgO3LAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=lB0dNpNiAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=GfnH0itrpjhMpFDPsBwA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=c-ZiYqmG3AbHTdtsH08C:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 18/22] staging: lustre: llite: style changes in xattr.c
Date: Mon, 16 Apr 2018 00:15:07 -0400
Message-Id: <1523852111-17321-19-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
References: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: James Simmons <uja.ornl@yahoo.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Small style changes to match more the kernel code standard
and it make it more readable.

Signed-off-by: James Simmons <uja.ornl@yahoo.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9183
Reviewed-on: https://review.whamcloud.com/27240
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Bob Glossman <bob.glossman@intel.com>
Reviewed-by: Sebastien Buisson <sbuisson@ddn.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 835d00f..d08bf1e 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -81,11 +81,10 @@ static int xattr_type_filter(struct ll_sb_info *sbi,
 	return 0;
 }
 
-static int
-ll_xattr_set_common(const struct xattr_handler *handler,
-		    struct dentry *dentry, struct inode *inode,
-		    const char *name, const void *value, size_t size,
-		    int flags)
+static int ll_xattr_set_common(const struct xattr_handler *handler,
+			       struct dentry *dentry, struct inode *inode,
+			       const char *name, const void *value, size_t size,
+			       int flags)
 {
 	struct ll_sb_info *sbi = ll_i2sbi(inode);
 	struct ptlrpc_request *req = NULL;
@@ -139,9 +138,9 @@ static int xattr_type_filter(struct ll_sb_info *sbi,
 	fullname = kasprintf(GFP_KERNEL, "%s%s", handler->prefix, name);
 	if (!fullname)
 		return -ENOMEM;
-	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
-			 valid, fullname, pv, size, 0, flags,
-			 ll_i2suppgid(inode), &req);
+
+	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode), valid, fullname,
+			 pv, size, 0, flags, ll_i2suppgid(inode), &req);
 	kfree(fullname);
 	if (rc) {
 		if (rc == -EOPNOTSUPP && handler->flags == XATTR_USER_T) {
@@ -307,9 +306,8 @@ static int ll_xattr_set(const struct xattr_handler *handler,
 				   flags);
 }
 
-int
-ll_xattr_list(struct inode *inode, const char *name, int type, void *buffer,
-	      size_t size, u64 valid)
+int ll_xattr_list(struct inode *inode, const char *name, int type, void *buffer,
+		  size_t size, u64 valid)
 {
 	struct ll_inode_info *lli = ll_i2info(inode);
 	struct ll_sb_info *sbi = ll_i2sbi(inode);
@@ -439,6 +437,7 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
 	fullname = kasprintf(GFP_KERNEL, "%s%s", handler->prefix, name);
 	if (!fullname)
 		return -ENOMEM;
+
 	rc = ll_xattr_list(inode, fullname, handler->flags, buffer, size,
 			   OBD_MD_FLXATTR);
 	kfree(fullname);
@@ -562,6 +561,7 @@ ssize_t ll_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			   OBD_MD_FLXATTRLS);
 	if (rc < 0)
 		return rc;
+
 	/*
 	 * If we're being called to get the size of the xattr list
 	 * (size == 0) then just assume that a lustre.lov xattr
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
