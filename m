Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521214436-2-16586208866730423088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214436; b=Nrwlf7qd3bDyi9Mum0b/MWhuFpDtETCULvfMx/3/iRfmGsh
    HCmM4DetZYRabRXFxm8zVBwliibRtuxSpXc1xTxeOUmeyf988N4Ws/rxpKbeiY1D
    xdY+yhG33ZccJ9sEQAr20SRHPdsVgx29njD52d7YDWQwBJSUHsQbtVHo+xvylqPo
    nH2I7hrcbYPOyxp4Cx3cAfLUdHPXu1ql2w/yP7gPm6pIwgaGF+CfdKgYDeLa/wzk
    lSzbqB0Ud9m8spaxORrr+FzNt16DQpfZD/tInFH9rxi+ELsnmHTOQQ0JvkTvbvYX
    aqIvcNI8Rw+USc2QoduRux4574WeEt2B7wy2TKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214436; bh=6mbFS1CoSCsGSx05yRUpSlKlOs
    fhIsxxFdXxKMiHPwo=; b=rPcbsgBjys7/gW9xxTbA0/kV4tk2m8rqUmm9ohEcEc
    qopUwtiOroCCyUbXc2yndVBulKzPAeCR0KOcv3R4ENsUrI7IQgMdvn9YUHpX7KCd
    Lt0SSbe87XCBcFZ17Nr0sQ2y/RN+8qv9TclcoT+UMsL+/M2ouUV3I+gFy4sfUzeZ
    yOLMKcH1vq+orwz2Ck77bKEjocfkT84dBz9wZwzeN5TJP6rg/Knum6vMR/1MGPAy
    FciWX1A2gVi0fSxM6FP1dqMcNSJMeIVaGvEEMmJVc7VNE3wkiMXSYjD2taKJgw9t
    pNEvJ9Bh7lHypnAKMGQ0P4Qyo/p8u4iRJyJvH242Z18A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S933818AbeCPPdu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:33:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933808AbeCPPdt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:33:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Subject: [PATCH 4.9 83/86] serial: 8250_pci: Add Brainboxes UC-260 4 port serial device
Date: Fri, 16 Mar 2018 16:23:46 +0100
Message-Id: <20180316152322.935324293@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
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

From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>

commit 9f2068f35729948bde84d87a40d135015911345d upstream.

Add PCI ids for two variants of Brainboxes UC-260 quad port
PCI serial cards.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_pci.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5100,6 +5100,17 @@ static struct pci_device_id serial_pci_t
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
 		pbn_b2_4_115200 },
 	/*
+	 * BrainBoxes UC-260
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D21,
+		PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
+		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0E34,
+		PCI_ANY_ID, PCI_ANY_ID,
+		 PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
+		pbn_b2_4_115200 },
+	/*
 	 * Perle PCI-RAS cards
 	 */
 	{       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
