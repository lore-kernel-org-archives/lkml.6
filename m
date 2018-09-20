Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89973ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B76E21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FftSLjIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B76E21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbeITIa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:27 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388220AbeITIaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTIVywSHPHd4b1A6mxBnDPFzrO80KHS8LzGpY1JgjFc=;
 b=FftSLjIxjM9CjJf8uQP+tHFgiQwoR6QMt+WYqZPHXtxIbyNAbwI8OffnIGp/QlXv0SmyfmL76mRMMhgcGHQnsom5MFZfrRHZLf/ed17Vhbcv3xUwOXVWo/1XJxgJsWCvg1hAo7PYYcv8yE0cNtQA1OQ/ZaRaY5bz89iiL3NpggA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 15/25] hwmon: (adt7475) Make adt7475_read_word()
 return errors
Thread-Topic: [PATCH AUTOSEL 4.14 15/25] hwmon: (adt7475) Make
 adt7475_read_word() return errors
Thread-Index: AQHUUIxnX6sXIcjrR0qbe1qRFxnxhw==
Date:   Thu, 20 Sep 2018 02:48:25 +0000
Message-ID: <20180920024810.58594-15-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:c2svvQk4uUov45YdKZXwGerYQ1fWKGQr5sZkd3T87kCZtINOo65iv9864ii0LiQW5j/0Nk1HecpAmlMq/77hn8/NUpkg3IBaKpBbd1Xm6HCSUMY9rqSlXb4yHKF7hi2K8RlFfZk+TSm57+mmSV/j/M9PWouHwY1mMAn6OVZRY76q5OwwHZVMoukn+fhwow4GhZ8l7NRF81Zo5sSAgsc5hcwxg4Z+834B6gLPaFq0Kax4lpxKAS/RI7cJsc3TT7QpzljdhW/ytX3wRxEbxyjiY2JWYL45ZsWaOwNHoR0fI/FoXxC+aDA2lAxCtStGVg3XiVIVdfmhGTCXndsl97qL3d+BZg+37vfOUO3cXrP9F9+025j/GaIS83sM0wKcR8cP+6B5kuDpnoZNQi5OVAhFmnA1e8yCf3rT+52lAbWk3ykQIWnDLtxwpQD3T1xwspS3aXrPCHOBrFmZapvLu7PVog==;5:Gf5bgFPNlVyyI5kD9WHU+/Zm85dTAErCeHrh7pin6iTGOi4B2YzRdjAAlTh8m0pVFpY/KDCOcUbzFJVLLFBwzyodbIcXvKL18mS+ODmKBoxfeRq7YiiadVd2Clsh7xtyaYdxyIML/4H1IyUKoLSQ9O/9A9f9MwBQrNpDI/oWBos=;7:3rUZfLHsp3IrZZlHSzfwsr77zfqA7YuFHICAwMJVTwHr8RM3iyQOIAYaLi3iZx15b8SCmY1Tt36CSHVpDSzK8XFRmrN2aqVMLfwGewIHN++tWppOAJsSvolExeWDqoYiGDAL9AjTlMuooPkTU2zhof3rRtlzPG0yq60Jj1rbizGRlo5gAkTrBYX2c0hhPjcsIa6eiwuAAT84ATXDR5BUkf+E/vgfEsoMfTaGfjuVQmbgaBimhB6wUAPSkP0JxIQt
x-ms-office365-filtering-correlation-id: 52b595a0-11d9-4a45-c75c-08d61ea3a746
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07441F4FB505F054BB8A663FFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(15760500003)(8676002)(305945005)(7736002)(1076002)(86362001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mMDHw7qzjb//baTl+TAQqVtaPzM/4JbnUgEcO/YEhzzkwZO1UwnAI5KzL/2GVxInjLk6YkZ3I5r2uPlo8q+EfcgcTicp+U5uNi+jp2evTfV4dBIaTLFDbL/lZHwSi3B8jnJbCILWe5IFHBIa6nyeVmJHzyEpDRolMhr5zQwc6nqyBRx2PDLkFZADKQv5urCEiWzA6rYdEorGryYi1zZTnEF+clcVfe5Lkz9+8qZ3tYt8sy3b06v7cGerCBUafKU5TSjCj0QsPFwzqdMcvlVy2w7mb9Gv+LVcOrIH98rhOaIpHmcbtPw/0147ffZ2Do4111kMVDEyOUV073e8SMIUYmO6NG8W32p/1suIkpeAGas=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b595a0-11d9-4a45-c75c-08d61ea3a746
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:25.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
index 9ef84998c7f3..37db2eb66ed7 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -303,14 +303,18 @@ static inline u16 volt2reg(int channel, long volt, u8=
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
