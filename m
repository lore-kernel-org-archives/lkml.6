Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486595-2-12151080548459004209
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
    t=1520486595; b=YxQ4aP5IitpNI/w8Ypq0PnVKf04a0VvuH896VU90yybbCjK
    cF9RpJMJ8NjoUnAxTD/5MJhzdllD+0w0hzg3ExPDnDrqXliQXx9SgCCAZyYhM7R2
    +6FkVAacr4bq8yrY0gfIfncLWCDK4A7YyxqIwRc5YiRe6hDL5dQ2h5NqS2SBKOIa
    WDqN/xiDxzcRazSbAxduPtiIb1Vu0EUH4VlVn+8p2QbUamxOEVu6+A6juoALIEj5
    1rjfs84IH3GsI8ZMUAvv7mff3rq8nJyn5ShVIbv1vCvdfFUmSJYJN9jzxooUE9qm
    8GZOARaa85K3ZOlfBuKmR+2MmGxHfFrVUyjnbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486595; bh=DoY+J9
    KQ3IZ0SkQ8WQ9gKZAFRaD9g3nqq/3WDmprOvM=; b=JM3NP8CV3BtH9/HTs9F5X7
    pnH6ppVa3Fe/Uu0Nk/JA3FUnIewkjfg+A7j9h5Yrke8KekbcuNStU6sVotUPBXjH
    G3ageacwxyZb1szEgEilzyTmlveebCCHZVoWOOLob8Gsqh3vKkgdCFq4EFjx+NHq
    W8teNE09PvMPUI7q8Z9sZqqMcHCw6dgWhgkIqH0lJ6LywnLd9R2S0hPfuKIJ/Y3e
    VpfHCGXLsVxrbHytV55RidSNwj+w+nC/1G9buJDb9AxCEdb/f3Casc/GVIvJwZ0X
    9xxhKZenOjPeX4UCYvo8m3K6BeGdx7jekQYz7k6SdyMEW+DFo9en5WeqnIT//rpQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fketDPb7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fketDPb7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966668AbeCHFIC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:02 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:56636
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966653AbeCHFIA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 095/101] pinctrl: Really force states during
 suspend/resume
Thread-Topic: [PATCH AUTOSEL for 4.4 095/101] pinctrl: Really force states
 during suspend/resume
Thread-Index: AQHTtpqf3rAlSN+qH06Q2SSblRI+bw==
Date: Thu, 8 Mar 2018 05:02:15 +0000
Message-ID: <20180308050023.8548-95-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:/7aT6dnaHOne2bjMco7aP3BEq9rRm394ZeXBBbQZfi9SoDrgGkgy4O9nhiaoArM5regX2eAVtiZokRhtjYiEB40WAVYAba/oVh0FrWPGdYw7tKYyWw9Xcfq37tdSFKYikfffBxBBtIxZHvWPgzUgy+CuIgPVYR53KTGkuZMLEORe7LeYopaOfgpjgGplqn/cYHNKshWFoDuqDVEKvl++Lm+JjTSnPyH0YRZShMV8qKgxpCkEHkUk/ophM8nOy48W;20:/zpfRZNZhWJmaPx2ribDfBtsBBPioQx4hV+JZeJECydBH7siyVvh+ivmjtUSE3ozCza7t3eNHTytkoL31eQaOdReQzkYZF1Y/CSND6+SWxx37WHexVajmECqF7tj33SpSKgQAhGE+ctwCdUqyQ/PhKXxWeEZzh/7t9lAwFwZT1A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db73962e-e4a0-4ffc-f2ec-08d584b28ca3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727E22F76F344D69E024A78FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(15650500001)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: KYmgkFg/qIIZjcrF2cKaVTNm/5qn9C4YlVOlq6l5N0ZGqB4Dh9jWpzXPgHmQJs79Zuxfp/p3GlA9nxB8t0FpH8czLY2jR66EbYJ8NgZHNmA+axUyN2H5PxCPZliONl83wvjsIcptfkz/CUlhC8325xCrjCS452emKymOOFthj945dqzbjm/QybIsUvCTxAKY+PA/VwoxUHONOT1rHHZ1u2fKX8WlODui3X5CWucfdh5hNXj0GIFxdSqbN9x7recSR3C+nYAVZXgkYd09db5JlcmMacPu3iF3wrGbTHkqSF/eMwyrmyKYarqPvrEHhvoBWh3QQADO/8r8NX0ovfQEaQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db73962e-e4a0-4ffc-f2ec-08d584b28ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:15.0129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 2686a4450dfc..f4639a9f1e48 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -979,19 +979,16 @@ struct pinctrl_state *pinctrl_lookup_state(struct pin=
ctrl *p,
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
@@ -1055,6 +1052,19 @@ int pinctrl_select_state(struct pinctrl *p, struct p=
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
@@ -1223,7 +1233,7 @@ void pinctrl_unregister_map(struct pinctrl_map const =
*map)
 int pinctrl_force_sleep(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_sleep))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_sleep);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_sleep);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
@@ -1235,7 +1245,7 @@ EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
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
