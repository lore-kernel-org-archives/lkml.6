Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3765319-1523363671-2-11566459545891381718
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523363670; b=MX+hquBMioub581EtFzOVV0SF7UOHMPveKl49j/3aH78bz+Giv
    a77krRjwMjbQ3jU3pDQ6SRT8hYwg3itvuTXt5sDK3Lu9H3Z1MfKazdwOANLqhEfu
    Ar68VZ4DHncAt4sy/+UrB6bnJvihJhZFWPgQJF87BsiclK9c3Ylm7YSMeFXJBhmX
    43S6ljrAQLq7zKuq0p/SHmDJbaKU3HRqHYRLnRbB0QMRNP4TksiYogiVnJfVSE2b
    sZetKuAuYcqx2s/wMz1v+5pMFHismYkn2vQ9cgZ65hJRXhQjqQMlfLHOboVbXGiA
    6TzO8nvlIocsuseGfFn80gWv7txkvrU8dm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523363670; bh=2UdB1qrly+xSPqSdqcyhxnOGFR6xxa
    majeTI1VCuJ00=; b=K64/aXr5mdRP7S6KiLwYIOyJQg3rFKrPD8OUOIEl8Dykp6
    uK6g965dCJ8ZAeUJ6QsHFy07pa0o6SgXMqHbFxeeVKgiOoDrZycDgLKu10hNIh8w
    koeQTicoRqquq/zCf/OukRzxa6YjG46UDu8jmELbDBQPs+kbvONCLnbl7jeDzL8u
    IBtzAQAMnCB4snqkLhoCOOzehAXjcISxcZS+iVr9ZnMonOtQsdmAlBqnEmnfMI2K
    db8/X3gNdjQrMtj4DTkScjk2AK/gwDCPFLp1Tu5OUQpQB0MksD1hiyXf5usTuwbS
    oiMIsPyFDuzGNXWU11MbYEn8TbHQEUAOK9UEeLhQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=sl9v3pQS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=FPi5QlPe x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PNtcta5Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=sl9v3pQS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=FPi5QlPe x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PNtcta5Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOHrC22nI1RGVOdStmr+BwnqBjU65JYlGEMsCHpeM2uFu97W3BlQ1J/i8xWReYvbcULLqFSOSMOT+byDYigRlzGd2tqDA0QJFqf8ZkrsS8RTspJM8hP0
    gGGcZ27TO4V7oO3wRRPE3fy+/6nLwrFkCa7Q/aJEItb+l8q3lKswv7tAMQ5YDzXe2iYqQ7hIkcG0874QYKqpoOgOiAWQ0pQFEOYxArVM3xGRMNx+60tO5H6B
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=dMW1zwEvQVwx_SPhr94A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeDJMeZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 08:34:25 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:50860 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753165AbeDJMeY (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 10 Apr 2018 08:34:24 -0400
X-Google-Smtp-Source: AIpwx4/pvTMidzzIX71YhW4n/c3tmsL3ExJtQoGTg7qDWwjRdopyngdnnY7H/jfafuQn3lPwSv5Cnw==
From: Phil Elwell <phil@raspberrypi.org>
To: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexander Graf <agraf@suse.de>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH] lan78xx: Don't reset the interface on open
Date: Tue, 10 Apr 2018 13:18:25 +0100
Message-Id: <1523362705-30032-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_04:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 92571a1aae40 ("lan78xx: Connect phy early") moves the PHY
initialisation into lan78xx_probe, but lan78xx_open subsequently calls
lan78xx_reset. As well as forcing a second round of link negotiation,
this reset frequently prevents the phy interrupt from being generated
(even though the link is up), rendering the interface unusable.

Fix this issue by removing the lan78xx_reset call from lan78xx_open.

Fixes: 92571a1aae40 ("lan78xx: Connect phy early")
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/net/usb/lan78xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index aff105f..108f04a 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2514,10 +2514,6 @@ static int lan78xx_open(struct net_device *net)
 	if (ret < 0)
 		goto out;
 
-	ret = lan78xx_reset(dev);
-	if (ret < 0)
-		goto done;
-
 	phy_start(net->phydev);
 
 	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
-- 
2.7.4

