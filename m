Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116418-2-2427829764630358708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116417; b=MpctSehZJXHn0JX4ipWvhduNPUO24L0jsRf2DQ+Z4oESP10qqW
    r7pt+xiZi0bGuNFv6B98qEktzSklsM3W1u4lT6QsNDAeXuPk33AxwIymuVqwLxiQ
    xUjw3JKZR8CQTdWaXelp59E/5ApgMHGGCKdnbhheIgsCQTJoDr+jBTBvY9vtLY0b
    Mj8nlYXpSISjJexSnZ+4fqNBjlSArrMOXNCVOkvOPvouHMY/zdD2guXjrPT0glil
    ZXsOPWjNU4GMwJFOE2df7qC4m/ihNfD8JnbZs4ubQPExzWRwCE8DK3C2/fUFE58i
    x8mePll+WOjX2tS7ycCaixO2GrIofwKskMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116417; bh=QQcnvRTAJkaWQfIY+My41VZQN/JRoP
    Ya+e0s//9DQBw=; b=m8gYaJAXUHTSREzdUW6QK3s7/y8dsHfnUXAYDyTZDvBabc
    swBm1r4oNAAzWIai+zNnO7i5IbWLjiE+VPe65oyaeUDESytI4gZI5+giAN18lq/D
    q85rCtf+le2bt5X1FRxIbeL8rspQBlsX0gxDTtHSI4wQhKogDdGNqYgEt5M/221Y
    Y4b+iaVFC0WC9esF5XdeR9TrGA94D3FCyijigAmczoVest/nQNnYUA2e7TDyEPsJ
    RJSGDjCPtUK8uSOZUJ+fZiiIo0GVXtE7VIXAl1xg3BIWqyL/rUzdxZ0lvKaKeMpY
    Xmmb8RI/PnqUMKyIYhOQK3IV4Si+2lVZ/RDoE7rg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOcYhCjO0utlWtSROEPp/NKvDxaYzewnrPWbVhj06XDJJ1TRnR8CbqDrvFzn6FaY/mYeegB+HWTbZlj6C4sUHaAQFGWQYcFD74/WY++r17FXumKbQJze
    osnZfar8ZQj6pvQQyJinzyHt1kCexXdsQtK/XNrRch7sH20/knOt5AHR1faS4jINlmlEDyy8kgUDMNtEgkL89wzQl3ebgzuZpe01qbv3Wtj2yqVOLiNwOvMp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=5EMsjEJVl8QOgak0-BcA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755803AbeD3T0x (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755290AbeD3T0v (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:26:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F3F22E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.9 45/61] ARM: amba: Fix race condition with driver_override
Date: Mon, 30 Apr 2018 12:24:48 -0700
Message-Id: <20180430183955.176440110@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 6a7228d90d42bcacfe38786756ba62762b91c20a upstream.

The driver_override implementation is susceptible to a race condition
when different threads are reading vs storing a different driver
override.  Add locking to avoid this race condition.

Cfr. commits 6265539776a0810b ("driver core: platform: fix race
condition with driver_override") and 9561475db680f714 ("PCI: Fix race
condition with driver_override").

Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/amba/bus.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -69,8 +69,12 @@ static ssize_t driver_override_show(stru
 				    struct device_attribute *attr, char *buf)
 {
 	struct amba_device *dev = to_amba_device(_dev);
+	ssize_t len;
 
-	return sprintf(buf, "%s\n", dev->driver_override);
+	device_lock(_dev);
+	len = sprintf(buf, "%s\n", dev->driver_override);
+	device_unlock(_dev);
+	return len;
 }
 
 static ssize_t driver_override_store(struct device *_dev,
@@ -78,7 +82,7 @@ static ssize_t driver_override_store(str
 				     const char *buf, size_t count)
 {
 	struct amba_device *dev = to_amba_device(_dev);
-	char *driver_override, *old = dev->driver_override, *cp;
+	char *driver_override, *old, *cp;
 
 	if (count > PATH_MAX)
 		return -EINVAL;
@@ -91,12 +95,15 @@ static ssize_t driver_override_store(str
 	if (cp)
 		*cp = '\0';
 
+	device_lock(_dev);
+	old = dev->driver_override;
 	if (strlen(driver_override)) {
 		dev->driver_override = driver_override;
 	} else {
 	       kfree(driver_override);
 	       dev->driver_override = NULL;
 	}
+	device_unlock(_dev);
 
 	kfree(old);
 
