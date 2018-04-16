Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523852124-2-9191861496155077170
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852123; b=X7AhFHqBAJGST6sMIdldr0lXelT4VrA5sVBxgP3jG2KCFqagfF
    uqbi4Snkjr1G1Oo6rAQRLm/jIJihL/QHTP74/gZ9I0Vm3yvS9zCkXC/fpes5njDU
    K9Fz9dmgkOPugZ3D2nuXY8RN/+ijqVl8slWnLr2mxxtrGudIPzBBjuc7al7a/q4v
    jGb8utz1IddOyITZd3JLo7X+Al47qLoGWy8Xb0j3NKl/cPNKodjqlWMI5TQTtIO2
    +F2qjBcSeZxMwYtr52BiPNuyT08NinfZiXsVtfGRYrxpyxt23J+CyYJFGFot2rz2
    pq8/rSy+zG9iVtUYebPzpWmCBMVzhVWNX6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852123; bh=Euhof
    8L/ajGJBgYJUBGWnWUtCP2E5qUQ01nh9k9OQiU=; b=WZp/OZPjNTR5qfDHlFeIf
    sHVqSnClsfKc719P66WpAUh+T+sR8DNWhU5XwHI76Ps9eD/25714hxM2ZRmUpukN
    oaXxTwgSPXi5GdqZny6gA3a+eMLPFxelAcV9DgcDfk1ri87dH9t0UPjTwROjjBYT
    3fYTyzJEqpGtk/1ZKfnJ7cD1oBRTI+HPG4b/C3OYmkt/zhwO4v+kwLO5c7nCb3Iw
    +tzGMmIc08cUHw11aPE4ItuyfVqk8sxv8jDsJvUDEaoxMGOSok6m+eidKnLC3aLn
    RinuU9lIbEtm9ZlAbC1JVj3QBaGNpb8RdRfhyAGyKKjyrFyVUC+8fGkmBtuplWfT
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJrTJhOWRIOfoyutCHCbneTsktt5TyctmhciqikhAXjT1R8pyUvsAYWcGmx+lZyUyUpiG7ppUg1YrccE3FcMq/CRhZPSjkgw7eyC8n1NoU075ceZPZwm
    8w8iWS1E2KTXReOrML12pIcs88pAS7wc9hZXYfKqlcbB9vJknON4QOrAutPxI1dboXu0H1FCt4lpvLv0KD/H5ci55xChfWd/A18+0ef+phtG78oKs/me59Wy
    BDo2d9SFmBM4WREGLjUaJQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=3go8odswAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=0WxA1dbfkC2TWfam0DkA:9
    a=CjuIK1q_8ugA:10 a=WCphLhRDQySbTNkkd-8K:22 a=ZUkhVnNHqyo2at-WnAgH:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 02/22] staging: lustre: obd: create it_has_reply_body()
Date: Mon, 16 Apr 2018 00:14:51 -0400
Message-Id: <1523852111-17321-3-git-send-email-jsimmons@infradead.org>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vitaly Fertman <vitaly.fertman@seagate.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vitaly Fertman <vitaly.fertman@seagate.com>

The lookup_intent it_op fields in many cases will be compared
to the settings of IT_OPEN | IT_UNLINK | IT_LOOKUP | IT_GETATTR.
Create a simple inline function for this common case.

Signed-off-by: Vitaly Fertman <vitaly.fertman@seagate.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7433
Seagate-bug-id: MRP-3072 MRP-3137
Reviewed-on: http://review.whamcloud.com/17220
Reviewed-by: Andrew Perepechko <andrew.perepechko@seagate.com>
Reviewed-by: Andriy Skulysh <andriy.skulysh@seagate.com>
Tested-by: Elena V. Gryaznova <elena.gryaznova@seagate.com>
Reviewed-by: John L. Hammond <john.hammond@intel.com>
Reviewed-by: Lai Siyao <lai.siyao@intel.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/include/obd.h   | 10 ++++++++++
 drivers/staging/lustre/lustre/mdc/mdc_locks.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/include/obd.h b/drivers/staging/lustre/lustre/include/obd.h
index f1233ca..ea6056b 100644
--- a/drivers/staging/lustre/lustre/include/obd.h
+++ b/drivers/staging/lustre/lustre/include/obd.h
@@ -686,6 +686,16 @@ enum md_cli_flags {
 	CLI_MIGRATE	= BIT(4),
 };
 
+/**
+ * GETXATTR is not included as only a couple of fields in the reply body
+ * is filled, but not FID which is needed for common intent handling in
+ * mdc_finish_intent_lock()
+ */
+static inline bool it_has_reply_body(const struct lookup_intent *it)
+{
+	return it->it_op & (IT_OPEN | IT_UNLINK | IT_LOOKUP | IT_GETATTR);
+}
+
 struct md_op_data {
 	struct lu_fid	   op_fid1; /* operation fid1 (usually parent) */
 	struct lu_fid	   op_fid2; /* operation fid2 (usually child) */
diff --git a/drivers/staging/lustre/lustre/mdc/mdc_locks.c b/drivers/staging/lustre/lustre/mdc/mdc_locks.c
index 695ef44..309ead1 100644
--- a/drivers/staging/lustre/lustre/mdc/mdc_locks.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_locks.c
@@ -568,7 +568,7 @@ static int mdc_finish_enqueue(struct obd_export *exp,
 		  it->it_op, it->it_disposition, it->it_status);
 
 	/* We know what to expect, so we do any byte flipping required here */
-	if (it->it_op & (IT_OPEN | IT_UNLINK | IT_LOOKUP | IT_GETATTR)) {
+	if (it_has_reply_body(it)) {
 		struct mdt_body *body;
 
 		body = req_capsule_server_get(pill, &RMF_MDT_BODY);
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
