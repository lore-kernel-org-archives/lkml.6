Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3292334-1523345847-2-17731877179643535156
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523345847; b=bo8EEbJ4pKOh1/7cJ735mKX4ztsjEY/AlTndfxl3I2tA1BBhz5
    NFzP7Pbhs/ReYEwJs3r4rOu5edKjAsqtd39CNEddGizT2bpAYaketH6Lmyi6ZSEP
    LFglzxqcdK5e8zD1U08bBPN6hssHgOVpdOWRMkLGprDl0GQkO3MICzghYZ+QdBUh
    WppMcStWfts8A0Phk5E1dmlVKyZLrwfYBZoZDGhkhZPEdY6coxgh5+j9QSn2hAyY
    VXanTjhExn6/G53TijljnQ6FSxIUroTt8hTkh50XwFd+a99M7wM6h0TU/8xURFwK
    AgfqEH8xMvpKFlXBHibo7qhXT3HF60hJ2cNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523345847; bh=6S8jG7vjC9gnlDL/sJSHa7c/LtL6bp
    o2yNzk6H2JTl4=; b=O0UEAsGxrRMc2jeFLKvyg4GsNtvExdq4/ShpOe1c3zCxsW
    vuwi2zPj2OhTJAy41y+rTSeGl4qXT19VVGwqRkZkMlTHXHxzbcfulZVIKbP7/cZb
    v+j/KVzL03AXlt/PV4S71vng+j50cyF+ct8fRdl9TvlNb4oZ+F9OTQPnlj3sMWYY
    HzI7UGujJx0ljIqxh9inyrkgelAjQUNLYXKFW0NcQwyMR8CgY67nbGfWQNA3Cttg
    6sepIZawMzKkUuOuVr0BG6K3Rg+9EhNTz6FSGr5/AfVK1VTdLmXDdxnEtNOE1+/c
    jQP854CT4G437RKb/Tvt24J8aXGooDlsvox0mdYg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DfD253Ij x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gPk78r/S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DfD253Ij x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gPk78r/S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCUF/UHEeXzKzjedcNzdlHMJKZ4MYNUPoczGF5VvW3f26ASEtDXVEHd1KJUhUoa2+fznVYMzavLi/fi9y1SK2yOEI79TxdPJqtY0/Ih9O6xSGEDzsC/U
    ikjz/PIxZdLNYFB3XaDQsU5OnJSMW3xi0ALdmVEJ7TB6ZVw+HWpK9FUf5fwDWwYD/spyG4lEZcwVVnERD6oSZFWFhqiB9mqic43WV0583HQNTsYyS/DpJHhd
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=tmjX-nCzVX8A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=3oNrhRv6XlMojPyqH4oA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeDJHhN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 03:37:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46446 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbeDJHhM (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 10 Apr 2018 03:37:12 -0400
X-Google-Smtp-Source: AIpwx4/5ayzLcQAY2NvCUeBjHzA91zK7LaoGqhusVg7TKAZlUZS8u2yh13ZwRbCrpZtOkGwWajiYDw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] usb: isp1760: Replace mdelay with msleep in isp1760_stop
Date: Tue, 10 Apr 2018 15:37:06 +0800
Message-Id: <1523345826-29223-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

isp1760_stop() is never called in atomic context.

The call chain ending up at isp1760_stop() is:
[1] isp1760_stop() <- isp1760_shutdown()

isp1760_shutdown() is set as ".shutdown" in struct hc_driver.
isp1760_stop() is also set as ".stop" in hc_driver.
These functions are not called in atomic context.

Despite never getting called from atomic context, isp1760_stop()
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/isp1760/isp1760-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index 8e59e0c..5599310 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -2090,7 +2090,7 @@ static void isp1760_stop(struct usb_hcd *hcd)
 
 	isp1760_hub_control(hcd, ClearPortFeature, USB_PORT_FEAT_POWER,	1,
 			NULL, 0);
-	mdelay(20);
+	msleep(20);
 
 	spin_lock_irq(&priv->lock);
 	ehci_reset(hcd);
-- 
1.9.1

