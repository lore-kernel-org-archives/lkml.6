Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826636-2-13251863904241146670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826636; b=Eo8XHU7zrhs5Kkg+VOrYjaw69ckwvMhZaLCnbWNB60Ik1Py
    VfmvyNbnqTyvX4c/1XHTs13S9VVOfUN7mIDp20Y0W8kRp0s0lqyNuA/gM/0Tl9gR
    sOUyp+qkVKMlwrUTpxoJGZakZo1LBsI/t1m0/PF+ynrSHeOISq1r+GKy6JtOKys2
    BflhLGc9JHxVNV0sgUzWsdNv/6vadBBzfBjcsUQXNzK50FfBEfNPpEye924xlccd
    oZ6b7A2FgZ7A55Ju5QZEDIzV5MU8CtgOM1FcvLMtDPVQyKSabTsyf5PsOw2e9tMp
    5scEttDaYYoNvA+jQ3cAjuuyqZm3pCzoHmgbQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826636; bh=7rD/NpxwHRy5FHRUHlW
    onTexXHhotM5vPVc49YWj6G8=; b=T2IkPek50WBvhqou+CJGp+POvejut4BnVAv
    ckiiaFHGGlKuGfE8V05xNcdBm0gMEbdLBqUx3SmiqP6rXlAR3cLo0iyBN7ou4D65
    kM0s+hbQhTxlCCtYH2pJy/kT01jZZn8vw7FTsMIfPg3mL/ZnH4in7qUo3WL5uNau
    mjZ21pV2y4VBLfcI/PGNNSmAbZLW0OxVq7R2REmfJvu5z3fWj8wetLpDyzRY2VOP
    za3Rvr5DPfUGVEFObmq38DxDjAgAttbuVghDPQSlSldFuFopJ1T88NI2OBaEOBid
    0HxWw/IWkTuhHL9jwoaquX+iCrNF53yiP45TGHbzrSQ+X+aCswQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeCLDue (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:50:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41045 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932585AbeCLDHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:39 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Syam Sidhardhan" <s.syam@samsung.com>,
        "Gustavo Padovan" <gustavo@padovan.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.103943495@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 002/104] Bluetooth: Remove unused hci_le_ltk_reply()
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Syam Sidhardhan <s.syam@samsung.com>

commit e10b9969f217c948c5523045f44eba4d3a758ff0 upstream.

In this API, we were using sizeof operator for an array
given as function argument, which is invalid.
However this API is not used anywhere.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         | 16 ----------------
 2 files changed, 17 deletions(-)

--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -912,7 +912,6 @@ void hci_le_conn_update(struct hci_conn
 					u16 latency, u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
-void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
 #endif /* __HCI_CORE_H */
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -225,22 +225,6 @@ void hci_le_start_enc(struct hci_conn *c
 }
 EXPORT_SYMBOL(hci_le_start_enc);
 
-void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16])
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_cp_le_ltk_reply cp;
-
-	BT_DBG("%p", conn);
-
-	memset(&cp, 0, sizeof(cp));
-
-	cp.handle = cpu_to_le16(conn->handle);
-	memcpy(cp.ltk, ltk, sizeof(ltk));
-
-	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
-}
-EXPORT_SYMBOL(hci_le_ltk_reply);
-
 void hci_le_ltk_neg_reply(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
