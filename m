Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-618430-1517904660-2-12477452377921502285
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
    t=1517904659; b=R2y14ZTOrIIC7XXKxb8n30DjlulA2BBMhZXPAx+9ZydXWPh
    1Am688fnALGxDR4p/5GQ1yjYo2KhsZwJq/DCcx7jBEHKxRjuQsaf0XRBBM/COrmv
    SL/kicT7mqKOQxT1iUwL+1QwfszPC26+3Th8E1S7hZKI4hIy4eA/wSw1AYujcsCt
    4iT9koh++14i2iPQwgPSGo7Mt2QhH73d6nGvE5teiFBX1EujVWhpSCaP6R8iKtsl
    30pigksy/4+Nzr+ZlagS0sAgMKMXHwpHWy5JCPTUn3HEr6V7cfIm8LDyYQkD4YWF
    QB0ApoWcdt1Zz6CgVRNn/sJA3d4LnjvGzXfmLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517904659; bh=naQId+wJeGRrLAsMH+MeTwpWVh
    I1hQwlJtFiXsyL9mg=; b=Fuo1Lwa1/NyxVrx8X+NWTOAPiYf4BeGcR9KPZfFYK6
    Mn7d/CVKinIptmZofthLgo9zKMLdu41eEd3dHjt/wDL5dxZYQGwNSav2yGhK7l+n
    +aJszrAvRmbWmdIBAlI1z+MIrZI0fQrfyDREPDtfhJzYs5MAzoflxvXEK6VLb2cg
    waYn4aUUahJq82KhAO38sAVRPEK+SkO3X+L4pazgoLMntn9sBuug9Sp1xJBxFOXq
    Z/2aUdd5SRhCou+g7BB87VHlGOzHyjlpDVogHj9DJB+fEM8DOI/v9ELEFqLwa98m
    fwumdGhSIX21soFbXIgu2yP09yVy7WADEeG0ePg61vQA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeBFIKz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 03:10:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751835AbeBFIKy (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 03:10:54 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] extcon: int3496: process id-pin first so that we start with the right status
Date: Tue,  6 Feb 2018 09:10:51 +0100
Message-Id: <20180206081051.10785-1-hdegoede@redhat.com>
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
 drivers/extcon/extcon-intel-int3496.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index c8691b5a9cb0..b23ee9d993a3 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -131,6 +131,10 @@ static int int3496_probe(struct platform_device *pdev)
 	if (IS_ERR(data->gpio_usb_mux))
 		dev_info(dev, "can't request USB MUX GPIO\n");
 
+	/* process id-pin first so that we start with the right status */
+	queue_delayed_work(system_wq, &data->work, 0);
+	flush_delayed_work(&data->work);
+
 	/* register extcon device */
 	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
 	if (IS_ERR(data->edev))
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
