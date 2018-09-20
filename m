Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A7ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF3321521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dj/rhUhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF3321521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbeITIdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:33:50 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:36192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387688AbeITIac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj6yafJ23O0Ki7KZYtWPPP5vme53CH1JhMlARqbKq+o=;
 b=dj/rhUhnYgwDq1zsxNqaCyx4xGIKflX5ntFrufZlqQc2BClbXdll3kgUrpWN4dlZ4CWFH7nVmXT4oaHr4aDftrf42KaO36Fa6OUhmYuqOPIwirXvo/2hxIcERD/P9ievKT7E9XTZSxzfW6ujJ55ol/VBxHxJhk+hqlK5wGEvlCw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 24/25] i2c: i801: Allow ACPI AML access I/O ports
 not reserved for SMBus
Thread-Topic: [PATCH AUTOSEL 4.14 24/25] i2c: i801: Allow ACPI AML access I/O
 ports not reserved for SMBus
Thread-Index: AQHUUIxrv1qQNWCz0Em2fMekHyuoMQ==
Date:   Thu, 20 Sep 2018 02:48:32 +0000
Message-ID: <20180920024810.58594-24-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:Rzhyz+r90PQUJ9A+w6Doio1THHpVYSMvMY+Z97TgHjznYCntPl9bnuOG3Mc6Jd2esyiNoglwi0e+Rf46jHf+LsAu1iBBz3IGbtZsbC3TvIH6b0rHlFzBwTWvW3oG7/r64qXqSUXwV9pcsdHTffSwoYfDejgyE8+goCKNR6U1zJs3ZuggPdWufRdnyUaUFDl7re5PqlBKUJJrKDBG62+d6vLXg2cry0un3XBBpsgZICg9PUH2jEJuBVzCX6hZ0Rlxa2rE0dL5/csCWK9kRnE2JZRdrobCPKzzgfRE/Fom2PONj+HV9p8bsKDS1mSSKGuK/X947GB32okQ4eQZiU+zguayv5v8Guk5qGDyi235+IifMLxnCbf/wkzjYZ6wPSjiv/c82DmyRmw/qVvn8loOlHMmHTevcr8mWp2qgjpqo8mlZ7/Y2W/PT+Hlvk0ERYMic/UNuZQmXzUNsAV68XzJwQ==;5:MbiL80Htn0lQV8isRCZY7mZZ/ZwF2cFzaeADnuu8BXhyfR3TH4aOnAEaZylZ2wz08FSeGWXjU781DNMvzcEFxy1bEvUxaBDWEqV3B8tNS21ipQVA4gChHTi+zmhPWVn6mqAIXl9Ad9x4zc8fr2YbDwogLStaey51Ngs0bJz6xqI=;7:DmbiXLxUwdjnlAvj6zfqEuJDr6TRrJip5G4+DkAopmB3ps+MZKofxcF1YiXebHbb95d4RmORHao1VpHvsBvFkiyJRytKXNoHxwZQojmnEhXB9CjSzpJQqjeM+X1ZSDjjO1NpC/ijw6Ovx7M+a83u3/4Ep6/LrIC9qNEeOKs4mBa/n1mcPhd2011cQOh2wCRzojy/o0waejo5rTfcKa5eCS6tKm9nGl9j7YABY6oaL59b2s2P9ZZgjKeqx5NJPbuy
x-ms-office365-filtering-correlation-id: 82e32396-3504-4851-ba19-08d61ea3a9e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07442A0519E5551C4D2BEA2DFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(6306002)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(966005)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4cfOe2LjlFpPuayWYOaqKLKq2PHHK6IzBJhfSDCus5cPWoT3vJ5Nl8l3FMGgrXC8EvXOgLrXAI43uWxFAWnHqL4UQoSKmeFoOHihzVzXyAF4Kh+c0Ma1PQ/JviE4XoIfRkUOreuVHQq/E5iT/gsWDy50M4vUr47UB1B3Nn1rQK+cXi6akOfv/e5H0cywXncCzx9MDY6bUtIrA4IQWjwemz660Re3E64CHEWngggpITgHaIAfHR/TYG1983xwNHT/J2oFhFiC0oIERTV/OWSlDxJihgaFw1gydVuZPb3/mDomiLUvIVVMmNp22tZiT1Hf9lIjobEROS0/ZaR5JZCoyjQMLTFpl/pNj+clyald5KE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e32396-3504-4851-ba19-08d61ea3a9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:32.7726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 7fd6d98b89f382d414e1db528e29a67bbd749457 ]

Commit 7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to conflict
with PCI BAR") made it possible for AML code to access SMBus I/O ports
by installing custom SystemIO OpRegion handler and blocking i80i driver
access upon first AML read/write to this OpRegion.

However, while ThinkPad T560 does have SystemIO OpRegion declared under
the SMBus device, it does not access any of the SMBus registers:

    Device (SMBU)
    {
        ...

        OperationRegion (SMBP, PCI_Config, 0x50, 0x04)
        Field (SMBP, DWordAcc, NoLock, Preserve)
        {
            ,   5,
            TCOB,   11,
            Offset (0x04)
        }

        Name (TCBV, 0x00)
        Method (TCBS, 0, NotSerialized)
        {
            If ((TCBV =3D=3D 0x00))
            {
            TCBV =3D (\_SB.PCI0.SMBU.TCOB << 0x05)
            }

            Return (TCBV) /* \_SB_.PCI0.SMBU.TCBV */
        }

        OperationRegion (TCBA, SystemIO, TCBS (), 0x10)
        Field (TCBA, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04),
            ,   9,
            CPSC,   1
        }
    }

Problem with the current approach is that it blocks all I/O port access
and because this system has touchpad connected to the SMBus controller
after first AML access (happens during suspend/resume cycle) the
touchpad fails to work anymore.

Fix this so that we allow ACPI AML I/O port access if it does not touch
the region reserved for the SMBus.

Fixes: 7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to conflict wi=
th PCI BAR")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D200737
Reported-by: Yussuf Khalil <dev@pp3345.net>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-i801.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ba8df2fde1b2..ec10aa1655f7 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1411,6 +1411,13 @@ static void i801_add_tco(struct i801_priv *priv)
 }
=20
 #ifdef CONFIG_ACPI
+static bool i801_acpi_is_smbus_ioport(const struct i801_priv *priv,
+				      acpi_physical_address address)
+{
+	return address >=3D priv->smba &&
+	       address <=3D pci_resource_end(priv->pci_dev, SMBBAR);
+}
+
 static acpi_status
 i801_acpi_io_handler(u32 function, acpi_physical_address address, u32 bits=
,
 		     u64 *value, void *handler_context, void *region_context)
@@ -1426,7 +1433,7 @@ i801_acpi_io_handler(u32 function, acpi_physical_addr=
ess address, u32 bits,
 	 */
 	mutex_lock(&priv->acpi_lock);
=20
-	if (!priv->acpi_reserved) {
+	if (!priv->acpi_reserved && i801_acpi_is_smbus_ioport(priv, address)) {
 		priv->acpi_reserved =3D true;
=20
 		dev_warn(&pdev->dev, "BIOS is accessing SMBus registers\n");
--=20
2.17.1
