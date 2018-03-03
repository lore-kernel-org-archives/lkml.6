Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118350-2-13898627723940902631
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
    t=1520118350; b=FhNJLYf0+Ziq5Q/nZUs2CnoXDUaj1bpVYHBPcUM1nb/uS0P
    RUgJ4teII8wqVzIYxvGKPCiMDZxQk+E5+NpM76/IA8Wy1SMIA3Q/UlXEuIsaNuFy
    GysVabkpZNKABJFscJzenWZymoJuBPay4KTkIoxHLUD71Lnz85MEVR44uogI6DMW
    X5j7NAPIQKLMFxBkBBoqGTfsVliu83IS3pbmjkDFlkBwFqr+lzvOL35QnY+4DaMM
    mQho4A18Qk8PYWp0G6gLDeaFPgbHpKAX5LpLO/jwaMfwwE1FJ5bDE4Q52s0bP166
    ZS+K3CmgQ2e0n7sOZsbT2+0wr6kLqn9KGprWaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118350; bh=w5zwT6
    LFN8nodvm0PPDVHT0t2IrLgYgWvxxxMzpk4v8=; b=JNQfRJRHR+4xnPp/eX878B
    RrYOdHusGgoRO1JFADGRlc6nF/reiUKrsKkYEDYEtXGrvgQwfuYydeQlGylMZUqr
    v4yz4wfXQpf+v5Z+MAGx1giMABWqymIEsZ/nvKpkaNeRt8nLoaxUiDzM36qLMQ0Z
    gALh8xdL/8jponY84LcHQdzetAY+oP8EF9PJt4yKXyo3HT993+17zPP+VnYQUL4W
    SjLi65T8kfl8acZWtvO//oqnw8t4vY2Z/YvdqZpIjH4ntChtB2ahL63QMGCta51q
    k6k3hoCi3pF3b5TFqYjYKRFheWWXho3p0WLCocdbo9hLhG/kaM5P6BIRPyRbjXSA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gc/jldMV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gc/jldMV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935151AbeCCXFi (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:05:38 -0500
Received: from mail-bl2nam02on0124.outbound.protection.outlook.com ([104.47.38.124]:62688
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934196AbeCCWkN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 082/115] pwm: tegra: Increase precision in PWM
 rate calculation
Thread-Topic: [PATCH AUTOSEL for 4.4 082/115] pwm: tegra: Increase precision
 in PWM rate calculation
Thread-Index: AQHTsz9l9e8g9EwgdUGRpERRjG2AIA==
Date: Sat, 3 Mar 2018 22:31:38 +0000
Message-ID: <20180303223010.27106-82-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:j14yYFMORPVvlCU+MlBEle/18OY0XopfU8C40xRRqIb9idI0ywvQBgT/MYi0dHtePkBuaf28YYXHf+qZUtxZkIAvMWonqRT8F9+2tGWT6BJgA0zLqA2CqAmeDPHtgn52GVLzmLTcWMzFJzCDzlxCeBCuurbTzMkdmj+dByvm9mffnlMxlxkVCZ8VeGUw5Sg736b+Yzfm5KgGB3N5bpdu5wGhAYlliRcpZ5Qdy0m3mLv63PiauBemI+3OokKYiZlb
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3cbcc06-dd21-46a8-da75-08d58157b783
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1033B4B2AD24154E276EF92AFBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(18589796830644);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6512007)(6436002)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(66066001)(14454004)(39060400002)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: cvWNfuUd/sRQEBAm/7AVXJD+80ji4pxYN/quKGQZ/By6nUXdjUHfRd0+Suo6K8BRu9Zo1hBKyXzQL3Pcjcj42fOWRK4vTMtqShGMSAA9RnUqpec5I5ll/QI6SHDp6EXHtZtc6YEKqxC78knsvrtiMH77pI90iqCRKQ6A0eSrDTw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cbcc06-dd21-46a8-da75-08d58157b783
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:38.5582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
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
