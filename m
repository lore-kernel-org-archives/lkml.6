Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1055825-1523541422-2-7792885968492928021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523541422; b=mG0/kNZqANauQ+4e48eeOjqFpVa6sa9BlBS+ID/XuvfL3FMd6u
    3JhVL3pujfP68gWv2Hu6+1zUds32EmsqqGVlgk2RCMcRJA+dfD8QsL3Nl0U2dyCZ
    bxG+7oOwsEmp+BKvAzax8iPCq+zNgdLDlAY/WX6w0/pR7vxgqyB1nmyQ5u5IjJRz
    dH5mtEtKDdNNw6VVTSX/MJpGA+YEusCDjfJlbIltPJ22vu+4+gOwmT1rvtp9L2J5
    xC7/7nCYxsn+p2afBG+7US+4bNYU9anyhDodUU7wy74gjX2BY/LYBR9lb7ylagI2
    Ag0ZKcb2GVUn+8jr1kmVytH71roQOwJCAVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523541422; bh=
    efYTqgJz0AQy0g0PI4PCS9QxZ54MLk3h6dlSBrVQhQQ=; b=arkg6P3P/lskpB1j
    g9UpgHgTE8aOAWU/EFCQG3gd/IHyhPZF9+JEJyP0nLVi/SHFGcN6e6A8+73xBSxi
    4yPpBGe9ZsZJn7jc2irkwNSd0+ZgIUpQf79BG/kMONy2rmtgEqfq7Xz53519tiKt
    ww0+Wf2pS0CX0LlKzRzSZtKfTJQQkIWJRdxyhqxDO5VlkNtSNZzTzfgRd4X5Jkp3
    /mhcL15/4XqBU2LUI7Bnkvq/kq+ePvLPSHlOjCaBp/DTKu8f3RQ/thn11KQMwCJZ
    Lz/theiLLDagUl4qGcd3aVOMx0wlBkfV9Xrgea7fcVUHcWUjkj8X0KP+f3UxxOR6
    5DeTKg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=o4tJQvMf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=xtAwRmcS x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Im2m5Lw3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=o4tJQvMf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=xtAwRmcS x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Im2m5Lw3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJtPczCveldS99n8eruF9KTNAySlln0ApWQ2xQ6G9H4tEVHqKzFPxfqva6Hvy3rwtxKojWt+plFOuqvzENSk4dRxz1YlN7CItTkG0m5GmzczRsldLBv0
    4xu/tS/aZE16alFk6yFRqoOxtpvxxIqbQz38164uBxGokzojZGxU9NzjKrAvYBTiI18yB7Q/p4fuJ8j8oepPJyi+xlUu8VdaZGM8F0Ml4mnWGnLPk0VsapQI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=YOfw-lN2nxCZsWbOGX4A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeDLN45 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 09:56:57 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:64353 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752571AbeDLNzw (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 12 Apr 2018 09:55:52 -0400
X-Google-Smtp-Source: AIpwx4/dlAtYg51RGn03Bmuzbazqy7BzJQoRes2syNovFDUPjtg/MZueikr3p9heXIU9anlO4mrI3w==
From: Phil Elwell <phil@raspberrypi.org>
To: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH 2/4] lan78xx: Read initial EEE setting from Device Tree
Date: Thu, 12 Apr 2018 14:55:34 +0100
Message-Id: <1523541336-145953-3-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_07:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add two new Device Tree properties:
* microchip,eee-enabled  - a boolean to enable EEE
* microchip,tx-lpi-timer - time in microseconds to wait after TX goes
                           idle before entering the low power state
                           (default 600)

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/net/usb/lan78xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d2727b5..d98397b 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2080,6 +2080,23 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	mii_adv = (u32)mii_advertise_flowctrl(dev->fc_request_control);
 	phydev->advertising |= mii_adv_to_ethtool_adv_t(mii_adv);
 
+	if (of_property_read_bool(dev->udev->dev.of_node,
+				  "microchip,eee-enabled")) {
+		struct ethtool_eee edata;
+
+		memset(&edata, 0, sizeof(edata));
+		edata.cmd = ETHTOOL_SEEE;
+		edata.advertised = ADVERTISED_1000baseT_Full |
+				   ADVERTISED_100baseT_Full;
+		edata.eee_enabled = true;
+		edata.tx_lpi_enabled = true;
+		if (of_property_read_u32(dev->udev->dev.of_node,
+					 "microchip,tx-lpi-timer",
+					 &edata.tx_lpi_timer))
+			edata.tx_lpi_timer = 600; /* non-aggressive */
+		(void)lan78xx_set_eee(dev->net, &edata);
+	}
+
 	genphy_config_aneg(phydev);
 
 	dev->fc_autoneg = phydev->autoneg;
-- 
2.7.4

