Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121589-2-1849044319709205607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121589; b=wQI1iN3s21MNRfvN90SoES0bDbGFIzd8B43wuBJnMajlyHZ
    FiDiuk8CQQHffSx5/qJr4tnecszHKjDUQK7qzeuD6JZ/vwkAjdWbx6HeFvRlurUi
    xG4iGUeM4tI1oPkUgPFdgGNbgFKHgCfbsmbkem4AQEn0BGsR3KBj5ZhNnCGNc5eZ
    DpVwzjXGv2kVPxpkfcfxY8QOxMq0Meor9w1CuBudAR3bJ/Us9/ZMcE2Qu6Y6gKRB
    n4rgiY0HY30FlxS/vSJ2u3x+wV9b/zvZq3+z8PN6v5L1PdyIFD3oDjmBnfHnfTnC
    mVrQrBAMY+1oYIuqJIAqq+3LixoybDw7wknNPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121589; bh=40RStW
    IE4sR3lWtybcx1izvIPtRftbpA308caXeku50=; b=MFeHX8iuVtbFGLXpuwInn8
    RyjHDFI3hTVgrItnX4xQXo9XCB8lYotHCsqOXEZ1+1s+R9zop802bWSl35qNF6Cf
    YJwW92dQ8BhmxV2Tb5za8TLiDVwmsJjABIDprtKOZR7l9uUeiMu4cw+tPVCY3WMH
    N7HHWzS5M5JLOS5eMyVK7VyaVKDHExpahbCTRY4f141l2KRr2U+7SJ8ZXBTJnV0p
    ljakv9OqYDS0z3c+j1Ah32Ore6IeYuSDON8spxsJushcBDOHfqwumIM4hATrfNnb
    7ZEyT8Na7p/Fs6Qnww0lAF4UktC+oml+Qk2sS09wH4aC/gxMgtdNp1WDmclUmpKQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wpzpb/r8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wpzpb/r8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeCCX7F (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:59:05 -0500
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:54496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933465AbeCCWcQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johan Hovold <johan@kernel.org>, Daniel Drake <dsd@gentoo.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 050/219] zd1211rw: fix NULL-deref at probe
Thread-Topic: [PATCH AUTOSEL for 4.9 050/219] zd1211rw: fix NULL-deref at
 probe
Thread-Index: AQHTsz7xUpsvD/qn3kKhTNGMXldAhg==
Date: Sat, 3 Mar 2018 22:28:24 +0000
Message-ID: <20180303222716.26640-50-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:61Bh2X2Bs0Qr129K5frKlCANclTnt4Lsm3h4/cmwoC4AR+GiH+Sb44U2NhkO38tD/R5CvhTzmbpJXVyYNN6kd13fnvYxNUz6rKqKDwFJddqS2RD7X9a6WHhDzxvPGcbbikvNZAiDZ5J2rMudB09ZNtFOaRNo8+VRiCoppO2b5BMTl83sIwtLNkjHjP7FnOAY5vuv9xPKJg84q9T3GqAiPpQy5JJtEMOJ4ErrFgvwEFPdXRsoLyAoPOg6Pr3oKFJO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 579066c7-a2bf-468a-9002-08d581569c27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1036BE48C81447B7B521FE9EFBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: C7JiQF/lw4Q1uw4PDGoqyKA4d9b3OHoOrCthkHyt+f0VL4w3RlX1/czf85YpDw4M3tY3TEeYtd0S/eOCLQloB/gFTiWs6r/me8U7K14tu0BavXK2S4z9Ab+zrqlmZ9cBg4U7B18nXslVq/0XKq6TlFyLMVlCez2k7ZPSKszkyeU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579066c7-a2bf-468a-9002-08d581569c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:24.9319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ca260ece6a57dc7d751e0685f51fa2c55d851873 ]

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer or accessing memory beyond the endpoint array should a
malicious device lack the expected endpoints.

Fixes: a1030e92c150 ("[PATCH] zd1211rw: Convert installer CDROM device into=
 WLAN device")
Cc: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wir=
eless/zydas/zd1211rw/zd_usb.c
index c5effd6c6be9..01ca1d57b3d9 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -1278,6 +1278,9 @@ static int eject_installer(struct usb_interface *intf=
)
 	u8 bulk_out_ep;
 	int r;
=20
+	if (iface_desc->desc.bNumEndpoints < 2)
+		return -ENODEV;
+
 	/* Find bulk out endpoint */
 	for (r =3D 1; r >=3D 0; r--) {
 		endpoint =3D &iface_desc->endpoint[r].desc;
--=20
2.14.1
