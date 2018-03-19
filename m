Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481744-2-14697864647494394451
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
    t=1521481743; b=r15h765tLqk+eADMj6uFixWKGylFOIrm8kgql9CCD5rvqUs
    AjkD/cujvthqKw/fpfIjxtC6fP2H8NG5Wu/6pLGetXir8rg/Qn6t+Z2ux0lv5L7a
    agXfYYg/DFBi8jC+1VFiXoJlrHI1t5yxWitt5WY50ylFAJH7U8OGg6n4yOaJ+Iz1
    ZBRj1Uuru/9yeaDVH2jzAAm24qubIy4tmmuE6/Bs8iP8Ntqa7VWvOUlOQ2RV20KD
    VyuBnm22kyir1mqp0HwinCLn+/s9Cb7UxSa8P35zG1aXK24s29IDzTKuhJIW8doV
    OBZvIz3lnWOE12zq8skBww1Q1zOqUNlzoj/1o9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481743; bh=sorEu0
    B+GHiy/h3K7R1+TKu6XeY/T3LJ8Wv2johT8kY=; b=V5sn81mAdJ+7pSCJ6fn9RY
    6Lj3nXGM7S03u9DC9s5gvsw+uM8uEOMrwUOkoYNd+mjUZa5wBzGEE0wgq8TnAwJf
    mQJ99K4Kdyl2kTy1r417OniFemIbjUuvlgbXw8Iw9gb1NF1oBgeVUFY5YSr+hapa
    ityKPctTnlnsqOZDHXXkU1HtpOb2s7OhWUsKQWuyT+xFeqlDJMZVHca+r3Qlj6dY
    4D099BIZ6Lcp9CAC83WF+Mth2Su3DNBfENx8wbcNxNS6+D8vPp+TjZg5cIaGIFBb
    pAeX5ZNGzCtwP5I1xFUOXeazbczqCFRQl4GHV+oJTux+oHYFWn0OE5bkv8EMppCg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dnmHYQWQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheegieenucevlhhushhtvghrufhiiigvpeegge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dnmHYQWQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheegieenucevlhhushhtvghrufhiiigvpeegge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965807AbeCSRtB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:49:01 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:45241
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965504AbeCSQFG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Heiner Kallweit <hkallweit1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 234/281] pinctrl: meson-gxbb: remove
 non-existing pin GPIOX_22
Thread-Topic: [PATCH AUTOSEL for 4.9 234/281] pinctrl: meson-gxbb: remove
 non-existing pin GPIOX_22
Thread-Index: AQHTv5uv5yIa2+rTL0azT3K7K09mXw==
Date: Mon, 19 Mar 2018 16:02:31 +0000
Message-ID: <20180319155742.13731-234-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:I8bnB20CaN5lJW2IaLNnuMNAyoeANEM67357oC/MICzsxzYqKOyDq0Lr9bXjuCW5nmI/TQcZ2ilFq9qOGU0ROMLwWit14jbhVYqR1Sd4/EiQpmaUt6SdlhUATPBfIksghnHAF1sHV01g1mWRJH+twN6lkJYv+i7/2LCZ6/Bi7fglfZ66BuwOtrcwPRpkF0nHvY/TJc62pAjDZ8MfFCbINioGcTWf6YihZEfM1W9ogpp5GZ+gIAaGI0PmyMehXq9J;20:jFuJYcyOoFqe59Fyuxv/KS52Sw4TyiVjwHLzlRbHS1hxZzOkF7EQnSK3RcvvGSbkza9zq3ony3Q8TYqAxHa8KE8cQ0BiqqgP8rx1OEJZl80A9gMimNq8T4Z4sL1MwTmwrkZpGrBvjiZQJFR8Qdv2vB6dV95zXS81BtsbED88IrE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9867639-dd13-47e0-022d-08d58db326bf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB088531E3AF22CDEDD1C832F1FBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(39060400002)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(575784001)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(59450400001)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: GYFYUc3XXOlpchJZGKMyq865N6ZcTtTxQdGRwzP5VcFQBXhgp59OkTIDZqz/BzJh2Ht9m6nOGpRCvXg6K7K5xjDg/pp/1wcwOh9KQxZpfBexucniX3Ch7KPEW7Rxe6Cu/TQh6oqAHDpf+bLQ1TmMyAkgxd2rBKIDgJSaFXDYhgDD6MDUT0iwIY8T9sbaaVKQfMFYSide4+xDLF88ujWAxUCofRE7VcrSKfc4RP6p6726JmUQWDlGyUrfLVdybwjzvHX+yfOI2UOm1aKjDxFcVRiyw9ObWa2MbKV7eF2gTTYQFbImjoiL69GtEvPAF9NHNsBrpaT//TqT5q0Dt48QUA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9867639-dd13-47e0-022d-08d58db326bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:31.5604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 4c8127cb523982e0a474ad80b14b665dc2f37b3b ]

After commit 34e61801a3b9 "pinctrl: meson-gxbb: Add missing GPIODV_18
pin entry" I started to get the following warning:

"meson-pinctrl c8834000.periphs:pinctrl@4b0: names 119 do not match
number of GPIOs 120"

It turned out that not the mentioned commit has a problem, it just
revealed another problem which had existed before.

There is no PIN GPIOX_22 on Meson GXBB.

Fixes: 468c234f9ed7 ("pinctrl: amlogic: Add support for Amlogic Meson GXBB =
SoC")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/m=
eson/pinctrl-meson-gxbb.c
index 7511723c6b05..257c1c2e5888 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -138,7 +138,6 @@ static const struct pinctrl_pin_desc meson_gxbb_periphs=
_pins[] =3D {
 	MESON_PIN(GPIOX_19, EE_OFF),
 	MESON_PIN(GPIOX_20, EE_OFF),
 	MESON_PIN(GPIOX_21, EE_OFF),
-	MESON_PIN(GPIOX_22, EE_OFF),
=20
 	MESON_PIN(GPIOCLK_0, EE_OFF),
 	MESON_PIN(GPIOCLK_1, EE_OFF),
--=20
2.14.1
