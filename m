Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518711414-5-1563691180425951119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711414; b=IfcrZHzC86arg/P5R9fHB0PvcAsjvw7yv4dtgbP4VYD1GYa
    hherGZa9FRuxhahpoBhsNddZH0VhEkeT/EMen8nTm3bYBtzd8gDq15IULWujKrHy
    vLOhCGvf7P2P/wjoo3DMYy8zkQ9B4j6EQ5DBf4LyYbZ/kDRl+j88MkGDG9MozXPz
    ZQddRoMm5rlKYACNHFuFXwu7B7Cxm1sn7pCZptGm7TP5zggjTW8JLkp3+sHajVZG
    zN9WlyOoX61oNY6g9RcKJizsjvBLq1ptcFJie3+SGLC8k9IqswbFuP+ZtDeZXICs
    TXL5fixC1bfoXZiW/WfiXU//3CXm6KbiyHVl7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711414; bh=OnlrOFz5Z4FnuAt+oL51u/ROt7
    51hGYi4jBWgz9qfD4=; b=sbatfgUWIu3PEbztaUywl45r6VqkZkuTgisgVLSjhN
    z6sVwDY04YiR+itgQYUYsHMyGoFyctTkt3SA0Dg6IKGJifxE15KMgM8hNN0cKibT
    P1asOMPTPnMUqPGAqokCB6EvkzqyI0ZRbDlbjrlWsGm3XzxyLTnBdjn8qJqUxy0L
    OKF3cr8eJ4JDSF5tsXP711Ku1nUUrdQaXs65vVwb5baJ88+/kAcb94p7WZqw2OmA
    nqGjaNeslxinL1Bzqr+BjUzbWzENer3VRJZIj5jpV8PBDIw8X3N+ZlgcN89ysClr
    6Wnpfs1qE0knxdVq3bbCC2yvAEfncDhCfH5CpGtn4qzg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034015AbeBOQQg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:16:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165458AbeBOPoW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:44:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 4.15 089/202] mtd: nand: brcmnand: Disable prefetch by default
Date: Thu, 15 Feb 2018 16:16:29 +0100
Message-Id: <20180215151718.096273271@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Dasu <kdasu.kdev@gmail.com>

commit f953f0f89663c39f08f4baaa8a4a881401b65654 upstream.

Brcm nand controller prefetch feature needs to be disabled
by default. Enabling affects performance on random reads as
well as dma reads.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/brcmnand/brcmnand.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -2193,16 +2193,9 @@ static int brcmnand_setup_dev(struct brc
 	if (ctrl->nand_version >= 0x0702)
 		tmp |= ACC_CONTROL_RD_ERASED;
 	tmp &= ~ACC_CONTROL_FAST_PGM_RDIN;
-	if (ctrl->features & BRCMNAND_HAS_PREFETCH) {
-		/*
-		 * FIXME: Flash DMA + prefetch may see spurious erased-page ECC
-		 * errors
-		 */
-		if (has_flash_dma(ctrl))
-			tmp &= ~ACC_CONTROL_PREFETCH;
-		else
-			tmp |= ACC_CONTROL_PREFETCH;
-	}
+	if (ctrl->features & BRCMNAND_HAS_PREFETCH)
+		tmp &= ~ACC_CONTROL_PREFETCH;
+
 	nand_writereg(ctrl, offs, tmp);
 
 	return 0;
