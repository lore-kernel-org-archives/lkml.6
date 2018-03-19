Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521499136-2-18395984511206015643
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
    t=1521499136; b=brzsXCg6wcrI74xAdzvQvm+zVdj+smHvYkeiUfVQjUV5nQN
    qwX7+YsaAhMDedh7TCl+OTe7/YM9m8Em+R3mKCg6a0EUaYcPeO9qutkFkaaD3K7n
    iseTX6WJbUKyh2TJ8V+EiVGMQ/esl6u8AsG9Cmh8gamSL363wQVadLozE9tP2aLi
    /ZqkOWp27VTCGAameVGIXlctpmbg4X45XkA7a7JKOWrHa6xkqDdguulAyEoZhNhC
    4w27Fw38mxnBYveB+sR81UmelmeytiVVpZefWbkB/eycrQZ/1jK7hzFh+eJyZXRZ
    bwu8zqdCkq3UAcmqUsRiK0WoTg7a7bqXlDqSlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499136; bh=h/dSJO
    8G/yJEcA0R3COvCO11OnFoGj1fkQ3z8Pfg7jA=; b=Nx+Q+cHwSrbkF3qq0fQ3qJ
    o/JHXm5DAE3I+hCKBI75n3JzAESt9IKIO+aPaqkXxe6djmWfyakGtkHe0tdK0nRP
    0SjKAr2fZry6li9tOFcRZE+R4KS5f4/AS+TXcqoPC2XUkWu+bRII5h72tI+oEHis
    sekvfd9bwiIZNJyCGtxmvQ50Q3jILQoCQrzY00sVsLXveGjf98e7crU+tmcOUxvu
    n3qtlcMiknr/uzgasq0fsnFuBaoZ7JTjq4gOZ8R8wyhsz/I1Qf4wMfTrUui3HgdT
    CDvvbCg8k2Mh/JBYj5CBZQNdf4ZXIOYKIYYg4ONpUwcnuOfgbwaagj20IemDkv6w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PhFotW5p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeegtdenucevlhhushhtvghrufhiiigvpeeftd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PhFotW5p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeegtdenucevlhhushhtvghrufhiiigvpeeftd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933756AbeCSWho (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:37:44 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:59200
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933458AbeCSPrg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 027/124] gpiolib: don't dereference a desc
 before validation
Thread-Topic: [PATCH AUTOSEL for 4.15 027/124] gpiolib: don't dereference a
 desc before validation
Thread-Index: AQHTv5mUkSrK8FmWmEenI7Ey7hyD7g==
Date: Mon, 19 Mar 2018 15:47:26 +0000
Message-ID: <20180319154645.11350-27-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:dQSOKHa2Yw08B5YjXi2Y3vlIWCtZ65s29yJMHuSdXNko8KZe96xFOD+/CQrvoIBVWCLgD73yytshTlGMiw8kognaBev4pcMx1ggvbESO+yiuzdstUPBj2b8JD6hx6dI2gO5bvDqlZAGYsROVv55XeYz77zLww67Ap/b513Yeks83wHG2gZtaNASq5wuVfv5oGb4pGVzZqSD3Ef5uvENts2vqiHDZv8/hlqWcvTw6q/5XFxXB82mU5E+uJmrS3OhG;20:fW0fKbgbmjbY5kDc9CvJN53XOhrWJfVzf7R1DOIzQCy/sROhOGvtY6qELy4a9Qen6kJawwfcY2En8ff1+Wc1G2621G2zbwRL6aLPCJ4YUS8pDqNI1yGUv98B4Rbi70ma+wcpxinlLM/UfbSYWB2zESNVQLmuYIrpEmnXzdPOZcY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ecf5ab6f-aa1a-47f4-a2b7-08d58db0b8c9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09985A2AC021ED9EED932A08FBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(575784001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8eEG6clU03uh3HpbPCpZF3ATkjlWPN81/+XjcwVjVanXiWVYekpPWoXY09W5wb1dZkW6VoANpK+bk1PwXDvuP4yfqZ15bnBnpFK9zju/AWRn0AME8yBDEsqoMVO88ZOTk410GGZPV3H9AAz2sr3RYtgFGhv2DIyXaJ4jYdknimL5e/Dfn0H7e9NYJEsd7CHEpI4z3iEB8Ja2Khgsc06rqYgJsWZ0tWW3JMotYfxFhhYI1KcZtdIERKkuB7KwMX4trQGqIAwK5jzKm3AsJb5NDHOp/2gbtdMNnFvy8KKwFs8Q8yUl2MlOGAYDqski3gzyV4f9oMseuLFqlEEisf+TEw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf5ab6f-aa1a-47f4-a2b7-08d58db0b8c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:26.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vladimir Zapolskiy <vz@mleia.com>

[ Upstream commit 30322bcf82d74cad0d6e1cf9ba7fa7fa48c7a026 ]

The fix restores a proper validation of an input gpio desc, which
might be needed to deal with optional GPIOs correctly.

Fixes: 02e479808b5d ("gpio: Alter semantics of *raw* operations to actually=
 be raw")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f6efcf94f6ad..8abdd0035091 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2459,7 +2459,7 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output_raw);
  */
 int gpiod_direction_output(struct gpio_desc *desc, int value)
 {
-	struct gpio_chip *gc =3D desc->gdev->chip;
+	struct gpio_chip *gc;
 	int ret;
=20
 	VALIDATE_DESC(desc);
@@ -2476,6 +2476,7 @@ int gpiod_direction_output(struct gpio_desc *desc, in=
t value)
 		return -EIO;
 	}
=20
+	gc =3D desc->gdev->chip;
 	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags)) {
 		/* First see if we can enable open drain in hardware */
 		ret =3D gpio_set_drive_single_ended(gc, gpio_chip_hwgpio(desc),
--=20
2.14.1
