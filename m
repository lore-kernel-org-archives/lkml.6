Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD3ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244C221521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hPuGoYEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244C221521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbeITIeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:34:12 -0400
Received: from mail-eopbgr710099.outbound.protection.outlook.com ([40.107.71.99]:10496
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388332AbeITIa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=827B9udbONQQBLPQtR44v/PcFrbixvQN/+8nIjfwQ4s=;
 b=hPuGoYELuQtNAHxIKT9x6QeVBu3CKlKJXu5rcunAozQ+lw1t1KVpm7W6bDPCSmjMviM9w5kOjWjuHEeIFntfPw5ZZmfe47U+dxEVxNOpcZSDlg2/AoZdpK6RKJMSGAMKEduUpnS44jWZsCYmRacaI73x9wk9dTAGkh7b08acj+Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Thu, 20 Sep 2018 02:49:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 09/14] hwmon: (adt7475) Make adt7475_read_word()
 return errors
Thread-Topic: [PATCH AUTOSEL 4.9 09/14] hwmon: (adt7475) Make
 adt7475_read_word() return errors
Thread-Index: AQHUUIx0EO3kM3KTYk+/11gIZKzUFQ==
Date:   Thu, 20 Sep 2018 02:48:47 +0000
Message-ID: <20180920024838.58666-9-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:hPUzFpjlTuWLmJsCKyevDuSblYLtfwIkw3LVx8p+m/NOHL4HDDm0OcA6mdUq0oVnRY58DQZ/74FgsOLsNxSNqi/Wpgq3FAEzhk2vA4p7/uBThje7rTSm06Vq6vH3+hyuMkUgOhLdavxF3laclpPmrb5MWUSq7pzphKbj/zKf0zub8HRKNK/Obq/APoIeWX2JVd+yb9dYy/qJT5yLpDURcMqoa9u7kuNa5Sgcc4j0l61mDQk99U8X7bc/J12euniuccG3iCjXTrQciAaSX4Nrf9wABQmjuU1RDM+tzt3cN2LffYVEoiIodZ1xnUrphp+oOkWb1in/kiC82juEJwh6ALsneJzWK82CoiDHGX/zzLvij8PeZYiiGl66XFdVQ8VlYCo1P7+aDXQCBbpLyTMK5E2gcWuebrCZN+HO/6qa7a3RjfMH7grM9FLIBjpgtxKOJQm96JQ+xFvq7b2XEZL14g==;5:ig9L1OT0Cgi7wvflRp0zii8VtosJZXZ5nf5WMhIrjEBF8lK+TaALoawAQ1JuoXoTe00mU0eRr4LR/Ik8pLj0yFwAe0PbkHw4wGVK8g0Ur+0WfFtxC8hLK18ySucFaxuGChHrfrPGUJm2hBufzN+V/w5KQm9I/La1eycOD0hJiRc=;7:qrVpicBsDUdasx04epJ7PU6+k6Vd14GHidJ4KyZfyFgun1VZ9gTWJPQp2bJAhOpCwPHWZBBobI1ZzCHCTQbKjMGO5IERREGsZqHBrRGBnkpoZevrdrPZcAhEHmthClVeS/p7diW9UTIc7MT8vpWDWbRSwy/NizZwTUeb67snyr7JNWI8S7eVnl1CGPN22zHBjxBh26ob4h+yI63o18jFav+ic4g011c5l5pmRTF+SnScRF1Au3rUAiZafv8MANat
x-ms-office365-filtering-correlation-id: 5ca52666-705c-4fee-82c1-08d61ea3acb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB04698EC30D3EDF9A44F8A72EFB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(76176011)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(11346002)(6486002)(6436002)(446003)(6346003)(81156014)(15760500003)(26005)(102836004)(86362001)(54906003)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(316002)(10090500001)(107886003)(14444005)(1076002)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rLWGJNQoRGkZ0YBOltP56RzR5/qNa8HGJ23Te1Ldp52wYQFHBm5L0P9lyr+zzZE6iXfTkpVOGQfqFGqR5kuvrElqSmX0rpUjDKSRfowyxQVVVAutrlIF4ZMulnFGSZUxmhPbvQXfaku6aB1NRV0DBipjRnvPnVj8Nc7YrO07sT6o2ANkp3Gejhd8xt+3luGXhSxDKp8Vq+1JI+RK4Jm51aMdQQ9v4zmrxcN1dWlgete4gSPrbR7sJTjU96hurJkwGc+y6IJs9+CHngYLKnA9c7rr5LWqddfvZCOKGXoBEP8NYK+KD26Ou4UcU8GmuOSgggJJNK8K42jroXUnECiZuowVYa6sCv1ZO2k8nFm79bg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca52666-705c-4fee-82c1-08d61ea3acb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:47.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f196dec6d50abb2e65fb54a0621b2f1b4d922995 ]

The adt7475_read_word() function was meant to return negative error
codes on failure.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwmon/adt7475.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 3cefd1aeb24f..9c262d955331 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -274,14 +274,18 @@ static inline u16 volt2reg(int channel, long volt, u8=
 bypass_attn)
 	return clamp_val(reg, 0, 1023) & (0xff << 2);
 }
=20
-static u16 adt7475_read_word(struct i2c_client *client, int reg)
+static int adt7475_read_word(struct i2c_client *client, int reg)
 {
-	u16 val;
+	int val1, val2;
=20
-	val =3D i2c_smbus_read_byte_data(client, reg);
-	val |=3D (i2c_smbus_read_byte_data(client, reg + 1) << 8);
+	val1 =3D i2c_smbus_read_byte_data(client, reg);
+	if (val1 < 0)
+		return val1;
+	val2 =3D i2c_smbus_read_byte_data(client, reg + 1);
+	if (val2 < 0)
+		return val2;
=20
-	return val;
+	return val1 | (val2 << 8);
 }
=20
 static void adt7475_write_word(struct i2c_client *client, int reg, u16 val=
)
--=20
2.17.1
