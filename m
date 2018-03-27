Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174005-2-1498309651520789569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174005; b=sRqaj06WCR5eT/9Bk+KK+ZP+Cmrke7wA617o0FX6npkN0va
    ZvIp1vOxB9CdOmtle+rEOm5wlUR6T6Xc4YI282Nc+p5tRJiERp0ikigFwSuaIZkj
    b2o5zgZlnNUBfRDSIkWUQQW5kxEGXfng2d4pC5YVKKs9Oxs79QQke0S3vyz+IpP5
    CG2IGtV0GuCpUmcQq4u1bgH7GAs1RqeBZdoc4j3/Kn/lDtlXp2NS083CtmRADR04
    jMlVm9v2BbPcZtn3d+r3cY+EUqtcBt55b1PYahS/aBwlF3zjE/jMkUQq0HhNyV9T
    dGyRwwlwDayEcDcAgxv6X9jfW+phk3LRjuaSRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174005; bh=UlEPmGP/T7QnhwO1qO4/EDae3h
    o5kCFtirDBTMLChNU=; b=DQNE8Jr23GASIXcgWZvsOhrc+JKZ5Eth8GekXnsoUa
    sKL4lsPPrqi2ycdZefJ+a5NUk1hI47/4WuXdHNQgB38oQPVawkOZARfEzRYpvTb5
    2BcpPzeOHDIoAG7UoNS0RmgK+qkuNQ6E4Xj1oAEV48eUaT1x/YljguP6i+Uwf6Lz
    538v18p8oaNyDUjM7qC+CiV7cPj3GPxpZDAPdBsdZ5On2Te399fZfFSy8gBJyZrv
    bpRypYU639Sk71A1OuowEEvF570nGetyq9sMZqqPhckSO3ZINtyqe2/tZ7IRx3qF
    Vp5Wvd0IYBJgmtfWD469J2SjUANFkVbD7GcEY3xj+I4Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfJBOyi4V4xNGIBj9p9uWUT7vHecWbATGK1m4crGXe1DAIzTMerMezt/eZlXHMfjRPQIx57DdnrC8KJGEInJ8JL7Q5dchkjXU89vx2D+vv0C+OPMOZuDs
    wJes57dHqYmXZsXX3h7G2QQ6mpTolHj1fqy3IUVpFiiJZQmS+Wi21Gcw53tJPsLuou/o0zLrx9Ccs8/VTEDj944ff5Szt2f6Bq7YTw+VtGWSqU2tTRFji9bM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8
    a=ucCKOs8ZBpaG-wBlNMIA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750922AbeC0SFr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:05:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41408 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbeC0Q3g (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jagdish Gediya <jagdish.gediya@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.4 29/43] mtd: nand: fsl_ifc: Fix nand waitfunc return value
Date: Tue, 27 Mar 2018 18:27:33 +0200
Message-Id: <20180327162718.054406593@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jagdish Gediya <jagdish.gediya@nxp.com>

commit fa8e6d58c5bc260f4369c6699683d69695daed0a upstream.

As per the IFC hardware manual, Most significant 2 bytes in
nand_fsr register are the outcome of NAND READ STATUS command.

So status value need to be shifted and aligned as per the nand
framework requirement.

Fixes: 82771882d960 ("NAND Machine support for Integrated Flash Controller")
Cc: stable@vger.kernel.org # v3.18+
Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Reviewed-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/fsl_ifc_nand.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -726,6 +726,7 @@ static int fsl_ifc_wait(struct mtd_info
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 	u32 nand_fsr;
+	int status;
 
 	/* Use READ_STATUS command, but wait for the device to be ready */
 	ifc_out32((IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
@@ -740,12 +741,12 @@ static int fsl_ifc_wait(struct mtd_info
 	fsl_ifc_run_command(mtd);
 
 	nand_fsr = ifc_in32(&ifc->ifc_nand.nand_fsr);
-
+	status = nand_fsr >> 24;
 	/*
 	 * The chip always seems to report that it is
 	 * write-protected, even when it is not.
 	 */
-	return nand_fsr | NAND_STATUS_WP;
+	return status | NAND_STATUS_WP;
 }
 
 static int fsl_ifc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
