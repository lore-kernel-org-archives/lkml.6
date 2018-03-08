Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485343-2-4683134239904536005
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
    t=1520485342; b=tvDbe26JJdutRzYfCqretSmHSK3TkHsw53e5k9oXys3SAv2
    dloOyJ+GoPGFwqTZYckxNe5yfY8kXQoJ6lBzkxyDOL8xdceyowPeQxMHUztLGyxa
    Dx8hQ1H8Z10deYXkwFS6KR6iSBd5/QLlL0u3bAC4WqwF61OeLHSrZao9vuTM2ZYa
    pnJZdpVAgYWseJBf3rwS3bLhV/oZaun+6BliwuI8g2K1hJxeEdDgxyiLr1wO6uN5
    U6dFsQQ1rb6nhxTdogJwm7VAaMkb4bMiPbpxGZ874VDhJBWa4VTDIm2J/VSrgS/u
    +JchprMjrEUa0Kgu03l2P3oiw4sHcybO7EJTYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485342; bh=3sbhNn
    muDTYJpC/nXt8/1jsLcRdLXQhontRCtVmm3tw=; b=L3FvmSIhLtCzjhDm6sAymT
    TmFLRToiOw71eoLJkjAaptg91EQTCVVBhxMmXwliu76dNMtcCMXv1YRhzhbPuHd/
    VP4SaLYMm4JrPOa1AJCF0CaGnpyZjEks+Ba7auvRNQmVPQZolKqDPgap3lYqkTQi
    LuVQlmSFDg/9s2iZ8CvFP5D6/QgHdMisugAygQgoiIzzpcJhEr2Bzbu37SfFOBkR
    rBJjp1YuduIUYLqfkaMWzPPW+lEye5LO+DbLbAQVRMNglN2yzw15WVc7v9k+iqC/
    O6MMFX5SNeK/CUyKQFjnKvvEJw8XRQjKVsJJnaaDfuSnGKgTka/sdKpKtjKJVXZg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lY6YqDzB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lY6YqDzB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeCHFCU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:20 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965822AbeCHFCS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 099/190] iio: hid-sensor: fix return of
 -EINVAL on invalid values in ret or value
Thread-Topic: [PATCH AUTOSEL for 4.9 099/190] iio: hid-sensor: fix return of
 -EINVAL on invalid values in ret or value
Thread-Index: AQHTtppAYicsvQUsWkm4PhawwQTVGA==
Date: Thu, 8 Mar 2018 04:59:35 +0000
Message-ID: <20180308045810.8041-99-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;20:h0BYXFQVHPb2MlQa47+vcVif4S/4fgYUu17DesWhz4GhRT69FYIaal8S0jUCVwBTB9wTWi7p/Fvtf+Zsap9LjNepsDVqy8AONJ0zKtVIWePxor+/j4guRNLiUv13RbvBLmNfwssIp0nQiLavR6Js56c9+Lksmmhycmf4ralWLFk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69cd0aea-5f1a-4913-da0b-08d584b1bfb3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063A9C8246C7447C444A402FBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(36756003)(186003)(2900100001)(6512007)(3280700002)(6436002)(110136005)(102836004)(5250100002)(99286004)(54906003)(2501003)(25786009)(26005)(4326008)(2906002)(10290500003)(86362001)(575784001)(76176011)(6116002)(3846002)(6486002)(68736007)(106356001)(1076002)(22452003)(2950100002)(72206003)(6666003)(14454004)(478600001)(3660700001)(107886003)(59450400001)(81166006)(105586002)(316002)(66066001)(10090500001)(305945005)(6506007)(8936002)(7736002)(53936002)(81156014)(8676002)(97736004)(86612001)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: OF/XwrEFTlluo/kM0BpRxmCQEw3N8ttD4iTgaeaW5Q0zQBK0nFodHAD0PiRbXwJ2DSMgPhYvM3kHkBAn+559Zx8GESps65iPG/j+PCQnvT2eZ0b0qS8cPIhMLl27Jj5LnMelOsd6yey+UPdfPSPIOvlEqazFjHauySFM4nLr2PYkiJhXSlmwZ2+L7kOLcAj7i972hdyiCAtD2U1FZtqocf1hkTFTcRISvlpOrQXBRqfJYMo3sJ3YU0nEdRfjJZHcZ5GGpYapHVhNLE5SgYDkPRR3Vw/TDWf4lkqXqikCSMdLX2kyHNAgRw1+GL1Zvg39XCEzkp4da/WSmQtlA1Ffnw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cd0aea-5f1a-4913-da0b-08d584b1bfb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:35.0417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c894acc7bf400d039bf740420b22f0b71b7fb504 ]

Ensure that when an invalid value in ret or value is found -EINVAL
is returned. A previous commit broke the way the return error is
being returned and instead caused the return code in ret to be
re-assigned rather than be returned.

Fixes: 5d9854eaea776 ("iio: hid-sensor: Store restore poll and hysteresis o=
n S3")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drive=
rs/iio/common/hid-sensors/hid-sensor-attributes.c
index ab646a90e3da..af85db50412e 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -215,7 +215,7 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_=
common *st,
 	ret =3D sensor_hub_set_feature(st->hsdev, st->poll.report_id,
 				     st->poll.index, sizeof(value), &value);
 	if (ret < 0 || value < 0)
-		ret =3D -EINVAL;
+		return -EINVAL;
=20
 	ret =3D sensor_hub_get_feature(st->hsdev,
 				     st->poll.report_id,
@@ -265,7 +265,7 @@ int hid_sensor_write_raw_hyst_value(struct hid_sensor_c=
ommon *st,
 				     st->sensitivity.index, sizeof(value),
 				     &value);
 	if (ret < 0 || value < 0)
-		ret =3D -EINVAL;
+		return -EINVAL;
=20
 	ret =3D sensor_hub_get_feature(st->hsdev,
 				     st->sensitivity.report_id,
--=20
2.14.1
