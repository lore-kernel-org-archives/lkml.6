Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476510-2-17869755433492388386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521476509; b=mfsXsoc3skiTDWINNlD6hNByuXwrexy38PhbI7tAf62kxUf
    Y4FLicGtPCRcOzl+ThwPBb0oFClpjg6QJsNIKSfUGlx+gfSHUa8gt9nL6W5qlLc9
    bL8V/M+PrP/aqarEyd+BRBRMx42g/RSreBV7Ghp8JNZH1lYXDQhKFrA0HD4Y8OEX
    sk89avYnO6QqvVfK/Tecbe2DRwU5wJAvN9HhmGvRymuI8+122VpPYqvGBbY6FHXQ
    KWgXQOFHPBgFN+cRWqjG/5ssDGexgguwwMEKk3ahVEjNztNQzDZCIE+2Qbekyqty
    77D2K3GBhyhRe6jm2y61G8mQ1mbNMiQgvmKlzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476509; bh=mvgE59
    pSWggjU3uXNBZfxAX33pp6mvmnlxAejlUH4nI=; b=mX+uf/bEY5Y99qFQiMetwE
    AjfMEGEW6Oc40f2/4QkHGrXNKvF4Wo06YwDkuiDBJtP+deVJaQhjkN2gneXJhnHM
    mOeL88Jci7hG74d9I3ETHgcvHbQ2bYXDLBBIOSCRIC+S0lujfMzrhQJQCrYRh3KF
    +T9lx5ChJ4l/5YpuDPr87za+wa/0yiJAqGT+EwIoRlvj8e1O4Ds2uR/7YomdY2vS
    tAFxYK6/NVoSmvSlr+Euz/DYz3bkhOl8gMLm7WgddW0v8YJbGEqJ6ysWDaQ2agJF
    HKZp1f/2s0O+TbDqYqSl/soPsmUsB0kYIQVSxH1d4gsPT2IVSXwA44wueVOQaCYg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kh+Br8PL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduvdejnecuvehluhhsthgvrhfuihiivgepgeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kh+Br8PL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduvdejnecuvehluhhsthgvrhfuihiivgepgeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935393AbeCSQVH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:21:07 -0400
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:37504
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966939AbeCSQOQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 087/102] iio: magnetometer: st_magn_spi: fix
 spi_device_id table
Thread-Topic: [PATCH AUTOSEL for 3.18 087/102] iio: magnetometer: st_magn_spi:
 fix spi_device_id table
Thread-Index: AQHTv50xX3ZDQ/G480qVE0WBbDNjqA==
Date: Mon, 19 Mar 2018 16:13:17 +0000
Message-ID: <20180319161117.17833-87-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:T3iVBTRo2e8pWvrDjkfdGGu53uxGcS+TjUZeUekww5hg8Bws85laqNZtY8pMOZSTagtEk4zX2l7j1bOCTseeenLXCd3bDoLQLFo7oJnKQ0a8SI0emY10GtYQBpmHVoWNO9xr5xiFSad3EdmWH8idIyMw1cqpomf+Mozr0jdw/TEauwp03dt2yR8H84fhqfN5a9KlbXgNvfNlLxXcGrLJLKQ5g2AX5N88/QNwxZ9tW/BYFMrEJRG1b6Z2Z/c5nE66;20:sC4nTUr5jTgk5AuZPtDMVYJwyIfHi5jyenVpiLlYEU7NP4dMDAZZMeVpmQVZl3IsPXlNSsNTc27lrqok5F56iXpehB4OvIvCtZZnH7ZP8VycqwCrCdQPTTwyGppNkpw6aKRRi3t/i7WLQ+maAeLkHxPu/zbDrIMLifg8SxayXrA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edef0f74-6d5f-4d23-3230-08d58db475a5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11128CE18B2C1EF5B493A7C9FBD40@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(39380400002)(396003)(199004)(189003)(53936002)(26005)(14454004)(36756003)(2501003)(186003)(305945005)(86362001)(107886003)(316002)(575784001)(7736002)(6506007)(110136005)(5250100002)(4326008)(2900100001)(25786009)(102836004)(105586002)(72206003)(10090500001)(54906003)(2950100002)(478600001)(39060400002)(99286004)(106356001)(6436002)(3280700002)(3660700001)(10290500003)(66066001)(2906002)(6486002)(76176011)(81166006)(81156014)(8676002)(68736007)(8936002)(5660300001)(22452003)(86612001)(6116002)(3846002)(1076002)(97736004)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8nrgTJbyaXdtRKgwo/M7RC9oBnpRwMrIvl0PSW4SWAUx0RYNamp/jfHPz+glLU+DI/rd3+q6owuetBBvggd7G4Q0qAXrKP88mqzOgMJjk2l/o4ZOIOFxFxzEpcB2l5e+4siEij5I7xlyEz67onAnlWhH0G8sTorGdgSuoC5X833Sc7IcVKXnGDnHOppxAyTKCq/yIWvMzNlL0P/wjFDUzXWFpjz43iHLTeQ3faoNwqLcudRxHGhjMo/XpnQEfOQMbOMpTcnO0rCxWq6CKdnYsftl3EuoTJ207v8vugMAOnR4EW41Lgl/njilIwu7RZuQzw2Do4irbNXn0T1NhTeFKw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edef0f74-6d5f-4d23-3230-08d58db475a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:17.9631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>

[ Upstream commit c83761ff0aac954aa368c623bb0f0d1a3214e834 ]

Remove LSM303DLHC, LSM303DLM from st_magn_id_table since LSM303DL series
does not support spi interface

Fixes: 872e79add756 (iio: magn: Add STMicroelectronics magn driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/magnetometer/st_magn_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetome=
ter/st_magn_spi.c
index a6143ea51dfc..d28685bec34e 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -49,8 +49,6 @@ static int st_magn_spi_remove(struct spi_device *spi)
 }
=20
 static const struct spi_device_id st_magn_id_table[] =3D {
-	{ LSM303DLHC_MAGN_DEV_NAME },
-	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{},
 };
--=20
2.14.1
