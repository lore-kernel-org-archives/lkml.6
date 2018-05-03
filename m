Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1656041-1525314111-2-10431121717614104076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='nz',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525314110; b=eIB1dBqTQg/U+tUY5wzP2/xFrKJF2psfGGhRZABx46iHXaW7+7
    LETjKItzdKDTIz9mwf06wzWCWLH7WQh7CGBUg6BJlTcl6aZSbWLzUNdWJSpuwS2f
    IrCzwXoTJ56kgzHcCjPvUZX2F2ct6miXbR8SxCbHSPs3TESOtpZOxTx4NzHTRgPX
    QINL3r4t2E8oMoWVHvON3iPt6L3yixUZqmnOWQUgNl8au8B9dyHXwlqu03+Madsd
    lKymwuxfbR38q4f12Bbf+vnevF6fSxSdKqwK4W+5cLGaDzuTgZi71k0wW1nzxDsf
    XDoEU2Y5dLaInFbjckBOOMibXoMbBQWS6fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525314110; bh=xubPi4fOiCwBp5jibacT2uQnQmlkS/
    WAvE35GWbWdto=; b=DUS90pBL1iOVwwq2vtgY9Gj4nc+prIXytd9MxwK1YiLF+i
    oyAs2S79AIcPrwXEQ5kaOmJ7fYfwwFsJQWnDAHmTMC/OyVvE3WTz2dSL3kf/4dgQ
    OtKE4y/y8SSBma9ThQGw541VJB65vctYYRnlyRuwHbjqF+744wGEST4Y9575ms3O
    vWjfewtwpi6JdAqIaDWmWN7kCB40xz5NvBDCKSNrNnpfxqQWr85Gtas4zk2L1xJr
    H+W5OtqRlsrlifQvu4WGe0Z6V1Z8qvfKGEhN6ppvKLlIjTJdnV2XtWfQwLsyjOwe
    2u3nN3RNpULeFqcOYaoTQoM+v7eed32WZe37iuHg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=alliedtelesis.co.nz
    header.i=@alliedtelesis.co.nz header.b=Eq1szInE x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none)
    header.from=alliedtelesis.co.nz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=alliedtelesis.co.nz header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=alliedtelesis.co.nz
      header.i=@alliedtelesis.co.nz header.b=Eq1szInE x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none)
      header.from=alliedtelesis.co.nz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=alliedtelesis.co.nz header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHPVdFM0YI5JNSkqJcAacDcGIW5iVn7cBR4V0uhGd0c7Cc/hcmcBWYcaJ5uY//1tzDtRntuyDBfRGOkE/BJVi6ZN3j5vnx8lZ5qdMCTFFXwaBlXhhF0s
    4GGcPpuN2iFZUVuvkF+rM/k1wQzVyW98IoUojNMCjAjCSV286/8ttm+R2CD6oIcOpVL83sTX9UwULAHOyav+nMRxvN5ZmuTIQBDkW0pGdYYcn+gagNnNsZ+P
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=4aEAohT2_9LeTJTm9NIA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeECCVq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 22:21:46 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47181 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeECCVp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 22:21:45 -0400
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: miquel.raynal@bootlin.com, boris.brezillon@bootlin.com
Cc: linux-mtd@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: marvell: pass ms delay to wait_op
Date: Thu,  3 May 2018 14:21:28 +1200
Message-Id: <20180503022128.10702-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

marvell_nfc_wait_op() expects the delay to be expressed in milliseconds
but nand_sdr_timings uses picoseconds. Use PSEC_TO_MSEC when passing
tPROG_max to marvell_nfc_wait_op().

Fixes: 02f26ecf8c772 ("mtd: nand: add reworked Marvell NAND controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/mtd/nand/raw/marvell_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 1d779a35ac8e..e4b964fd40d8 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -1074,7 +1074,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 		return ret;
 
 	ret = marvell_nfc_wait_op(chip,
-				  chip->data_interface.timings.sdr.tPROG_max);
+				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
 	return ret;
 }
 
@@ -1494,7 +1494,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct mtd_info *mtd,
 	}
 
 	ret = marvell_nfc_wait_op(chip,
-				  chip->data_interface.timings.sdr.tPROG_max);
+				  PSEC_TO_MSEC(chip->data_interface.timings.sdr.tPROG_max));
 
 	marvell_nfc_disable_hw_ecc(chip);
 
-- 
2.17.0
