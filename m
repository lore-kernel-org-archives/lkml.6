Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488024-2-9359368704949726502
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
    t=1520488024; b=oEcPsow245vXyCezuwlv0nlhKaTqxw2tSMeKvwfPdj4PXYT
    73Z8q5glN0mMnJgSdQCkuzVRg44FgmzcjuDXwH+HFdO4FihfFL0H36bTB+0FDcIn
    TEum1nQyYCfpESryYmZFzD/z3XdzU38bipI3MR4y6MDa9Qx/aQvpXJYYZyxtvcVm
    Df0lKlZ71GxDGcEZZNr1T2D6wjJZyA7ACyiQPL1Vc2e1Sa9I9nlQDRFn9Vp0DE8l
    k5sSWqW9aDA3B1JByM33/3OBgPD4xyfhWGmTkGmrQ0Sogw95kpza5Lt4Io0ltjsX
    nYdREw9xxeVmp1JJSgOWOCy4UcDhor6nVPmYU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488024; bh=w5zwT6
    LFN8nodvm0PPDVHT0t2IrLgYgWvxxxMzpk4v8=; b=ue0jL8dIXJbMmMkyemdZMY
    SMtfkDptSiLQ/OW0qzXmUDzhnK3QT0LVmZmynih9+bhJ210RsFxcHZNconPRJ7t4
    IVt1PSYzZv4cV2oI4oQKRVd8sFHscViEewvD3zirB1wBpiZ9Xbm/Z3xXT/8JPm3z
    5tUjCIfxIKu2jPJO10yfrRmL7ZK4Ubmy3mLW77WLUvVp7TYUjtdnumj0Sw7Egy4m
    hBXIC8U8peLrSLdiisjhVkWW9h0NbORrmTX/bEiyPBP/223fuQv9si9aNwuAt7Va
    KgHVndMhIZoIUaGGcf6b3Sc0O/VJ021rx868T51mHK2mrt57WWJo6jydWbN2jN5A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o1UEsbuu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o1UEsbuu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965997AbeCHFqr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:46:47 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:10302
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965963AbeCHFFJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 009/101] pwm: tegra: Increase precision in PWM
 rate calculation
Thread-Topic: [PATCH AUTOSEL for 4.4 009/101] pwm: tegra: Increase precision
 in PWM rate calculation
Thread-Index: AQHTtpp6Mc2Rgbtj/kGS+079TMou1w==
Date: Thu, 8 Mar 2018 05:01:12 +0000
Message-ID: <20180308050023.8548-9-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:yeo1dyafnLdGpvEdenLLW+81kFn560KHO8guLF2+3x8quQwxeOqTwTdnylRd2D4TTOOAcmIBSNN63YA8A0/iLk7FMnNOr0g6EXb2VgpQKsILqEaj5vZ1UujFwgnp5qwkfTXZiSsf+1A/N8LPEfo+uT6JISaLyabYOA+R8pHzGPAiIGcz71Jxp56wSX5tugCNgp66kMn5VyaZKvQo00QelgwiCGCpd9FplLCOIX8Dignq9q88Y9QY3ISxPiYUVz2L;20:iPxLSygOTSnPSJqrYw5KVqsDT5bXOYMuC4LXG4gzVGhXxS5vxbtwgey2mohHGal2HZlikoVX7ezckje1GDdOO2sQcnltQQ0NtoSHu6r4jZeipkoneD5Ewyc3VVBUenFRYXNDzuzCdCNUS6EKPDCi669bQVxC2oPoZfkaaAYwGIA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83df092e-3ef9-40f5-3039-08d584b22913
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07278AC7F0F25F403258EA56FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(18589796830644);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: nd5o/XJnCHAoT48NtJTbbln6qP2/BMQwymX2jQoZZqljqR3LVDi2ZyHrfIbP4WE/VqgzW393akO5+FdwWC4ioEs68iZbc01gVz/jxc5VmRXuwQGcDYmI4nOwEe9j6XEyp29IW2mY4gUVUJBPX53jW+RQ0yJhweE/JZRa4gvKUN7A3o36ycx8KJkki3/9gj8dND5z4rMHz3iJRgphoQ549xadLjs7EjUwoVHtuRv8V+V23qKNQganGl1JsJPcc/4Gmp9bwkSIO6K2eumkiltN7si+DhSkC1vtZp9hC/cVQvZ93BINvliZwOkzOPgfdZxoasAbQsByOQAtXJCskwMltg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83df092e-3ef9-40f5-3039-08d584b22913
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:12.1944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Laxman Dewangan <ldewangan@nvidia.com>

[ Upstream commit 250b76f43f57d578ebff5e7211eb2c73aa5cd6ca ]

The rate of the PWM calculated as follows:

	hz =3D NSEC_PER_SEC / period_ns;
 	rate =3D (rate + (hz / 2)) / hz;

This has the precision loss in lower PWM rate.

Change this to have more precision as:

	hz =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC * 100, period_ns);
	rate =3D DIV_ROUND_CLOSEST(rate * 100, hz)

Example:

1. period_ns =3D 16672000, PWM clock rate is 200 KHz.

	Based on old formula
		hz =3D NSEC_PER_SEC / period_ns
		   =3D 1000000000ul/16672000
		   =3D 59 (59.98)
		rate =3D (200K + 59/2)/59 =3D 3390

	Based on new method:
		hz =3D 5998
		rate =3D DIV_ROUND_CLOSE(200000*100, 5998) =3D 3334

	If we measure the PWM signal rate, we will get more accurate
	period with rate value of 3334 instead of 3390.

2.  period_ns =3D 16803898, PWM clock rate is 200 KHz.

	Based on old formula:
		hz =3D 59, rate =3D 3390

	Based on new formula:
		hz =3D 5951, rate =3D 3360

	The PWM signal rate of 3360 is more near to requested period
	than 3333.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pwm/pwm-tegra.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index d4de0607b502..3039fb762893 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -69,6 +69,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct=
 pwm_device *pwm,
 	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
 	unsigned long long c;
 	unsigned long rate, hz;
+	unsigned long long ns100 =3D NSEC_PER_SEC;
 	u32 val =3D 0;
 	int err;
=20
@@ -87,9 +88,11 @@ static int tegra_pwm_config(struct pwm_chip *chip, struc=
t pwm_device *pwm,
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 */
 	rate =3D clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
-	hz =3D NSEC_PER_SEC / period_ns;
=20
-	rate =3D (rate + (hz / 2)) / hz;
+	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
+	ns100 *=3D 100;
+	hz =3D DIV_ROUND_CLOSEST_ULL(ns100, period_ns);
+	rate =3D DIV_ROUND_CLOSEST(rate * 100, hz);
=20
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
--=20
2.14.1
