Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3705427-1523492055-2-3479756106965240254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523492055; b=f9rPzbmtRyco7dsx3+MqPaV6YPOp/6jaV96IRatccz4TiQE5zU
    2SdqYFWhJIJqe4wSuCLZHbRgK9F7RrlsOh5G0pUQjHr71dd0QSIgfYOfmlYGrfo2
    eDrqOdsHCgLdvt7YgcJRrDay7GjI5SFoNnqjlouKVdRTsbHmH/ZI0mYAsC8usLmA
    vEG8fd0IrfGwmSJn4SFn8WKBfPIM4rDTa7CUGsqzNedVZRsJ+yi31SQ0l8zrFCsJ
    b413TfxvXS5+60h7QMbHhEnqSUkKoo3T6Swp41x/0DJmn+dppCZjk152r9RxzhYT
    BttNajNaZ7xqfis9O4eHU4luIQGgGzf44mtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=fm2; t=1523492055; bh=zMSULAX6Ba1q7bBDlWX6c9SaI08PJM99CIIsicn
    j5kk=; b=K10rYT36dHot5JChIiGYk4DmXDHqyOTCnqIcjHg2lENwb0F/z1Edmv4
    GupVeM2SFnhryE8K/3fElAy46PZXPfQxjpL7Lsr3iG13BahohOVU+0NTOFY2cq9A
    iaH7Evbj0fX0e2naPXjWFPz/uAGCmefAXOdZYFE2MtO3HcFX7adfAu/Y7+7cmeD1
    8OGSzm6FQ4UKNbvvZHe7Zvy1DYjehJnigQyT2EuVS+qdGvUNCiJA6TkYWM/1oGAO
    QjTQy+WXIG/H2tFj1UUJyk9ar7uKNkp5RyZ3Mr0mqfYkr1su4tJdsFM2uDuIC2aC
    t78DPfWoVhxzoB86ybRHRJhpvJpYdTQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=25 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=25 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNlD5Z4qP3PnZ67n8msJjrNv39Hqjay2ByrQ6iyGCk5Xp4XwNcKmrnw0kb3iX15hTHMONaol1SE+0TNZ8jX+suoQG3Qm4HLLWv5pDQK21M18P6yTVGEp
    tHi5e3+xrPBbuem47V74hi4kX0xd8LCrZdIedI3Wzv9ZPJeloHi9RFTaTx4Fvue9KxoHynnwK5hE2YRGwslS+5movPQcLtIKWRmZKeFkNu2mZDnEfGbM5v6x
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hD80L64hAAAA:8
    a=VwQbUJbxAAAA:8 a=tUhBpIbImjzArLDXXXsA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeDLAN6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:13:58 -0400
Received: from osg.samsung.com ([64.30.133.232]:52127 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751553AbeDLAN5 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 11 Apr 2018 20:13:57 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usbip: usbip_host: delete device from busid_table after rebind
Date: Wed, 11 Apr 2018 18:13:31 -0600
Message-Id: <e245729770ca221377aabb7db4daba4c41dabdb9.1523488629.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <b6765a8e7116246649f6a90c56b12fc65bff9b14.1523488629.git.shuahkh@osg.samsung.com>
References: <b6765a8e7116246649f6a90c56b12fc65bff9b14.1523488629.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1523488629.git.shuahkh@osg.samsung.com>
References: <cover.1523488629.git.shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Device is left in the busid_table after unbind and rebind. Rebind
initiates usb bus scan and the original driver claims the device.
After rescan the device should be deleted from the busid_table as
it no longer belongs to usbip_host.

Fix it to delete the device after device_attach() succeeds.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/usbip/stub_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index d41d0cdeec0f..fb46bd62d538 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -186,6 +186,9 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 	if (!bid)
 		return -ENODEV;
 
+	/* mark the device for deletion so probe ignores it during rescan */
+	bid->status = STUB_BUSID_OTHER;
+
 	/* device_attach() callers should hold parent lock for USB */
 	if (bid->udev->dev.parent)
 		device_lock(bid->udev->dev.parent);
@@ -197,6 +200,9 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 		return ret;
 	}
 
+	/* delete device from busid_table */
+	del_match_busid((char *) buf);
+
 	return count;
 }
 
-- 
2.14.1

