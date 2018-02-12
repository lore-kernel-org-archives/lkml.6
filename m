Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2131322-1518464801-2-1388354366059574439
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
    t=1518464800; b=aCWCpOITWF6PFrCBksyY4WbuWnre9R5XtTzI0aU3uKiC4AR
    0RYwZ5huwfyodyNV8TuIcp09k4aIzVF8JJvuOVGZoyXqfz1TJaV2rmssMHvL2tGE
    Z4QMIxKPX52xqsQjZ9aEKSJ9LDknCeXMfAczjtd/1ZP+ZR3gM/CuBRmbEZDPa3CP
    AvRi1hjuvqmJVM+T0ooewkHFePXfqtdSEPriudR2NgSiSY+pwANnDmxy6Me+RONF
    QPF8U0ZPYOF1O2ry9goDfULcF7ouMXiyoNwkT7jdqnZHexLyAPhKVDQvvcI7ALDO
    nGf2CyC2NwZHvINCcQuSqZcaB/Pn160KKUOk2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518464800;
    bh=etbFdJdzzAf3hosD/ju1n4DnBfRwkt1NqG4LMgx0iCU=; b=dVj5PVbUtrAy
    shoFWRbKqFJMJNKwFtdO2uVRFWEHPEZbzwGeVbTm9t6NxwP5Jl1jlWy4KN7bc4q9
    fkrfsddQw5fYBKv2wp7HaUTxnj836XURMeCQpOlbrjjtOTL2QLfiqAAjgRz5hqSg
    2OgA6korbf/pDNZN4HoqhwbWQuplHNgMps3fv7PVisSgCIPKl4xQ+3mcOWEtiY4e
    51mCwTZrvYxNsYWstfXJLvkCNPbDFnNBIMEn2M5n5eTfv6X3odIiaA0fxG1kAnGh
    3sTs+7d8q9968nJUuA22yOTgEQtB4dSxHw2i+kuE6a+7uFWRxsXdMTD7g94EipK+
    UqV4zOQkOg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeBLTqg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 14:46:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752265AbeBLTqf (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 12 Feb 2018 14:46:35 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3 3/3] extcon: int3496: process id-pin first so that we start with the right status
Date: Mon, 12 Feb 2018 20:46:30 +0100
Message-Id: <20180212194630.7216-3-hdegoede@redhat.com>
In-Reply-To: <20180212194630.7216-1-hdegoede@redhat.com>
References: <20180212194630.7216-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some other drivers may be waiting for our extcon to show-up (exiting their
probe methods with -EPROBE_DEFER until we show up).

These drivers will typically get the cable state directly after getting
the extcon, this commit changes the int3496 code to process the id-pin
before registering the extcon, so that other drivers see the correct state
right away.

Fixes: 2f556bdb9f2e ("extcon: int3496: Add Intel INT3496 ACPI ... driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add Fixes tag

Changes in v3:
-Fix oops on probe by scheduling the work too early
---
 drivers/extcon/extcon-intel-int3496.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index c8691b5a9cb0..673bb26a9a2a 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -131,11 +131,15 @@ static int int3496_probe(struct platform_device *pdev)
 	if (IS_ERR(data->gpio_usb_mux))
 		dev_info(dev, "can't request USB MUX GPIO\n");
 
-	/* register extcon device */
 	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
 	if (IS_ERR(data->edev))
 		return -ENOMEM;
 
+	/* process id-pin first so that we start with the right status */
+	queue_delayed_work(system_wq, &data->work, 0);
+	flush_delayed_work(&data->work);
+
+	/* register extcon device */
 	ret = devm_extcon_dev_register(dev, data->edev);
 	if (ret < 0) {
 		dev_err(dev, "can't register extcon device: %d\n", ret);
@@ -153,9 +157,6 @@ static int int3496_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* queue initial processing of id-pin */
-	queue_delayed_work(system_wq, &data->work, 0);
-
 	platform_set_drvdata(pdev, data);
 
 	return 0;
-- 
2.14.3
