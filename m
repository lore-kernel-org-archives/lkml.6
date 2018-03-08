Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485110-2-2925951214909679148
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
    t=1520485109; b=O2vGKrLH+zQV8J0bwU5o2e96FXy80mn6cO0Pfih/0k1+GrP
    qisHgTjMJx2LoXicF0YiIItMrmNz5b/mwpgp6A/qUEMyczelvbbJELeyeEf5AE/m
    CR2nLxaaK1MY34KRwxU3eX2kFxyTGJdAvfF0lmvybdA7OiLroegjcsemmgbXKhC8
    SkZ3YSqZWSMYeLUh5t8xa/yq+yrOpsHSbtIbSeg19BeDU3vbo8FzwaAyMljHOTIt
    rjTM4VFmlPlwiAkr1H11mjJYLBo7KqC7AqV7MRA0zPX0MG3PzgzFhhu4ON6iSX2A
    hnSGHjJlNdiAjtvKNnfI7Y5ZY9gbho+6Ud8VjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485109; bh=plMtU7
    X17hriuG/J/4La4ZA9DV9FIO962JiVa2FZubA=; b=LL7vJhVMW94Lkqzeyr9xZ/
    EinBP0/RVY5WDUnaWLZ0tID5rXaw/IHNAUO05O3bOpCf3Z3UYJbiHW0M+7vhwhhV
    3Kz27vnpu1qCs4VDOCUsrGIel0ycedgwK8B2qE4zdV/y1nZRGZ4xJs3zAodTjnwl
    WSVH08MDTqGWUicL+nAUzgczLstLdWbbOiZAjvNUap4ArSNvY75QQNS1pti4KQZy
    NSpWkvix0xmOCcfJHUdN2dtj6JQMxVE11w7c8IcUkCL3s6h8BlcuW4Fl10ciEsQn
    YrD5E/fr54TXQrCyY36Vmq5/QVj9Ti0HgAHMeIXlzAhgVRMKolgnDiObIx0aJGGw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oDKuqnU1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oDKuqnU1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965145AbeCHE6Z (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:25 -0500
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:60295
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965053AbeCHE6N (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 13/67] spi: sh-msiof: Avoid writing to
 registers from spi_master.setup()
Thread-Topic: [PATCH AUTOSEL for 4.14 13/67] spi: sh-msiof: Avoid writing to
 registers from spi_master.setup()
Thread-Index: AQHTtpn6UmDy1mi050+etHEqWe6e/Q==
Date: Thu, 8 Mar 2018 04:57:37 +0000
Message-ID: <20180308045641.7814-13-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;20:N2vq4vLXecSXgJfU5LrEUDNDCXZCjRCez1xhxkhyZplO+ZI0Jo/wQkPOc0/9PFHH9CHs57Qc8Ha9tNPiB8EtROBgXCFlyiixTWFewefwi0ewWjB2dRY2G77tSo3CZ14Q7KqN5Ehacr1pV00Vu9UJeOfdOAVw+KBOR9nUkpPLSwo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfe6db6b-9e99-457c-12de-08d584b130a2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888B8260B0032FA48BC8D53FBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(575784001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ry+Y0HE3jcOo86J/PzphMcHBlGvuwBzWqmGoQX3ZdT6Nu8b+aPcQh2USZOnQDecrN/mo2WcxP/J4WAESzmBKsFm/eiS75bt9JAiUZ0Tu1VitX4NLeHisMAT4uIa1EUBCM91PYjjtKVCWCVA0ZXFitrdeCOjlf6uNssY5HxU0IeefDVWNlo56PHNHnIMIZImpVQopE7kJlo0RTASdL3vfFfWMqMYo5OR8fWXt+/wcjqqXwX911PDpEwg4uOmB4yufVN74MzVIIoSTGoHWIKwwJFJOnvWRHsFEHJU0rLm+a+XfgtNiII2MLYy4vVpY0DTrRqZO2gRmLEo4WQJ1WWQ2vQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe6db6b-9e99-457c-12de-08d584b130a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:37.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 7ff0b53c4051145d1cf992d2f60987e6447eed4f ]

The spi_master.setup() callback must not change configuration registers,
as that could corrupt I/O that is in progress for other SPI slaves.

The only exception is the configuration of the native chip select
polarity in SPI master mode, as a wrong chip select polarity will cause
havoc during all future transfers to any other SPI slave.

Hence stop writing to registers in sh_msiof_spi_setup(), unless it is
the first call for a controller using a native chip select, or unless
native chip select polarity has changed (note that you'll loose anyway
if I/O is in progress).  Even then, only do what is strictly necessary,
instead of calling sh_msiof_spi_set_pin_regs().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-sh-msiof.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 837bb95eea62..092a5fc85b9a 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -55,6 +55,8 @@ struct sh_msiof_spi_priv {
 	void *rx_dma_page;
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
+	bool native_cs_inited;
+	bool native_cs_high;
 	bool slave_aborted;
 };
=20
@@ -528,8 +530,7 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 {
 	struct device_node	*np =3D spi->master->dev.of_node;
 	struct sh_msiof_spi_priv *p =3D spi_master_get_devdata(spi->master);
-
-	pm_runtime_get_sync(&p->pdev->dev);
+	u32 clr, set, tmp;
=20
 	if (!np) {
 		/*
@@ -539,19 +540,31 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		spi->cs_gpio =3D (uintptr_t)spi->controller_data;
 	}
=20
-	/* Configure pins before deasserting CS */
-	sh_msiof_spi_set_pin_regs(p, !!(spi->mode & SPI_CPOL),
-				  !!(spi->mode & SPI_CPHA),
-				  !!(spi->mode & SPI_3WIRE),
-				  !!(spi->mode & SPI_LSB_FIRST),
-				  !!(spi->mode & SPI_CS_HIGH));
-
-	if (spi->cs_gpio >=3D 0)
+	if (spi->cs_gpio >=3D 0) {
 		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+		return 0;
+	}
=20
+	if (spi_controller_is_slave(p->master))
+		return 0;
=20
-	pm_runtime_put(&p->pdev->dev);
+	if (p->native_cs_inited &&
+	    (p->native_cs_high =3D=3D !!(spi->mode & SPI_CS_HIGH)))
+		return 0;
=20
+	/* Configure native chip select mode/polarity early */
+	clr =3D MDR1_SYNCMD_MASK;
+	set =3D MDR1_TRMD | TMDR1_PCON | MDR1_SYNCMD_SPI;
+	if (spi->mode & SPI_CS_HIGH)
+		clr |=3D BIT(MDR1_SYNCAC_SHIFT);
+	else
+		set |=3D BIT(MDR1_SYNCAC_SHIFT);
+	pm_runtime_get_sync(&p->pdev->dev);
+	tmp =3D sh_msiof_read(p, TMDR1) & ~clr;
+	sh_msiof_write(p, TMDR1, tmp | set);
+	pm_runtime_put(&p->pdev->dev);
+	p->native_cs_high =3D spi->mode & SPI_CS_HIGH;
+	p->native_cs_inited =3D true;
 	return 0;
 }
=20
--=20
2.14.1
