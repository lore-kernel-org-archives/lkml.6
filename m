Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119727-2-4487464147979352775
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
    t=1520119726; b=M7h+PG8k1a8gO/iuVA8+REIVmuaCjHZDQCbs9Acy7I09yju
    kgkZd/YhkmMffQf4vI3rBe/YDakb5COt1mv1iYU0/x9noPy3pdGT7x+N3vqMIGeA
    FRhURMmBLAqT8bnUD1khmcfjorXKRG0tBbekeNP+4e0UZNDIwUharfCDuEQpCdA0
    yzS+gvN7GBCg4FdjOM6vDAgfWgud28pWqH7fp85lkh0QLWc7sOnaRJgL036RYBfr
    ReoGQkObsghP9obfQNuZVOn4p/dUKUbP/UsvpjzxbwuQ1IXreoj+mSZynu1YJTH9
    fF/VS6bzY9wxYcleuaZfDcyJzBn7dO1yaU3/8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119726; bh=jgeyfj
    pIQMEG/1dDOjRCt0qfzVVELtioAMwszS7IAJc=; b=XvLVliRmDXEdrrRwb9eWmD
    jYx967mKdnizAn7aw32sBNH+3wnbFjulEb87l8YR+GyPx16S8X0IEWfESPGyze3+
    vE2D3CQ5BQIrVTq6QRM0qBnlaXmi0TXtZjNN7PN/rB4FK147dBHYFFycaOPixzk6
    ie6MI89xckXsm3JeTin038VsiNF1lzWWBu+TCPGGozzDfNqthCnac47CXZ+/S8dR
    bF+ed3R3dbQgHJptBP4lS39yjv4+FUbWb2tHh2zgmSBSRBAziSEPI6IztXRxqUI9
    PJ9MpbXfHWYFEYCT0rqL11wmh6Cb15lYgU76AYwdxWqRGddjj3Pq9BOZo/P6BMPw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fi2n1NZQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fi2n1NZQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeCCX2b (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:28:31 -0500
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:41088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934588AbeCCWgu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 189/219] leds: pm8058: Silence pointer to
 integer size warning
Thread-Topic: [PATCH AUTOSEL for 4.9 189/219] leds: pm8058: Silence pointer to
 integer size warning
Thread-Index: AQHTsz8ibBjx64s+M0y4fsjTewTM5w==
Date: Sat, 3 Mar 2018 22:29:46 +0000
Message-ID: <20180303222716.26640-189-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:1X1hUEPBSV8sG88v/Ka9p1u53dU7XciD1XU7C/gNx08NLtfN9McL/rNwLPTd1CHzBEfdMM3VEjsu3BCbS7wI1kurcPDmWmRlGW+xcHUZjgLAT1Jh1SFLv9aAZ2kurkmeqr0oOLaT4VTNsZ3QwvdyZR7khn3W8c5pikRpTTYjWICMcV0V2Ko59xPmVCFCtH8EdotQWsNP0dbdAJtqDqBNErnQ28yG6+aQ1CJIJiyoEgTY2+L7SIJUogaDbZ0Mh6Yp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a079ce0f-d8b0-4f42-8626-08d581573dad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1020E62559C9597AB4055F7FFBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(59450400001)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: bcBUYE3QJgy+noeBa+/WlwPe9T1+hTcyERJi1bODt7PMDO0vahEslvuz9Oi2V1wg+fQrXdijFrHSnn+V9smhesyl8qe3aAtLOLrKbrzXHtPSqh3v0lu+eHP6SgrDsirhBr8LGwDdFB+5PTwRYloBsamb5wHKvIBuHp3BK2MCc8I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a079ce0f-d8b0-4f42-8626-08d581573dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:46.9789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 8f52df50d9366f770a894d14ef724e5e04574e98 ]

The pointer returned by of_device_get_match_data() doesn't have the same
size as u32 on 64-bit architectures, causing a compile warning when
compile-testing the driver on such platform.

Cast the return value of of_device_get_match_data() to unsigned long and
then to u32 to silence this warning.

Fixes: 7f866986e705 ("leds: add PM8058 LEDs driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/leds/leds-pm8058.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pm8058.c b/drivers/leds/leds-pm8058.c
index a52674327857..8988ba3b2d65 100644
--- a/drivers/leds/leds-pm8058.c
+++ b/drivers/leds/leds-pm8058.c
@@ -106,7 +106,7 @@ static int pm8058_led_probe(struct platform_device *pde=
v)
 	if (!led)
 		return -ENOMEM;
=20
-	led->ledtype =3D (u32)of_device_get_match_data(&pdev->dev);
+	led->ledtype =3D (u32)(unsigned long)of_device_get_match_data(&pdev->dev)=
;
=20
 	map =3D dev_get_regmap(pdev->dev.parent, NULL);
 	if (!map) {
--=20
2.14.1
