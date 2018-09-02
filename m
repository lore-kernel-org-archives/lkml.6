Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655C7C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FF5204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="k4kenb74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FF5204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeIBRXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:41 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729415AbeIBRXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEjb63thZGdR/7lPbJcxES4cFxgOApFFnWtR84K3lWg=;
 b=k4kenb745dVL9jcQOAHEcrtCW+6+3sxJx25+q3oOaYYz5RYuL3zA43uw1H/8vfuaWXiIwtLXn9Y1UxIXO7QOxYLR2S8P43GD8ggShUp49ZpkDgovx8+n5KF9QF0baCk+4GZ7enqowI2BN8PmiozjqGyWOWYQ8LvpWLOI6GfDljw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 57/89] tpm_tis_spi: Pass the SPI IRQ down to the
 driver
Thread-Topic: [PATCH AUTOSEL 4.14 57/89] tpm_tis_spi: Pass the SPI IRQ down to
 the driver
Thread-Index: AQHUQr3htuNG/5fCWk6/7FBGlmrVZQ==
Date:   Sun, 2 Sep 2018 13:07:19 +0000
Message-ID: <20180902064918.183387-57-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:vOEtARdN6ECiVp10R1gM9yAQBiosa2pN5v1F8hlfQ1bvexoHJfl30tXSzx8Tyi9OemwAJP2cBRa7Fo/OWI9Wr1PpZRl3idDziliRuCXnHeb/SD/GvMjS9f5eX/MUhS0t60VVROq9xLiBSxDN6g/3l7PPcRZhlINfqrMiDYit/G1+APput1wg3IwqT91JzX3B2zwBQ97o0RnGSvpSGwNF9qVfgyvBs42hrXo8fJrwzmwzEJp6Lc1WKevd5FISJXZXmFyK+LG3E/rbkkMgFguRiemoDG5Zenpw87ITcX5TCdecFNtYEEal8xuJjLaabqdosRiwprLl5zn/dpPtuigv5hmCsj/h2suE4pwCG0Xjd1y87ZuX2ZgcRYS5ou65/FT8IhD3jhkuRR/GzdY8d2SID1VIzx/FK9HjTSLfmDRF+8KqVWZpSie1ijTK0unx8tRLvCdKlhmQ1yDIymtklDFQ8w==;5:iKIGJE5O1u00pQRRRpP+Z26eWGTu0UEdg7JHxW93uzNHbp3M3PXUL/o8yzX/fRBoKsOlEsTFGCB58VkF2ybamM5Ih6zTH6bDbkwqSl47SW5aO0nKDywBTdUktxR25wXTOM/gPjywEFpJn7iq2KWbYMhvkiog+8vpnxZH46cmrvM=;7:HBQczZcbNUV1mkpDnEhC41V8zA4E9a2wtLam3EBJkZPqVfBW7V8IbseM8DHVE69b0LK4C+ZHZhfXU6bFZcnGA1nKe6U5Zy8o2xWzXilT1Gr+mQv2ypSTWi4Uehx+QmNvjKS+9GsDwdVqoi3aZgLWXLbaBpuXCSc1BssQR4GjEUGtNKb//3gEjrEpkR0GC4HLg0vIqXJ7rABUzO0qscmrGEUyM0zgqde9sckgBHFeC6q86mHRPgByohTqN8/Kk5pG
x-ms-office365-filtering-correlation-id: 3aa0de9b-bc53-4a08-f582-08d610d51442
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503CA9935F4583713CBE05BFB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: fnH7HPcF/S7oG9qDd5plfzopVQmgfzZdZaodgY/fpbvl9PLw1znq8l1RIKutDxE5G2rK2m+/inBFEXQpfFoTyMYa/tqgN20iw5FY5j+UN/5KCTpWa7Lf6XHOT39kAyGfsEUX3kPSie89GAkNHwAyppESDkkDGfaxOegCkuD1oMfNONLsN2sg6/aE2T4aH6sXXMX4lT0oQcQEbGfC1hdHvM/5A5jU8akF8y/49RzJc86JOy1i0FIdTV+f4MOmDFAZcgsAOX3YLRb7gt9yE48JtwjO9Qdjh9/yExjVbpkgUKNbcdqfSu9zVTv2Ib8CDa3oGLhwnvkyteGW/MaKflHGek8PF9sS2h3LwBvS8EcbBxA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa0de9b-bc53-4a08-f582-08d610d51442
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:19.8746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 1a339b658d9dbe1471f67b78237cf8fa08bbbeb5 ]

An SPI TPM device managed directly on an embedded board using
the SPI bus and some GPIO or similar line as IRQ handler will
pass the IRQn from the TPM device associated with the SPI
device. This is already handled by the SPI core, so make sure
to pass this down to the core as well.

(The TPM core habit of using -1 to signal no IRQ is dubious
(as IRQ 0 is NO_IRQ) but I do not want to mess with that
semantic in this patch.)

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/tpm/tpm_tis_spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.=
c
index 8ab0bd8445f6..b00388fc41c8 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -188,6 +188,7 @@ static const struct tpm_tis_phy_ops tpm_spi_phy_ops =3D=
 {
 static int tpm_tis_spi_probe(struct spi_device *dev)
 {
 	struct tpm_tis_spi_phy *phy;
+	int irq;
=20
 	phy =3D devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_spi_phy),
 			   GFP_KERNEL);
@@ -200,7 +201,13 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	if (!phy->iobuf)
 		return -ENOMEM;
=20
-	return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_spi_phy_ops,
+	/* If the SPI device has an IRQ then use that */
+	if (dev->irq > 0)
+		irq =3D dev->irq;
+	else
+		irq =3D -1;
+
+	return tpm_tis_core_init(&dev->dev, &phy->priv, irq, &tpm_spi_phy_ops,
 				 NULL);
 }
=20
--=20
2.17.1
