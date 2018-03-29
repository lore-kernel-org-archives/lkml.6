Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1456203-1522346894-2-12141967777061692372
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
    1522346893; b=GHkpFsk1PxFWOudV0V//mjvOeT9wJ4Zoci2yN0W09wQPaFb+6r
    mayAaqOMZNzXrm14v5U/P9R8Ooi426j6FJFNAutXoI7mVwf2kfH49KLV7tA4cCKQ
    sQWAnlhfDIzLyywatr2wfbhjFb/CTNscJzgxE3wgUQbqdmQvyqMNrOFiR02Y5uDs
    ccY3zbsBxvTKOtI7h4kQavOMjVYQvLoozJoGJL/5ySEJg7npSaH7xCAnGnWSuvrn
    If98WtSGtf2FTcwZQanlF5HJHYnpuM7TOLHK6k6sz3BtAZ9PUkNtWwXJTY+C4jzE
    lcMu67cj3FKcvgfQsG3Auq7sBrZb8AnxykYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522346893; bh=IA0c6emiQYXfOLuxvdXaIkUicyC4ch
    +0u02TOPffdOg=; b=gxqNU0SNWqUHD0wqDFgsMpy2uZH2G2bbuvDWYC1boBZ6On
    X9hMjfvUcs23WSSbom2yD62yzLtZzSWWRKNRxlF+vix4Avr9qzBZ94HYPayWqYmL
    c+mqPqMkO6akYUyh/FmOJPOcGgy7YmJudnheHiPfYnvrOVfQDvThCBazcV+sat85
    megToTeh5dyHlmbkFCvT3+3t1KlsIVY4m4NoVt5o3MDfFRQqR+KVh4g7Txf1jYUx
    iVk4opDSucNTV1LIkKnbI8GnGYUN6lGM5JPiP3tvhu+BqwX74RFysySVB6SralGV
    mhAxTI525HO9Z6AmWmruZCCtcewovR3uVsR+9m/g==
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
X-CM-Envelope: MS4wfE/Ygzumror8VzUhaqaYp6dpU36F/7U5sWFusBtJC2di+ETTrRIA+vsR2hs668l6pS2P3p6UQQ/pppNBxyCglOBNrUHaBOuXR+DyTGoj600KkWTwh2/Z
    6lvOPEJh4WomV1kiFmVUvbodfBDr1VCN2mnJUldSmwVzu2aFZBjiopG0HCx4Q9rKlG0tTSpdpHtMYNF44VbrYPxouOxtPcaOq0ok74QlFJnczfwKDMIOkb0V
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VnNF1IyMAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=wyaWlSuSt2FKKcOKA90A:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeC2SIL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:08:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbeC2SIK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:08:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 14/20] s390/qeth: free netdevice when removing a card
Date: Thu, 29 Mar 2018 20:00:50 +0200
Message-Id: <20180329175742.507138372@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 6be687395b3124f002a653c1a50b3260222b3cd7 ]

On removal, a qeth card's netdevice is currently not properly freed
because the call chain looks as follows:

qeth_core_remove_device(card)
	lx_remove_device(card)
		unregister_netdev(card->dev)
		card->dev = NULL			!!!
	qeth_core_free_card(card)
		if (card->dev)				!!!
			free_netdev(card->dev)

Fix it by free'ing the netdev straight after unregistering. This also
fixes the sysfs-driven layer switch case (qeth_dev_layer2_store()),
where the need to free the current netdevice was not considered at all.

Note that free_netdev() takes care of the netif_napi_del() for us too.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    2 --
 drivers/s390/net/qeth_l2_main.c   |    2 +-
 drivers/s390/net/qeth_l3_main.c   |    2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4969,8 +4969,6 @@ static void qeth_core_free_card(struct q
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 	qeth_clean_channel(&card->read);
 	qeth_clean_channel(&card->write);
-	if (card->dev)
-		free_netdev(card->dev);
 	kfree(card->ip_tbd_list);
 	qeth_free_qdio_buffers(card);
 	unregister_service_level(&card->qeth_service_level);
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1062,8 +1062,8 @@ static void qeth_l2_remove_device(struct
 		qeth_l2_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 	return;
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3243,8 +3243,8 @@ static void qeth_l3_remove_device(struct
 		qeth_l3_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 
