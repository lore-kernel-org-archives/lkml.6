Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116747-2-2696272401326488229
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
    t=1520116746; b=JWvWR3ei5AgE1dBKeqbhwmtwLvnSzjCu5wKc7XCMGviZ+aE
    FGqtASuC/APEsNPIdPzQNT5BJymphVXWjCD9h3m9CXhk559ZzuvM6YX1c8cL1Lz9
    jh5aitb1yvUUcKRlSQCijaKKX88/OSt2YHp0yNFSZno4gLBiVzYtHVO+cbCSATED
    LyPCoixDz9wIYIMBrK3DQvOBuM17QK+Deldkg+zlD1nkJWsS2R/+2OUZ70A0HcZ/
    XPi8+HuEXdfbJ/N6CQOtVMcph7VU3sTCM5jrLtsI4j7joD5YW9vMOpsUEwy+S08A
    gsBV1pakmQxl4ccZ4LijkkCcmL+LGi+sjms0ZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116746; bh=/0GAmA
    i2oC7XJanbjgwZsisTF1WsIk4UrDmCoSyhsJk=; b=VoY1aoT1/6RPjodE40LpxY
    yAKFec+wN4le94nt3AutpQ8M8EAVxpJoASFH+gkXUCqPT9rTfnxHOPs9f2HRKcVH
    ai/gnzGI18PVP8D3jaB+q/8EfaEbEsJbJag+jFBY4hwto2kdivgBXBxgulEcAH+T
    W6QbS2OMuatyxZYwr/rnJdLJn+Ktuls5fNZ5Mr7LeKLexU98YF5lpCLHJdeLk9/J
    YnzoH1rVV5CXva0OTetH8SEoCoRTvnzURojRHnlXpvhTKIm64eRuKRh106nQXKgn
    fzUlifix9llYjfUKp4hT7mjXJSYEbibWgTwd4eLvrgkxCD4AQ3T2FujjCCoZw97A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AEQP+Hfo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AEQP+Hfo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934395AbeCCWjC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:39:02 -0500
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:20871
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934392AbeCCWio (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Akinobu Mita <akinobu.mita@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 032/115] spi: omap2-mcspi: poll
 OMAP2_MCSPI_CHSTAT_RXS for PIO transfer
Thread-Topic: [PATCH AUTOSEL for 4.4 032/115] spi: omap2-mcspi: poll
 OMAP2_MCSPI_CHSTAT_RXS for PIO transfer
Thread-Index: AQHTsz9S6raZnGZhsEeNuo2TkYJq4g==
Date: Sat, 3 Mar 2018 22:31:07 +0000
Message-ID: <20180303223010.27106-32-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:PJCaa/wFmyb0JIYdNFEmsKYhEe0RAwMTMRfUP9Ov8K5UridSLovITryypIPkmz6SFnXdVbxcwgXoN7g6cMHeFf4KOrquHCcAPPQepsXQq9HoHUpSsHvgsJYGgh86ULTLNrblu7B2YPVl1Vtt7/rIh+A+8ESaAbmgPOfWlEx2s5iSGKCteOOw9lgvRkBF52LArlunJM6qTnI6JgtEgGWXKJPi4A0UclkvB43VGrouJtoPK+LIZ/FSUBNtbC3f0pMt
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0afe043e-a81a-4cab-7941-08d581578411
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10676706EA97D953E63FFF12FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(39060400002)(76176011)(6116002)(25786009)(3846002)(102836004)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(15760500003)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: uyZbZn/nCcpFBB1fygCGGdunEbwFdY1Bja5EHoFIGWkqslRrS7U3sUgFBb1M11yF/aMrBGQBHAZbLklwI47Ve8o6USe7/2aALW9CfkmS3u4633aW5QBMd3DIZSSpgViTmHS5lHpRnjb/3P1apbuN2AiD6AdZXt40ChfUXud+jLE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afe043e-a81a-4cab-7941-08d581578411
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:07.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
index ed8283e7397a..83b53cd956aa 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -457,6 +457,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
ransfer *xfer,
 	int			elements =3D 0;
 	int			word_len, element_count;
 	struct omap2_mcspi_cs	*cs =3D spi->controller_state;
+	void __iomem		*chstat_reg =3D cs->base + OMAP2_MCSPI_CHSTAT0;
+
 	mcspi =3D spi_master_get_devdata(spi->master);
 	mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
 	count =3D xfer->len;
@@ -517,8 +519,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
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
@@ -536,8 +538,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_t=
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
