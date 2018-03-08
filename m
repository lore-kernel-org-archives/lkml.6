Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491190-2-17851652749876627316
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
    t=1520491190; b=v1vbSF3dvz7P3jIpgGZ6lrYpkA54mpdHGWPFIayg8LzzuE6
    Ut05lAW6J0546YHz6qqcz2F87tCqCtNXs0TMVJBOlI4dMryYKv3AwNj7LWkBtDRi
    UQcOsMGYJzLdCJDGOjszHQ/PAAVhfNth0C07LWrINv5qvI33AbORJmAcsakjpZIQ
    Y4/IKHctySsCQSrg0F7KCzA5k8FQQ8zfpM8YgKy0rE2o8NAcPguCWNNsmmjIEDwK
    OlAvpXAeoxAzEKBg/ZBe1pPiUlzZ4hVVb3RZ81sHgUp0/fAwWjODVecbuJAOX3J2
    /U5ATQ0MjDitV6L71dA+XKd4V0ygpyA9be6334g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491190; bh=lIqhU8
    nO633pMJG09gW5SMkAZBdyQcCqLXYKEGGpVbA=; b=iSMiN2MCpt1GTPtYo+cU5c
    4h+Z7Uq+IMg7omcsia1P6fPTwBoQHg0mxChfnPOOyzzzDcrNe0k6Dctir6cXmhYw
    YL93+MyWKu6U0Gr0Tx02RbcEs9EYOt3cDvbNTg+flZRWdBeIpgA7I9QStA995P7H
    NKZBcG4Grmmc74i2YlDQVu+pDQcOFIvxiDrC2mvP8QURS0s2DuO5J4bLnQB+M3Gh
    ENo4TS2hwEUfgeUIfc+dxvAM2fVGoLxiQSuzufasPGxLbMffNdy+Ca2GqVI0uwCA
    N0vUX6F2XcPQRYJNsD3t2n+fZy4jMMaZOc1GjRXl6eHzJzqZaaKYPEDWE713p0gg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MbNhR6F2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MbNhR6F2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeCHGjr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:39:47 -0500
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:14491
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935381AbeCHE7L (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 50/67] pinctrl: Really force states during
 suspend/resume
Thread-Topic: [PATCH AUTOSEL for 4.14 50/67] pinctrl: Really force states
 during suspend/resume
Thread-Index: AQHTtpoEGS+l1kvX/EeDpWQdbyqsAA==
Date: Thu, 8 Mar 2018 04:57:53 +0000
Message-ID: <20180308045641.7814-50-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:liSJVzisU4k6fsIF+W8C0Ij+eheRxe1GhxlR6aEFEnNzbhEwXAGfh2snbT59s8RQGDFECMWLrDUnonPUg56LuqE5PYJQNC9NBPrGe1Hi/hUCPVoB1V8hykc5rjtL75PFZXJZ6tbn5js1iJ7oh5//vz9cCjEv7AzMWIFGwgRjyVRREmRyMsKLkdyaTBMmkXbAc/O7GF5cuSRxNpkroB+AxEa92NNLIB/vSZlqWLkznZfG/j26SIrVW1AQFI6EUYvC;20:YQu/gp0k5Pos86L3AVN0vR5UQqy7lZte2Wj7K4JfRXw1rCPSeQhixA1JOGvG24l1kO7nKOnMhH5n+6IgVZCP75ikgxA7ytgUhkYNtyJEhoedBZ0Y6lfHomNbqIdWx2H3NKHMZDznECu6Gb/qYXTn0QLncKfNZV8VTRtdafldRSM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2835a4e4-8422-4f1a-6b6d-08d584b1531b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015F6BA0AECD38C422751D5FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(15650500001)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(39060400002)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xbMPDFJO2wARTMHajWzFVoewRdbbeBCNmpqDenvZ67aYVw2oyR2NbZ38MzD/9wdroivtKPmTbIVW4X4/G/ywqzZDxUsnZYbVbMj/xyEZ3jRzBZspM/zQLRGdS1ucw1d2cscaHlCzA5rVz2n6bCHbwdLdYcAC5Kjl90MwI3J57MhW6iE+0V91Z8aiORH6wTFmLAT9oyMYH46neTpdyZ6EG0/XHGA4T26mIZGHIXsrx8fjdwd4UleSF1aD3u19tnSrzCHOl/5rREiPPSC7p5tW10b7iO6dtBDixHqGAURsd/rRsJwQF52gkzlwiVIOroUzsNh9ABOewlUQb8Q2/HStKQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2835a4e4-8422-4f1a-6b6d-08d584b1531b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:53.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 56fbe4c3e800..c55517312485 100644
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
