Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3278546-1521213867-2-15520762644154225502
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endask.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521213867; b=tQ0dcmWXXoE9dfCt+XbbttV981i6rBgGX+MC6ZHeOjLGQUs
    UJOdJFlIDeKD+xNpOjpE+Q0c4WDNoVc102zaxrCNO5XVhvVF2F1giVQhJGtVLyWP
    sPnTBMf67EGe+F1rhAlJ5MYY+xYC4ex/MOpm5derkGpoITZuZ55rkwMCtPuEIAMM
    8h+bPpFh13iGMGlpwkK2YEdcQDUPz0rf68vgH2AE0yu2OLP0LH0Xsqx8AvguoOef
    +F++3NMijsLcYcNtCV4nhdwXSnTgWz6a1MD4EKL7aTmjxiMeffXToSrq4BuDfgSK
    XatRbzOUNAlfPn/3LQ3E5/VP8JFpnYFR4PRycig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521213867; bh=I6uEPaTyY4bpweZ3zIJ4hEAvW0
    jUtHa+rupV0dIs2ac=; b=qVWIG3bDM/n5fm2u4HUucKQEszOp4gMkoN0J/szqvs
    xIaWhZCrInpAZAY7jg6X8y2UVdghgwrhiy1zzZqMaaUGYvT2NJI2J6Nr+LTs4dvf
    FemR93tUPl2lQP9tq2OGgAAbNR2lW+OIGDTouMIJk6jGwuS1gry9MKwt+fMlvjmC
    /S38xOI8Ei7FigQ89Rzr2vl8X/pE6SxYGNff3P7I37hwtzZJvYMZCAtoJRb0JGsT
    9d6sZskJqQHAzPgF01PYQqx1Uak9XpkwaxL9iBNS3BBSV4BDSCZBO3M7Dt5YZw1J
    G/RpwMM7X6D5UwNNCOrfgCQ0Kl9j9sg1IFuQzT4k+PnQ==
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
        id S1753937AbeCPPYO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:24:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754045AbeCPPYC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:24:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Subject: [PATCH 3.18 24/25] serial: 8250_pci: Add Brainboxes UC-260 4 port serial device
Date: Fri, 16 Mar 2018 16:23:11 +0100
Message-Id: <20180316152233.730622401@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4982,6 +4982,17 @@ static struct pci_device_id serial_pci_t
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
