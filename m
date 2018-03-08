Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485474-2-7757784615627418624
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
    t=1520485473; b=b1o2tQLCn0dIVbleIVQkg4sjhwfg1bMVyWLH9zAMDHh3umq
    9fHAi8j1fU6yxWFZUCCEKqL+HN6+25VHMhJrHAYx7AK29/c4DAMPfYDd8Io1WQt1
    pSStB862TbEvrPPjU9It0IZYFdNprs3VHluotSBe1HnDDlbyQg+lx7WpHF8dAEa7
    l4Pg6lMpGViDEXCyCXfHPzv7yPiFQqetp+8xZs5v/CQAU3dQUJN2Bzshkd4ily0d
    1V07is8LUK0m9aQmw2X5NvO4g2n6HNROpt56qJ4pIeo0G1+7G9wnsNGqLnr6hWQm
    THbnsB6yNeNG44bHiIsiaav6PJtsfQiDJXSLDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485473; bh=quLvSX
    VN1mNnUNtLYGbdr7hXKxzwEqpXsRHQfQrryCc=; b=f6bpYvZa8a940g0Izl+Sdf
    UTDNjRZdt6lhbRIJG/AVss8p42DBXyK85NevzjgPGy5WiW/e1pX4LxNY82I4NyTG
    irqswdhDa0Nmava8c7179YMJfx4/laat8epwNu+pe+helwVaUOpEjt6HPUxY7QdA
    Zy5ayR1h4SuCDo/o9+sDdFkPZhAaC0UiCst9EO8lDjjZ71XYLGmNU/SMLqQ/jOfo
    PX0AeU3iaJnNy5/N4SKsLOzDFA/lRFjnSkCPDvtbIvasAGS2Ab6Qj3+xl62xX9uM
    VawkMFL3OWTa3PjdCIG8wjnSS9b8EUrFAX7QKrxkJJEpHc6xf8fjz9I78yY47UAQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lKyvKAwW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lKyvKAwW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935430AbeCHFEb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:04:31 -0500
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:34032
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935429AbeCHFEa (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 180/190] pinctrl: Really force states during
 suspend/resume
Thread-Topic: [PATCH AUTOSEL for 4.9 180/190] pinctrl: Really force states
 during suspend/resume
Thread-Index: AQHTtppWCJ/PgEe8kEWMd8vqGEW4Uw==
Date: Thu, 8 Mar 2018 05:00:12 +0000
Message-ID: <20180308045810.8041-180-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;7:4TEn/mvX1PFS6NyATIamODUVI+YPUuLGDnnprMfeMuqyCoU3OnVbMaG4FwLZK49n9Iz6Qeb0vimZxjFA/+ggdAfWp7S05F3x/WMXvx5RXHuMXXkF9dJH59l4u1/JOQv0hogZD5Q1URMmtmnyp6OojnN4hjydK8WZ1BZ2xjvlnvmIHYexz+uZ4neAhT+yUCIDU9R+KOz3YIVgldT4dKZlTPLGlHLPXJ/IJGRs0ZER5WFbbkd8puKSTusivZelYwLw;20:DZa8UOF+yfop49L+u8dsqA53f8jwzRDiuQukjUy6nSIKZjI3DSy30y4ggMJWQcuD0j4vPBMW31hT2sQGHiy0Ow2nIo6u42Yejz0zFxLXxiu2AxNAiyEYRVkG2L7Pio+KYA/w2YDDuObsEcfWAwsHODZ/RW2h/YSu71S0uPB6/WU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c59c39da-0933-4f9f-5bee-08d584b2118f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08726350FC9E7F9CBFDAFA8CFBDF0@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(5660300001)(186003)(5250100002)(26005)(316002)(1076002)(4326008)(2501003)(2906002)(39060400002)(25786009)(76176011)(99286004)(6436002)(6486002)(6116002)(36756003)(3846002)(575784001)(22452003)(3280700002)(6666003)(2950100002)(86362001)(97736004)(8676002)(10090500001)(305945005)(2900100001)(66066001)(102836004)(68736007)(3660700001)(14454004)(15650500001)(7736002)(53936002)(6512007)(86612001)(110136005)(54906003)(6506007)(106356001)(59450400001)(478600001)(107886003)(105586002)(81156014)(81166006)(72206003)(8936002)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ccgYfj7cK0jTww0uSw8G6TksgekvKnqRc8Hf/lO70YIgrVBSWvgfjqXkHLDNLfU72qrnr9w4URyETGW7TK3HLvUNTMqHPKilDn892aInu2syPO+hbs4sF7JY7w0e6/pxMJwaXMYohgzLvy3V2kj0iB4L0/JlGFphxaPjQ6RSI1faRjTuQfWB2qfFb7FQcAz+E0XpkVFXwT1sgCpWDuiPR7hBnQUNMM8kF1Xmsu93a7iPTRcg4aX+h/lSlwQ3kou9ZVzbSa6L4Ito8rM/mls7fNxxBXTFNcqMI0f/1QwbRc3op76+3+bFeUYcoQY+hh+7ODWgDpz2QkHHC7YWhX5ovg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59c39da-0933-4f9f-5bee-08d584b2118f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:12.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
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
index fb38e208f32d..735d8f7f9d71 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -992,19 +992,16 @@ struct pinctrl_state *pinctrl_lookup_state(struct pin=
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
@@ -1068,6 +1065,19 @@ int pinctrl_select_state(struct pinctrl *p, struct p=
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
@@ -1236,7 +1246,7 @@ void pinctrl_unregister_map(struct pinctrl_map const =
*map)
 int pinctrl_force_sleep(struct pinctrl_dev *pctldev)
 {
 	if (!IS_ERR(pctldev->p) && !IS_ERR(pctldev->hog_sleep))
-		return pinctrl_select_state(pctldev->p, pctldev->hog_sleep);
+		return pinctrl_commit_state(pctldev->p, pctldev->hog_sleep);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
@@ -1248,7 +1258,7 @@ EXPORT_SYMBOL_GPL(pinctrl_force_sleep);
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
