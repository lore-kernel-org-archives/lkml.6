Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-536962-1524060243-2-6187638446250162470
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524060242; b=G+dr/A1zMzKt8obUE9BBu/rc+RjGQdc6OQ0wrmt+czMtgGNNeq
    RJXkZO/BeqgI8AukG+3YxoS8BmK8Y+56Y544295dNhteA4bAN0+P2XMATRwGhQ9D
    9yr1NwYBPaIlxMN3A2dU/mJZXp+3YusKJIOOVzVMb182l00nQrlznIlqfKBkypDc
    GCg61JkQqdkP1mavTggh+TdlDheq0MIiLmyJT1wL7vnY9uwuMS3QBIQaO2+C/Msf
    vZV/X7cyck/C+ThJ4lEFXDNZw4Htf34FIsJ0Y8svBXokjAbe7mRTM5Nqs68UoUyL
    dIU9zG1VPhhP5FCVS0gvER9y4IMlI2L4KKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:cc:subject:date:message-id:to:sender
    :list-id; s=fm2; t=1524060242; bh=Llaq2vpplo2NDT8qb/Ox/fFhhEUrmh
    1RtiUQh0MGuws=; b=lBwRTkp3Aaxl8cOrnxl88/URWGhacncICGFLPJBQNvq1oY
    lZt+SPRD2vf9T0A8olEF5zX7D3CFe+it+Z+aP4qq/M21m+s6horeLpBFVEiO2j88
    fGo588YsCZQv/5ps62ts0aT0nlpQcocYJl+11bg5hx+BgUKZmx0xpPo77IihucNW
    N2IwkRV3iNpifJbpu59HCZY0xV4sD/dpP3b/Vip5SOKOQ1/SqYNZQMBNsEGaZ8hf
    eqLn2NqXzl+LFc7+ExhzVzHPuh4VpcQCzmg12f0azOcKnCy91jNQuDUJVG6PSrWW
    yv43NmalWUpFRYrM3nwpEqhMSTLGzmA4BP381aIA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=raGQ+Tk0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GWRuIecq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=40 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=raGQ+Tk0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GWRuIecq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=40 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAnHONY5F+p90Qjq4Vjjsmc5wcEH9YeIvc0sZpek4kjGjfIJ+YDf51LgJB5XhP5RY+SeQdZYB1p4BWe/OXkPxtyTU0vVcQLcxDxU7sZu7oZPVd32LlDg
    QCY65ShTfYWNYUaPUJXgvvrlk8M13ojZm+rPR3Bxe+OIXqKeRx+f7gZQ86JGttiN0I3VlhNwH8i5C99tvNnonGyNw1sXv0SxnSGHFqEow6rdFrXZTwgvjs8/
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=CzwUxKIRHyYA:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=gyn7KXnmNKB5_wepHVkA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeDRODd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 10:03:33 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34411 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752727AbeDRODb (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 10:03:31 -0400
X-Google-Smtp-Source: AIpwx48DG0Wi/BHPD+RhGTEK3wCqpZEkxEYgotQHoH+0cLt8F/+F1GcY8F8Pb1+vlgWnUKNpGYCdow==
From: Pawel Dembicki <paweldembicki@gmail.com>
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: qmi_wwan: add Wistron Neweb D19Q1
Date: Wed, 18 Apr 2018 16:03:24 +0200
Message-Id: <1524060204-7814-1-git-send-email-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This modem is embedded on dlink dwr-960 router.
The oem configuration states:

T: Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 2 Spd=480 MxCh= 0
D: Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
P: Vendor=1435 ProdID=d191 Rev=ff.ff
S: Manufacturer=Android
S: Product=Android
S: SerialNumber=0123456789ABCDEF
C:* #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E: Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E: Ad=84(I) Atr=03(Int.) MxPS= 10 Ivl=32ms
E: Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E: Ad=86(I) Atr=03(Int.) MxPS= 10 Ivl=32ms
E: Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E: Ad=88(I) Atr=03(Int.) MxPS= 8 Ivl=32ms
E: Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E: Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=125us

Tested on openwrt distribution

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index ca066b7..c853e74 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1107,6 +1107,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1435, 0xd181, 3)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 4)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 5)},	/* Wistron NeWeb D18Q1 */
+	{QMI_FIXED_INTF(0x1435, 0xd191, 4)},	/* Wistron NeWeb D19Q1 */
 	{QMI_FIXED_INTF(0x16d8, 0x6003, 0)},	/* CMOTech 6003 */
 	{QMI_FIXED_INTF(0x16d8, 0x6007, 0)},	/* CMOTech CHE-628S */
 	{QMI_FIXED_INTF(0x16d8, 0x6008, 0)},	/* CMOTech CMU-301 */
-- 
2.7.4

