Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491414-2-2199341798360577929
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491413; b=cJ7QQOF4YWA/Hnn5IYa7u89q1XUFAkWt/6Gku08cKa43p2x
    K5HhO3WQDyf9qEvRW3bSQnbW9vhyThCfYiSSNCwMY6zTEvx91Yghtyp0U4Cxncon
    uNE9y6msopd/HM5QAIRZB91xH9bbTBThUbBmSPvQ5yxtkqPcrvb1vrtmwvw1SrQ3
    499GAFPh54NsZ5x+9qCsULqujPfHh6JwbGTA0XRRdEGSjI0yBFxRDWiUEffffl40
    Lg8x7ZxyQv+VZv0EB1LkopdWjXVheI67kewCDozUgzquYdSm0twvM1b6WtQMtFCf
    DQHF7uIKaH3uAiQLbHnykDBrFT6/rmQnpi4Uw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491413; bh=HaW1yu
    Nm2uewrXWELsTVgL7lJL8CaBauDC8hIMCK9lI=; b=O+YJ9fxOYyL8ZPCWhdU+ij
    pLRyRcHZk27rhE8A99DsNzSk2DWw+BsER1drqzOywyczHMUotVfmcFcK7AKymKmA
    zRxhaCpvdChlQBuaXIw66ynpPRy402mfSXuXajwaIoPQ2rkY/GV+NpQzNpN0t2R4
    x0st+ReE+gaXZzaR7d84t21aOIO2tUcwzx6b8laIW8e/XwC/+1ViAWwBtKnvwEUV
    keExJ33lB4lm7D3HiTRQSfIiu25/0JMW54QagCl7AUYcCadCFTSt6mk1QM1Y+ix2
    +ASZuuKUBDCUVitcCcW98Zjazi+rDCJeCgDCqN8hN8MzMF+p+YhugTTBQL2AWOVg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=egF9rD7O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=egF9rD7O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965234AbeCHE67 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:59 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:6433
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935243AbeCHE6z (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 32/67] sfp: fix EEPROM reading in the case of
 non-SFF8472 SFPs
Thread-Topic: [PATCH AUTOSEL for 4.14 32/67] sfp: fix EEPROM reading in the
 case of non-SFF8472 SFPs
Thread-Index: AQHTtpn/Fia+7N/+V0ShiJmc+w6Yrg==
Date: Thu, 8 Mar 2018 04:57:45 +0000
Message-ID: <20180308045641.7814-32-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;20:jJsGK2447jSM1ZyeuuNJvUsZg5tjVn0QwNt4afovuBXzyILr/r70aXUCJIaXf8Ds3R4mRTBI7U85NLumciYN5HFb1bwAVkEe3zXk4l7eTv9Crq1DplSQWe/1e1h/JF4iQePHfJ63ynIALR6UbZt7OUQsslIo4MP/HEM5dgyNXUM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8dd61e6-aa91-4ce1-f382-08d584b14a5f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080FE182628B5836412B14EFBDF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(6116002)(1076002)(5250100002)(26005)(102836004)(2501003)(3846002)(59450400001)(186003)(6506007)(25786009)(3280700002)(4326008)(2906002)(68736007)(66066001)(86612001)(3660700001)(22452003)(6486002)(6436002)(14454004)(8676002)(81166006)(2900100001)(72206003)(81156014)(8936002)(478600001)(10090500001)(105586002)(10290500003)(53936002)(6512007)(6666003)(107886003)(2950100002)(106356001)(76176011)(316002)(7736002)(86362001)(36756003)(97736004)(54906003)(110136005)(5660300001)(99286004)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Deck4y4Pp1rLFQDfUFVf4xBmQNSKdti9ea8huxar3F8e4/tf8oVAcN7sPfcnkRHY8oU8x05fOjqDNRusLAqX4te7USaVHZgDtHHn2BhbVgK9h+htOzljuIVGto1FWU5bVnhdXRpAYg04043KZ0lgZJjL2CjghjNGiHLka8H2Auv+QwuqpaoI1Th9MHoAh3oP8BaE5xdY8jOkQWuuKgzMpFxd6A/jiAsduli9caHBEp2W6dJKKnRTd7nksc45pYTjK1XtfRnSWE0lKzgB0sfpkmhpRNW3x6EsWakSGmESj1Tk7YVdt5Sci7SXg5Geq3FVEi99zUVePedno6xO3oP91Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dd61e6-aa91-4ce1-f382-08d584b14a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:45.5706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 2794ffc441dde3109804085dc745e8014a4de224 ]

The EEPROM reading was trying to read from the second EEPROM address
if we requested the last byte from the SFF8079 EEPROM, which caused a
failure when the second EEPROM is not present.  Discovered with a
S-RJ01 SFP module.  Fix this.

Fixes: 73970055450e ("sfp: add SFP module support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/sfp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 8bf10aba7452..ddf184db9c45 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -667,20 +667,19 @@ static int sfp_module_eeprom(struct sfp *sfp, struct =
ethtool_eeprom *ee,
 		len =3D min_t(unsigned int, last, ETH_MODULE_SFF_8079_LEN);
 		len -=3D first;
=20
-		ret =3D sfp->read(sfp, false, first, data, len);
+		ret =3D sfp_read(sfp, false, first, data, len);
 		if (ret < 0)
 			return ret;
=20
 		first +=3D len;
 		data +=3D len;
 	}
-	if (first >=3D ETH_MODULE_SFF_8079_LEN &&
-	    first < ETH_MODULE_SFF_8472_LEN) {
+	if (first < ETH_MODULE_SFF_8472_LEN && last > ETH_MODULE_SFF_8079_LEN) {
 		len =3D min_t(unsigned int, last, ETH_MODULE_SFF_8472_LEN);
 		len -=3D first;
 		first -=3D ETH_MODULE_SFF_8079_LEN;
=20
-		ret =3D sfp->read(sfp, true, first, data, len);
+		ret =3D sfp_read(sfp, true, first, data, len);
 		if (ret < 0)
 			return ret;
 	}
--=20
2.14.1
