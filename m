Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480335-2-10488507418585373350
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
    t=1521480335; b=AFaqOKbPdv6tKiP0WMtv84ss5xknHQXRWKMt0Sb2Lslcze/
    I4nINsB+eb81NAufebp0DcnynOhJhJzM4yWEjLElTHt5/H6oLzOzRGecsz9Su8I+
    NsgtBIYyFfvHgkAtWjZocn8q5dicNHzGjPVn9EJoS+otV/rW7OALqrSDhiHYD8bU
    dObr9vKSAY9uTG50pzv71/vEQ4r0k3nOB3Tv/I2JrvL/XBOyFlWEt/mntJJTTy85
    UlDvsT1k10Hk5PwFXgHrXhELEKBCbESIcjt/oqUR0b3cljk4VyDgKZQdnXgm8Kt9
    4KEsqOleHW+9lPcnTpaYf5an9+Jt8ICSj6oiTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480335; bh=cQEd6m
    Y54tW43y+r/qIsNfX5HZ98A2IfeFOixVEtFtc=; b=WZVG9pJlYgAo5o90tDcOiG
    QhcjZaPxJPE2gX3ICgwaQoSeteb9Q2LA/a0UjyopzDGigyx0EH3oPVRhrWNEPSZ5
    9J5JCvkQU81RQjsVHiVlWetnhqiLe8QhcNe+0EGtlCAQtilUdy/7PdT0FAxH+EZH
    HAY325mSF/jr7ioioiTENj7BeNCA9GKGCoTnQZTXaxnKi5yI5mUjaAyOQCoo4EpL
    mxe9rxlHp9dt5O/H8hy+ssbiloyw37FsbYIduOzN6qO9gpIV7IE1yq9E55HcF+Fl
    OctgWrI/UTHcV7lpy6LkLhqU580c7KAnZ7gkZDY7dEBSBzsiJbqlAOgEnUQzy4Ig
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h/snKYIw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeijeehnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h/snKYIw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeijeehnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968030AbeCSRZa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:25:30 -0400
Received: from mail-dm3nam03on0096.outbound.protection.outlook.com ([104.47.41.96]:30671
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966216AbeCSQI1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 056/167] iio: hi8435: avoid garbage event at
 first enable
Thread-Topic: [PATCH AUTOSEL for 4.4 056/167] iio: hi8435: avoid garbage event
 at first enable
Thread-Index: AQHTv5w+0PdrFccd3kSzeRPbVdoGYQ==
Date: Mon, 19 Mar 2018 16:06:30 +0000
Message-ID: <20180319160513.16384-56-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:IC0u4tQi6sUmhostnKGB2hIoAVGh/oE4E6TUViE87aqIVlfWKy2b4mU6PQP4TtuW/jIi0Ku5Q1Akg56xf1rCftI0s0/ddi6upuz14fNNuavHsegZioqrsNJu/zMjGU1WxjbaerBZRFSgSKtb3BlpGXidyuRVI7tsW4gRh8dAZkcav/FMQlsJMmDNmFCX7ww+Z/mc+SFlYzhIDWXZr3r04kYKVvW/I6cefuKpacCkw9SChj4I4WQuUd6iUReoBKv+;20:yjnU0m4RM2Ae8RyUzcopdfnpWUnv2Vi8m39eGZuPxXSZBHDwCg1vtO/wk/LL7UOt1Uh47jjFF5UStWow0sE8O/bSOccuYlT+JE/k6gCN3AfQUnW8LOYTdpFWJ9J9o5P3hwfuLrNiPpy8rSD9ELcn6LPzwWxWm2wTh45kzGltpmw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e13d58f0-23d4-4f2e-ba2f-08d58db3a315
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08050C8E76CF0D4553FB926AFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0Xbq3vqaYnAWRU8A2AD0Ktv8sGkiJvyfrUofZaJBbGLXeScYQQ7WTgXaDxJQ9Qm8Ka8FJoYxQA6QFY9RkL5xLqpEQEPPs18UMD36Sm8gMv0lgelu/5focpFdB2nFQhP2eyDN9rroNHNCLyXBVpH6NZ4wZ3aChIlSp7joQe+BSzxpj+ozoUlXUVXpPYokzvcYQObIONgQZPwiBEvwVB+trdg6cGQzGdmmgLW3l8W74yqvLICSnPG3o7OAiTwYCXrOOGWJztKYDgljOMNeS1s1CSTUlTMBHtZekMvHQsaD84qsMXaxdfSXmHSVzUwDhi3gO2kSYxrVmjvS3XJ46Ow8yw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13d58f0-23d4-4f2e-ba2f-08d58db3a315
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:30.5968
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

[ Upstream commit ee19ac340c5fdfd89c6348be4563453c61ab54a9 ]

Currently, driver generates events for channels if new reading differs
from previous one. This "previous value" is initialized to zero, which
results into event if value is constant-one.

Fix that by initializing "previous value" by reading at event enable
time.

This provides reliable sequence for userspace:
- enable event,
- AFTER THAT read current value,
- AFTER THAT each event will correspond to change.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/adc/hi8435.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index c73c6c62a6ac..ba9e8fc747b8 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -121,10 +121,21 @@ static int hi8435_write_event_config(struct iio_dev *=
idev,
 				     enum iio_event_direction dir, int state)
 {
 	struct hi8435_priv *priv =3D iio_priv(idev);
+	int ret;
+	u32 tmp;
+
+	if (state) {
+		ret =3D hi8435_readl(priv, HI8435_SO31_0_REG, &tmp);
+		if (ret < 0)
+			return ret;
+		if (tmp & BIT(chan->channel))
+			priv->event_prev_val |=3D BIT(chan->channel);
+		else
+			priv->event_prev_val &=3D ~BIT(chan->channel);
=20
-	priv->event_scan_mask &=3D ~BIT(chan->channel);
-	if (state)
 		priv->event_scan_mask |=3D BIT(chan->channel);
+	} else
+		priv->event_scan_mask &=3D ~BIT(chan->channel);
=20
 	return 0;
 }
--=20
2.14.1
