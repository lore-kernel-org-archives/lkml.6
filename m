Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474474-2-7470665304343534094
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474474; b=EKF3LCW8LpzzPJ7ZpiwLmARkLuDsTtE78kZUMiAU4JnYAvm
    3fy2JCmm37KHucQa9sSSESDF7SY0D8CNPCA4Fx5Vb4mp/X2oqWfRTjHpdb3WLtUI
    qoW5isjDiUSzFQ9LXMvM7F1koH8kaa7BgJ21VINhIX1FQNMXX+36BF72GBFG6PFJ
    utirtuCwffLscPFPsWOuVKdCmru+j06aKmxM9Gek225sEJuT25V8Loj2Zynf1I+9
    sMDKbmPpo6K+TZNQTp89Dx25QHCYVhrGnjIrnZCoerIooJAGRZgOtKOAcp6VsZoH
    xuqcjTl1KtruvwGgn1M/RQ0lN7zaGBoPZtk05Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521474474; bh=uGVenSM27XrPjnOfyk22zt6GWC2esnX7Jrn2DT
    oZI48=; b=BBO4cOPXMv7wum8im7Ecz8w2ennu08AJATQm+VFIxeryMttvNFnPf5
    XoRqD35GEAfHSfUB35wC2EaQgz/vkFRp4gK0HdPgeC9hsgrxYSUIsYBOJnSDZFJh
    2EwPsIlvSmDYqZc095AR9zrlqvaWqzFNQtHIkhKBk5c0DnBE+7W15Socc/sYrAZ6
    a4u+iedhuDSH2cz+ClmQOKRHptpFBwrwTBNcYlpvdRW5dVAejHkXI3qN+JflKTAx
    +hJDvQ9cAw0m3K0DE0E2fwxQFLfTl3wWyt1/n2mAlnQBaod/qBuHub/Bedbxblo0
    zqHFP3lcrtX8ovUx9zqo5yEGVOQHDsCg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l11MHSf4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeljedunecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l11MHSf4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthgsredttddtjeenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeljedunecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933034AbeCSPrs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:47:48 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:61852
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933522AbeCSPrl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 030/124] thermal/drivers/hisi: Remove bogus
 const from function return type
Thread-Topic: [PATCH AUTOSEL for 4.15 030/124] thermal/drivers/hisi: Remove
 bogus const from function return type
Thread-Index: AQHTv5mWtoSZtT9/Z0qioLswjR0Vxg==
Date: Mon, 19 Mar 2018 15:47:29 +0000
Message-ID: <20180319154645.11350-30-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:vXsaWPnESpgZYVU/Q6OGomj+XIfzX2EHPOzybN+lQGIrn2qWtBPxcpvm4gMORjFr0E3zJSydsY6379lE16lHF/DVxN56Sf9+pFqi01qK4Uk942W3UNj4xmJthPT9I1BYhueExu/A0cdvHJDdKQdqxnFRHlz5rfgUkSOCCcQ5jQkYONxuD5RkZqbm/5g9qbpOeoid5bv/VSfilP9hgbfQVc3TgMRIrdW/eFUvWgAIwntpzbhbj4ObfWwuXiG/3vlJ;20:hKmPgffWfJOe1Zksu1OQIsxi20GQ/VvwytWrghiv/tuoN3VCmT9p1uI2+hD4itApOtQA6qfzIVSfadNyuYhq8BujU/DN+8L7r1/6zM9AhAdFJfjcC+Z0QpFJkDbD/8lK6XKEoITxCb88SQ00aLAAYaANM6tKJBtqvLLrma9wybQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d2dffdf-3d2f-4395-382d-08d58db0b9ae
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998952DB6687AADF2C2B12BFBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(575784001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(39060400002)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ky+CNzPuWtnxxxNb+AcgPl04Ljbb2+rVvEWFXviwH5S45+5lNOuFw+Q/UKFTUwSmtq6V+v5qa8ssPnF3TXNLEJ5ILNSlBexsqDLKhD8nR9zXGviXMRv/1QLxKW2frKaMfRGcnBXJZTjhUd+HJKtNe6JxJQIMe6Q68/3sGCV6lYiG8f+EM1Vq8OAie5GMZuUVD+tGQBRfR9KrnEXNjVcD6aicAvBGtETO0G1QewonWJUUe33S0R0yCDebA4kSOI9zK+0FFa4EbkJhcjdY6+oCvgOKRA8bRI3dJj3QdJWuVBJ5GKGjRWmAg/OvPynI1lht1kf5jkfV4RyAr+bQ+A8KeQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE27DF3A9811C043947B08AFB6790538@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2dffdf-3d2f-4395-382d-08d58db0b9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:29.9047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCg0KWyBVcHN0
cmVhbSBjb21taXQgZDBlY2JiYmU1MThlMWIyNTZmY2RhMTc3MGVjMDZhNWExYTA1ODU2NyBdDQoN
CldpdGggZ2NjLTQuMS4yOg0KDQogICAgZHJpdmVycy90aGVybWFsL2hpc2lfdGhlcm1hbC5jOiBJ
biBmdW5jdGlvbiDigJhoaXNpX3RoZXJtYWxfcHJvYmXigJk6DQogICAgZHJpdmVycy90aGVybWFs
L2hpc2lfdGhlcm1hbC5jOjUzMDogd2FybmluZzogdHlwZSBxdWFsaWZpZXJzIGlnbm9yZWQgb24g
ZnVuY3Rpb24gcmV0dXJuIHR5cGUNCg0KUmVtb3ZlIHRoZSAiY29uc3QiIGtleXdvcmQgdG8gZml4
IHRoaXMuDQoNCkZpeGVzOiBhMTYwYTQ2NTI5NzM2MmM1ICgidGhlcm1hbC9kcml2ZXJzL2hpc2k6
IFByZXBhcmUgdG8gYWRkIHN1cHBvcnQgZm9yIG90aGVyIGhpc2kgcGxhdGZvcm1zIikNClNpZ25l
ZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQpTaWdu
ZWQtb2ZmLWJ5OiBFZHVhcmRvIFZhbGVudGluIDxlZHViZXp2YWxAZ21haWwuY29tPg0KU2lnbmVk
LW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0t
DQogZHJpdmVycy90aGVybWFsL2hpc2lfdGhlcm1hbC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90
aGVybWFsL2hpc2lfdGhlcm1hbC5jIGIvZHJpdmVycy90aGVybWFsL2hpc2lfdGhlcm1hbC5jDQpp
bmRleCAyZDg1NWE5NmNkZDkuLjc2MWQwNTU5YzI2OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdGhl
cm1hbC9oaXNpX3RoZXJtYWwuYw0KKysrIGIvZHJpdmVycy90aGVybWFsL2hpc2lfdGhlcm1hbC5j
DQpAQCAtNTI3LDcgKzUyNyw3IEBAIHN0YXRpYyB2b2lkIGhpc2lfdGhlcm1hbF90b2dnbGVfc2Vu
c29yKHN0cnVjdCBoaXNpX3RoZXJtYWxfc2Vuc29yICpzZW5zb3IsDQogc3RhdGljIGludCBoaXNp
X3RoZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQogCXN0cnVj
dCBoaXNpX3RoZXJtYWxfZGF0YSAqZGF0YTsNCi0JaW50IGNvbnN0ICgqcGxhdGZvcm1fcHJvYmUp
KHN0cnVjdCBoaXNpX3RoZXJtYWxfZGF0YSAqKTsNCisJaW50ICgqcGxhdGZvcm1fcHJvYmUpKHN0
cnVjdCBoaXNpX3RoZXJtYWxfZGF0YSAqKTsNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYt
PmRldjsNCiAJaW50IHJldDsNCiANCi0tIA0KMi4xNC4xDQo=
