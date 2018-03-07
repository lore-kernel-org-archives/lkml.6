Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452841-2-9966931331448933387
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452840; b=f6ClBOF3fyK360wazUhO2qh/X5U0ocyl1KMHRRJ+JAZXJEH
    dEXdedyDvtAdrR+CQ6gpHQ5nAMkNb3uzdAzG31baTcKOKvKHV0PcknzCd1GE+YXq
    xT3k2OS0lcApqXCgkxa6bF2i8SUqucW4HEKNKlLg15tFrFMM2h3wmgYz3iXRT7Xy
    8tKqPZbL6060lve9e9u7z74wf2L8fcMZQ6sIkvHBo0diwxN8UA0ONcHhFKqypFDI
    YR9pzgMIov95+HpSSir0Fa3e17QXLq2PFfaId+oGYNciTipbTquiEX7G0fKvsZOA
    +gA4UXMnPmYMI2rijLp1HxZhR38XEuMGjKkh25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452840; bh=TbnDrxfB1amsavc1a13Z90BiLP
    H+39FNMJ0JVRDoSU0=; b=VDMGTtwWeJfZZVKAyxxW6e/PT1WNoQA/Fsi4LrBQ4C
    iklkb30Xp62oeRlTNDdOIwkvJERQPxefyGBasCbfkH7Yvwn73wvKYQHAuYTyIpER
    iG47V8fM1UzVdpUDk8vFv0bm8LLuA997QvIYiAK3kmcA9GW4w8+KpUK35fY9J/Hp
    CRAtN4LBiqrRMECVSytxFaUM9e0c830I4Usu+Mkzp1MVlPXz4bVZON+0Q/yRpgli
    /+jApeTNfY3OX68QctzGCK+DNSItbCdvWb3qzwGEhLDxm10VHf3Bfs5oZxUhqENO
    SQYOmG8utV0HcQM8rCKHilFIS6V6AW2K1l3aY+PXH6NA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934506AbeCGUAj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:00:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965654AbeCGTrB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:47:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 076/110] s390/qeth: fix SETIP command handling
Date: Wed,  7 Mar 2018 11:38:59 -0800
Message-Id: <20180307191049.429281327@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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


[ Upstream commit 1c5b2216fbb973a9410e0b06389740b5c1289171 ]

send_control_data() applies some special handling to SETIP v4 IPA
commands. But current code parses *all* command types for the SETIP
command code. Limit the command code check to IPA commands.

Fixes: 5b54e16f1a54 ("qeth: do not spin for SETIP ip assist command")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core.h      |    5 +++++
 drivers/s390/net/qeth_core_main.c |   14 ++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -580,6 +580,11 @@ struct qeth_cmd_buffer {
 	void (*callback) (struct qeth_channel *, struct qeth_cmd_buffer *);
 };
 
+static inline struct qeth_ipa_cmd *__ipa_cmd(struct qeth_cmd_buffer *iob)
+{
+	return (struct qeth_ipa_cmd *)(iob->data + IPA_PDU_HEADER_SIZE);
+}
+
 /**
  * definition of a qeth channel, used for read and write
  */
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2073,7 +2073,7 @@ int qeth_send_control_data(struct qeth_c
 	unsigned long flags;
 	struct qeth_reply *reply = NULL;
 	unsigned long timeout, event_timeout;
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = NULL;
 
 	QETH_CARD_TEXT(card, 2, "sendctl");
 
@@ -2100,10 +2100,13 @@ int qeth_send_control_data(struct qeth_c
 	while (atomic_cmpxchg(&card->write.irq_pending, 0, 1)) ;
 	qeth_prepare_control_data(card, len, iob);
 
-	if (IS_IPA(iob->data))
+	if (IS_IPA(iob->data)) {
+		cmd = __ipa_cmd(iob);
 		event_timeout = QETH_IPA_TIMEOUT;
-	else
+	} else {
 		event_timeout = QETH_TIMEOUT;
+	}
+
 	timeout = jiffies + event_timeout;
 
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
@@ -2128,9 +2131,8 @@ int qeth_send_control_data(struct qeth_c
 
 	/* we have only one long running ipassist, since we can ensure
 	   process context of this command we can sleep */
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-	if ((cmd->hdr.command == IPA_CMD_SETIP) &&
-	    (cmd->hdr.prot_version == QETH_PROT_IPV4)) {
+	if (cmd && cmd->hdr.command == IPA_CMD_SETIP &&
+	    cmd->hdr.prot_version == QETH_PROT_IPV4) {
 		if (!wait_event_timeout(reply->wait_q,
 		    atomic_read(&reply->received), event_timeout))
 			goto time_err;
