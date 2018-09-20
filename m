Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C34C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1D221521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mDMCHOvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1D221521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbeITIf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:35:56 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:36173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731709AbeITIaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNU1BdunWmIqJNqGyE33Kch+Gt1T1/jr5fEt42EYzxE=;
 b=mDMCHOvRXAtnWsr6LRiQbsvaFZzPMClsj4c/21YO/o/PVTjAXc90Heqwwics8HyIiDLlxrkTdCfO87gWNSwUOv/cCf+O8nYt9AAbaCRngjzMMonEFtdMY2rItjflfCZXJWI65+vKOrrzy54GvQdgn0O9h+eeEx1Bwx9Pq4d01cA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 54/56] i2c: i801: Allow ACPI AML access I/O ports
 not reserved for SMBus
Thread-Topic: [PATCH AUTOSEL 4.18 54/56] i2c: i801: Allow ACPI AML access I/O
 ports not reserved for SMBus
Thread-Index: AQHUUIxbo/zTx8OEsUGp0q2bKDDGlA==
Date:   Thu, 20 Sep 2018 02:48:05 +0000
Message-ID: <20180920024716.58490-54-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:LqPv+YQcMg29aFEtuUv6Xn6/l7/O1WQw8TmeycYDmgK1prVxDw81nizT8R53h0rTr5RCrkJHx8zzwJVBgt51rQOtPerSscKZrcOQrFlG47W/2ziHgULYxvZ8BLcdDIrwm0vf7eXnsaoR3zifSPm49z4dJDo8Tccu0Z8alEBSrS5duH5N2YOMm2PbEilDTp3PFmg2jbCHtzviEiAiFprU6aSIM6ZUkvoRpt/ytMb9mb3Iqa4kfY+tLA2+UhNbR16cJblSATP7sTXHfhHL93IfBvZDhLiR02WsL4vc+Was/1A/oBKrAjBCU9DQCzyryICd/CajOqo1Ye8AQgzW6TOdLrdtT5mr4pbD2SYFYNPidqS/QvlgQVM+rny05v2OwdkVUUSS+W2jpawuxDCTXr73Ki8SQ9wcsUT1JNUZ7UP5CyBj4aEvsH6K4hBKEoWX6X3Ffcg3mNWb36xDSW+DHLp6Dg==;5:FjeGhYKtsQ+a6vgKdeDSUI1IzC2UPxJrkxneVztkdyhnjF5zcitXUmA1iGHXVNJguskrAVlL3nJlopIaU+pijtCjtSRNQll5phLvNmoARX2wL0GcSlnOE4v6wF79kI+4H9Xj2xO1Erngliyf+3oPzHFj1XE41ciW6dtOz3m7WJY=;7:7d/xUm5nxcrl5I7zlMIvzfKnTwx5yzPwTB8v6uB5uPMqPQsJ/JFWp0yE2KWvJlbQx6MnzQCBiYkGOFCvhVHfAUcVP9XXWEPdcVirIW66JXgrW3EVn6X0k+oYZQXa2aAFWULLrLTOH2bY0f+Gaxf8MKXyPPBdXQohSEcW63kuqm5Byw8hAhSm52bOxWQ6tubpoQr/xlnoIZSc9URkiRcWn3yQWWw9G9N58ggds6eUJZmMiZaNgSv9p9OcX6UfYo9v
x-ms-office365-filtering-correlation-id: 8661273a-faa6-4d06-e582-08d61ea38efc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01192ACD7B791C4205C5044BFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(966005)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(6306002)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IsH2lMaXzckMyzMFIoF1mLSKAxxA4kPn9JGDUliTfxanouA06c0MRRDQiQxMq2o3ffa68qd3o0lA/TL40jmOlGSUbZ/4aoi+HbAAz9OXgULj6Rh5Rb1moHYzbC2GbcPzSwMwJ93NV5+0/oIm9i5LJMhHwNekfe2Z+ra7GnMC7TXZP1+uQ9c2eO/Y1ej5kDlIWOfHrBRokhLugIcZWjbwCzHoBD7RHIrzDapS9yF2OD37vvdaZTpodopn9TwDSR/D/jV0TF8rupX6Y0MfyMfMvaWovfz5+soqc9QW838LA1HTPvAeZffVH6M+e5yeDBDr7BAmQxhKmlGmNiZfe1HmLAP0QqtnSLMSg8KYFoRkpVE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8661273a-faa6-4d06-e582-08d61ea38efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:05.5698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
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
index aa726607645e..92e523360457 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1412,6 +1412,13 @@ static void i801_add_tco(struct i801_priv *priv)
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
@@ -1427,7 +1434,7 @@ i801_acpi_io_handler(u32 function, acpi_physical_addr=
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
