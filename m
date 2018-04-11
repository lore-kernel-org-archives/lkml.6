Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477489-2-2090969353957195307
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477488; b=jenbBzQ+zlR4pHxXs/k8kzD3drq/ZaYUQ5V3YfOF7waONrM4ZY
    6CvffeX974CH973v9c48Rjmyq3PcG/x27x9UpZ1mAd/1ZDOLU9ltNBd8H9Y5prI8
    /7GpdnHsnuoYJXW7ROMyLYNYmreEXmRsbg+eETa4vnc5+SAfeHTY2i09M8TXfzrW
    jbM/cHBUFLD9zc7/Y6R7xa1FHMTAtiASdsIzWQMRzEKlW9+dKG+1/lcJqB3bHLGu
    swcCAvaBlhOD2fok8QikATE2C/jv8uxZvPJD9GSHBn1aUSvSz9M5BdIFadrgB8uG
    W0E6VhVLv0MpM7v9zM9w2Fk6CB0Oc58KAbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477488; bh=hE1itpdEuoggQdDxZDjH3/ciDjLxHU
    kDdbl9DEJhh+E=; b=SYPSlCq2uBq431Cu9WbfQ1twVrpEgR9BzMc0HGzGlTee3j
    m7FVnoVQrtW9bm1mFN9h9fOT661H9HTTO0POPJlYNYzcKj8YWMwbDO1LcbGgLcRH
    4LWOCpkdNjVxupJ/cR6PQrwcVOtKAKpboMBPs2n4vKWgRONAmEmfHBvd96d/M3aB
    0SjFni5pS99iGzGcWhiqwEjdpR3Yo5Oy7MpgDKB5HjiMR9fWlHX6VDCpC1fmRSjq
    Q1c6CsyeuxIynnZolKyZWW3tkWc6/rT7/kKsMj7mMdnWqXkLclRq6rxoRkzhD57n
    /Jrgjpg2AtFJsoE9dRPyMki9pwI3hyj0n67CAVeg==
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
X-CM-Envelope: MS4wfHr8GHLy7BUsxUECU74M40pVikd2kk4TYtVqSAzFyMvmYj3+FtLcAmnWkkdiHe3ghsOJzkpKK1d4a4fmf5WSyDMPsBRKlkv+cQUA+fQ91UzWdXathSuE
    2SxwOTGL6zDB1Y7NSuj7Fgfkjf1Rb3YDvmRSVM/bQtvJPAI6du8F1hQ4EH0gB7q13Xe0kY4GC6DBVFqtqWYKRWjuGHBul9ElGXbHqYpfT7NiTcnLknzXqHfl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=yhoxnxGeVW0gzB0m1KEA:9
    a=T1J3hCco9ZppPjOH:21 a=vTWGwHAHXQcAkDfl:21 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933469AbeDKSyX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34402 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932610AbeDKSyO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 041/310] bus: brcmstb_gisb: correct support for 64-bit address output
Date: Wed, 11 Apr 2018 20:33:00 +0200
Message-Id: <20180411183624.035426311@linuxfoundation.org>
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

From: Doug Berger <opendmb@gmail.com>


[ Upstream commit 0c2aa0e4b308815e877601845c1a89913f9bd2b9 ]

The GISB bus can support addresses beyond 32-bits.  So this commit
corrects support for reading a captured 64-bit address into a 64-bit
variable by obtaining the high bits from the ARB_ERR_CAP_HI_ADDR
register (when present) and then outputting the full 64-bit value.

It also removes unused definitions.

Fixes: 44127b771d9c ("bus: add Broadcom GISB bus arbiter timeout/error handler")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/brcmstb_gisb.c |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -37,8 +37,6 @@
 #define  ARB_ERR_CAP_CLEAR		(1 << 0)
 #define  ARB_ERR_CAP_STATUS_TIMEOUT	(1 << 12)
 #define  ARB_ERR_CAP_STATUS_TEA		(1 << 11)
-#define  ARB_ERR_CAP_STATUS_BS_SHIFT	(1 << 2)
-#define  ARB_ERR_CAP_STATUS_BS_MASK	0x3c
 #define  ARB_ERR_CAP_STATUS_WRITE	(1 << 1)
 #define  ARB_ERR_CAP_STATUS_VALID	(1 << 0)
 
@@ -47,7 +45,6 @@ enum {
 	ARB_ERR_CAP_CLR,
 	ARB_ERR_CAP_HI_ADDR,
 	ARB_ERR_CAP_ADDR,
-	ARB_ERR_CAP_DATA,
 	ARB_ERR_CAP_STATUS,
 	ARB_ERR_CAP_MASTER,
 };
@@ -57,7 +54,6 @@ static const int gisb_offsets_bcm7038[]
 	[ARB_ERR_CAP_CLR]	= 0x0c4,
 	[ARB_ERR_CAP_HI_ADDR]	= -1,
 	[ARB_ERR_CAP_ADDR]	= 0x0c8,
-	[ARB_ERR_CAP_DATA]	= 0x0cc,
 	[ARB_ERR_CAP_STATUS]	= 0x0d0,
 	[ARB_ERR_CAP_MASTER]	= -1,
 };
@@ -67,7 +63,6 @@ static const int gisb_offsets_bcm7400[]
 	[ARB_ERR_CAP_CLR]	= 0x0c8,
 	[ARB_ERR_CAP_HI_ADDR]	= -1,
 	[ARB_ERR_CAP_ADDR]	= 0x0cc,
-	[ARB_ERR_CAP_DATA]	= 0x0d0,
 	[ARB_ERR_CAP_STATUS]	= 0x0d4,
 	[ARB_ERR_CAP_MASTER]	= 0x0d8,
 };
@@ -77,7 +72,6 @@ static const int gisb_offsets_bcm7435[]
 	[ARB_ERR_CAP_CLR]	= 0x168,
 	[ARB_ERR_CAP_HI_ADDR]	= -1,
 	[ARB_ERR_CAP_ADDR]	= 0x16c,
-	[ARB_ERR_CAP_DATA]	= 0x170,
 	[ARB_ERR_CAP_STATUS]	= 0x174,
 	[ARB_ERR_CAP_MASTER]	= 0x178,
 };
@@ -87,7 +81,6 @@ static const int gisb_offsets_bcm7445[]
 	[ARB_ERR_CAP_CLR]	= 0x7e4,
 	[ARB_ERR_CAP_HI_ADDR]	= 0x7e8,
 	[ARB_ERR_CAP_ADDR]	= 0x7ec,
-	[ARB_ERR_CAP_DATA]	= 0x7f0,
 	[ARB_ERR_CAP_STATUS]	= 0x7f4,
 	[ARB_ERR_CAP_MASTER]	= 0x7f8,
 };
@@ -109,9 +102,13 @@ static u32 gisb_read(struct brcmstb_gisb
 {
 	int offset = gdev->gisb_offsets[reg];
 
-	/* return 1 if the hardware doesn't have ARB_ERR_CAP_MASTER */
-	if (offset == -1)
-		return 1;
+	if (offset < 0) {
+		/* return 1 if the hardware doesn't have ARB_ERR_CAP_MASTER */
+		if (reg == ARB_ERR_CAP_MASTER)
+			return 1;
+		else
+			return 0;
+	}
 
 	if (gdev->big_endian)
 		return ioread32be(gdev->base + offset);
@@ -119,6 +116,16 @@ static u32 gisb_read(struct brcmstb_gisb
 		return ioread32(gdev->base + offset);
 }
 
+static u64 gisb_read_address(struct brcmstb_gisb_arb_device *gdev)
+{
+	u64 value;
+
+	value = gisb_read(gdev, ARB_ERR_CAP_ADDR);
+	value |= (u64)gisb_read(gdev, ARB_ERR_CAP_HI_ADDR) << 32;
+
+	return value;
+}
+
 static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
 {
 	int offset = gdev->gisb_offsets[reg];
@@ -185,7 +192,7 @@ static int brcmstb_gisb_arb_decode_addr(
 					const char *reason)
 {
 	u32 cap_status;
-	unsigned long arb_addr;
+	u64 arb_addr;
 	u32 master;
 	const char *m_name;
 	char m_fmt[11];
@@ -197,10 +204,7 @@ static int brcmstb_gisb_arb_decode_addr(
 		return 1;
 
 	/* Read the address and master */
-	arb_addr = gisb_read(gdev, ARB_ERR_CAP_ADDR) & 0xffffffff;
-#if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
-	arb_addr |= (u64)gisb_read(gdev, ARB_ERR_CAP_HI_ADDR) << 32;
-#endif
+	arb_addr = gisb_read_address(gdev);
 	master = gisb_read(gdev, ARB_ERR_CAP_MASTER);
 
 	m_name = brcmstb_gisb_master_to_str(gdev, master);
@@ -209,7 +213,7 @@ static int brcmstb_gisb_arb_decode_addr(
 		m_name = m_fmt;
 	}
 
-	pr_crit("%s: %s at 0x%lx [%c %s], core: %s\n",
+	pr_crit("%s: %s at 0x%llx [%c %s], core: %s\n",
 		__func__, reason, arb_addr,
 		cap_status & ARB_ERR_CAP_STATUS_WRITE ? 'W' : 'R',
 		cap_status & ARB_ERR_CAP_STATUS_TIMEOUT ? "timeout" : "",
