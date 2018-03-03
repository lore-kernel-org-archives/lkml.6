Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116447-2-9604756887778514328
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116446; b=LRA+UBBumEUWkflvkk5JX6bc+s+UdQWP3Ac5ggnMQF06qhQ
    QRmrwvoMsoS9scYcwiKJGjUSiw0sYek776vSTMI9WaKnuv2wyDmSdcWKNbdVaWIz
    NEgOg8syjeVABaDDC0xOTN49LEB/5TU2H6I555sU/x1FuctoBS9scqTvoYa0SgfR
    D6MSLd2Zkjn92yPiVf2Qg88ox5MF7RXpA4f84k/gI2JQaMxxma5CbEjUNtVKlIR3
    RooSjRb3lbMNSGjuIzrE7t9WHfZq8suYCY/tG2No+VlZMpN7Qqb847RMgs1TN8Lt
    nWo8VZgFAxw5k4ofsYuUPKYs579ni9aPsIARD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116446; bh=mQGEsL
    AKnkx2E9TgmwaagUNqVQfe4RSfJh6qSJYpnkM=; b=gg0aynxTgcaH5lVwPOghIb
    Z0oT9nuRS2rMDNkQRMOmjdflF/I67BWqtZpWMnR05OPAa0JLXlJJBvHauzrUATsP
    ZjCZBC9bVi9iov/c2+ZfRUEtlfj1OPcOLxyu//J+awSfS0+s8pdfsND68U+4Tuu2
    Uc2Zl8Y+wh62iZI1C3NpOVrDOz3JYSHsdTrJ+whle8QXv/kZU24DTyhhfzU6bpDE
    foROkI/szEtQifbouwGlcgxNzgtbMtchU6BUAjdU4dzQ/ctZeuLCu7ulIy+QmwtA
    RlORZ5fWOt3A8e3yXvLlAXtAMxw1206vc4d5qHaGc9gqPv3RJ8OiO0NRc9UWrQ4A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F0BPpi35 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F0BPpi35 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbeCCWc5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:57 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:47215
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933885AbeCCWcx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Akinobu Mita <akinobu.mita@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 065/219] spi: omap2-mcspi: poll
 OMAP2_MCSPI_CHSTAT_RXS for PIO transfer
Thread-Topic: [PATCH AUTOSEL for 4.9 065/219] spi: omap2-mcspi: poll
 OMAP2_MCSPI_CHSTAT_RXS for PIO transfer
Thread-Index: AQHTsz73wS1mMVgK/0Sk20klUYk2XQ==
Date: Sat, 3 Mar 2018 22:28:33 +0000
Message-ID: <20180303222716.26640-65-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;7:9V2yXBp011rQlk515H0b6lGnsm2t2G7yzNWSzCvTvMLuEtShct+Xgg0qwSm1Y5G/cSAIQCx82QEx8sGVt1RIWQxYnqtcMCUviCE2ER66ZDqW1Cm6jqy5hHC4C8iwFctJ1ntSqoGIUupYTCJiiTuYMJHPB/X1kprUpuNE4RmuCfiQtjQQmK5NrrkZkxtYz5xE6SQycgGEAAdDnxwSEJ8x0CJOzYAtU3E0wITVnRHSiduV7YkpcYEL+okpUrQgz7MW
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7cb0b5e6-fa0c-40ff-9853-08d58156b2fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB109852D78B6105179C8990A6FBC40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(2906002)(8936002)(36756003)(6512007)(81156014)(10290500003)(81166006)(99286004)(6436002)(68736007)(39060400002)(478600001)(3846002)(22452003)(53936002)(8676002)(15760500003)(110136005)(54906003)(4326008)(316002)(76176011)(6116002)(7736002)(105586002)(305945005)(3660700001)(1076002)(14454004)(97736004)(25786009)(186003)(72206003)(26005)(102836004)(86362001)(6666003)(2501003)(3280700002)(6506007)(5660300001)(10090500001)(59450400001)(66066001)(106356001)(5250100002)(2900100001)(2950100002)(86612001)(6486002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 6qyf0U6fR2VQvRBgBtjUCafx023SYY9n15gNVA2/lkHvGTXRW9KDKuIY5s2Ayz0HmtffkoUYdO2YIfafXacbvp3/0VvgVKWtyL26m/BLUnjIgWo1zzRvWu1fwI+cOn2X7FqNqWaicsN+8NSX/JKWQN4DkmIXC94ybF+ctP/ae4E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb0b5e6-fa0c-40ff-9853-08d58156b2fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:33.9631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 812613591cb652344186c4cd912304ed02138566 ]

When running the spi-loopback-test with slower clock rate like 10 KHz,
the test for 251 bytes transfer was failed.  This failure triggered an
spi-omap2-mcspi's error message "DMA RX last word empty".

This message means that PIO for reading the remaining bytes due to the
DMA transfer length reduction is failed.  This problem can be fixed by
polling OMAP2_MCSPI_CHSTAT_RXS bit in channel status register to wait
until the receive buffer register is filled.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-omap2-mcspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d5157b2222ce..a47cf638460a 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -454,6 +454,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
ransfer *xfer,
 	int			elements =3D 0;
 	int			word_len, element_count;
 	struct omap2_mcspi_cs	*cs =3D spi->controller_state;
+	void __iomem		*chstat_reg =3D cs->base + OMAP2_MCSPI_CHSTAT0;
+
 	mcspi =3D spi_master_get_devdata(spi->master);
 	mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
 	count =3D xfer->len;
@@ -549,8 +551,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
ransfer *xfer,
 	if (l & OMAP2_MCSPI_CHCONF_TURBO) {
 		elements--;
=20
-		if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
-				   & OMAP2_MCSPI_CHSTAT_RXS)) {
+		if (!mcspi_wait_for_reg_bit(chstat_reg,
+					    OMAP2_MCSPI_CHSTAT_RXS)) {
 			u32 w;
=20
 			w =3D mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
@@ -568,8 +570,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
ransfer *xfer,
 			return count;
 		}
 	}
-	if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
-				& OMAP2_MCSPI_CHSTAT_RXS)) {
+	if (!mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS)) {
 		u32 w;
=20
 		w =3D mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
--=20
2.14.1
