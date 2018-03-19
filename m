Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521476045-2-5867027723702155848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521476044; b=opC8VESSFZ9+ym7fuoqM82i0V2/AEiF6YqfnVTUX+W9v2u2
    9RH/nMg3sGg7PdLex/ThkbyNqZEKOmDumaI50k6lT6C5Uow1oUvnMBCHyPz1gg21
    vCHr5qV7J8+FVP9dS+jCrMMZ5qlDVLLprp6YM170VoUqcF5DwqeTRsqlgzYjTr/d
    rKgfe266kPwLGlc1OGK/4Abm37pNJWDKnG2mXgpPIi+eSGnY+OIfXw2L4yNr5pl0
    vyWHTa8o+aBaYdKKq445b416bCOcw6NMyNUcPbr2+hlRnaulDFy9/LVCVQoL5Klo
    E5i7RZaxqO7J+Teei6uoHD8k2cViIdwBnpHvQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476044; bh=4FnykX
    OprzGLovkIe2D82HeEJWVyxD4e4N6zX8ZFWuQ=; b=iEo16VDAWwMf9razF1X7Ci
    AQK9XnpdZFJ0ZF18wPvP7aYjYtq3CNwdZgQvnves1TG4qOLbPS2Ivj+WgM+z+FUC
    RsDCR4VK52QsRNAo8lFhiAzLUiiuzq7aJdAxcmXDcb/RA5sGWVu6INHOaS9MDOok
    HXoPYEXOY8/dN5A7xqqqWCbkD7AnZHpRcCOKNVETx1ZoU+TYpvTVC7Vds7zAWsQo
    tB5pvDR3cVBzALRFMAMHbZyTC3OYVAE6UYavRZfNThTi1G0Xa9Bt3rwv9f7aPu5s
    ykRts/muyAovjeLZ3mnDT1+N334fNyGtoxN4OPVduCM86qj0e7a2EX/XrC6aPoJg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SM+HA3jw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehkeeknecuvehluhhsthgvrhfuihiivgepieeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SM+HA3jw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehkeeknecuvehluhhsthgvrhfuihiivgepieeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966803AbeCSQOB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:14:01 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:53605
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966885AbeCSQN6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 067/102] Fix serial console on SNI RM400
 machines
Thread-Topic: [PATCH AUTOSEL for 3.18 067/102] Fix serial console on SNI RM400
 machines
Thread-Index: AQHTv50hjbjjFFtIJ0OF62KTzR7d4A==
Date: Mon, 19 Mar 2018 16:12:52 +0000
Message-ID: <20180319161117.17833-67-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:TvpzqSXJcu+HyG43yTIEvOEc1y49XjJu7qRBtqstFhSU60X+Si1vzJIUKsVzzY8apl7Q1S9wzItxVaVR+NwXq8JfXpUyG2HZQsC3tMHV99ee5bHp0f9358pnCtglpnt2Iy1scyoliGd+fA15INddwMlhKgSjPQnqQV/cx8Ac+TQ9OzulB+N+H6rgOlklZa1unKNfMu32QBQmSyG8atAOLqqbhe2dWRg635JcFbW5WpFOM3up/0Z7l7cCU3hw5CMm;20:Pb483cnbusbu2ucEj7sbbF+XLXCT5d7cFETXsCFcpaD0/GWXYH5QRDYHCaJk5DhKylTc2XjrDX3lAr5mRZHgJFw/c6tC7HwHP7K5iO2FkYvHULrR8zu00e8xroPxBDkucPTAQvc/wCYhvsorszjWz788xk6uQSGoRrhjcMb96yo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4beab8a-1243-48ab-daf1-08d58db46880
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10636265A5AF19C42F98FB1DFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(575784001)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(59450400001)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Cl3GHi0TIT0fs25BjlMcZ0f7oJbwsX0T5aSqtehPDDloWqz22aomCahHOY4/4AR+KIEpydfmquUK+Y+ur5hakG8P6OHPWxYACZH27P3VvRw5WXPprjdlZKOX8jc/ArFNEJFH74ud/C4qrcA0bco6daPNJK0P6XF4RMR9J+hFR+uAu1Fs5Zxd0oN6oiOVXP171yOU07x/5lFp9HrDn5dXKV2+x9dv7dozx7XP7INCcfeRstrtGQ6nN7mbIDYE95Ndrmy+LGN8JxZrVurftQud4GIzTVe6zdZ6Qgh4EwhhoqBFS3FXUonQZqe5/qbI6IQ0b8ua+8X6SHyDWqd0/fbTlQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4beab8a-1243-48ab-daf1-08d58db46880
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:52.5822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

[ Upstream commit e279e6d98e0cf2c2fe008b3c29042b92f0e17b1d ]

sccnxp driver doesn't get the correct uart clock rate, if CONFIG_HAVE_CLOCK
is disabled. Correct usage of clk API to make it work with/without it.

Fixes: 90efa75f7ab0 (serial: sccnxp: Using CLK API for getting UART clock)

Suggested-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/sccnxp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 75850f70b479..72f4146e8eed 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -884,14 +884,19 @@ static int sccnxp_probe(struct platform_device *pdev)
=20
 	clk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-		if (PTR_ERR(clk) =3D=3D -EPROBE_DEFER) {
-			ret =3D -EPROBE_DEFER;
+		ret =3D PTR_ERR(clk);
+		if (ret =3D=3D -EPROBE_DEFER)
 			goto err_out;
-		}
+		uartclk =3D 0;
+	} else {
+		clk_prepare_enable(clk);
+		uartclk =3D clk_get_rate(clk);
+	}
+
+	if (!uartclk) {
 		dev_notice(&pdev->dev, "Using default clock frequency\n");
 		uartclk =3D s->chip->freq_std;
-	} else
-		uartclk =3D clk_get_rate(clk);
+	}
=20
 	/* Check input frequency */
 	if ((uartclk < s->chip->freq_min) || (uartclk > s->chip->freq_max)) {
--=20
2.14.1
