Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1530CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C433C20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mJE9P/mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C433C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJCRld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:41:33 -0400
Received: from mail-db5eur01on0051.outbound.protection.outlook.com ([104.47.2.51]:23104
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726547AbeJCRlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqdb5m8A8LR0LlacvSmDPiYaNBRXt4xuQhEa0GhU6V8=;
 b=mJE9P/mL0HM3I1Y53B6U3eKoIQWZ42XQiDV8WRXwgdNPeZt4keLCd0wT8jo88Gx8fbEw+wX0AuN7GHJ2ZwszS99uamwnWZRJ5fwM8ygRLjh5p6LyBMks8DlZBTx6nKryD9u7Q0sR3wNqM7aFYvXt/F1gz+cxxZEtWigHDXwIUlU=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3655.eurprd04.prod.outlook.com (52.133.28.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Wed, 3 Oct 2018 10:50:46 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::5892:d48b:ebb8:8991]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::5892:d48b:ebb8:8991%5]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 10:50:46 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Roy Pledge <roy.pledge@nxp.com>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        David Miller <davem@davemloft.net>,
        Shawn Guo <shawnguo@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Bharat Bhushan <bharat.bhushan@nxp.com>
Subject: Re: [PATCH v2 08/22] soc/fsl/qbman_portals: add APIs to retrieve the
 probing status
Thread-Topic: [PATCH v2 08/22] soc/fsl/qbman_portals: add APIs to retrieve the
 probing status
Thread-Index: AQHUVZwKH/WwkRKFn0OBDwKlwc/ZM6UEjyMAgAjTf4A=
Date:   Wed, 3 Oct 2018 10:50:46 +0000
Message-ID: <c4ff9977-c730-be48-8046-97da663c5a23@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
 <20180926132247.10971-9-laurentiu.tudor@nxp.com>
 <CADRPPNTD=SNpSqz=zoLyGP1tvh_xDr5E1NDHF_P0bcSPyx9X1A@mail.gmail.com>
In-Reply-To: <CADRPPNTD=SNpSqz=zoLyGP1tvh_xDr5E1NDHF_P0bcSPyx9X1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3655;6:wD1L06EW9OWvog50qRhakoI8jIs0tg+4Gu/25f6/1mFU2etq9JFTue6PS+sc0WMzAi9rZCmQ3OaJuLLl9cBF7FEdt/b0mR5Njvy6Gzy8pW7MWV5vvX9TXdfPGMmJ9mHPulri5s8AcPL4SVqSUbsZFTNTg4FxFt5fSpMIlJ/k7eZF71oIF4tP3N7aW8OnLkEtrsFjGUH30OA6iYP9n+XhN8Wr71ARtgTPkYaQ0ik4Tx7uvO5n4/QEmOlQBzp2DDjxidO8UT8jN5rtUI0NjCpUMIA29ZMac9R1Cp9w4dEBBUZePBwIGA4CtOA5oTMsDhQuU2hr7itbmtabcEHl7CjcXdU03OYsCMIkauBiD4CEWTL9mYxrWnTc0lEBVkBYC3s6SMXqBAZve+Yzk6drTN/wyzFulVrMb2tM0IU/q1CDSq9O46Jw5W5Hx7N3j32ckj2KaBm/34Mg2YaMh19DPoqALw==;5:aLntZePD80TIBsrY83TnEJH5i/pusVEmtfmyuv+f8LrR1xOBsHiXRIFuHx/0SlVoCKrog88II80E94z0HoAslEtj3TPQdBCn7rUX9tWixCtDnFoSbbe9DuiPLOXGNN8vWl7oiFiuyiXzu7EQGzvS3WyboU1mcnoT/HVaHeRzmJc=;7:Pq1y3JKlE0dmBbP3yLi0XfSzxk4R82zJqwzkuFlnl0dlyHSZaneMm5V699R0h1+TbZ99u75vk+RjKiZAYbQmoA44FsKm+gKIttPjbquCeJ4MUNkYSsxp647kiy4vlUZCFZ2KI06he0jLX50qvUEGKrrkpVcP3wC28feXA8kIWqfEj69NgHpZk0O7yxnrUok5pJxlbl58hvJmahifNlejF2VgLLY+4DhOrcp9wIkR4eC54JI4bzBLY9km4/qx/EoJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c3981508-2ada-4ef5-8106-08d6291e1303
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3655;
x-ms-traffictypediagnostic: AM6PR0402MB3655:
x-microsoft-antispam-prvs: <AM6PR0402MB3655498B60D30FE6EA8C7A5DECE90@AM6PR0402MB3655.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(227817650892897)(275809806118684)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:AM6PR0402MB3655;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3655;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(396003)(346002)(39860400002)(52314003)(189003)(199004)(86362001)(97736004)(102836004)(6116002)(31696002)(3846002)(316002)(6512007)(256004)(26005)(53936002)(5250100002)(14444005)(37006003)(54906003)(2906002)(6246003)(106356001)(4326008)(6862004)(31686004)(105586002)(476003)(2616005)(8936002)(446003)(11346002)(305945005)(7736002)(5660300001)(44832011)(486006)(66066001)(25786009)(6636002)(68736007)(14454004)(186003)(2900100001)(6486002)(478600001)(229853002)(53546011)(76176011)(81166006)(8676002)(81156014)(99286004)(6506007)(71200400001)(71190400001)(6436002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3655;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b18t4+KCfn85FDA/xG5GM06EeYRN5siYC4ZtWvl34Xw3llS5AJO2oX0UpzK0NaqJ5df2RCocd7EG0v7ZPwiFBM8Fe/dAwhZCVcbUZ2a3/DmIlvKwg++YPwZ/NCdoa0YVYOESdJJaarTEYk7kk3a200pBWgi3dgu6rf7Owi/X16UCyhfd9CWqIYDDxE6Q+63aByxOSrO6zNjOSh3FCgOhooz18ts23QTa8xx73ELhBs2Dki6j9Lmnb1Kib0T5nd3ITHcjDsAc9Nt3vbOgp0ZfTnxGbB8ckG5IaQUAzTpTWAzmtfC3lnVRbQ4yy/+bheOqXpAGbV+7rkjUfSAZImAATRrQiteurn0PcAM9XGT4qk4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2E6A1E9E0788343B9DCD71E8D314255@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3981508-2ada-4ef5-8106-08d6291e1303
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 10:50:46.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3655
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVvLA0KDQpPbiAyNy4wOS4yMDE4IDIzOjAzLCBMaSBZYW5nIHdyb3RlOg0KPiBPbiBXZWQs
IFNlcCAyNiwgMjAxOCBhdCA4OjI2IEFNIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gRnJvbTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4N
Cj4+DQo+PiBBZGQgYSBjb3VwbGUgb2YgbmV3IEFQSXMgdG8gY2hlY2sgdGhlIHByb2Jpbmcgc3Rh
dHVzIG9mIHRoZSByZXF1aXJlZA0KPj4gY3B1IGJvdW5kIHFtYW4gYW5kIGJtYW4gcG9ydGFsczoN
Cj4+ICAgJ2ludCBibWFuX3BvcnRhbHNfcHJvYmVkKCknIGFuZCAnaW50IHFtYW5fcG9ydGFsc19w
cm9iZWQoKScuDQo+PiBUaGV5IHJldHVybiB0aGUgZm9sbG93aW5nIHZhbHVlcy4NCj4+ICAgKiAg
MSBpZiBxbWFuL2JtYW4gcG9ydGFscyB3ZXJlIGFsbCBwcm9iZWQgY29ycmVjdGx5DQo+PiAgICog
IDAgaWYgcW1hbi9ibWFuIHBvcnRhbHMgd2VyZSBub3QgeWV0IHByb2JlZA0KPj4gICAqIC0xIGlm
IHByb2Jpbmcgb2YgcW1hbi9ibWFuIHBvcnRhbHMgZmFpbGVkDQo+PiBEcml2ZXJzIHRoYXQgdXNl
IHFtYW4vYm1hbiBwb3J0YWwgZHJpdmVyIHNlcnZpY2VzIGFyZSByZXF1aXJlZCB0byB1c2UNCj4+
IHRoZXNlIEFQSXMgYmVmb3JlIGNhbGxpbmcgYW55IGZ1bmN0aW9ucyBleHBvcnRlZCBieSB0aGVz
ZSBkcml2ZXJzIG9yDQo+PiBvdGhlcndpc2UgdGhleSB3aWxsIGNyYXNoIHRoZSBrZXJuZWwuDQo+
PiBGaXJzdCB1c2VyIHdpbGwgYmUgdGhlIGRwYWExIGV0aGVybmV0IGRyaXZlciwgY29taW5nIGlu
IGEgc3Vic2VxdWVudA0KPj4gcGF0Y2guDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGF1cmVudGl1
IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3Nv
Yy9mc2wvcWJtYW4vYm1hbl9wb3J0YWwuYyB8IDEwICsrKysrKysrKysNCj4+ICAgZHJpdmVycy9z
b2MvZnNsL3FibWFuL3FtYW5fcG9ydGFsLmMgfCAxMCArKysrKysrKysrDQo+PiAgIGluY2x1ZGUv
c29jL2ZzbC9ibWFuLmggICAgICAgICAgICAgIHwgIDggKysrKysrKysNCj4+ICAgaW5jbHVkZS9z
b2MvZnNsL3FtYW4uaCAgICAgICAgICAgICAgfCAgOSArKysrKysrKysNCj4+ICAgNCBmaWxlcyBj
aGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29j
L2ZzbC9xYm1hbi9ibWFuX3BvcnRhbC5jIGIvZHJpdmVycy9zb2MvZnNsL3FibWFuL2JtYW5fcG9y
dGFsLmMNCj4+IGluZGV4IGY5ZWRkMjg4OTRmZC4uODA0OGQzNWRlOGEyIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9zb2MvZnNsL3FibWFuL2JtYW5fcG9ydGFsLmMNCj4+ICsrKyBiL2RyaXZlcnMv
c29jL2ZzbC9xYm1hbi9ibWFuX3BvcnRhbC5jDQo+PiBAQCAtMzIsNiArMzIsNyBAQA0KPj4NCj4+
ICAgc3RhdGljIHN0cnVjdCBibWFuX3BvcnRhbCAqYWZmaW5lX2Jwb3J0YWxzW05SX0NQVVNdOw0K
Pj4gICBzdGF0aWMgc3RydWN0IGNwdW1hc2sgcG9ydGFsX2NwdXM7DQo+PiArc3RhdGljIGludCBf
X2JtYW5fcG9ydGFsc19wcm9iZWQ7DQo+PiAgIC8qIHByb3RlY3QgYm1hbiBnbG9iYWwgcmVnaXN0
ZXJzIGFuZCBnbG9iYWwgZGF0YSBzaGFyZWQgYW1vbmcgcG9ydGFscyAqLw0KPj4gICBzdGF0aWMg
REVGSU5FX1NQSU5MT0NLKGJtYW5fbG9jayk7DQo+Pg0KPj4gQEAgLTg1LDYgKzg2LDEyIEBAIHN0
YXRpYyBpbnQgYm1hbl9vbmxpbmVfY3B1KHVuc2lnbmVkIGludCBjcHUpDQo+PiAgICAgICAgICBy
ZXR1cm4gMDsNCj4+ICAgfQ0KPj4NCj4+ICtpbnQgYm1hbl9wb3J0YWxzX3Byb2JlZCh2b2lkKQ0K
Pj4gK3sNCj4+ICsgICAgICAgcmV0dXJuIF9fYm1hbl9wb3J0YWxzX3Byb2JlZDsNCj4+ICt9DQo+
PiArRVhQT1JUX1NZTUJPTF9HUEwoYm1hbl9wb3J0YWxzX3Byb2JlZCk7DQo+PiArDQo+PiAgIHN0
YXRpYyBpbnQgYm1hbl9wb3J0YWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4+ICAgew0KPj4gICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4+
IEBAIC0xNDgsNiArMTU1LDcgQEAgc3RhdGljIGludCBibWFuX3BvcnRhbF9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICAgICAgICAgc3Bpbl9sb2NrKCZibWFuX2xvY2sp
Ow0KPj4gICAgICAgICAgY3B1ID0gY3B1bWFza19uZXh0X3plcm8oLTEsICZwb3J0YWxfY3B1cyk7
DQo+PiAgICAgICAgICBpZiAoY3B1ID49IG5yX2NwdV9pZHMpIHsNCj4+ICsgICAgICAgICAgICAg
ICBfX2JtYW5fcG9ydGFsc19wcm9iZWQgPSAxOw0KPiANCj4gV2hhdCBpZiB0aGUgbGFzdCBDUFUg
aXMgbm90IHVzZWQgZm9yIHBvcnRhbHM/ICBJcyB0aGVyZSBhIGhhcmQNCj4gcmVxdWlyZW1lbnQg
dGhhdCBhbGwgQ1BVcyBuZWVkIHRvIGJlIHVzZWQgZm9yIHBvcnRhbD8gDQoNCkFzIGZhciBhcyBJ
IGtub3csIGluIHRoZSBjdXJyZW50IGRyaXZlciBkZXNpZ24gYSBwb3J0YWwgaXMgcmVxdWlyZWQg
Zm9yIA0KZWFjaCBDUFUuDQoNCj4gV2hhdCBoYXBwZW5zIGlmIHRoZSBsYXN0IENQVSBpcyBvZmZs
aW5lPw0KDQpDYW4gdGhpcyBoYXBwZW4gYXQgcHJvYmUgdGltZT8NCkFueXdheSwgSSdtIG5vdCBz
dXJlIHRoYXQgdGhlIGRyaXZlciBpcyBldmVuIGF3YXJlIG9mIGNwdSBob3RwbHVnIGJ1dCANCkkn
bGwgbGV0IFJveSBjb21tZW50IG9uIHRoaXMgb25lLg0KDQo+IA0KPj4gICAgICAgICAgICAgICAg
ICAvKiB1bmFzc2lnbmVkIHBvcnRhbCwgc2tpcCBpbml0ICovDQo+PiAgICAgICAgICAgICAgICAg
IHNwaW5fdW5sb2NrKCZibWFuX2xvY2spOw0KPj4gICAgICAgICAgICAgICAgICByZXR1cm4gMDsN
Cj4+IEBAIC0xNzMsNiArMTgxLDggQEAgc3RhdGljIGludCBibWFuX3BvcnRhbF9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICBlcnJfaW9yZW1hcDI6DQo+PiAgICAgICAg
ICBtZW11bm1hcChwY2ZnLT5hZGRyX3ZpcnRfY2UpOw0KPj4gICBlcnJfaW9yZW1hcDE6DQo+PiAr
ICAgICAgICBfX2JtYW5fcG9ydGFsc19wcm9iZWQgPSAxOw0KPj4gKw0KPiANCj4gVGhlcmUgYXJl
IG90aGVyIGVycm9yIHBhdGhzIHRoYXQgbm90IGNvdmVyZWQuDQoNClJpZ2h0LCB0aGFua3MgZm9y
IHBvaW50aW5nLiBPbiB0b3Agb2YgdGhhdCwgdGhlIGFzc2lnbmVkIHZhbHVlIGhlcmUgDQpzaG91
bGQgYmUgLTEgdG8gc2lnbmFsIGVycm9yIChpbnN0ZWFkIG9mIDEgd2hpY2ggc2lnbmFscyBzdWNj
ZXNzKS4NCg0KLS0tDQpCZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQ==
