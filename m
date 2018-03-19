Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481470-2-1518248774522344592
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
    t=1521481469; b=ODyFhwd2zeovMrDHlXLZgplQpsjoUhUskgeG+rF/FYtKETQ
    CU15lSgwbVlRC3jvFhgdUwwgz0p84ZHs//yTcoZmiwjIJ+xRntP3UJbD6hc2M4c7
    ZG5PNoRekv/5d0hnYeybm2jLME8qlLqrh6LdXPbh7v09jkBhvclu/eUxs8EXFCI+
    XlSU2K9bDXgGBN8KjbaGDcZRUYPQMS2E/yzxCeicxWjgNnYRBXx0qiMfnJXZCnXt
    5Rlahadydme3j1Cy1kl7Al0w7RQ6KJS6VExwZmdeIeQdN2TlVhbs7JdhS9VpT3Xw
    +t4VBJAidzRfXYhbRN08F0pad4evJuDIbUbaqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481469; bh=6cNabe
    p6jnYGOzPK5HNaO1YvKlXVuJ3sdKk2MKj7I+E=; b=k/UGm6Uj226Z7qQUg/eMsw
    v93V2DAgGsMe66jmGD8j6iHFg4zoJslyQDjsJuSeLxadNXfzzrWJ0zUwhdNt/2Ou
    PfBzLsTMjNFSjS+Uwlw4t7mhxn6JQHkfkEQaXUcgRvqYRe+Et2Z/qt1w4eXSoye3
    jN0fBiVRd4DEQwTZv1HHVw4LF/PPKi2FwPXGPcMUrhPx1uPOJiI2fXNFE0sVC2Pb
    jVaCDcZnYWWNI808jCQsiiZS/vDOww2A41HUGoBwkw35t6j7khNGxkMNPM5EiGYe
    J944nI7Dv8kBKqPchc/BojEykmVMkACdcVh+NYsEzpahybUMjrBBouk0CH0j9S+Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OCobCZ8b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudeivdenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OCobCZ8b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudeivdenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965818AbeCSQFk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:05:40 -0400
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:2671
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935103AbeCSQFg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 245/281] iio: magnetometer: st_magn_spi: fix
 spi_device_id table
Thread-Topic: [PATCH AUTOSEL for 4.9 245/281] iio: magnetometer: st_magn_spi:
 fix spi_device_id table
Thread-Index: AQHTv5u3I1lTOQctTUeWMswecOnUZQ==
Date: Mon, 19 Mar 2018 16:02:44 +0000
Message-ID: <20180319155742.13731-245-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:oNhgUx5n8iakbAcxGUiX5qgNApE/s9UGG2i6XJT8jmLicY49aBchckEivE2Om/JEBJTXeKRgcBUYcJmPYPGHhGPBbSMiCoEd14JQ16u3shVOE2yasDhbDKMa7mO/8Spfn6ACAj72NGFuXZ5mi5R82qTfWaOcACIhz0+1ddhU2w91k6Aq4RB0YMZxtxepJ2It2ESnG+SxXADidhkA9KkUy2/5G4kzTUmbFFS9xaY7B9DerMUK7L8AB8gTePfaBZ3j;20:CLT4Y7cwiBMAH2SW4haPC12EtQJDbCPe2P0byN9mONrO4OGCvQWJ7EhlvT3dHIAM41wd7/Hqr24VIkzFKv7wLXVM8OXsmTPSbLflQ1VxcIA/4l6J3g9cam3DgvR9qPskFJnLNfzpf4Ov0mN8QgmV9Uw1yPHIq2wpu7BK+oAJDDo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81160395-0100-4763-a6a2-08d58db33c1d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07276ED022C6F1997FB49EE9FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(39060400002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: M2S01bWRtWEbxZQy0wT+O6zAvFYAvS49KHvZVqeQEOeVZCbIijHk0P6Zx2SEKSucwiwvKMWBsFQJvx/A/OIauXn6tSuZOCr9qbqnQ+7VXetEJQYp5iDi1XT2Oiei5WKqBIkcxS6M64pJSjwdNHD1hr+YYNho3OAIUvGwbTF/l7oO1+iHlzftl1+DgpdQU+v1bxbTmySrR0yjwj1L64iKEqogRR6oY7QmsAY8MA6zO9siTzxas751saXrKrJ7LU+IohOSymK1CsbsFhHNJ7IiWF9P0yIb4Q4ml6Z8o0qEzAxyn3gJHohCtgWRWWpwgRtjIsI04hip9pzOaf3J2DdMFQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81160395-0100-4763-a6a2-08d58db33c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:44.6128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 6325e7dc8e03..f3cb4dc05391 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -48,8 +48,6 @@ static int st_magn_spi_remove(struct spi_device *spi)
 }
=20
 static const struct spi_device_id st_magn_id_table[] =3D {
-	{ LSM303DLHC_MAGN_DEV_NAME },
-	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{ LSM303AGR_MAGN_DEV_NAME },
 	{},
--=20
2.14.1
