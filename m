Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521474965-2-1053842638847418988
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
    t=1521474964; b=l22S+LOFVSMSjpUQxheZsb6khLzscQfz+VFdglHgNpjICtq
    Ttw9z2PMTl6L92HNZi81jV+IaY5Fsp1Lr6tsjOnd9+Ftq4OItFo0hX7UZ3Owa0gV
    TMxtGT9GMp1UgQlPMqA/ZWB5Y7C8MgFN09RyOatNsew0BcoB16CnNWzVbSPZdSH2
    /7dhE1fYA6Cg9I1E+kM7C+lvS2ID3/kzQYi5mh/b5tQjYkkqTAuvEaXEMPrIFw8C
    N2f2iEYTnJgKEEgKn90k49EZ8Dr8bNjX7uc/NqqV0tU1sXc3GgEoNhB+k39hTkJg
    5fibzV1WSBfCp9e9dJV4Ce2P7REATINh9DgH+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474964; bh=bG6H82
    ZUSe0kTt5cSICnzEnlRLMzksatSOQFNkgJGlU=; b=hq0InubxjNjR3s05bHX2UZ
    uLnzLabFM2VUQZDT5tp4u7rDS7m51FK7iWSTF4SbpkHEZYnAz7yqa3pf6ZJogHPX
    cs4vdIT7LnL4Bi5Aj2vgrsCCzDByCI07ka5jP9iVC/MM0+1YJ4xDnTMeHu6DygG1
    0j+CxXFjivPiSUC+vyKpJRJ1ym8E/WGH3+sON9XDa4kOPrRwR28y7dQkLjB49JN6
    SQb8xNhOjEApKX+mtc15LeyKAlz1blo20o/ur7eXwXsOWSpl1Ixu3VKUQWzTD9OE
    IE0FXfcLOP4UjoOpYc4tCzU+xSP50IYbq65tDI0ouV/0yaG6qWv5VUNYGzAfZIZA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iUiGDdH4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleduiedtnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iUiGDdH4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleduiedtnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933974AbeCSPz7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:55:59 -0400
Received: from mail-by2nam03on0092.outbound.protection.outlook.com ([104.47.42.92]:42976
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934423AbeCSPzz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Jarzmik <robert.jarzmik@free.fr>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 45/97] backlight: tdo24m: Fix the SPI CS
 between transfers
Thread-Topic: [PATCH AUTOSEL for 4.14 45/97] backlight: tdo24m: Fix the SPI CS
 between transfers
Thread-Index: AQHTv5qwbZnJKYzjf0ScxhdKNhaKRA==
Date: Mon, 19 Mar 2018 15:55:23 +0000
Message-ID: <20180319155411.12348-45-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:9KStV0dbixL5H/lnwJufi6BRb1KW3CuRiUpz9R/jSDULttt1lIr55hx/pNsnLS5p03gRDlmePWlTIqXX5foO2v47quJJw4I1M5PG3YLmZpfH1R4QL7SWzD4ptEIFk8vptEzYj3e4wE0aMpTzx1kKNfe7VQoyGcOAlHcbyQ+BAy6gE+WhZhOYGkTHlstApwO1K5mA/Ojz6l+PSBPDWcV7KUz13N+1jSjlIwhlV2OK3iAJyi7DQFSO4Zj/XG6pjjMR;20:oswodYBsZ9wqbScxn7DBiMn+WWXmz45wCfFOQdrqr+R3Wp7i5BucTX/m0td3SJnWsqhNGjQxiKZx4Rnm5wTmhZq5ZJ+I+2VEnnFuZ+vWkvuscMfJTQDh9+tLCAsy6iil8+9OxQi3QaUCayu+Fnh5f7RDYGNzZghlgniZp5/qvcg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dad1850d-c6ad-4b26-4fc3-08d58db1e159
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09677E3AAA64FA25EA9C1574FBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(575784001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: A0m0oS9z3+wmUxxWBrdWqfi8ZGmr/TgON7h2SLQZ8nsTcINDSGI7yfFFwrYYYACI5MbXEnwQB09zjqlQfLx6LxMaQ+d8YOflC378aSOJCCyI5dp6asibC56OrPlKYrFeM4SYqDkW5U5YtglPsXoFKdgdS/ItBfJWnMK1tGHXYXFZH2jG7jTe3NWaLjt5GQBzEep34XLH6eByjXx6T8Q9YVMAHJ9TGHPtxAwb9CmTGc5xd9YZgq4d40SKlx7lumJsNcGzI3KWPjnUsNf7gSITQJp5tuLEXzohqWgGEKE62YPKXhO9JnXRJ/RzuHLjJHRTd0y06Nf3kwaq5roLi1okhg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad1850d-c6ad-4b26-4fc3-08d58db1e159
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:23.3395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robert Jarzmik <robert.jarzmik@free.fr>

[ Upstream commit 2023b0524a6310e9ea80daf085f51c71bff9289f ]

Currently the LCD display (TD035S) on the cm-x300 platform is broken and
remains blank.

The TD0245S specification requires that the chipselect is toggled
between commands sent to the panel. This was also the purpose of the
former patch of commit f64dcac0b124 ("backlight: tdo24m: ensure chip
select changes between transfers").

Unfortunately, the "cs_change" field of a SPI transfer is
misleading. Its true meaning is that for a SPI message holding multiple
transfers, the chip select is toggled between each transfer, but for the
last transfer it remains asserted.

In this driver, all the SPI messages contain exactly one transfer, which
means that each transfer is the last of its message, and as a
consequence the chip select is never toggled.

Actually, there was a second bug hidding the first one, hence the
problem was not seen until v4.6. This problem was fixed by commit
a52db659c79c ("spi: pxa2xx: Fix cs_change management") for PXA based
boards.

This fix makes the TD035S work again on a cm-x300 board. The same
applies to other PXA boards, ie. corgi and tosa.

Fixes: a52db659c79c ("spi: pxa2xx: Fix cs_change management")
Reported-by: Andrea Adami <andrea.adami@gmail.com>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/backlight/corgi_lcd.c | 2 +-
 drivers/video/backlight/tdo24m.c    | 2 +-
 drivers/video/backlight/tosa_lcd.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/=
corgi_lcd.c
index d7c239ea3d09..f5574060f9c8 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -177,7 +177,7 @@ static int corgi_ssp_lcdtg_send(struct corgi_lcd *lcd, =
int adrs, uint8_t data)
 	struct spi_message msg;
 	struct spi_transfer xfer =3D {
 		.len		=3D 1,
-		.cs_change	=3D 1,
+		.cs_change	=3D 0,
 		.tx_buf		=3D lcd->buf,
 	};
=20
diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo=
24m.c
index eab1f842f9c0..e4bd63e9db6b 100644
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -369,7 +369,7 @@ static int tdo24m_probe(struct spi_device *spi)
=20
 	spi_message_init(m);
=20
-	x->cs_change =3D 1;
+	x->cs_change =3D 0;
 	x->tx_buf =3D &lcd->buf[0];
 	spi_message_add_tail(x, m);
=20
diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/t=
osa_lcd.c
index 6a41ea92737a..4dc5ee8debeb 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -49,7 +49,7 @@ static int tosa_tg_send(struct spi_device *spi, int adrs,=
 uint8_t data)
 	struct spi_message msg;
 	struct spi_transfer xfer =3D {
 		.len		=3D 1,
-		.cs_change	=3D 1,
+		.cs_change	=3D 0,
 		.tx_buf		=3D buf,
 	};
=20
--=20
2.14.1
