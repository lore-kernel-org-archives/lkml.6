Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519831905-2-12784044906871422930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519831904; b=tVk3IJGE7X8+qa6XI4cmTQ3xQ2G+2rOvNApKdHaOIBf0sgI
    wezPmxO0Ng1WpSWkeyUHg+spYEJGYCis/dHY5cziLASSBeS5LVc8sWs5OJWXxBmp
    goT2YH/l3kjl3vYcyHaOXSKf8VubBHqHq3OZm43Ai6cRFE+sTHvWX4LInjqckuwl
    9MCHTguxhKEanpD8QU0l4FxxCMY9r0N8EhWsTIjnfAqcmmDqs0kB2WBezgAkvWSC
    8de93ujqeAKjHsac5Cp1p4Uu1JcnzC334XhP+zL9SPuoPc6FcMSbTk/JbA45GyHa
    QakTR46GmY4VzXOUdSDUvDidFagtrB6BLWzzRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831904; bh=QDNm9U1zzvI8qxyHRep
    KilVLDqoSASb5ztE9Z1Bw+KU=; b=IxvqtyZ4n9BJfBDtxCol+XVGLBav+L5C1cK
    nE865XwKktRZm9aWs5CuGYcQs+Db7Fi8c8pDBA67IcADDuYUXkXwACkusWhJIP1l
    ZIg4QvAnNjLdGfDN5iapj69S7DEGOHhCccD703XHolzMcj6f7G2zX16WMIsvMG2U
    DcBglZd7WOa9cJjo5MEA+abvKw+QfWmyvEnfbapMJ8nKIRjVcuKu5hmsMstQLVEl
    SyvSJlIiX7fM3hVmnBkkPDcY+xOZQPXS3AkVSlysNS5u9rQWLE3j3BD5rIRw4DFe
    IjvI2uV3nIW+vUCRgneL6MnZurku4WfidY8MAdBChSxxBMhPUSw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeB1P1L (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:27:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33338 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752873AbeB1PWk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Nogah Frankel" <nogahf@mellanox.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.623540736@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 031/140] net_sched: red: Avoid illegal values
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nogah Frankel <nogahf@mellanox.com>

commit 8afa10cbe281b10371fee5a87ab266e48d71a7f9 upstream.

Check the qmin & qmax values doesn't overflow for the given Wlog value.
Check that qmin <= qmax.

Fixes: a783474591f2 ("[PKT_SCHED]: Generic RED layer")
Signed-off-by: Nogah Frankel <nogahf@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2:
 - Drop changes in sch_sfq
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/net/red.h
+++ b/include/net/red.h
@@ -124,6 +124,17 @@ static inline u32 red_rmask(u8 Plog)
 	return Plog < 32 ? ((1 << Plog) - 1) : ~0UL;
 }
 
+static inline bool red_check_params(u32 qth_min, u32 qth_max, u8 Wlog)
+{
+	if (fls(qth_min) + Wlog > 32)
+		return false;
+	if (fls(qth_max) + Wlog > 32)
+		return false;
+	if (qth_max < qth_min)
+		return false;
+	return true;
+}
+
 static inline void red_set_parms(struct red_parms *p,
 				 u32 qth_min, u32 qth_max, u8 Wlog, u8 Plog,
 				 u8 Scell_log, u8 *stab)
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -479,6 +479,9 @@ static int choke_change(struct Qdisc *sc
 
 	ctl = nla_data(tb[TCA_CHOKE_PARMS]);
 
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
+
 	if (ctl->limit > CHOKE_MAX_QUEUE)
 		return -EINVAL;
 
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -384,6 +384,9 @@ static inline int gred_change_vq(struct
 	struct gred_sched *table = qdisc_priv(sch);
 	struct gred_sched_data *q;
 
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
+
 	if (table->tab[dp] == NULL) {
 		table->tab[dp] = kzalloc(sizeof(*q), GFP_ATOMIC);
 		if (table->tab[dp] == NULL)
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -189,6 +189,8 @@ static int red_change(struct Qdisc *sch,
 		return -EINVAL;
 
 	ctl = nla_data(tb[TCA_RED_PARMS]);
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
 
 	if (ctl->limit > 0) {
 		child = fifo_create_dflt(sch, &bfifo_qdisc_ops, ctl->limit);
