Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3ACECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891F8208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dfc1QsDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891F8208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeIOGrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:45 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728409AbeIOGro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNZxhYweF0L1WQiYcSvgZTJLQ/kel4YdJ1Q86jPlxo0=;
 b=dfc1QsDf+8rMKayTcFACle6PER7unKHIfphWETEWE6DUSoD2WQkbMZAzzXgsGDQ5yMAj11vftnVmXdPBAT3JZ4yqah6OmFVw3yKxfot2ZYkdiO9L2Ht0O27aRLbH+AtJgIo+vGvP9r5ulEt6wTZCCEaR+qMGGKHF4XSqyrhEf+8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
        Jan Luebbe <jlu@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 32/92] gpu: ipu-v3: csi: pass back
 mbus_code_to_bus_cfg error codes
Thread-Topic: [PATCH AUTOSEL 4.18 32/92] gpu: ipu-v3: csi: pass back
 mbus_code_to_bus_cfg error codes
Thread-Index: AQHUTJOls+C2jMto30OaAvgZAikA4g==
Date:   Sat, 15 Sep 2018 01:30:12 +0000
Message-ID: <20180915012944.179481-32-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:KPGKOoZ7PkD9PEJXaY3JuF/p5wa9p2vkKqVHf40dxS26L5r3PuGH22nm+cQSeTEoIz9CId6u4X4bAwu8ifXVBJSXEAqSARy1dlu9hV1p8mZOL34Cqrk/aPZA3ZUSzrTFFESMn/8lI/EFaZAt0GZQSHiOX9l3maqmlyimtNleRfqTQyYDwqLvOQdlxOmygH7AUYUU0oCx3MkGoZMKzY9zfLrqKE2yMAHlQYDZpTXTuIJ8jTB7dkVqBZS8NZ+N0+aPgJ2VGvmGknqgPFxmG9sSLIor7RW3CdwMgKKlaVqpS/A207QmrwHS5GYntA1YCZWze+KbKZzovmIhht2PFaZpa1sL99Y8oKDXP0Du9hFu57YaebO5EWBMRDdKRfJ8eVcSMtSDdC5TyWhchLnFDao59bSwPAY8uDeEvFeVgfvdumg+W99e+15sPwGzm597FlBIui0QbKVpz0YMtrIwWUmtQQ==;5:cQG6t9grvlUxT5Eg41T25jcAIDQ0T0dgkw+CESclT8Aeu7EctVorv4jqv0sol7batcAhq35vwIPpAnfqo0NBdfrlDtJwf//1X18f7xHn23DkaZoiQShBCkZGblnZY+KIi9bSso8PZoW8UKUMzPzkgRnivRDHmIx1n5w57mEE+RU=;7:3NCJyRU+Aw6GZoVLPQ5efRN1/1+UGDZyoAl25ReBCN9Xsod0f+WXH/0qvkX3ZH3qZsiR3pQyAN/W1iIQuJge5z249VJn4KswSomfcQB6u34Fx34RbPZqFac5Xqx4zdsqosd1dO7qxzZMVpwSaCJ7EepuGqbywEV7KdLRTxiZK3foPNEzPw+UuWICOu+ysmWzDwBXAxtNt5kK9QrQGkdT6g4eSmIgtO4qXvolQwP3Ffmq15CLVqoXrPCuxpAy51nC
x-ms-office365-filtering-correlation-id: 8d337697-acc1-465a-99c6-08d61aaada1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB0741DF663D8490FE83A762CBFB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: mqaprsu9FMWwBMsbvOfq1phaK3Iuu+RI+JERVOnoEpQcevpuNAmA5BJZlBOIsFXnlopMshtsPw6wSOy+E8QoB+AryqHqD5b99gbM0HM3rhX8+t5lotVW4H83XTsqjW1uM0I6cJzKd8bRnMi8Y6IsZFMwIADoFTTyfEcvs+yvyJf/cVsApKt8eCYJVZ1jCFKKTKIOhZduNHl7ls8+hqw8KDu263KGO3D6Nxd4TUeYD2AM4zSVQuZdy3VfbFHOH7FOtsDdDfFhyT9+ki+t946uInwNj8NhY2cBzUtyMHBF5natBojfwd6kZjBI511qNfJ3hfTNI50yFqRu1FralB4xFQ2RKMy6UStCt/cNeO8izyc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d337697-acc1-465a-99c6-08d61aaada1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:12.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

[ Upstream commit d36d0e6309dd8137cf438cbb680e72eb63c81425 ]

mbus_code_to_bus_cfg() can fail on unknown mbus codes; pass back the
error to the caller.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
[p.zabel@pengutronix.de - renamed rc to ret for consistency]
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/ipu-v3/ipu-csi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-csi.c b/drivers/gpu/ipu-v3/ipu-csi.c
index 5450a2db1219..2beadb3f79c2 100644
--- a/drivers/gpu/ipu-v3/ipu-csi.c
+++ b/drivers/gpu/ipu-v3/ipu-csi.c
@@ -318,13 +318,17 @@ static int mbus_code_to_bus_cfg(struct ipu_csi_bus_co=
nfig *cfg, u32 mbus_code)
 /*
  * Fill a CSI bus config struct from mbus_config and mbus_framefmt.
  */
-static void fill_csi_bus_cfg(struct ipu_csi_bus_config *csicfg,
+static int fill_csi_bus_cfg(struct ipu_csi_bus_config *csicfg,
 				 struct v4l2_mbus_config *mbus_cfg,
 				 struct v4l2_mbus_framefmt *mbus_fmt)
 {
+	int ret;
+
 	memset(csicfg, 0, sizeof(*csicfg));
=20
-	mbus_code_to_bus_cfg(csicfg, mbus_fmt->code);
+	ret =3D mbus_code_to_bus_cfg(csicfg, mbus_fmt->code);
+	if (ret < 0)
+		return ret;
=20
 	switch (mbus_cfg->type) {
 	case V4L2_MBUS_PARALLEL:
@@ -356,6 +360,8 @@ static void fill_csi_bus_cfg(struct ipu_csi_bus_config =
*csicfg,
 		/* will never get here, keep compiler quiet */
 		break;
 	}
+
+	return 0;
 }
=20
 int ipu_csi_init_interface(struct ipu_csi *csi,
@@ -365,8 +371,11 @@ int ipu_csi_init_interface(struct ipu_csi *csi,
 	struct ipu_csi_bus_config cfg;
 	unsigned long flags;
 	u32 width, height, data =3D 0;
+	int ret;
=20
-	fill_csi_bus_cfg(&cfg, mbus_cfg, mbus_fmt);
+	ret =3D fill_csi_bus_cfg(&cfg, mbus_cfg, mbus_fmt);
+	if (ret < 0)
+		return ret;
=20
 	/* set default sensor frame width and height */
 	width =3D mbus_fmt->width;
@@ -587,11 +596,14 @@ int ipu_csi_set_mipi_datatype(struct ipu_csi *csi, u3=
2 vc,
 	struct ipu_csi_bus_config cfg;
 	unsigned long flags;
 	u32 temp;
+	int ret;
=20
 	if (vc > 3)
 		return -EINVAL;
=20
-	mbus_code_to_bus_cfg(&cfg, mbus_fmt->code);
+	ret =3D mbus_code_to_bus_cfg(&cfg, mbus_fmt->code);
+	if (ret < 0)
+		return ret;
=20
 	spin_lock_irqsave(&csi->lock, flags);
=20
--=20
2.17.1
