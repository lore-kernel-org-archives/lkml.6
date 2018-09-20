Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7238CECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFD121521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cPfDumiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFD121521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbeITIb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:29 -0400
Received: from mail-sn1nam02on0096.outbound.protection.outlook.com ([104.47.36.96]:62018
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387917AbeITIbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=827B9udbONQQBLPQtR44v/PcFrbixvQN/+8nIjfwQ4s=;
 b=cPfDumiAzcHRl3TSe6kV9XhBLLWE+h6nrs8FSL8C9SpL4qTFr6QyPMVyZKY76aPrXZmE8GX6Affb3rBiQJpuhixUyu0pIqUecCKHbcKKuTJRTuXLnhjbs6j7w2U00ykWXB/cEYb2UigUubECUJYb0M1CtscD3J10Y+Jd6VVjUtY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:50:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:50:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 4/4] hwmon: (adt7475) Make adt7475_read_word()
 return errors
Thread-Topic: [PATCH AUTOSEL 3.18 4/4] hwmon: (adt7475) Make
 adt7475_read_word() return errors
Thread-Index: AQHUUIyYkNUqnZweOkiNNqmWVqzLnw==
Date:   Thu, 20 Sep 2018 02:49:49 +0000
Message-ID: <20180920024943.58781-4-alexander.levin@microsoft.com>
References: <20180920024943.58781-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024943.58781-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:eJNYeQ06yf9HnPM3BSPj+w3b+4ON8efAkHFYp+Vt8hoOz66adxQjOQNl2yUOI+jiph9tBhy7oMMaoHhOCvExUILDhhTkZ1k2NO0qrXgfgP7xbQwqjJW65wdbH1uTuisyozRZKMdUe9vvRAysK4xoy4QjE8bgI/Tkj8DZoAH/eOU/9TR9m90fG8YNmZOuXJSMC4PuvOdxXPU07flXDzyUFqFEvbU5rEp586hUzmHGiezxJD3LeUeK5S5YdxqCTMc5Lvw4KsvdCZL7Ck9Nbq8iHhInOM4Hg5ZB7oNVDO7MR83mwk9a9KYz41y3NHN6UUpgA3Mu1hm1m7ZnE9CwGsih/DeE6DKu5x1qrmSuN5KknLpnqJGMB1cgtCOYZ4XRmmZIUdfw5ew31Yq05m86cobnPaQ3QGyjMoE9/3cCKQxSG98z90hVeKiOTVB91+tOrPHlR+B0WsOmy+MDLodXgmSvyw==;5:2kV0DKeb6co1n+w+IqKSvkowBjFwS4EQ8XaQ6UMs6FOsdko9v62iG46AwIz/y7dJrBZfzk05TKtd7EOhQHohrMilfkN94oqgb/9xo3WSgD9YMv2Kjbr1VNKvThFmMdiwqrFzVo3QOt2LLyUyuVbMd6eu6QXbhU/4hNQc0GqL1Lo=;7:nIbqzmt4qhInUU/wmkfvm1vISL6yVSC5Bz6g7p4Xg2z8+GeJs00VqXI0d8VtMukzy2HXOZtqc1U52EVwPuQxNTi8KEG7JMMSSZeeYeK8B0WMggQHZgyWtrpAYV6ndILy3Ci+7huvlCuf/CkUMcWsRb3uChJ645xzu0OD/4lmDaUHy01xeQpqRMPDbcVuuB2LPlwnLIGnAf99SRgB9Er8i2T8cBX4x8TzEk73gUZlQHldvJCAO4w/iN6HE4aXLJmn
x-ms-office365-filtering-correlation-id: 26e5c678-5814-4aca-52c1-08d61ea3c7fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855A1D04DDE39EB94080040FB130@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(2501003)(186003)(86612001)(10290500003)(478600001)(2906002)(86362001)(6666003)(106356001)(3846002)(5660300001)(2900100001)(6116002)(8936002)(105586002)(1076002)(53936002)(14454004)(7736002)(305945005)(81156014)(81166006)(8676002)(6512007)(68736007)(72206003)(6346003)(107886003)(102836004)(26005)(14444005)(256004)(6506007)(36756003)(446003)(476003)(2616005)(71200400001)(71190400001)(486006)(217873002)(66066001)(11346002)(97736004)(25786009)(22452003)(5250100002)(10090500001)(6436002)(316002)(6486002)(110136005)(54906003)(99286004)(4326008)(15760500003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: kZqnSEzbkh8+RvFu8Q5VUwkfRw8cOgt0RWqLAJoFBnqOdJsdMznK+3Bjf5VUBfJAPUgAsOgrGnx8AQHkgaJk4SfhlwVBDnbpNP2jXLdaxIJP3eRv2sIKuW7qyKrDsBS6b2h0s2rguuG3jYg2HCPTRTt3TXUoM3hxBCgOnVtuMsQnwgnwhT0fFOqmKUAcRmU5t7dBAjTNmQJU3NqWkSlCeZfbx63jEG5okVkT3Pb6pTDDzgSEhDz44mu+8ii0jHFoRjEiLt20biomKxVKZesStgPGOMS42n+M3+K5+Hsx4Ht6HtgsAqCf9p0uP9l5XQP1W9P66LGQjS3xLABR9iKr8u8pYlXglycOnpIpqClOcwI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e5c678-5814-4aca-52c1-08d61ea3c7fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:49:49.1779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
