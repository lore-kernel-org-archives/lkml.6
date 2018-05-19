Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1852109-1526761402-2-9659820427157093582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526761401; b=eKIVLPQizxTVx0G2YkUGmHIinkzG6ri7Wl1r6mlGZqmdu7I1T7
    oX1JNiDBzoLx0YyEDsfGUrZezc0znkC1d54kaA7YEKOs+WrJrYMYz08wrxorfmEY
    bofJRy65whizMskEOt61S634d5me2BK2HgnKjcy5bWckmomizDLsdTNMZRiT1uCf
    SNdTTNqrO5+OjVvYNDGpIYqs6NiG5TcIfY5FmLb4ar5SzsH64cp1KfegegOTWjH1
    uCYozW/msqfU4q/S46injxB92IXI9mh9DEAE2VsaidDp4c/gYCpRnJ0bQGKZzeNl
    vsGU+RBmLVvvQxH7/Adg2FnloEnKjYnHs9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526761401; bh=vXnRI
    iSDy2euUz0PHaUXlHDt/haVrB7ZAtAbpmiXePk=; b=kxHS3kyBUjGZbKRUM1XBX
    kTae3sLc/jUngQFQEBDv1DnrepkOujIyun/PmUotfzDCjMJmak2qKx44pzTBd5OA
    pMt+O/IK9luYsdh4VhblTa0uE29eJ/W9LLRTeCviXXgbe0PHBKIpxk1GzdB/+BwW
    2ztohyI3nM35dPt9XPXTKpUFuAUsCJqQ78NifQM4BJ93lCbWslF/sh8IEnY1q5E0
    ta0ozL0ybra2sy9pz+iK0lQfoHQSOrfJN6EWTxrnIXhuewJi+tigtFFHqB27DlI2
    71MOOx0Ukg5vt+QTYyZ6oH/1jRhNUFil11RihJHHLfI2Em7PCDbDhRBxLuqooGHu
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=DrLOdfG3 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=fS1N2qmj;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=DrLOdfG3 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=fS1N2qmj;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDDaQrtB8vy0GU3CpvxY0mrSUaF/lCGRFGrjukJo/MRpuvWLWKyMbsgy/8NAwX4lO93CM5R2QEvEil9G6Vz2H/MZfXcDsgF/qHGMIV1mpTgqAkqg4zuv
    dkEqqWsuHQRDmvhugBFbD9Aw24B2aatK3bFl6c1CNDHNLd2/jmVBZB5/MyCThE+EdIhVX7NAGvdj49+LqTlYvWkFibTin0KmDHYkgv++MqoI6WhWIV4WPIsc
    x4Eo22nA/tfM5e2gnh0IqQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=OEiIynOWa98A:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=xVxfnp0aOBrK7t3zB20A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrykcDWGabEaP2SqF/Sc/xxhvFaEtsqu+PBVErJqzFrW021HS+u5uCYR7Op8NgC+TIpYjxeLw==
From: Davide spataro <davide90.spataro@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] Staging: rtl8192e: rtllib_tx: fix spelling issue.
Date: Sat, 19 May 2018 22:23:02 +0200
Message-Id: <20180519202302.14521-1-davide90.spataro@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: devel@driverdev.osuosl.org, johannes.berg@intel.com,
 Davide spataro <davide90.spataro@gmail.com>, linux-kernel@vger.kernel.org,
 davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix a spelling warning from checkpatch.pl.

Signed-off-by: Davide Spataro <davide90.spataro@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index fc88d47dea43..d314b2f602e4 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -578,7 +578,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		.seq_ctl = 0,
 		.qos_ctl = 0
 	};
-	int qos_actived = ieee->current_network.qos_data.active;
+	int qos_activated = ieee->current_network.qos_data.active;
 	u8 dest[ETH_ALEN];
 	u8 src[ETH_ALEN];
 	struct lib80211_crypt_data *crypt = NULL;
@@ -684,7 +684,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		else
 			fc = RTLLIB_FTYPE_DATA;
 
-		if (qos_actived)
+		if (qos_activated)
 			fc |= RTLLIB_STYPE_QOS_DATA;
 		else
 			fc |= RTLLIB_STYPE_DATA;
@@ -727,7 +727,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			qos_ctl = 0;
 		}
 
-		if (qos_actived) {
+		if (qos_activated) {
 			hdr_len = RTLLIB_3ADDR_LEN + 2;
 
 			/* in case we are a client verify acm is not set for this ac */
@@ -788,7 +788,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		txb->encrypted = encrypt;
 		txb->payload_size = cpu_to_le16(bytes);
 
-		if (qos_actived)
+		if (qos_activated)
 			txb->queue_index = UP2AC(skb->priority);
 		else
 			txb->queue_index = WME_AC_BE;
@@ -797,7 +797,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			skb_frag = txb->fragments[i];
 			tcb_desc = (struct cb_desc *)(skb_frag->cb +
 				    MAX_DEV_ADDR_SIZE);
-			if (qos_actived) {
+			if (qos_activated) {
 				skb_frag->priority = skb->priority;
 				tcb_desc->queue_index =  UP2AC(skb->priority);
 			} else {
@@ -831,7 +831,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				/* The last fragment has the remaining length */
 				bytes = bytes_last_frag;
 			}
-			if ((qos_actived) && (!bIsMulticast)) {
+			if ((qos_activated) && (!bIsMulticast)) {
 				frag_hdr->seq_ctl =
 					 cpu_to_le16(rtllib_query_seqnum(ieee, skb_frag,
 							     header.addr1));
@@ -866,7 +866,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				skb_put(skb_frag, 4);
 		}
 
-		if ((qos_actived) && (!bIsMulticast)) {
+		if ((qos_activated) && (!bIsMulticast)) {
 			if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] == 0xFFF)
 				ieee->seq_ctrl[UP2AC(skb->priority) + 1] = 0;
 			else
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
