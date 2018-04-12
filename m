Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3705427-1523492067-2-10241072292191865910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523492066; b=B6E0SWX2QNPW/6DFocy3kF/TtvckSwzYTTicp3HWdnqoKSCvNs
    l6k6Ue648IiZiUI+3FHYxH3+1jemEq+kudZPFQ5dIskPhmmTzTULXp/rBmrefv+1
    SnTbVcH/iEHf/Q1iBZlgjxqaummUChevFsYC+06UCNYVsfg0wY9/jBsNRU/gF0kY
    PB0k9ZiD6Nx/ailLnDhLzRD69zJ04ixqrzYKvAjyhRgCwPLZQ8EQQjcYZ+ecxkTN
    JYuWnz2ma0Nskyc5FjToM79HcZ0NzR6rYWguhOz5iHmjsa5HZHB4x4xtdeygJg89
    krlcu9x78VsYQl4HEk/fEk6ua5dq/fwZd2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523492066; bh=
    wjlscmWONuAE5FcaSAV6d1xQIkox1njGkNaHDlDTFTs=; b=hAtopf9FecL5aVLi
    kLn4G1bsotGp7ETQGysdC0zfe3/8j36Othlvmety9s1hVLQ/DLo+jWj4I4nbOij1
    3ynAPHsWSdIxdwAqEzTozmPy+rgqB+NKiq5b4+PtzyJWWHnTT3OV8d4ATNFt9Sdi
    Ae3kRTwp91reIRNn7vRJ3iOs1dUNCjBsdb0624gs9ltZBYDKTYjNTaR3g+sfsaNh
    Gngde0KMuyk/I5HYLwsm+4rQNWamjdFplJf3hZie1uHpSaBQyzhmvvmUxWrC3zQF
    IWnXTH4fgLRPbNi35wWu3TkPINuBbsINXM4dkl2+EfqOADgzCaJjW0zx2Uj8r1ux
    B5FQvQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPrYEapnTw2iXlQSbFnh1fdA1iJEcjRDSKe9/pwjNtRHGCY5Yr2szMAKqQHMioogYnDQeik1oDvYCGiwC8a8ydgRiDn+pfoTEZBmoEK9r/rnUYzVPUv/
    4RG7JtDzjSPbhS5abrJ7kDYjZn0o1XcACTGo2Kr1vrQzaHcnsw4ENKWpuVW/wZ+96TnHEmSuFS+MysbB2XEwkDfPzTEnlWoerOgXo+Ern1kotb1bBpQir9qP
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hD80L64hAAAA:8
    a=VwQbUJbxAAAA:8 a=FzfdhALRrfit3yjIu2EA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeDLAN5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:13:57 -0400
Received: from osg.samsung.com ([64.30.133.232]:37717 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbeDLAN5 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 11 Apr 2018 20:13:57 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usbip: usbip_host: refine probe and disconnect debug msgs to be useful
Date: Wed, 11 Apr 2018 18:13:30 -0600
Message-Id: <b6765a8e7116246649f6a90c56b12fc65bff9b14.1523488629.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1523488629.git.shuahkh@osg.samsung.com>
References: <cover.1523488629.git.shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Refine probe and disconnect debug msgs to be useful and say what is
in progress.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/usbip/stub_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index dd8ef36ab10e..7813c1862941 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -302,7 +302,7 @@ static int stub_probe(struct usb_device *udev)
 	struct bus_id_priv *busid_priv;
 	int rc;
 
-	dev_dbg(&udev->dev, "Enter\n");
+	dev_dbg(&udev->dev, "Enter probe\n");
 
 	/* check we should claim or not by busid_table */
 	busid_priv = get_busid_priv(udev_busid);
@@ -404,7 +404,7 @@ static void stub_disconnect(struct usb_device *udev)
 	struct bus_id_priv *busid_priv;
 	int rc;
 
-	dev_dbg(&udev->dev, "Enter\n");
+	dev_dbg(&udev->dev, "Enter disconnect\n");
 
 	busid_priv = get_busid_priv(udev_busid);
 	if (!busid_priv) {
-- 
2.14.1

