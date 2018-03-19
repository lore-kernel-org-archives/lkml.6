Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495683-2-5686122159612161972
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
    t=1521495682; b=JafEq0B+cHcuu4aDoU1M399Of+8q+LgtnvZs5Mm4J1S/kqi
    IQp9DyoQ0gWM4hmRT9I9XwI+KV5Vi5MEM4N9nE4yR/q08iou/ppCtvy32M25ObyS
    hkazL92zl3ekuAPz/c7A6sXd1+Jft1NEOpT0ngcVIYBTkGFAAs3SDEneW0QGbp7F
    SJBrTJ2zm87EAVXTXSDU3FpwIkaT60gVB/rNeXXP3ajHHFrjLlltgKPz4o9ckvQU
    74CHiW8+oFwl+BxCHDtYd2DpDXU20I07uCfX/XtiyFFVvt3p/+Go9+8udrmaU9BC
    JoW1BODzP2uU6dc4NRjTxFp7A/m7OjLzHFq4BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495682; bh=aFgOkm
    qua8OgPFlgk5DuUkOmrHjrA/HnluhotHo0HFM=; b=ILhj2CNJO+Cy4WfnYN0AvR
    1E3XAdrfYbXvePwcRBBVAlGY50lj0Ngi2OGD6H/huLODxxq7lI1HGBdSWyJ6aU6C
    mkUnV0el+8c8yIdskZOSG9TKYbVkPRlAys8dd8HDo1kHipp4rq82zyxCY482GSUl
    xfSBtzR72hT+CxQqqs7MT9ZBK0mD5G7rQZtL/slFqxyqOgGuiJUtHuqYCmrgEs+J
    W6RVB4QRyM5q0GQfaXTGHEnIiQp8/45ki0scUTVYPI3yaaha2Uam2g6gx9o5BHPf
    +nBa1Bd3fD2Et3qiCh39fpcsQQ4lOnigZHc7bCPThDLj7FBewT+NkSAHNFV4EF9Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QG9CGlBT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudelvdenucevlhhushhtvghrufhiiigvpeegje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QG9CGlBT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudelvdenucevlhhushhtvghrufhiiigvpeegje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965017AbeCSVlO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:41:14 -0400
Received: from mail-by2nam01on0118.outbound.protection.outlook.com ([104.47.34.118]:14025
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934719AbeCSP7A (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 033/281] Input: elan_i2c - check if device is
 there before really probing
Thread-Topic: [PATCH AUTOSEL for 4.9 033/281] Input: elan_i2c - check if
 device is there before really probing
Thread-Index: AQHTv5sfx2WzBfnQ4EyT7VpBL7JM6Q==
Date: Mon, 19 Mar 2018 15:58:29 +0000
Message-ID: <20180319155742.13731-33-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:oJIHxTyb0kN3ES9wXSHbJ/1gHXVq4Jm7ZOR7S0dPL8oWPsL+X51lRTTNFkdtTQfBYZg/T091NbfFN8xQlpNO8geCu9Hll22XmPZxBRoZIsaZuaF6mY1dag0A/KU8lS+sfurOzsdesm6bjHZ1R4ssLLccyKzxKGP8aIpMf5QKWHXkevjjIZhYOnbiB94D9aKieJAM8+dsbD4TqLFgvYAh1FnZObvb9wDfjZETJI8dF4JixNDwdkDbhJzC2JsitiwM;20:gD40py0+i/xocUqFf1+YEf+JZtTF/BpVDB5RV3OGWTKUKdDAGDtmfmCWNt02HWI4upT7UMfTCzDWtER75KCbmX2CX7MbtwmsjzHk3rBlYDLm+Ian6rTobQbxoxD9kQXXzNwKNcUw7YaUaIr8eji9LOX+ZgoFT1yJgceY/pRKVPU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0429e8f5-c7c5-4a2f-b1fa-08d58db253b5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07264E8316457D7DF8D5CB4EFBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(6666003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(186003)(39060400002)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sfyLu7G63eNvPkYvVl7tUl+eBTuHRW2HSj98BCq2A58kUOMml49ZMgFAC5vgg3ACFXK+4VmD9NqjDeV2HMPa/FRkcZLn7prHms2pjg8LCeiqlOuHKdUTElndtbfFe3SPSHDuQCYae+ccqmt9fnhGQzJ8/T3dYc2HYWzjPx1ANXdU2ljs9nWP90mpgYGPAfCBiadsh0LzDNqCDtKWGUW5IBKLprFvXVAezi40e3Ob5/WNgg1owWB/75mYaZlavUqdbAwoxc83Yqz5Yl+6ZeOSXbR8jv5PAFb87IY6s3HFBaI309NB+TO5kLmOdHzo8+wnU1GS2T9espO0/BprEqHbNg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0429e8f5-c7c5-4a2f-b1fa-08d58db253b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:29.3929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
