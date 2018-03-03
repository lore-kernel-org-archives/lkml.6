Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117577-2-10742291983126286422
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
    t=1520117576; b=OdqDGiiUvUHo+lR0tj2Bh3bFwnuTWAAzGtOvWrrR+Qkyccf
    ZIDOq3jcbVp1+OgtgQChvAdlpcv2Mal9G9JMd2Knzs400owP5AK/TxmOy+WyIm4B
    WNehlT+9BtWJPsT1Z68/Ubo0b4LXu6RRfO9Q2IAka5odq/+VlwCo+kJqe7b/E2sB
    EBGk/YFjqCcnFWJuuFeSbOFezCcM5ZGzoAsBDQuMtMTTlQyUn5FUC2lF9US1m59b
    fkY5/klPnXfKpx0Pp3Q3UjfopfLEZ1ZIq/jS/dgljEuGABpb434B1g/jwVJReZUV
    +TX45Qu/SeHyUZhI192l3FANrs1LH7wij2GjZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117576; bh=5dDrWX
    85vmoHSDIa23KmbC/wWVDg4inwT9AGmBlT8AA=; b=fa8TlUGJl8FsVW7WYK7BTf
    sOgehvM58rbisGy+rN8YTCFJMWJk/CVYRyERK9XfHSbg/RtGe4iylYY8f5BNSKZ8
    Hpy2+UqN2PIDD8pxvOmil+GN8qQGK3zeRwlWHWDlnlRMKcmSRQUroESlOoBZjwEp
    Ml/1SE/EdRV5wVHythcEjFKn/ZyxMdAq9gnzBhck56wb9drH3qe8YbygdQqiFAMC
    TeLMFnYYqiiFeHQia8If1vX0o0CfvkHQKCo2gSSOQIe6bEpzm5jUEcKa5fH5FUOU
    f6OQZ6TGR3O2qT6Y7EYn+8XLNuLM0/Oy0jnQSVXWl2EOmOwZZ1F3V+ycuTGyO6sQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rb0Oy1g1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rb0Oy1g1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935176AbeCCWwY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:52:24 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935423AbeCCWlI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Akinobu Mita <akinobu.mita@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 19/63] spi: omap2-mcspi: poll
 OMAP2_MCSPI_CHSTAT_RXS for PIO transfer
Thread-Topic: [PATCH AUTOSEL for 3.18 19/63] spi: omap2-mcspi: poll
 OMAP2_MCSPI_CHSTAT_RXS for PIO transfer
Thread-Index: AQHTsz+hzryBAtC+s0GjuXPJ8BBceg==
Date: Sat, 3 Mar 2018 22:33:20 +0000
Message-ID: <20180303223228.27323-19-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;6:UnS72QnojW+bz+ZDhx3BDrMaTaGFE35bK+qYLXn1R9fxUKNtrSkXxJrjmnxKc86VS8jntZcZ0eZ0gLMwKC+9Yzmdmm6PI13R59yroPGfaSMkCYeyKryIyfutXt9gdIK2o7F/yC1VryQG4PYcWtIMrTs8WTWl1gA8n7EGumeELpdlroSwrQBAVb6aW2yWxhuOQOGnukwIDIdb3cXzq1RWdM5Kq8+FqAYkBPpnJAH34GCExP7XdsoDV+PIXHgJ8PXE7BoW3mHSDBaFr0qBzsGWnrJPuJ6X9HAsEuJgqhAMxCbaxmGGXq2QcIb7fdXS53TDPYNj5240GwOMo7hFtMAAqrGZvQwCCtyKx24bo5li05bexKlJcnGv7aYCKNXEUzaE;5:GgSALj0k7ESN9XQI36feOFiLsa2LNKsxQHMHc8UE2hD/2HtqEPjAikvrQVzw2cLeC9WPz5tC7UvyV8NyC0Y2cKCaXQaju8MRNksKGNT3Z7Yc0olmcs+gqvpYDOUacCk5wo6HFw+hTJmqJI/zJaBnBbN+UgyjEUmmRT1Yn8cHVAs=;24:xQDsLsZ3buH6WhmNq1BgLau7x1c9RsmUFk08B3RuUP9WKxFderlMr8D6H4KnrV97JLeo+39aex5Iv4+EZmWb8LgMi2DqkvQSxSeVUXdFx+0=;7:ubb/Mcw4NC5SlBhqXUchvX3yP2+byuxsnfvQ0eTOR7lyzSwGeSbbxpRQXU3awEz3zQ3MqYoNv3NdG3+XL1MzHGAIoc1G+bqi6UuQr3MYCXI0fwpJiFPXAkwROV8uXCtPeNHyoXln0pbXldbopD+4dUzcgGwdfvOUAhOyhqI5+el1kS1Uyj9kmwhHB1IY9HLXIF07cD9frDy7z1zrNdzElhEeWKI7EHnFuM+KWyKARe78+/WJLwxnk3WIJqHcuHjO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f66be878-0f2a-4e08-850c-08d58157d971
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09403160AF5685D01E5387A4FBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(39060400002)(2900100001)(316002)(97736004)(59450400001)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(15760500003)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: E3MGE27Kw+jVuGwAbZX0D+vjsvWkC52xDuozr94DfTaLJwzEmWK4wRxdAuFMOowruQIc6Tp+1wkqI8+eHNqr4+D6X5eAvXVHXXondQA+s4id4BUv26QxfxSskumXsctaekqDQd7gCC8tjC64xmwVtfFlgx/UQqGGVTxap1i+EwI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66be878-0f2a-4e08-850c-08d58157d971
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:20.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
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
index 352eed7463ac..7f48cb57822c 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -441,6 +441,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
ransfer *xfer,
 	int			elements =3D 0;
 	int			word_len, element_count;
 	struct omap2_mcspi_cs	*cs =3D spi->controller_state;
+	void __iomem		*chstat_reg =3D cs->base + OMAP2_MCSPI_CHSTAT0;
+
 	mcspi =3D spi_master_get_devdata(spi->master);
 	mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
 	count =3D xfer->len;
@@ -501,8 +503,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
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
@@ -520,8 +522,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
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
