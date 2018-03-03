Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120147-2-962314495981045230
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
    t=1520120146; b=oLiZE+5lG/6gpJZwS07jihBZYugYz4mxhuQ62jEK+iwD+8a
    mdsL1dr05GDbL+7ZZQEkgjcGWDj42ZkY3FvYpH/SL3evrSMyaeJxTAqUMjler432
    wBFImd/W8PGrGmrny8HIQab0+HXWb7tSW+xu06xO2ObS5Z+lJsaa9WesB0jRi//f
    glQ3qq7p+ypkkBw7JKy1JVhRuFA06f7Th4KtBzwH3HqSJ4E8CgZWa4YqbSTc1UtZ
    vdW0iBQKEgiEuB7oBtZJiMPWkZMCd/ESTKUCRLBaQiBUfQt3O3yaCIxWIQPPCLL+
    ZNdlzG7SFeLGphiNRo4JQVHlAyRtKYBjHT2hKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120146; bh=6+BkVx
    lxgyjh5SPP7qMKDw6+63X9v56DX7sQRLdk0Gc=; b=rTK2Rvr9jml8t3pQwexUly
    VTCxdp0kEU+ecvysTlYXBPk2P8xkDUh/w2kaZUvWL0IVXXsv2UTNbtdL9BBptzCq
    vKS+azQQkr+vNyQl8/WDWb6YTuPY6LyP1r4YjfBbaJGrbrY3TY3DKXm4lzT5PoyT
    OPxC9D4iDIphwEeow4DsOsMmkY3ZPtWvu4oZjOUAnoTwkcO0ka/xq56jbDHo5F6t
    oLYGnqaA27i9/fmGmH101ZST58mSZ/+U11ANlFvNGNVYZiz5GRbaM50stQpS/C+d
    Xj3fIBZflbfQpGihAuu5IOT80k05GUX3+7uzPV7Ov6KCAMqk7e6YU4tKxrvDWYKQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=noUGsfUq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=noUGsfUq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934479AbeCCXff (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:35:35 -0500
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:43384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934447AbeCCWfy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 161/219] pwm: tegra: Increase precision in PWM
 rate calculation
Thread-Topic: [PATCH AUTOSEL for 4.9 161/219] pwm: tegra: Increase precision
 in PWM rate calculation
Thread-Index: AQHTsz8Z3xRmpZdNtU2OBHjy+hbKaw==
Date: Sat, 3 Mar 2018 22:29:30 +0000
Message-ID: <20180303222716.26640-161-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:w4Gdg543A2Q3IWnHZ6hHhEhUG1kZU4wRA/fvTyOsL0VJd5+p+NjON2n3LNpo8d8Ml5ssPz0KGvFAAJgDF2FNrKiBHmnmlYpcaQ+TBJb27vvCOLaQrTn2RpI/cxFcEwCQhCcC7pTjFmP/1ALjY/jTNCWZSuxLdFAXhGXR/JXkjvBy8rhD521gyVasG3YxElLRvV5R8lSniZn+pDo1zMwOoEJxnbRebkXELzSRczMfTEwNqZXkd/c1cwp4UBkrHt4m
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab76c6ca-dc53-4a06-6491-08d581571b22
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10349EA49B4D00F8AB8D5504FBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(18589796830644);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(106356001)(39060400002)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zBhAFuY+wY30vqJQ8yG+FWfZUZfzmHwxKdKf18+NmJDts9uE7L56yZBYWKaGBRZRrZGPXahYlmKOSCKqxaaJsF4rxTEaz+hGvmTv0tGbZ0P9TJDq13msKgU/o38WADJc+6vz6WL/7ilNmZdux7U7mtcn6HDDhtc8dnXrNsv5/UI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab76c6ca-dc53-4a06-6491-08d581571b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:30.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
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
