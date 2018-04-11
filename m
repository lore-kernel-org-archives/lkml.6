Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2164128-1523444583-2-12474475786595734778
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
    1523444582; b=j7lqb5G7bITa6ajy89s8NnKX4TNUC7YFKEVVuCAXN7VKxFQEan
    KF+QWQpIelbAQForu4Tqo3mmFOcB9UtggC1OvXIqdbIn4OLKxQhI3CVlYEvV9Swu
    uesWaEDu1UJScMda4ydN4e4fBz3boLDKN5mZYRVg0HLENT2ZmSggMdzlz3znVe04
    N6hIdomprvybDkawBgT4EdUZaG20CFmLZ5/tzopIlofYbA7BcnCbPKEhrxeU7HN5
    1EpNQCJBU/lrF1dN38DzKvmbNdXTJoYrzojx95Sr//oDQfcjxTYwrIXBrYbDKv8v
    v0bzDJsgetbOyTjl5tPOvIvsTFRLLGCOK7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523444582; bh=GfnHhsWozPC8F+tS6W72E3fMKReAnj
    PQRvX7IgVBjCM=; b=bUH1yUqAf6rBKJEKely2+Y9+mSuREeSFAh++9WwVTyaxib
    fDnd3mGyvsrwTBVGQ9cYGfxf1skmS/pzIGh7QwXKOlEgIy/uhSmv2RiO6ECpv8e2
    OMlkfAoTmmipdBN8Po0J68qa6LV9g6x/PoWw2IMsPB60aU7+yoUvBB/e1nh7F+Po
    aIRJUnf2oVCm9xI8Dv8+7T8siutPV+joIdq/bTxOnHZ5B7MmO00qnTIv2g3Eskp/
    HybH4CBdiFAjnOW1fpoug+Acfrwujz0tQgC2//xOavzxaSo0dGNBRcGlypv9lVT6
    HBeRYSFDzZRqk46+BHQFpnP6Ooyx/2BPGLb7G6+g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=nmkNwZQ5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=QCGE9oKs x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ekKVVQVP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=nmkNwZQ5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=QCGE9oKs x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ekKVVQVP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKTzgrEYvLO4wu/YIM0zDAsjK6b20P9OTQnu6rIJaspig2STgv0ufXbBXOPGEPquVncmQxEGY+nNx/bRw5awBgaRwI1QtlSP2mQ35mYvE3Uj9tAIBQyY
    xG4Eg0lSHwgbMBh+R7JpcL8ae7ZUvhVy+lrpcYmuSlk2MD/W1bHU0GtCI498Nh1LzLbyGGo3IePms6p5pkRIu/ViCNH7+cS21S+2/DxD1WFTOeTvAfQB42mA
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=yf87aYU2R1CNuXuf2b8A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeDKLC5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 07:02:57 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:52786 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753016AbeDKLCy (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 11 Apr 2018 07:02:54 -0400
X-Google-Smtp-Source: AIpwx4+nBq9zR+Fzkm3qgpvaU/hd5SmbBxTL5eadF0uozEtPPJxdafOcmO4QCeK7JBGmIo2D1GFH3Q==
From: Phil Elwell <phil@raspberrypi.org>
To: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH] lan78xx: Avoid spurious kevent 4 "error"
Date: Wed, 11 Apr 2018 12:02:47 +0100
Message-Id: <1523444567-128200-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

lan78xx_defer_event generates an error message whenever the work item
is already scheduled. lan78xx_open defers three events -
EVENT_STAT_UPDATE, EVENT_DEV_OPEN and EVENT_LINK_RESET. Being aware
of the likelihood (or certainty) of an error message, the DEV_OPEN
event is added to the set of pending events directly, relying on
the subsequent deferral of the EVENT_LINK_RESET call to schedule the
work.  Take the same precaution with EVENT_STAT_UPDATE to avoid a
totally unnecessary error message.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/net/usb/lan78xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 32cf217..3102374 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2507,7 +2507,7 @@ static void lan78xx_init_stats(struct lan78xx_net *dev)
 	dev->stats.rollover_max.eee_tx_lpi_transitions = 0xFFFFFFFF;
 	dev->stats.rollover_max.eee_tx_lpi_time = 0xFFFFFFFF;
 
-	lan78xx_defer_kevent(dev, EVENT_STAT_UPDATE);
+	set_bit(EVENT_STAT_UPDATE, &dev->flags);
 }
 
 static int lan78xx_open(struct net_device *net)
-- 
2.7.4

