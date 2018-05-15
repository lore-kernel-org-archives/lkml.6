Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1731937-1526350645-5-1448887638883186594
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526350644; b=cCvhQqdA3OONZ5ninZmaNWECUS/ARD1LGomvpSawmi2kPU+rWC
    Fk0zK0+dtUjL8V4Oopx9QIiwXbModHd1i87OWgb3GwCmHI7BMr1N2DmhcmBwOLml
    BJ7RdYxM/Q2eBXqYv5ShxQ7Z5xM1NxASGD3x14vPvGKW4ggAfMBR588O7LasE0pz
    ffqBFjxw54NYbi7r789TItFK7wbBJJnf/C3x0X93jGUbILYgH5BpvBetAKWB5CRb
    f9S21uDUIlULk6YTGjQSgRnIhY+irYXHmAV8uR1fn6oYuURR5lOQXN/8hWpPLouE
    DWh8eJy3MatJRsBPonAnzC2Ksa2z3xK3mSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526350644; bh=7TzcV
    wkloDSRLC6hJzb8sXa8vpJtDuLAJUdpLJFTv+0=; b=MJE1l21KOw9GF2/oMV07r
    h+dL6e0S+07bzRrJZsgj5N8pUn+YEmswYQcVSbXQGDHiQkpROn9XrgK8zJVdL5z1
    +Rqn73pO7969S4RaziQ7TrE/3UpZrpUGi95PGCeZP/XRL8asF96aNS2PsRqUKc+X
    5461IU0Hsm4B0L4ATE5BzmS7zegiYEHhFwzlsHKuifJnhyeC0Y9xM9lAMpri5nLy
    ehHl0lqeh/pKCGRYSdEqwZfGXKnslq4Yess60sAv7SVI1Ciy9slyIdjSqIiFZOEF
    +lktR5PyYVedLePVIfU55nGVMYlGNdbQ6eK7gUI5HrJ22dWk5tCqQ+XACRd5H7br
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfK5MZZENoGgHLRo7GLlRusZL6V8GkKhoA2KmXJrro7JnM0MF8wuW7vme1aA1dBxV/9Cf2nhZnHL+cBLpb03OgZjMS09a5g7njUk1IlMFouQa1g/K3hBP
    EuIZud5kCTqAY4PZfwkvFCsPoAgzqBTNDtFiwJCMkuuWVdVBoHOB2ESMfuSDDdIzLXeWsKzCOPFx6gF0BDme3wd9iZn2F2rkZsvUszkJrz9nhpqFjDdJl5Dd
    BR5MffK1xY+NuggDj7XHuA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=kBl-OI3rAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=D6xUfIpKSkuOhv7ezpoA:9
    a=Hpkj-hC3kaxbwXU0:21 a=91anU4eSSeshjBvv:21 a=CjuIK1q_8ugA:10
    a=pLxN2xGgR0OPbCgNAGn6:22 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 4/5] staging: lustre: mdc: excessive memory consumption by the
 xattr cache
Date: Mon, 14 May 2018 22:17:02 -0400
Message-Id: <1526350623-4616-5-git-send-email-jsimmons@infradead.org>
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
Cc: Andrew Perepechko <c17827@cray.com>,
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

From: Andrew Perepechko <c17827@cray.com>

The refill operation of the xattr cache does not know the
reply size in advance, so it makes a guess based on
the maxeasize value returned by the MDS.

In practice, it allocates 16 KiB for the common case and
4 MiB for the large xattr case. However, a typical reply
is just a few hundred bytes.

If we follow the conservative approach, we can prepare a
single memory page for the reply. It is large enough for
any reasonable xattr set and, at the same time, it does
not require multiple page memory reclaim, which can be
costly.

If, for a specific file, the reply is larger than a single
page, the client is prepared to handle that and will fall back
to non-cached xattr code. Indeed, if this happens often and
xattrs are often used to store large values, it makes sense to
disable the xattr cache at all since it wasn't designed for
such [mis]use.

Signed-off-by: Andrew Perepechko <c17827@cray.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9417
Reviewed-on: https://review.whamcloud.com/26887
Reviewed-by: Fan Yong <fan.yong@intel.com>
Reviewed-by: Ben Evans <bevans@cray.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/mdc/mdc_locks.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/lustre/lustre/mdc/mdc_locks.c b/drivers/staging/lustre/lustre/mdc/mdc_locks.c
index 65a5341..a8aa0fa 100644
--- a/drivers/staging/lustre/lustre/mdc/mdc_locks.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_locks.c
@@ -315,6 +315,10 @@ static void mdc_realloc_openmsg(struct ptlrpc_request *req,
 	return req;
 }
 
+#define GA_DEFAULT_EA_NAME_LEN	20
+#define GA_DEFAULT_EA_VAL_LEN	250
+#define GA_DEFAULT_EA_NUM	10
+
 static struct ptlrpc_request *
 mdc_intent_getxattr_pack(struct obd_export *exp,
 			 struct lookup_intent *it,
@@ -323,7 +327,6 @@ static void mdc_realloc_openmsg(struct ptlrpc_request *req,
 	struct ptlrpc_request	*req;
 	struct ldlm_intent	*lit;
 	int rc, count = 0;
-	u32 maxdata;
 	LIST_HEAD(cancels);
 
 	req = ptlrpc_request_alloc(class_exp2cliimp(exp),
@@ -341,20 +344,20 @@ static void mdc_realloc_openmsg(struct ptlrpc_request *req,
 	lit = req_capsule_client_get(&req->rq_pill, &RMF_LDLM_INTENT);
 	lit->opc = IT_GETXATTR;
 
-	maxdata = class_exp2cliimp(exp)->imp_connect_data.ocd_max_easize;
-
 	/* pack the intended request */
-	mdc_pack_body(req, &op_data->op_fid1, op_data->op_valid, maxdata, -1,
-		      0);
+	mdc_pack_body(req, &op_data->op_fid1, op_data->op_valid,
+		      GA_DEFAULT_EA_NAME_LEN * GA_DEFAULT_EA_NUM, -1, 0);
 
-	req_capsule_set_size(&req->rq_pill, &RMF_EADATA, RCL_SERVER, maxdata);
+	req_capsule_set_size(&req->rq_pill, &RMF_EADATA, RCL_SERVER,
+			     GA_DEFAULT_EA_NAME_LEN * GA_DEFAULT_EA_NUM);
 
-	req_capsule_set_size(&req->rq_pill, &RMF_EAVALS, RCL_SERVER, maxdata);
+	req_capsule_set_size(&req->rq_pill, &RMF_EAVALS, RCL_SERVER,
+			     GA_DEFAULT_EA_NAME_LEN * GA_DEFAULT_EA_NUM);
 
-	req_capsule_set_size(&req->rq_pill, &RMF_EAVALS_LENS,
-			     RCL_SERVER, maxdata);
+	req_capsule_set_size(&req->rq_pill, &RMF_EAVALS_LENS, RCL_SERVER,
+			     sizeof(u32) * GA_DEFAULT_EA_NUM);
 
-	req_capsule_set_size(&req->rq_pill, &RMF_ACL, RCL_SERVER, maxdata);
+	req_capsule_set_size(&req->rq_pill, &RMF_ACL, RCL_SERVER, 0);
 
 	ptlrpc_request_set_replen(req);
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
