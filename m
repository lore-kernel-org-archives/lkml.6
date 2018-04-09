Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241914-2-12673515351861610151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241914; b=VFi2NN5qNhToDqDxByFHPr8yXiCGgXWN5g09/lfTslFPh4RWOx
    BbOlk1snenRx9/+4QRHkVvn8/8s6RVterHiK6dR2hdczfXE+T0cBEnf5NYZDVKRH
    NLOE+TWOs/W8+Mn63m+HE/3321hwLHgkREdTLd5wAQzF4D8y4FDEpIT4BQ4f8Cb6
    4p0659DLQEWAXEGe53x/W/7GBipJAFuqO9VTfh414vhezKhpmlJg5TAGlHHle9J1
    Xkr8hO89+SJf1aRwXiilF+v9s8sSz8oBVtCqYlQVjVkgl46l356mVbh9GX1A5VB5
    5M8m/RmTEF/3FW9moAmeP93G5k3KEHHwT+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241914; bh=xUqF4XbJcD
    XU3db8WX4+bvFS/k3vd+DELCrESx8LU5A=; b=VxdebRUvGi6TGia8OGX+3MkDd3
    1mB+J53tVSTqblFEG9D6Yx8hHTEz1jsExhL/S8pi47qyRvNJNmh296J3SOdBGAPK
    GQfAooK2wW5tCSdXOhnaRENtpx34jGeOGvpc4L5HECfL+jMg7/2PB3J6oK/wNuoC
    D8kQr7ZdTlr+S4cXkUAEbEzRygu+EuM3QxvGFaqEDmP8qgpfFvfqTN55MJVS2OIu
    +ZWURIsGvb3AoFr8sd3keeEq69XeLSGUicSjpJQkayj9mTtL4RfpJiLua6LXN1Un
    Z230e9g3fr0JLutPlhU6pf1UphY3xkDGnp+VLojz0S3JvCGidFvy9swqJbTw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z/gbCr0w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z/gbCr0w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLBvFKVfIFXYocHIDSCStY4d3HSldS+ghsFmm5GNPhFxPAUpc5D53CigxpHxZR+DqP4pU5m3DFATCoxfRir5K99vc9f2fVf1PJv8ky+YQWY03xJ0hSoE
    9oK1MA225Thsvqn/EizgJ7+nUpdBov19WlXEx43LAG4rVc9qPTe0Fgd+jI8qj85ggGUc71AK6zRsrr0F6E5b0/V5kHwtY0AYyddd5KZeXZlc1pyyBSNYc+JE
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=IpJZQVW2AAAA:8 a=KKAkSRfTAAAA:8
    a=yMhMjlubAAAA:8 a=O8jRWyagVWjPOzXYQoIA:9 a=wPNLvfGTeEIA:10
    a=IawgGOuG5U0WyFbmm1f5:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbeDICpK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:45:10 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:2432
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755432AbeDIA0r (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Heiner Kallweit <hkallweit1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 020/293] pinctrl: meson-gxbb: remove
 non-existing pin GPIOX_22
Thread-Topic: [PATCH AUTOSEL for 4.9 020/293] pinctrl: meson-gxbb: remove
 non-existing pin GPIOX_22
Thread-Index: AQHTz5jthNqHDzHGikCEXMUBt0nHaw==
Date: Mon, 9 Apr 2018 00:23:05 +0000
Message-ID: <20180409002239.163177-20-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:TcqBtOrgE5AlL4Kg3ezTVycfT8UZQ7XET2KNQNdi+BMKG1qeujp9CgCPkIi/vQDBy0ewC+dsiHHCx9Eyfrfmy+H3PVwvtIWkfdyEn/bo5T9xut7MwisBx2LUeinIWYLEH/3nF38TNfL5tPkDf+Wh2dmJLZqaYcgbssg6N3EW3UXRKFKVviVutAkOXAVpR+9Qzfzk714h8d/SFm9/RRAeIXyDkftJ6CCBnuxiWrSgKoS/IdL1bUfKC+GTNC0yxwPb;20:zdPcg7xKEGlIKUt+nVcHJDAUoIOrdMiVeVHKP4llS84cyGd/TNvtEoMfeK/RE/3cTsel+Xzc7qtLrlD87/DWUOiV98tuUWXOGPIWRlntUJmNlMnDuOq1dyopZu+bxirOUnfA+uBbLAbKr7BG9jLqAQNYIwp0QUWk5R+DUpdtezg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7412b1e6-29e4-4e77-0b7a-08d59db09127
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB088582A8CF1BF9CAF71672B0FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(86362001)(59450400001)(66066001)(39060400002)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: u8PEBzg8rIa2V8Qpwq5kQdcqX4iJAI55ssmdBX9lrP9Is7U+0Cd6BJrekZhpi7E7SqOM2ntQbrcSrhxM9emCKQ++Yt+aFVJQko3MyAJOF9Azt/ebn8n6vN9LuRfuXmaoDlDHpIqjvVXHmsULxXQdBAPVAFCQLV6P48GMvACXw6SMzRHuyKOpZDanWrE8s5lJx65OkUN0op09V3g5SE4P/z+fUGeb7gulE6wiiIJkRDGS/HpxIe+Bsk71xO9UMIh9Bhl0UqWI2VxqGh+cKWQEI230YF00fN/ZXWqZYkFkHLg9gWELS0Mz+RjIacvotYY3LSKsSle/MEKwUUsZdpW1dc2FSZ2HdxJ+cPRKGQVtPM1H2d8C+fX4VSgj0SU6qsGqFAXHCFcBsbeb1KcODSWQuPz4KSm4wpfLfNO+3A8hwf8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7412b1e6-29e4-4e77-0b7a-08d59db09127
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:05.4092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 4c8127cb523982e0a474ad80b14b665dc2f37b3b ]

After commit 34e61801a3b9 "pinctrl: meson-gxbb: Add missing GPIODV_18
pin entry" I started to get the following warning:

"meson-pinctrl c8834000.periphs:pinctrl@4b0: names 119 do not match
number of GPIOs 120"

It turned out that not the mentioned commit has a problem, it just
revealed another problem which had existed before.

There is no PIN GPIOX_22 on Meson GXBB.

Fixes: 468c234f9ed7 ("pinctrl: amlogic: Add support for Amlogic Meson GXBB =
SoC")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/m=
eson/pinctrl-meson-gxbb.c
index 7511723c6b05..257c1c2e5888 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -138,7 +138,6 @@ static const struct pinctrl_pin_desc meson_gxbb_periphs=
_pins[] =3D {
 	MESON_PIN(GPIOX_19, EE_OFF),
 	MESON_PIN(GPIOX_20, EE_OFF),
 	MESON_PIN(GPIOX_21, EE_OFF),
-	MESON_PIN(GPIOX_22, EE_OFF),
=20
 	MESON_PIN(GPIOCLK_0, EE_OFF),
 	MESON_PIN(GPIOCLK_1, EE_OFF),
--=20
2.15.1
