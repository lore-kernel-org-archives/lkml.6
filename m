Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495464-2-11194521855894687786
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
    t=1521495463; b=lIo7SqCq68zPzeMK/Y1YuL6m/JxkEWKCbW/HQYB8U04Yh89
    om8Dd5/prkZK7P5KGv3kXDGN179Z8/rbbeQwodyP0tFZMil4tW1iwmMpdd51MtzF
    x64WFHbU3NQTZec4Mm+w4dHu6JN1L173f9nhQkIuTvg5x1/Wc+DICNgrS29g0QXR
    mwwblK80ndnKexs0tif14uHjiHkw7bdmnUenHzZ36mpFQ+SgxsU5ZPRA8Y9ruBPa
    zTME6AAvECOp9NboPlP8cyNB/JWBfNnBMNYuZl7oSTJzlfvQ2zI+gxY2rDigU7KR
    P5LnMJ1pNesgDrjkFyU9J0X9UVBLuTCzC7Bzq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495463; bh=4+28Nb
    hEW3TpFDKhtpNMPop7lfostgm0jL6sQ0ve7Bg=; b=aTkW3u98BfuQq/b5HMzzwi
    RbUi0gJ91TjaZdcKbQwwm3g9sf29dQWbGv9hHfDOFNEHnq1p9OPHDxc+sCAOnsuS
    2rfhmIoHWpVS02RblJ+bP3akb6xc5G+zwCrahXfK4I/z46sozN6HlkpmO4w3xyHl
    tNTMFfHP+bkH0AgNquq341W3WRjiR4XiubsMhC9TD4CpowPdDTHvSoZ5d0ev9Z2H
    yVId064m4ZY0EVvuu4hh1hbEKxb9E88CqaD9aticb5nsUOjj0HqwdPST8+RJFitw
    wgxC+R0YMaCFIMKCBhMv7BEzGQBlNYi/++L5f1spwgwZC+vHUSSEJ3+uus9dc6TA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cwZqvUD2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejjeelnecuvehluhhsthgvrhfuihiivgepfeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cwZqvUD2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejjeelnecuvehluhhsthgvrhfuihiivgepfeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965115AbeCSVg5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:36:57 -0400
Received: from mail-bl2nam02on0101.outbound.protection.outlook.com ([104.47.38.101]:39744
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965111AbeCSP7Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 051/281] i2c: mux: reg: put away the parent
 i2c adapter on probe failure
Thread-Topic: [PATCH AUTOSEL for 4.9 051/281] i2c: mux: reg: put away the
 parent i2c adapter on probe failure
Thread-Index: AQHTv5srx5TybjsH+0iDOo5Pk9E00g==
Date: Mon, 19 Mar 2018 15:58:50 +0000
Message-ID: <20180319155742.13731-51-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:Gm5mIKUX7NyEQNHxZCRCbwG3yqdQuancHwc8VXeiSjBEK9rVZz/O+8dieLNnFa0r3vSQb0BVrAQIK+4CEd/6fCJ7ZQupGI6bUamMSD7cRWJLGBmy02cO0bKzXWTMRBnupVdvKDrKNgzFMZNbJmt5fiewb7UCGL9J5svUhnkKulqZCgDK3ix3RZksllRpe6OzcW7Hee9jx1Ria/Dj+6cAYJVD+D74BzGBoaSY316lzXRst559kFezebGlFtphIh+J;20:NWrlfMa/H6ZcT8qomq7TbHlfLAo+TPsmrsQKfUgX7i42c/VQKzHiOYz8jFtmUaboHpAJ7j90HucuhwyWtJ0dey2pRU7P5csQLfXeeJfaRD8x/AvaVUc1zsNUGHuwEn6XUgYGnaXD14quiuIsQOQRx7F4bq0wc8BCvfjMMIxpKD0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f049afb4-4b55-4465-197d-08d58db25f4b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109B4A2151B569355853C80FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(575784001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: WcS927nfzQPAukQdguJ+KUigqyHCTPE0w7Nbbmid44RIoprda4wh5dGfc8uvISfmkVyu9Kf0jvk35BSOXvLiuqi/KIwxyMZQI7OHfr0t5jv+wtcQjrmMUhcOqgfs+i3sF+V1V9AzfjKkdErDQVq1VLiOEJmTF1kjkZUD4jEfr2trVAumrUvk4PBa9vMnog1xk+/PBSHobMFZAAxzAQO46I0VvTaHrQLbVnj/Wy1XPZZ2boWw+pExmqoKAun8pnWXr4NR0uPmSzuJgO6suHgJTpY4LpjuSojBBAFxbRSqK8jBDv76ubOtWzrOPhKvy24gqRE60ZanRi89n9DYJjOGBw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f049afb4-4b55-4465-197d-08d58db25f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:50.3001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 68118e0e73aa3a6291c8b9eb1ee708e05f110cea ]

It is only prudent to let go of resources that are not used.

Fixes: b3fdd32799d8 ("i2c: mux: Add register-based mux i2c-mux-reg")
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-re=
g.c
index c6a90b4a9c62..91b10afc8c34 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -196,20 +196,25 @@ static int i2c_mux_reg_probe(struct platform_device *=
pdev)
 		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		mux->data.reg_size =3D resource_size(res);
 		mux->data.reg =3D devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(mux->data.reg))
-			return PTR_ERR(mux->data.reg);
+		if (IS_ERR(mux->data.reg)) {
+			ret =3D PTR_ERR(mux->data.reg);
+			goto err_put_parent;
+		}
 	}
=20
 	if (mux->data.reg_size !=3D 4 && mux->data.reg_size !=3D 2 &&
 	    mux->data.reg_size !=3D 1) {
 		dev_err(&pdev->dev, "Invalid register size\n");
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto err_put_parent;
 	}
=20
 	muxc =3D i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values, 0, 0,
 			     i2c_mux_reg_select, NULL);
-	if (!muxc)
-		return -ENOMEM;
+	if (!muxc) {
+		ret =3D -ENOMEM;
+		goto err_put_parent;
+	}
 	muxc->priv =3D mux;
=20
 	platform_set_drvdata(pdev, muxc);
@@ -235,6 +240,8 @@ static int i2c_mux_reg_probe(struct platform_device *pd=
ev)
=20
 add_adapter_failed:
 	i2c_mux_del_adapters(muxc);
+err_put_parent:
+	i2c_put_adapter(parent);
=20
 	return ret;
 }
--=20
2.14.1
