Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475243-2-6956390318436120623
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
    t=1521475242; b=DR+OJvYNXDwm4MZAQrsjNshmNeGcOSC25tLBvIX9CONMHeP
    39DzW1Ii7pWBBjfpouG8FNyYEThV+sRdb6fnaHQEdFXeNZxdl22lknDoidi6BSCP
    av3uRhfwGcL8OwJCLq9XUbFkDgm5ucS9miXkJv7S64KtwE2EVSuEmrhau5tHT+4u
    ts2Xw2vQkRHPvZfLHKVUFGYufr2H+iurEb8zPM2LEdCr94FYZVsg9FgLmx5M1v4L
    ln3yrifE9AuEfb4SVjIRcVpOzotomSY2OmJ7nCcKbZUQni9eD4bDdarsrp3P+13g
    hAPjBmjjN8BtHrybXib5G2o1HI+D9+4pbbVq+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475242; bh=47tMDL
    eI7y2uJppZk80EZW+Rk3ZjHjO/s4SHLj3kxZA=; b=KQb+Exarv8RQ61LKm+ojaW
    Rp+nb3fgJGfWt3jdYs6js5J4xkyem7FUcOoz0qvc9E5mh3lBmil971KjrVzmBqxr
    LX2vZ6H6VVV/DSr9QRiKqBNudHWUsXzbxxuzxLKF0XlpZIb/a5Ck2LW7Kq+qJGKh
    hzN/2azRnG67XZ4lILFn5VAHs+mFf/QMqRMxAEfn7qAPudg2fH1yzTUwlFDhA0Az
    tgCAtqNGaZKsEaqAi01YoLdlnbVyD/45bcx2/w+H0h5ytMH9Y2OtnLYOrwjYvTOe
    drC2/+UF5iw8agxKF02Oq7X3fKIHZ5Nh/qj1tfsI7qhKe3ZX166gkOg8N0xaL5Xg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kdK7NlLb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejheejnecuvehluhhsthgvrhfuihiivgepgedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kdK7NlLb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejheejnecuvehluhhsthgvrhfuihiivgepgedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934869AbeCSQAf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:00:35 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:54448
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934867AbeCSQAb (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 086/281] iio: light: rpr0521 poweroff for
 probe fails
Thread-Topic: [PATCH AUTOSEL for 4.9 086/281] iio: light: rpr0521 poweroff for
 probe fails
Thread-Index: AQHTv5tFxLcmo4gBIk2ZcKws2/8OCA==
Date: Mon, 19 Mar 2018 15:59:33 +0000
Message-ID: <20180319155742.13731-86-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:vYzJaEkxSXxC3P42k8+Hk9FgHzFe0bB7IYHm432r7uafyxdnyyTYQkaLwiC7qxBy2uTPI2mROIEFLzcHBTwINRUyRsclyRkDBK5EX7Qcqf7qOwV4VFIpm5gBhNgaVv+w1RxpBtvzU9kFqMk1hcIh67qh3Bku/STqiRuP1zo739s4eSjxcrM16SLQwG8SgdKtvkHB9/V8psY8VHHWyEKn1oloDazco7maN80/DSb0QUZiHR/vFVwNqILHGXsZ+5fT;20:/Mqbnn7508RsQyORi0/t1ys60ripMRXPuus8twxC3WmyP0Z/LJN36RgYLqIOs8GEmCRV80aWYrlxLEbX13jZ/pmx0s8KgjBeCX3l4w5FhpENI1+6SafCr4NoyeXrH9cJzv26ZuuzIrGXvN9Vy0pf5XHVjZRM0J44jquiNGyYnJw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4ed8641-8d7a-449d-d5e4-08d58db27c55
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08690C5357A8EE2659C03B0DFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(575784001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hx9clPaKxhwjkre+XMPW8/D4NguSR14BQRU1LLPFRMASKugRjEP25YlUYYhJafUSVnXxuAVtJ0qiA1xVEKixp0UhiIiuj0jUohV1c+jN7mU6akx5pJbMNy/hcVq2sBD3R1KNf20dUFXVqJPZ75FyZAydo5CE6wWT3tpJzC50vlj4HJ0dsPzMbXPlvox1tXo6OWn0cX1/f0hdq8FNjDvYuqbYcB4/aePEhO56wV88yJ/J7KZgSsX77HvS/bIrF2rWjCZafXR/5KMp5X1h2kPdvb95LWDrJR+6UjSiDc7SxNZ12nXbSETL1m8hrKq+NDG1+UKL1+FCWiPHPkpgvgDeCQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ed8641-8d7a-449d-d5e4-08d58db27c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:33.7565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>

[ Upstream commit 12d74949133e2450533894ea01ce0c56646ce006 ]

Set sensor measurement off after probe fail in pm_runtime_set_active() or
iio_device_register(). Without this change sensor measurement stays on
even though probe fails on these calls.

This is maybe rare case, but causes constant power drain without any
benefits when it happens. Power drain is 20-500uA, typically 180uA.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/light/rpr0521.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 7de0f397194b..d23cf7759ee7 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -510,13 +510,26 @@ static int rpr0521_probe(struct i2c_client *client,
=20
 	ret =3D pm_runtime_set_active(&client->dev);
 	if (ret < 0)
-		return ret;
+		goto err_poweroff;
=20
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
=20
-	return iio_device_register(indio_dev);
+	ret =3D iio_device_register(indio_dev);
+	if (ret)
+		goto err_pm_disable;
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+err_poweroff:
+	rpr0521_poweroff(data);
+
+	return ret;
 }
=20
 static int rpr0521_remove(struct i2c_client *client)
--=20
2.14.1
