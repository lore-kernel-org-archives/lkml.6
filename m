Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217916-1523852138-2-17840775140437303318
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852138; b=XKCobjW65e+neV4rAYqmgrRSxgKSBtDE24nv4IUKwj56rWgcR1
    GMLT+q1vkJY++A/DT3n64PBDlal+Hopy31Er/C5fROTDfG2blXa9eZ3FqAM4qdu8
    elFZ3vVTmTtRTsKahwfd8Mwu1PoGbs1o9Rufk7pdaGAC7JQVyu+LTA3scZ1PJufs
    o8noOe7Sa6uuahDue+BO25mGPsT1pySewnFxdLvb3iLLvkFm56rwTePkdqmDY1f4
    z3M2yqPx8gxWTOXp7HJIYf3ZB7BiEtY5fR1dKfnkSlpQ79jYcL+3oaQ0ISNk+f4n
    WDCMihI2VmAlbla4Q7PsosWe0jzEl4nWQ5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852138; bh=VDemE
    VCEsvusbKOdEuqBAIcCom6dbsYvo9wMZsvjD74=; b=mNEvmt/ZdJN0ttoarNyy/
    vSxGIWFbN3+0/k+lKOd3o6hn8/u/4q41aC1VQ9s91edcCLQkmhGCFP6loYsMFPq+
    uBxrewefs0fgyZF7ANMh6ltiCkrGq61kFqzESRtSbNdEXgwq+doyzTfXeSXHqKrN
    0I8ZPH8TenP5QsUY9Di4AuYkBCM2mtg1XMDjS2Wx0tWEOtT+IosUqjUb/Sn2uadL
    103999oTby3kRMEEzhvuPhGkzNezPji8TUaLr1YqVEG/nWdSXTDqCzalPirsuDxd
    K2S9K2KD7lh8ycIdsSq6YKeOSsprSYmpOWH6+qInR9An6uKImTKR0gB7IXLYsff6
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfDn7mZQa3wSP36FUYnGkZCvafoUhd+AseY1dN5c0hgG6rvqRAbGJ8J5/06Ix0BBUbDT63npobWFrXpox8F8mb7lQIr2t+1IzEIDaXoPdNUJlMktkCZTT
    cM/9IR1Iou+M0SFaPYBNbwwEmIpZ8eF64HfJrA69+dL3piF6FOzla6rYh1sfDxVtiFJgRoxJFdAtTK+Msu6uv0qbMWFO15UGyYGQ8XtkLJJXIhWhpsZqMxc4
    4iC/CU5nB0XvJ8rICcchKg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=_tzkH5T9wEdExqb1jzkA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 10/22] staging: lustre: llite: return from ll_adjust_lum() if
 lump is NULL
Date: Mon, 16 Apr 2018 00:14:59 -0400
Message-Id: <1523852111-17321-11-git-send-email-jsimmons@infradead.org>
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
Cc: Bobi Jam <bobijam.xu@intel.com>,
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

From: Bobi Jam <bobijam.xu@intel.com>

No need to check several times if lump is NULL. Just test once and
return 0 if NULL.

Signed-off-by: Bobi Jam <bobijam.xu@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9484
Reviewed-on: https://review.whamcloud.com/27126
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Niu Yawei <yawei.niu@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 78ce85b..56ac07e 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -190,15 +190,18 @@ static int ll_adjust_lum(struct inode *inode, struct lov_user_md *lump)
 {
 	int rc = 0;
 
+	if (!lump)
+		return 0;
+
 	/* Attributes that are saved via getxattr will always have
 	 * the stripe_offset as 0.  Instead, the MDS should be
 	 * allowed to pick the starting OST index.   b=17846
 	 */
-	if (lump && lump->lmm_stripe_offset == 0)
+	if (lump->lmm_stripe_offset == 0)
 		lump->lmm_stripe_offset = -1;
 
 	/* Avoid anyone directly setting the RELEASED flag. */
-	if (lump && (lump->lmm_pattern & LOV_PATTERN_F_RELEASED)) {
+	if (lump->lmm_pattern & LOV_PATTERN_F_RELEASED) {
 		/* Only if we have a released flag check if the file
 		 * was indeed archived.
 		 */
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
