Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520485917-2-15857236532564705126
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
    t=1520485917; b=SBAgMXdfZ1bJJcdGseF6UfQCf02/v+edXS1/nEiSnWhb+3Q
    u2HIRxhflCebGIeNOdEAGJHph/mp+P1gh2u+a9C6pzSulzpmPGFoyzamVon1zQLM
    fyQpG77EZC3ID34OOrRmCpUzxXwu/2ucmjeYR/hSEKK3IHBL5Pevrt0qUQP43ARt
    v/Oq364kEtDB6QeJDJ6htAHpHmZ6D2ofu+Vqi6lzRPZ/YGfO/f/e+pIIDzqgVOqf
    rDlwl1LNY9d73NlwPEzciei3KoLPcowq0NqU9nBh+wiVM66I5Bppy1BtJ//qzXzI
    T9fSob2yCtSaFxOi8R11FQBPUqRz1M8Y2hLqLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485917; bh=RqwLwM
    cU0mR1AahB/CUVrNoSF6w4Q01P3viLJj9yYxY=; b=m73e24kDkJEv4DofKpDEtF
    2XTJvJZIKe1qAr3lKSTIVuB726419Vhom9SKklAjLFPhrw1JawAd6VleydRPBaKB
    db9WncEz8ZQCFw2Csga5AnwcocODTjKntwP2Al93Y6g+C0mjZRg8F4fsLdqvW0RO
    pQ9EcuhoONkQDCw2uYMq8cDLZKEwFHdPg4KInzfSUakBxwZbW85yAyiLJTqhhdYS
    sbSmUAgxgJ3V1hfRRpbz6bk6jNCqQJNf8Y/dIWOQPuWDdZL25dghn9jhsHlaY/4H
    K3wo+cdswNPMfAkVHSXF8ncARG3YDCYAtqtvd2ikKYZnKXy24NPt0y3WBIEmGBjg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b8u/9d0v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b8u/9d0v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966946AbeCHFLw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:52 -0500
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com ([104.47.33.106]:33696
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966933AbeCHFLv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 52/53] pinctrl: Really force states during
 suspend/resume
Thread-Topic: [PATCH AUTOSEL for 3.18 52/53] pinctrl: Really force states
 during suspend/resume
Thread-Index: AQHTtprM9wK7z8mTgkayoFgj/uxC+A==
Date: Thu, 8 Mar 2018 05:03:30 +0000
Message-ID: <20180308050230.8876-52-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:xWGj0WXKTXBkryRrtImzXEb4doq0h5oeyjlqIm4ue/5dHAzd035FGI1FYir8zqbAYt5wmNsIlGF99hV3dw8JIXa824nMcsB96s+F2ng0HLnUw8PCZ0LZVAAsWdPyJsi0uNwXcuBMDIsOBjEgzeoWWkTz2mlL8TSRutNblVA+oggckzH/nj41jbm9QVbx4I9OIgJO9X5N7QW7iZpRp4T3ut3tZRrwdhlFvWWCk2j4fQBz2J+GH6miOefb6ua5tY/n;20:pvxKief5f6Fw3vH0ZuktgVEsFPMnyllV29tAbeWSiAjb/NFeZrU5ftEAahDqLZCm9PNV/oweKt/PQXnu52DS5tOl4tkVySXcawix/AHJhqRn8NXxTZbGDGUSh3KrjjrOZnq829RTBktIN3oU5+1xF7mIG3mCQJcJWTSojQQCW4c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c29688b5-cd2e-4c35-1101-08d584b3188c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871C0F76356DEABCF3508FEFBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(15650500001)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(39060400002)(26005)(316002)(186003)(5250100002)(2501003)(575784001)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: RV8yzB/hko3Z6lrIc4qFtqCpVuunsung3Y0ys+qH2a8JyfqrZB60w7oCG82cN4J4YLz+2G9RTf9F365s4ja6rl44BfB0x9VJpBgPFPCBk9ScelZqm7pinURhF21TE8pTPZbjLNLuGHJa4PiPqUhs1ffjcWO91y6WJuD401vWGEBEHzTOra5QqU+JYYcllQ+BxBlat8eY+FVvktCuXhCea3JgxnnQiTeH/SgWsOpMPWUhpvpJz+XxP+DDKLjJ8094ZsSHflVYnoO+OpGshLzGoQjgCfRovyjd14R8S5YIMhocy1NsMw4CcdiI4Aw2eS5fLraJjHCPAJD0kabg8j8a+Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29688b5-cd2e-4c35-1101-08d584b3188c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:30.2988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index 18ee2089df4a..db43f8b34e2a 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -977,19 +977,16 @@ struct pinctrl_state *pinctrl_lookup_state(struct pin=
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
@@ -1053,6 +1050,19 @@ int pinctrl_select_state(struct pinctrl *p, struct p=
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
@@ -1221,7 +1231,7 @@ void pinctrl_unregister_map(struct pinctrl_map const =
*map)
 int pinctrl_force_sleep(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_sleep))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_sleep);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_sleep);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
@@ -1233,7 +1243,7 @@ EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
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
