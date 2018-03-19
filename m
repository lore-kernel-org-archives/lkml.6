Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480605-2-1009692640824984595
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
    t=1521480605; b=BGDkz4kUT+rdokkeUmjXlyeT83LlwP59Qx+BYsgErE5vp4P
    hl4Ol/r2nZ6NT2pRpKNcKyqPBbIXKaXSIk87BcGmROtHJmoQUnSPcU/mTxYD6DDr
    GSAcFt8QfOh98bqta7LW76wTTHpL6C1hp4CtJ8tp33c9eFcSRSw3kDNAndHfrbGO
    mgPrt8/ivbnW2abrhN3clMMGh8IN6b9oKopstNgEPQ+lKWvkqZ0q4w3K5KtXSg1V
    oeKaFIC6S5tPwJazpUsRiCWWaEXxIGhwvZlV3pqFOnSiv7B6O1qCmjXhANFlKDSh
    uLUJja+J7iWJ7szQpmROXVF2B80GwaLWSA4+iQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480605; bh=aFgOkm
    qua8OgPFlgk5DuUkOmrHjrA/HnluhotHo0HFM=; b=WP/5nSe3mYMVbXjO3Dac5l
    lXwKbddOyYCBTeuAf/mnVwUrM8MqIIPBwkHOxHEYZDg4Ztk7iAXoRSmoDNIGbn+r
    U2TltxULxKCjzxMqtX72RiQVOjdLlWfIg85tGMEvLMXmKKlqwIBasa+lQhCdnRiB
    LJ0pRANfZsOtSR05fg5Tm7LC8/l2EkAb7t4xApoe8unNFP8fg4WLnaPe19B9P7C8
    iZhY6RpXU7oxrp1cgiZJqjyYw8gHVT18T1Yhcfwuz1EcQhEWbOAfxjlqgD7QD+Y9
    aPY7EBsTiiLwDWNJwCCcF58VJKvGtKgRxo9iPLMhGF0DcAb05mjU5RkgdEE9U2Lw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gFlipvCQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudekheenucevlhhushhtvghrufhiiigvpeejke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gFlipvCQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudekheenucevlhhushhtvghrufhiiigvpeejke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966068AbeCSQHL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:07:11 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:20505
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966064AbeCSQHA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 024/167] Input: elan_i2c - check if device is
 there before really probing
Thread-Topic: [PATCH AUTOSEL for 4.4 024/167] Input: elan_i2c - check if
 device is there before really probing
Thread-Index: AQHTv5wmd4xxesW2mUu6M1lp8DkkUQ==
Date: Mon, 19 Mar 2018 16:05:51 +0000
Message-ID: <20180319160513.16384-24-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:LBKnHHdjwb2kp9GJBChhziyLQMBfIxaaGzogfPHPp7rgd2yRl4rkrQfxWHFin954qkkJVK+6m0FB8QXlkCXxYLvqqVeqtPVnNShAIxvOs4ziFnEPF+GuP4aifikpHW7z6/+h91Jw1cHX1hS85sqyue50/RdeM+bhZfT/sytyOGrO1/NToKlBzOKepW3Cz48EW0eyJjCfSOGgq1AN8nzSgZvuXhdM5qTX2Rj6vTUBX3d1BmfTd5xKcqGTbegma7NN;20:rcgkvFEF+Mvu1iTfMUm0XbrTtSaHsSXzJSTrkAU7tK6G93kekI0BIRzydKOMPli9YADZWqaQujKb9QszA3xZWOTAf3nA1KaIkw4OVlerQmfX+UYfgS0XWLyBhZa3th80+H6lIWzC/4XvA/GBJkAwzi1A/W/N9LonjnD5GK164qY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae62d326-5180-4f49-663f-08d58db36dea
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10930BAF3705927BE5BE138FFBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(76176011)(107886003)(2950100002)(39060400002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 3Yu2iu1cEuakYHRhu8fYxSnD8l0dW5CWW5IS8z9ZDWTkHS9QpOOWSeuDoebaWF6XJa6fpsgN9Aucd1Cd+K2sfRYVzZbTTX+FLMmwiNYfggUMJovn/4r3uvrt7kzmyofvVmHzZxzV/h6+tRw4feEK+QnaHj2oInJQrB+nQdsIAT+liLyuAXuihmCYJtM0qb/TvGEIS9i5d380Ob8zBKbArE9z583Ak8IT3XQYsc9RNbWjVc/xhZFVWLRIMxovcy48FUp79BNLCNFwlFLXIap/M/E69WsMsmCdUuDtjIrGK8gspNrxnKb/r4jy0wyS2YQxYs4YrtLzJ9K93xvF+YLIXw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae62d326-5180-4f49-663f-08d58db36dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:51.0517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit c5928551fd41b2eecdad78fa2be2a4a13ed5fde9 ]

Before trying to properly initialize the touchpad and generate bunch of
errors, let's first see it there is anything at the given address. If we
get error, fail silently with -ENXIO.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/mouse/elan_i2c_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan=
_i2c_core.c
index c9d491bc85e0..3851d5715772 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1082,6 +1082,13 @@ static int elan_probe(struct i2c_client *client,
 		return error;
 	}
=20
+	/* Make sure there is something at this address */
+	error =3D i2c_smbus_read_byte(client);
+	if (error < 0) {
+		dev_dbg(&client->dev, "nothing at this address: %d\n", error);
+		return -ENXIO;
+	}
+
 	/* Initialize the touchpad. */
 	error =3D elan_initialize(data);
 	if (error)
--=20
2.14.1
