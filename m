Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241126-2-13689022603861776793
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241126; b=HWSfrjcrd62R08PUBbVgE9v3oIiPb42VnJMDyYcLziLRSO1Icx
    ypkS8XTt8CbCvT5o8HE7Wtk/7wR/gKrab/QDsYPLFAjUdnzvAzBJZh0Q1vCvuUXp
    CN+/Tt5LSVs/B+B6SIJFmjVAzOPVfXUjsqZ4QIGogTHUDU08SIcH+blSDmdzkI7l
    b6Oe34ni/ORNLgikqZsEA0J7CjRmbclotnK/LsW59OeEwqeD4G5f58ZyhmvhIGUQ
    1KYtytMPY5jf1TPezxRHs2gNWIUYP1oDtrXROVqX24/4utEngtPqatHNZeZYEQdu
    gq3urERsvflHg51nR5kJ5uMjsnCSEhFimlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241126; bh=yvDeHuWmWF
    Jp8Guz+yGJ5n6Mt/XeILkA81mywywWPYY=; b=hB0QOqPBceyGHcdW0H864ZT9J/
    0ajzmVoA5zFP1kwiAtJC+HXkW0x1VvKuSWC95CZjVdYnWBgd8taG3lWJMUg1mtk5
    Y2A68AImwvn4hujGZKpoxifQRVt+HkpF3hPyH/3AATbD9JZeDxzzV7gvZQ+z1mP/
    QyibU3XwsCL7CQp0A3uOUfGEb/nuhPqdH0HA5Yuy+fvNodiy1RaMD79wD3o2XmFM
    nav60T/ipeRQjQjXzswozTA2GRsTCYIM7sBZXaauc2ej10kOij5AAd5v7Ib9u+4e
    M7UHhyRa2wArCb9bASlhPmhxL/gzgwEDCpnpMk/vhN+E2B/KCYmX6B6JZmkg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VTk3qTSb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VTk3qTSb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCs6Ht5KNF4M5R4EdAnNc+lOqCBhW61QQ6mdhZfRX22/aMcUMAqGuf/Gy61OlZuMoKNn6F9wDGdy8k+Lnxg8mBuGpiC5LK1qC+aUtZ0y0O7Yi3QmIOBY
    BkeVnlNPBX/EQRW0g3OwIapUIVJEb3yxHBnmwd6rBVJ70pX4PexGFbAVtSV780EyeUAl855dli/aex2pED5GsTrbYqUU9ipBTdcNx0KneTwV40dnCCndNMUb
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=NGdr6CL8AAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=qzvJORBUwEijb5N1BcAA:9 a=Zz_gr4ycMqAPw_0o:21 a=OmbRj8NSVfpL8UYh:21
    a=wPNLvfGTeEIA:10 a=FdaAwssBmeZ4pLUej-U4:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756844AbeDICby (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:31:54 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:15008
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754844AbeDIA2O (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 067/293] iio: imu: inv_mpu6050: test whoami
 first and against all known values
Thread-Topic: [PATCH AUTOSEL for 4.9 067/293] iio: imu: inv_mpu6050: test
 whoami first and against all known values
Thread-Index: AQHTz5kFtDNsC0p3sUyeb98lHNz4uQ==
Date: Mon, 9 Apr 2018 00:23:45 +0000
Message-ID: <20180409002239.163177-67-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:igPTwSCyPKRVaGUClCT3W0OFa/WCfJvXvZkKg5zYDHgWBX8CJQ01yvoC9kt+TsXfJiCCLo3B48TxpHkMRiesreJVqEgs/goV9FJKhcSg+3NyknNSH0ZCiOg3YzVkTaprLi6i9YMMmE0v2sw/ghzT8QMHb1mgkBVOlDUUum401RM0HNRkEO5TlhNYPvHC7WlT2R85KNXSR+MoPAMW+nYT5G//m7YtTHYFlIQxlFJ36a5dx1sTzmPbC39JxLst/gUs;20:xzyRqzK0QDhes9EyZp+rP1nlbGEcjSToptz2msdoKjyYlXnLXLkBg+GocEIsik/3GgxAv02l/f+REd5kTeSfjR/wb9B2mf69Dus1zROQS6LRsRRiFVhIcHLp6M+XJUT53M9T7B0RtJb30V+b/oSW8VFwZXjMdYVmJzGgfhX+pxU=
X-MS-Office365-Filtering-Correlation-Id: 89bd07e5-c787-4a5c-354f-08d59db0c5c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087169C57806DF49AB7D6179FBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(257004950022427);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gi1HK8peemixQGzhezBt/2aGKYf6Up6P7VNurLe6GLNsEa3s5oHxTTixILIoFL97hU2/A1JiJDltqxamC5A8CqRRcgbRyw4oqcSnmkYOBiC7ie96vLXS82m4omkSUKjtp7Q9UvG64ViT9GexM+utLjs5i3xQU4YznmgDhwRyglT/FKHW7RC1zhEsg+DdLblHHCkTFZD7RaRpOohjYdPfkKJC6DrVQRqelcCO3tfOnbhZyW6PxQ+A2V4cZo5OyBufyK4oIpZYiAu6fqyqmq0YkRXvgT2ttFRbk3Md/8OIaUDg0hdNv3jasPKMkweYggSRqBjmjf8x5l6XlZLnajDHntKSuPxKQoxB5xopZmDF/ihM2j7GRFhxixMYcsXDAuxwtQ6weqMZvQG6hnxEfGZYgEJ6yyUdM1Gr6OybyFaNV60=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bd07e5-c787-4a5c-354f-08d59db0c5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:45.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>

[ Upstream commit 881b556f6cf22d37be9340f293f2db10ce7ae8bf ]

SPI bus is never generating error during transfer, so to check if
a chip is correctly connected on a SPI bus we enforce whoami check
to be correct. In this way we can assure SPI probe is failing if
there is no chip connected.

Note that this is really papering over boards that claim the device
is there when it isn't.  Not a bad thing to cope with, but not
necessarily stable material.

Fixes: cec0154556f8 ("iio: inv_mpu6050: Check WHO_AM_I register on probe")
Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 33 ++++++++++++++++++++++----=
----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 5faea370ab57..41c68d4a3f6b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -797,27 +797,42 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
0_state *st)
 {
 	int result;
 	unsigned int regval;
+	int i;
=20
 	st->hw  =3D &hw_info[st->chip_type];
 	st->reg =3D hw_info[st->chip_type].reg;
=20
-	/* reset to make sure previous state are not there */
-	result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
-			      INV_MPU6050_BIT_H_RESET);
-	if (result)
-		return result;
-	msleep(INV_MPU6050_POWER_UP_TIME);
-
 	/* check chip self-identification */
 	result =3D regmap_read(st->map, INV_MPU6050_REG_WHOAMI, &regval);
 	if (result)
 		return result;
 	if (regval !=3D st->hw->whoami) {
-		dev_warn(regmap_get_device(st->map),
-				"whoami mismatch got %#02x expected %#02hhx for %s\n",
+		/* check whoami against all possible values */
+		for (i =3D 0; i < INV_NUM_PARTS; ++i) {
+			if (regval =3D=3D hw_info[i].whoami) {
+				dev_warn(regmap_get_device(st->map),
+					"whoami mismatch got %#02x (%s)"
+					"expected %#02hhx (%s)\n",
+					regval, hw_info[i].name,
+					st->hw->whoami, st->hw->name);
+				break;
+			}
+		}
+		if (i >=3D INV_NUM_PARTS) {
+			dev_err(regmap_get_device(st->map),
+				"invalid whoami %#02x expected %#02hhx (%s)\n",
 				regval, st->hw->whoami, st->hw->name);
+			return -ENODEV;
+		}
 	}
=20
+	/* reset to make sure previous state are not there */
+	result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
+			      INV_MPU6050_BIT_H_RESET);
+	if (result)
+		return result;
+	msleep(INV_MPU6050_POWER_UP_TIME);
+
 	/*
 	 * toggle power state. After reset, the sleep bit could be on
 	 * or off depending on the OTP settings. Toggling power would
--=20
2.15.1
