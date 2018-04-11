Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473193-2-13086245807439997053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473192; b=ck3/v+RWQrPY7YwSoHUedLWpqLaHkG1lpLup5SpT5y5Y9Df5+F
    h2KoZX8toda1JU6QsaDM+TK0KPYE3lgfYtNeqdlCzcZICHxNXLtxtuVWiVls54C1
    NbpDeAL1u+zI7WhP7C2jkGh7e5bHU+va0t9MOCuDZtapMZvQWYBZLD/wSSbqAy87
    g9wy6vjwZ9+nSOd/X9ezeGNiPh2rDLxVayOIgvt4cxegLXO4ICIi4Z/yK2XzdSIx
    fnDDiNHffXMLbzT71kqus18PHAh0RIj3AyWI80j6TP0RuJmJKlgi5vsT70h8h12/
    AhHZzqUiZ1kwrIDThvYHQmQov9hN1N57my0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473192; bh=Eo2ug4AEVp8Zhb0QmXPITzvRsnJlpv
    xlLt24EgnQBsc=; b=uz4cmY4MkYoRrOIFHfVr9qzd2LsDZZBOekNZze4U05T5fj
    wHCm9aNSMKJWKqEhWr1WPRcKulnnberxN7Et4svIwbCFEm39/2m+lGZ/cuVgoDv9
    8Aurn8fmSrPTdUl5NqKNlA6/Xo71QocjarUkawOZIJSiwPmJ7b8g5SopkvLOPHRS
    II+qCKvGDBLUtJBZ614F4X2U6ZASN1+uNOpYSrjQorh9oja9Gs0MCO9clIv10L2d
    TB0i/SFvwDiwUZBy4yrhbHZUO4vCO0BTckFVTB3r3iimL2JMVuffJusGKfZ2h8Rv
    ydGdF88bWX8yqiqy7JAR+1zKX66ebEAaQX47dW8g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfGLD2vguUb1N14kO3I6YV4gwGdQpRTpzxACuqg0kPcpHNkajdgzlOTBvZHaTwLyUqk2pkBOHjLDH0f9Ix9LPlx9XXPiMjgyyNLzOv/VyzdYk+wsLzqUP
    lxMiFs+XJmeRlLk1PQoFuXo5K3ZgNkRkqd3XL37IZR3cRhMZzMxPsuTkdWLI4JdLj1aijCWaTVIjCH/wXzUVgB1AbVlXofNL7NedXoBaItm8UuQkiQNoQ3RD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AGRr4plBAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=w9mbZPsughNlnzgq46IA:9 a=QEXdDO2ut3YA:10 a=bOnWt3ThIoLzEnqt84vq:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756582AbeDKS7t (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:59:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756576AbeDKS7q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:59:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arjun Vynipadath <arjun@chelsio.com>,
        Casey Leedom <leedom@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 158/310] cxgb4: FW upgrade fixes
Date: Wed, 11 Apr 2018 20:34:57 +0200
Message-Id: <20180411183629.196465448@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arjun Vynipadath <arjun@chelsio.com>


[ Upstream commit 26747211486c5bc7dd014c3caab206576e00c0d0 ]

Disable FW_OK flag while flashing Firmware. This will help to fix any
potential mailbox timeouts during Firmware flash.

Grab new devlog parameters after Firmware restart. When we FLASH new
Firmware onto an adapter, the new Firmware may have the Firmware Device Log
located at a different memory address or have a different size for it.

Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -6185,13 +6185,18 @@ int t4_fw_upgrade(struct adapter *adap,
 	if (!t4_fw_matches_chip(adap, fw_hdr))
 		return -EINVAL;
 
+	/* Disable FW_OK flag so that mbox commands with FW_OK flag set
+	 * wont be sent when we are flashing FW.
+	 */
+	adap->flags &= ~FW_OK;
+
 	ret = t4_fw_halt(adap, mbox, force);
 	if (ret < 0 && !force)
-		return ret;
+		goto out;
 
 	ret = t4_load_fw(adap, fw_data, size);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/*
 	 * Older versions of the firmware don't understand the new
@@ -6202,7 +6207,17 @@ int t4_fw_upgrade(struct adapter *adap,
 	 * its header flags to see if it advertises the capability.
 	 */
 	reset = ((be32_to_cpu(fw_hdr->flags) & FW_HDR_FLAGS_RESET_HALT) == 0);
-	return t4_fw_restart(adap, mbox, reset);
+	ret = t4_fw_restart(adap, mbox, reset);
+
+	/* Grab potentially new Firmware Device Log parameters so we can see
+	 * how healthy the new Firmware is.  It's okay to contact the new
+	 * Firmware for these parameters even though, as far as it's
+	 * concerned, we've never said "HELLO" to it ...
+	 */
+	(void)t4_init_devlog_params(adap);
+out:
+	adap->flags |= FW_OK;
+	return ret;
 }
 
 /**
