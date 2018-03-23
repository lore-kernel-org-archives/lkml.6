Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521806397-2-17523006988604724766
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
    t=1521806396; b=iqPGH0YdUDlNkVb9HCAzyISJBM8fWL2OhMyNz+kGnW+wWgZ
    jIqNwJZwRtEvLsP/mcgoI0FnnzvZe5ID5IVhHnXVaJHaw8qpY82fhQR7cwVVFSuq
    lN8EMoFJ0esiD+AepVVVyFoHDvhp5pBxl1BqoFX4Owsm3ky7B4uHWQlQecy5KLtt
    LbN7HSUHV9VyaFnCrFjEaTuIeP2VbVwvbl8fXiAi79QvZkSV0pwnU0Z6upUUfpLJ
    zOb9crDHbLgVIUOi0+2SVRpyPF/I7X1qraoOBMe5ubMTpsIXOkIfixQaQv6DLSiD
    DWIKeD46YN6scIhGXHMX9dw2XQhtFnJo+38kCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806396; bh=jrVLAxEn2UbIG9R7evXhYtt/Pj
    zM7YQMH9jggP6nZjE=; b=beh4U8TZ1u3LjZuu8ir/VBJMfQpYob/k/TeY9w02le
    YEW0NthBiR5POF5+zUWgWb32ShneNSTRnS72qmoUAhcBDnAt2UfShmGGdI+PZwlt
    iAMC40gHdk3k4thYgt8KinQolzOb7FfQvPtSdWVz12f8rIL07reeNxAJZTWUoyZG
    kqpk+rkEmD5gFMiC0mHXhHU3RI66U4H94geSh9IocahJ8uBJ54xyUed8rliI7/4q
    71hk07BHEpoQ2kvdg+j5yMWrEQpCuhO+YmqrXel+Ttv1gSmluTNsWrAxJN/ZE/aa
    6i/ncaanHbpICh2V2Ttg80wPEDxsBkwa1/ALH/UqOVOQ==
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
        id S1753539AbeCWKAP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:00:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeCWKAO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:00:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.15 80/84] serial: 8250_pci: Dont fail on multiport card class
Date: Fri, 23 Mar 2018 10:54:34 +0100
Message-Id: <20180323095424.049504740@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit e7f3e99cb1a667d04d60d02957fbed58b50d4e5a upstream.

Do not fail on multiport cards in serial_pci_is_class_communication().

It restores behaviour for SUNIX multiport cards, that enumerated by
class and have a custom board data.

Moreover it allows users to reenumerate port-by-port from user space.

Fixes: 7d8905d06405 ("serial: 8250_pci: Enable device after we check black list")
Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_pci.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3387,11 +3387,9 @@ static int serial_pci_is_class_communica
 	/*
 	 * If it is not a communications device or the programming
 	 * interface is greater than 6, give up.
-	 *
-	 * (Should we try to make guesses for multiport serial devices
-	 * later?)
 	 */
 	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
+	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MULTISERIAL) &&
 	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
 	    (dev->class & 0xff) > 6)
 		return -ENODEV;
@@ -3428,6 +3426,12 @@ serial_pci_guess_board(struct pci_dev *d
 {
 	int num_iomem, num_port, first_port = -1, i;
 
+	/*
+	 * Should we try to make guesses for multiport serial devices later?
+	 */
+	if ((dev->class >> 8) == PCI_CLASS_COMMUNICATION_MULTISERIAL)
+		return -ENODEV;
+
 	num_iomem = num_port = 0;
 	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
 		if (pci_resource_flags(dev, i) & IORESOURCE_IO) {
