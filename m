Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD775C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5035020824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SEOHRI8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5035020824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeJXPMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:12:02 -0400
Received: from mail-by2nam03on0079.outbound.protection.outlook.com ([104.47.42.79]:6416
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbeJXPMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ewb2CCaok6Zmbeo9Bhhnfi+YSKkM3xYT35X0YDb3V4=;
 b=SEOHRI8odFrVDaz0ay9Z0DIdI+DhZ71ZY0tr/bnqgQr6u0TT+EdcXdz7EXHFHoO2xr4huWJ0KiIDFApMYZIOiqLK3cCgQb2T/3x2bALFeOIQfxGRIqMShGa0H/OwwEVxJ9+/R9FeYrS+uD9hJKMnAbEkzrmOR6nJ0vN7WEIbwco=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB5560.namprd02.prod.outlook.com (20.177.230.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Wed, 24 Oct 2018 06:45:13 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8d0d:7d34:1d3:52d]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8d0d:7d34:1d3:52d%4]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 06:45:12 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Alan Tull <atull@kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Subject: RE: [PATCH 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Thread-Topic: [PATCH 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Thread-Index: AQHUZ4iwAV2KiqpHJkaYTH9bDhS7XKUrjfsAgAJsrvA=
Date:   Wed, 24 Oct 2018 06:45:11 +0000
Message-ID: <BYAPR02MB47101F176968C213EA05B5D5C2F60@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
 <20181020084805.29103-3-nava.manne@xilinx.com>
 <CANk1AXQ_AFGX9_80YM7-GYncfZ8pOhaYdSb=O-ZpYCWuHx71vA@mail.gmail.com>
In-Reply-To: <CANk1AXQ_AFGX9_80YM7-GYncfZ8pOhaYdSb=O-ZpYCWuHx71vA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB5560;6:QCELmocf6owfpMm2x0F3n7EZp9J9o+3ksMmQ7CaZNxnTEYx2qvwqomoTs/cLhrJmT7KDz5YTxhIJlbm21DSSji7OfsnpmbGZKAjd+UnOhCXbwhdOMUkseD8Wm4jtVBs0gkhfGXbjNL0Rf7rX7ZUlZtTDrPA6VaPBcgu+aMKVk3PUsmCjlwzm9FevHCcYOYFO0c0VwGw1GQt2X6hFKKCkWCwMGgh7dN3ZdOtQbruZSeUZRGR5aZQLb1ilsgo4n3j4pyVJey21AvvMCSuEyIaJpUrsXqwV3Gr/R09IOyyFU4yTXygmcYIm7uG8pRyODS7c6MP6+rh14dPX7NbkATnnf5Rl8FS3Bd0dUDtV5tv8Ke2IWcM/WBFEzduFiBvnHKGOSvOkiivz9EMunLa8udO2dI7aP7OfIfcxGNwRp42ZJVB2WdsPSzdRKpebTpC+E8tmyqEkbYYqpmYSz8Qzjt4LPg==;5:n5gWFos1HT/M8QH6heCpuwj1AZRqOVquiCKBzgn3EputFvp/ZxrV/btFr3Z4cKOxSXjkOF9FKkl6ij1fRbGdlulZXc1DwHRMPrmznFtdMldnXSO5EdA7tiP/h2+D8uTLoDwKEp4vCP57bxLgMk/vy8L0/yn2Yw5C7vMQYXjwdZo=;7:EHTq/2phtx2dKskcC/tL3tSjl3lHlxmIHDgfRVIN7V/J/lg1/Vxw2ZWNMh/594wk5TqQ2dFoRSoBm+7fpZgrbiNZSZNYEevvlc1v261gmtu8sJCaziCgPWCOFGfrLwyiv93vjvwnoIDR3yIaODAc/+dEpasAnJms/pwzVKyrlKK/cwdncAGY8iU5NeTjmEf66FhhzDapruNYfqdnc3su0XbEKUQFynXaO3J9ZQlvsOdpFHYpwjYUZtxeCMTnMOk4
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(51914003)(189003)(199004)(13464003)(25786009)(68736007)(102836004)(8936002)(6916009)(486006)(5250100002)(305945005)(66066001)(81156014)(55016002)(2906002)(74316002)(76176011)(7736002)(7696005)(54906003)(9686003)(99286004)(316002)(81166006)(8676002)(6506007)(53546011)(71200400001)(6436002)(71190400001)(476003)(5660300001)(53936002)(6116002)(229853002)(14454004)(575784001)(3846002)(2900100001)(4326008)(446003)(11346002)(105586002)(478600001)(33656002)(26005)(39060400002)(256004)(106356001)(6246003)(97736004)(86362001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5560;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 4a8df514-0ac8-48d0-10d2-08d6397c3f4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB5560;
x-ms-traffictypediagnostic: BYAPR02MB5560:
x-microsoft-antispam-prvs: <BYAPR02MB5560F96A050DE56DFABB970AC2F60@BYAPR02MB5560.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592)(180628864354917)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB5560;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5560;
x-forefront-prvs: 083526BF8A
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0GDSiQUXNqKbqIEzxDTV+NXdIlz8oOt2QsW8+wz/1wOqyeV/IMqVQ14ytlAzsF1JCnV1ZCa5TQ5ml8IYavZN33jBQL7YOxlP9jcWbXwBvkc07xZaKUiW1wPUDokHGrKvo3xZJg9LIRfIsoLFskwy4Hs085/8SSmMU8nfL3+GUznzMzIiFvk6mE94bSYB5kE95DIcGb3pGCaVOmD3pOhfUJxqYJOV/FxudweTln2M8b8dHs2HRuMB3iivnz5f2ntv8COk7nrxuuZY9nM8vOi78YiE3w3PpbM++WagPA1Yx84HYbmbnsjdQ/6WlO0stYtLbYh4Pc3esHt4y6+tJUmVAlnBUHgazqbXTIxCVfETXSM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8df514-0ac8-48d0-10d2-08d6397c3f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 06:45:11.8553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5560
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KVGhhbmtzIGZvciB0aGUgcXVpY2sgcmVzcG9uc2UuLg0KUGxlYXNlIGZpbmQg
bXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEFsYW4gVHVsbCBbbWFpbHRvOmF0dWxsQGtlcm5lbC5vcmddDQo+IFNlbnQ6IE1vbmRheSwg
T2N0b2JlciAyMiwgMjAxOCAxMToxMiBQTQ0KPiBUbzogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZh
bUB4aWxpbnguY29tPg0KPiBDYzogTW9yaXR6IEZpc2NoZXIgPG1kZkBrZXJuZWwub3JnPjsgUm9i
IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47DQo+IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRs
YW5kQGFybS5jb20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+IFJhamFu
IFZhamEgPFJBSkFOVkB4aWxpbnguY29tPjsgSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+
OyBsaW51eC0NCj4gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJF
IEFORCBGTEFUVEVORUQgREVWSUNFDQo+IFRSRUUgQklORElOR1MgPGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnPjsgbW9kZXJhdGVkDQo+IGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJN
IEFSQ0hJVEVDVFVSRSA8bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47
IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IGtpc2hvcmUg
bSA8Y2hpbm5pa2lzaG9yZTM2OUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8z
XSBkdC1iaW5kaW5nczogZnBnYTogQWRkIGJpbmRpbmdzIGZvciBaeW5xTVAgZnBnYQ0KPiBkcml2
ZXINCj4gDQo+IE9uIEZyaSwgT2N0IDE5LCAyMDE4IGF0IDM6NDkgQU0gTmF2YSBraXNob3JlIE1h
bm5lDQo+IDxuYXZhLm1hbm5lQHhpbGlueC5jb20+IHdyb3RlOg0KPiANCj4gSGkgTmF2YSwNCj4g
DQo+IEp1c3Qgc29tZSBuaXRzLCBiZWxvdy4NCj4gDQo+ID4NCj4gPiBBZGQgZG9jdW1lbnRhdGlv
biB0byBkZXNjcmliZSBYaWxpbnggWnlucU1QIGZwZ2EgZHJpdmVyIGJpbmRpbmdzLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhLm1hbm5lQHhpbGlueC5j
b20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBmb3IgdjE6DQo+ID4gICAgICAgICAgICAgICAgIENy
ZWF0ZWQgYSBTZXBlcmF0ZShOZXcpIERUIGJpbmRpbmcgZmlsZSBhcw0KPiA+ICAgICAgICAgICAg
ICAgICBzdWdnZXN0ZWQgYnkgUm9iLg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3IgUkZDLVYyOg0KPiA+
ICAgICAgICAgICAgICAgICAtTW92ZWQgcGNhcCBub2RlIGFzIGEgY2hpbGQgdG8gZmlyd21hcmUN
Cj4gPiAgICAgICAgICAgICAgICAgIG5vZGUgYXMgc3VnZ2VzdGVkIGJ5IFJvYi4NCj4gPg0KPiA+
ICAuLi4vYmluZGluZ3MvZnBnYS94bG54LHp5bnFtcC1wY2FwLWZwZ2EudHh0ICAgICB8IDE3ICsr
KysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9mcGdhL3hsbngsenlucW1wLXBjYXAtZnBnYS50eHQNCj4gPg0KPiA+IGRpZmYgLS1naXQN
Cj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL3hsbngsenlucW1w
LXBjYXAtZnBnYS50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9m
cGdhL3hsbngsenlucW1wLXBjYXAtZnBnYS50eHQNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjQ4ZmYwZWU2MGE4DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL3hsbngsenlu
cW1wLXBjYXAtZnBnYS50eHQNCj4gPiBAQCAtMCwwICsxLDE3IEBADQo+ID4gKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICstLS0tLQ0KPiANCj4gUGxlYXNlIGdldCByaWQgb2YgYWxsIHRoZXNlICctLS0tJyBz
ZXBhcmF0b3JzIChpbiA0IHBsYWNlcykuDQo+IA0KV2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lv
bi4NCg0KPiA+ICtEZXZpY2UgVHJlZSB6eW5xbXAtZnBnYSBiaW5kaW5ncyBmb3IgdGhlIFp5bnEg
VWx0cmFzY2FsZSsgTVBTb0MNCj4gPiArY29udHJvbGxlZCB1c2luZyBaeW5xTVAgU29DIGZpcm13
YXJlIGludGVyZmFjZQ0KPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArLS0tLS0gRm9yIEJpdHN0cmVh
bSBjb25maWd1cmF0aW9uIG9uIFp5bnFNcCBTb2MgdXNlcyBwcm9jZXNzb3INCj4gPiArY29uZmln
dXJhdGlvbg0KPiA+ICtwb3J0KFBDQVApIHRvIGNvbmZpZ3VyZSB0aGUgcHJvZ3JhbW1hYmxlIGxv
Z2ljKFBMKSB0aHJvdWdoIFBTIGJ5DQo+ID4gK3VzaW5nIEZXIGludGVyZmFjZS4NCj4gPiArDQo+
ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0aWJsZTogc2hvdWxkIGNvbnRh
aW4gInhsbngsenlucW1wLXBjYXAtZnBnYSINCj4gPiArDQo+ID4gKy0tLS0tLS0NCj4gPiArRXhh
bXBsZQ0KPiANCj4gTml0OiBwbGVhc2UgYWRkIGEgY29sb24gc28gJ0V4YW1wbGU6Jw0KV2lsbCBm
aXggaW4gdGhlIG5leHQgdmVyc2lvbg0KDQpSZWdhcmRzLA0KTmF2YWtpc2hvcmUuDQo=
