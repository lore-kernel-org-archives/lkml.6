Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719342-2-8336780669896094163
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
    t=1518719342; b=WwA4VFCoL43rXYH4icZQGGaQqImR8pq9jV8F94kMJwuWqix
    yB1/PDRZsln1b+NjH8S5qFvH3tiqtDfObf7fzn1mVc2IbJH521BiVMfafkncY1aL
    leeK/LxDMRMbx9Vn7er+xpdazXbhXPYWpNtPPucWG0m8QxmbzNBn3ArBG6JMgbUz
    sFZ/5WPQe+96nqSc6nllUpZ3W7qCIdJiKcdfJY9SvYGpApEUGicYJUvpD5fsJlw4
    WvqZ7Jjf9twS0ODL7PFK9Gu7tbC0AwF0fkamXUijZF5v5HvTLSFp7oHy6RuufQlx
    q9c7WVN8i4ZAM2YMdR1o7HdzAZnOZhaVkZZC8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719342; bh=fynkW+AUswng/PApyRKOHx96e8
    VzR2jggqwusgZonTs=; b=YWHSvMF0Kbq1evxjU9ZuNHh/g9eQvipaZwS6EZuaTi
    Rf+eh6dm/+P8BI9mx1YG3wEnKYDlAidX2B5ynkBd9BLhlCHdA05nnL0CMudQN15c
    STouXD4VUmtHqDrbOPEOnpCqMPTHWCJoJSPuE5/2yU7T9zXKpVYtV9OP6vNVu7l+
    eJzebd704vBPHUeM8FIb04NCe0vJ21ZK+QJ2tKjcEc63oYSxpv1BRap9plV3eEOw
    qU4ZN6ximfao+RgKSPSWAegZCh2YCJBFtlD245FB4PmUFGDoVYlZbJDQfGmkLjK0
    s9LeCx7LQSCWSu7itw2E59apIJLhO6agRTZs81gizSrg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166467AbeBOS2o (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:28:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163176AbeBOPZZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:25:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.4 093/108] Bluetooth: btsdio: Do not bind to non-removable BCM43341
Date: Thu, 15 Feb 2018 16:17:30 +0100
Message-Id: <20180215151235.362338659@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit b4cdaba274247c9c841c6a682c08fa91fb3aa549 upstream.

BCM43341 devices soldered onto the PCB (non-removable) always (AFAICT)
use an UART connection for bluetooth. But they also advertise btsdio
support on their 3th sdio function, this causes 2 problems:

1) A non functioning BT HCI getting registered

2) Since the btsdio driver does not have suspend/resume callbacks,
mmc_sdio_pre_suspend will return -ENOSYS, causing mmc_pm_notify()
to react as if the SDIO-card is removed and since the slot is
marked as non-removable it will never get detected as inserted again.
Which results in wifi no longer working after a suspend/resume.

This commit fixes both by making btsdio ignore BCM43341 devices
when connected to a slot which is marked non-removable.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btsdio.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/skbuff.h>
 
+#include <linux/mmc/host.h>
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
 
@@ -291,6 +292,14 @@ static int btsdio_probe(struct sdio_func
 		tuple = tuple->next;
 	}
 
+	/* BCM43341 devices soldered onto the PCB (non-removable) use an
+	 * uart connection for bluetooth, ignore the BT SDIO interface.
+	 */
+	if (func->vendor == SDIO_VENDOR_ID_BROADCOM &&
+	    func->device == SDIO_DEVICE_ID_BROADCOM_43341 &&
+	    !mmc_card_is_removable(func->card->host))
+		return -ENODEV;
+
 	data = devm_kzalloc(&func->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
