Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496280-2-880483230161616273
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521496279; b=SYsLlXKkR07geVqkPRNlfLOPG0+AZNoMqKYdFR4xmI8plQ5
    a5CrvOlyvmdhNw8Rm2xwKA48wygTmteRo/35GU4zugKqATiCTnzUGyQ5SNIiXzkM
    uMXQNj+nDsXK3qqIF3kY3msKr7wHhxk2vKN9Fx1wCYylRQ8YPQGLVCIbzrIJPU07
    RiYnYRb8PUM3P3tTsF++B8N7iST07S2M1RLHQPH8vU8TrSme6eMSMeAkS3xzlZwC
    2TQnI9oA/voIqZ2Pa0sczvp/zuGMQPPqBM+69R+doyuClJ31Pq7LCPgaI3SSHcHh
    LF8TeuJOsCZidzLLLMBd2fCw1vwNlTxoL6GuWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496279; bh=VzX6sx
    F90/WcE5h7shyIuoMIDYZ7fk2W2IRvd7g6n3I=; b=YHg3kNZRDKC8KbahDCGqEd
    toCmsedrwDchcPISsSBDOL2HGoY1RXiWQ+2qAieYlZaOwY/ZAI2vJV+mbPll2lPY
    loBCgU/w7FYpHgbsSo+hL/88sCj+9ikEz7I+SkaGXd3uAzrlekOQ5nHsJPT1KTnh
    BzU2DAFJwcI/a81hCmk+w1GsMEClIaR7gBwRSLBz4TljrqlOKDbZ82IRmp3ggQUm
    bJCCqvUYaT6zzPqlGKW4o5VcM1oM6UQ5zFn0ExqzEpvgrgsKdbQta8g6UrW11b/p
    Rq4SfMjCa5r/4floZhyKQD/nhy6jw2Cp/XoTwM7CdVl3Xe2X3gHXjt3guSVkPJ7g
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KxcRMUya x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdejheenucevlhhushhtvghrufhiiigvpedvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KxcRMUya x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdejheenucevlhhushhtvghrufhiiigvpedvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964868AbeCSVvC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:51:02 -0400
Received: from mail-by2nam01on0125.outbound.protection.outlook.com ([104.47.34.125]:56880
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964867AbeCSP55 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:57:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 004/281] rtc: snvs: fix an incorrect check of
 return value
Thread-Topic: [PATCH AUTOSEL for 4.9 004/281] rtc: snvs: fix an incorrect
 check of return value
Thread-Index: AQHTv5sJLphLEKtbQ0acE9Mc6AxACQ==
Date: Mon, 19 Mar 2018 15:57:52 +0000
Message-ID: <20180319155742.13731-4-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:oTYbjP4642Ejpv2i60KkfGR6unQkBb+xAvweioF9DemNqMEO9vS/RBwLJQlh41kn3x6/JuSW/8/zJ2c3AsUsTm/ge/hh+sTA/rzEN5gjNKT/hSyH0moIQeOVKz0Rqlk5NqSj2J4VYAQSJFJKHaXCuU7/Gc9NCdzS3XaN/a83kmU5I8xsj6b+bXl/BEIlN1Uf78rxRm4g/T1c69pWNRLGWTFJfBoOg/GdR65EJbSY0Kh6IE2TlHYujlUwGy+pcB31;20:MQlm2yXlQAU3rldZccqR4IGCED+isQUlfKpGGrIN9NEOY4xEM6wLXxOWJsXpN1U8IpchxyDRIoxxpC1ysyMxWf2GgCxl49e0jo91e/S3oA4ylGhouPUBLAboI+A2+Zu0V8bzbFJE3ZqPuVeqvO2McQvoGQas13Z5J6KILiDKWzE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5f0536b-c44a-4770-f596-08d58db22c2c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106429E8A7CB9DA1D6821341FBD40@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rbRM8nK5hZ4cLLvag7lUsq7hAMqRssQ3mW2swuLuwp7PrbtZ/HzM/V19dMkb0IegJMJjlHkQHD6wqWh5ImC3nGBAOqEHT+Gx1b1W0ki+ckVH0rvQhQG+9BwyelKq8pdj4qZ0B1TbNVcZU+M9Gs53jTiDXwoLP9X3FkZidR/KEupESp8C7ts3xaux+E4QFmaJeMepwxXbyh5RAHcjphiewFdl/zaRrbu8CyTOseubI40kL/QpbN+WLbQmdBs+sBUiS2qkQk0qHXEWg1OgpXk19r+kQLR4KBFtXVDn2OajB5OSxvo6STybmmPYxq+u0XbChDg4L5nKO0v07AKsqXYBRw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f0536b-c44a-4770-f596-08d58db22c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:57:52.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 758929005f06f954b7e1c87a1c9fdb44157b228f ]

Function devm_regmap_init_mmio() returns an ERR_PTR on error. However,
in function snvs_rtc_probe() its return value is checked against NULL.
This patch fixes it by checking the return value with IS_ERR().

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-snvs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 0f11c2a228e3..a753ef9c1459 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -257,7 +257,7 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 		of_property_read_u32(pdev->dev.of_node, "offset", &data->offset);
 	}
=20
-	if (!data->regmap) {
+	if (IS_ERR(data->regmap)) {
 		dev_err(&pdev->dev, "Can't find snvs syscon\n");
 		return -ENODEV;
 	}
--=20
2.14.1
