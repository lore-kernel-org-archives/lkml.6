Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281303-2-12624552500896894726
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281302; b=bYJs/OncXsQpM4lM9Ect94iYXn7vR6hfEg/NUTviW/l7MirqMA
    lTVjFzqSXTH2n5Zpy4LhFBGPMScmFirjb9rzDc0ptX8paKzWReOtPF87jrYURagW
    CHXoBIKN5sPE3ZEvxsl4TDuhG+VSPu18rVnee19jFOSe6su1EnUYpNcMM+oMCric
    cHpgqScKRGyZdryCVqHSWEO0r4hYEpWr+ceAM5VeNGMYt+MKBLOjEwvZrw+vMSlK
    1A1+hFqFeq8w+OqyeDewr78DCbEqMmUCJLkAdti1PsjVfuAuki94Lch/jfY04RSR
    9qBl9ZPIdVFXDTQyeWBw6WvIzDYNErfugzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281302; bh=2ZDcaj6i85fAGSQS5weI1aRZBtFM27
    aoo4vjnBz8YFE=; b=Sw1GA1osGX5wGEJLCw+V89j18GFy58UEyWoN3LisKC9nto
    hCny4LsBHn9eRm9P3VG+qbowKMD+UPdeFcisqNbtwXms/e+5xooqz0VlDh6himz2
    5wY8GYHrN9fvRrVyfIp8/67gRTQHFxxgI/OUyHdqQTvQvwXGU5ubPqx9HtRJ9s0o
    pu1j4k7DrH/FSraCnmLfwmVU/BX74P4UAdC+Z/hNNu0dFOP4yLTcjCsoxDaA5zyh
    b6pjteG+iH5QRf09KMdHng1TXzCzetd4E4rhoftDW27uVU38gt5o3R19ajXnrU57
    MdRZxg8JYp2vb3wHZiMj45hkZb7aMaqYsCMeGUDQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=z3Uinh4H x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=z3Uinh4H x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK1IIPxP59LolI6Z6OoY8xD4HzkrxIvCUf0q/xe77tmiyM4Wo9l6AJ1LW9Ih3EP7x+wy9966J3eBaxcww/163RuGYB00y+CScowsFdzRWSL9iDiOQDtN
    URrgluCNojWLEKNBzcH2NWLYh7hPwrHdjZBJGpmnIq0NLcuqmb73bR/ONw1YemGNey9dQOe80i1X/Dk84bV3Oa5NO5nZ7eqO/xrsib8U+misHzZtJMEsI7vZ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=LT5gBJ_D0TxnlAYQ6SQA:9
    a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754257AbeENHBO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932148AbeENHAy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.16 40/72] mtd: rawnand: marvell: fix command xtype in BCH write hook
Date: Mon, 14 May 2018 08:48:57 +0200
Message-Id: <20180514064824.897731811@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit a2ee41fd953e7c3ff6c55a3038c80354d191a318 upstream.

One layout supported by the Marvell NAND controller supports NAND pages
of 2048 bytes, all handled in one single chunk when using BCH with a
strength of 4-bit per 512 bytes. In this case, instead of the generic
XTYPE_WRITE_DISPATCH/XTYPE_LAST_NAKED_RW couple, the controller expects
to receive XTYPE_MONOLITHIC_RW.

This fixes problems at boot like:

[    1.315475] Scanning device for bad blocks
[    3.203108] marvell-nfc f10d0000.flash: Timeout waiting for RB signal
[    3.209564] nand_bbt: error while writing BBT block -110
[    4.243106] marvell-nfc f10d0000.flash: Timeout waiting for RB signal
[    5.283106] marvell-nfc f10d0000.flash: Timeout waiting for RB signal
[    5.289562] nand_bbt: error -110 while marking block 2047 bad
[    6.323106] marvell-nfc f10d0000.flash: Timeout waiting for RB signal
[    6.329559] nand_bbt: error while writing BBT block -110
[    7.363106] marvell-nfc f10d0000.flash: Timeout waiting for RB signal
[    8.403105] marvell-nfc f10d0000.flash: Timeout waiting for RB signal
[    8.409559] nand_bbt: error -110 while marking block 2046 bad
...

Fixes: 02f26ecf8c772 ("mtd: nand: add reworked Marvell NAND controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/marvell_nand.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/marvell_nand.c
+++ b/drivers/mtd/nand/marvell_nand.c
@@ -1404,6 +1404,7 @@ marvell_nfc_hw_ecc_bch_write_chunk(struc
 	struct marvell_nand_chip *marvell_nand = to_marvell_nand(chip);
 	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
 	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
+	u32 xtype;
 	int ret;
 	struct marvell_nfc_op nfc_op = {
 		.ndcb[0] = NDCB0_CMD_TYPE(TYPE_WRITE) | NDCB0_LEN_OVRD,
@@ -1419,7 +1420,12 @@ marvell_nfc_hw_ecc_bch_write_chunk(struc
 	 * last naked write.
 	 */
 	if (chunk == 0) {
-		nfc_op.ndcb[0] |= NDCB0_CMD_XTYPE(XTYPE_WRITE_DISPATCH) |
+		if (lt->nchunks == 1)
+			xtype = XTYPE_MONOLITHIC_RW;
+		else
+			xtype = XTYPE_WRITE_DISPATCH;
+
+		nfc_op.ndcb[0] |= NDCB0_CMD_XTYPE(xtype) |
 				  NDCB0_ADDR_CYC(marvell_nand->addr_cyc) |
 				  NDCB0_CMD1(NAND_CMD_SEQIN);
 		nfc_op.ndcb[1] |= NDCB1_ADDRS_PAGE(page);
