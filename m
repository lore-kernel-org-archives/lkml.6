Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497120-2-6429344854622385767
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
    t=1521497120; b=tjdiBejDKRtZPJOb+75xfo3qRDdN1BmmOKx9DnTA4nWEcHj
    qcOQkjqnVnNh2BRryAs8Y3H2eHCxt12jwUm0+6ovefnhDGKwbtYfCqRI1139yUD/
    uaEcGCbmE4L9EJWDRhPy3tRFiAqazB26P2MKmOHCfBmf5dgwLifJXoNixaXS1kO7
    3QKQta8PA4EFug+yVPsi4l78aESKlDVhVVxI3eONTSQRoz2+HnVcSsH1EFMmRe3P
    za4vuwvVntC59v18IssqheGL+UTJv/T12Rdruiz8ggGwrUJuxKAkexaDu8UA/gTU
    bLyc00qaI2ahmf5tpQXJDUGjcvdKPCvVtznaRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497120; bh=98Eu7y
    EWcyxNDBxcz6PwfJ8/H4xrNu7mYMwFZo8uayo=; b=uJVuChaQDl2DI5UI/6zQ5Y
    8VFZWFBqPdVgP5tQM4WLAkRtVt2CKUmbvvuAS96EjvUNrSyVful1IF00swbLmQpJ
    GAAlwtww+ZH3TOXAhORv13LrATasYRdTzw3OoGlTJRGX+CL1zlZmGMxw0X1RWxq6
    /HowRFWEvwswS9GDIE+7Oih22bMqYBOu7uF5O/URf+iprn+5urzH4pcVsM9jvDr8
    xMuSgTmVsLYENOa+bsLzyanojLgYN3iaTUhXI1dgD5pVjOhFRlRPR+P3290f0pUX
    QjceIlmIglH2WZ4W1Nnwb0EgMk59s6nEHfcmB7RAy9hLsP6uUK2y/QGX81XWNrXg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nMavLIuM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedvgeenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nMavLIuM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedvgeenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934437AbeCSWFH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:05:07 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:43956
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933827AbeCSPzq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        "Reported-by : Jason Kridner" <jkridner@beagleboard.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 39/97] gpio: label descriptors using the
 device name
Thread-Topic: [PATCH AUTOSEL for 4.14 39/97] gpio: label descriptors using the
 device name
Thread-Index: AQHTv5qsAN2EbUV2qUyg6Fm0yT2hNQ==
Date: Mon, 19 Mar 2018 15:55:15 +0000
Message-ID: <20180319155411.12348-39-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:aDoYkd8Y2ZNbaq6gBIDRpCdoy4n0Dkcsk9bjCwjJxa+1x6Uz7TnzAcpNVZkVsONOW35onlBV4X7HfZeuA+KQ/1DSx/Yen9OdinLsevq/d1PhTws9vZlgx7kyYAzTTzUK+I2d2P2QdO8zMzYsl/UQJAfZqu9G3xExOrsjoneo+4r4ukgc+VTer9q7ilkrcKNOQwr1UxNK/Bzhs3BrOpdjaR+z54/PutDcNjWR+fS48q5pbLxsiepv0mUy6aEUIYKW;20:oFLgT5/VR1VuWEV/nQl24bgNzMU+M5Fa8VhMM6Cejxz9IAEx5tf7obRDTXwQXyghQ4jQ6cO1uBKooMMJJqcB66IDUd6O+EYsNehAt8F6sQ6Ga1nonFH21NBd9XZvHePmwjnLQZAAitbTWs8ANNIXoNY5M7nrmUOJa0MJHGa2lnw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd3a3c16-2c44-4b20-5a99-08d58db1df48
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967821B4B17CB4CDDEDF98DFBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(59450400001)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 54QvOL5u4xLWEZEllP2rC/OqyfY07Yjm3RwxYlznmoYm28AYAOR6g9WkR1nO2uuXN+JXMx5ZSBRKO2zk6oMG/92h0bPrMnEQwbconv4wca2yudZGQzyd9ul188juM0SF9VicgojD5LSXkRaqUfpm+J+qkaavZZTuuUcmEkaYwXvJlvigVBnwk92FFTbNCUWsLnVmhO7oqxt107R1k2SnQQ1i/DfIDOM3LdtY0hY+QJi2enR465GBHVATkaraca7MxX5qq0uP5483jsnUOaiG6TMPUdel7v/iG4iPuz+OZeGd12PLNGakv8YVdrjUmhQgymIu+/NpAskaHiHExLScvw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3a3c16-2c44-4b20-5a99-08d58db1df48
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:15.9653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 24e78079bf2250874e33da2e7cfbb6db72d3caf4 ]

Some GPIO lines appear named "?" in the lsgpio dump due to their
requesting drivers not passing a reasonable label.

Most typically this happens if a device tree node just defines
gpios =3D <...> and not foo-gpios =3D <...>, the former gets named
"foo" and the latter gets named "?".

However the struct device passed in is always valid so let's
just label the GPIO with dev_name() on the device if no proper
label was passed.

Cc: Reported-by: Jason Kridner <jkridner@beagleboard.org>
Reported-by: Jason Kridner <jkridner@beagleboard.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bdd68ff197dc..b4c8b25453a6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3340,7 +3340,8 @@ struct gpio_desc *__must_check gpiod_get_index(struct=
 device *dev,
 		return desc;
 	}
=20
-	status =3D gpiod_request(desc, con_id);
+	/* If a connection label was passed use that, else use the device name as=
 label */
+	status =3D gpiod_request(desc, con_id ? con_id : dev_name(dev));
 	if (status < 0)
 		return ERR_PTR(status);
=20
--=20
2.14.1
