Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492277-2-7255309310700888081
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
    t=1520492276; b=ZddhXLheH+5gt7Hg23HryWnGGuHtsYwAbNybkPRDMQ3pnoY
    W3mGZGpqgz5GZasCmGCVgoVGcpr3qvg6aukBS/aRUiM4O15x8aWKb3vPhlnNiOoH
    dis9z7DH1LVxJMPDuTqxfQ4Jo8kVENgravYJhTL5QMOcam4+jZtcPfmgQYy7AEY1
    pAgOn0sL9wXj6VKE16BhjAOQGFUntZG2RiepRAk/PS1l0j1+sIK3ZMnI09AAUzdd
    sw1kh2cb2T+6TwFiTTtwwvUkxoPSchEufuffKLPPpeRHHswAF3XdPnyy++HbiJJO
    wFONIEyQ0rYd7rmRJ7toscUu7oKFDjdCYTD9y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492276; bh=RhhFHR
    wjhWzvVmEWxamzhkuBzydr+rI+wxJcUvfo4mM=; b=RY4+63HYIfNBLye+6xhgJ7
    uPCjqNay+sQCutgGGuyFyZViO1XkHg+kaOzF0yXYk1yC7zsQVVzGFGb11ufdTH1c
    jKWxHe/3uwf3Xew17OJ7WdQ6bye4v40SpeFHFgpKTFxi8xJut2iGgMXlzelFfK7j
    MScGLhRM888q20GmSrUzHN9QdwGQJ1d7wHNdoUMt50ZmRm1sb+3E8l/Uyiz3xEGd
    CQWzy4A8pfcXNEisO2vL9m+eRaLBYvECfRMJwssJgmqu2hzjx39jcAC3E6aDMj/V
    SccQmnYlii35CKY7EC28UsRfB6Ag3QLtA2xjLw0L4Fr0iIIrAMh3FK/fl4ROeK4w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V4m9UWMI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V4m9UWMI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934985AbeCHE5m (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:57:42 -0500
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:4352
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935101AbeCHE51 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:27 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 60/78] pinctrl: Really force states during
 suspend/resume
Thread-Topic: [PATCH AUTOSEL for 4.15 60/78] pinctrl: Really force states
 during suspend/resume
Thread-Index: AQHTtpnQD92iXi/daUa/bqKMi9jXKg==
Date: Thu, 8 Mar 2018 04:56:27 +0000
Message-ID: <20180308045525.7662-60-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:lr1oQrtUnS7EZ3zp3vZSm1WMcWFYxzRr5TmdEl5GIPOFpJJN8xBpZLpr6ZkJvoMWtUToNv/xGUrJBvVAAPAypYScQKVpPYLp257mzvC02AWycZhWPNhZ+RHw5cE7kAhwqP1XP+602jamoNIE73419Au+dQxql3aypLf1+7BPCKuxmuW3pJ4V4NnowKZ8an/RC80gs8p7lGqM6Vz8KIZucsLASYTWlhu15zE/Jhw+E+WHrH2024Uo696x9DOy5Fye;20:/Bn2FxmEdGHc4LV0n11N9rzlauVWXjXvbmKST7w7HZSREdutfvjI5/2X6wL4Dc9p4PkXG9PuwbWT+x/+dNi+EohoXJrwGrsQjlJ8PrOQbcgNBTCmsFNOoQNzzz4uj6rzpE1TkXSU5H10POgiHnT4GgONLxY7THf/85O+1OK+J2Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e392f50e-bdea-40bb-4cd2-08d584b110f6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032578AC3A879AC18709A30FBDF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(97736004)(36756003)(8936002)(105586002)(2950100002)(2501003)(6666003)(186003)(8676002)(5250100002)(86362001)(2900100001)(3846002)(5660300001)(6116002)(10090500001)(2906002)(7736002)(22452003)(81156014)(26005)(6506007)(1076002)(102836004)(575784001)(59450400001)(81166006)(305945005)(3280700002)(72206003)(110136005)(86612001)(54906003)(99286004)(10290500003)(15650500001)(316002)(107886003)(39060400002)(4326008)(25786009)(68736007)(6486002)(6436002)(6512007)(53936002)(76176011)(66066001)(3660700001)(478600001)(14454004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: hq1d83KrG6U5uaqpnqU7JRRz0t9w2dOgIbwX99TZM+JcfN+FH6nWzOssld1Cf49vzvg0BXmsP3rLxrBzaEalQOuqvYiHPWN0BVIeMAZxk7r/zjwInxPNJ0DHGvg4RCot5MJUMoh0SLoBlUY4+hZcckbTsFkhS2d/LqOLf56yYz1kLlDydW1mpJSTdNcQsIaBRNG+3CkEI7Mxe26PwHrVg7MeAbX50GmEXMSLSfzdihKI+WtCAq267VEeTfBiekrBtSn/+38qjuJbXclHIHYSYQ8snmBhH82amQtEiJUAqNkLkY6a/XN2SvZbONa3gaS1e5WK21Eo1f3+PP2oMqHg+g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e392f50e-bdea-40bb-4cd2-08d584b110f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:27.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 981ed1bfbc6c4660b2ddaa8392893e20a6255048 ]

In case a platform only defaults a "default" set of pins, but not a
"sleep" set of pins, and this particular platform suspends and resumes
in a way that the pin states are not preserved by the hardware, when we
resume, we would call pinctrl_single_resume() -> pinctrl_force_default()
-> pinctrl_select_state() and the first thing we do is check that the
pins state is the same as before, and do nothing.

In order to fix this, decouple the actual state change from
pinctrl_select_state() and move it pinctrl_commit_state(), while keeping
the p->state =3D=3D state check in pinctrl_select_state() not to change the
caller assumptions. pinctrl_force_sleep() and pinctrl_force_default()
are updated to bypass the state check by calling pinctrl_commit_state().

[Linus Walleij]
The forced pin control states are currently only used in some pin
controller drivers that grab their own reference to their own pins.
This is equal to the pin control hogs: pins taken by pin control
devices since there are no corresponding device in the Linux device
hierarchy, such as memory controller lines or unused GPIO lines,
or GPIO lines that are used orthogonally from the GPIO subsystem
but pincontrol-wise managed as hogs (non-strict mode, allowing
simultaneous use by GPIO and pin control). For this case forcing
the state from the drivers' suspend()/resume() callbacks makes
sense and should semantically match the name of the function.

Fixes: 6e5e959dde0d ("pinctrl: API changes to support multiple states per d=
evice")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/core.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 4c8d5b23e4d0..2c0dbfcff3e6 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1189,19 +1189,16 @@ struct pinctrl_state *pinctrl_lookup_state(struct p=
inctrl *p,
 EXPORT_SYMBOL_GPL(pinctrl_lookup_state);
=20
 /**
- * pinctrl_select_state() - select/activate/program a pinctrl state to HW
+ * pinctrl_commit_state() - select/activate/program a pinctrl state to HW
  * @p: the pinctrl handle for the device that requests configuration
  * @state: the state handle to select/activate/program
  */
-int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
+static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *s=
tate)
 {
 	struct pinctrl_setting *setting, *setting2;
 	struct pinctrl_state *old_state =3D p->state;
 	int ret;
=20
-	if (p->state =3D=3D state)
-		return 0;
-
 	if (p->state) {
 		/*
 		 * For each pinmux setting in the old state, forget SW's record
@@ -1265,6 +1262,19 @@ int pinctrl_select_state(struct pinctrl *p, struct p=
inctrl_state *state)
=20
 	return ret;
 }
+
+/**
+ * pinctrl_select_state() - select/activate/program a pinctrl state to HW
+ * @p: the pinctrl handle for the device that requests configuration
+ * @state: the state handle to select/activate/program
+ */
+int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
+{
+	if (p->state =3D=3D state)
+		return 0;
+
+	return pinctrl_commit_state(p, state);
+}
 EXPORT_SYMBOL_GPL(pinctrl_select_state);
=20
 static void devm_pinctrl_release(struct device *dev, void *res)
@@ -1430,7 +1440,7 @@ void pinctrl_unregister_map(const struct pinctrl_map =
*map)
 int pinctrl_force_sleep(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_sleep))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_sleep);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_sleep);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
@@ -1442,7 +1452,7 @@ EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
 int pinctrl_force_default(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_default))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_default);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_default);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_default);
--=20
2.14.1
