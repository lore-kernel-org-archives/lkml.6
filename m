Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836495-2-9858423330918271318
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836494; b=X+cPEWoafFLN4ikdDk/6s0MsTLJRfu7snzQR8r01nIo4xuF
    4F2N2YoNSD3yIOWSEOnp0K5x4UhX1GsjGcBgSPrmxX3UU8beZw8iDn53GIM6p+/b
    +/KKxhDv0PMgPWArWsA7WIXogIfw91YakJdot4bzBb9z78jnsk2AWq65C17307zo
    NW9zEcxS7S2u9XImrzt4yIoLkM9BbyQU9fXFQgPR1TErih8YYdZUC/90/CTol/Ow
    tYOlfg0Ew1Com2xa9tPEHdzoPin2IA0zqau324UVBQvCvSsai6+qXb13wJFQzvFk
    Hp0obRtDV0vLBiDoGXaIRJrCEpGvEHV5M6K2DIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836494; bh=lqi/Nd2opCD/P0kTQ0m
    6SQv4DRKWyvcfI6/wokoRfIg=; b=BCK77+whM8haH52hrzmKeEgj1gfTXMl36g4
    uOuTwEY+DGZFk4NrDAmYHNRsnBE+tsEE0o3Zu9dPFeaQqOsmFzOynSEuSyZ67ar/
    DixeMixuUi0vY4AaUd24SIiCSrQerNFhhBsW3ko430Hd7bilM2vb74mW0CCr1BOg
    7a0GCmkQacKF+MO4uqN91E+a/Bqrapf/fkuR2Dhrxy5FZM0vE3wR50FNxyQZtRRj
    heH0Z7C9ocwAIKsDFDmRL8LnvuJ5QGmbH4hi44VDglsiBImOH3ywRAFUDKnYJZvx
    9YazX0LAiIsKjbfom0vkYDOojyDH78sTqxEsul8lVDC8iPQeanA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeB1Qrp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:47:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34593 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934293AbeB1P65 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.490015559@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 187/254] Input: twl6040-vibra - fix DT node memory
 management
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

From: "H. Nikolaus Schaller" <hns@goldelico.com>

commit c52c545ead97fcc2f4f8ea38f1ae3c23211e09a8 upstream.

commit e7ec014a47e4 ("Input: twl6040-vibra - update for device tree support")

made the separate vibra DT node to a subnode of the twl6040.

It now calls of_find_node_by_name() to locate the "vibra" subnode.
This function has a side effect to call of_node_put on() for the twl6040
parent node passed in as a parameter. This causes trouble later on.

Solution: we must call of_node_get() before of_find_node_by_name()

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/misc/twl6040-vibra.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -264,6 +264,7 @@ static int twl6040_vibra_probe(struct pl
 	int vddvibr_uV = 0;
 	int error;
 
+	of_node_get(twl6040_core_dev->of_node);
 	twl6040_core_node = of_find_node_by_name(twl6040_core_dev->of_node,
 						 "vibra");
 	if (!twl6040_core_node) {
