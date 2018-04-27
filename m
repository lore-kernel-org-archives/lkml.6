Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288473-1524837706-2-2190007585989856047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524837706; b=jW4f0uAubqSUet78a+1jb0gT6HhsxktniHk1uo0ZzZCxgrkdxg
    eRw4+cIp8MK+9PDJZbVti48+LqmrD2ztJd7KWsewqw++B4TbHqt5KzZiW+GXzA5F
    +Wpsk+PaXVN8eORUK2AIJhGj6mugtrzqL5g6uAIGLPG3kpkK8tgtRAy447Cn94no
    ISmUMNpkr2YFt3ZsGD+h5s/nnrLBPzsgzVRGn2elFwvHVmrKbwy2UXOnKi4Fnner
    k23/rAwNAbKy3RKTELTQHac/j1ouZ5rPZRiAOc/Pb1YFE3gi9Y5udgvXZ94mz6Dr
    wFyL1aOmq1UQIRtxLdddC7K0AZODDUny/Jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837706; bh=npBbk0XxG5Ew3r67A1M4MULoRrjzOG
    7U/P6M9auACxc=; b=hBGTtmbhHuEC8ZpR219F7G7dRkxwoskGtsErf+xfyj0wSj
    nyl1XBzsg0XOlV/sE1w/I11g3QkC0MM/FeqZuH1M4myGwQTDFnRlWHwlfi/MQTI6
    zKG4Bw9XmJ0ooYmIOIWZimzRXySEH2doxEv2L6J9gmWlWrsQaWY9SiDUjHQY1ZjK
    SiQS5ivdbxF85c2OcqwW8NYwoeCdUB1D0U4J1VHiUDArziSfm8yEu39uoAXwo7pR
    w3Gqofqzfjx4HTlsNNT7yYo85/h1STXeUIKCPu716phgbXeIkIWUfbmTUUi1yyaD
    VDycjsPdiuVgJzlF5Yr8qBzr2eaeUc8bz9toKEpQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKYgHQRVLKGM6OJZRTUmS/w+3RHCnKWvJSy2nrLi7YHjna5yHtdvBBzoRt7XsM44hwgQ1k4crP/N0IfPyJA7qAXT3dNrvs9lkmU7X87O41E28OjoF9CM
    sA4OVi+foZMKjv0h3RWs64lSOrPA5d5H8hEbQIWBBqhO61rJcT7hpEtFL3PBBaHPY0rk4tFBP9uPhirUB9OTfrZvBMGRFSvlhMfkc98+ofw5hgi7DBmpa0RF
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=wPsBQ40odNOwqZ2001YA:9 a=TIOgUnMNOxmp_s_p:21 a=obED7St9Fajfpnfo:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932851AbeD0OBk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933171AbeD0OBi (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:01:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99982185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f922284c18ea23a8e457@syzkaller.appspotmail.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 32/50] llc: delete timers synchronously in llc_sk_free()
Date: Fri, 27 Apr 2018 15:58:34 +0200
Message-Id: <20180427135657.584983982@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>


[ Upstream commit b905ef9ab90115d001c1658259af4b1c65088779 ]

The connection timers of an llc sock could be still flying
after we delete them in llc_sk_free(), and even possibly
after we free the sock. We could just wait synchronously
here in case of troubles.

Note, I leave other call paths as they are, since they may
not have to wait, at least we can change them to synchronously
when needed.

Also, move the code to net/llc/llc_conn.c, which is apparently
a better place.

Reported-by: <syzbot+f922284c18ea23a8e457@syzkaller.appspotmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/llc_conn.h |    1 +
 net/llc/llc_c_ac.c     |    9 +--------
 net/llc/llc_conn.c     |   22 +++++++++++++++++++++-
 3 files changed, 23 insertions(+), 9 deletions(-)

--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -97,6 +97,7 @@ static __inline__ char llc_backlog_type(
 
 struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
 			  struct proto *prot, int kern);
+void llc_sk_stop_all_timers(struct sock *sk, bool sync);
 void llc_sk_free(struct sock *sk);
 
 void llc_sk_reset(struct sock *sk);
--- a/net/llc/llc_c_ac.c
+++ b/net/llc/llc_c_ac.c
@@ -1096,14 +1096,7 @@ int llc_conn_ac_inc_tx_win_size(struct s
 
 int llc_conn_ac_stop_all_timers(struct sock *sk, struct sk_buff *skb)
 {
-	struct llc_sock *llc = llc_sk(sk);
-
-	del_timer(&llc->pf_cycle_timer.timer);
-	del_timer(&llc->ack_timer.timer);
-	del_timer(&llc->rej_sent_timer.timer);
-	del_timer(&llc->busy_state_timer.timer);
-	llc->ack_must_be_send = 0;
-	llc->ack_pf = 0;
+	llc_sk_stop_all_timers(sk, false);
 	return 0;
 }
 
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -951,6 +951,26 @@ out:
 	return sk;
 }
 
+void llc_sk_stop_all_timers(struct sock *sk, bool sync)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	if (sync) {
+		del_timer_sync(&llc->pf_cycle_timer.timer);
+		del_timer_sync(&llc->ack_timer.timer);
+		del_timer_sync(&llc->rej_sent_timer.timer);
+		del_timer_sync(&llc->busy_state_timer.timer);
+	} else {
+		del_timer(&llc->pf_cycle_timer.timer);
+		del_timer(&llc->ack_timer.timer);
+		del_timer(&llc->rej_sent_timer.timer);
+		del_timer(&llc->busy_state_timer.timer);
+	}
+
+	llc->ack_must_be_send = 0;
+	llc->ack_pf = 0;
+}
+
 /**
  *	llc_sk_free - Frees a LLC socket
  *	@sk - socket to free
@@ -963,7 +983,7 @@ void llc_sk_free(struct sock *sk)
 
 	llc->state = LLC_CONN_OUT_OF_SVC;
 	/* Stop all (possibly) running timers */
-	llc_conn_ac_stop_all_timers(sk, NULL);
+	llc_sk_stop_all_timers(sk, true);
 #ifdef DEBUG_LLC_CONN_ALLOC
 	printk(KERN_INFO "%s: unackq=%d, txq=%d\n", __func__,
 		skb_queue_len(&llc->pdu_unack_q),
