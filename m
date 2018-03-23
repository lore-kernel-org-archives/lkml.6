Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803441-2-16343857536134029179
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_RHS_DOB 1.514,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803441; b=SaREkyp/27s0Cx1sM1HDFzLeRhqIH3BJVvN4NORF1WeoY0y
    hvtgSmsLYTmAMvr9UeUVr4sFojO+564etnkaNCxxTkXuSZLfh8yHK6pvHggwz8p+
    3mF7lI3cxqS0ejyBY/hQg7wI8MMsLiduUAhTW2wy3oSfht/Az0W1HdoRgsrvEvvC
    ohbDNMNM7S7syGUMp+Lt5sQi5qz5LnasElogFnhPa5Ko4Vihq3H/Ywtob5zgzhFN
    kgUiATQJ4E/6MVBWa12bs0SqULluot5GOvVHq1mP1qf8FmVTlwYahmF/EZFUmhkK
    pOLzxFlmQia/Qv41XPSNtIE9+1nNssTT1WV7VUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803441; bh=+g2MH/tqqJ1fXSPsrCLvSb736v
    ysHiYq+76m3eKUopI=; b=eYb4akDV82wTmaOMRlXrAswIdhRrID1I63Up9j58zh
    BcKHD/fevF5Q6FAWmsZIgS0mdWTEWyYtDONJ/znPTzYmjtyer85SJ4MHad37hepT
    2YP4Ykrd+wEE3mUeVMSQFln5iLIxpeiSdd3SFk3BA1zIf3QudGBkdzYgv5vASsLU
    wROzjwiDDQ5IBRuLJ/o1H1NRbn3xjOXGky2jsf+wV/N5x0ERZ4bYtbmg19oghdlB
    PAA5y05SQ8G+vzCk1YhBaTgfIfrX4Sn7ylpEHo0jwG5QZzwyYLqFEJoZ7+1IDN0r
    2JY3fTp4ckcsQu+HAnu/TonBwkfxHLiycTwF6RbkKzQw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbeCWKLV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:11:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43794 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932899AbeCWKLT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:11:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 140/177] media: bt8xx: Fix err bt878_probe()
Date: Fri, 23 Mar 2018 10:54:28 +0100
Message-Id: <20180323094211.385411211@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 45392ff6881dbe56d41ef0b17c2e576065f8ffa1 ]

This is odd to call 'pci_disable_device()' in an error path before a
coresponding successful 'pci_enable_device()'.

Return directly instead.

Fixes: 77e0be12100a ("V4L/DVB (4176): Bug-fix: Fix memory overflow")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/bt8xx/bt878.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/media/pci/bt8xx/bt878.c
+++ b/drivers/media/pci/bt8xx/bt878.c
@@ -422,8 +422,7 @@ static int bt878_probe(struct pci_dev *d
 	       bt878_num);
 	if (bt878_num >= BT878_MAX) {
 		printk(KERN_ERR "bt878: Too many devices inserted\n");
-		result = -ENOMEM;
-		goto fail0;
+		return -ENOMEM;
 	}
 	if (pci_enable_device(dev))
 		return -EIO;
