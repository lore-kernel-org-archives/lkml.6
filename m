Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121515-2-18094757189682870004
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
    t=1520121514; b=S1UUBxQavZN8AIuw/XhAJpgZ3W3x0zFm6oKVrXcwsB9Q5PW
    Px0nGJgAEIe+2ha0yB1T61USUG4XeSCIP5HFd/7kpQOaSS24g+tkbDXkKKxgJgZJ
    VdwG1+oTCSLSfus6+geHeZ39vkm5HOlB7fBD8KyL1dXA7l1+vrnAtPjjQewveRZ0
    N313k3F09SPB6dlgI1cQ4gsTGv182p79Y/GryhNHEYlT1rzIh8vC4EWI3L987/jK
    lIZ48I96FpIqTnua3sMhA/RHUU+40nrPEEqmC51idc3L1rlyZVaVWxQo/kQZ6iNh
    rOj7bioxz/qe+yDVPWWI4tcZGXNnQoEmI+kN0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121514; bh=1tpqu9
    IBS86diAUrOpxPz2N7A9smARC0T9Dlcf/0QjA=; b=ZMnNkC9CfnBKK5n1mAbP9g
    heYJcSEmNcgXT1CuP3t2ifVqBNaNyEXhDzUbBSEk5bLjzLn7Ccc5fA7n3bsxrNph
    VJALulPtgaoPVNatyLlhhpaQ0EY7sbMilcbrsvLLSKRHPkCMFqaiquyXCYgZGPDu
    ofJfwPOEf5YhMD57uoNWPaO296PdGAOhdbCx3hXWQaWWY+syuf3RFZqwCQWWlwx6
    R0MD+FsSKhb57bJ7vduMmvR31UkJuk9L+E38c+fN7/7T4JUAEo4Z6IaNF9+OfpaH
    Ic096aY8gSOUub/LtWlY2ftACkvleyO6T8+tLXr7OAq1G1cffMyCYkWx7sg8+chw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MNAQj8rq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MNAQj8rq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeCCX6S (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:58:18 -0500
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:2176
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933820AbeCCWcW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 060/219] Input: qt1070 - add OF device ID
 table
Thread-Topic: [PATCH AUTOSEL for 4.9 060/219] Input: qt1070 - add OF device ID
 table
Thread-Index: AQHTsz71t984mB14S0yS1zyLTEJv+g==
Date: Sat, 3 Mar 2018 22:28:31 +0000
Message-ID: <20180303222716.26640-60-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:nuuW7sVxKvOYWv9fuCm/yVbBuf0U8lS3cyr4Sq+oJ1m45XHUTZHntvoRw4NJtcEdWs0oViOTaB3c5uq3rlmiSpY98apHzmWuLr/+iyfqOqAeMoXGrAxqWLT12j7VGZNeLZysDA7YdirvjZ+3rimpYF+tQlQ6EZet+6VZJcgxKGNYcZ+xV/iWfKm7g6v0gyHt1hycjGXyWTJRVMsnzeeEMfA1SvoWnoygiNFVgXX7C69vW+62z8UVMshsdPwLPryZ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 363b1de2-32ff-497f-b663-08d581569f99
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10970D998F5AAD5974614B25FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(39060400002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: KDT0K4CBYtuhFP0oYH4nPmzShV/vmKY3IFuNqPdGFx+vfXIXdjSapoOUkZKVkUSRA8bbO6b5dlvG8DKofhhlVR4PNkQ/EHRT7bsXd/Aox7nUyeufDrmnMaCaaoF+hEWZ/4Db90gkjlt9F4ZZ6nzzPk9QYLAjPyxlwVcBf6npTG4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363b1de2-32ff-497f-b663-08d581569f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:31.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
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
