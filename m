Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832D421521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mPPTO6md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832D421521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbeITIbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:07 -0400
Received: from mail-bl2nam02on0120.outbound.protection.outlook.com ([104.47.38.120]:37182
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388553AbeITIbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T2flM7FsILEMFxezKIQgP8uZ1ZNMLkx5RnLJrI5SrI=;
 b=mPPTO6md14ZKzhBN4g1q89p0vkzUL6aAKLKqmAXc5IP2XJLK/uONULA26SfS2iClZjhpAPmnVpQxI/0w2W2O7s8rcEOfZ07Ij0K2htFhvS/wqSHLA/MRACXySf8Vj6QHuu0mGKY03KFX6Rf8LCqgkKgRjv7jPjC/Qs/OpX4lo/Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Thu, 20 Sep 2018 02:49:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 14/14] i2c: i801: Allow ACPI AML access I/O ports
 not reserved for SMBus
Thread-Topic: [PATCH AUTOSEL 4.9 14/14] i2c: i801: Allow ACPI AML access I/O
 ports not reserved for SMBus
Thread-Index: AQHUUIx2yOpMs+Sx/UubPIQL+ts5xw==
Date:   Thu, 20 Sep 2018 02:48:51 +0000
Message-ID: <20180920024838.58666-14-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:N4gnpAsezCjdMmj89gn4j0TOMh1UPeM3KuWLSVWK1sTqG28UDUu4/P2hvBS3r0W+Bi6pdCUevQ9pUbuETm20Mt22dcj+zg0OB1BvQPO5vMhkhQUGgpt1BtJ4U8m+St1WqvV7pQ1Uet/MAe9dQ2AvV1yyVRA9mYBTc8SDc/rCezX1zxwYkLd1cXrLSiF6zkii4gJjdkXIwVd3aLmXu9wqQhdQO+qJi6A050a/9H9IkgQjbpq+gTJzmml8dnsdJ+eLo4SaLwnCIzPgDbLa8zMAo5Mkp19VZwsI46cIU7Gl5wV51WtnXwW08FWP8PnzSuqoLPlMLx0tRHv34WFMoT5ADKLEaRibg6U5ggmbKugB8VrFaej2QltBDr1DMbERwELvvOvRSmvuWZ76cxdMnaaIzliV/l60mOMKMBeBMHsX+BLDD3vSZxOcB/F0bXV++jN7sNBJoPFWpNynWeksBCSkcw==;5:JTSbYrqhDLCHY3v9uKFSnSEI6ONswl4SYgMrgjYY5BiKK/tsT3rHznhSXJHZURw9gGFSOX6tCWUkFN2kEzkfkVhHEK/KS2Q+bnlqUyzPc5Bixob7Zw0e6Rgt85uqdTMMV1H+1QG1ON0P8GSrMZyGBPNAuEynWla++YwQzPP0TOE=;7:FEQOT2NewDkm83d16mU+AKn1boA1Tj94uXRQqx+klJjImybdLo3Aihu8BFlsKX4rhUMYnNVfN0I3PDZNJzoEvGAMOPhwK+1BcfQ0nPNvN85Z7hkcLlQ5rwNJeZzov50BDQOHF3pq70ejjjgYY+Qh9xSTIwV0XiMALHucBSNRs/xF2UQQFWO7pDRNmpB4v4oSelwTXkOEz5ZKm5u6k7kMHxzpfz0R73rO2QEURTSG13vM+UfciLRp5YsCF7FOwP6Z
x-ms-office365-filtering-correlation-id: a9f17ece-8f15-482e-694b-08d61ea3bff2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB04695429E8BE484BAC4F1A1BFB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(6306002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(76176011)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(11346002)(6486002)(6436002)(446003)(6346003)(81156014)(26005)(102836004)(86362001)(966005)(54906003)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(316002)(10090500001)(107886003)(14444005)(1076002)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: cqIsIdeZHKjUnFnS99aNStm1TLeQg5KevkdHiL3cjGgPYA3B7d+WIMupMmfkBxtsE87g/eHXBmjj3netwdXRQ3BLHOrhQ+5HqEfvHuBzTIbd37Qu6gC2Vs2ABcWUDjESW+GYPD373Nl0d00WCR2XMxy8DeyJr2ZXUjs2QPatUmI3lS+XqxMaZFaLl3P5FmLTOS6ogUGaRSEgFKjGDrSxC1clCjEgpgnR5hZ3LSOddQUbtBLf6jn7T6HtAmYPPdu5J63I8Sh5tpV4JCY0fitgfa/UezbQR0zDUhPnQTbYTM4dpvuEddNHrVU2r9i7bkc79mJtozAPJLG6vhCHRanSKHKYqFNDXoRJPmMsjwGemJc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f17ece-8f15-482e-694b-08d61ea3bff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:51.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index b32bf7eac3c8..73007fc1d2d2 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1403,6 +1403,13 @@ static void i801_add_tco(struct i801_priv *priv)
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
@@ -1418,7 +1425,7 @@ i801_acpi_io_handler(u32 function, acpi_physical_addr=
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
