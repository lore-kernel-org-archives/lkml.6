Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805284-2-10109990409093772089
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
    t=1521805283; b=gf2wCkvANQd84WXhSN3Pky7BLcjSaj7h0f1q3QPTelweW3n
    aIpjAMFU01Ye0TpFW8L67FMXZjYlg6dpCl84+AD5b8fe2gXZl4o08ESoHeeAb2GW
    8pl20r3BKL/1nhOO2mlwXdgkLNhNtX2ZLMmdjAAcztZmoRNXlkzD31/AYUlBr0q2
    w5tqB3YY/CPikwczWjaZu+uvIg24KMdA277kx4BBHoUYL05vbnH0Y7PW7kVZ7DeY
    nzqNbNeJz0rJYnUeYNECYPQpX+g3qdnYxAo93XFtRygDWaV8NKYITLkn+5S3pyBT
    7mepmA7LqN0uJENGDQDjGyf2Qt3L/Z2Cb/h1odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805283; bh=mTVMpsDXEV8+mzTJx+FqF768tx
    3o6yjYPkCJ5nfGCSc=; b=B4QbWKSFThAYBYzBz+UmqKO0cgCMFteVJ7CN3aOnah
    VTK6QUofbkpWM7vOAjMeVjVba2AhURpN3SuJAiFK/N4Ci/KdtN9h/r+xMxxRsMdh
    Ou7KF6MM4WBycGdWyLbqEqSlyd+XFVsWqq564j0aQEADd65TYywpz4/5PzR/Vs1g
    uYf3GM1H8P3KzBE5W73s5qlJn62JlcvPhecYjjS3A3MxX7uXMLiv1ral+JbpslgE
    tGh6csF/1F6oupdipG80WnfjjmtJof7CQW4WQeR8LVF9fUC88ffbpAkXcgKlEuGA
    ESdLGNtm1+v2vYHUDE6d6zpKa/bquWGAADH/YEGpcZZg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1754600AbeCWKEE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39008 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754572AbeCWKEA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 71/77] serial: 8250_pci: Dont fail on multiport card class
Date: Fri, 23 Mar 2018 10:54:45 +0100
Message-Id: <20180323094147.035333881@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3389,11 +3389,9 @@ static int serial_pci_is_class_communica
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
@@ -3430,6 +3428,12 @@ serial_pci_guess_board(struct pci_dev *d
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
