Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D78C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4F52082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4F52082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=live.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeH3Lok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:44:40 -0400
Received: from mail-oln040092254073.outbound.protection.outlook.com ([40.92.254.73]:51376
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727466AbeH3Lok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:44:40 -0400
Received: from HK2APC01FT046.eop-APC01.prod.protection.outlook.com
 (10.152.248.53) by HK2APC01HT030.eop-APC01.prod.protection.outlook.com
 (10.152.248.246) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.1101.10; Thu, 30
 Aug 2018 07:43:45 +0000
Received: from HK0PR06MB2561.apcprd06.prod.outlook.com (10.152.248.60) by
 HK2APC01FT046.mail.protection.outlook.com (10.152.249.180) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1101.10 via
 Frontend Transport; Thu, 30 Aug 2018 07:43:44 +0000
Received: from HK0PR06MB2561.apcprd06.prod.outlook.com
 ([fe80::5902:da9:e907:fe7d]) by HK0PR06MB2561.apcprd06.prod.outlook.com
 ([fe80::5902:da9:e907:fe7d%5]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 07:43:44 +0000
From:   Changwei Ge <gechangwei@live.cn>
To:     Larry Chen <lchen@suse.com>, "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: [Ocfs2-devel] [PATCH v4] fix crash on
 ocfs2_duplicate_clusters_by_page
Thread-Topic: [Ocfs2-devel] [PATCH v4] fix crash on
 ocfs2_duplicate_clusters_by_page
Thread-Index: AQHUQDUtksKoRiA7XkiDpbTdwtwk8Q==
Date:   Thu, 30 Aug 2018 07:43:44 +0000
Message-ID: <HK0PR06MB25613C564B9204533E7D4801D5080@HK0PR06MB2561.apcprd06.prod.outlook.com>
References: <20180830030654.20872-1-lchen@suse.com>
In-Reply-To: <20180830030654.20872-1-lchen@suse.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PU1PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::28) To HK0PR06MB2561.apcprd06.prod.outlook.com
 (2603:1096:203:6f::10)
x-incomingtopheadermarker: OriginalChecksum:6B2D2549136A25C6B7E9E55E8791E13B158465C35B61D0AA09CB7C866939CD76;UpperCasedChecksum:77DB97C8FEB6AAABE90EE85F540FA21866632E6E38D95237649A4255FD138295;SizeAsReceived:7631;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [tTPKhNwEdZR7/yOMENW55+4VDok05pOQ55ZZowyq7w4=]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2APC01HT030;6:aw/49LZ1Nh7IAr7cblWokW+PpEs48we12h7zx2URchcDFiAw5e0sCgQJf6UB04198pVV2RXhfwDGSni9xIkvCVG/bGVwI9nmo3qf/Uo2OSqRlAhgvUIQfp+qTtABSOZWayRW5Rsrh4sEnrJphf0t4nN4ElwlmFSz7lR4RNvuiHpp22z1OIGgUdBDF9QhwqfrWsDwZhxOSwjRsFJTZMqhpgI23Yc4mrZoZkm9LtBCKd1SUB3wMKjRHwKhfbLt3rPdONROyuQRKjxWrnOAXtyzew3byATAcRCzD/5iHGiazK4nOzLO65dRoWeiXa9KjjUFmXvS6YprzDy7lxs/sgoeomh0iwFnXgQsAzvT3bJDm1GYOR3q4D1IQT2l8wusys87oGrkRk434wb4YFW3zGxbhw6/oHSgQAF4phCF9wcGXhRLPMjPe+WF6hQKwCU74qmyamQeoh19EX+F9jwmkK7r0w==;5:jbcvjGRNL5qn0FvenpAslzAHV3bQk17rYN0UcKrvBaHAv3kROI2c3VCwFAsx+nRt0qAp1OIODFAA5v0UwwBO15BOL6E9VBXDvTOnQh5796EXBPKLohyVMaiEsZ9YVhNrJz9fXfzdXgJ2SJxCyUMjWg7oy44sMI5y3FU7yMQojVg=;7:6rI3gwYDUS1POn0uwTJx9YQkbVv8wpKP6iWxjhxbU7xE/GQ93pPBGDdy0H32XCbFsn2yFlZx/nYouYVPLJGVnsHDmOTzNUoChuEYnz4Gmfi3vYoNbZhs11zNS5b22w5g53mP0ZrRbFpZcwhucikZEgxVfudey0ueVmo4pr6v+vsRiOXJSHpzMAsd1+tgWgKGroMAR+A1O+NQLeHPH5zavOjIbT7ggN092B/GQIkD9d5H0D8jGlNVvHaNCYtStxS7
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:HK2APC01HT030;
x-ms-traffictypediagnostic: HK2APC01HT030:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:HK2APC01HT030;BCL:0;PCL:0;RULEID:;SRVR:HK2APC01HT030;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(5250100002)(5660300001)(11346002)(446003)(7696005)(2900100001)(14454004)(74482002)(25786009)(6346003)(26005)(102836004)(33656002)(68736007)(486006)(4326008)(97736004)(6506007)(2201001)(386003)(53546011)(9686003)(2501003)(86362001)(6246003)(76176011)(74316002)(56003)(305945005)(104016004)(6436002)(476003)(256004)(81156014)(8936002)(229853002)(54906003)(110136005)(55016002)(105586002)(106356001)(8676002)(15760500003)(99286004)(82202002)(81612004);DIR:OUT;SFP:1901;SCL:1;SRVR:HK2APC01HT030;H:HK0PR06MB2561.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: live.cn does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gechangwei@live.cn; 
x-microsoft-antispam-message-info: 092XzkfFKAH8iHkenepCJ9uG0rdtAFe/zQKYZ+AgaONg+GiV5d/C9sCkguMEjhCS0bNA5U/M1ogcbKQCLWEQjuaTBElxNSCE6PAzY13HtbsKRBl6zAY9zcURjNkK63a3azNVPoGw6aPKaLrbyUbSr70B1ugi3CXn8RSSOa/uNN2TUdQ+DQeRbkEc45L2sjpnMav3P1o3dGBCCsONgE5xr4S/Yo8/3z1Vjdmy4QreRME=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03A1B5578CAC774DBE0967159158336E@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f6f1fc-bf51-4187-67db-08d60e4c5007
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 07:43:44.8484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGFycnksDQoNCkRpZCB5b3UgZm9yZ2V0IHRvIGFkZCBwcmVmaXggJ29jZnMyOiAnIHRvIHlv
dXIgcGF0Y2ggdGl0bGUgbGluZT8NCg0KDQpPbiAyMDE4LzgvMzAgMTE6MDYsIExhcnJ5IENoZW4g
d3JvdGU6DQo+IG9jZnMyX2R1cGxpY2F0ZV9jbHVzdGVyc19ieV9wYWdlIG1heSBjcmFzaCBpZiBv
bmUgb2YgZXh0ZW50J3MgcGFnZXMgaXMgZGlydHkuDQo+IFdoZW4gYSBwYWdlIGhhcyBub3QgYmVl
biB3cml0dGVuIGJhY2ssIGl0IGlzIHN0aWxsIGluIGRpcnR5IHN0YXRlLiBJZg0KPiBvY2ZzMl9k
dXBsaWNhdGVfY2x1c3RlcnNfYnlfcGFnZSBpcyBjYWxsZWQgYWdhaW5zdCB0aGUNCj4gZGlydHkg
cGFnZSwgdGhlIGNyYXNoIGhhcHBlbnMuDQo+DQo+IFRvIGZpeCB0aGlzIGJ1Zywgd2UgY2FuIHdy
aXRlIGJhY2sgdGhlIHBhZ2UgcmF0aGVyIHRoYW4ganVzdCB3YWl0Lg0KPg0KPiBUaGUgZm9sbG93
aW5nIGlzIHRoZSBiYWNrIHRyYWNlIGR1bXA6DQo+DQo+IGtlcm5lbCBCVUcgYXQgL3Jvb3QvY29k
ZS9vY2ZzMi9yZWZjb3VudHRyZWUuYzoyOTYxIQ0KPiAJQlVHX09OKFBhZ2VEaXJ0eShwYWdlKSk7
DQo+IFtleGNlcHRpb24gUklQOiBvY2ZzMl9kdXBsaWNhdGVfY2x1c3RlcnNfYnlfcGFnZSs4MjJd
DQo+IF9fb2NmczJfbW92ZV9leHRlbnQrMHg4MC8weDQ1MCBbb2NmczJdDQo+ID8gX19vY2ZzMl9j
bGFpbV9jbHVzdGVycysweDEzMC8weDI1MCBbb2NmczJdDQo+IG9jZnMyX2RlZnJhZ19leHRlbnQr
MHg1YjgvMHg1ZTAgW29jZnMyXQ0KPiBfX29jZnMyX21vdmVfZXh0ZW50c19yYW5nZSsweDJhNC8w
eDQ3MCBbb2NmczJdDQo+IG9jZnMyX21vdmVfZXh0ZW50cysweDE4MC8weDNiMCBbb2NmczJdDQo+
ID8gb2NmczJfd2FpdF9mb3JfcmVjb3ZlcnkrMHgxMy8weDcwIFtvY2ZzMl0NCj4gb2NmczJfaW9j
dGxfbW92ZV9leHRlbnRzKzB4MTMzLzB4MmQwIFtvY2ZzMl0NCj4gb2NmczJfaW9jdGwrMHgyNTMv
MHg2NDAgW29jZnMyXQ0KPiBkb192ZnNfaW9jdGwrMHg5MC8weDVmMA0KPiBTeVNfaW9jdGwrMHg3
NC8weDgwDQo+IGRvX3N5c2NhbGxfNjQrMHg3NC8weDE0MA0KPiBlbnRyeV9TWVNDQUxMXzY0X2Fm
dGVyX2h3ZnJhbWUrMHgzZC8weGEyDQo+DQo+DQo+IENoYW5nZS1sb2c6DQo+IDEuIE9uY2Ugd2Ug
ZmluZCB0aGUgcGFnZSBpcyBkaXJ0eSwgd2UgZG8gbm90IHdhaXQgdW50aWwgaXQncyBjbGVhbiwN
Cj4gICAgIGJ1dCByYXRoZXIgd2UgdXNlIHdyaXRlX29uZV9wYWdlIHRvIHdyaXRlIGl0IGJhY2sN
Cj4NCj4gMi4gd3JpdGVfb25lX3BhZ2UgYXJndW1lbnRzIGxpc3QgY2hhbmdlZCwgYWRqdXN0IGFu
ZCByZXRlc3QgdGhpcyBwYXRjaC4NCj4NCj4gMy4gQ29tbWVudHMgaGFzIGJlZW4gY2hhbmdlZA0K
Pg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMYXJyeSBDaGVuIDxsY2hlbkBzdXNlLmNvbT4NCj4gLS0t
DQo+ICAgZnMvb2NmczIvcmVmY291bnR0cmVlLmMgfCAxNiArKysrKysrKysrKystLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9mcy9vY2ZzMi9yZWZjb3VudHRyZWUuYyBiL2ZzL29jZnMyL3JlZmNvdW50dHJl
ZS5jDQo+IGluZGV4IDc4Njk2MjJhZjIyYS4uZWQ4NGQwNWM3ZDAwIDEwMDY0NA0KPiAtLS0gYS9m
cy9vY2ZzMi9yZWZjb3VudHRyZWUuYw0KPiArKysgYi9mcy9vY2ZzMi9yZWZjb3VudHRyZWUuYw0K
PiBAQCAtMjk0Niw2ICsyOTQ2LDcgQEAgaW50IG9jZnMyX2R1cGxpY2F0ZV9jbHVzdGVyc19ieV9w
YWdlKGhhbmRsZV90ICpoYW5kbGUsDQo+ICAgCQlpZiAobWFwX2VuZCAmIChQQUdFX1NJWkUgLSAx
KSkNCj4gICAJCQl0byA9IG1hcF9lbmQgJiAoUEFHRV9TSVpFIC0gMSk7DQo+ICAgDQo+ICtyZXRy
eToNCj4gICAJCXBhZ2UgPSBmaW5kX29yX2NyZWF0ZV9wYWdlKG1hcHBpbmcsIHBhZ2VfaW5kZXgs
IEdGUF9OT0ZTKTsNCj4gICAJCWlmICghcGFnZSkgew0KPiAgIAkJCXJldCA9IC1FTk9NRU07DQo+
IEBAIC0yOTU0LDExICsyOTU1LDE4IEBAIGludCBvY2ZzMl9kdXBsaWNhdGVfY2x1c3RlcnNfYnlf
cGFnZShoYW5kbGVfdCAqaGFuZGxlLA0KPiAgIAkJfQ0KPiAgIA0KPiAgIAkJLyoNCj4gLQkJICog
SW4gY2FzZSBQQUdFX1NJWkUgPD0gQ0xVU1RFUl9TSVpFLCBUaGlzIHBhZ2UNCj4gLQkJICogY2Fu
J3QgYmUgZGlydGllZCBiZWZvcmUgd2UgQ29XIGl0IG91dC4NCj4gKwkJICogSW4gY2FzZSBQQUdF
X1NJWkUgPD0gQ0xVU1RFUl9TSVpFLCB3ZSBkbyBub3QgZXhwZWN0IGEgZGlydHkgcGFnZSwNCj4g
KwkJICogc28gd3JpdGUgaXQgYmFjay4NCj4gICAJCSAqLw0KPiAtCQlpZiAoUEFHRV9TSVpFIDw9
IE9DRlMyX1NCKHNiKS0+c19jbHVzdGVyc2l6ZSkNCj4gLQkJCUJVR19PTihQYWdlRGlydHkocGFn
ZSkpOw0KPiArCQlpZiAoUEFHRV9TSVpFIDw9IE9DRlMyX1NCKHNiKS0+c19jbHVzdGVyc2l6ZSkg
ew0KPiArCQkJaWYgKFBhZ2VEaXJ0eShwYWdlKSkgew0KPiArCQkJCS8qDQo+ICsJCQkJICogd3Jp
dGVfb25fcGFnZSB3aWxsIHVubG9jayB0aGUgcGFnZSBvbiByZXR1cm4NCj4gKwkJCQkgKi8NCj4g
KwkJCQlyZXQgPSB3cml0ZV9vbmVfcGFnZShwYWdlKTsNCj4gKwkJCQlnb3RvIHJldHJ5Ow0KPiAr
CQkJfQ0KPiArCQl9DQo+ICAgDQo+ICAgCQlpZiAoIVBhZ2VVcHRvZGF0ZShwYWdlKSkgew0KPiAg
IAkJCXJldCA9IGJsb2NrX3JlYWRfZnVsbF9wYWdlKHBhZ2UsIG9jZnMyX2dldF9ibG9jayk7DQoN
Cg==
