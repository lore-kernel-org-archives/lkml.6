Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2141624-1524728035-2-8476887225122757329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524728034; b=MqPdw3PQmZxGNbms7uF7P6RBdVknDDMqj2ZWN8JTiVSBufa95F
    gHZK1KgRpaeLvnSBPHTDVpCZavucB6z3TWEVcmWHVVBovZQF6st97G99CRa7sks/
    nCoMi6YzC9Ozafw87FfhaIW6QS2CmFnqxtkP01gRFGRgG5UqyfNIcD86t9Obt/mj
    gReN14f9dwoskjoBb5sSQoYO2WvFX7Kv26bms4I//jE9XsuRCNhrIJN/if+tfTeZ
    Qz4dNoipeFT2g2DXsik73lbRS9kYfaHz1ZDvrJk8NbV6NwSQnbgXpdm4hCv57nwa
    /CpjfUfyBAE32WRxKgcxaRMA7EwaSzvZm9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524728034; bh=h4nwRfeoOiKElNVb7xTegm0XGSubyI
    yTKRy0orGNaU4=; b=TpfgEKb1x6k5za1oslxNgDfjwvEN8FsCM/ySLszyXDcS+o
    UMrizBTOFeEpc9afuQSkI5bcv/o3a0vI1qm9S/9cZ2glrySvehBtWZLSzL3VySk/
    dYxybBAMBtDmuVyOvU5rGxSpgnyTvKAdbG+tOGRGPsPKX8jIYFzxWPB/gy5pCjzD
    a7tx01YnO33iUeZESwSRuqQp3Y2E3uXhD/dO42DzWqrwCXj1OYX00JQL6lsPZA/1
    jGePIYRgdFQKdth0qMI02V/3s9i6ehWYbocuV39XQ4xI0DAmyjF3ZSuukbS96nvK
    plRgvV2e2Af99xMKmeKLhubwi3Mur7FSYgnA/FNA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=k60LSTQ0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ce4B4dXs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=k60LSTQ0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ce4B4dXs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCqDUGrHKEcJ9AAqYn8xJIV9NhNCoRsT5kFcaWObc2Kdozr+SpUcCOWM2vo2A+zOo7zBXXpH76kt9ECT07MXVylQeJ7bgdR2OqJ7JN0x6P2dpRn87WNT
    /K+XseOAfdlkWso5XLdEdaFslpz2HAGnUeCEcdVeSqPx3xpRE6v7K8EoHTMhNhHk4UzfeJaLOtK3M8umID3FvSHrpeN0XhMGx0WfodhpdHn2NxSXPJNcvsND
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=QyXUC8HyAAAA:8 a=RQ7XpqNMG1nq32PeMuIA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeDZHdw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 03:33:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34308 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeDZHdu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 03:33:50 -0400
X-Google-Smtp-Source: AB8JxZp5KNRM00fsBn4WW59MVxlqM9H+7t1JU2KknLsUmBZSC3SxOvkjyKCS2uM/GxU0TxrApvFJbA==
From: Johan Hovold <johan@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] net: rfkill: gpio: fix memory leak in probe error path
Date: Thu, 26 Apr 2018 09:31:52 +0200
Message-Id: <20180426073152.7953-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Make sure to free the rfkill device in case registration fails during
probe.

Fixes: 5e7ca3937fbe ("net: rfkill: gpio: convert to resource managed allocation")
Cc: stable <stable@vger.kernel.org>	# 3.13
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 net/rfkill/rfkill-gpio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 41bd496531d4..00192a996be0 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -137,13 +137,18 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 
 	ret = rfkill_register(rfkill->rfkill_dev);
 	if (ret < 0)
-		return ret;
+		goto err_destroy;
 
 	platform_set_drvdata(pdev, rfkill);
 
 	dev_info(&pdev->dev, "%s device registered.\n", rfkill->name);
 
 	return 0;
+
+err_destroy:
+	rfkill_destroy(rfkill->rfkill_dev);
+
+	return ret;
 }
 
 static int rfkill_gpio_remove(struct platform_device *pdev)
-- 
2.17.0
