Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521215106-2-14193363535014991717
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215106; b=DJIn6a/HXEbBa9NQjyIjjWP4WBHKTW2OIWUugddWHf1uCpA
    cCo5kqvrBIBwYzdAvnAHYJu79NsuIcsm98XCt6u1c6jvbDkEY77m5jtt5vcWtqig
    jC8AwyoRp+7sRS+tIF6PY+jUPsUdTkfwD51WAJfAfyl5B1rXuKOjR+ybIqRrq6Db
    /4wFIxiXyjRwiHbu3/MpqTp4mn+d2XT3Huo1YkD2bno8SddMn6iUMTrxydl/8Gfa
    3FhbluQSY5C+rADcnusb+l30qKGYnifd+HtwQi56um/VGD0aXpJl7+wtd6cPCR1Q
    hYmkRSwEYXwFHZ5UqE6J2TmgOZlZXyoRRMF+y8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215106; bh=XT57oJ7duAO+Mm0QreiZxlD91m
    tOBcqZCN19AgJVTCs=; b=sdBZlZo5KPp4zP1dobOgs55JOSqglivAnkUbutMsNi
    FRcsn4l/6UoT2LnobnEsmIUn1au5itKzPzPpZkIEm+cB2XDzRPbXSi5OmjLTJs+f
    6ie/oPZ47dNvbDgXzXHAi9q7nMttQ20aZShEBgVJPp0Z6IEsN2q30KCF1vmxaKet
    /i/kLIGhrt/deLeKw8jQLUYO8CGd4f299ZLggjZJI6XCXv30DNAEmEceTQSUG+uS
    H/GJ2PO4xFZmzaaZZpd3XZz/gpW9ohJ7SIPxtsUHELPwPZNXOblJfSa4A9pKmT1R
    2K9sUeIYtbD6ZHmh1tAckuFZIA1O4Aw8KWJNPpaQ/bYg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965236AbeCPPpB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:45:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46174 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965273AbeCPPo4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 127/128] dmaengine: qcom_hidma: check pending interrupts
Date: Fri, 16 Mar 2018 16:24:28 +0100
Message-Id: <20180316152342.757885357@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
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

From: Sinan Kaya <okaya@codeaurora.org>


[ Upstream commit 38680bc6b1e3592bc9e18adc1d6e259667df27ce ]

Driver is missing the interrupts if two requests are queued up at the same
time as the interrupt handler is servicing a request that was just
delivered.

The ISR clears the interrupt at the end but it could be clearing the
interrupt for an outstanding event. Therefore, second interrupt never
arrives.

Clear the interrupt first and then check for completions.

Also, make sure that request start and interrupt clear do not overlap in
time by using a spinlock.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/qcom/hidma_ll.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -393,6 +393,8 @@ static int hidma_ll_reset(struct hidma_l
  */
 static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev, int cause)
 {
+	unsigned long irqflags;
+
 	if (cause & HIDMA_ERR_INT_MASK) {
 		dev_err(lldev->dev, "error 0x%x, disabling...\n",
 				cause);
@@ -410,6 +412,10 @@ static void hidma_ll_int_handler_interna
 		return;
 	}
 
+	spin_lock_irqsave(&lldev->lock, irqflags);
+	writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+	spin_unlock_irqrestore(&lldev->lock, irqflags);
+
 	/*
 	 * Fine tuned for this HW...
 	 *
@@ -421,9 +427,6 @@ static void hidma_ll_int_handler_interna
 	 * Try to consume as many EVREs as possible.
 	 */
 	hidma_handle_tre_completion(lldev);
-
-	/* We consumed TREs or there are pending TREs or EVREs. */
-	writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
 }
 
 irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
