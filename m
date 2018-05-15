Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1731937-1526350637-5-14439035953570437316
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526350636; b=ADPIzj/bzZWKJh4Rz8b8vGVHdQPMAa9CeTe2gibRGMfnLeBr72
    qK+x+ZzeUp5OJGTxpAG9rJmn8qlBBhS1PW82k2sahQsiDidIFQ77fUx6jL3UyW9t
    Y9x/x20tsyGWVMCoyAp5gRVte7U0YpcZMfbAYCQD/GgAcYb8XTaRAr9JthPKcKMo
    al79d62k2XtucC/5zAfSY4Diu7amsYIf+EPQIUH70w3ADz+XLtwFSVFubiQkd4rq
    u/enMDc/UED8oSrfEfnEKMsEpRkW8nEqpFLPUNKt1YVYsBs6Ekpgtc9IG9D7gkBX
    FkYOVudVo+mPWQclsw7NHe6PRwTj0iuO2Q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526350636; bh=jzNS/
    VAbIQcQJieHhBpTwbtYh1t2HX5q0/KsPbBbxFE=; b=Zo/87sImvYtLryOpaNZH4
    CMTXRgxhrxE342g5DuqvsXlMumV0cY7n29JR3KgNylziTxkO2DEjqDkSXR5zbnmy
    GD1cSAWNYaaLQFtwmOPPEzXRWpmSvXlgJed86778oTIVcAo/+FmqohDP6KPOWN28
    lNyQE9AAS1/vjIYbr/9Hwdvv5SLecn3hxSxL01gLJstzm3B923BELwG56afxZzY2
    03um9dmjUZf3b+3v0z/+hQC9uNRUxOFEuCB0K3RTZPYfvQWZ1KDPxwmmnR59+fnF
    PHz+2Uj0n6awIJYhI6vDvFC4G7ZoHiaNE1VDW2v9NwlVVwvSqqkH+g++60+IuZG4
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEQJRv7IWhQPtAnmT+dQ3WbCEAwOnB//qezLVDpIowax1i+d/jlIcPwod5XJ0mYKEXag/eQlnurHOm6thXP+eW6l5+UQZzatdiwfH226BWM3jl6ucgkr
    1XIlmd+fqRuVYbaepgXrhYzBh/w0mq0unWJ0Ag5GJ31bWXMisJ8AdLI95ShiTRMyXOkF3a2mJmQuQu2rNi7KyqmLRY+D8C6F8ZHpL1m7wwunrW52AslXW0ZL
    mCDj85r4oslPd+t26rfwkg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=CjxXgO3LAAAA:8
    a=ySfo2T4IAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=hUUdjm8ASoJFF7p6gMgA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH v2 1/5] staging: lustre: llite: add support set_acl method in
 inode operations
Date: Mon, 14 May 2018 22:16:59 -0400
Message-Id: <1526350623-4616-2-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526350623-4616-1-git-send-email-jsimmons@infradead.org>
References: <1526350623-4616-1-git-send-email-jsimmons@infradead.org>
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
Cc: Dmitry Eremin <dmitry.eremin@intel.com>, James Simmons <uja.ornl@yahoo.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "John L. Hammond" <john.hammond@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Eremin <dmitry.eremin@intel.com>

Linux kernel v3.14 adds set_acl method to inode operations.
This patch adds support to Lustre for proper acl management.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Signed-off-by: John L. Hammond <john.hammond@intel.com>
Signed-off-by: James Simmons <uja.ornl@yahoo.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9183
Reviewed-on: https://review.whamcloud.com/25965
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10541
Reviewed-on: https://review.whamcloud.com/31588
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10926
Reviewed-on: https://review.whamcloud.com/32045
Reviewed-by: Bob Glossman <bob.glossman@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
Changelog:

v1) Initial patch ported to staging tree
v2) Fixed up goto handling and avoid BUG() when calling
    forget_cached_acl()with invalid type as pointed out by Dan Carpenter

 drivers/staging/lustre/lustre/llite/file.c         | 62 ++++++++++++++++++++++
 .../staging/lustre/lustre/llite/llite_internal.h   |  4 ++
 drivers/staging/lustre/lustre/llite/namei.c        | 10 +++-
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/file.c b/drivers/staging/lustre/lustre/llite/file.c
index 0026fde..64a5698 100644
--- a/drivers/staging/lustre/lustre/llite/file.c
+++ b/drivers/staging/lustre/lustre/llite/file.c
@@ -3030,6 +3030,7 @@ static int ll_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return rc;
 }
 
+#ifdef CONFIG_FS_POSIX_ACL
 struct posix_acl *ll_get_acl(struct inode *inode, int type)
 {
 	struct ll_inode_info *lli = ll_i2info(inode);
@@ -3043,6 +3044,64 @@ struct posix_acl *ll_get_acl(struct inode *inode, int type)
 	return acl;
 }
 
+int ll_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+{
+	struct ll_sb_info *sbi = ll_i2sbi(inode);
+	struct ptlrpc_request *req = NULL;
+	const char *name = NULL;
+	size_t value_size = 0;
+	char *value = NULL;
+	int rc;
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		name = XATTR_NAME_POSIX_ACL_ACCESS;
+		if (acl)
+			rc = posix_acl_update_mode(inode, &inode->i_mode, &acl);
+		break;
+
+	case ACL_TYPE_DEFAULT:
+		name = XATTR_NAME_POSIX_ACL_DEFAULT;
+		if (!S_ISDIR(inode->i_mode))
+			rc = acl ? -EACCES : 0;
+		break;
+
+	default:
+		rc = -EINVAL;
+		break;
+	}
+	if (rc)
+		return rc;
+
+	if (acl) {
+		value_size = posix_acl_xattr_size(acl->a_count);
+		value = kmalloc(value_size, GFP_NOFS);
+		if (!value) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		rc = posix_acl_to_xattr(&init_user_ns, acl, value, value_size);
+		if (rc < 0)
+			goto out_value;
+	}
+
+	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
+			 value ? OBD_MD_FLXATTR : OBD_MD_FLXATTRRM,
+			 name, value, value_size, 0, 0, 0, &req);
+
+	ptlrpc_req_finished(req);
+out_value:
+	kfree(value);
+out:
+	if (rc)
+		forget_cached_acl(inode, type);
+	else
+		set_cached_acl(inode, type, acl);
+	return rc;
+}
+#endif /* CONFIG_FS_POSIX_ACL */
+
 int ll_inode_permission(struct inode *inode, int mask)
 {
 	struct ll_sb_info *sbi;
@@ -3164,7 +3223,10 @@ int ll_inode_permission(struct inode *inode, int mask)
 	.permission	= ll_inode_permission,
 	.listxattr	= ll_listxattr,
 	.fiemap		= ll_fiemap,
+#ifdef CONFIG_FS_POSIX_ACL
 	.get_acl	= ll_get_acl,
+	.set_acl	= ll_set_acl,
+#endif
 };
 
 /* dynamic ioctl number support routines */
diff --git a/drivers/staging/lustre/lustre/llite/llite_internal.h b/drivers/staging/lustre/lustre/llite/llite_internal.h
index 6504850..2280327 100644
--- a/drivers/staging/lustre/lustre/llite/llite_internal.h
+++ b/drivers/staging/lustre/lustre/llite/llite_internal.h
@@ -754,7 +754,11 @@ enum ldlm_mode ll_take_md_lock(struct inode *inode, __u64 bits,
 int ll_md_real_close(struct inode *inode, fmode_t fmode);
 int ll_getattr(const struct path *path, struct kstat *stat,
 	       u32 request_mask, unsigned int flags);
+#ifdef CONFIG_FS_POSIX_ACL
 struct posix_acl *ll_get_acl(struct inode *inode, int type);
+int ll_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+#endif /* CONFIG_FS_POSIX_ACL */
+
 int ll_migrate(struct inode *parent, struct file *file, int mdtidx,
 	       const char *name, int namelen);
 int ll_get_fid_by_name(struct inode *parent, const char *name,
diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
index 9ac7f09..b41f189 100644
--- a/drivers/staging/lustre/lustre/llite/namei.c
+++ b/drivers/staging/lustre/lustre/llite/namei.c
@@ -1195,7 +1195,10 @@ static int ll_rename(struct inode *src, struct dentry *src_dchild,
 	.getattr	    = ll_getattr,
 	.permission	 = ll_inode_permission,
 	.listxattr	  = ll_listxattr,
-	.get_acl	    = ll_get_acl,
+#ifdef CONFIG_FS_POSIX_ACL
+	.get_acl	= ll_get_acl,
+	.set_acl	= ll_set_acl,
+#endif
 };
 
 const struct inode_operations ll_special_inode_operations = {
@@ -1203,5 +1206,8 @@ static int ll_rename(struct inode *src, struct dentry *src_dchild,
 	.getattr	= ll_getattr,
 	.permission     = ll_inode_permission,
 	.listxattr      = ll_listxattr,
-	.get_acl	    = ll_get_acl,
+#ifdef CONFIG_FS_POSIX_ACL
+	.get_acl	= ll_get_acl,
+	.set_acl	= ll_set_acl,
+#endif
 };
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
