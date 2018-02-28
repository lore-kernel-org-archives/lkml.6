Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519836868-2-832948972629402726
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836867; b=F2FLMxpdFQj/pFaRmdpm0gh/SZOex6KtXUoxvnQHiUGx3Kr
    PevxQePKWFrSsZsrA0bkksTl3RU895hAdZv48JnWjuzciXdzUFFV/JT7PGV5Fv7W
    eixGcwzLVr0STEzX/zr+/MO5GdNLsDDabRYYARv5IjkpEKW9XUCsCgyRyRp1x/r0
    A85v2eMZbI6g2yeoWfYZ2KbHrSXphOlhT+CpEkDv8I6kRUFjLk1xqoSIFtuwaU6y
    rBNBZShnf7xW0CB1mvb2FCha8VZAYyk07FEJ2d9NOcQuZFJY5yHxjhc8JLdM8Voc
    vh3dAYA4VbUDo0zbWCjTKKm70Bm0/Yza8INpW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836867; bh=vEpy++aiSZd0m796K/8
    2JCQUK5P5qd+dSNVrWNyyCwM=; b=U1PRQ+sP6MtkqBBOLCk2aOH3PZe9QE+z1zE
    mHmza0MHDZ3H9MzQnGYLFIuTpgspVbrxXCmBBinMKzJc1Y49rNMk3o+vyaLXC9pe
    H76rCO9SUmcwxWINRDOh9M1RXnf7Ov4Hq5pClWl1QpRSKjSsRiXz2WKw7DrdS5pi
    mXoD8cYTluLnlOjZCt68AXvvTEdJ+h14w41ulqpZkNlj0UA2CNmTqrgG/zvG3aM9
    XVcpMjQGraK8UaZXk9Ehu0bqjhIOTmsPBtejjsaiBtHmLh3brkTxMzgI9uiKXdcf
    f+PJuYr7UMo+LCocEDGBilhgl/f7Xh9/800eoD5x8Unbk0tiLYw==
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
        id S934177AbeB1P5m (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:57:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34518 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933979AbeB1P5j (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:57:39 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "=?UTF-8?q?Oliver=20St=C3=A4bler?=" <oliver.staebler@bytesatwork.ch>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.595649925@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 044/254] can: ti_hecc: Fix napi poll return value for
 repoll
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

From: Oliver Stäbler <oliver.staebler@bytesatwork.ch>

commit f6c23b174c3c96616514827407769cbcfc8005cf upstream.

After commit d75b1ade567f ("net: less interrupt masking in NAPI") napi
repoll is done only when work_done == budget.
So we need to return budget if there are still packets to receive.

Signed-off-by: Oliver Stäbler <oliver.staebler@bytesatwork.ch>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/ti_hecc.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -652,6 +652,9 @@ static int ti_hecc_rx_poll(struct napi_s
 		mbx_mask = hecc_read(priv, HECC_CANMIM);
 		mbx_mask |= HECC_TX_MBOX_MASK;
 		hecc_write(priv, HECC_CANMIM, mbx_mask);
+	} else {
+		/* repoll is done only if whole budget is used */
+		num_pkts = quota;
 	}
 
 	return num_pkts;
