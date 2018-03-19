Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498610-2-16576726737890417081
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
    t=1521498609; b=wnHe4Sr3DCMATLFq1ULJux0KMgxhRBtp7Py0UmkNzJmbYZP
    hOXbHTimO1xHISKMPicGnPnUqUlBMyAxaDOCcxBRf+L8F6v6MpyUxWGw57RYj6ya
    X14aqqta/y9UyBYf1CqN80qORBkB9pbMSvoHHzU0npPyKFJQgWU/TIs9wHl+fMOy
    FW/J0a/0LhtZgMm4jz4YUi9Z+g1H7cS7xIpk9hLTAQ3D4t3bIyuhkCTFwTPioOe0
    SuG9FQ5mzy/gH3+YZ+XZsAHBe7lPmWzGEOobZne5QMErzN5UnGf5WQUAtaazp+Sg
    F3X9wQrFJaDgbmcypzEJXVkLJKO4HnoNYWmLL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498609; bh=4FchJ+
    SVaykXLEKWv6/QOrC83v07UoRp8vfZcQHPMKs=; b=T+L/B84cvm9KhXWYao0yr+
    Zbh/y5LKcs36Dfi8P31getyFBdkOR2tMpoJVTwo9kP81Wj1OsZFgYG/ufo8CQP+N
    jAq/cFWjmtp+cu/09udl8zR5P/J3pyqeupt83WojTDQfd8DEJm9FRLB2gYLkj/mz
    5OH962o+kLUZI3KX7sK4FJQCxjQn2vgQbL7k8FZbyp/4ZJ9Tzf0eYDhSAVueeh13
    QVgk84cWj8hlqhDw+tdoFZiVkwagdTdZptJ6wHwvBvIimqWITvuhPBkeB51FzHlV
    oyYeUJqZuxHVx2YZGh46+E1Djz8Lc3p6+3EuUAU8HJaYRkilJwpSiPy+kdWJmb0g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RlGRL7j2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedvkeenucevlhhushhtvghrufhiiigvpeejie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RlGRL7j2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedvkeenucevlhhushhtvghrufhiiigvpeejie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936530AbeCSWaG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:30:06 -0400
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:16179
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933522AbeCSPsa (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        "Reported-by : Jason Kridner" <jkridner@beagleboard.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 052/124] gpio: label descriptors using the
 device name
Thread-Topic: [PATCH AUTOSEL for 4.15 052/124] gpio: label descriptors using
 the device name
Thread-Index: AQHTv5ml+sln5ZcwBkSMg1noXkQBXQ==
Date: Mon, 19 Mar 2018 15:47:54 +0000
Message-ID: <20180319154645.11350-52-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:jnORC4JQqwlQ2YYGePIpKHtm9t1dbneZQ2qNHZvn5j3dVMxZb91m2MnRDhkhHtB2q7Z4EynDi7tl4VU1ZrKeX4oi3roTGHXnS8ApLobpLqmHQBUU1+2zXzBVuv1gVScFwdV5/CSMBHudzSJNxuzrZnVl4OcoaK2kCwADbdVcrLEAdsb5XT29XLzsm9JX+kMKPnj/dO8iqTNG/5WC9ci6Rvp0naTBZCFw7pj4KpHfs2EGju3xsEsQKgOAkgsA7Q4Z;20:ItCoAxTxXzHRGc0Ym+ZyhYd0sSl289hKy+arF9nRNZmoqka4xIy20BjvsOB3nkWTY1qMURk2ZLpafs5WYGDcAKrVZK7+eOYliy2iAWazeBoBP+/rh1EJKfZEsQyu7L7JVq1Zh7gYRdHrMoDlabHmlR8LSX1lKGLNa4IW5WBq0zw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67d6edc2-f158-4025-2ebf-08d58db0d33d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031EA585D74E8C9E9E60FB6FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(59450400001)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(86362001)(53936002)(107886003)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SU7nwxjyDkgGecyRovQc09Ia0QyadCEylaD40h6x3poN1MSNWv6GmdnpkNeKPhBmg0VdWQ4vYLp8i1IKw/aT4izK2phmqFc7dWyJnSsnbQ0oNOOqXEGCQ+7s3OFaRaoG2DjhJ0CwfEyMa9ZbRLn+uff0gTpXMbuk7D9l6evzBeNNMNvwcLRArX7CY1Z/QFcCS19Q6KYnsUHUas7JUHerKNzIM+DLxcNI3yQuyib0Lg8eLTfgJ4q0l6diJ4Ukx7y/iyA2eywnJkv7qamIKGh/9U204tmV5hc/FkvIbmp5beJDGtUPyo9WCXtPtdyP0ythoQXhCw8jRLhsOk7QR8JZ8g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d6edc2-f158-4025-2ebf-08d58db0d33d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:54.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 8abdd0035091..c6c499691541 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3638,7 +3638,8 @@ struct gpio_desc *__must_check gpiod_get_index(struct=
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
