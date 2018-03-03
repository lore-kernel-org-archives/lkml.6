Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124149-2-12821952510582629368
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
    t=1520124148; b=OKg+jsIW1o9D8810sP8nT+WeBWi0AwyFesIVb3S/ZoMGLWA
    MsF+TIAZ0YSxi/JSh7uzdhxwzqWHK1aToT7fOa0GRxv2IazzbRMsQaZ/gqY1Q5lr
    fXMGQafwaCZb4s1tHqEhsRfCHfyiFJcyw7A2siTefqqTn9bMt8ARXrl/PcEcNrMO
    ZHgWKdBOt251GFy50704SL9BS2jU9Kn3lpMA8OBkXNJRcXCwDP5cns5hRNIvg0lg
    50Cd/0OMzMx3/E+KzkdjYuyANcmvd8TLs9gln+ppf3DnhQJzAQBw9n0vkzX6FZ5Z
    PbJDnvtvwti4epzyfoxzi/+UwVgHOb+MuVvGUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124148; bh=jgeyfj
    pIQMEG/1dDOjRCt0qfzVVELtioAMwszS7IAJc=; b=monhbSpNeVHoDnelBBWa/B
    QXHMugw29kv0O5M9w3JP1Ik2J9QICLzOuB1Q4QJGYLjsM1wnOCtt7uKKEZfD53Nv
    n+nAwq03gB3tZwwYpMAfHukMWbyAFykfq+8RzoADrBFptavVRaTm6BwUIVtRLq7P
    1O0d54j7ZmGfG3AgP1ynaBfbLGDdQTzqtUIiK67aMg+arZrwGLefW6S4vnxZfmoI
    Ktwabb8V/5P1wjVyE7Fj2ObGhe29wQswxokDLi/5h8SQ/BUCSEubBWrhuF/8SuiJ
    1p9c52NskpzIubJRv5jwp0gOlj1poO7TtFSXxy0sx3dOJzNMr/gZhu1pOYcwgVmw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gZ07m+6l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gZ07m+6l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932576AbeCCW0O (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:14 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932455AbeCCW0J (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 040/102] leds: pm8058: Silence pointer to
 integer size warning
Thread-Topic: [PATCH AUTOSEL for 4.15 040/102] leds: pm8058: Silence pointer
 to integer size warning
Thread-Index: AQHTsz5nthA863iYvkuSVLuM9YlwgQ==
Date: Sat, 3 Mar 2018 22:24:32 +0000
Message-ID: <20180303222318.26006-40-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:PH2gqPdtsUP9Orb6H6zGtDGc5+zFBxekZWoLOgvusjcGPM2136+C1xhL3y09C4KQb54B2f/ZFeLM5W7gvMcbjXX5iRZV0cbbv54Ur01GMczp8Oce8ERbyVWRYnUWvrOtUoYvDORxICz/r9pVAABhRcrMe9ax30yMq43A3CHJ9BcTkqkZ2bJQuZ7SM0bATkoCapZPkrcY5lwtLWZjjrL2vDGBrWfu2GmA9O7h1t1dey4eztsaGUUwcpEucHZTtzh3
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04c3b1c8-de59-4d66-b803-08d58155bf8a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3532B4F1F396116648C50FDFBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: TrGKCquR5u3vtA072WfR//ba4181SMG6xb07pMGL9YPTTWZBQXpcQtagjFZ886U2cRmhP8EMdIFB9ST6bTh07ESkdbbWH77vWCJETMI3GVkrW3wbRo2lk3uJDyOvd1B9osbPmOEaJ4C6MWjQC7COnuQHKxjSvJ3vBU4gC1ktkl4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c3b1c8-de59-4d66-b803-08d58155bf8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:32.6971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
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
