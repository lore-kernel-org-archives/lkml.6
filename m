Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3900284-1525416987-2-7862391532113010595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525416986; b=P+ov1PsNf0bDdmshsJq6xKhl24PYNEjt1jxgBgrBx9zg8LMJ9t
    PN7ubkPhx7ZW/TsVFvwQEFmPEhl1TWOWIYSvMa7op6Bary64tLmFIYC9xk0+Jd29
    0fpOgZXgp7dKuseChkrcXZx4Tv27rngqvLAgSbYlR4oqqtvMDqU5SblPKaRMvVUV
    r5bfbheVmjiSjGiumP7R60xCue11OS9CWQYn148N1ahz9DmR2nB9oEjBWYFb+2dv
    TALas1gOZqhqhs862CNNmxF4ItC0SUQBLSwsqh265BiUYjmkflCb0z60Ur+C7Dw2
    xutuV22JBzPu0M3s/2sPM6Q7ZF85aJvDLMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525416986;
    bh=iDD6nGKVRmOBCrXvUtAEFF9yE8a3oSSMCiwcoyGeb1A=; b=TKbXHMqoPXTb
    c+1ymPk8s8hWPVS0ibQ0S0w+hwVNXVQldx1ag/yyc60ttkU+SH0KfNyPg295roJ7
    hqJT4S06KPwrDC8wSWxejNVgLXIU9+lEvjapY2fLLB6W6LkLwf7IkjeUvTDvg70r
    y8cD5W2n3bhBRvnRQ7JK5k99TpjtxDP3ty8EaZbbA0G1Mg+YbWUqf8dWWr9RhunU
    DpZYWAcHoBPzCEAx1LrM7JVTS91hVbtKa9FZEXhr4naDRMgZLnc7qwnvLuQS7vYo
    rVea9VO5BM0LA/keE+O015NTwcYdGZmhn2NF2ckKVGfbf7xabNii3H19bKI4IEOD
    4siAWd1EdA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=pengutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=pengutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGZfPpGt/vmQXZ4m2+3Geg6ns+E7OLgssurecNlSKjY/iaAm9rarnWrsGeI7oyglHjlTlL6n86nPlWmzdkRvMVEwIvOBTjORipkCzwQ151t2EUPS+P4L
    1Hp4G6lJUcado0/YN+8HvEhdoyYkKpTePjPuXpxEoONtAs5rnsfuahK69SW9hROVrMh5Y14EASlsRYpe/4y7TNvT/A3qaD0RoEx70/aE2C7RDcuP+vpTR90I
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=8AirrxEcAAAA:8 a=uP1ucDPQAAAA:8 a=bGNZPXyTAAAA:8
    a=U-iezQoUQag7TEKD_b4A:9 a=nayMJLm4Q0NL7BzA:21 a=WPsQ9zoCSIu8POgn:21
    a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22 a=9a9ggB8z3XFZH39hjkD6:22
    a=yL4RfsBhuEsimFDS2qtJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEDG4Z (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 02:56:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36109 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeEDG4Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 May 2018 02:56:24 -0400
Date: Fri, 4 May 2018 08:56:21 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-mtd@lists.infradead.org
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: v4.4-stable: GPMI nand controller broken
Message-ID: <20180504065621.hclfdfxjxnobt4e7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:43:22 up 133 days, 15:01, 85 users,  load average: 1.03, 1.12,
 1.15
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following went into v4.4.120:

197190bc5c48 mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM

This patch was backported to far for the stable tree. It only makes sense
(and only works) together with:

bd2e778c9ee3 gpmi-nand: Handle ECC Errors in erased pages

which first appeared in v4.7.

So either we revert 197190bc5c48 on the v4.4 stable tree or we apply the
attached patch which is a backport of bd2e778c9ee3 for v4.4.

I don't know which solution is prefered, personally I would prefer
applying the attached patch which is also a bugfix. Without it erased
pages may not be handled properly.

Sascha

---------------------------8<-------------------------------

>From ec42023a83778e524a024bdd25d970b8dc7a3966 Mon Sep 17 00:00:00 2001
From: Markus Pargmann <mpa@pengutronix.de>
Date: Mon, 25 Apr 2016 14:35:12 +0200
Subject: [PATCH] gpmi-nand: Handle ECC Errors in erased pages

ECC is only calculated for written pages. As erased pages are not
actively written the ECC is always invalid. For this purpose the
Hardware BCH unit is able to check for erased pages and does not raise
an ECC error in this case. This behaviour can be influenced using the
BCH_MODE register which sets the number of allowed bitflips in an erased
page. Unfortunately the unit is not capable of fixing the bitflips in
memory.

To avoid complete software checks for erased pages, we can simply check
buffers with uncorrectable ECC errors because we know that any erased
page with errors is uncorrectable by the BCH unit.

This patch adds the generic nand_check_erased_ecc_chunk() to gpmi-nand
to correct erased pages. To have the valid data in the buffer before
using them, this patch moves the read_page_swap_end() call before the
ECC status checking for-loop.

Fixes: 197190bc5c48 ("mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM")
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
[Squashed patches by Stefan and Boris to check ECC area]
Tested-by: Stefan Christ <s.christ@phytec.de>
Acked-by: Han xu <han.xu@nxp.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 78 ++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index e2a239c1f40b..40a335c6b792 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1032,14 +1032,87 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	/* Loop over status bytes, accumulating ECC status. */
 	status = auxiliary_virt + nfc_geo->auxiliary_status_offset;
 
+	read_page_swap_end(this, buf, nfc_geo->payload_size,
+			   this->payload_virt, this->payload_phys,
+			   nfc_geo->payload_size,
+			   payload_virt, payload_phys);
+
 	for (i = 0; i < nfc_geo->ecc_chunk_count; i++, status++) {
 		if ((*status == STATUS_GOOD) || (*status == STATUS_ERASED))
 			continue;
 
 		if (*status == STATUS_UNCORRECTABLE) {
+			int eccbits = nfc_geo->ecc_strength * nfc_geo->gf_len;
+			u8 *eccbuf = this->raw_buffer;
+			int offset, bitoffset;
+			int eccbytes;
+			int flips;
+
+			/* Read ECC bytes into our internal raw_buffer */
+			offset = nfc_geo->metadata_size * 8;
+			offset += ((8 * nfc_geo->ecc_chunk_size) + eccbits) * (i + 1);
+			offset -= eccbits;
+			bitoffset = offset % 8;
+			eccbytes = DIV_ROUND_UP(offset + eccbits, 8);
+			offset /= 8;
+			eccbytes -= offset;
+			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
+			chip->read_buf(mtd, eccbuf, eccbytes);
+
+			/*
+			 * ECC data are not byte aligned and we may have
+			 * in-band data in the first and last byte of
+			 * eccbuf. Set non-eccbits to one so that
+			 * nand_check_erased_ecc_chunk() does not count them
+			 * as bitflips.
+			 */
+			if (bitoffset)
+				eccbuf[0] |= GENMASK(bitoffset - 1, 0);
+
+			bitoffset = (bitoffset + eccbits) % 8;
+			if (bitoffset)
+				eccbuf[eccbytes - 1] |= GENMASK(7, bitoffset);
+
+			/*
+			 * The ECC hardware has an uncorrectable ECC status
+			 * code in case we have bitflips in an erased page. As
+			 * nothing was written into this subpage the ECC is
+			 * obviously wrong and we can not trust it. We assume
+			 * at this point that we are reading an erased page and
+			 * try to correct the bitflips in buffer up to
+			 * ecc_strength bitflips. If this is a page with random
+			 * data, we exceed this number of bitflips and have a
+			 * ECC failure. Otherwise we use the corrected buffer.
+			 */
+			if (i == 0) {
+				/* The first block includes metadata */
+				flips = nand_check_erased_ecc_chunk(
+						buf + i * nfc_geo->ecc_chunk_size,
+						nfc_geo->ecc_chunk_size,
+						eccbuf, eccbytes,
+						auxiliary_virt,
+						nfc_geo->metadata_size,
+						nfc_geo->ecc_strength);
+			} else {
+				flips = nand_check_erased_ecc_chunk(
+						buf + i * nfc_geo->ecc_chunk_size,
+						nfc_geo->ecc_chunk_size,
+						eccbuf, eccbytes,
+						NULL, 0,
+						nfc_geo->ecc_strength);
+			}
+
+			if (flips > 0) {
+				max_bitflips = max_t(unsigned int, max_bitflips,
+						     flips);
+				mtd->ecc_stats.corrected += flips;
+				continue;
+			}
+
 			mtd->ecc_stats.failed++;
 			continue;
 		}
+
 		mtd->ecc_stats.corrected += *status;
 		max_bitflips = max_t(unsigned int, max_bitflips, *status);
 	}
@@ -1062,11 +1135,6 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->oob_poi[0] = ((uint8_t *) auxiliary_virt)[0];
 	}
 
-	read_page_swap_end(this, buf, nfc_geo->payload_size,
-			this->payload_virt, this->payload_phys,
-			nfc_geo->payload_size,
-			payload_virt, payload_phys);
-
 	return max_bitflips;
 }
 
-- 
2.17.0


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
