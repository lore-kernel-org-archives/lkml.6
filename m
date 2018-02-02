Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591770-2-17816148836159791785
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591769; b=F/xIqpHtCDv0wq8DxLKpRpxAJfhYNokEdR1JGq699pq/MdX
    +95c+ASZ6tB/puK43KgQv/qG/g6J5maqkWtNZwecU2baF83MLeXDEyL6cG//RsSx
    OmRrfJLkW4zoNNvuS//t9tX0/3i5dMUXvlu9WwDSH0RrGuBSlXauufFaGDVRObAg
    Mr9bNTyILLt/X7lEXAr/CBD3zvfcSEWew2kVVvdea6lHPRYBk6Mg22P6y1sFI2t5
    81udiHXqD3wwxBgvi+DVUyaF2XZ7i8tesYPo3VLwTCAxHOVWA19/Dk6vQb0fb+XU
    Y6cpXwYOrNZGIfzA7naDHL3+S5t25m2INz4dbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591769; bh=fSOGrpBF8tOa1Q5+ufKeZvNByc
    Mnu6wc2AXFj1xeL+8=; b=m+VGbhMQfNxKe2XqXWniBDbYPlhrkO/QswXJr2qBXV
    F/OcJ2+EJvtTvzV5o2BspRY88/vWAZ2TDncO06iAdxxmbZnr8aSJBucjw7Gma943
    8ULKN2KhRaWvKW1BB5+VOHW9Y6lDP/WUVdSlkTs/UCJ22vc9aPWBYH6Z2helReIm
    FM8rlkrUegItgtQ4nF8J5lBREc5wKfTPoqaC4kYrIjl/pYfaA67ZWIEj5ZMj4y6W
    UEEKr8Vkl4nZAI9AVpwKnNyI5yvU4ZML0P5k09SOtAo8p1pMbnZGsuufjH1/Qsj9
    ICbOy8iF/NH7LAMCrhqJGDH3iliDWQhGF30a3d2lijcw==
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
        id S1753617AbeBBRQA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:16:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeBBRPn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:15:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>
Subject: [PATCH 4.15 29/55] staging: ccree: fix fips event irq handling build
Date: Fri,  2 Feb 2018 17:58:47 +0100
Message-Id: <20180202140829.145933496@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
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

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit dc5591dc9c03e4cd22d3f0c3659196cc34668452 upstream.

When moving from internal for kernel FIPS infrastructure the FIPS event irq
handling code was left with the old ifdef by mistake. Fix it.

Fixes: b7e607bf33a2 ("staging: ccree: move FIPS support to kernel infrastructure")
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/ccree/ssi_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/ccree/ssi_driver.c
+++ b/drivers/staging/ccree/ssi_driver.c
@@ -117,7 +117,7 @@ static irqreturn_t cc_isr(int irq, void
 		irr &= ~SSI_COMP_IRQ_MASK;
 		complete_request(drvdata);
 	}
-#ifdef CC_SUPPORT_FIPS
+#ifdef CONFIG_CRYPTO_FIPS
 	/* TEE FIPS interrupt */
 	if (likely((irr & SSI_GPR0_IRQ_MASK) != 0)) {
 		/* Mask interrupt - will be unmasked in Deferred service handler */
