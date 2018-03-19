Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494251-2-3847088055978659298
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
    t=1521494250; b=EK8NjPO17P05RpVTvIqTqy1lC7DYP4HO98Q+L81ZanMMiHT
    2HWWU7+Z2Mjh3fZoKqa4QlCWfZ2u4jsu7g9x7qZSBmJtjw1xb9Rb/6Vu1pWw/yGs
    P1h5sfzK1UQl4Ty/C6GOPRxSV3LZXDgxXRsxWGDolijVL8pOhiL0FxblVihlcTnO
    +5rjcJdkakvrAmkcmEd4QokzM87ySBi7LCNUQSuKqu020tku7bbO+frSlBGdmZOO
    iTvGHwHDw1d+FcId9cAMylItSEwMhlSitp2nQ9XI9Cw2FehSN+PVkV467ifbOF93
    UUbRlZaMypg0mSzzYlNWFkoYSrWmseQ9NYTjHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494250; bh=+hkY/h
    j2eA4o0H0fjcDpq3pwappfUGX1XtnaCvyqMqo=; b=aILOMGsRg07e7/1zmBh3Sk
    diUuR1ol3VyKOb9UeWkEMVkwLjCdB588/K0y9eo0V7XHNanK/NmhZtDm0AYOi0fx
    bdyMqIf2gQ/9jXW0Uu8n0GtEHlLUU19b5aVIE9d1QYmClhpY5BdBQrndVqY8bkvL
    dp3pfvszB8GSlnpd3EAtpqULJmqCAg6xpzEvxanfWPX4njufDkj/aokt5V3jF8aO
    Et/HbfEe8ro20C6TAh1wjgHh6ZjBmjq4eh5VbdRKPFN2tnh4536bZZ4EJOskvP7l
    Kc0GYWucGszTQiuB9/WsADZpebiyW1AC80xjHPV27XbPAsYa3vYsgD6m3wz66xfg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FypWYAOa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeegleenucevlhhushhtvghrufhiiigvpedvle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FypWYAOa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeegleenucevlhhushhtvghrufhiiigvpedvle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965253AbeCSVRR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:17:17 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:39043
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934913AbeCSQBH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 112/281] Input: elan_i2c - clear INT before
 resetting controller
Thread-Topic: [PATCH AUTOSEL for 4.9 112/281] Input: elan_i2c - clear INT
 before resetting controller
Thread-Index: AQHTv5tZ+x8H20mkDUqkAosyMZdAvQ==
Date: Mon, 19 Mar 2018 16:00:05 +0000
Message-ID: <20180319155742.13731-112-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:VAJThlYspU8xT22mRDQkQNpfohynAvmApiOJi3ItMKRZi8r+QsBVPwR/MrlutPWXiRXhCxj/KOeSrJqF73BqkBi+0UeThZ9uscAVr9YYJKRl7YbYTRRpUVjweHchn1xAKkz6Q1sn5497Br13TROxfcqbPcbGJQVi+hocB1OlIAx7puBahBRmJjTq6pKwPVtr9bjhB6AQE75eQ/FL60mOHgDP52RdZiub0HZSfc8wzjWkearK+i/Y42nlXvvenTRW;20:JLgDsUhyQHzdiNL3Rd/0v/kS4vKSGEWn0L36I63Yd7pWnVjX+8BvCVj0L0CjD0pNLnjeX3D3IQ6ffJ7Yqa1cACHfd8Vgo9wSoLop0aIq2xKVKNw6z9wjo3I1jqaBYhbL0RYRvvFfC6c4KbCeDpYz1Cb3UXd3jIPqeO3F+GthsM8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 023dee4d-4320-4f0f-ab59-08d58db29b38
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015F71BE54741C0135AD941FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(39060400002)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Z4hm4ca1UBjICJ3MAtxlh5qnrz/sMZse25OfgUlCBdY7fqKvyfNsRLR1796J+3mxXI4oyerflW7cOluQMK+x2f6MI3IVsiHuISxG76326FNgXg4MDi0QbKu57CowjsKse25yZbW/UJLa/dqpubjgWNlIAoIPB32CqziNoqYuq3ZChDVKJbejN2S0Oy948CttDMuR+/8QqYGBdtKzqbcN50zKmrY+HFmf/6feNjT7YM9/FepTPDI41jBLdfgU/qMwoSlpS6XqrJVUqftEtKWXi99TKQgq9JJR4Pa1rUaqkYLKejM9x2Q5864zSFxehRiNHVGYHOQjLlbYytFsItw3CQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023dee4d-4320-4f0f-ab59-08d58db29b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:06.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: KT Liao <kt.liao@emc.com.tw>

[ Upstream commit 4b3c7dbbfff0673e8a89575414b864d8b001d3bb ]

Some old touchpad FWs need to have interrupt cleared before issuing reset
command after updating firmware. We clear interrupt by attempting to read
full report from the controller, and discarding any data read.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/mouse/elan_i2c_i2c.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/elan_=
i2c_i2c.c
index a679e56c44cd..765879dcaf85 100644
--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -557,7 +557,14 @@ static int elan_i2c_finish_fw_update(struct i2c_client=
 *client,
 	long ret;
 	int error;
 	int len;
-	u8 buffer[ETP_I2C_INF_LENGTH];
+	u8 buffer[ETP_I2C_REPORT_LEN];
+
+	len =3D i2c_master_recv(client, buffer, ETP_I2C_REPORT_LEN);
+	if (len !=3D ETP_I2C_REPORT_LEN) {
+		error =3D len < 0 ? len : -EIO;
+		dev_warn(dev, "failed to read I2C data after FW WDT reset: %d (%d)\n",
+			error, len);
+	}
=20
 	reinit_completion(completion);
 	enable_irq(client->irq);
--=20
2.14.1
