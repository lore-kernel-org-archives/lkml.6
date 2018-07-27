Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C64C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A54E205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="WNkrM8Wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A54E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbeG0Rqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:46:40 -0400
Received: from mail-eopbgr730121.outbound.protection.outlook.com ([40.107.73.121]:26356
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730516AbeG0Rqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXeOqd6cKkmW1lH6AtuuGCmx0qMl86t1Uj/jyquAj+Y=;
 b=WNkrM8WfXizYMQWEIAQQdIJYmE9wfGw55w9beyON4EQdpS1aelF76P/A7W0SVqpS/Ptw+saxkpJWKVZIpOtuWvPLaevqf5TQGvvXBAPnVNTD5vG2W5zPg/S+YOgJyt8tG+Pj1S8ANCHrkqcb0R2GX2Fx3TQCrHSguRC+zPWi6jQ=
Received: from BYAPR04MB4760.namprd04.prod.outlook.com (52.135.240.79) by
 BYAPR04MB4680.namprd04.prod.outlook.com (52.135.240.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.22; Fri, 27 Jul 2018 16:23:43 +0000
Received: from BYAPR04MB4760.namprd04.prod.outlook.com
 ([fe80::44e2:1ff2:21d5:5b45]) by BYAPR04MB4760.namprd04.prod.outlook.com
 ([fe80::44e2:1ff2:21d5:5b45%3]) with mapi id 15.20.0973.022; Fri, 27 Jul 2018
 16:23:41 +0000
From:   "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chuanjin Pang (WH)" <chuanjin.pang@bayhubtech.com>,
        "Mike Li (WH)" <mike.li@bayhubtech.com>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Bobby Wu (WH)" <bobby.wu@bayhubtech.com>
Subject: [PATCH V8 2/5] mmc: sdhci: Change O2 Host HS200 mode clock frequency
 to 200MHz
Thread-Topic: [PATCH V8 2/5] mmc: sdhci: Change O2 Host HS200 mode clock
 frequency to 200MHz
Thread-Index: AdQlxhUr6YbZUmHxRYOjRyJK87Krqw==
Date:   Fri, 27 Jul 2018 16:23:40 +0000
Message-ID: <BYAPR04MB476082C4951D3D7EE47B3881E52A0@BYAPR04MB4760.namprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
x-originating-ip: [45.77.188.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4680;6:+ZngHJKFelKQ83VFt1nI56GFbJPCTlOixvJvI8S2AYq+Z4k/mr+6i+vvDfeN4ydkDorAmHylSaL/lft7+3pQNyEhvNRWhJ9ar8t3P4ow6WMiyEt7I4dyD4fDveAGACuBY9KhEXJjjITaGB8J1+c/k0qde8DYDnKLqdsKLjgNzBoyistchDiZMlic7VuDWuEi3W2Y4mbdfME95jv1Zzvavzr1IWPik+zNB1JTvPgEJPIFPU3Orfvv2lneLRETAavpCgchDqBPQCO242B57iQtxHcgAVbpxF0upqZ9fP9j51CBDEzPYYidkxZONB//nvFMrXy/kTcbEnjHD6qXu35OTsJ1UPhWLm64CefJlyHIxtVpn5QAn1iq4+ALCtbWVOz+irqH+W3W751iEWAn/P0couhcWXi+YNZF6Nr/HqGilXdjs0LBisWTwNrY4IdqOdGefwhxFkGUHZwc7mCULjjnKA==;5:ZxtCD/c4dmOJ/8W3xTkE/0gy9VUXJ4BNRHthSNAY4kcMbaofYI9j0vDLqi+M0GhscJvoqm9wUQxxuUzeGmchD1+8rL7mZjziYKA9a0afY7eK3D1cXmaiVMHtBfgDM2ThTefbKBGXsdsNknFwJqILArH9XR8UPAM415n0aP+4a9I=;7:eD6TIBoYZOOGb+O2pE7bQeFsfFvqhTMJIFQXVBojEDS72C5yL+NdDjAMPec0j/kuArr6nXMNAGhG+adpzKy/KcAqOGjxggljc9mdu4SY4vzYVl1nvmqzn5HXmpIFs+l0ZC0vtKjM6GKWsuPTmtDtUY2lfPp3ttjlcZ+WHPCH3NMENe1QpCBqTigVyQ09tozfQoYZFquw+2acl29odoCq2+bQTOx/vcW9WRl8YUvGC5G82elzQRGpaJM/kfM/AV3O
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(136003)(39830400003)(396003)(376002)(346002)(189003)(199004)(13464003)(57704003)(6116002)(53936002)(86362001)(105586002)(316002)(53546011)(106356001)(110136005)(3846002)(4326008)(5660300001)(25786009)(99286004)(2906002)(54906003)(107886003)(97736004)(14454004)(478600001)(66066001)(8676002)(8936002)(81166006)(33656002)(26005)(2201001)(74316002)(81156014)(7736002)(305945005)(6436002)(102836004)(476003)(55236004)(186003)(486006)(2501003)(9686003)(6506007)(55016002)(2900100001)(68736007)(7696005)(256004)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4680;H:BYAPR04MB4760.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: c783c8a0-bf22-4501-1ba6-08d5f3dd50b3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(7168020)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4680;
x-ms-traffictypediagnostic: BYAPR04MB4680:
x-microsoft-antispam-prvs: <BYAPR04MB46807CFB396E3D8701520EC4E52A0@BYAPR04MB4680.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR04MB4680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB4680;
x-forefront-prvs: 07467C4D33
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t02D5oj6yuUPecjI3Myj4AgdtnnwSPcTCFpdLvHKBhrshZXPGqmOOfeqyXMRlf4dYKbGgWCVIzA4k9ITqSc0QK5YHBSWGy44lE+apXRUOJOaScJUufewJHkyeHlEGrdx6kA4m13j0WeLNJQ3bKTcngVErqiGuIyaPeh5Dl7F7K4orb6IZqchT/Pjl3tsaLAZm1+2x4dKHJj8jc2NwYxB2/3eYsyDarKU806BKLGHOmmX62rcmGSbAa8L16quHzhTNitmgmnMEaeliO9rimHv4fSV1e7LN03gDIGOmpbi7sT3LLbIcogCFEJTUAcHeZfhP0KI6wYbFXQFnALMRS3YeI6ErNwOf4aZ3cPhWMZ9Txk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c783c8a0-bf22-4501-1ba6-08d5f3dd50b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 16:23:40.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TzIgU0QgSG9zdCBIUzIwMCBtb2RlIGNsb2NrIGZyZXF1ZW5jeSBjdXJyZW50IGlzIDIwOE1Ieiwg
c2hvdWxkIGJlIGNoYW5nZWQgdG8gMjAwTUh6IHRvIG1lZXQgc3BlY2lmaWNhdGlvbi4NCg0KU2ln
bmVkLW9mZi1ieTogZXJuZXN0LnpoYW5nIDxlcm5lc3QuemhhbmdAYmF5aHVidGVjaC5jb20+DQot
LS0NCkNoYW5nZSBpbiBWODoNCglUaGUgc2V0IGJhc2UgY2xvY2sgY29kZSBjb21tZW50IGhhcyBi
ZWVuIGNoYW5nZWQgaW4gYWNjb3JkYW5jZSB3aXRoDQoJY29kZSBjaGFuZ2UgaW4gVjcuDQoNCkNo
YW5nZSBpbiBWNzoNCglDaGFuZ2UgSFMyMDAgbW9kZSBjbG9jayBmcmVxdWVuY3kgZnJvbSAyMDhN
SHogdG8gMjAwTUh6IHRvIG1lZXQNCglTcGVjaWZpY2F0aW9uLg0KDQpDaGFuZ2UgaW4gVjF+VjY6
DQoJTi9BDQotLS0NCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1vMm1pY3JvLmMgfCA2ICsr
Ky0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1vMm1pY3JvLmMgYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1vMm1pY3JvLmMNCmluZGV4IGJhNTlkYjZhMTI2Yy4uOWU3
YmFjZGE0NzE3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNy
by5jDQorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1vMm1pY3JvLmMNCkBAIC0zMTEs
OSArMzExLDkgQEAgaW50IHNkaGNpX3BjaV9vMl9wcm9iZShzdHJ1Y3Qgc2RoY2lfcGNpX2NoaXAg
KmNoaXApDQogDQogCQkJLyogQ2hlY2sgV2hldGhlciBzdWJJZCBpcyAweDExIG9yIDB4MTIgKi8N
CiAJCQlpZiAoKHNjcmF0Y2hfMzIgPT0gMHgxMSkgfHwgKHNjcmF0Y2hfMzIgPT0gMHgxMikpIHsN
Ci0JCQkJc2NyYXRjaF8zMiA9IDB4MmMyODAwMDA7DQorCQkJCXNjcmF0Y2hfMzIgPSAweDI1MTAw
MDAwOw0KIA0KLQkJCQkvKiBTZXQgQmFzZSBDbG9jayB0byAyMDhNWiAqLw0KKwkJCQkvKiBTZXQg
QmFzZSBDbG9jayB0byAyMDBNWiAqLw0KIAkJCQlvMl9wY2lfc2V0X2Jhc2VjbGsoY2hpcCwgc2Ny
YXRjaF8zMik7DQogCQkJCXJldCA9IHBjaV9yZWFkX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LA0K
IAkJCQkJCQkgICAgTzJfU0RfRlVOQ19SRUc0LA0KQEAgLTQwNiw3ICs0MDYsNyBAQCBpbnQgc2Ro
Y2lfcGNpX28yX3Byb2JlKHN0cnVjdCBzZGhjaV9wY2lfY2hpcCAqY2hpcCkNCiAJCQkJCSAgICAg
ICBPMl9TRF9QTExfU0VUVElORywgc2NyYXRjaF8zMik7DQogCQl9IGVsc2Ugew0KIAkJCXNjcmF0
Y2hfMzIgJj0gMHgwMDAwRkZGRjsNCi0JCQlzY3JhdGNoXzMyIHw9IDB4MmMyODAwMDA7DQorCQkJ
c2NyYXRjaF8zMiB8PSAweDI1MTAwMDAwOw0KIA0KIAkJCXBjaV93cml0ZV9jb25maWdfZHdvcmQo
Y2hpcC0+cGRldiwNCiAJCQkJCSAgICAgICBPMl9TRF9QTExfU0VUVElORywgc2NyYXRjaF8zMik7
DQotLQ0KMi4xNy4xDQoNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBBZHJp
YW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4gDQrlj5HpgIHml7bpl7Q6IEZyaWRh
eSwgSnVseSAyNywgMjAxOCAyOjU4IFBNDQrmlLbku7bkuro6IEVybmVzdCBaaGFuZyhXSCkgPGVy
bmVzdC56aGFuZ0BiYXlodWJ0ZWNoLmNvbT47IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5h
cm8ub3JnPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0K5oqE6YCBOiBDaHVhbmppbiBQYW5nIChXSCkgPGNodWFuamluLnBhbmdAYmF5aHVi
dGVjaC5jb20+OyBNaWtlIExpIChXSCkgPG1pa2UubGlAYmF5aHVidGVjaC5jb20+OyBDaGV2cm9u
IExpIChXSCkgPGNoZXZyb24ubGlAYmF5aHVidGVjaC5jb20+OyBTaGlybGV5IEhlciAoU0MpIDxz
aGlybGV5LmhlckBiYXlodWJ0ZWNoLmNvbT47IFhpYW9ndWFuZyBZdSAoV0gpIDx4aWFvZ3Vhbmcu
eXVAYmF5aHVidGVjaC5jb20+OyBCb2JieSBXdSAoV0gpIDxib2JieS53dUBiYXlodWJ0ZWNoLmNv
bT4NCuS4u+mimDogUmU6IFtQQVRDSCBWNyAyLzVdIG1tYzogc2RoY2k6IENoYW5nZSBPMiBIb3N0
IEhTMjAwIG1vZGUgY2xvY2sgZnJlcXVlbmN5IHRvIDIwME1Ieg0KDQpPbiAyNy8wNy8xOCAwOTo0
OSwgRXJuZXN0IFpoYW5nKFdIKSB3cm90ZToNCj4gSGkgQWRyaWFuLA0KPiAJRG8gSSBuZWVkIHJl
LXN1Ym1pdCBhbGwgNSBwYXRjaGVzIGFmdGVyIGZpeCB0aGF0IGFuZCBjaGFuZ2UgdGhlIHZlcnNp
b24gdG8gdjg/DQoNCllvdSBjYW4gcmVwbHkgdG8gdGhpcyBlbWFpbCB3aXRoIFBBVENIIFY4IDIv
NSB0aGF0IGhhcyBteSBBY2sgYW5kIHRoZSBjb21tZW50IGZpeGVkLg0KDQo+IEJSDQo+IA0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIFttYWlsdG86
YWRyaWFuLmh1bnRlckBpbnRlbC5jb21dDQo+IFNlbnQ6IDIwMTjlubQ35pyIMjXml6UgMTU6NDUN
Cj4gVG86IEVybmVzdCBaaGFuZyhXSCk7IFVsZiBIYW5zc29uOyBsaW51eC1tbWNAdmdlci5rZXJu
ZWwub3JnOyANCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogQ2h1YW5qaW4g
UGFuZyAoV0gpOyBNaWtlIExpIChXSCk7IENoZXZyb24gTGkgKFdIKTsgU2hpcmxleSBIZXIgDQo+
IChTQyk7IFhpYW9ndWFuZyBZdSAoV0gpOyBCb2JieSBXdSAoV0gpDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggVjcgMi81XSBtbWM6IHNkaGNpOiBDaGFuZ2UgTzIgSG9zdCBIUzIwMCBtb2RlIA0KPiBj
bG9jayBmcmVxdWVuY3kgdG8gMjAwTUh6DQo+IA0KPiBPbiAxNi8wNy8xOCAwOToyNiwgZXJuZXN0
LnpoYW5nIHdyb3RlOg0KPj4gTzIgU0QgSG9zdCBIUzIwMCBtb2RlIGNsb2NrIGZyZXF1ZW5jeSBj
dXJyZW50IGlzIDIwOE1Ieiwgc2hvdWxkIGJlIA0KPj4gY2hhbmdlZCB0byAyMDBNSHogdG8gbWVl
dCBzcGVjaWZpY2F0aW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IGVybmVzdC56aGFuZyA8ZXJu
ZXN0LnpoYW5nQGJheWh1YnRlY2guY29tPg0KPiANCj4gWW91IGxlZnQgaW4gdGhlIG1pc2xlYWRp
bmcgY29tbWVudC4gIEZpeCB0aGF0IGFuZCBhZGQ6DQo+IA0KPiBBY2tlZC1ieTogQWRyaWFuIEh1
bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IA0KPj4gLS0tDQo+PiBDaGFuZ2UgaW4g
Vjc6DQo+PiAJQ2hhbmdlIEhTMjAwIG1vZGUgY2xvY2sgZnJlcXVlbmN5IGZyb20gMjA4TUh6IHRv
IDIwME1IeiB0byBtZWV0DQo+PiAJU3BlY2lmaWNhdGlvbi4NCj4+DQo+PiBDaGFuZ2UgaW4gVjF+
VjY6DQo+PiAJTi9BDQo+PiAtLS0NCj4+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1vMm1p
Y3JvLmMgfCA0ICsrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBj
aS1vMm1pY3JvLmMNCj4+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jDQo+
PiBpbmRleCBiYTU5ZGI2YTEyNmMuLjk0Y2YzY2Q3NWRkMyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktcGNpLW8ybWljcm8uYw0KPj4gKysrIGIvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1wY2ktbzJtaWNyby5jDQo+PiBAQCAtMzExLDcgKzMxMSw3IEBAIGludCBzZGhjaV9w
Y2lfbzJfcHJvYmUoc3RydWN0IHNkaGNpX3BjaV9jaGlwDQo+PiAqY2hpcCkNCj4+ICANCj4+ICAJ
CQkvKiBDaGVjayBXaGV0aGVyIHN1YklkIGlzIDB4MTEgb3IgMHgxMiAqLw0KPj4gIAkJCWlmICgo
c2NyYXRjaF8zMiA9PSAweDExKSB8fCAoc2NyYXRjaF8zMiA9PSAweDEyKSkgew0KPj4gLQkJCQlz
Y3JhdGNoXzMyID0gMHgyYzI4MDAwMDsNCj4+ICsJCQkJc2NyYXRjaF8zMiA9IDB4MjUxMDAwMDA7
DQo+PiAgDQo+PiAgCQkJCS8qIFNldCBCYXNlIENsb2NrIHRvIDIwOE1aICovDQo+IA0KPiBUaGF0
IGNvbW1lbnQgaXMgbWlzbGVhZGluZyBub3cuDQo+IA0KPj4gIAkJCQlvMl9wY2lfc2V0X2Jhc2Vj
bGsoY2hpcCwgc2NyYXRjaF8zMik7IEBAIC00MDYsNyArNDA2LDcgQEAgaW50IA0KPj4gc2RoY2lf
cGNpX28yX3Byb2JlKHN0cnVjdCBzZGhjaV9wY2lfY2hpcCAqY2hpcCkNCj4+ICAJCQkJCSAgICAg
ICBPMl9TRF9QTExfU0VUVElORywgc2NyYXRjaF8zMik7DQo+PiAgCQl9IGVsc2Ugew0KPj4gIAkJ
CXNjcmF0Y2hfMzIgJj0gMHgwMDAwRkZGRjsNCj4+IC0JCQlzY3JhdGNoXzMyIHw9IDB4MmMyODAw
MDA7DQo+PiArCQkJc2NyYXRjaF8zMiB8PSAweDI1MTAwMDAwOw0KPj4gIA0KPj4gIAkJCXBjaV93
cml0ZV9jb25maWdfZHdvcmQoY2hpcC0+cGRldiwNCj4+ICAJCQkJCSAgICAgICBPMl9TRF9QTExf
U0VUVElORywgc2NyYXRjaF8zMik7DQo+Pg0KPiANCg0K
