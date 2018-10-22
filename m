Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEB5C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4362064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CLklpsDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4362064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeJVSVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:21:51 -0400
Received: from mail-by2nam01on0083.outbound.protection.outlook.com ([104.47.34.83]:64288
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727865AbeJVSVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CthmIIpQEV42aAvX021wTsZXqq+5wIZXhfLDoLdG2z8=;
 b=CLklpsDLM8JFGYLicNikQuJTAHKIuTKrn5ymGnqOQ30XOYpumd5cCSo74Z70Que8Olt2RTU21cdg8kclqc+yWoHFw1g1Etyyv5uEtoXjqa3RekI/eLVN0qG7bsprRTE+rAX4o0A3GGp+6rAqfFJJnmNw1BKUhFt/DUq0ABGbd/U=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4792.namprd02.prod.outlook.com (52.135.232.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 22 Oct 2018 10:03:55 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8d0d:7d34:1d3:52d]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8d0d:7d34:1d3:52d%4]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 10:03:55 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <moritz.fischer@ettus.com>,
        Moritz Fischer <moritz.fischer.private@gmail.com>
CC:     Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 zynqmp
Thread-Topic: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 zynqmp
Thread-Index: AQHUZ4izEyYJo0F/yk269IKpDT/Ht6UnFPUAgABFVACAA7DPYA==
Date:   Mon, 22 Oct 2018 10:03:55 +0000
Message-ID: <BYAPR02MB47106D61C0CDB8268BAF4E44C2F40@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
 <20181020084805.29103-4-nava.manne@xilinx.com>
 <CAJYdmePxnkG=3iJC5Lewq3n3zFGTKASJX7ceUEufBvOJogCfdA@mail.gmail.com>
 <CAAtXAHdP6z5NG+EAvW_N_RfcPv59e15hkd83AR-L3RDBrLMvcQ@mail.gmail.com>
In-Reply-To: <CAAtXAHdP6z5NG+EAvW_N_RfcPv59e15hkd83AR-L3RDBrLMvcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4792;6:E3MkwzJ4nai19gxsPoOTGY/afnfElQ34/mKDU8QRfM2qaJu5DtM/gOLLCG33z3aE3oIr0cGjhigL8B4TnU2jcOKpz4njxewRljwvdnKmz9F3qGFa0ZdD+dapLp2apEO8IQQH6YlRkTcIuEKKiucyhomAWxZ4uzSGF0o9iL+2YBb/uDj3BIaRlnov5k3GIva5fWCRDePRwaV2BIHdJUi/sHrR02cB9tge3rXBO2TlS2tLyxmPQzjvWEOkdo36fPwJUeHPOBpJM+KHwdeCM/8zeMw6goEaXiVzogZM9WC85QjzYr97DvvIp+zUuYSuua5HtvcR/AW5K5TIZrVpgIg3tY+RzATHKJvBxXuHclGyFwV6DjpqvhJUTP44C5x+Epl5CeZWdWt2ED8S6rdUwME2Anpzp9DfkAjf9bikRPKSQlCSr4tXHkBS5Eg+6g2fGFnNuI1zMKSc762d9f8rPswIjQ==;5:TZXDO71W7+eF26+30W/f+QFewi/C4c1VFYO887MUvkywqoGBWoQZrdbpAcxyrlra8PAeILa/1Tckz/dWUhSvKGGPgddB4tjIz/l1QpjHPmUaROflEDOZ1bNtN0sAybYVbll1uF+9bh1kv5qeNAynQhDsmoAaQFxw44DtBddJoLk=;7:Z0Xr+mKKvmOXQDLTc5tODvalswcwMu06F7e4je9r9efx3HZ8gKsFZYBr0yyu17XK/bs2Yl5sEFm/TSlEt84GGPvgxS2cS4irNwYkspNXkfS3u49k4Lp5VenwU6HuhwIP/7HafAZBFGSQL0Q2nIQ8+FqRGRrJtJpsjgOOC560t9ihnU23yJmCbuKdWx8AaaaOaWegcYgW3mOJq344lAAraCGWiQEYVKyjDSE4hvaA7+cnjcYehnubjIIbJdQSDjWV
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 4256562a-0ed9-4401-6789-08d63805ad92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4792;
x-ms-traffictypediagnostic: BYAPR02MB4792:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB4792A269C2CD6DC7AAF7C624C2F40@BYAPR02MB4792.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(85827821059158)(17755550239193)(192813158149592)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4792;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4792;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(136003)(51914003)(13464003)(189003)(199004)(102836004)(26005)(186003)(478600001)(316002)(5250100002)(105586002)(2900100001)(8936002)(6436002)(229853002)(9686003)(8676002)(74316002)(81156014)(68736007)(7736002)(86362001)(305945005)(53936002)(256004)(6246003)(55016002)(5660300001)(99286004)(97736004)(39060400002)(4326008)(6116002)(3846002)(71190400001)(71200400001)(33656002)(6506007)(53546011)(66066001)(106356001)(110136005)(54906003)(25786009)(7416002)(81166006)(93886005)(14454004)(7696005)(76176011)(2906002)(486006)(476003)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4792;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Vqcb9dStjIVCQPDeY6ShPu/Y9tSZ6MW1pIe82r6YpcuTliZffmjrSzxvW6Yqnlp1BLBlCCQu2fi57qgbLhMjddDfFz/3Yy0VusA0KUkAHQ4PAeXxASCgI86ePf1G46vPFZful9VG/MTLyZkZp7ycOtPq+wtZMdz49q6xDxHYZoQTwOZDOp+kQuC8ZkfrwJq6uWuZG4rMQ9I83eVVGmJk3O/BX9zNEm2YCS47AmuM3kGBL1SXLl7kAs1rmbv/SVzfFWFL0m9Owl1jlpPIxkrfIxkJUSdNud14MeX1giuoE1b4T8PwWCQvEf2dJIUCGAK1v4v/DLL52TAePoGeKPWEEfOvdotJqVJ2wpMefRIlG40=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4256562a-0ed9-4401-6789-08d63805ad92
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 10:03:55.5830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4792
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTW9ydGl6LA0KDQpUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZS4uLi4NClBsZWFzZSBm
aW5kIG15IHJlc3BvbnNlIGlubGluZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBNb3JpdHogRmlzY2hlciBbbWFpbHRvOm1vcml0ei5maXNjaGVyQGV0dHVzLmNvbV0N
Cj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMjAsIDIwMTggNzowMiBBTQ0KPiBUbzogTW9yaXR6
IEZpc2NoZXIgPG1vcml0ei5maXNjaGVyLnByaXZhdGVAZ21haWwuY29tPg0KPiBDYzogTmF2YSBr
aXNob3JlIE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPjsgQWxhbiBUdWxsIDxhdHVsbEBrZXJuZWwu
b3JnPjsNCj4gUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8
bWFyay5ydXRsYW5kQGFybS5jb20+Ow0KPiBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNv
bT47IFJhamFuIFZhamEgPFJBSkFOVkB4aWxpbnguY29tPjsgSm9sbHkNCj4gU2hhaCA8Sk9MTFlT
QHhpbGlueC5jb20+OyBsaW51eC1mcGdhQHZnZXIua2VybmVsLm9yZzsgRGV2aWNldHJlZSBMaXN0
DQo+IDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWFybS1rZXJuZWwgPGxpbnV4
LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGlu
ZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IGNoaW5uaWtpc2hvcmUz
NjlAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBmcGdhIG1hbmFnZXI6IEFk
ZGluZyBGUEdBIE1hbmFnZXIgc3VwcG9ydCBmb3INCj4gWGlsaW54IHp5bnFtcA0KPiANCj4gT24g
RnJpLCBPY3QgMTksIDIwMTggYXQgMjozMyBQTSBNb3JpdHogRmlzY2hlcg0KPiA8bW9yaXR6LmZp
c2NoZXIucHJpdmF0ZUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgTmF2YSwNCj4gPg0K
PiA+IExvb2tzIGdvb2QgdG8gbWUsIGEgY291cGxlIG9mIG5pdHMgaW5saW5lIGJlbG93Lg0KPiA+
DQo+ID4gT24gRnJpLCBPY3QgMTksIDIwMTggYXQgMTo1MCBBTSBOYXZhIGtpc2hvcmUgTWFubmUN
Cj4gPiA8bmF2YS5tYW5uZUB4aWxpbnguY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBUaGlzIHBh
dGNoIGFkZHMgRlBHQSBNYW5hZ2VyIHN1cHBvcnQgZm9yIHRoZSBYaWxpbnggWnlucU1wIGNoaXAu
DQo+ID4NCj4gPiBJc24ndCBpdCBaeW5xTVAgPw0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YS5tYW5uZUB4aWxpbnguY29tPg0KPiA+ID4gLS0tDQo+
ID4gPiBDaGFuZ2VzIGZvciB2MToNCj4gPiA+ICAgICAgICAgICAgICAgICAtTm9uZS4NCj4gPiA+
DQo+ID4gPiBDaGFuZ2VzIGZvciBSRkMtVjI6DQo+ID4gPiAgICAgICAgICAgICAgICAgLVVwZGF0
ZWQgdGhlIEZwZ2EgTWdyIHJlZ2lzdHJhdGlvbnMgY2FsbCdzDQo+ID4gPiAgICAgICAgICAgICAg
ICAgIHRvIDQuMTgNCj4gPiA+DQo+ID4gPiAgZHJpdmVycy9mcGdhL0tjb25maWcgICAgICAgfCAg
IDkgKysrDQo+ID4gPiAgZHJpdmVycy9mcGdhL01ha2VmaWxlICAgICAgfCAgIDEgKw0KPiA+ID4g
IGRyaXZlcnMvZnBnYS96eW5xbXAtZnBnYS5jIHwgMTU5DQo+ID4gPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNjkgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2ZwZ2EvenlucW1wLWZw
Z2EuYw0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvS2NvbmZpZyBiL2Ry
aXZlcnMvZnBnYS9LY29uZmlnIGluZGV4DQo+ID4gPiAxZWJjZWY0YmFiNWIuLjI2ZWJiY2YzZDNh
MyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9LY29uZmlnDQo+ID4gPiArKysgYi9k
cml2ZXJzL2ZwZ2EvS2NvbmZpZw0KPiA+ID4gQEAgLTU2LDYgKzU2LDE1IEBAIGNvbmZpZyBGUEdB
X01HUl9aWU5RX0ZQR0ENCj4gPiA+ICAgICAgICAgaGVscA0KPiA+ID4gICAgICAgICAgIEZQR0Eg
bWFuYWdlciBkcml2ZXIgc3VwcG9ydCBmb3IgWGlsaW54IFp5bnEgRlBHQXMuDQo+ID4gPg0KPiA+
ID4gK2NvbmZpZyBGUEdBX01HUl9aWU5RTVBfRlBHQQ0KPiA+ID4gKyAgICAgICB0cmlzdGF0ZSAi
WGlsaW54IFp5bnFtcCBGUEdBIg0KPiA+ID4gKyAgICAgICBkZXBlbmRzIG9uIEFSQ0hfWllOUU1Q
IHx8IENPTVBJTEVfVEVTVA0KPiA+ID4gKyAgICAgICBoZWxwDQo+ID4gPiArICAgICAgICAgRlBH
QSBtYW5hZ2VyIGRyaXZlciBzdXBwb3J0IGZvciBYaWxpbnggWnlucU1QIEZQR0FzLg0KPiA+ID4g
KyAgICAgICAgIFRoaXMgZHJpdmVyIHVzZXMgcHJvY2Vzc29yIGNvbmZpZ3VyYXRpb24gcG9ydChQ
Q0FQKQ0KPiA+IFRoaXMgZHJpdmVyIHVzZXMgKnRoZSogcHJvY2Vzc29yIGNvbmZpZ3VyYXRpb24g
cG9ydC4NCj4gPg0KPiA+ID4gKyAgICAgICAgIHRvIGNvbmZpZ3VyZSB0aGUgcHJvZ3JhbW1hYmxl
IGxvZ2ljKFBMKSB0aHJvdWdoIFBTDQo+ID4gPiArICAgICAgICAgb24gWnlucU1QIFNvQy4NCj4g
PiA+ICsNCj4gPiA+ICBjb25maWcgRlBHQV9NR1JfWElMSU5YX1NQSQ0KPiA+ID4gICAgICAgICB0
cmlzdGF0ZSAiWGlsaW54IENvbmZpZ3VyYXRpb24gb3ZlciBTbGF2ZSBTZXJpYWwgKFNQSSkiDQo+
ID4gPiAgICAgICAgIGRlcGVuZHMgb24gU1BJDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9m
cGdhL01ha2VmaWxlIGIvZHJpdmVycy9mcGdhL01ha2VmaWxlIGluZGV4DQo+ID4gPiA3YTJkNzNi
YTcxMjIuLjM0ODhlYmJhZWU0NiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9NYWtl
ZmlsZQ0KPiA+ID4gKysrIGIvZHJpdmVycy9mcGdhL01ha2VmaWxlDQo+ID4gPiBAQCAtMTYsNiAr
MTYsNyBAQCBvYmotJChDT05GSUdfRlBHQV9NR1JfU09DRlBHQV9BMTApICAgICs9DQo+IHNvY2Zw
Z2EtYTEwLm8NCj4gPiA+ICBvYmotJChDT05GSUdfRlBHQV9NR1JfVFM3M1hYKSAgICAgICAgICAr
PSB0czczeHgtZnBnYS5vDQo+ID4gPiAgb2JqLSQoQ09ORklHX0ZQR0FfTUdSX1hJTElOWF9TUEkp
ICAgICAgKz0geGlsaW54LXNwaS5vDQo+ID4gPiAgb2JqLSQoQ09ORklHX0ZQR0FfTUdSX1pZTlFf
RlBHQSkgICAgICAgKz0genlucS1mcGdhLm8NCj4gPiA+ICtvYmotJChDT05GSUdfRlBHQV9NR1Jf
WllOUU1QX0ZQR0EpICAgICArPSB6eW5xbXAtZnBnYS5vDQo+ID4gPiAgb2JqLSQoQ09ORklHX0FM
VEVSQV9QUl9JUF9DT1JFKSAgICAgICAgICs9IGFsdGVyYS1wci1pcC1jb3JlLm8NCj4gPiA+ICBv
YmotJChDT05GSUdfQUxURVJBX1BSX0lQX0NPUkVfUExBVCkgICAgKz0gYWx0ZXJhLXByLWlwLWNv
cmUtcGxhdC5vDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS96eW5xbXAt
ZnBnYS5jIGIvZHJpdmVycy9mcGdhL3p5bnFtcC1mcGdhLmMNCj4gPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4uMjc2MGQ3ZTM4NzJhDQo+ID4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gPiArKysgYi9kcml2ZXJzL2ZwZ2EvenlucW1wLWZwZ2EuYw0KPiA+ID4gQEAgLTAs
MCArMSwxNTkgQEANCj4gPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsN
Cj4gPiA+ICsvKg0KPiA+ID4gKyAqIENvcHlyaWdodCAoQykgMjAxOCBYaWxpbngsIEluYy4NCj4g
PiA+ICsgKi8NCj4gPiA+ICsNCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4N
Cj4gPiA+ICsjaW5jbHVkZSA8bGludXgvZnBnYS9mcGdhLW1nci5oPg0KPiA+ID4gKyNpbmNsdWRl
IDxsaW51eC9pby5oPg0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiA+ICsj
aW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJl
c3MuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+DQo+ID4gPiArI2luY2x1ZGUg
PGxpbnV4L2Zpcm13YXJlL3hsbngtenlucW1wLmg+DQo+ID4gPiArDQo+ID4gPiArLyogQ29uc3Rh
bnQgRGVmaW5pdGlvbnMgKi8NCj4gPiA+ICsjZGVmaW5lIElYUl9GUEdBX0RPTkVfTUFTSyAgICAg
MFgwMDAwMDAwOFUNCj4gPiA+ICsNCj4gPiA+ICsvKioNCj4gPiA+ICsgKiBzdHJ1Y3QgenlucW1w
X2ZwZ2FfcHJpdiAtIFByaXZhdGUgZGF0YSBzdHJ1Y3R1cmUNCj4gPiA+ICsgKiBAZGV2OiAgICAg
ICBEZXZpY2UgZGF0YSBzdHJ1Y3R1cmUNCj4gPiA+ICsgKiBAZmxhZ3M6ICAgICBmbGFncyB3aGlj
aCBpcyB1c2VkIHRvIGlkZW50aWZ5IHRoZSBiaXRmaWxlIHR5cGUNCj4gPiA+ICsgKi8NCj4gPiA+
ICtzdHJ1Y3QgenlucW1wX2ZwZ2FfcHJpdiB7DQo+ID4gPiArICAgICAgIHN0cnVjdCBkZXZpY2Ug
KmRldjsNCj4gPiA+ICsgICAgICAgdTMyIGZsYWdzOw0KPiA+ID4gK307DQo+ID4gPiArDQo+ID4g
PiArc3RhdGljIGludCB6eW5xbXBfZnBnYV9vcHNfd3JpdGVfaW5pdChzdHJ1Y3QgZnBnYV9tYW5h
Z2VyICptZ3IsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBmcGdhX2ltYWdlX2luZm8gKmluZm8sDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IHNpemUpDQo+ID4gPiArew0K
PiA+ID4gKyAgICAgICBzdHJ1Y3QgenlucW1wX2ZwZ2FfcHJpdiAqcHJpdjsNCj4gPiA+ICsNCj4g
PiA+ICsgICAgICAgcHJpdiA9IG1nci0+cHJpdjsNCj4gPiA+ICsgICAgICAgcHJpdi0+ZmxhZ3Mg
PSBpbmZvLT5mbGFnczsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+ID4gPiAr
fQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBpbnQgenlucW1wX2ZwZ2Ffb3BzX3dyaXRlKHN0cnVj
dCBmcGdhX21hbmFnZXIgKm1nciwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IHNpemUpIHsNCj4gPiA+ICsgICAgICAgc3RydWN0
IHp5bnFtcF9mcGdhX3ByaXYgKnByaXY7DQo+ID4gPiArICAgICAgIGNoYXIgKmtidWY7DQo+ID4g
PiArICAgICAgIGRtYV9hZGRyX3QgZG1hX2FkZHI7DQo+ID4gPiArICAgICAgIGludCByZXQ7DQo+
ID4gPiArICAgICAgIGNvbnN0IHN0cnVjdCB6eW5xbXBfZWVtaV9vcHMgKmVlbWlfb3BzID0NCj4g
PiA+ICt6eW5xbXBfcG1fZ2V0X2VlbWlfb3BzKCk7DQo+ID4NCj4gPiBSZXZlcnNlIHhtYXMtdHJl
ZSBwbGVhc2UsIGkuZS4gbG9uZyBsaW5lcyBmaXJzdC4NCj4gPg0KPiA+ID4gKw0KPiA+ID4gKyAg
ICAgICBpZiAoIWVlbWlfb3BzIHx8ICFlZW1pX29wcy0+ZnBnYV9sb2FkKQ0KPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRU5YSU87DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHByaXYgPSBt
Z3ItPnByaXY7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGtidWYgPSBkbWFfYWxsb2NfY29oZXJl
bnQocHJpdi0+ZGV2LCBzaXplLCAmZG1hX2FkZHIsDQo+IEdGUF9LRVJORUwpOw0KPiA+ID4gKyAg
ICAgICBpZiAoIWtidWYpDQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
ID4gPiArDQo+ID4gPiArICAgICAgIG1lbWNweShrYnVmLCBidWYsIHNpemUpOw0KPiA+ID4gKw0K
PiA+ID4gKyAgICAgICB3bWIoKTsgLyogZW5zdXJlIGFsbCB3cml0ZXMgYXJlIGRvbmUgYmVmb3Jl
IGluaXRpYXRlIEZXIGNhbGwNCj4gPiA+ICsgKi8NCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgcmV0
ID0gZWVtaV9vcHMtPmZwZ2FfbG9hZChkbWFfYWRkciwgc2l6ZSwgcHJpdi0+ZmxhZ3MpOw0KPiAN
Cj4gRG9uJ3QgeW91IGhhdmUgdG8gZG8gYW55dGhpbmcgd2l0aCB0aGUgZmxhZ3M/IElzIGl0IHJl
YWxseSBqdXN0IGEgcGFzcy10aHJvdWdoIG9mDQo+IEZQR0EgbWFuYWdlciBmbGFncyB0byBlZW1p
IGNhbGxzPw0KPiANCj4gRG9uJ3QgeW91IHdhbnQgdG8gbWFrZSBwYXJ0aWFsIGJpdHN0cmVhbXMg
ZS5nLiB1c2UgYSBmbGFncyB2YWx1ZSB0aGF0IHlvdSBleHBvcnQNCj4gaW4geW91ciBmaXJtd2Fy
ZSBoZWFkZXIgKHhsbngtenlucW1wLmgpIGFuZCBzZXQgdGhvc2UgYmFzZWQgb24gd2hhdCBmbGFn
cyBnZXQNCj4gcGFzc2VkIGluLCBpLmUuIGV4cGxpY2l0ZWx5IHRyYW5zbGF0ZSBGUEdBIE1hbmFn
ZXIgZmxhZ3MgdG8geW91ciBmaXJtd2FyZSBmbGFncz8NCg0KQXQgdGhpcyBwb2ludCBvZiB0aW1l
IHRoZSBmaXJtd2FyZSB1c2UgRmxhZyAwIGZvciBmdWxsIEJpdHN0cmVhbSBhbmQgMSBmb3IgcGFy
dGlhbCBiaXRzdHJlYW0gbG9hZGluZy4NClNvIEkgaGF2ZSBub3QgZG9pbmcgYW55IGV4cGxpY2l0
IHRyYW5zbGF0ZSBGUEdBIE1hbmFnZXIgZmxhZ3MgaW5zaWRlIHRoZSBkcml2ZXIuDQpXaWxsIGRv
Y3VtZW50IHRoZSBmbGFncyBpbmZvIGluIHhsbngtenlucW1wLmgNCg0KUmVnYXJkcywNCk5hdmFr
aXNob3JlLg0K
