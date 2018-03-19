Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480321-2-3634386386576962575
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
    t=1521480320; b=Qx1A8CJBSKgYYV9ZyIpiL2cFgoiwoKNMUd7Ug4qnJ9nfHvO
    RE6BdOGJGA9/vr4ELMYMwbDIa2TZMTmKcWPbReIbKVuK5KYR8XLu8K0d1Myenlm7
    gN3daZ/4+S2xYqoPBpDbu+/h+iRb5gqDfjlmluefpWBq2X7D9Hoy9pIpIpM3qARt
    RMi5k3nu0uTkhOAZ6dQUYbuFIRDru6i4RX2ydI+wZNLHA36PFdYJaJGY7NBEshHJ
    zKLc7Bt5LkKdfRrUwxs+f57rT3BHKhCqFlC9mzcdNCX3s/2iCSLS/7X0w0fdg4h0
    q5S713ko/I+L1Nxj3YyOwQdJRseMBv9+sRoqk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480320; bh=XN1f2n
    ange4Nha5yJTyZBWdT8yg6RvFZe3CrJphbNLk=; b=tpzG26qTA7kFPqROiHw24e
    PLGzee4VKP4CBTvCRD25JWHg36VSgzrvZlVM5zF/l48lboSD4/Bu9p6aF4STZGX6
    Y7xFdTSf/YbGTwLenaK/AuiGfF/sTUwN7aMQjiMSiC/SbpoWdQMVFvuMp3QTTah+
    A3UuyZi+zCYgzW1DA1OW+U6ZhCloHuraSxHsyg6iiQnGARERPz+beiphtLZN5hdf
    81H3rfaXIx3VSzw8IK8uzZTgGffJTu1Guabtj+Xn2R0v6IiPPxWBAVxjbvjp5B8e
    b+kfmglqRdSPdepI8CfaRUssnBzH50HtlE/LHbt5IahxOTL6zi+fKH0z68GDszyg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lBZI0dpJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejkeegnecuvehluhhsthgvrhfuihiivgepjeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lBZI0dpJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejkeegnecuvehluhhsthgvrhfuihiivgepjeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967924AbeCSRYp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:24:45 -0400
Received: from mail-dm3nam03on0096.outbound.protection.outlook.com ([104.47.41.96]:30671
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966297AbeCSQI2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 057/167] iio: hi8435: cleanup reset gpio
Thread-Topic: [PATCH AUTOSEL for 4.4 057/167] iio: hi8435: cleanup reset gpio
Thread-Index: AQHTv5w/7oBHFEA8vUmRBWo0RhulTg==
Date: Mon, 19 Mar 2018 16:06:32 +0000
Message-ID: <20180319160513.16384-57-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:2lw4zmeGVeGFsUAsV24G3n09C7C5HWfNc+M4zKbg/BPPUpDcYpmAmH5K4H0HS9ygDASzrL8orkH0/qQakCnm8M7CItdzbbxz/LiHA1EF5apPbtWWjwM6DpPZPYz2javJE9FPZV2dFi/xTSc0TPGhZclzafNlk00YKF96S3iiex9Px0S4cSyzZQZ7yMp4M6DyfaNJT4sFZuQWKkdZ1Kmr1r6crg8a7woCdrACWi/m6w0XWYG0Q47fDQYF/vCAtdKu;20:TIYXilDmowOdkhv/v741zeYgPBSdJCxBeY7wh0YgBlaa4N3sfg1sNWL7xrWHQ17D7fpVZskCdI/IouQ4iXvOydAvkKF32U2fqtWYS6itoxgO253ajaRSV7zBzPXp/pGYBVfyZ3Lk5XzAgGJttsZM5T3CUM1gaxzm57FjAQIPaUc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef364d9f-59e3-4c5c-21f6-08d58db3a379
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08059F61167B6A6CC2D7E63AFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XTeHI6JJYyLSxLC0Xe5RfpUNtH7OZ3hbPxw3XRw4N982vgR3V8jGczrsnjtJvE6Tmjv9HJjP/lrG6gRHG1f9nsoztlej7pEFG8sYwLsb4e68E69PqGoUAWXQG+x+HO6VQ8eKrDDu6T0Pv1TUGyU9yz9ZfcoIrRWfLbrejbpcqbDdREs2BnuWY/o9sC5uC3tu5mpVhYMDBs7Y8NsNr5KiOsEHNm1VRcUkXnz0IF/9uqvP0FrlFru3IKg2h+tNYqecF+vV/9j82FyM2RbkCCuXTZGCkb6rJJWzltwtBz5UGhXNAH5+/qsuUcAaHnKEb5zW2FDr95znyDHdbgVLyg0rBQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef364d9f-59e3-4c5c-21f6-08d58db3a379
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:32.0668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

[ Upstream commit 61305664a542f874283f74bf0b27ddb31f5045d7 ]

Reset GPIO is active low.

Currently driver uses gpiod_set_value(1) to clean reset, which depends
on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.

This fixes driver to use _raw version of gpiod_set_value() to enforce
active-low semantics despite of what's written in device tree. Allowing
device tree to override that only opens possibility for errors and does
not add any value.

Additionally, use _cansleep version to make things work with i2c-gpio
and other sleeping gpio drivers.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/adc/hi8435.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index ba9e8fc747b8..7401f102dff4 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -453,13 +453,15 @@ static int hi8435_probe(struct spi_device *spi)
 	priv->spi =3D spi;
=20
 	reset_gpio =3D devm_gpiod_get(&spi->dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(reset_gpio)) {
-		/* chip s/w reset if h/w reset failed */
+	if (!IS_ERR(reset_gpio)) {
+		/* need >=3D100ns low pulse to reset chip */
+		gpiod_set_raw_value_cansleep(reset_gpio, 0);
+		udelay(1);
+		gpiod_set_raw_value_cansleep(reset_gpio, 1);
+	} else {
+		/* s/w reset chip if h/w reset is not available */
 		hi8435_writeb(priv, HI8435_CTRL_REG, HI8435_CTRL_SRST);
 		hi8435_writeb(priv, HI8435_CTRL_REG, 0);
-	} else {
-		udelay(5);
-		gpiod_set_value(reset_gpio, 1);
 	}
=20
 	spi_set_drvdata(spi, idev);
--=20
2.14.1
