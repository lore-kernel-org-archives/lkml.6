Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736BAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3915E223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G6fi7RMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3915E223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbeKOWTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:19:52 -0500
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:56064
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729155AbeKOWTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLKOEj390BEBPdSjrMRFEYXui8+w34eyMbx8dCzfQSs=;
 b=G6fi7RMkSuhjXp3Zf4dfGJfBrsJKhs1+gbBX0jFxZNXxccFOSI4+vBwHgM8vviXMUoUIguvUGzqOgScflQiH+PJ+CAOsk8Z/otTSHOfRWsBQENJL+dMKWEoc2z/woNHhBknE9UAutXTR2BRsxltM78RRlBd3RQZkHjQG3+qOmR8=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3693.eurprd04.prod.outlook.com (52.134.15.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Thu, 15 Nov 2018 12:12:12 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 12:12:12 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH RESEND] bus: fsl-mc: explicitly define the fsl_mc_command
 endianness
Thread-Topic: [PATCH RESEND] bus: fsl-mc: explicitly define the fsl_mc_command
 endianness
Thread-Index: AQHUfNxw+U2RkUGjsUCH4hKpL41brw==
Date:   Thu, 15 Nov 2018 12:12:12 +0000
Message-ID: <1542283916-13101-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::22) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3693;6:6gmkvq+AfuaS344UUeFQOVibbcTwHg/96IoiLkRXugOWpqauhOArz+gYYDYLAd2cUVM06sGsGBkeFXUcD0dUOsmgMWntvaQ8REigcU26VyJXVoac1WU1jnnGZLCuhVK4HxfTk22ZcgqMmQzONOvV5CQdOpjNWNACGrg1gvWTqIk7ckNZr7ZDhISjVQeOngLAjj9gCrQp+cQ6n+aXpEbm0mkHC04XIWZ/+h7uI5OtC70ntfBjDHCu80FMD3dOl+tT4WRAk3tQOM8vOZ81vyvw1kgxs3G+Fjisp147r5i9MCWarXHrl55k1QkFgRNKBY1HfXBYZGrX0jaU6tEk6j3/WrasF33HvJ6ZD8pNGiHnlPIqN4BQB/GX33bG+N/x7SCTFHNCf1zKqo4OM8G9ctn/5Fajov8Q3fQVzEYeYyo/3s3ANEQ2ieOJuSUafBviQDVPuW3bINQ6eom2D5Dis4wm5g==;5:NLKiShzrqzrABUfrjhZh/vzpAlJDHdXcyP8o5oQPsaexotsvNyUXP+ihSSfZuxYOmzW4Xsh9u3e04mMY0MC5F3T4wPINNU2sEZFSfayJHXPmhidf1jah4Frm5eBaUS4zuxNoUSALggiLGVa0Cwf7zX1gKshDHWJaf6bmNA8Z2HM=;7:Ewh+nGF7m9dEBbPz13G0CTNcLolucdEn+ViYQ+nPJXNnc5STpzahDRYULLhI8S9ucqDeCAZX5pJpxik6oNXIvNNN1tvCkxalcH81YpCsjaKj6kaNspMMvrma2LnAe5R5tSrh2aT5O/NvA3AQ+iOnDg==
x-ms-office365-filtering-correlation-id: 906bd929-d480-4610-de4e-08d64af3930e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3693;
x-ms-traffictypediagnostic: VI1PR0402MB3693:
x-microsoft-antispam-prvs: <VI1PR0402MB36938B825BC11E441700DA76E0DC0@VI1PR0402MB3693.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3693;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3693;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(6512007)(4326008)(476003)(6436002)(53936002)(54906003)(3846002)(6486002)(2616005)(110136005)(6636002)(316002)(6116002)(8676002)(81166006)(2900100001)(256004)(2501003)(8936002)(575784001)(86362001)(81156014)(36756003)(66066001)(186003)(71200400001)(68736007)(5660300001)(102836004)(14454004)(97736004)(478600001)(26005)(71190400001)(106356001)(7736002)(486006)(305945005)(99286004)(6506007)(52116002)(2906002)(386003)(105586002)(25786009)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3693;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gfPMS+K/sOwrBk0XSWBzdqdsyV34TV1B/+9sqwWx8i1uEbzbtaoyHJKtVEMCXnNfbQbY3dpZlmAELm5Pb+mFM0MeoUAH8CQhHtFg2n1hHsCqdKheSGdf9M96zr3zfiAfqly67OoCsfTrNxQKqhoWihIJNRtYWrHPwehBsyerGsFZkjdu6W59Hq8OuwN1gYlF4RYnssKHTXRbcSVWdI0SWl2fddErzpdfe4Z6YliaCBLIv/0C9tzZHsJt/1fsOa7WQkBHWC3jSE9o1zGRmJgQxhEFndlRvgI2V8qNvhbgkTvM8+BJpk61e1Q9m1Exn28SrSuxxYhYKegWI+vrz4dDNbqXti77a/8RO1X+2q5wm+s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906bd929-d480-4610-de4e-08d64af3930e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 12:12:12.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the header and the command parameters of the fsl_mc_command are
64-bit little-endian words. Use the appropriate type to explicitly
specify their endianness.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 include/linux/fsl/mc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 9d3f668..741f567 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -210,8 +210,8 @@ struct mc_cmd_header {
 };
=20
 struct fsl_mc_command {
-	u64 header;
-	u64 params[MC_CMD_NUM_OF_PARAMS];
+	__le64 header;
+	__le64 params[MC_CMD_NUM_OF_PARAMS];
 };
=20
 enum mc_cmd_status {
@@ -238,11 +238,11 @@ enum mc_cmd_status {
 /* Command completion flag */
 #define MC_CMD_FLAG_INTR_DIS	0x01
=20
-static inline u64 mc_encode_cmd_header(u16 cmd_id,
-				       u32 cmd_flags,
-				       u16 token)
+static inline __le64 mc_encode_cmd_header(u16 cmd_id,
+					  u32 cmd_flags,
+					  u16 token)
 {
-	u64 header =3D 0;
+	__le64 header =3D 0;
 	struct mc_cmd_header *hdr =3D (struct mc_cmd_header *)&header;
=20
 	hdr->cmd_id =3D cpu_to_le16(cmd_id);
--=20
1.9.1

