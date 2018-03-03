Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118966-5-17813889245368204901
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
    t=1520118966; b=ASJyYGV8NtFna/E5Kdpic/bCMyu/EcSSvYN54aBNc2uDyZh
    AjUrRJWhNc7TZeKULLpJZxOZUWj6N1BK0eZC00XdZBYOOF6HI+HblTJQ7omjKLY2
    gbFr5eQN8gq+CU23M3W0w83nNHe8qQ+XhZgqqRfXj0P+JDrh5NfOD8iE53VnGawp
    d44LawDvR8K/973Or5popv51eT1xBlpIMEQboXMXTiN3WWKA+EcExdfgv/puy6Eh
    NwbrRPNC6ruuLTUFVaa+jBSr7hIqq6yStrskHpCgRR7HZlvSCWsLnhHAU0HQGdDx
    bSobRNbDxa6HK/r57SzoHHAhDusutqOSwRthySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118966; bh=1tpqu9
    IBS86diAUrOpxPz2N7A9smARC0T9Dlcf/0QjA=; b=qItfd6/Vqc7f4hsVc3UII4
    RkDa6K7RrwLxXWCpopNcaYkgGy9kXBVFTvLV3LUy2lZiAoMlCYuqqx2uqmveTo0k
    dPn+1ONzrf15AsoEo6bR3zfH8wdnMaV2ai7agGFlJq14O3shvIk4tNszshzi202r
    1yvFIfRkiDHbGA0X/ZVg6ktoeoPt8wEWPdKV78beCw+Z7QUs2FExO/hIVoj6vPtf
    aUROE7I6PgkX7lhM8N7i+xp9QKJtYcws/0ift2WCMW/DcPxDznHf0U9V2Zpg1rCq
    CS5f1JWehBNheWVQJN34Kwqc24BX5joVe1u0TBkZe/KPHHyy/gEiYJc0gujUYPyA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZGK5RKLG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZGK5RKLG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeCCXPu (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:15:50 -0500
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:41081
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934922AbeCCWiQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 029/115] Input: qt1070 - add OF device ID
 table
Thread-Topic: [PATCH AUTOSEL for 4.4 029/115] Input: qt1070 - add OF device ID
 table
Thread-Index: AQHTsz9RboijMz8TyE2Zf6407Zjx7A==
Date: Sat, 3 Mar 2018 22:31:05 +0000
Message-ID: <20180303223010.27106-29-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:+NjU6E/AeCyvmNjjg1kA0nxL74qTDe7bHBKDmQs/lrDBcCMPchjCq1jBcBU4gdV8vTAUqUd1ulWV/kbILAymkXsHn7Ijkzua9zBIr/eUDk3+YzCxcqbDU2ASCTNSHPXHd2bOoGajZvHeKOk+dArGbQtsR6KCBJsG/COLKC1clEazb9idq4gQ5Ce4s2uHkuyU28TWzk5i6CDbdD2wajAIuJJxhBMXJBjfXy09uegSwjQLC9xTjJBqa/nDG51dSa98
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 207e674e-808d-4977-079c-08d581577171
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10679DA1EBEF4B4068C39DF1FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(2900100001)(39060400002)(76176011)(6116002)(25786009)(3846002)(102836004)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: M9gjFUtbUv7EX8fmdllcsEUpsiIacovS9ZbQj5VD7eKo4id7YIZ+FEZ7wrkizDGfcqz3ddJdcDa4aqd7wDfxKzqixQ6Di0/3k+bcQDkAYUaO8TwUPH9tuL5GwzJ7bsGPgLybIGU7p2HIXtFYmC7EUcZNvhi5rkugthN5Jgu79IQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207e674e-808d-4977-079c-08d581577171
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:05.6352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Javier Martinez Canillas <javier@osg.samsung.com>

[ Upstream commit cf5cd9d4480a87da78768718cac194a71079b5cb ]

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

The compatible strings don't have a vendor prefix because that's how it's
used currently, and changing this will be a Device Tree ABI break.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/keyboard/qt1070.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt107=
0.c
index 5a5778729e37..76bb51309a78 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -274,9 +274,18 @@ static const struct i2c_device_id qt1070_id[] =3D {
 };
 MODULE_DEVICE_TABLE(i2c, qt1070_id);
=20
+#ifdef CONFIG_OF
+static const struct of_device_id qt1070_of_match[] =3D {
+	{ .compatible =3D "qt1070", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qt1070_of_match);
+#endif
+
 static struct i2c_driver qt1070_driver =3D {
 	.driver	=3D {
 		.name	=3D "qt1070",
+		.of_match_table =3D of_match_ptr(qt1070_of_match),
 		.pm	=3D &qt1070_pm_ops,
 	},
 	.id_table	=3D qt1070_id,
--=20
2.14.1
