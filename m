Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD85FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F53821521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e5RI60MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F53821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbeITIbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:41 -0400
Received: from mail-sn1nam02on0096.outbound.protection.outlook.com ([104.47.36.96]:62018
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388611AbeITIbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6slep5d96isw5x9TSDL8AHqXjSA1CNO87UGxql82f8=;
 b=e5RI60MD9NN25wZFB0bCSOrMAaSPLVhxo8SMwwFEEA19K/w0dtby2EqEA0uWTUu1jc3f7t8P8HSMIkdr/gyICw/n+IFAwu83VNvFeGKi3HmqcYLpFiTBuC+QJhAW5S3D5ntNhF/BLgDuxHhUB4X3/7aMJrvW2Y+bslafprt10TY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:50:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:50:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 7/7] i2c: i801: Allow ACPI AML access I/O ports
 not reserved for SMBus
Thread-Topic: [PATCH AUTOSEL 4.4 7/7] i2c: i801: Allow ACPI AML access I/O
 ports not reserved for SMBus
Thread-Index: AQHUUIyTo364Ktkr0kWsug/RRAzXhw==
Date:   Thu, 20 Sep 2018 02:49:40 +0000
Message-ID: <20180920024932.58727-7-alexander.levin@microsoft.com>
References: <20180920024932.58727-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024932.58727-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:i0YgLBpJGRV5O6Z083tp9d0PcLU8XcWyHlU2+2VUbk8a8R1hRccqOIgZ+QP16/s6WoMHvHVqytCI0ODst1RKxrnZW6Ro/dXm925Wbo5M06HITrx+8TXY1TYe1kUHXW5Y0IAII1jlBe3d78/ZEkzBjfaUvcOZ5ssW2X8IbUK4pOX7O06lG8QWT/R8e9cIVNUJaTd3Ow/f4t7kLK++JLI1JcsWL7gsJWt6gjP4LvVXscsDZFPM60S23N3m0ewOVu3pMGKejGr/nTwk7UdF3YE1LwWOITCzY1/2ZVtEKBAD6BQ5iO78swn0JEnwrdnyZyIFMu873ANQoe3pgWWYuizo/NCUT58tCLtkOSBbFkidsF+2hQhOmk0+tnCP8woWsxDIX10oqa7K+P/qUoYOVrb+6MT4gbMvI8UPbHklG21uRlDw6rpH3A6Pq9bLbjRdvzdiV4GXZ1zPU4HYzUYEdOObWg==;5:D6+XXQOFSycQhWqzUzZT6hC5WYY6yPcM0N5McWjz3MuUYA6AX4yMgmOFq8MZVdVHyVFFwipJKrseJSkXsnpGK4gFpeh24Mzgun2nIBYdu6UP5kfBTYYQZgVNhUEUAKyfVkovJgwkxWRwkS/oU6oKMRPUsOZFl/Hozh5Adtuh/n0=;7:N9IWxndkBZwhT/hOCQCO1Vdq4TpLQSbY4/tF9tN7f8ZCibzPBkrBrrukqZeIybcFLxKc8ytz3QrvhUne4hYnkpYwbv44jPCr+cddZAKaVnnnic6//Ij2TQ7tSA9x1i6tmraiUxQ45qW3RDa75YJzyaf4vSW9iVZmrcKDmfab42VOhimK9f89H3r+1YThxD0+K11pF3SV3j1RFatWF1v8JBkMBTYNozrbUxRwbXPauVTiqA+iOJtsllhhPEeB2E5f
x-ms-office365-filtering-correlation-id: 63dd1807-6c88-4078-eb60-08d61ea3c6d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855A9DA8CA6AB28F7AA0A45FB130@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(2501003)(186003)(86612001)(10290500003)(478600001)(2906002)(86362001)(6666003)(106356001)(3846002)(966005)(5660300001)(2900100001)(6116002)(8936002)(105586002)(1076002)(53936002)(14454004)(7736002)(305945005)(81156014)(81166006)(8676002)(6512007)(6306002)(68736007)(72206003)(6346003)(107886003)(102836004)(26005)(14444005)(256004)(6506007)(36756003)(446003)(476003)(2616005)(71200400001)(71190400001)(486006)(217873002)(66066001)(11346002)(97736004)(25786009)(22452003)(5250100002)(10090500001)(6436002)(316002)(6486002)(110136005)(54906003)(99286004)(4326008)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5fajhNvb4kPOi0uzASWys6Nj2iMTe+DGcoJLu2r1c4xbDC9CQ3ar6MGEzu8tGmucMZ3bzSpCK8dEnfJ2CQhL02qMX+cUUcOCovX3oZ7jxh8MG171Cw4keKn6SLyR0ovpRD+rgeY8cOAn2tJqZJQFtvTW2LR0Xxuu73UuPtWsQM2pGz4KSEyA2BdOW1NhSaM+0ADe0HaCsOCFR3P1F1lLgPh96mYIe2SXj9ZCtnDGCb13tC/U3wySewyZ56Lyx7Cgy25HQu2QkcM7f7Yzk30aAeZm/WBeQgmGs4azTow8D8FYz/+K3zA1TDc7L4Cs9FCGFAq1Al83RsZUEyPHRYirqRZAnSoTzFXdDgYdhaRgjmY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dd1807-6c88-4078-eb60-08d61ea3c6d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:49:40.2249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 85f39cc3e276..675d634c13d0 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1267,6 +1267,13 @@ static void i801_add_tco(struct i801_priv *priv)
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
@@ -1282,7 +1289,7 @@ i801_acpi_io_handler(u32 function, acpi_physical_addr=
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
