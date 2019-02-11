Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA9BC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DEA20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="APKRFBVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfBKCx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 21:53:27 -0500
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:35377
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfBKCx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 21:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TL0So4gmVJEBdFhgc3+elj+3eSlT8pH7mDbqBVuE74=;
 b=APKRFBVNEvMvgHP4Y3GOLnDvv+v6EOAQQc/dVKW3zNCpxpPOp1HrlrlvoHmrQyQOJh3H3zesvQn6iZIVdqIZPo8bK+Ed1NI5bH7FgRIbKMn5vxvP5Tp/VX5D6ri0/ppxXLPxC3zAmbPqJrc86Sw+Safep2Ze4x2eLRr1/yOW3vU=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB3280.eurprd04.prod.outlook.com (10.170.231.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Mon, 11 Feb 2019 02:53:18 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84%4]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 02:53:18 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andy Tang <andy.tang@nxp.com>
Subject: RE: [v5 2/2] arm64: dts: lx2160a: add sata node support
Thread-Topic: [v5 2/2] arm64: dts: lx2160a: add sata node support
Thread-Index: AQHUtIYwnQmxzXZ3L0eB1kWs+99RWKXKhh8AgA96GpA=
Date:   Mon, 11 Feb 2019 02:53:18 +0000
Message-ID: <VI1PR04MB44313B08539AA7081DC53BAFED640@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190125081013.21663-1-peng.ma@nxp.com>
 <20190125081013.21663-2-peng.ma@nxp.com> <20190201063011.GL19882@dragon>
In-Reply-To: <20190201063011.GL19882@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3280;6:dumBAFrhWxOvHrC6Pn+FAvQPed0qqQTWZBPk7Z9g01a5mMX/OMDutdDv9UkezpIPQ/H2CmxY2ZDuSXps4MRmv23Ld60TZKXQ5O42NH/hplsQHz2Zs51FaTxLBSkFKXZFy09WwFIyHj3GxBEqEyOUd4m7MV97J72rkYH8Kv4yPZCaHntvD9bV/geRCmZiZ33Wxcw2MrITIOEQJVBpnvLVg4PdR0QrEFvmkuL5l4qiTxTNWjD7j6OV3ZqD2ujeyHZyB5LhOQqVTrZufMSF/IIJCgGHeYHkjyvPK3rEkc3uxP+Jvq4jgS3Eh2j7XHTYrmPJJoGbAF2VOl8me1bTIwMvDRPnJQFl0sVKKBaxhblUcTitnFZtSoSP2Jigr4TbnpbpBS0+VK/66iMpQSKXgHEhzUjeAbFy9e/ZNCAOqgk3l+yu5WWxdhA3r7ncsA8/PiPLbGJY1WtCRb9EY/iBQqyt0Q==;5:KKPXvLQv1CZkkz0DxjGc9I0siqqVIUDARCqQoMhdxSahrg+XvZHfnNMQU1kEB2c2EPomJf8gLKqgEbp1vN+pn8uFTdR39p/Sj7ZQA+ZgVst1eyb7cJjw+HKLOeVCa9BywkZGTys3R/licYQ0nvg7NJ1L4SiZNSYWRp3jm8iUn8mTfyyguvlYcqrV5W1IX9d0ZrYBZ9OaXm6NbG2ErPBoVw==;7:ga2IzK5lqtEMkRIBDyCjVM7yVQTwhZ9ki8SABsoOSwN8EL1xEV0XNMlBxWf2BE1pPtUAI8Ec49P0XvdGjUf0c7zeQZ7IxP3sdtHnImOXLpl/o0lPkL/qC+roHbWaD1KhRSoEIJn3S5wlJAoBCEIDDw==
x-ms-office365-filtering-correlation-id: 9c4e800b-8d17-4d19-b25a-08d68fcc13d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3280;
x-ms-traffictypediagnostic: VI1PR04MB3280:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB328015BD11F5DCF2E4CC50A9ED640@VI1PR04MB3280.eurprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(13464003)(199004)(446003)(33656002)(9686003)(2906002)(11346002)(55016002)(316002)(6306002)(68736007)(305945005)(7736002)(54906003)(14454004)(6916009)(478600001)(66066001)(8936002)(6506007)(8676002)(486006)(44832011)(6246003)(97736004)(966005)(476003)(3846002)(6116002)(74316002)(106356001)(81166006)(81156014)(4326008)(86362001)(105586002)(102836004)(6436002)(71190400001)(71200400001)(6346003)(53936002)(26005)(229853002)(25786009)(186003)(99286004)(7696005)(76176011)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3280;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DKCAx6n85oPb5bbpavI72yStIyw9BUGS4czCf458lhJj9rUufFMQg7W/beb2+Dx2abe0zV18sDLY5PNE5kjAPOQYUu8+JuJ1mDCmBDFcqcbudlgvt1RL08V0gcSNDkYNVLJNvHma4ynWq9cewKD4TjraKn+taH4rczqs9SIKw9t7zQk5QQXDv29JPKz+kwjWi4AKfvO0mDDRuVDoPz7cq2MxRD39sOiUCa75iXUZBzwQkRzCiFy6Qqy3X9JWGyUl7nmABk7Us7Duun2cEccmJQnUhqfaqymFsbLdYmowmV0+Qv+dv/HOuwJ3f5G7kHXbUhwnmZVo+zQCmFz/MPISIHnufj8pCuj0wUpq7QMbPAc1vpiveia4yeVamWFplBSekXBSH+AhHwF0hN/mv1gWkYNXgSS2a5/NnWlzqqIa+B0=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4e800b-8d17-4d19-b25a-08d68fcc13d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 02:53:18.7288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz4NCj5TZW50OiAyMDE5xOoy1MIxyNUgMTQ6MzANCj5UbzogUGVuZyBNYSA8
cGVuZy5tYUBueHAuY29tPg0KPkNjOiBheGJvZUBrZXJuZWwuZGs7IHJvYmgrZHRAa2VybmVsLm9y
ZzsgbWFyay5ydXRsYW5kQGFybS5jb207IExlbyBMaQ0KPjxsZW95YW5nLmxpQG54cC5jb20+OyBs
aW51eC1pZGVAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj5s
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IEFuZHkgVGFuZw0KPjxhbmR5LnRhbmdAbnhwLmNvbT4NCj5TdWJqZWN0OiBSZTog
W3Y1IDIvMl0gYXJtNjQ6IGR0czogbHgyMTYwYTogYWRkIHNhdGEgbm9kZSBzdXBwb3J0DQo+DQo+
T24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgMDg6MTA6MTNBTSArMDAwMCwgUGVuZyBNYSB3cm90ZToN
Cj4+IEFkZCBTQVRBIGRldmljZSBub2RlcyBmb3IgZnNsLWx4MjE2MGEgYW5kIGVuYWJsZSBzdXBw
b3J0IGZvciBRRFMgYW5kDQo+PiBSREIgYm9hcmRzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBl
bmcgTWEgPHBlbmcubWFAbnhwLmNvbT4NCj4+IC0tLQ0KPj4gY2hhbmdlZCBmb3IgVjU6DQo+PiAJ
LSBubyBjaGFuZ2UNCj4+DQo+PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4
MjE2MGEtcWRzLmR0cyB8ICAgMTYgKysrKysrKw0KPj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMgfCAgIDE2ICsrKysrKysNCj4+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpICAgIHwgICA0NA0KPisrKysrKysr
KysrKysrKysrKysrKw0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgMCBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWx4MjE2MGEtcWRzLmR0cw0KPj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzDQo+PiBpbmRleCA5OWEyMmFiLi4xYTVhY2Y2IDEwMDY0
NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcWRz
LmR0cw0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEt
cWRzLmR0cw0KPj4gQEAgLTk1LDYgKzk1LDIyIEBADQo+PiAgCX07DQo+PiAgfTsNCj4+DQo+PiAr
JnNhdGEwIHsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJnNhdGEx
IHsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJnNhdGEyIHsNCj4+
ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJnNhdGEzIHsNCj4+ICsJc3Rh
dHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiAgJnVhcnQwIHsNCj4+ICAJc3RhdHVzID0g
Im9rYXkiOw0KPj4gIH07DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cw0KPj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzDQo+PiBpbmRleCA2NDgxZTVmLi41YjY3OTllIDEwMDY0
NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcmRi
LmR0cw0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEt
cmRiLmR0cw0KPj4gQEAgLTEwMiw2ICsxMDIsMjIgQEANCj4+ICAJfTsNCj4+ICB9Ow0KPj4NCj4+
ICsmc2F0YTAgew0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4+ICsNCj4+ICsmc2F0
YTEgew0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4+ICsNCj4+ICsmc2F0YTIgew0K
Pj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4+ICsNCj4+ICsmc2F0YTMgew0KPj4gKwlz
dGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4+ICsNCj4+ICAmdWFydDAgew0KPj4gIAlzdGF0dXMg
PSAib2theSI7DQo+PiAgfTsNCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1seDIxNjBhLmR0c2kNCj4+IGluZGV4IGE3OWY1YzEuLjU5MjAzNGIgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+
PiBAQCAtNjcxLDYgKzY3MSw1MCBAQA0KPj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiAg
CQl9Ow0KPj4NCj4+ICsJCXNhdGEwOiBzYXRhQDMyMDAwMDAgew0KPj4gKwkJCWNvbXBhdGlibGUg
PSAiZnNsLGx4MjE2MGEtYWhjaSI7DQo+DQo+SGFzIHRoZSBrZXJuZWwgZHJpdmVyIGJlZW4gcGF0
Y2hlZCB0byBwcm9iZSB0aGUgY29tcGF0aWJsZT8NCj4NCj5TaGF3bg0KWWVzLCB0aGUgZHJpdmVy
IHBhdGNoIGlzIGh0dHA6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMDM0MDgzLw0KQlIN
ClBlbmcNCj4NCj4+ICsJCQlyZWcgPSA8MHgwIDB4MzIwMDAwMCAweDAgMHgxMDAwMD4sDQo+PiAr
CQkJICAgICAgPDB4NyAweDEwMDUyMCAweDAgMHg0PjsNCj4+ICsJCQlyZWctbmFtZXMgPSAiYWhj
aSIsICJzYXRhLWVjYyI7DQo+PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEzMyBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsNCj4+ICsJCQljbG9ja3MgPSA8JmNsb2NrZ2VuIDQgMz47DQo+PiArCQkJ
ZG1hLWNvaGVyZW50Ow0KPj4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiArCQl9Ow0KPj4g
Kw0KPj4gKwkJc2F0YTE6IHNhdGFAMzIxMDAwMCB7DQo+PiArCQkJY29tcGF0aWJsZSA9ICJmc2ws
bHgyMTYwYS1haGNpIjsNCj4+ICsJCQlyZWcgPSA8MHgwIDB4MzIxMDAwMCAweDAgMHgxMDAwMD4s
DQo+PiArCQkJICAgICAgPDB4NyAweDEwMDUyMCAweDAgMHg0PjsNCj4+ICsJCQlyZWctbmFtZXMg
PSAiYWhjaSIsICJzYXRhLWVjYyI7DQo+PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEzNiBJ
UlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+ICsJCQljbG9ja3MgPSA8JmNsb2NrZ2VuIDQgMz47DQo+
PiArCQkJZG1hLWNvaGVyZW50Ow0KPj4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiArCQl9
Ow0KPj4gKw0KPj4gKwkJc2F0YTI6IHNhdGFAMzIyMDAwMCB7DQo+PiArCQkJY29tcGF0aWJsZSA9
ICJmc2wsbHgyMTYwYS1haGNpIjsNCj4+ICsJCQlyZWcgPSA8MHgwIDB4MzIyMDAwMCAweDAgMHgx
MDAwMD4sDQo+PiArCQkJICAgICAgPDB4NyAweDEwMDUyMCAweDAgMHg0PjsNCj4+ICsJCQlyZWct
bmFtZXMgPSAiYWhjaSIsICJzYXRhLWVjYyI7DQo+PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDk3IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4gKwkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gNCAz
PjsNCj4+ICsJCQlkbWEtY29oZXJlbnQ7DQo+PiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+
ICsJCX07DQo+PiArDQo+PiArCQlzYXRhMzogc2F0YUAzMjMwMDAwIHsNCj4+ICsJCQljb21wYXRp
YmxlID0gImZzbCxseDIxNjBhLWFoY2kiOw0KPj4gKwkJCXJlZyA9IDwweDAgMHgzMjMwMDAwIDB4
MCAweDEwMDAwPiwNCj4+ICsJCQkgICAgICA8MHg3IDB4MTAwNTIwIDB4MCAweDQ+Ow0KPj4gKwkJ
CXJlZy1uYW1lcyA9ICJhaGNpIiwgInNhdGEtZWNjIjsNCj4+ICsJCQlpbnRlcnJ1cHRzID0gPEdJ
Q19TUEkgMTAwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4gKwkJCWNsb2NrcyA9IDwmY2xvY2tn
ZW4gNCAzPjsNCj4+ICsJCQlkbWEtY29oZXJlbnQ7DQo+PiArCQkJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4+ICsJCX07DQo+PiArDQo+PiAgCQlzbW11OiBpb21tdUA1MDAwMDAwIHsNCj4+ICAJCQlj
b21wYXRpYmxlID0gImFybSxtbXUtNTAwIjsNCj4+ICAJCQlyZWcgPSA8MCAweDUwMDAwMDAgMCAw
eDgwMDAwMD47DQo+PiAtLQ0KPj4gMS43LjENCj4+DQo=
