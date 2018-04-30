Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1878097-1525117062-2-1357225131427255997
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
    1525117062; b=R+HGEuRs9th0sMbiN+OeStklCMqAfRHsKKkqLSNlNR+io2vWvG
    nQaSG40VM0R6omWPm3k8HTGezc7hGZp/n2Pa9Evfzqv8+iL4qqOoHHPLeamALehU
    4EeDXIVc3ydw0uDlom/a8WaMDJYj9V1sY7MT3QNCr6IHQTf4YBEejNy9ldg9mpjD
    PbB2oaJaR1Wfcs/yXPRwBaBP8NOYXYD8Awz5I1hsW8g62ibpLDWZitRZYfL0/30J
    22CV3WqL3TZzO7PH8B40qif6QAMBQVcZlwa3Q/Xi2iVzTG4YkwuH25Hnat+wM8nZ
    6pqwDIcQL351yk9B0Qdj4cO7Ym64zkEbQOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525117062; bh=W1iDUXB7NvT9+P9E/QwR6YWwoxwDKJ
    kINc05lyPLBWg=; b=m/6E3YYepbuIKwlVRJ1gPZOUwRoec5wuJCPJew29vhNdPD
    bIHJXs3LY9/1QDyfuZT8U7mbjOyKBgzVskuNPH/tzbD0+5c4vUdGZxj5p1SC6Mmh
    lM0UWW406q916G5D/aSFUeMphlYvcs0glNukk+X449ts7yC7pdXafFKB4a2hZWHT
    XsmYqMFpKyCa195P+EaaGAwvTLr1TSqJqYRclNpP/tOlzpUDslsGYZNqQt8SBUi2
    /PgmUqL1/dayZqcQWV9vrg7LZWUjnYDWPjtuDSZj9PS1d/pQR3e9JJ8QJn307SgH
    DUD1CVejtdUw2Gghg0x5ZEivM5+f77Sp85D7rb0g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfPgm75j17/jcmaZTzu55Af6QHnmiNYqLFuWbAoXqngxb76pn3Qj+hw7jesqPYMn4m/9Rv3KzuKXqoGl2rs3WKR4g4LqutuspH6Gh4dRydmJcZYfUxJ0A
    ooQIrDCF1X8jwmpwYcOZisPUzoQwmdANGhgP9FlAZgmN/RhdUh3e5BZ+iHFx5M4hnSVoPG5AiXI6aJxWyE/2K+V9NovFW2fFrI6V/97r7ed9XN1VbMeEh2rT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=5EMsjEJVl8QOgak0-BcA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756373AbeD3T2m (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756372AbeD3T2i (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:28:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F45622DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.16 074/113] ARM: amba: Fix race condition with driver_override
Date: Mon, 30 Apr 2018 12:24:45 -0700
Message-Id: <20180430184018.331824098@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
