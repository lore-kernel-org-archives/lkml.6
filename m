Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683599-2-16122032234500642452
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683598; b=W7UpG3WdIf7H7zLWLp3hkeBHpheh/fk3YJ+G+c4NUMtJ8r5
    ffRLYUoZCnn0ZG5Vs76MA2xMmK/SfZBnOYF4OKw2PAlyUDzfviXrvYqg4QuwEvRz
    fYOBPEbAR1088E5At7ad7NmqNOmqHC4hjpRtnO6aOdRVZkWguk7RdbM3Z+bMR+a6
    RsPu4X8gE6Xhahk/3H2yaMfHcips4QyJ0hy2JxonltbG+l4wQIYyePPgeSUTpZB8
    g5Md7SRpOBJHt3Di4zd3gRjez5bfprCNdqvlvzoPfjs/3WExc8meTIBVZOiOGYN7
    T/I2ZBQfol5d+QnKxuYkV/nh3tNjo4HPozqHcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683598; bh=G31CAz
    KZzayTLbyAooTM2UPP40DMG50eNo+TTP4UjU0=; b=GKb/U51CQgSJBPpLnNsHbo
    D4ZvCvqX8b6shLKADjOVvWcff4+/PPIt0XQKSCkPOIXH86LJXusXTJCv6ZxPPEUn
    ClyoWi2CweVC2N+avgtLpwUxCYaw205Np6XJ6S58vokx5YkYF1/pHBdiLv+bo3gM
    JIoxeujdDQyt3m5ArJp1FW0AEjySkL+sGoVpTsWHY5EZREYpNjNaXbA2PaBC/+CG
    vR2Ul7e72hLKKWzBOEhwpr7cJwQp3AMwLwj3y2SUzwX23pJngYiqL6Vxa/njngMK
    kZ5LKGlAmGm4kIryK1/vJYxQaeOQY1PmMJ8EC8fv3LlshEmkyiyX0HpptiBX0QMQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OqZ8LlcU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OqZ8LlcU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755064AbeBCSqe (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:46:34 -0500
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:35168
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752918AbeBCSBb (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:31 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Abhijeet Kumar <abhijeet.kumar@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 029/110] ASoC: nau8825: fix issue that pop
 noise when start capture
Thread-Topic: [PATCH AUTOSEL for 4.14 029/110] ASoC: nau8825: fix issue that
 pop noise when start capture
Thread-Index: AQHTnRjnIdl/Kttc4Uy8OruAwVGxiw==
Date: Sat, 3 Feb 2018 18:00:42 +0000
Message-ID: <20180203180015.29073-29-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;6:5Kmqj5zWJh5q/ad2nIeen+8bhWPOCUF4y5Dr3+ILE30U0LNxlsNjVgqXMuNU4FYCohwfanq93E2XVHX03ZBOqjY0buNuK21HRHqIMULypBhyABaSFDIDxYzP0gg3ogUmheOBpNqj2nn7BnyjE9HPujD38k1No3tkeSRU2DqqAZaVAUWb3rij8iq86TT5bQIhLYeTeF0PhXzdbrk8AuPu7EHC3NjcoyrtkECtzHXeq0kHRCmgNB509V7A+1ammv4UjpjwVdH48onbIzSGX/D+uSQ6HVm6XYEoRvwib6jjD5bO2Q3yy0Tae13ANNTv5BSWqO2jo2LnNQq/o6uO+AEJ5nWZlN6uuHF6ql+5SQLA0Bg6vROvt5iValmPYmI1ou3F;5:GSKYyhkMlNk3GcsDe50kUs5fYnL8VP/JWa6rwGgRuHJKqLEX5v7HU+Dv0P2qYALnPTxG3J+JPQie8LejNNpaD039aVu4ca1jJJHZfHuH/LfdcoTCFodPEJe2YYgLdRaccUsvhr3aXV5X920jRDY1lT1Z28EUbRz/5GcAJTqYzCc=;24:2xhqjBJMWf/PTO2PaPZxMb/Jws6IhCYi5Y7gbuj12KDD7l5T8YWzZpyFWNoFR3OU2BF5DRf/rlWkvOrvI0wBSzH31dnd7GSTgV3pmVT0rYA=;7:LGSpdY+LBvbHVHPEhh6ikc26ovDJ24ToNeyfBcq50/7jug6waCImY7xdyABiO2BHTHDU1UZzjd8lKa7HrSgr7LYRmSJYZvPeq1u0RMHiJsdYmRQ5S2WDQQJdV+11KY23z8BuQ8br9jHdqVpEh9RVWQ5/c/jlwv87mwWEpej05CcJe/7FPc4ITYutMY51BXqMcCZsTToLqwc5C4XL8iLXVaJwAWYsFSDuM9QTbJbnGgfrUGQIuakM+M3eV4HqDNpf
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca3b4e2d-227c-4993-2c53-08d56b300bd3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB1090396E0951C353423E0FB8FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(107886003)(72206003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: hO3mubK12YRPhtkCPFiV4BeABHe12mEGmeJumzSIdtERGgdxvCrsCSVJ7y32U4jfcQuGC/y6kgnL06qRCL1cZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3b4e2d-227c-4993-2c53-08d56b300bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:42.0659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

[ Upstream commit d070f7c703ef26e3db613f24206823f916272fc6 ]

In skylake platform, we hear a loud pop noise(0 dB) at start of
audio capture power up sequence. This patch removes the pop noise
from the recording by adding a delay before enabling ADC.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/nau8825.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 714ce17da717..e853a6dfd33b 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -905,6 +905,7 @@ static int nau8825_adc_event(struct snd_soc_dapm_widget=
 *w,
=20
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		msleep(125);
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
 			NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
 		break;
--=20
2.11.0
