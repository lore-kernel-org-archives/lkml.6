Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475752-2-6836553462557546154
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
    t=1521475751; b=nRHfDNa1M002Pp/l66AuVoUwPMZ2YmM/O3q6KNzquSZrb0I
    KCAxgRvIKpzU3LZpXtdPpyF2HCIhZt1WUvRayexq03PFR/QCV0JP33UW/+oQoInJ
    LbOAuK4t9/kiWa2XWFqqee79rEnAKu1BYYOr+IVziQdAoAe8Xint3lmIWH04dGaO
    yQTJDkFPqTBiR67pniEBtEiNUR58T7eVJH7fGjqQ0mSBL8351/CNWyQV3Zlznwvt
    x0ETjQUAzrAMfZ62wsDEBRG2nFtf6JFZPdlGZD5ZhBeTXTTasKCN7TSaoivbbJpc
    Taa4s0f6xYwEmSsXcfXrVC+MNHHCYJTcqkvbV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475751; bh=uFPnl4
    S2lLX1RUUxOahYulGrtd83Xq72nJv+H1aRw+Y=; b=SM+Qe2iaOj5yivIAXVNyPM
    K3/KOnx4ZJHMgP+RwRLtTRZiK6O0CQIBxchZJ+cMh/n/wwD/Gwq/ytd9X5nDctYP
    xrVzCIZ9A0VBfvyExwJxKIdgjGU8k4kley1iWoNkOXCgjjYkGUq0QgSBlA9jh4R8
    17+KZr6Xdhy47AFXVI1bi7ma7BpotLc6MWjcBur49fNjpg/Cz6xyOIWfyDtj0A5w
    V70oXuooHin232NfDGE395UCGn1UAx0jBOc7DMQjsSJRIYgYNf+/H7Us5ufLtxJc
    VQ9ZS+EUZzudy5auv4iDKOjmf5dHR8/9k41P87eYUOVbBsAfFKmlBurtBsxMuRXQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fLTDhuIG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduvddvnecuvehluhhsthgvrhfuihiivgepieel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fLTDhuIG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduvddvnecuvehluhhsthgvrhfuihiivgepieel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966383AbeCSQJA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:00 -0400
Received: from mail-by2nam01on0094.outbound.protection.outlook.com ([104.47.34.94]:45505
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966289AbeCSQI7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tin Huynh <tnhuynh@apm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 062/167] leds: pca955x: Correct I2C
 Functionality
Thread-Topic: [PATCH AUTOSEL for 4.4 062/167] leds: pca955x: Correct I2C
 Functionality
Thread-Index: AQHTv5xDD2JDJdd8wEWHv0PTElTpjg==
Date: Mon, 19 Mar 2018 16:06:38 +0000
Message-ID: <20180319160513.16384-62-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:v4KKKxrsTXG2ybc5k250N35ZOLI0IdIxCFjDJ8I88aTsDl2MBA/0sSD4DmiXvMU3ER7Ec3No4NqslXuNCJSV5pcg6OtKCsw1hk2wuAmBjeplQ1XUE2IGJvJhRsKf8TMqfOWoXUjiH3o9+6g/+qtDtFHu42UmuaYxgFMVJ5CGfsHDPg/VWFov1H3kmJ3KeJy6Ss58v+OI2OpnHGT1/6pKKNHdavReVkT8HufJKoeVt3Lw/UdVqPfcLqj0xYLeRgbO;20:PymBMr0iC2/2Lmb7U4bkminHjC5ADCT8uCUlDBJ+QgPUe9kNJpueLHMH4oqt60tpUURkl2CuuhwKmDx4hS+WZGGBE7qwN0jxZQr8+YmpN6OpTFpMQYxvShVExFSyrqg3qoL30eJK2LQr0IfJHAyQhDQbHBj3eJwWucvryJdFew8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb79b113-b422-49b0-0953-08d58db3b6d5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965504A7A4DD4EEF0632733FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(39060400002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YccJrTmxHe24tI+7hz7piUHEtojIk+FbyuUc/NX0pS3cHHgfEzA/Gev+gMmbhnoRemNjizEf8MJwDUYdXDJ5q0z9DYtJ9XE+a6wUUIolGSTcFkoJ2IB7wiG3A+/YxcxYeEmhCKy07AchqT6WUspesBezHhCe5sXcJh1VFOvBc3UeQPqFphq1j4YMgtI/mgnekSQ+daCyQezJ93eZNfqFTpDxkxH/u9jSetpgr/H37Uy9rE+AFvHGFAR0B/zmvjFqWuXb3lvNIMd2rEY6YugdKEqzuGJt3dtaEyshoKcxidxU+bPCYLt32JXgpiIv0vcBMFjha8ZNhpn+Ne7uSRpLTQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb79b113-b422-49b0-0953-08d58db3b6d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:38.5834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tin Huynh <tnhuynh@apm.com>

[ Upstream commit aace34c0bb8ea3c8bdcec865b6a4be4db0a68e33 ]

The driver checks an incorrect flag of functionality of adapter.
When a driver requires i2c_smbus_read_byte_data and
i2c_smbus_write_byte_data, it should check I2C_FUNC_SMBUS_BYTE_DATA
instead I2C_FUNC_I2C.
This patch fixes the problem.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/leds/leds-pca955x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index b775e1efecd3..b9f71a87b7e1 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -281,7 +281,7 @@ static int pca955x_probe(struct i2c_client *client,
 			"slave address 0x%02x\n",
 			id->name, chip->bits, client->addr);
=20
-	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
=20
 	if (pdata) {
--=20
2.14.1
