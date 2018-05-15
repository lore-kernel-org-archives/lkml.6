Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1731937-1526350646-2-4609426845295240066
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526350645; b=IY6yHXAvOILshskRruCq9pnubax9SaSO8NJWnTKnae6WwGZdGw
    vxdFc2JKCRqV0sia1bFKcfwbkYIXhR+wgLUzwIh4PiS/fD4soyWr2SST2d34ucHO
    HRM0eSmRCUwo2EcQWT+EZX7+ha/c9z7hrVjExpNXQNWllIVcmQZoRxeVvXerPgr/
    vFoH8xaK+4/7TLL0pjNO4TbyVbESUof5UY1rBlJ/ZcwBVSLrZfSl/SynmjCBq9Q8
    QntPRjU9W9qDcA0WREBAc7je8if6nNWfpTn5PZCcp//q2+BT2zz7sLxF94b0HOX2
    aFw9DZLbHwCF26XMl7txJM++aOCOcn2LMlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526350645; bh=j6ApX
    81QGWrKPs5Oa0pHjIvaFaKIVv1fFF1Vr5MgLV4=; b=F7OhFaI0RyLCTmGn/MJnH
    XzWaFp9Y2CEGtfoBNldy8D/qRfBGfgKII3X+RF5Ol93ct8ecytjySnaR9glhkF9M
    JKJp2aTLgpnVBiIrWbSY//6ap4/v8Ak4llmQguJEdEYzDOWSdLz/Aq+x8i74KEnH
    6UAtkwROJESPWM2vmoE0pRE0WsMQCVg/gWyBn8BXlQ0Y6fkbR4DIv5Y7rYyZhlVE
    k8ohwSYrA+WVmmCytxRWO70ZAFC3/auzTpob8RrCdqudyCrLYVxhZQckvl2/wwOR
    K6YhWfo7qmyCkJvJTfjqMaKcRmVsJ4FxZb96RQGE+CCex/VWCVShjXYbsMhThqVW
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL1Pg3bgqBlkvgC55H7nV2nrB4WOA4epwrTF/yHqNmotN5S4qlhxxjsHJxTZcCFfbiEanrRZiAzUQn6CEMAzKURObx1xHE3FEFhm4FghWvU36KOfigtu
    XxPEgeUmjTrHLt8nLBY4BgWWCIiJ+jmURSgHKlTnurk7dx5hpUi3gYq/mwLP7yy89ycs3YKeeUO3qX1wtUAPboiXrbrI2OCc/QeWhY+M14CVUmjrVU9KtUHt
    OJ+qbDf2+DrExsjEpWJvIQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=XoljZmphCf-CZ_AndNQA:9
    a=QoO5jAV0-8V3mT78:21 a=0ggCYed0Kxyu23Ah:21 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 5/5] staging: lustre: mdc: use large xattr buffers for old
 servers
Date: Mon, 14 May 2018 22:17:03 -0400
Message-Id: <1526350623-4616-6-git-send-email-jsimmons@infradead.org>
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
Cc: "John L. Hammond" <john.hammond@intel.com>,
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

From: "John L. Hammond" <john.hammond@intel.com>

Pre 2.10.1 MDTs will crash when they receive a listxattr (MDS_GETXATTR
with OBD_MD_FLXATTRLS) RPC for an orphan or dead object. So for
clients connected to these older MDTs, try to avoid sending listxattr
RPCs by making the bulk getxattr (MDS_GETXATTR with OBD_MD_FLXATTRALL)
more likely to succeed and thereby reducing the chances of falling
back to listxattr.

Signed-off-by: John L. Hammond <john.hammond@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10912
Reviewed-on: https://review.whamcloud.com/31990
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Fan Yong <fan.yong@intel.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/mdc/mdc_locks.c | 31 +++++++++++++++++++++------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/lustre/lustre/mdc/mdc_locks.c b/drivers/staging/lustre/lustre/mdc/mdc_locks.c
index a8aa0fa..b991c6f 100644
--- a/drivers/staging/lustre/lustre/mdc/mdc_locks.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_locks.c
@@ -326,8 +326,10 @@ static void mdc_realloc_openmsg(struct ptlrpc_request *req,
 {
 	struct ptlrpc_request	*req;
 	struct ldlm_intent	*lit;
+	u32 min_buf_size = 0;
 	int rc, count = 0;
 	LIST_HEAD(cancels);
+	u32 buf_size = 0;
 
 	req = ptlrpc_request_alloc(class_exp2cliimp(exp),
 				   &RQF_LDLM_INTENT_GETXATTR);
@@ -344,18 +346,33 @@ static void mdc_realloc_openmsg(struct ptlrpc_request *req,
 	lit = req_capsule_client_get(&req->rq_pill, &RMF_LDLM_INTENT);
 	lit->opc = IT_GETXATTR;
 
+#if LUSTRE_VERSION_CODE < OBD_OCD_VERSION(3, 0, 53, 0)
+	/* If the supplied buffer is too small then the server will
+	 * return -ERANGE and llite will fallback to using non cached
+	 * xattr operations. On servers before 2.10.1 a (non-cached)
+	 * listxattr RPC for an orphan or dead file causes an oops. So
+	 * let's try to avoid sending too small a buffer to too old a
+	 * server. This is effectively undoing the memory conservation
+	 * of LU-9417 when it would be *more* likely to crash the
+	 * server. See LU-9856.
+	 */
+	if (exp->exp_connect_data.ocd_version < OBD_OCD_VERSION(2, 10, 1, 0))
+		min_buf_size = exp->exp_connect_data.ocd_max_easize;
+#endif
+	buf_size = max_t(u32, min_buf_size,
+			 GA_DEFAULT_EA_NAME_LEN * GA_DEFAULT_EA_NUM);
+
 	/* pack the intended request */
-	mdc_pack_body(req, &op_data->op_fid1, op_data->op_valid,
-		      GA_DEFAULT_EA_NAME_LEN * GA_DEFAULT_EA_NUM, -1, 0);
+	mdc_pack_body(req, &op_data->op_fid1, op_data->op_valid, buf_size,
+		      -1, 0);
 
-	req_capsule_set_size(&req->rq_pill, &RMF_EADATA, RCL_SERVER,
-			     GA_DEFAULT_EA_NAME_LEN * GA_DEFAULT_EA_NUM);
+	req_capsule_set_size(&req->rq_pill, &RMF_EADATA, RCL_SERVER, buf_size);
 
-	req_capsule_set_size(&req->rq_pill, &RMF_EAVALS, RCL_SERVER,
-			     GA_DEFAULT_EA_NAME_LEN * GA_DEFAULT_EA_NUM);
+	req_capsule_set_size(&req->rq_pill, &RMF_EAVALS, RCL_SERVER, buf_size);
 
 	req_capsule_set_size(&req->rq_pill, &RMF_EAVALS_LENS, RCL_SERVER,
-			     sizeof(u32) * GA_DEFAULT_EA_NUM);
+			     max_t(u32, min_buf_size,
+				   sizeof(u32) * GA_DEFAULT_EA_NUM));
 
 	req_capsule_set_size(&req->rq_pill, &RMF_ACL, RCL_SERVER, 0);
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
