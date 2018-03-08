Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492922-2-18000530950620958452
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
    t=1520492921; b=QZ9sNr/Wf42U/GTQmr0JofLnhcITXTAW7BgMIC8XRKiM4X3
    /5WaqS+0ZMYRUOJtXgzgQztfuvhSKIz0tf/tMfPj1JXM8EQWCY6psCBdTZmY9IrB
    Rr1kzkyvKsN9/+f4H+OAs5wHSUnhG+8J5bVUn2EQ11nsIdx3Gnkatrg+gJood926
    59EHajX3euSYpJ8kBZxFcnKF+3j5vrXV+9iJher1jf1YVbq3zvTsOObPexV4dI2Q
    ix1IQ+sQUaz5jrropoc/FN5mn/XvvLPGu8+NYBNwvpg1oIavFBRpKLbuJfW+B5Hd
    8xVlYLWZS1I0yl0ke8og5kmm/tguQtmL1IGD4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492921; bh=DcbIAV
    TqW7y49fDjNuzc88QomLIUu7t/E6+7YN24nkw=; b=wws+nvv65jadiU52jyZPeb
    vtYmezO3o8Ovb/bBTp6oG/PrLCoNN055jfyPIJC+rAEKZmEG+y8y/Hqf2luKuFUS
    iYe009eIhfYLoe1dd5PB6COmOp5dGDqu+yDK7xHAFRbu02lPsyPvYni9jrQCEb+I
    JIoK7PI09PvWkZit9QJQcwTwaAuQoLbBfGXNcEPdOPU6RyMHm1z83pgspf9U1ANY
    CfTtZHLsPDBstaiEqjwpcQwBKBfQBhV2IUuToBOK8LZqTGzHvN+3VdXQCd0qMGkU
    iEmmYwIUoTEUXky4QRvd4nquuCQgnvzVbY4LMePtnprlzvVujtaYBjiAoZi4bYiQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gKLIc7Ak x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gKLIc7Ak x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964971AbeCHHIi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:08:38 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:1475
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755009AbeCHE4R (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 17/78] spi: sh-msiof: Avoid writing to
 registers from spi_master.setup()
Thread-Topic: [PATCH AUTOSEL for 4.15 17/78] spi: sh-msiof: Avoid writing to
 registers from spi_master.setup()
Thread-Index: AQHTtpnFhHMHnLWLZ0OiZpRKfpEY9A==
Date: Thu, 8 Mar 2018 04:56:08 +0000
Message-ID: <20180308045525.7662-17-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;20:wPyRiG2hdrrTFC/ACWV86Ccolnq5aqmZeshJfU8CbDzUACC6SRYGZxDK2krAJrEuWRm8o3oaiLg86lYkMWVnNK4X2LPpD5oioDEhSKU9oacVKWawHfScRahef0TTRpBTAQuKVzgdwTVdYjOuBmBtp+LmumG3nKkF4c/zthddqbI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7995b04d-b7a1-4785-691f-08d584b0eaa8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1111A41294BC38886300B567FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 6Hmrg7U7DxIguYGSegcl22t4ic8lI3ud0yIl8lv8WiiwJjs0B+Ke0kcl1DWujuByggGkGUkGUplsEBIjo/UnBy42nMDYSC07IaJVsuwuxj3apGGSctqH0TAckh2R6MZ8ZpRWpo+HWSOpYX1OhqX6ysPHbD+dPCHGx+xnC/n2jYLjETPgU/+GgAniaN5LBvQ3zKaxBniCFXfH5pLfTIz/2av2SC2ntyu82DIq55Np5i2jh6OexnvyksEAroltgG/eXYTovKdaF1kexvx+dHy0zg2vexGd0CG+6lCyEcFCuVWYJyhdpMGyg7WX7G/WZk99qQhmLWNDFm8biZh2C/VAwQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7995b04d-b7a1-4785-691f-08d584b0eaa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:08.4538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
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
index fcd261f98b9f..bf34e9b238af 100644
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
