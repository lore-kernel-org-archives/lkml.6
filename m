Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116147-5-4560602927710503694
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
    t=1520116147; b=U4SZHQ3Eo1AQPGs4gdlJG6DChDrZaNxirdPnkasGucu/TxY
    j0qbkEQobGYai156Q/xeZbSgiwmw1TfWpBhtkk+tCxXTSDBE6wKKuunZl5EABkIm
    Dqn/imK1si9meZYEQ44NlSLwBxluA4p6p+qAaBNv1TSi6Cx89YA4usYiVbzwQhQm
    WTOrmV9yOiNC/ZtVO4mugL0yxJZhJZB4nFpBCDhis20FS2WdCqqFzFMLvOr6zDTo
    BlYWJ0D1pDMjtQeTqseoFWLtvMvLei+KIZX0zGZZGBe+keTiXMZE1P52oclPbhSc
    G0440M6vj86GOU3VsWNhS5hN4JRNgaIziQTNYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116147; bh=jgeyfj
    pIQMEG/1dDOjRCt0qfzVVELtioAMwszS7IAJc=; b=mof8FkdTb8D6FzzmCHD8IJ
    Gz+Jv0TDMUZi8a5NjErF2foPGUr+zVhbTMyqKiSlXvAvg1N0kYHJmM4lqabiV4U6
    Ksktd9+3XQKcwJJCkXKAOwicC8r7zy/qx5CT2Rg4fiww6S1z0YXeBAzzImvK5SCS
    6Vr2irykNQcKexOXlD9XsqL0vMDkSV8KxLQZ2FOXdduqyrdvDJmtCM4GHYdW6yns
    GA3XIWAi8H4k2sUECVRR+vnmf6Ale2eoQXA/qMoYWD8YaEJsE3IAgU2oUtrwBHTB
    ccpZTvM9RUuHcO4Zy1/DB4eNIo3/71kxHT1RgJk2GycsZ62otRhYo87H3Jw5iOZA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VtvCLZf4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VtvCLZf4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbeCCW2e (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:28:34 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933244AbeCCW21 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:27 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 30/84] leds: pm8058: Silence pointer to
 integer size warning
Thread-Topic: [PATCH AUTOSEL for 4.14 30/84] leds: pm8058: Silence pointer to
 integer size warning
Thread-Index: AQHTsz6l5mf+pvCwpEa+frvwU36IEA==
Date: Sat, 3 Mar 2018 22:26:17 +0000
Message-ID: <20180303222518.26271-30-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:yEJiDnLCeKQqjTv7oCZ05qmDVo+3K8CVFj8LXNq2skfqyUI/tl4TDVF3GaMV5Or7oR28Euy2LX1ce2GW2VmTOGrbFh2M7C2cLo6w7KPLrepzhU2ccKI7R4Fpng9WFbeFYLdcCLrk5LoU3c0QtjPxrObuIX2TxtHzdaWziUoVPtu0qZVgg3cX0VPomV1CkIBloiF9QgNzvFXW2N9ZaWN/Gcj2znXSc45WLT9EWrbmF54/F7AUjERLSZt3kZva07M1
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ac7751a-f5fd-41bc-5f4f-08d5815612cd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115EC0E1B72E61B2CB735E9FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: e6Y4/DuRVtP7wmiRSezqtqEJwZ3WJUZiyq4WwjqWhvuyhlHFj0eUar83zk1RFeH9gfipUZVwSJBfGWxFPeHhVm9JmADJaux2b6QOy78PI3MvXHm/Y2FcQV4d6k3Z/fjpiqH8lLOH0tbnIfxVierg4AsZ2Jn9LOkRFgxxvvXM77A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac7751a-f5fd-41bc-5f4f-08d5815612cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:17.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
