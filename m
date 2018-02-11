Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3984029-1518391598-2-15942534940059858019
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518391598; b=KxggqLPhW+2ZvC2BuvhCs0UoIaUttVWl/Yxm4k0LBQEZkVd
    W8i7fOzEszf3zp5CwAOrb9q+W/HG6fdUFhmvnyBnsyoHxKnOHrag58Sm1zvvApxT
    zlm8J/M/4W+YwpUSbehrgb/MG4WNGgLvuaYWcdSvEr2RNWwOqH8se45WjCNV3/rb
    qR93MscKM/nCi4Yw3g0pI01Z4T1l/FYQI9cixrbcwz5eDjBH2729i8OHwN8VFQ0z
    cTXtoZJBrIuLGxb/cPzMAQ38HmsUpkx+r4Ki6D8+CUVoQqg+4VbyDB9TNou8nrL7
    WzWs/Ks26WGfLfroO1O79zzLLjyMQVkEbKk2bww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518391598; bh=L7NbBtqTefYgNxawRkB8uGWe6C
    a56Vjm6t9OIkBeVAU=; b=oZDNqPG72B1jKZukC+0gCWe6KGoUQshVXRLQmqyqKR
    XnQvsef3t5+yq2N6jnnfP3t9fk4UabMo4HDIGdD9eoVNhUVyIFCcS8Ljlv1494uT
    h5gNDC2PIlTastz5WlufiU5SmriA5uSRRk2BDgTYwHvIRqYyhfPVXuwPrLnYTk7Z
    EcbiFnT7vfBzOvokHRFEU10wVqOEz+ziKDr5VlAMLsempFaXFjT2T/YhelEgQeG4
    jR3/XGetuKSEEf985oQsdMXSHnQln37fxvDbfq40RXFJ7nJDKuOxKCFznzXTYq+B
    IcmHkMHPH8oRr0RfATwRgnq2g4OpqgROZRk0ZiaXeyHg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753766AbeBKX0g (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 18:26:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753745AbeBKX0g (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 11 Feb 2018 18:26:36 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] extcon: intel-int3496: Fix oops on probe
Date: Mon, 12 Feb 2018 00:26:33 +0100
Message-Id: <20180211232633.13565-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 41d600274fbf ("extcon: int3496: process id-pin first so that we
start with the right status") starts the work on the workqueue before
registration to make sure we've a valid cable state directly after
registration.

But that commit moves the queuing of the work to before we even alloc the
extcon, causing a NULL pointer deref in the worker.

This commit moves the queuing of the work to after we alloc the extcon,
fixing the NULL pointer deref.

Fixes: 41d600274fbf ("extcon: int3496: process id-pin first ...")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-int3496.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index b23ee9d993a3..673bb26a9a2a 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -131,15 +131,15 @@ static int int3496_probe(struct platform_device *pdev)
 	if (IS_ERR(data->gpio_usb_mux))
 		dev_info(dev, "can't request USB MUX GPIO\n");
 
+	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
+	if (IS_ERR(data->edev))
+		return -ENOMEM;
+
 	/* process id-pin first so that we start with the right status */
 	queue_delayed_work(system_wq, &data->work, 0);
 	flush_delayed_work(&data->work);
 
 	/* register extcon device */
-	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
-	if (IS_ERR(data->edev))
-		return -ENOMEM;
-
 	ret = devm_extcon_dev_register(dev, data->edev);
 	if (ret < 0) {
 		dev_err(dev, "can't register extcon device: %d\n", ret);
-- 
2.14.3
