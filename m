Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122213-2-11993819348398469540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122213; b=bslXhLQWS+U0fHneniu3+Q6IV11F6vMtcfq/MyjyCLIUKWw
    1d06uF8jcEX9SNKxBBNeGJ53bauXyEUT1KZVur171rlSsnH4x+F4ohJltpsMk/zD
    1hmnBJFkTyFokJL903W637ss90Dmg8aoKTCKlOF1Jo/w7UQjqICmP8FBgfHstO9d
    3n9a+jHqNtKsAlsn8go5I46Ro2dK1Gtj6JLmwoYgXYv/1Iisu/IripD+BLmFe1z2
    pHdgDy/eM1x18joXg70YkB+1/KNEPRLROg0RnsR9BNZ1CAMSyx9bHNbgzPJLR8Cb
    3E0UBOnUXVbLFTpEroHLBs05hgQnmGb3hSrL3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122213; bh=rO428k
    sEIdIkniavpC843ct15S44NgYlD+WTxR2NeME=; b=u3Z9V7PSZxrXdbc0rxUgV2
    PkLXFmY/ykRHU/8o0ASut04fWHlXmQD6ZMwMZ4bFPnwUVxsD/2WGq3q2ehciMr7W
    U5QBCr2NRp9Dzj4W6QrAKZjoYUhbbfcabQDyaMEe729v4XOdXqclplxzrIdUncTL
    nB/mkZcRFM1q5HTpyKf9bLxQoOvaBXlfLzy77GYL/oXbq+TRY1oz52HflDQ1k/85
    YwUmEgV0A44STyjqrLV/jUBm47eusZHgeD9H3VjVux33gFwB7v533XAsvHsoKBLW
    1Iw/vZ1Oikj0rJQ2f7FMYh09oKNa32zzUddeW6uwmDfLcD7TDEHawNRNc/eL0MLQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HtaHY6e2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HtaHY6e2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbeCDAJ4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:09:56 -0500
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:51749
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933324AbeCCWbA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 002/219] spi/bcm63xx: make spi subsystem aware
 of message size limits
Thread-Topic: [PATCH AUTOSEL for 4.9 002/219] spi/bcm63xx: make spi subsystem
 aware of message size limits
Thread-Index: AQHTsz7gbxq43L/790e5qAZ18oup4Q==
Date: Sat, 3 Mar 2018 22:27:56 +0000
Message-ID: <20180303222716.26640-2-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:73yaCgLl+9W6obF6uu7GUBg3fuqlYxY0B4mTCA+IHga358APYQwl6EBTezZ9CMOIEYyniY3eGpNAYmDRC9OX+Ka1iWOymyvaOhd8Lb71eOtN45xVQkxF3r+6kWwXOXqDTuCC0xsaQgNkFZ3XhO3mnfpj1sJp3gAGTfV9jYl2eHqDiRjY+N/qNX9f8JGgzvroRYL5LVo7vyrvegStr+CY6n7wr7q9dMarViSbqez8dTi1ebEjzEtjdJBj8i7D7omy
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93ea2334-f41d-4bdb-7f07-08d581566e44
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970FDAF999674C2054DB19EFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(39060400002)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(15650500001)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: pcLEJnEQPj9+/fj1ESvnTcaRjPSc4hXIqrFh9bw50WtKDebdWZfwlQx8PfuO4J4iH+6OY6VUJw41OHzCo4rccUk+GJYDuaSn4x2uLfFMma4K1pQYd6ZTDrlU8TT3C/BSAoHg+uZashSpoR2fJbS8/5JKR+2mcdpppIEwfB2nxd0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ea2334-f41d-4bdb-7f07-08d581566e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:27:56.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 0135c03df914f0481c61f097c78d37cece84f330 ]

The bcm63xx SPI controller does not allow manual control of the CS
lines and will toggle it automatically before and after sending data,
so we are limited to messages that fit in the FIFO buffer. Since the CS
lines aren't available as GPIOs either, we will need to make slave
drivers aware of this limitation so they can handle them accordingly.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-bcm63xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index fee747030ee6..caa733ec405c 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -428,6 +428,13 @@ static irqreturn_t bcm63xx_spi_interrupt(int irq, void=
 *dev_id)
 	return IRQ_HANDLED;
 }
=20
+static size_t bcm63xx_spi_max_length(struct spi_device *dev)
+{
+	struct bcm63xx_spi *bs =3D spi_master_get_devdata(spi->master);
+
+	return bs->fifo_size;
+}
+
 static const unsigned long bcm6348_spi_reg_offsets[] =3D {
 	[SPI_CMD]		=3D SPI_6348_CMD,
 	[SPI_INT_STATUS]	=3D SPI_6348_INT_STATUS,
@@ -541,6 +548,8 @@ static int bcm63xx_spi_probe(struct platform_device *pd=
ev)
 	master->transfer_one_message =3D bcm63xx_spi_transfer_one;
 	master->mode_bits =3D MODEBITS;
 	master->bits_per_word_mask =3D SPI_BPW_MASK(8);
+	master->max_transfer_size =3D bcm63xx_spi_max_length;
+	master->max_message_size =3D bcm63xx_spi_max_length;
 	master->auto_runtime_pm =3D true;
 	bs->msg_type_shift =3D bs->reg_offsets[SPI_MSG_TYPE_SHIFT];
 	bs->msg_ctl_width =3D bs->reg_offsets[SPI_MSG_CTL_WIDTH];
--=20
2.14.1
