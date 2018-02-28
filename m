Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834651-2-2472989997295817496
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
    t=1519834650; b=FGXGSCXZjuDnZjjVSmiDTrdhBWBAcJv0o0ejAckW6rpBhko
    QPHkeqvX8AuURSVLlvkAqDlffrlqg0b/zltREDJOs9kUbAbR4yLE/xfBqAyXCZWD
    YmEVKTmHX9Ct58GTQ1CDDx/pqnFFiOAa60SZB3g/XQ+PkW9xY7K8qKFQBjmLZuTC
    dvmPHjnAg1+0xVpR5ySAH5d8TMz8wAhQSwJPMCbd70/bfn0vbHrPyri5+alIFOM/
    HFW7V1CKzXUOhXyGkZRQslZu+gt7+e6tENehvsccKsdndqg8Hkd99XvA248t9QlS
    gQQoE6XZMeMqqFJBue8hvWnJcmnm63K8EjpW/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834650; bh=TK2ogfjZfzbZzJHI/+B
    R2khG8jlqxdARZGvm3woGgN0=; b=WrxIF21qU1hZLoOje5LvdQVLCcqctaywLMH
    WreF04UAmqM1FSFf/CPo4wwDwiytRiQxJh6a3IryzUiycLsg+I5ehdcyTnBJCQeS
    wgw0l6bwGI7mO7fNrNl4dIjHecUH6enPWT1vrODsVeI2qDYz4qTsl0fX2ycHKN2+
    5zhajmYYlU5K7tUCfqAjIePzcf8ac7rJWil1hXe9Yx7bBD2pjOcbwxxDk03CwMom
    yjdi3oZoPtouTSPjdFHs9sI2gp6IvJqMc6W19QqLkyaXOWxS98efh2HVtOtibyev
    OUKGP8zbdnmfN2I2A2UAoxkLRUHD8mbJsTuj9Z3g/XPWx0a0EDg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934967AbeB1QQg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:16:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35241 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934542AbeB1QQe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:16:34 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Nogah Frankel" <nogahf@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.849819311@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 057/254] net_sched: red: Avoid illegal values
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nogah Frankel <nogahf@mellanox.com>

commit 8afa10cbe281b10371fee5a87ab266e48d71a7f9 upstream.

Check the qmin & qmax values doesn't overflow for the given Wlog value.
Check that qmin <= qmax.

Fixes: a783474591f2 ("[PKT_SCHED]: Generic RED layer")
Signed-off-by: Nogah Frankel <nogahf@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/red.h     | 11 +++++++++++
 net/sched/sch_choke.c |  3 +++
 net/sched/sch_gred.c  |  3 +++
 net/sched/sch_red.c   |  2 ++
 net/sched/sch_sfq.c   |  3 +++
 5 files changed, 22 insertions(+)

--- a/include/net/red.h
+++ b/include/net/red.h
@@ -167,6 +167,17 @@ static inline void red_set_vars(struct r
 	v->qcount	= -1;
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
 				 u8 Scell_log, u8 *stab, u32 max_P)
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -419,6 +419,9 @@ static int choke_change(struct Qdisc *sc
 
 	ctl = nla_data(tb[TCA_CHOKE_PARMS]);
 
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
+
 	if (ctl->limit > CHOKE_MAX_QUEUE)
 		return -EINVAL;
 
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -388,6 +388,9 @@ static inline int gred_change_vq(struct
 	struct gred_sched *table = qdisc_priv(sch);
 	struct gred_sched_data *q = table->tab[dp];
 
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
+
 	if (!q) {
 		table->tab[dp] = q = *prealloc;
 		*prealloc = NULL;
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -199,6 +199,8 @@ static int red_change(struct Qdisc *sch,
 	max_P = tb[TCA_RED_MAX_P] ? nla_get_u32(tb[TCA_RED_MAX_P]) : 0;
 
 	ctl = nla_data(tb[TCA_RED_PARMS]);
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
 
 	if (ctl->limit > 0) {
 		child = fifo_create_dflt(sch, &bfifo_qdisc_ops, ctl->limit);
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -658,6 +658,9 @@ static int sfq_change(struct Qdisc *sch,
 	if (ctl->divisor &&
 	    (!is_power_of_2(ctl->divisor) || ctl->divisor > 65536))
 		return -EINVAL;
+	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
+					ctl_v1->Wlog))
+		return -EINVAL;
 	if (ctl_v1 && ctl_v1->qth_min) {
 		p = kmalloc(sizeof(*p), GFP_KERNEL);
 		if (!p)
