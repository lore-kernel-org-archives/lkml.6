Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2707851-1524408488-2-586094199221273669
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524408487; b=IPtm+4Rw9mSOwNNNbwxtNxkLq8xppIiVyWea+TKL/m0YwNuEYW
    udB1DZ49pD7b2SGlwRXOEEnndxb2D7Dha4CX5iBGE+qKh6pnGWGPvpGW6EBkn7Wj
    sxCCeayJoIVmhqrHWivLrxj33IiL9ddALPg2fTK78UDBW10cesPsUkOKJOPasVQr
    1KCLnB3kkS1OpY8Oa8osdYDptHA3Vw+vsni0jo8x98R5SU4fYmJ+X07dO7xZ+pMV
    oxTB4Ioh6/o9VQo/m+iJ362P2TDuX8cCfRVdsFlK4uxCKkIXrELJE2JOy7DPvYzG
    ImXK3XJigngHA0K01BUsgrCPRTm22hb4voBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408487; bh=vjupF8CSGFDkHxjqiugzMJRaFvTLqj
    F7OisUli23myI=; b=fwxtwsRAOj9KgFR108r6yLHz1qBCmAvFb7thQRrduLwRPx
    tpRQWPapI8gwNNpQ2addZYDnBTeuDToZ9rjgd96Ppa4ta2qmuQwKasUD7K/bBgPx
    WLU6neadPFYbzmstKbUkByN1hn8NXahGEI2XeqSfeOu7NCYyEOajbOcZV1AepAfS
    e/KBrlRPVZTbMFfrmxlRJioUGFk9gh8wWmQndQpBN7q8NdWQZQzSbnuonWlxYsVx
    Fu0ESGitLpvKZix2JUMOnzF65l3ob12c3+3Qnai7YpJOp/dXjoPTb7+z1Zky4RqC
    ld3q87nSAsoJCDIpOa/LkBs24K8YMW97SiLIlxWg==
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
X-CM-Envelope: MS4wfJxZTtTvVKhONXPZ80RnMz60Qoq0Ckpu/QD06riP4H61C8eebNuxVtY/dORiE8eTWsRWBtn/SIK9Vt19j7vmLhHTc72t9nK2CnysJkzRGF+zD4Ya+2WC
    HpB7Vs6+SSbu6IDPiNbuMkTwS1d43fsuUFcVK3AJF2rNseojZ9CW2OCOdXEB+mBq0dSDhRiMaw8gDmn2+Ou5NwPmM/Mq2Ed/iUMnNieFR8KAYTRRt1/vaDI/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=cA917tEuKh2QAOatFzUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757204AbeDVOrv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:47:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932210AbeDVOQG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:16:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.4 22/97] ubifs: Check ubifs_wbuf_sync() return code
Date: Sun, 22 Apr 2018 15:53:00 +0200
Message-Id: <20180422135306.046611687@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

From: Richard Weinberger <richard@nod.at>

commit aac17948a7ce01fb60b9ee6cf902967a47b3ce26 upstream.

If ubifs_wbuf_sync() fails we must not write a master node with the
dirty marker cleared.
Otherwise it is possible that in case of an IO error while syncing we
mark the filesystem as clean and UBIFS refuses to recover upon next
mount.

Cc: <stable@vger.kernel.org>
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/super.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1728,8 +1728,11 @@ static void ubifs_remount_ro(struct ubif
 
 	dbg_save_space_info(c);
 
-	for (i = 0; i < c->jhead_cnt; i++)
-		ubifs_wbuf_sync(&c->jheads[i].wbuf);
+	for (i = 0; i < c->jhead_cnt; i++) {
+		err = ubifs_wbuf_sync(&c->jheads[i].wbuf);
+		if (err)
+			ubifs_ro_mode(c, err);
+	}
 
 	c->mst_node->flags &= ~cpu_to_le32(UBIFS_MST_DIRTY);
 	c->mst_node->flags |= cpu_to_le32(UBIFS_MST_NO_ORPHS);
@@ -1795,8 +1798,11 @@ static void ubifs_put_super(struct super
 			int err;
 
 			/* Synchronize write-buffers */
-			for (i = 0; i < c->jhead_cnt; i++)
-				ubifs_wbuf_sync(&c->jheads[i].wbuf);
+			for (i = 0; i < c->jhead_cnt; i++) {
+				err = ubifs_wbuf_sync(&c->jheads[i].wbuf);
+				if (err)
+					ubifs_ro_mode(c, err);
+			}
 
 			/*
 			 * We are being cleanly unmounted which means the
