Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521477718-2-11090726479853805989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477717; b=nZHr1Eo6oB2LzBwPcEBPwGPhq1th88/bStpEeJuSPRiR7+c
    IxrglXU6W6evbpLDBXHZJsI5sM6Z0IXgqLck+4ZhZunXWmdYYWyFke8ni2oLZLxF
    RPgoMbpERGtp5MylX0ZmcF6XMV1F4S1Q3zTCaUfs1Wg398Fd+9BpjS0uS/luHvBA
    qnjYyEkkGLt2AI4MgYi3JjWO2CMHjmG1NHyblNOeMeYguzo9eQUfi0axnjgDN5Pf
    UQ7fgbyIMUXEpDEq17/ZEw7q+PatgPuj+mkxDB4rOVC89dQZL+sSsrKHsETcAJFL
    MEbcnY3gBVIZ7x9VKftWTeBvROooyNsRRfMBs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477717; bh=XBG7Xg
    BYGcmZSh1mGUxn0Dnl54et3NobMy5KxbWZ9tQ=; b=LW8SsoBP+PUo7Z8vGbC/rQ
    xGZcJJwq98sCR+AAL9mATbZxYwQENHXzItyIE7QrcnoMasr2yvvfu8Fi+yCMPLzA
    HEJzgE8VEQjpSf/uu2aYWs0rlA2ssXZPbmuMj/aZCv41yBrY+dufopFNI+AhM/ho
    +9TEz6iXwGzX+CMQVYVmQK/53uw0e/PEofsbGJHejsKgY1UQ+eK9Fz+aCqMQqsnS
    cbjIuQcPM4Ad/DzWYlMtGAaF6erN1c/7nULD9YQQsj1eHcoCn4pnyVfnDHmrNfUk
    q9HPY2N8GOYDj4lorZeVIP79AdaePqswwdPDUBDsiAjLrBTNb1ZbB/dblq/zULfA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jjNsbnBT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduvdegnecuvehluhhsthgvrhfuihiivgepfedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jjNsbnBT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduvdegnecuvehluhhsthgvrhfuihiivgepfedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967241AbeCSQlZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:41:25 -0400
Received: from mail-co1nam03on0094.outbound.protection.outlook.com ([104.47.40.94]:52832
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966826AbeCSQMx (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tin Huynh <tnhuynh@apm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 039/102] leds: pca955x: Correct I2C
 Functionality
Thread-Topic: [PATCH AUTOSEL for 3.18 039/102] leds: pca955x: Correct I2C
 Functionality
Thread-Index: AQHTv50Pk3QpozcMnEWN61+6nt/g/w==
Date: Mon, 19 Mar 2018 16:12:21 +0000
Message-ID: <20180319161117.17833-39-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:qWzCkgPR4FU5sKnywmPCbWISqGYwXsKsL5M+W8vMZhyhbykNYbejEB6VMp+l2q4krmR8JG+PeEk+WiRcGiWD1KWLE1CysjqlFNk16MBAFHXp+FsRCwS9e2L9wf7pEO5nVSSJJjpMxSvPWL7yhDzYtXcA7KWaIACIaqJGnjs75yG46QVKAA/a/Ih0r/JL7bILqYaB8ATfU9mt7M6H/jGgWTzXZOT4ZI9wsUHqkpX8s8wzaaGgfJyNyFecw0j9vW/a;20:q4SWi88gX7IYkGxVqP8uZ2cqagNx1UiFhg5D4tM7CPaRDzo7WdGx7sNlwxLHYiqKX4+eLH3JNzwUey9yi6eavckWLQlzUeNcrVDmBIUDEpRgJLACjg2WKo0XmsBVuDi7uymFcrH2RAy9xmUvvznIy47zWjtDiuZwynJDbwMmjWs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b37cc183-24f3-4d06-7703-08d58db44357
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014475CD575DA8E315108E9FBD40@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6486002)(478600001)(5250100002)(102836004)(86612001)(1076002)(97736004)(575784001)(86362001)(99286004)(72206003)(2906002)(6436002)(107886003)(66066001)(6116002)(81156014)(10090500001)(81166006)(305945005)(8676002)(7736002)(68736007)(3846002)(110136005)(54906003)(26005)(3280700002)(105586002)(316002)(186003)(53936002)(8936002)(39060400002)(76176011)(2900100001)(59450400001)(6506007)(10290500003)(22452003)(2950100002)(36756003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: n6cs2Z/ZdO+QNm1XH/JDZ93VgiW5pVH/UTb3MLPsS4J5rmMx6Kd68pu4Db13c8LJTzWKWBP0icsa8dXXxa8BA7pDTGcho10GDROLhYZT+5vkkZmjpAQESLUHmLb9h9xLmA+DfvQIYHDevl7uRCvO8RncASx87GECbM5qs3KDmsuc30aWMub8mnQXUIwQnsMBV2UjJKMlDqwWmSQCVYDJNd7DtLuuVI3Bv+/rQt6VrH/ljUi35sf+KIy3TKdt8pHBKLA74gdbzWUo7fF8BrVodDLKpVOoVXFi17x+8AxgGeYw4T9qHk9r5VxADihqLxxwYLTYpmZnaok870aVIAw+kA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37cc183-24f3-4d06-7703-08d58db44357
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:21.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
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
index c3a08b60535b..760deffa9ad3 100644
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
