Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719763-2-13426329978499186227
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
    t=1518719763; b=KrHbUT2GHG9hELrsaep8sxa8tnRnQMVOd+5XxvF2kh1dd1h
    BF1ObLIfX0X5DpXbVWB3IY5+ihiiWJTzRIYBRb3PSTDMzAKHj2H3vpWWg6vutMDK
    hT7Mv1j/xTfAFF0tqFOCLLfPQvEYqas0Ts+LibU5JMzGkghKN3MLn7xIK05IMDwk
    mo/bME3f16tNelz/K5QzZXW71A5MWo5X+rinlOAK0rCkr7weHtbVcr/gpXGy/0Zv
    m8tT/19TN7sEcvSVNTEfbqw5zQ/Xse+WN9ouWwrChvnU8OOFI4VWXv8jPuXU3fUk
    G5hd/jlqC2NO1g2Vg0Z5pWeQEdoUVqv5m3MlfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719763; bh=cVEElrl2TDcoOi1VWupP5ri3qY
    3YoIT93rBHbqXu4vM=; b=PbSfiYbWUiM3hiKTFvb9+ZgfpzcEhcrEgO6tz05Y41
    TG3T2JAitstXarVq6gSbYdd4Ddf/wJPYV9iJd2WNXdk9sCFn/5D8OsFKqdCq7NIw
    siKSnwOExSTMooLR/suc/J6VSWj2JayfnziT0P+eOdY/A94srQAyJcmuX2d3KUSD
    E7JW1mh/HlfDuwIgto/1Lxq7jG6ER41oN1QmYiZa732Fn0Qi4UuwWXdGzfmRL32v
    Sup8KtMtMC3hp8UQivYOIIEznZ16ZsRuXuyuIGZ/htPSbt3s/LYwHrPCj/e2kt4F
    vpdI68hwp1NX0GwqRJorF3Y5D1SwH0iDR6myniTYSNSw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162872AbeBOSfd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:35:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51928 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162875AbeBOPYe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 4.4 055/108] mtd: nand: brcmnand: Disable prefetch by default
Date: Thu, 15 Feb 2018 16:16:52 +0100
Message-Id: <20180215151230.112418659@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1922,16 +1922,9 @@ static int brcmnand_setup_dev(struct brc
 	tmp &= ~ACC_CONTROL_PARTIAL_PAGE;
 	tmp &= ~ACC_CONTROL_RD_ERASED;
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
