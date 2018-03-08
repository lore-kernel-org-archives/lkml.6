Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490811-2-1501765803934056213
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
    t=1520490811; b=fwIk2i/kkWhj1xjVezYc/pCAB35BWrvIlXSrcFAaFhwqUgw
    GxxZ7LK6JUhYGWXLTggyEfgEWJ4FTbaRJjIucm1rkz2EEpn1V3E0Ycchv7Yx+q6v
    bt/uuoMYJ7x2kHKHVN/A6ufVALGwG9qwxa7RI2QW05xhw9b2qOHI5PUfAnCX/rl2
    JhO4Q3JdUJGrHW2cdFiDOir3itFjI+ii43MmwfiDf7l/b7ITXmLqis2lqGO5plKc
    R2vAgbdr4RZWRR20RLcTft8dyaYLxwqV+Y6A65OgmAgTu5lnTq4ETr0nAeKyW29Z
    nDTPIclb0oioet55GN0e9mtkl+74VhRuFB6umzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490811; bh=6+BkVx
    lxgyjh5SPP7qMKDw6+63X9v56DX7sQRLdk0Gc=; b=BKAT109J/25ERI5OgjeYSu
    HvOZsNxRxPMeycLJelFHIE19W6Q3Gyq4hrgFEGGNlgpxJMvlhMTmeXypYyhpGjGR
    QU5t7mVq6UQe1OIk/rmxKiSev5HRkbB4ymmLe1OEpX1zKqS4fBMhvBoutsHIq243
    VCrnuNgdaAA6xZuZGAs01qCwe4Ykn6WrCdcDJkfIDU8hE2nvil14wzNN3arBX5US
    8/Y7Uws0pDItKoC6fUoRpK95qKFqflKfIV2Ll7qZlN8ZYLCr+6ocrONAnOg0+0ve
    Y/VmQ4h/Je7Kq8q0XxzJ+HgO1xgQAVznpA8yteqRP3S9qX3pgWi8y2fDC3ILU6DQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T4nltlWF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T4nltlWF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeCHGdM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:33:12 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:44208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965544AbeCHFAB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 015/190] pwm: tegra: Increase precision in PWM
 rate calculation
Thread-Topic: [PATCH AUTOSEL for 4.9 015/190] pwm: tegra: Increase precision
 in PWM rate calculation
Thread-Index: AQHTtpopMmjF9WW37kCj38IqioCeOg==
Date: Thu, 8 Mar 2018 04:58:56 +0000
Message-ID: <20180308045810.8041-15-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:ghoYVSCGhpRUf6mO3meJ28Y+I66a6ZfYU0rzqQiLVBuGJ/KqblkoDrXFZzliiFx8Ks4DiwShoTPNhHnVns85M8zg7M4y1e+12Xjk6gOuoV+nJgEwDajHyFm/a9fViMPQ9K4E0e4mdWJrmm1KDAQokL3hvYXbAKuNNjCmVX/y7G44olB3o0twRiQgUtxeiV6SxX9XfaJ/EXsuRTZ22gSksIxGZCOoI2eXep4NU2yTzgQe8pOjWla4pNKccid9PRo8;20:C0PjpX8OPNXFqB153z07l629rCIiuIaGPqRHHJH1ynUTFVVV7t+VdPelr6vH+2jX2aIMzcqJPlUOnEeipZCNgTvkxK/Cym34kksuBxma12fHPZOAZ0Aw23FjqX5tKf8hmtkcErxULFOQ1XhmZgB+xHbEa0vNA0WBHjVSLq9VLtg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28ccc908-1d8c-4af7-abd9-08d584b170da
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09838C272396A7304992558BFBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(18589796830644);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(39060400002)(106356001)(86362001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: YJSjgftqPjv0tLrBNOf1JGZB5Z4unCb/zMGVqecF3rpK2phMvC5rLuL6G5KgJQx3+xPuW9xKna2HjhC0qHwTIdHQ6oktzTo9hbFHoFaZLQyy5d9XqThucY09LsEh1/qFnfAplaaOrfGCt+J2YFo20rS39uyFvnWIq71gu0Ro3CmwoZKaXnh10wOYbFHjlWOJNjsycpQK0Fi0FPt0396A4CAAoGr1KaK0zwi9UxVRGHd+uhJq+9712Mkq3xb4fmOstqX0U/c0/6LU+LnLbTOlw0GCkhSKZE6IkvxZJnNDZYSQoRfz/qnS/U2Rx9tat4ZnTuGlxPIy6ZKkIa4KQK79BA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ccc908-1d8c-4af7-abd9-08d584b170da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:56.6365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
index e4647840cd6e..7e8906d6ab7a 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -76,6 +76,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct=
 pwm_device *pwm,
 	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
 	unsigned long long c =3D duty_ns;
 	unsigned long rate, hz;
+	unsigned long long ns100 =3D NSEC_PER_SEC;
 	u32 val =3D 0;
 	int err;
=20
@@ -95,9 +96,11 @@ static int tegra_pwm_config(struct pwm_chip *chip, struc=
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
