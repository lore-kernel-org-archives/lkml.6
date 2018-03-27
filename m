Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-22565-1522169039-2-982108276625571976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522169038; b=v2QCHYEI+q48EDfJZ5slVikqk23nX54MbNRo4MixcQLZP8U
    i2bXmzf52uOV6ORwMo+tedOlARmswd3Zytu4aZkVC4hA7dK19qarBRSrts0Nwt5N
    pSbyRo8EEz53pIYq1n0KiCSK8UvAToH19/biCBvkCcKnQO4W31zpZK3xAYqIa8Qb
    6GF6st5ZhvWVE9PA1aecXyun7qYh3G89TrEi2LsS4VaRCWvbng0rYbdoqHYwVFrn
    /W4bIxsNhFq+apGMhz9jajnhwcsSTQzbrIyH4wvCFUo3iFuPUqXibVNccWZ3oX0d
    ZGa9JIO1HRuIF7hC240HLVoPlKD3jf1kDjsxtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522169038; bh=Y1C8ma9KQfAhqs255S5sd4LRDz
    pSMKAAfr9VfSeVy4Q=; b=k17atyayGo1cK2WY1IQRpQXjDAZDMlvf6B4m1hZHLa
    DbZW0jsI5/RHcSiZCCYKQJ0DIivCD+7CGoBbmGo5bUGGNbkC78ZSPdW9CKt9d+zx
    gCdyrVUXdO1FoNxYlplX8pr+TvS14P7EZ9rDjs81DvgkmRYx6NAWuEGs4MZAUPz0
    jK92Dg7CJIBLVMAaZWfF4uOQukGI9AVj/RKdpqS0QGIntqTKydwxtmME53CfGC1R
    6D1f7OhNHU4gkmUaXDupfd5nvSWv9axXfcnCXcYVua5ooJxJld+adsVLHxVtfkam
    7B4Q3RNqZu5wEkyPRYYXQ0ssi6Pcbf64IWYjsX3UabGQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfEztkJ1sqcLDwwjv/8pKcZhHsx8ZGRswG1Ce/P1FcRlr7QVVWr1C3FsyEVC+WYrEIw78NE8cQ+e3XLv5uD8D7FlOQ2uHRCuEyA4N+oyKkr8Iarx3YNmb
    nv6r6s0UqFPdqkN/aJLlncTFzUgDg/k5+zMZXXGnnHVsxKhTNQh6V2T9KWrtQaxXLjLwO30fdUe53j6OSHNgdwmyhwPeGr4ZUhOc8SZTmTU/MBaX1b0IC5ct
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8
    a=NKU_7g4Tm1YdhWV8ZxMA:9 a=B34RNk_T7wKlamwR:21 a=cCwcmhCSoBL2R95D:21
    a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22 a=AjGcO6oz07-iQ99wixmX:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755608AbeC0Qno (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:43:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbeC0Qnm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:43:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Jagdish Gediya <jagdish.gediya@nxp.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.15 072/105] mtd: nand: fsl_ifc: Fix eccstat array overflow for IFC ver >= 2.0.0
Date: Tue, 27 Mar 2018 18:27:52 +0200
Message-Id: <20180327162802.398095596@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jagdish Gediya <jagdish.gediya@nxp.com>

commit 843c3a59997f18060848b8632607dd04781b52d1 upstream.

Number of ECC status registers i.e. (ECCSTATx) has been increased in IFC
version 2.0.0 due to increase in SRAM size. This is causing eccstat
array to over flow.

So, replace eccstat array with u32 variable to make it fail-safe and
independent of number of ECC status registers or SRAM size.

Fixes: bccb06c353af ("mtd: nand: ifc: update bufnum mask for ver >= 2.0.0")
Cc: stable@vger.kernel.org # 3.18+
Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/fsl_ifc_nand.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -173,14 +173,9 @@ static void set_addr(struct mtd_info *mt
 
 /* returns nonzero if entire page is blank */
 static int check_read_ecc(struct mtd_info *mtd, struct fsl_ifc_ctrl *ctrl,
-			  u32 *eccstat, unsigned int bufnum)
+			  u32 eccstat, unsigned int bufnum)
 {
-	u32 reg = eccstat[bufnum / 4];
-	int errors;
-
-	errors = (reg >> ((3 - bufnum % 4) * 8)) & 15;
-
-	return errors;
+	return  (eccstat >> ((3 - bufnum % 4) * 8)) & 15;
 }
 
 /*
@@ -193,7 +188,7 @@ static void fsl_ifc_run_command(struct m
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_nand_ctrl *nctrl = ifc_nand_ctrl;
 	struct fsl_ifc_runtime __iomem *ifc = ctrl->rregs;
-	u32 eccstat[4];
+	u32 eccstat;
 	int i;
 
 	/* set the chip select for NAND Transaction */
@@ -228,8 +223,8 @@ static void fsl_ifc_run_command(struct m
 	if (nctrl->eccread) {
 		int errors;
 		int bufnum = nctrl->page & priv->bufnum_mask;
-		int sector = bufnum * chip->ecc.steps;
-		int sector_end = sector + chip->ecc.steps - 1;
+		int sector_start = bufnum * chip->ecc.steps;
+		int sector_end = sector_start + chip->ecc.steps - 1;
 		__be32 *eccstat_regs;
 
 		if (ctrl->version >= FSL_IFC_VERSION_2_0_0)
@@ -237,10 +232,12 @@ static void fsl_ifc_run_command(struct m
 		else
 			eccstat_regs = ifc->ifc_nand.v1_nand_eccstat;
 
-		for (i = sector / 4; i <= sector_end / 4; i++)
-			eccstat[i] = ifc_in32(&eccstat_regs[i]);
+		eccstat = ifc_in32(&eccstat_regs[sector_start / 4]);
+
+		for (i = sector_start; i <= sector_end; i++) {
+			if (i != sector_start && !(i % 4))
+				eccstat = ifc_in32(&eccstat_regs[i / 4]);
 
-		for (i = sector; i <= sector_end; i++) {
 			errors = check_read_ecc(mtd, ctrl, eccstat, i);
 
 			if (errors == 15) {
