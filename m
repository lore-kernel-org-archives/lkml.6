Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486350-2-13691188110662251626
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
    t=1520486349; b=G3j1C50SVZZHCUryINqHRo0HASgxvIOaJ5Jy8hcKnGsU8jX
    bcxvjiP6oVynqn07dhOR70lvbjY1HweYQB8cGSgyN1gEZTr8PGSdwVQl3ZakeB29
    02LZ9fuxjJOyrmXq1Iak9nncaTbq29gnu9Iek9KfPrUIIwBbbymuSItsdtuNLY0W
    GkISlSlHFbObpm8ZLmVdG7oAl0cV60m9fLGzt48BmombwmJSJn+X5I98mKJB4sqI
    foMv0bqOlZaWb4keVlMTnZaTTyCJ1x0qDpKArGVIZ+jE5A0ZllkhDAt/+C85Phca
    cx+fhNf1loJClyYhWiEUQC44m/EU1jLO2o3A1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486349; bh=aZYKrR
    brHrpHr+6ENDD98Oy5HQDikxHd1xTS+WoUM4k=; b=TQMT5i/fOcZclb4hfBHyRp
    r8MJzZtusvYI7mugItw0kjx3DvXeSZJbdsd5lfschYiWdBOr3m62cwFLt+5NVXmd
    5oHHqSC3QvvKBsH8GmBfhhroZQWsXXt8XKTlySeApCiaDcFIJqR8ROsQ1TJRMa2e
    IECjjzrUn1UISlzdYl30upkeIirsHYlvXUSNrmWUtevmEedi67gk0aClK2tKwZwa
    bJztgGO+MYPPyz0lpiUF7Vw4KqAyBzY48ItMa16FFLKH1n0QG3c7zn+J1eqswhqH
    JIMNzlyOzO9S/pMVdMUb8UZMOmGTdyaV3S2snSa9ZRA0ltECUc450zhnVVJRY1MA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M/AbtkAa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M/AbtkAa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966445AbeCHFSh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:18:37 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:62624
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966294AbeCHFIh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:37 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>,
        Michael Brunner <Michael.Brunner@kontron.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 14/53] i2c: i2c-scmi: add a MS HID
Thread-Topic: [PATCH AUTOSEL for 3.18 14/53] i2c: i2c-scmi: add a MS HID
Thread-Index: AQHTtprCWEKEiMkQLEmJdQhZU8QLdg==
Date: Thu, 8 Mar 2018 05:03:12 +0000
Message-ID: <20180308050230.8876-14-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:LNYH785yX/Js3oJ0QszZUrpLDPgrStRiOVtWUlB3XXnvCBgd8FZBioHfq70SfMCNXBP9Qb2ya77adaVPwsZIWk2cp58AD5nUOK2yI3wtFp0/+vgdf9eNCX7PC+9lxvFn7ll/Rqe7XLr5OGFVeURqfejXuZ4+kdUp3A48L7+taIxmA3tuDBqn6OIrBHSFydrGaCbcsfiRV26CJ4ZfLF6XK2F8LZDd81hxPy1sqNpPrRvbdNepRzU8FPEj7JjraeIe;20:OJ/niVu4rns8sGGZSAq6lXQgB7cg6QSu5TsGEe+DyuXeYliCwN24TANT/MxtEuMe50v95UqvV80iMW9um3d3fs9AVlc52X7J8T5HoNStU2CcZ8Hz68lIkesPSSrgy9YHp04sjjn6Ae+/38TtVOS8FYkV0UctORrHNz/4pNuy5So=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ba1c487-02b8-42c9-1912-08d584b2a502
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871C9C58F67CCA081808F21FBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(4477795004)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: p6ZEaCA9dl2YWX/ynHP2kamf/1g2dm8unQQCmdajcfJ0ZgRcTtd88zrS3/DFoM31FbO79f24PP9kpnrjhuzqx4XV4PusZDYGQfVPlevjZ2NnV0FxI6b0GT4OFTRMydyhR77xoQe2d1QEQVCSlZBpK5Z2F2LYudWLOFmOUG8sY52PFVL7Sgy2IkbPArjHDk545FzRYBhW5A3j9zLiI1nYz6gslRluJFchh3uL+wZU30uQBPQB/sdbNSRlDXTzZRwJhNfqOb2+qA68MueLEdfbnix6ar52nWrGEYHr6ZJXGMqFbmAsqJmOFBITJ1FfWQeMWL5MInQLzfYhZ90u4fxpjw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba1c487-02b8-42c9-1912-08d584b2a502
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:12.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>

[ Upstream commit e058e7a4bc89104540a8a303682248614b5df6f1 ]

Description of the problem:
 - i2c-scmi driver contains only two identifiers "SMBUS01" and "SMBUSIBM";
 - the fist HID (SMBUS01) is clearly defined in "SMBus Control Method
   Interface Specification, version 1.0": "Each device must specify
   'SMBUS01' as its _HID and use a unique _UID value";
 - unfortunately, BIOS vendors (like AMI) seem to ignore this requirement
   and implement "SMB0001" HID instead of "SMBUS01";
 - I speculate that they do this because only "SMB0001" is hard coded in
   Windows SMBus driver produced by Microsoft.

This leads to following situation:
 - SMBus works out of box in Windows but not in Linux;
 - board vendors are forced to add correct "SMBUS01" HID to BIOS to make
   SMBus work in Linux. Moreover the same board vendors complain that
   tools (3-rd party ASL compiler) do not like the "SMBUS01" identifier
   and produce errors.  So they need to constantly patch the compiler for
   each new version of BIOS.

As it is very unlikely that BIOS vendors implement a correct HID in
future, I would propose to consider whether it is possible to work around
the problem by adding MS HID to the Linux i2c-scmi driver.

v2: move the definition of the new HID to the driver itself.

Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-scmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index dfc98df7b1b6..7aa7b9cb6203 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -18,6 +18,9 @@
 #define ACPI_SMBUS_HC_CLASS		"smbus"
 #define ACPI_SMBUS_HC_DEVICE_NAME	"cmi"
=20
+/* SMBUS HID definition as supported by Microsoft Windows */
+#define ACPI_SMBUS_MS_HID		"SMB0001"
+
 ACPI_MODULE_NAME("smbus_cmi");
=20
 struct smbus_methods_t {
@@ -51,6 +54,7 @@ static const struct smbus_methods_t ibm_smbus_methods =3D=
 {
 static const struct acpi_device_id acpi_smbus_cmi_ids[] =3D {
 	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
 	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
+	{ACPI_SMBUS_MS_HID, (kernel_ulong_t)&smbus_methods},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);
--=20
2.14.1
