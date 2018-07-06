Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03840C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B914222BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B914222BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeGFVIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:08:54 -0400
Received: from mail-oln040092064019.outbound.protection.outlook.com ([40.92.64.19]:6885
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753751AbeGFVIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:08:51 -0400
Received: from VE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
 (10.152.2.55) by VE1EUR01HT136.eop-EUR01.prod.protection.outlook.com
 (10.152.3.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.906.15; Fri, 6
 Jul 2018 21:08:49 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com (10.152.2.54) by
 VE1EUR01FT022.mail.protection.outlook.com (10.152.2.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.906.15 via Frontend Transport; Fri, 6 Jul 2018 21:08:49 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::106:1799:3361:8e9a]) by AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::106:1799:3361:8e9a%2]) with mapi id 15.20.0930.016; Fri, 6 Jul 2018
 21:08:49 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix range checks in kernfs_get_target_path
Thread-Topic: [PATCH] Fix range checks in kernfs_get_target_path
Thread-Index: AQHUFW2IDxMQeexPRUWoBG/li+s+hQ==
Date:   Fri, 6 Jul 2018 21:08:49 +0000
Message-ID: <AM5PR0701MB26577F11198A56858D55C104E4470@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0373.eurprd05.prod.outlook.com
 (2603:10a6:7:94::32) To AM5PR0701MB2657.eurprd07.prod.outlook.com
 (2603:10a6:203:75::7)
x-incomingtopheadermarker: OriginalChecksum:8E0864D7123DA0A5EF402916C25A6DA6463ECD3C65327C76ECF535B0213938E8;UpperCasedChecksum:D8ACA1AB8BC65E7E89223FEA1DB460C8936507E52EDACDB2AEEF486B0CDE7AC4;SizeAsReceived:7410;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Ucin0v/k/U1Ljd0lpGyIFkxz+MyK3vSX]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR01HT136;7:NN5lEzeXK+Ta6o8XhUSdYZoTV68iNH5rdv7hCf6v5/5h/bo2OgzFy11vaanbG422havpeZegUjCkjoWhMq0pzWcNZsxU7XiJSv3JsSrg8Gkz1dGiis6WQomCyMerKwxGxVOtoGBDr296NpeIM4E7/miMc9dQLU+xQo3Pa8loPqzcw/WHiTkkCauGLw5fccBdjdIF7jy3MP7YvFnJDhAE1n00ezvdwQMY6aRGnt3tIFwsbOVoxsfn6pg73DMiCzMb
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101448)(1701031045);SRVR:VE1EUR01HT136;
x-ms-traffictypediagnostic: VE1EUR01HT136:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(444000031);SRVR:VE1EUR01HT136;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR01HT136;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(99286004)(74482002)(74316002)(5660300001)(105586002)(5250100002)(33656002)(106356001)(8936002)(305945005)(81156014)(2501003)(8676002)(68736007)(73972006)(75402003)(25786009)(110136005)(6436002)(82202002)(104016004)(2900100001)(9686003)(97736004)(486006)(44832011)(476003)(55016002)(14454004)(1857600001)(6506007)(386003)(14444005)(7696005)(256004)(102836004)(86362001)(6346003)(26005);DIR:OUT;SFP:1901;SCL:1;SRVR:VE1EUR01HT136;H:AM5PR0701MB2657.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:;
received-spf: None (protection.outlook.com: hotmail.de does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bernd.edlinger@hotmail.de; 
x-microsoft-antispam-message-info: oYSB7RHncXvlbpkZKq21txHN4F6rh0Ko61nD6wL/vLkNBsVOmWYigHKNDI7Jux7TIjL+JPozqo5N/hn+DQkq4pA/DQVppOMUrwyc7ViWWXKVjdUj3qFhvHAS8D43XIzSOZ2acAJ9IRaiBIBtCK5CewFdn/sD6uVwZX2fy4FG3s0HnL42xiatA0wNYbJHfDBMxI1ipAS0Vlx4vKKfj7U7bG6HYayPu3E54AFbzxvRVRY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <658E9E3413BF8041B39C2C1B3D19D67F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a6cf78-96b0-42d1-bfd5-08d5e384aaa6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 21:08:49.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHN0cm5jcHkgY2F1c2VzIGEgd2FybmluZyBbLVdzdHJpbmdvcC10cnVuY2F0aW9uXSBoZXJl
LA0Kd2hpY2ggaW5kaWNhdGVzIHRoYXQgaXQgbmV2ZXIgYXBwZW5kcyBhIE5VTCBieXRlIHRvIHRo
ZSBwYXRoLg0KVGhlIE5VTCBieXRlIGlzIG9ubHkgdGhlcmUgYmVjYXVzZSB0aGUgYnVmZmVyIGlz
IGFsbG9jYXRlZA0Kd2l0aCBremFsbG9jKFBBR0VfU0laRSwgR0ZQX0tFUk5FTCksIGJ1dCBzaW5j
ZSB0aGUgcmFuZ2UtY2hlY2sNCmlzIGFsc28gb2ZmLWJ5LW9uZSwgYW5kIFBBR0VfU0laRT09UEFU
SF9NQVggdGhlIHJldHVybmVkIHN0cmluZw0Kd2lsbCBub3QgYmUgemVyby10ZXJtaW5hdGVkIGlm
IGl0IGlzIGV4YWN0bHkgUEFUSF9NQVggY2hhcmFjdGVycy4NCkZ1cnRoZXJtb3JlIGFsc28gdGhl
IGluaXRpYWwgbG9vcCBtYXkgdGhlb3JldGljYWxseSBleGNlZWQgUEFUSF9NQVgNCmFuZCBjYXVz
ZSBhIGZhdWx0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBCZXJuZCBFZGxpbmdlciA8YmVybmQuZWRsaW5n
ZXJAaG90bWFpbC5kZT4NCi0tLQ0KICBmcy9rZXJuZnMvc3ltbGluay5jIHwgMTAgKysrKysrKy0t
LQ0KICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZnMva2VybmZzL3N5bWxpbmsuYyBiL2ZzL2tlcm5mcy9zeW1saW5rLmMNCmlu
ZGV4IDA4Y2NhYmQuLmM4YjdkNDRhIDEwMDY0NA0KLS0tIGEvZnMva2VybmZzL3N5bWxpbmsuYw0K
KysrIGIvZnMva2VybmZzL3N5bWxpbmsuYw0KQEAgLTYzLDcgKzYzLDEwIEBAIHN0YXRpYyBpbnQg
a2VybmZzX2dldF90YXJnZXRfcGF0aChzdHJ1Y3Qga2VybmZzX25vZGUgDQoqcGFyZW50LA0KICAJ
CWlmIChiYXNlID09IGtuKQ0KICAJCQlicmVhazsNCg0KLQkJc3RyY3B5KHMsICIuLi8iKTsNCisJ
CWlmICgocyAtIHBhdGgpICsgMyA+PSBQQVRIX01BWCkNCisJCQlyZXR1cm4gLUVOQU1FVE9PTE9O
RzsNCisNCisJCW1lbWNweShzLCAiLi4vIiwgMyk7DQogIAkJcyArPSAzOw0KICAJCWJhc2UgPSBi
YXNlLT5wYXJlbnQ7DQogIAl9DQpAQCAtNzksMTYgKzgyLDE3IEBAIHN0YXRpYyBpbnQga2VybmZz
X2dldF90YXJnZXRfcGF0aChzdHJ1Y3Qga2VybmZzX25vZGUgDQoqcGFyZW50LA0KICAJaWYgKGxl
biA8IDIpDQogIAkJcmV0dXJuIC1FSU5WQUw7DQogIAlsZW4tLTsNCi0JaWYgKChzIC0gcGF0aCkg
KyBsZW4gPiBQQVRIX01BWCkNCisJaWYgKChzIC0gcGF0aCkgKyBsZW4gPj0gUEFUSF9NQVgpDQog
IAkJcmV0dXJuIC1FTkFNRVRPT0xPTkc7DQoNCiAgCS8qIHJldmVyc2UgZmlsbHVwIG9mIHRhcmdl
dCBzdHJpbmcgZnJvbSB0YXJnZXQgdG8gYmFzZSAqLw0KICAJa24gPSB0YXJnZXQ7DQorCXNbbGVu
XSA9ICdcMCc7DQogIAl3aGlsZSAoa24tPnBhcmVudCAmJiBrbiAhPSBiYXNlKSB7DQogIAkJaW50
IHNsZW4gPSBzdHJsZW4oa24tPm5hbWUpOw0KDQogIAkJbGVuIC09IHNsZW47DQotCQlzdHJuY3B5
KHMgKyBsZW4sIGtuLT5uYW1lLCBzbGVuKTsNCisJCW1lbWNweShzICsgbGVuLCBrbi0+bmFtZSwg
c2xlbik7DQogIAkJaWYgKGxlbikNCiAgCQkJc1stLWxlbl0gPSAnLyc7DQoNCi0tIA0KMS45LjEN
Cg==
