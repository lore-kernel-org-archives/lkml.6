Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519836774-2-2724485478536602006
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
    t=1519836774; b=Tsz8FUq4j4cShs9dak3MnbJyNYezeksAcxB96QSHsuaFuq3
    HVzLolayY9qUitt6ZXDhvEf/oSxttPRD9Vnsm0OhXAH7XGIncj1NNgVQI9nezQqq
    8nLoZ8BYLBO6mkIuJbRaB+oK6f13NrYuxX7SHSHqsQYPRGxAUv/Pl2DHZkxW6lA4
    Kex2daDeyIVZ8qZIsSNJOwyouebLI0UyffN6niu86jRZcw0dkrE7oWtKG9nu/RXw
    Ik1gIUCkvndIGRvAcHqLIjLTYty2/t+LEtykr0HSwfoBxO8AOUNoLvfeA25BBgno
    j+Teu2JXZccgg0BdzkKxMlKKDty9ZxpLtCInN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836774; bh=BWcCQhGV/LRO50KpucM
    AgC9raNShEsMJ8MkrxwWejPs=; b=oAaOpJVjaKVdyCnrolD2MscMci5XooEoGOm
    NxX8H9/dZyrKcC+YREbXyfvAZeAxzF1+MQuaEOjbqYTMbdU3LUAUV4L+mz9vYclk
    RaHZIpvX8ue902YA3wOaDNJ/Bdj+U+/LUJFzw82N8S6Svrwtvug1AIvkzedTXvxp
    sM1xAo3UjO1ov0UdRC5QnNz9oigYFnjSW0vLKKOWY6BPbZefpBJaQqIrHR0COD9c
    4cw+4scKUceRZAg0BVb2Aqk7M+rm6e0RwXZD7Nw4HAVvSXeoWjRnvz73p2Xaiq73
    LLy1Sjy5tPAbMlgQuUHZbTxYJVrCIvZX2eKG+4287wbxx3/zJLA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeB1P6K (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:58:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34548 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752340AbeB1P6I (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Helge Deller" <deller@gmx.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.669401543@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 118/254] parisc: Hide Diva-built-in serial aux and
 graphics card
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

From: Helge Deller <deller@gmx.de>

commit bcf3f1752a622f1372d3252d0fea8855d89812e7 upstream.

Diva GSP card has built-in serial AUX port and ATI graphic card which simply
don't work and which both don't have external connectors.  User Guides even
mention that those devices shouldn't be used.
So, prevent that Linux drivers try to enable those devices.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/parisc/lba_pci.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1652,3 +1652,36 @@ void lba_set_iregs(struct parisc_device
 	iounmap(base_addr);
 }
 
+
+/*
+ * The design of the Diva management card in rp34x0 machines (rp3410, rp3440)
+ * seems rushed, so that many built-in components simply don't work.
+ * The following quirks disable the serial AUX port and the built-in ATI RV100
+ * Radeon 7000 graphics card which both don't have any external connectors and
+ * thus are useless, and even worse, e.g. the AUX port occupies ttyS0 and as
+ * such makes those machines the only PARISC machines on which we can't use
+ * ttyS0 as boot console.
+ */
+static void quirk_diva_ati_card(struct pci_dev *dev)
+{
+	if (dev->subsystem_vendor != PCI_VENDOR_ID_HP ||
+	    dev->subsystem_device != 0x1292)
+		return;
+
+	dev_info(&dev->dev, "Hiding Diva built-in ATI card");
+	dev->device = 0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QY,
+	quirk_diva_ati_card);
+
+static void quirk_diva_aux_disable(struct pci_dev *dev)
+{
+	if (dev->subsystem_vendor != PCI_VENDOR_ID_HP ||
+	    dev->subsystem_device != 0x1291)
+		return;
+
+	dev_info(&dev->dev, "Hiding Diva built-in AUX serial device");
+	dev->device = 0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_AUX,
+	quirk_diva_aux_disable);
