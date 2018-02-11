Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326259-2-6900843337266895860
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326259; b=AihdGslgpQcGGn4/6eMQhYAw65bn/y+sOFzR0kPtTZD1TUA
    Qlx3vbghCOr8MQ4emGFiHi/H4DE4BRScZAMtlJA53u8Nc2YXllgh7V2Osujk/f+x
    OOITuLzIhlm2kGTq5qqLZA6aN/tYNUT97GiybdvGwBj+8wyHNeMsalUE2Pyqkmek
    8+SExf0LTJchflKPw73RqnMWLzIFOQhz8UR+Q/8snXoAFlDlNNRYS05LSaXxr3qs
    KK0j38H9OWIMzZdjK+NGuwGTL6973tc1G5OimgfOg7cYOVgLlxfsGjMgLIF6XEJd
    8NSBRKvlFZ6XNraUSBkEJ7w2BfOq4KFMrtYILAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326259; bh=NuPQ9U6v7FK13n6rGuE
    e0Mf/Dx5VUgymvRqThnUS7oU=; b=fyN4PMptmiDSCa78zFzqcz38PtlmPZfAyuV
    Z8cqNlEzTafVuvwrUg+3lYeFgVw87LCTlNHmF00/cgsGr8CldOzMRen3Qaj3a+iE
    MGzkI3S2soMKcMGVcfPvCQeZGI3yunrrDiqL1E7kTmPXOP1V7haj/n8t5GUwzNxt
    +0Px9yQV0TPbJUSkfXJecyYsupBFLxf+SgFodKbRJRZJ1e8mCLyfaWAWzWGgUJoe
    QGzGw66VhoR3dJ27L8Rwc/XqfzlhRtoS2pUttu1qUbw2FngrXG9ovUbjgcMVSgMK
    0fJ7UvpO9xOjmA0S6KpTBQNAkKccwyAnJVZfCirSpUWB0SxerUQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeBKFRh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:17:37 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41347 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752547AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "James Chapman" <jchapman@katalix.com>,
        "Tom Parkin" <tparkin@katalix.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.305387497@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 15/79] l2tp: purge session reorder queue on delete
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Parkin <tparkin@katalix.com>

commit 4c6e2fd35460208596fa099ee0750a4b0438aa5c upstream.

Add calls to l2tp_session_queue_purge as a part of l2tp_tunnel_closeall
and l2tp_session_delete.  Pseudowire implementations which are deleted only
via. l2tp_core l2tp_session_delete calls can dispense with their own code for
flushing the reorder queue.

Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1347,6 +1347,8 @@ again:
 				synchronize_rcu();
 			}
 
+			l2tp_session_queue_purge(session);
+
 			if (session->session_close != NULL)
 				(*session->session_close)(session);
 
@@ -1669,6 +1671,8 @@ EXPORT_SYMBOL_GPL(l2tp_session_free);
  */
 int l2tp_session_delete(struct l2tp_session *session)
 {
+	l2tp_session_queue_purge(session);
+
 	if (session->session_close != NULL)
 		(*session->session_close)(session);
 
