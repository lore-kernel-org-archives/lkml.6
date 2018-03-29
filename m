Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1445413-1522346749-2-445187364140143805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522346749; b=bQVkNJUQ6VCIFG2yyacdBiW1MQmhghmKIY4ewmv2ySuTXo+ZE1
    35NQ2i7PiLqxPNjKhFR/W/ajqqjdBontWCpwBF+okDYwDFdNuSWQYarfRMaGQ0n/
    fcVUTJ0GkQWi83cooZZr9aouOBEphXBlCQEUrCCClQzZN0ctLDwt5k/PwFOLN+KV
    dqS1HCi0qxU3d3HQV5ILRYGzOIC/4Jj9oUBpradzEJdKyE7lWG4x+sJ85278kOm/
    cHLbgeJTyZni4nQomFOSeB36LxspP16/tkEPAnsU+udiJm2y/EY85chwaRJHhirt
    YmV9XingT3ZIRdlCbi5LQFktamHF8XOf5VEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522346749; bh=WO3K/4yn6+pVKbHqnVtBTK5zK90Ep/
    FJjh+lkFe39W4=; b=dq7qC1dbdbmeAMRJBHSvwihOdlo05QhJfSQZwUo5V7ITnK
    kR2BNhLBoSjPVJzc1f1wkyUGb0B/hgpb5Hs4lfSmD5Cy1/0JYK9LbeknqME+8+QZ
    8Zn+LaWPFhGjIvC6DptX4V1jG7PmsU/G7iXrfquGRpG3MuT3hllD9FXJxUMQ7pvg
    Kz5PvaOEr1cLrzrdmvgGiOYAN4dj2dTXMW0AKFE3KirVrQpc+dqQMyRL8ihmtlWE
    vToOSXNIDgLQs5egplu6E8gRvL2DrTXWfM/uYYXZ4ofdfHcGAlCgBVxIdLrwcm3J
    AnE0/cWmkzbieXjI/orBxwx8fOK8XyoMnmyFoeHQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfJORdSmyP4Y7Ovxfq31boWVhkAkgwTdwQgfbAasUgH6lXZh6SAmismSCCTdvpxgT92pKbTIt9obue9JTL0/N4SlQ/J3K0CFfZM13EApdMYBcM0Dij449
    WznJpHLIq/D5Mu0Dn2WgP33l7LiTQcWrga9DgsrAWmf9ZXz1ZlW4uB+06epMbkMObdvyiH1wHpIdeSjMYu0XCfAUO2SekdgPU+VAkJ4iMmNqFI76llLsxYDF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VnNF1IyMAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=r20Ri-rQZPU9uJhM6l4A:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeC2SFo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:05:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59420 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeC2SFo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:05:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 42/43] s390/qeth: lock read device while queueing next buffer
Date: Thu, 29 Mar 2018 20:00:37 +0200
Message-Id: <20180329175734.782126433@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 17bf8c9b3d499d5168537c98b61eb7a1fcbca6c2 ]

For calling ccw_device_start(), issue_next_read() needs to hold the
device's ccwlock.
This is satisfied for the IRQ handler path (where qeth_irq() gets called
under the ccwlock), but we need explicit locking for the initial call by
the MPC initialization.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -526,8 +526,7 @@ static inline int qeth_is_cq(struct qeth
 	    queue == card->qdio.no_in_queues - 1;
 }
 
-
-static int qeth_issue_next_read(struct qeth_card *card)
+static int __qeth_issue_next_read(struct qeth_card *card)
 {
 	int rc;
 	struct qeth_cmd_buffer *iob;
@@ -558,6 +557,17 @@ static int qeth_issue_next_read(struct q
 	return rc;
 }
 
+static int qeth_issue_next_read(struct qeth_card *card)
+{
+	int ret;
+
+	spin_lock_irq(get_ccwdev_lock(CARD_RDEV(card)));
+	ret = __qeth_issue_next_read(card);
+	spin_unlock_irq(get_ccwdev_lock(CARD_RDEV(card)));
+
+	return ret;
+}
+
 static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 {
 	struct qeth_reply *reply;
@@ -1183,7 +1193,7 @@ static void qeth_irq(struct ccw_device *
 		return;
 	if (channel == &card->read &&
 	    channel->state == CH_STATE_UP)
-		qeth_issue_next_read(card);
+		__qeth_issue_next_read(card);
 
 	iob = channel->iob;
 	index = channel->buf_no;
