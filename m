Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523852139-5-7178940380635644993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852138; b=kb1IMAy7P0biCg0XZmHX+Zhudec4UCJ78AW44hB1ITLjDqUmFP
    OpL/q3DK3C1Zjs7DTdoZOKHRvQ654iqkUXK+RC6ivmpJFwDgLt6N5rMWBr28d47j
    SPoShco4j6wzuJdqn4IMRtKHVf4dOlHEeEDQaI5vGdmbkCyoUN3fxezNcX9igBZE
    4uhUfoFTthuNLd/Ds1Nmqs2B6kk4z+L7JEN+l3McKll/DulkewvpNuXCTuv6bWxD
    LTxrk81Z2oGSt0WUxbjgMqrn72+zt22vwrKUcqFMibKSGxI0Fl4sahWJKccKcStT
    V9hdiDO7+pRnqI8w7/KUtRjadwaAVBHoCfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852138; bh=/bHzu
    HHrF1RoYFwIKE3wEzQp/HZxFH1Z8ITt6CMGBR4=; b=vsoVDXnhsXc2s1VR1/Mnl
    62q/khsAzAtSHydcBGpvkE3TtARdh4jdBOy9qKcF0TpLs6WXEi+Xw3wRkPRhEL2d
    63/27qqWz0EKfYY3yJxs/jWAkMusaQPNEPyBpA4YGSEmQMjuwNUtkqmdDZn+wF2n
    BEpckjLcnG0XtrPZwbFQqAPUql3NQd18zGv4LvDFHLK9KliF9HlOfA+Uu929v4E2
    uDOltFO1FA+lZssllE4K06DDi3ivlKnQROfoJAvMLdfU8Kd3RPRYS86tWcAs2kOg
    fqEK3GEWnSOXQ1RVMZfx9aS7xqjMKeqn+lqmS7nt1h/km/U7pn5YLwUGQWWl4gSt
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHlE30ardBKDHLM7LWNZV1tF6OSY+TtONv21ThvohrMmdgFkOEyqn6PJZ8H/AEs5aTHoPgCsTOABEtG2nWqPSL2/2SHBQhGmq6Xa6umXob69zW+FXeTV
    IsIgVVyhgCfh0L4b/iahWNa7kSVQP4Hx9g4MZUuSCr5BDz9FfLmBoUoX50B4C0BTK1jJekQEfbJgmS9e7fZSxmaPCnp306MklIdfHdirmNi9f1pG52sML9EE
    vPGcZ2eUqv4aRqhUQZF4/w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=Rh9ii05IAEwFrDjoKgAA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 07/22] staging: lustre: llite: refactor lustre.lov xattr
 handling
Date: Mon, 16 Apr 2018 00:14:56 -0400
Message-Id: <1523852111-17321-8-git-send-email-jsimmons@infradead.org>
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
Cc: Niu Yawei <yawei.niu@intel.com>, Bobi Jam <bobijam.xu@intel.com>,
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

From: Niu Yawei <yawei.niu@intel.com>

The function ll_xattr_set() contains special code to handle
the lustre specific xattr lustre.lov. Move all this code to
a new function ll_setstripe_ea().

Signed-off-by: Bobi Jam <bobijam.xu@intel.com>
Signed-off-by: Niu Yawei <yawei.niu@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8998
Reviewed-on: https://review.whamcloud.com/24851
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Lai Siyao <lai.siyao@intel.com>
Reviewed-by: Jinshan Xiong <jinshan.xiong@gmail.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 131 +++++++++++++++-------------
 1 file changed, 69 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 55a19a5..1b462e4 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -186,6 +186,73 @@ static int get_hsm_state(struct inode *inode, u32 *hus_states)
 	return rc;
 }
 
+static int ll_setstripe_ea(struct dentry *dentry, struct lov_user_md *lump,
+			   size_t size)
+{
+	struct inode *inode = d_inode(dentry);
+	int rc = 0;
+
+	if (size != 0 && size < sizeof(struct lov_user_md))
+		return -EINVAL;
+
+	/*
+	 * It is possible to set an xattr to a "" value of zero size.
+	 * For this case we are going to treat it as a removal.
+	 */
+	if (!size && lump)
+		lump = NULL;
+
+	/* Attributes that are saved via getxattr will always have
+	 * the stripe_offset as 0.  Instead, the MDS should be
+	 * allowed to pick the starting OST index.   b=17846
+	 */
+	if (lump && lump->lmm_stripe_offset == 0)
+		lump->lmm_stripe_offset = -1;
+
+	/* Avoid anyone directly setting the RELEASED flag. */
+	if (lump && (lump->lmm_pattern & LOV_PATTERN_F_RELEASED)) {
+		/* Only if we have a released flag check if the file
+		 * was indeed archived.
+		 */
+		u32 state = HS_NONE;
+
+		rc = get_hsm_state(inode, &state);
+		if (rc)
+			return rc;
+
+		if (!(state & HS_ARCHIVED)) {
+			CDEBUG(D_VFSTRACE,
+			       "hus_states state = %x, pattern = %x\n",
+				state, lump->lmm_pattern);
+			/*
+			 * Here the state is: real file is not
+			 * archived but user is requesting to set
+			 * the RELEASED flag so we mask off the
+			 * released flag from the request
+			 */
+			lump->lmm_pattern ^= LOV_PATTERN_F_RELEASED;
+		}
+	}
+
+	if (lump && S_ISREG(inode->i_mode)) {
+		__u64 it_flags = FMODE_WRITE;
+		int lum_size;
+
+		lum_size = ll_lov_user_md_size(lump);
+		if (lum_size < 0 || size < lum_size)
+			return 0; /* b=10667: ignore error */
+
+		rc = ll_lov_setstripe_ea_info(inode, dentry, it_flags, lump,
+					      lum_size);
+		/* b=10667: rc always be 0 here for now */
+		rc = 0;
+	} else if (S_ISDIR(inode->i_mode)) {
+		rc = ll_dir_setstripe(inode, lump, 0);
+	}
+
+	return rc;
+}
+
 static int ll_xattr_set(const struct xattr_handler *handler,
 			struct dentry *dentry, struct inode *inode,
 			const char *name, const void *value, size_t size,
@@ -198,73 +265,13 @@ static int ll_xattr_set(const struct xattr_handler *handler,
 	       PFID(ll_inode2fid(inode)), inode, name);
 
 	if (!strcmp(name, "lov")) {
-		struct lov_user_md *lump = (struct lov_user_md *)value;
 		int op_type = flags == XATTR_REPLACE ? LPROC_LL_REMOVEXATTR :
 						       LPROC_LL_SETXATTR;
-		int rc = 0;
 
 		ll_stats_ops_tally(ll_i2sbi(inode), op_type, 1);
 
-		if (size != 0 && size < sizeof(struct lov_user_md))
-			return -EINVAL;
-
-		/*
-		 * It is possible to set an xattr to a "" value of zero size.
-		 * For this case we are going to treat it as a removal.
-		 */
-		if (!size && lump)
-			lump = NULL;
-
-		/* Attributes that are saved via getxattr will always have
-		 * the stripe_offset as 0.  Instead, the MDS should be
-		 * allowed to pick the starting OST index.   b=17846
-		 */
-		if (lump && lump->lmm_stripe_offset == 0)
-			lump->lmm_stripe_offset = -1;
-
-		/* Avoid anyone directly setting the RELEASED flag. */
-		if (lump && (lump->lmm_pattern & LOV_PATTERN_F_RELEASED)) {
-			/* Only if we have a released flag check if the file
-			 * was indeed archived.
-			 */
-			u32 state = HS_NONE;
-
-			rc = get_hsm_state(inode, &state);
-			if (rc)
-				return rc;
-
-			if (!(state & HS_ARCHIVED)) {
-				CDEBUG(D_VFSTRACE,
-				       "hus_states state = %x, pattern = %x\n",
-				state, lump->lmm_pattern);
-				/*
-				 * Here the state is: real file is not
-				 * archived but user is requesting to set
-				 * the RELEASED flag so we mask off the
-				 * released flag from the request
-				 */
-				lump->lmm_pattern ^= LOV_PATTERN_F_RELEASED;
-			}
-		}
-
-		if (lump && S_ISREG(inode->i_mode)) {
-			__u64 it_flags = FMODE_WRITE;
-			int lum_size;
-
-			lum_size = ll_lov_user_md_size(lump);
-			if (lum_size < 0 || size < lum_size)
-				return 0; /* b=10667: ignore error */
-
-			rc = ll_lov_setstripe_ea_info(inode, dentry, it_flags,
-						      lump, lum_size);
-			/* b=10667: rc always be 0 here for now */
-			rc = 0;
-		} else if (S_ISDIR(inode->i_mode)) {
-			rc = ll_dir_setstripe(inode, lump, 0);
-		}
-
-		return rc;
-
+		return ll_setstripe_ea(dentry, (struct lov_user_md *)value,
+				       size);
 	} else if (!strcmp(name, "lma") || !strcmp(name, "link")) {
 		ll_stats_ops_tally(ll_i2sbi(inode), LPROC_LL_SETXATTR, 1);
 		return 0;
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
