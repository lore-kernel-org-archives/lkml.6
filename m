Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239744-2-8895111635356159447
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239744; b=aGJZ3tWLpf9hz3xk+nHHH7p4hDSGYpRapWiYbnNCuVhxrFatrb
    TmUxydWYTAizkTTk+Z8u59CEDBpkqc2lB1pYHK4sP/wM0RYk09Y9iZTpQyX8Nu8f
    M5cbt/NxJZkz57bkFbJKVBLjRyogKBqcQuUihyqWkd8ifHdsMPafUKtt+NnUcpTs
    ClL0fglpMVc8M4HiHKl2+4W6S/rHjYK7OYjz0T/pd8svPU7Tl4u67BaW9sAIhFgX
    qbdLMEhedm+n5zWGCt2mtm/FLRh1rOT1vqLTD6Ldlqm+fbyzj9kQ9fscmJpqpdXx
    ZHJwxCFebrECQ0/rQG6uOJl3Wjge1xRmfObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239744; bh=PYBHjBkGn3
    5hsgeEwXaS9BTSvKx/fn6CeppyNxpB0Gk=; b=pcASTmE3/l3LT8Eqo+ctLe2mif
    1INVJJFYpB2Ib1jh4Yow57gIzqpOCYve0fyEHHmISaJNi/GpiQrZHPtAkuNOc0lH
    kPAXP10cLvRhDMQd3hZR74tYqgtKLlSGQIozIJbSMybGqCnDozkH29cEWbxYWDjH
    hi66T8AboxbvMZT5B9aE3fQjtdx6+bYb3aYsmgh/oJaTsG36ykPUcAA7uTbuszwo
    6HpLzmKrKbuCtOPQybsN9nT3Rtj/hQoJRL9aIW6D1gn7XCuGUEXUJa+4/4+XJWCQ
    +QpXRSF5xr8EtoZy8QhqOiCZ2KpLN9+nOFCmz4AvOWSf2ZZs+0b21eaTY+LA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BPSYrUv5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BPSYrUv5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLG+n7f2rw9hxy1gFG2GxoKzQbrVObWqkwLeajOfEPboL/2gM2n4/as18/SO1vPJgsjCbe6GSnzz0ad1fdhBRhYMniY/ODRBoRO27Kbef/rkTrGt2idR
    LK5Qvr8Nvtdg+SR5FtqP0ckNffrFql8yQkIFrYq6tbPXPmgW0IRTP2SO8CzvRIJJ+MulY+cDoeW7DqznMnxhfvgX2XwJ+EtpZcQXgAUPpQ0pUnu8HbrinyK1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=s8YR1HE3AAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=9FnN3P69ahgYoadm5VAA:9 a=P5dES8liNZ3ZV5fP:21
    a=ieHIWiiV_Q6btQsU:21 a=wPNLvfGTeEIA:10 a=jGH_LyMDp9YhSvY-UuyI:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756257AbeDIAbW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:31:22 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:54752
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756251AbeDIAbU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 166/293] spi: rockchip: Disable Runtime PM
 when chip select is asserted
Thread-Topic: [PATCH AUTOSEL for 4.9 166/293] spi: rockchip: Disable Runtime
 PM when chip select is asserted
Thread-Index: AQHTz5k0KqXsMfmBHkGW1fg4xq/13g==
Date: Mon, 9 Apr 2018 00:25:04 +0000
Message-ID: <20180409002239.163177-166-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:+nmsKE5ax+Ofn2N0VWLMZc0ZRt40E6SXmEq8D5t6iUJ0FZ7HxGS4BGdCyjnPjRcKHpa0nfq36EBeTCpUhYtoy4GZ3tr538DvijfPZLp5P/rwlCUxSxm13foMgPz52hemGDzohaeZjGYUFmREjYFT7sF6cfPqD98sFuyEUfaSlGdfs+sbOq48ZBCyJ/O+wwuRcSCzqV6TNfizwCty6rnKgNimpCsIocK5Wn9oxKgPb7bz6Q/MU0Sal6FPtUTFTONB;20:b+yN/0RNZUJEQo+T58EGV+LnEnwwner8q4GyylroxY+7rogPuxsJBbb+D7mvA49qYNLf94X98cry4yM3q1HDljybymkwzC3WYiFqjEB3/fVofdLZNPojuBsjQGVyV5A80Ofi7pluqvJW/sbQDZjYbuxexzyqsr3tnPBb0uMQek4=
X-MS-Office365-Filtering-Correlation-Id: 1cd13ae6-061c-4269-4d2a-08d59db1345e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091792D2B101237959BBBDC1FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RM6126KI87ngBaXxcxuaA9ry8P1Fdqtk7aJX5kVS4jGu65fGWm8E3+bQtTnxO9oSRcRE3c1eA47ysvEpaWO+ywqiZxw1ziNW3MSOY4TL/hf+mGD8tleEeJw7gmHn7Zk+4pAkkt7Y+OeWuWP3L43tWR2/mcMtOVVig8TrpxCG86IeHuWNYnWw0a0oN+r/XIi5zdOoRtf2qQmIUKnR5SCFMwzmOQfOj1V1uK2HFSvH1E8Kj3sLpa+iMWUd4KM4sppR3nosWKs0PE8+kpIOcDbtagsBVQeGz1po18Sh1rmvdKbX3jKzhw4qhnEGLiXIN/YxFIKTY6x0D6o+bKmHOdBKIjXgmtktMqwl44trKZt8T7VeglCpibVWrU8xv9q/WUGLmj8rxa37Ofm9tWfhomqOz3CTGLXlcat04aIu/FF9Dt0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd13ae6-061c-4269-4d2a-08d59db1345e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:04.4720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeffy Chen <jeffy.chen@rock-chips.com>

[ Upstream commit aa099382ac0cda27e10fa8f45bf91edea0d1d35e ]

The rockchip spi would stop driving pins when runtime suspended, which
might break slave's xfer(for example cros_ec).

Since we have pullups on those pins, we only need to care about this
when the CS asserted.

So let's keep the spi alive when chip select is asserted.

Also use pm_runtime_put instead of pm_runtime_put_sync.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-rockchip.c | 51 +++++++++++++++++++++++-------------------=
----
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0f89c2169c24..c3648397c082 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -24,6 +24,11 @@
=20
 #define DRIVER_NAME "rockchip-spi"
=20
+#define ROCKCHIP_SPI_CLR_BITS(reg, bits) \
+		writel_relaxed(readl_relaxed(reg) & ~(bits), reg)
+#define ROCKCHIP_SPI_SET_BITS(reg, bits) \
+		writel_relaxed(readl_relaxed(reg) | (bits), reg)
+
 /* SPI register offsets */
 #define ROCKCHIP_SPI_CTRLR0			0x0000
 #define ROCKCHIP_SPI_CTRLR1			0x0004
@@ -148,6 +153,8 @@
  */
 #define ROCKCHIP_SPI_MAX_TRANLEN		0xffff
=20
+#define ROCKCHIP_SPI_MAX_CS_NUM			2
+
 enum rockchip_ssi_type {
 	SSI_MOTO_SPI =3D 0,
 	SSI_TI_SSP,
@@ -192,6 +199,8 @@ struct rockchip_spi {
 	/* protect state */
 	spinlock_t lock;
=20
+	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
+
 	u32 use_dma;
 	struct sg_table tx_sg;
 	struct sg_table rx_sg;
@@ -263,37 +272,29 @@ static inline u32 rx_max(struct rockchip_spi *rs)
=20
 static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	u32 ser;
 	struct spi_master *master =3D spi->master;
 	struct rockchip_spi *rs =3D spi_master_get_devdata(master);
+	bool cs_asserted =3D !enable;
=20
-	pm_runtime_get_sync(rs->dev);
+	/* Return immediately for no-op */
+	if (cs_asserted =3D=3D rs->cs_asserted[spi->chip_select])
+		return;
=20
-	ser =3D readl_relaxed(rs->regs + ROCKCHIP_SPI_SER) & SER_MASK;
+	if (cs_asserted) {
+		/* Keep things powered as long as CS is asserted */
+		pm_runtime_get_sync(rs->dev);
=20
-	/*
-	 * drivers/spi/spi.c:
-	 * static void spi_set_cs(struct spi_device *spi, bool enable)
-	 * {
-	 *		if (spi->mode & SPI_CS_HIGH)
-	 *			enable =3D !enable;
-	 *
-	 *		if (spi->cs_gpio >=3D 0)
-	 *			gpio_set_value(spi->cs_gpio, !enable);
-	 *		else if (spi->master->set_cs)
-	 *		spi->master->set_cs(spi, !enable);
-	 * }
-	 *
-	 * Note: enable(rockchip_spi_set_cs) =3D !enable(spi_set_cs)
-	 */
-	if (!enable)
-		ser |=3D 1 << spi->chip_select;
-	else
-		ser &=3D ~(1 << spi->chip_select);
+		ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER,
+				      BIT(spi->chip_select));
+	} else {
+		ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER,
+				      BIT(spi->chip_select));
=20
-	writel_relaxed(ser, rs->regs + ROCKCHIP_SPI_SER);
+		/* Drop reference from when we first asserted CS */
+		pm_runtime_put(rs->dev);
+	}
=20
-	pm_runtime_put_sync(rs->dev);
+	rs->cs_asserted[spi->chip_select] =3D cs_asserted;
 }
=20
 static int rockchip_spi_prepare_message(struct spi_master *master,
@@ -738,7 +739,7 @@ static int rockchip_spi_probe(struct platform_device *p=
dev)
 	master->auto_runtime_pm =3D true;
 	master->bus_num =3D pdev->id;
 	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_LOOP;
-	master->num_chipselect =3D 2;
+	master->num_chipselect =3D ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node =3D pdev->dev.of_node;
 	master->bits_per_word_mask =3D SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
=20
--=20
2.15.1
