Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3296075-1523345824-2-13690369361284514519
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
    1523345824; b=iUHaCYZTrYnL+LOQLy69sdR6iGs268HFeDVrNBMc6IlVH0kgqi
    0dOOrnaw6W6UCgNrPqgEeSDeu2UAp0trk5KdmA5Xnj4TutmCDbelI3qdmlnaRo8h
    YL8UqjJKs+o/bErDCGr9H+6cjT5FFc/VzANN1qQRdIPtGybKjCtSJIRewU0r3n8n
    A/tzQTRKrhhG5s1M8zZ8KI94vbmoMSuOUjxsp/eHen3dLgZvCSRjYuFQfFidjeYs
    7lePW5TZM9xQ3sX89xO8TOT9EHOz6Cni2I9OQHnWWClWywC2B9B8GE6xVnz8oSXn
    bGRDnriAe4jeVEMweyzAC0Ws05pzF+s+30/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523345824; bh=rkyMR7QuBTJwz8XQxBGzK7u0CL3cF8
    SVFBCjzdOIENQ=; b=sQxNq9Jri57lj0rEMbiDtpriJTX1/0bAU9zRsh74qfudNv
    0cizUEZt0Nc9kpP5ACLnx/1DggEQ+sjtBIWOICG/d7NWq4HAd/DjRBsGbjcYpb8d
    mHxTsw9iEKXDt0XEDd/1xOpkAyfrUPPjLMPAYPmHYF7qYaFdbH+qVTj/06quOqpw
    xZDj8QLHHLJRgzjBXQ+WvPaPf3Bd7Y306oZrPCHo1JJlXjcDDBzrYXOZUv8puNil
    4G9mvOK6E+wwjr5fQS3Q8qB5Jeh4IAbyy0SVrIyy8nJUeynX1ShWdq9oug8GVTq/
    cV2eknqvCtaPoC2kSa+uLk7EmzDg0jdMidMyDT/Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OM606hmR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NkYCiESS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OM606hmR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NkYCiESS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDdwMCw8Izj1ZOKkHBc9a6i6IOLvzejP3DH21io9J+T8uBSkLB+TpHAkV4NmBcQy3rSUITQLJSthJYZDZzIoD9VvzO/AzYccTilfZtNsmCx5Ax9kDfMh
    GfY5YpqknuJfC0VW3NtB9hjhlJIyTVF3gXRmht1e1htCvEmAmS0BCCYZlsx16jJAjrfaFZ5+XYNkBtDDYmRxkKpEkYnJn1wE5zhqNHFyNxnEFfX3vl/OHJTt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=tmjX-nCzVX8A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=edgWQxouFUk1NSNC0jgA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeDJHgu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 03:36:50 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45362 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeDJHgt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 10 Apr 2018 03:36:49 -0400
X-Google-Smtp-Source: AIpwx4/RQK173kruTXuXdQgvidfTMD015/Xn+dpJ7P2yDii1KYQMRMUSq0IwUBXPMNjkN+p1GA9qsw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] usb: isp1760: Replace mdelay with msleep in isp1760_init_core
Date: Tue, 10 Apr 2018 15:36:40 +0800
Message-Id: <1523345800-29129-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

isp1760_init_core() is never called in atomic context.

The call chains ending up at isp1760_init_core() are:
[1] isp1760_init_core() <- isp1760_register() <- isp1760_plat_probe()
[2] isp1760_init_core() <- isp1760_register() <- isp1761_pci_probe()

isp1760_plat_probe() is set as ".probe" in struct platform_driver.
isp1761_pci_probe() is set as ".probe" in struct pci_driver.
These functions are not called in atomic context.

Despite never getting called from atomic context, isp1761_pci_probe()
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/isp1760/isp1760-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/isp1760/isp1760-core.c b/drivers/usb/isp1760/isp1760-core.c
index bfa402c..259c3eb 100644
--- a/drivers/usb/isp1760/isp1760-core.c
+++ b/drivers/usb/isp1760/isp1760-core.c
@@ -34,7 +34,7 @@ static void isp1760_init_core(struct isp1760_device *isp)
 	/* Low-level chip reset */
 	if (isp->rst_gpio) {
 		gpiod_set_value_cansleep(isp->rst_gpio, 1);
-		mdelay(50);
+		msleep(50);
 		gpiod_set_value_cansleep(isp->rst_gpio, 0);
 	}
 
-- 
1.9.1

