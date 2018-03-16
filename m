Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3238001-1521211505-2-13541883561045026894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521211504; b=BfR8BrATUsPUR5nCxmWisE2+965UKh8+4XaJi88miNUbMMw
    nD4DSZD+VZbldPP4WeWMcn9HI9BHbXxWTfniXqRHfCJKOSsaSc/He6HyjsOUYTYx
    V9pk18acDPAcS7Bb/zaFkupSpH4XXhzrEP0JnNOHS9qMYgk29W8+skQUS7mmYxtw
    qPIoVP2MJLiQq4/GoEsaDtS1FWb0oU9v8yGlrID6bcdJ8jDFcZw0LSTWNfj4iw60
    FO9KXfMXAJatgcwSsep/G2nUDhu31cvT0cGj7zPFiq3Kd8DESGOHSl2Jiex32Xjz
    yI4sFbDKsu2ixCzuS2UHxrgVLKuG2u5x7G0ZqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521211504; bh=+Wxv+iA2NCIvGxAkQW98XAmK6nvI3GgBO1tr+75Qye8=; b=L
    Dxyk4AM7gLX589vTfBukmHf5TguBzSfSrLL9KHgCWx69x/BQhI6uiuy7zKk89ffe
    U8oJAQim/4Dd0/dGGHOp/hXFk8FYno6FFzh8njwd+wVG6kqg4KfZb2HpNtZhnsMv
    8zrbtDppMZCcXknxT2maZKRquhEXUJZgY8wBtN9MoTGL3phHg/y68YQ2yCEiPdCY
    YwUNjP1z2wpG0jwUX0eYc9Z4rYnGvXcEV70PlPdzcJXFw37YqQySjFzMlRgPOhUB
    PYn92XWzY9qTPwQI/MjMWAUQkeAngh0HTGeDcsUSYM3Z3ZrN2b6/ocDJH40CsRLb
    b25OQlpRzsNRV1U+v4Tvg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=kGGI+VZP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=kGGI+VZP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCPOoe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 10:44:34 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:36235 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeCPOod (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Mar 2018 10:44:33 -0400
From: Roger Quadros <rogerq@ti.com>
To: <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: dwc3: core: Fix broken system suspend/resume on AM437x
Date: Fri, 16 Mar 2018 16:44:27 +0200
Message-ID: <1521211467-6872-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On TI's AM437x, the DWC3 controller looses state after a
system suspend/resume. We are re-initializing the controller
but we miss restoring the PRTCAP register. This causes
USB host to break on AM437x after a system suspend/resume.

Fix this by restoring the PRTCAP register on system resume.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e8890c0..5becd7f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1374,6 +1374,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (ret)
 			return ret;
 
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_resume(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
@@ -1384,6 +1385,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			ret = dwc3_core_init(dwc);
 			if (ret)
 				return ret;
+			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

