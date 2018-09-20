Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C02ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E1921521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RowkrtTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E1921521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbeITI3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:39 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:53376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387961AbeITI3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTIVywSHPHd4b1A6mxBnDPFzrO80KHS8LzGpY1JgjFc=;
 b=RowkrtTTHwRAlHjb4yTe16Nwx2i8aRxCkTNFY7NrH0cTIUFaIxSTjoXCkxiLbPiRAwWfS2gwvgmDQHojRmgOuQAMQbruGV+chdAY5mzhjZMRRPbk5E74h9thfnE3jm0ufowG6HnpC3DsrMYiogv26au9k4IX1zskF9uu/tImTmY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 44/56] hwmon: (adt7475) Make adt7475_read_word()
 return errors
Thread-Topic: [PATCH AUTOSEL 4.18 44/56] hwmon: (adt7475) Make
 adt7475_read_word() return errors
Thread-Index: AQHUUIxXUnGOtB3rfEqaQaZT1HijEw==
Date:   Thu, 20 Sep 2018 02:47:58 +0000
Message-ID: <20180920024716.58490-44-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:eiF2n2NwGr5MIn7QsjYEgx0aXaIkMFheVgiiSgMh28IYeCZT493tJViq8aGh5VtrG0ITSuwdU9eszpm6c+c8J35IkonmcAcAkhUXYCIjNlf0Vpi4tJ5zlOvr4DX35ntrkX/WoLwGfgLInlTIjlsmAXj3XR9v/88JUERneAHn3sXVEwyOx9qLpD7INjq7CfRO+N1IUgydiMQffXKnVMkrbNWu6sl2h54pHBcKxP/fptUXvEXQU7SvQyuuZLEMe9O/rE+/Pz6F2PyfiR7wz8m9X8FSIFxF6U5kdzVmjRRJgXsvUGrkYEuCRNVvjwjUZJXZcy9kfGDPKhZuacHqThN5uUJsyESxyHshoJTjTZnfxmqNfCr3bvPOOwO+GBo6AYLHkdKw5bcoNf6iXfdG/D1a5ad5fperktQmlaj9juUSjztkaFUrhDxAaZ0cpaG/fbYx3aNHU45LfTbNPyH+0nbfPw==;5:AtEGuJ1DJWtAKQSXGEm0v0ROVLg2MKfbPA1xGSJUxvYXgUI16kzkBnmy8YeaArdxLvlPm6jj+YvmKdgazpxcCofoC6VujXt/XMGNEPfCofNvTlte/I5LtWJqnmQFiiDb+yzAy7WsfncHzCjWfSQ+X1p2q6l4mqjbDG5GS8hVGwg=;7:RQroQycF5dHJSGJdHfSkLfZUFBg0oNqMpO11AjHmnfM7+KFwfQuFx6ZOK1nj6PHmmSePEeTJmGhB2NkHapWJlhJ4EIQMyoVBHndCZeUN90SWCEuYW59g6JZtbOJC0a9nbOSiHgqmMYmWRhwDrVQcpynZqTqZuCuYX2GPVyS8ATIgijeP7H6XHfqv9/jjKoZeR4CtVvG+/mKrkBTlFt9NJ3ubCBj7nmMgY/GrSN+xkXXRraSzo/Qz6xAs5Z6226wv
x-ms-office365-filtering-correlation-id: 1342fb23-e26c-4ccd-2282-08d61ea38a25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165DBB9CD82A4310CB75EA7FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(15760500003)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: qKKBnI2rkS/jA17xKoEP62SxxEB+sOOppnBFUwk8vBz+34xaBJ/3na76c0bCN6uCSxa3KRACFRLtSJ7UWuIPz3G2aIkVXWqSBQ67UGlW7/sqKQ308LbGGZng4uXYwec2nNLeEas3P0p7Ho96M5bdcMETMc7pNEyqWeWs+0Zp1cvi9UXJfY8HQH6Ve8hUWjQ+pgDPK0rS8bR1T2LPSeLs/4uuHrf/o1aG0Ux+tEGYVkLmM6qkc4RySr4AlmZP11P4SHaLGCKWVx9W7R2NUMuWeLHsjE3uoyUV0qzF5qv8119A7jJPQLeMwoi0AFWNJ/9/QKkXd8SBg5/xteCJOs/TlQh5dsfYozR3p/FU6D30Ugc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1342fb23-e26c-4ccd-2282-08d61ea38a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:58.7886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
