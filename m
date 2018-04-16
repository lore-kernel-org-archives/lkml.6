Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217916-1523852125-2-14719330071987163497
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852124; b=inV8ZiPURGb2zvwIBmxDbGcWPvS2HsI7cPWKkaasnYiGljuyk+
    QzqAHmOoe1toUOoZ3LtulHb89Uip+CTww8Z1ha1UbF3dUOAmrAS28PSwgqQWzxEW
    EE8dRx8yVUwDaL/sUu6RWFsRdaTKdmv3qlaAPYz3GlMHzBdc8ttVZeCO4Z7i8jFd
    Z6qmexRlmnYjq+o/YRXRjuzG5MjeVDJXYYxzjK60AXIzyL2mihtft6UOlfrS3pbK
    EHyIhU6BXFEb8dvevWJswSHZAlKVQ0Rp5d3D5A31n5BnUYnfD7GGbCu14txDdBpr
    fNcZgtwSvMtscZ2/oYMGv8ol3dLixY4bqJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852124; bh=TK2SE
    k/lQZP5aCRZYqvZoaaefSXAjn5UkMn+L4MonH4=; b=lLxdWz1qECopI6xLy2H4E
    mcpCvaTWVBxk6Z6w8YcjbiOnyFvzn1xgrWXJFovCWfjV9rl+2W/WMyx+5VKsMGyR
    e5Rl218ywGbTwJjFpT6aDfD90SzmnrZDJ7JPIy/SdpHE5RdCDkR+xnmxoFRHpgOC
    FBcysMu+Ro54J1H7tKd220dRvS/45MUgijEBGv4Q75Y8hzRiChUFj0kipJ0MWcCG
    dS57a1Cm01/pyUgZNsa4lpal1wZnakLh/jz+tPVXDSDutLUh7RtNtkv36GNtuA/j
    yQ34dwLBy+H5BbDdxpOllhRS+Fo74bssTQzfnBEDgaPf9KtXJO9NnbzmJEFJp1R1
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
X-CM-Envelope: MS4wfIFGYKvdQQv44xQ5fkDOH1RRh46bfTnxGW1fbyX/UtKWEq4kylMnad1q6rGWxjytxYRJbjpcl+W/IGfWfagTWGHSk0Vk8lGXnIg4LhxWTdb2Jf0t47Mo
    eplINExvj1Jr475/5nC/edvoTtNtPV75n/NPdU1gI1rvIuTf4ut+db/i9+FppdSJNKeCfqSnX+QE2Qgud++EMOmT0vZ6cbADWOQgvLTjprJA+I7jkKntO4XQ
    HTO3j0gQ4WHusL6i4/G0ug==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=3go8odswAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=H-RkfYE6CuBbyF8ueEYA:9
    a=CjuIK1q_8ugA:10 a=WCphLhRDQySbTNkkd-8K:22 a=ZUkhVnNHqyo2at-WnAgH:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 03/22] staging: lustre: obd: change debug reporting in
 lmv_enqueue()
Date: Mon, 16 Apr 2018 00:14:52 -0400
Message-Id: <1523852111-17321-4-git-send-email-jsimmons@infradead.org>
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

Remove LL_IT2STR(it) from debug macros in lmv_enqueue(). The
removal makes it possible to simplify the md_enqueue() functions.

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
 drivers/staging/lustre/lustre/lmv/lmv_obd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/lustre/lmv/lmv_obd.c b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
index 7be9310..e1c93cd 100644
--- a/drivers/staging/lustre/lustre/lmv/lmv_obd.c
+++ b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
@@ -1660,15 +1660,14 @@ static int lmv_create(struct obd_export *exp, struct md_op_data *op_data,
 	struct lmv_obd	   *lmv = &obd->u.lmv;
 	struct lmv_tgt_desc      *tgt;
 
-	CDEBUG(D_INODE, "ENQUEUE '%s' on " DFID "\n",
-	       LL_IT2STR(it), PFID(&op_data->op_fid1));
+	CDEBUG(D_INODE, "ENQUEUE on " DFID "\n", PFID(&op_data->op_fid1));
 
 	tgt = lmv_locate_mds(lmv, op_data, &op_data->op_fid1);
 	if (IS_ERR(tgt))
 		return PTR_ERR(tgt);
 
-	CDEBUG(D_INODE, "ENQUEUE '%s' on " DFID " -> mds #%u\n",
-	       LL_IT2STR(it), PFID(&op_data->op_fid1), tgt->ltd_idx);
+	CDEBUG(D_INODE, "ENQUEUE on " DFID " -> mds #%u\n",
+	       PFID(&op_data->op_fid1), tgt->ltd_idx);
 
 	return md_enqueue(tgt->ltd_exp, einfo, policy, it, op_data, lockh,
 			extra_lock_flags);
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
