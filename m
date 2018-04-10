Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2410678-1523323771-2-13820482006360243230
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
    1523323770; b=FZP3NBvULiodNd2Mb/aCuBcJluQdlkSQRDPdc+aYxzgeCaF4d7
    42XCocWIDkqY/I4SNxzitWoCf5okBAh6IoNzijpBbyqhM7bzCQSy4bucl6lE4YI7
    3jrTOKWeUiMC+OIGxfWPH8mowO7mqfPcVKjMuqvWMglRPPoSgsG8hESy9VizBUr5
    t6Rvbg/BwVhTgGmCNi6qKJrPLnxIGnH6scjkPNU9ffdldm4kehBUD5HokN0xWiBA
    I5OcDsap3LmkADFUACBOP01nHScpVkqXsV/PWYZCQ2ahVIiRBkxYt8yfCNdNklf2
    eh+TuX4AaK6/JZqe0bXJwftkpePf/2WviKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523323770; bh=5gZHkiVCVkZH1cF1aSFquuMr/t09yL
    W05eeLHtm3Y1w=; b=stoPLlfbFdS26NvTjWMXIvptYb6Yx/8PL7WHRgxHuly35p
    TZNIvswhpIR1fP3d5+jF29fRCsDCw4LtnSjHft+hOFgy3ecAnPTdM7+aQo7iiM1U
    cNeKKmSV+kCBy2dn3ZUhBlaSbDlZGsqL2edsH1P+/GUn//AqdYCNyjatbRm5lG5l
    uPe3G18KwT82OhUQVl49hvvcqEyfuz77nM2lMHwLERElh9Ftd/ncfDiJ5p/td71h
    IK7SGfvefC1Qy2A8sXG7/RtJ6z9xmqUpYMTZTI/ujiFgsRSoHx1rbRBulrlSWcIo
    3fnsdyJ2BjVrgaybe++LkilrwYIwomZbOieiybTw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=u0U+pAsU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PaTa4iJU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=u0U+pAsU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PaTa4iJU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBJeQIb1kgBGUK0itseyV03sHOAvlCK2//aGKXq4JFcl6LrPwuWIwGEyrJBhgAEClYYI4xK2vTqyhlXthE5xNGVXs6LPVZCtS05mlHVko70WoeGe+c9h
    fKehMDrF2ZseubkNEyvIMSQbh8lYSAx5ePXw8S5zJBIQEVRm8kqpNs4LrYyZ/b8Nur57tb0zRW225ZWYZsZSL7ZRrxyyN6tEihyiPHG9iQl4d2Yw/o8jl72i
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=tmjX-nCzVX8A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=F7M4UJ9ODhekjDxEDoYA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeDJB3R (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 21:29:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:47083 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDJB3Q (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 9 Apr 2018 21:29:16 -0400
X-Google-Smtp-Source: AIpwx495SAx6vi5PJT3eQN+cW4+fPLKw70IqEnNslKSVnc520+OhosDXZfoYsXkQB/l3q44PcAceTA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: storage: Replace mdelay with msleep in init_freecom
Date: Tue, 10 Apr 2018 09:29:08 +0800
Message-Id: <1523323748-28361-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

init_freecom() is never called in atomic context.

init_freecom() is set as ".initFunction" through UNUSUAL_DEV().
And ->initFunction() is only called by usb_stor_acquire_resources(), 
which is only called by usb_stor_probe2().
usb_stor_probe2() is called by *_probe() functions (like alauda_probe()) 
for each USB driver.
*_probe() functions are set ".probe" in struct usb_driver.
These functions are not called in atomic context.

Despite never getting called from atomic context, init_freecom()
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/storage/freecom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/freecom.c b/drivers/usb/storage/freecom.c
index c0a5d95..c7f886d 100644
--- a/drivers/usb/storage/freecom.c
+++ b/drivers/usb/storage/freecom.c
@@ -477,7 +477,7 @@ static int init_freecom(struct us_data *us)
 	usb_stor_dbg(us, "result from activate reset is %d\n", result);
 
 	/* wait 250ms */
-	mdelay(250);
+	msleep(250);
 
 	/* clear reset */
 	result = usb_stor_control_msg(us, us->send_ctrl_pipe,
@@ -485,7 +485,7 @@ static int init_freecom(struct us_data *us)
 	usb_stor_dbg(us, "result from clear reset is %d\n", result);
 
 	/* wait 3 seconds */
-	mdelay(3 * 1000);
+	msleep(3 * 1000);
 
 	return USB_STOR_TRANSPORT_GOOD;
 }
-- 
1.9.1

