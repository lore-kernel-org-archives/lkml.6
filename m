Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2024894-1523440775-2-13269724856428366048
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
    1523440775; b=iwr12Eo3kyiH9/Ipysd3EhuasrEw9bK+h2dcHcfgOXqjEP9GfE
    2No8ok6ga7gB6j6pF6WaS3Xa4NMSQ4LExeIoS1QeEkL3eXunWtB7JAVjntZ+cII/
    GbySZ9s3qvv4ncnwMRedW7jg2RBNOI+vQY7qWEOM8LAaS8PfIZDtyDwenwD18tQn
    QJiZF2l0dycRM0mEuOIvWckYYytPeguCZXChcMB+uT5SkV30EztOCd/eSZtcGUE6
    zY5KkiR1+vO75h3ZzECEvLV7ytXelDofuUM8rctw0ZbMyT+ycWTQFvOKDz3p/fQB
    XlgNs2We+95be0asWqf+6LOnLsxm7IUnuq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523440775; bh=TLNGukJq9aoTn/UiuAGws+DBAOrrke
    nCbA3WTvphtH0=; b=msOeKfGaIYyuhLbpOmSVpbYwJJlD3NLfjz58HH1k9sCDoV
    PB7ruT0Kg7YFUFS0hO6dkDYR08vL4BTmhqmJHbRbqVh7UEWyof9ArJCPEkDY+SSB
    z24DzyDlQj6yN2JP3OEbnJbvWWuHYuosB+MtMUuu+sTJpmTv1dUoxexw2rHaJiy7
    esUdDubjEBuslu11JRaN1PAy2VZkU+1ve/PSWClUZLitg5xnia/DOHm9R2IwkOv9
    qNEXZfunXD/wr8uI+9/iPJnZCeXo9p4fwF98+ChqyARDDrqwTk1yAhx5TlGF22l9
    +x5q+wRLWnWdUqiGgPgc1dGGuBWsk5Iv3k7pH40g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=UsgR95CQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=lI5JBRIv x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=I79MqYj/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=UsgR95CQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=lI5JBRIv x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=I79MqYj/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPW7w+8eSNlx9k6XbBvmFALxwG3oJ+1tUMz37MIrjKs+X/hRE+sAhVrBPbykvPRM8qYYMn2WlVH7LJhqVmhqK4mdsDDc2iJyG0Y+l4z49blY7ZnBd0Cf
    v6ho2n5mLcw9mdkAQq6ooyH5SAb5dzE+sq935cA+Vy9zqNJBwcDEUXp8ysGD9mv8nRuV1D0CGVXQRQLtjuiLwOjhSYv6o662b+VElLOCZ8YY12512oMVT+oI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=u2rCM0WZxCTF80eq96sA:9
    a=hopc_Mnd26h9mjeD:21 a=UczcMTL1NPQg-v51:21 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeDKJ7Y (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 05:59:24 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:65199 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751970AbeDKJ7X (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 11 Apr 2018 05:59:23 -0400
X-Google-Smtp-Source: AIpwx48MXY1jLzg0rTgDuohwJN8qVDo4ubV7/jljBDevoOS0Fe+6ONjkNonH2zaLleXWQSUgy0JbzQ==
From: Phil Elwell <phil@raspberrypi.org>
To: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH] lan78xx: Correctly indicate invalid OTP
Date: Wed, 11 Apr 2018 10:59:17 +0100
Message-Id: <1523440757-127451-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_05:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

lan78xx_read_otp tries to return -EINVAL in the event of invalid OTP
content, but the value gets overwritten before it is returned and the
read goes ahead anyway. Make the read conditional as it should be
and preserve the error code.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/net/usb/lan78xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 55a78eb..32cf217 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -928,7 +928,8 @@ static int lan78xx_read_otp(struct lan78xx_net *dev, u32 offset,
 			offset += 0x100;
 		else
 			ret = -EINVAL;
-		ret = lan78xx_read_raw_otp(dev, offset, length, data);
+		if (!ret)
+			ret = lan78xx_read_raw_otp(dev, offset, length, data);
 	}
 
 	return ret;
-- 
2.7.4

