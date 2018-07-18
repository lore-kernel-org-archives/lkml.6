Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C4CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3880D205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="g1053/qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3880D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lairdtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeGRMGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:06:16 -0400
Received: from mail-eopbgr690121.outbound.protection.outlook.com ([40.107.69.121]:1741
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727640AbeGRMGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9/H2YsrxWIVGLPbSIP1nIC3hrHspd3FR9th9lM4KE8=;
 b=g1053/qsgoYon11Z6UPLVk+yVeIb6/0WD75k2111i/WggXSlD/V29OK94XiKhqx0cucreONAP9NI3035m/LF0qeIim1SwlTyd1DgXwLhHOYyZk1+1/p5cOy4PSHuS+vIr75bZtXqu5LtnMK/hYO9HUgwptIsMh7JsFV1zZLZTzA=
Received: from BY1PR02MB1114.namprd02.prod.outlook.com (10.162.108.140) by
 BY1PR02MB1276.namprd02.prod.outlook.com (10.162.109.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Wed, 18 Jul 2018 11:28:41 +0000
Received: from BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da]) by BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da%4]) with mapi id 15.20.0952.021; Wed, 18 Jul 2018
 11:28:41 +0000
From:   Ben Whitten <Ben.Whitten@lairdtech.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?utf-8?B?TWljaGFlbCBSw7ZkZXI=?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?utf-8?B?S29uc3RhbnRpbiBCw7ZobQ==?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "contact@snootlab.com" <contact@snootlab.com>,
        Brian Ray <brian.ray@link-labs.com>,
        "lora@globalsat.com.tw" <lora@globalsat.com.tw>,
        Alexander Graf <agraf@suse.de>,
        =?utf-8?B?TWljaGFsIEt1YmXEjWVr?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "seth.forshee@canonical.com" <seth.forshee@canonical.com>
Subject: RE: [RFC net-next 00/15] net: A socket API for LoRa
Thread-Topic: [RFC net-next 00/15] net: A socket API for LoRa
Thread-Index: AQHUESvs76hBN1IPF0edb2dht4kHWaSKLTiQgAZ/oYCABDUGQA==
Date:   Wed, 18 Jul 2018 11:28:41 +0000
Message-ID: <BY1PR02MB11143134B9ABAC9C9929A9C4E7530@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <BY1PR02MB11147C7443AB9623D6B65798E75A0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <e08cdcfb-207f-bd73-2afd-f775810b72b7@suse.de>
In-Reply-To: <e08cdcfb-207f-bd73-2afd-f775810b72b7@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [109.174.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR02MB1276;7:nuhsuh3yRShBQtMIScx3DroTTcKllYsiCHV3qm6BKY84S4C/LZMoMZQjFGMVmZN0v01Fo/k580vnL+kz4XXgR6TXOLE8HvCAvO4UyWvNN3elqyIxZ/aLpfcZPknlZr0hAmpSXU4U1QwkiBaukZo/Xv8aJFLAN9MT2DYC6B56emWbsSk3nquwzRT9xFbb6fFncoQUzUvjcfsBenW2rPgTjfPDrPhOWJcphFpk9dkgeNEyPeAKx6TuVO+rUmnKTedc
x-ms-office365-filtering-correlation-id: 86ecc8a8-b106-4a65-6e90-08d5eca19d77
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY1PR02MB1276;
x-ms-traffictypediagnostic: BY1PR02MB1276:
x-microsoft-antispam-prvs: <BY1PR02MB127622EFA5BD0477917C6909E7530@BY1PR02MB1276.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(35073007944872)(84791874153150)(21532816269658);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY1PR02MB1276;BCL:0;PCL:0;RULEID:;SRVR:BY1PR02MB1276;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(346002)(396003)(366004)(136003)(376002)(39860400002)(199004)(189003)(4326008)(6506007)(105586002)(86362001)(66066001)(6916009)(72206003)(476003)(53936002)(486006)(102836004)(8676002)(33656002)(8936002)(81156014)(478600001)(14454004)(39060400002)(68736007)(81166006)(186003)(106356001)(7696005)(26005)(6246003)(966005)(6436002)(7736002)(2906002)(7416002)(25786009)(9686003)(55016002)(446003)(99286004)(229853002)(5250100002)(7406005)(6306002)(3846002)(6116002)(76176011)(74316002)(97736004)(54906003)(14444005)(5660300001)(2900100001)(11346002)(256004)(305945005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR02MB1276;H:BY1PR02MB1114.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QWpXC7VThhjWS0pCbG1Gmv16zv3UD8ZT9JNieN5zluNhtxR5cutNct51HhAK8Hx6Lv1LPfz3oTgfxWS/qBnuX3BwkB2JW+JGKcrq5PIJSG1W6BM7dTgYXbrhLmJZJimh0MgV77HxWZegZ9wJf2oicCNqXo/wX1ySh6Ts8CRKkGjnIS6FB523/5IOMhJg4LnsTJvjObihJyaAvSZcVWXIqHIqMWuJ2ZcLLgwLhIy+z6bEAZYxBqKlHifH4JV9GJjIGh4dXbBqOti2rwkMCTnRnteuCllFTvMtDNHafuyW2uCMoXAbH2F41oeK57deHXdUYhv0FbfHhMdGdHWsCwRSmuq+EHJekInwzjla9x+7Z/A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ecc8a8-b106-4a65-6e90-08d5eca19d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 11:28:41.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1JGQyBuZXQtbmV4dCAwMC8xNV0gbmV0OiBBIHNvY2tldCBBUEkgZm9y
IExvUmENCj4gDQo+ICsgbGludXgtd2lyZWxlc3MgKyBTdGVmYW4gKyBTZXRoDQo+IA0KPiBBbSAx
MS4wNy4yMDE4IHVtIDE3OjIxIHNjaHJpZWIgQmVuIFdoaXR0ZW46DQo+ID4+IFRoaXMgcGF0Y2hz
ZXQgaXMgY2xlYXJseSBub3QgcmVhZHkgZm9yIG1lcmdpbmcsIGJ1dCBpcyBiZWluZw0KPiA+PiBz
dWJtaXR0ZWQgZm9yDQo+ID4+IGRpc2N1c3Npb24sIGFzIHJlcXVlc3RlZCBieSBKaXJpLCBpbiBw
YXJ0aWN1bGFyIG9mIHRoZSBkZXNpZ24NCj4gPj4gY2hvaWNlczoNCj4gPj4NCj4gPj4gMSkgUEZf
TE9SQS9BRl9MT1JBIGFuZCBhc3NvY2lhdGVkIGlkZW50aWZpZXJzIGFyZQ0KPiA+PiBwcm9wb3Nl
ZCB0byByZXByZXNlbnQNCj4gPj4gICAgdGhpcyB0ZWNobm9sb2d5LiBXaGlsZSBmb3IgYW4gU1gx
Mjc2IC0gY2FzZSBhKSBhYm92ZSAtIGl0DQo+ID4+IG1pZ2h0IHdvcmsgdG8NCj4gPj4gICAgbGF5
ZXIgTG9SYVdBTiBhcyBhIHByb3RvY29sIG9wdGlvbiBmb3IgUEZfTE9SQSBhbmQNCj4gYWRkDQo+
ID4+IExvUmFXQU4gYWRkcmVzcw0KPiA+PiAgICBmaWVsZHMgdG8gdGhlIHVuaW9uIGluIG15IHNv
Y2thZGRyX2xvcmEsIGhvdyB3b3VsZCB0aGF0DQo+ID4+IHdvcmsgZm9yIGRldmljZXMNCj4gPj4g
ICAgdGhhdCBvbmx5IHN1cHBvcnQgTG9SYVdBTiBidXQgbm90IHB1cmUgTG9SYT8gRG8gd2UNCj4g
Pj4gbmVlZCBib3RoIEFGX0xPUkEgYW5kDQo+ID4+ICAgIEFGX0xPUkFXQU4sIG9yIGp1c3QgYSBz
ZXBhcmF0ZSBFVEhfUF9MT1JBV0FOIG9yDQo+ID4+IEFSUEhSRF9MT1JBV0FOPw0KPiA+Pg0KPiA+
PiAyKSBQRl9MT1JBIGlzIHVzZWQgd2l0aCBTT0NLX0RHUkFNIGhlcmUuIFRoZQ0KPiA+PiBhc3N1
bXB0aW9uIGlzIHRoYXQgUkFXIG1vZGUNCj4gPj4gICAgd291bGQgYmUgREdSQU0gcGx1cyBwcmVh
bWJsZSBwbHVzIG9wdGlvbmFsDQo+IGNoZWNrc3VtLg0KPiA+Pg0KPiA+PiAzKSBPbmx5IHRoZSB0
cmFuc21pdCBwYXRoIGlzIHBhcnRpYWxseSBpbXBsZW1lbnRlZA0KPiBhbHJlYWR5Lg0KPiA+PiBU
aGUgYXNzdW1wdGlvbg0KPiA+PiAgICBpcyB0aGF0IHRoZSBkZXZpY2VzIHNob3VsZCBnbyBpbnRv
IHJlY2VpdmUgbW9kZSBieQ0KPiBkZWZhdWx0DQo+ID4+IGFuZCBvbmx5DQo+ID4+ICAgIGludGVy
cnVwdCB0aGF0IHdoZW4gYXNrZWQgdG8gdHJhbnNtaXQuDQo+ID4+DQo+ID4+IDQpIFNvbWUgaGFy
ZHdhcmUgc2V0dGluZ3MgbmVlZCB0byBiZSBzdXBwbGllZA0KPiBleHRlcm5hbGx5LA0KPiA+PiBz
dWNoIGFzIHRoZSByYWRpbw0KPiA+PiAgICBmcmVxdWVuY3kgZm9yIHNvbWUgbW9kdWxlcywgYnV0
IG1hbnkgb3RoZXJzIGNhbiBiZQ0KPiA+PiBydW50aW1lLWNvbmZpZ3VyZWQsDQo+ID4+ICAgIHN1
Y2ggYXMgU3ByZWFkaW5nIEZhY3RvciwgQmFuZHdpZHRoLCBTeW5jIFdvcmQsIG9yDQo+IHdoaWNo
DQo+ID4+IGFudGVubmEgdG8gdXNlLg0KPiA+PiAgICBXaGF0IHNldHRpbmdzIHNob3VsZCBiZSBp
bXBsZW1lbnRlZCBhcyBzb2NrZXQgb3B0aW9uDQo+IHZzLg0KPiA+PiBuZXRsaW5rIGxheWVyDQo+
ID4+ICAgIHZzLiBpb2N0bCB2cy4gc3lzZnM/IFdoYXQgYXJlIHRoZSBjcml0ZXJpYSB0byBhcHBs
eT8NCj4gPj4NCj4gPj4gNSkgTWFueSBvZiB0aGUgbW9kdWxlcyBzdXBwb3J0IG11bHRpcGxlIG1v
ZGVzLCBzdWNoIGFzDQo+ID4+IExvUmEsIExvUmFXQU4gYW5kIEZTSy4NCj4gPj4gICAgTGFja2lu
ZyBhIExvUmFXQU4gaW1wbGVtZW50YXRpb24sIEkgYW0gY3VycmVudGx5DQo+ID4+IHN3aXRjaGlu
ZyB0aGVtIGludG8gTG9SYQ0KPiA+PiAgICBtb2RlIGF0IHByb2JlIHRpbWUgd2hlcmV2ZXIgcG9z
c2libGUuIEhvdyBkbyB3ZQ0KPiBkZWFsDQo+ID4+IHdpdGggdGhhdCBwcm9wZXJseT8NCj4gPj4N
Cj4gPj4gICBhKSBJcyB0aGVyZSBhbnkgcHJlY2VkZW5jZSBmcm9tIHRoZSBXaWZpIHdvcmxkIGZv
cg0KPiA+PiBkeW5hbWljYWxseSBzZWxlY3RpbmcNCj4gPj4gICAgICBiZXR3ZWVuIG91ciBvd24g
dHJ1c3RlZCBPcGVuIFNvdXJjZQ0KPiBpbXBsZW1lbnRhdGlvbg0KPiA+PiB2cy4gaGFyZHdhcmUv
ZmlybXdhcmUNCj4gPj4gICAgICBhY2NlbGVyYXRlZCBhbmQvb3IgY2VydGlmaWVkIGltcGxlbWVu
dGF0aW9ucz8NCj4gPj4NCj4gPj4gICBiKSBXb3VsZCBhIHByb29mIG9mIGNvbmNlcHQgZm9yIEZT
SyAobm9uLUxvUmEpIG1vZGVzDQo+IGJlDQo+ID4+IHJlcXVpcmVkIGZvcg0KPiA+PiAgICAgIG1l
cmdpbmcgYW55IExvUmEgZHJpdmVyIGZvciBjaGlwc2V0cyB0aGF0IHN1cHBvcnQNCj4gYm90aD8N
Cj4gPj4gT3IgaXMgdGhlcmUgYW55DQo+ID4+ICAgICAgZmFjaWxpdHkgb3IgZGVzaWduIGd1aWRl
bGluZXMgdGhhdCB3b3VsZCBhbGxvdyB1cyB0bw0KPiBmb2N1cw0KPiA+PiBvbiBMb1JhIGFuZA0K
PiA+PiAgICAgIExvUmFXQU4gYW5kIGxlYXZlIG5vbi1Mb1JhIHJhZGlvIG1vZGVzIHRvIGxhdGVy
DQo+ID4+IGNvbnRyaWJ1dG9ycz8NCj4gPg0KPiA+IERvd24gdGhlIGxpbmUgSSB0aGluayB3ZSBz
aG91bGQgYWxzbyBwbGFuIGZvciBhIENSREEgc3R5bGUNCj4gcmVnZGIgc29tZXdoZXJlIGluIHRo
ZSBwYXRoIGZvciByYXcgTG9SYSB0cmFuc2NlaXZlcnMNCj4gb3BlcmF0aW5nIGFzIHNvZnRNQUMs
IG11Y2ggbGlrZSB3aXRoIFdpRmkuDQo+IA0KPiBZZXMsIEkgaGFkIHJhaXNlZCB0aGUgdG9waWMg
b2Ygd2lyZWxlc3MtcmVnZGIgZm9yIFN0ZWZhbidzDQo+IGNvbmZlcmVuY2UgLQ0KPiBjdXJyZW50
bHkgaXQgc2VlbXMgdG8gb25seSBjb3ZlciAyLjQgR0h6LCA1IEdIeiBhbmQgNjAgR0h6Lg0KPiBO
b3Qgc3VyZSBpZg0KPiB3ZSBjYW4gZWFzaWx5IGV4dGVuZCB0aGF0IHRvIGNvdmVyIDQzMyBNSHos
IDg2OCBNSHosIDkxNQ0KPiBNSHogYW5kIDkyMyBNSHoNCj4gYmFuZHMgb3Igd2hldGhlciB3ZSdk
IGp1c3QgbmVlZCBzb21ldGhpbmcgc2ltaWxhci4uLiBJcw0KPiA4MDIuMTUuNCBhYmxlIHRvDQo+
IHNoYXJlIHRoaXMgZGF0YWJhc2Ugd2l0aCBXaWZpPw0KDQpXZWxsIHRoZSBSRUFETUUgaW4gdGhl
IHdpcmVsZXNzLXJlZ2RiIGRvZXNuJ3QgYmluZCBpdHNlbGYgdG8gODAyMTEsIHRoZXJlIGFyZSBy
ZWZlcmVuY2VzIHRvIHRoZSBvdGhlciBFVFNJIEVOIHNwZWNzIHNvIHRoaXMgd291bGQgYmUgdGhl
IHBsYWNlIHJhdGhlciB0aGFuIGR1cGxpY2F0aW5nLg0KVGhlcmUgd291bGQgbmVlZCBhIGJpdCBv
ZiBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIHRvIGNhcHR1cmUgZHV0eS1jeWNsZSByZXF1aXJlbWVu
dHMsIGhvd2V2ZXIgdGhlIFNSRCBzcGVjIHN0YXRlcyB0aGUgbWF4aW11bSBiYW5kd2lkdGhzIGNh
biBiZSAnVGhlIHdob2xlIGJhbmQnLCBzbyB3aXRoIGEgZmxhZyBzZXQgd2UgY291bGQgaGlqYWNr
IHRoaXMgYmFuZCBpbmZvcm1hdGlvbiBmb3IgZHV0eS1jeWNsZS4NCkkgYW0gdW5zdXJlIGlmIDgw
Mi4xNS40IHVzZXMgdGhpcyBkYXRhYmFzZSwgbW9zdCBvZiB0aGUgbmFtaW5nIHNlZW1zIGdlYXJl
ZCB0b3dhcmRzIDgwMjExLCBubDgwMjExLCBjZmc4MDIxMSBzbyBwZXJoYXBzIHdlIG5lZWQgb3Vy
IG93biB2ZXJzaW9ucyBvZiB0aGVzZSB3aXRoIGEgY29tbW9uIGNvbXBvbmVudCwgSSBob3BlIHRo
ZSBtYWludGFpbmVycyBjYW4gZ2l2ZSBzb21lIGd1aWRhbmNlIGhlcmUuDQoNCj4gQW4gYXJndW1l
bnQgdG8gc2hhcmUgd2l0aCBXaWZpIG1pZ2h0IGJlIHRoYXQgU2VtdGVjaCdzDQo+IFNYMTI4MCBh
bmQgU1gxMjgxDQo+IDIuNCBHSHogdHJhbnNjZWl2ZXJzIGNsYWltIHRvIHN1cHBvcnQgTG9SYSBt
b2R1bGF0aW9uLCB0b28uDQo+IEhhdmluZyB0d28NCj4gZGlmZmVyZW50IHJlZ3VsYXRvcnkgREJz
IGludGVyYWN0IHdpdGggTG9SYSBkcml2ZXJzIHNlZW1zIGENCj4gYmFkIGlkZWEsDQo+IGFuZCBk
dXBsaWNhdGluZyAyLjQgR0h6IGludG8gYSBuZXcgREIgZG9lc24ndCBzb3VuZA0KPiBhcHBlYWxp
bmcgZWl0aGVyLg0KDQpXZWxsIEknbSBub3Qgc3VyZSBpZiB0aGUgbW9kdWxhdGlvbiBhZmZlY3Rz
IHJlZ3VsYXRvcnkgaW5mb3JtYXRpb24sIGp1c3QgYmFuZHMsIHBvd2VyLCBhbmQgdGVjaG5pcXVl
cyBsaWtlIERGUy4NCkFzIHRoZXNlIGNoaXBzIGFyZSAyLjRHSHogb25seSBJIGV4cGVjdCB0aGV5
IGFyZSBib3VuZCBieSB0aGUgZXhpc3RpbmcgcmVndWxhdG9yeSBpbmZvcm1hdGlvbiB3ZSB3b3Vs
ZCBqdXN0IG5lZWQgYSBwYXRoIHRvIGFjY2VzcyBpdC4NCiANCj4gaHR0cHM6Ly93d3cuc2VtdGVj
aC5jb20vcHJvZHVjdHMvd2lyZWxlc3MtcmYvMjQtZ2h6LQ0KPiB0cmFuc2NlaXZlcnMNCj4gDQo+
IE1lYW53aGlsZSBteSBhdHRlbXB0IHRvIHBsYXkgd2l0aCBuZXRsaW5rIGR1cmluZyBTVVNFDQo+
IEhhY2t3ZWVrIGhhcyBiZWVuDQo+IGdvaW5nIHNsb3cgYW5kIEkgY291bGQgdXNlIHNvbWUgZ3Vp
ZGFuY2Ugb3IgYSB2b2x1bnRlZXIgdG8NCj4gY29udHJpYnV0ZTogSQ0KPiBoYXZlIGEgYmFyZSBz
a2VsZXRvbiBvZiByZWdpc3RyYXRpb24sIGNvbW1hbmRzLCBhdHRyaWJ1dGVzDQo+IGFuZCBtdWx0
aWNhc3QNCj4gZ3JvdXBzLCBidXQgbm8gcGxhbiB5ZXQgaG93IHRvIGNvbm5lY3QgdGhhdCB0byB0
aGUgYWN0dWFsDQo+IGRyaXZlcnMgdG8NCj4gcXVlcnkgb3IgYXBwbHkgdGhlIHNldHRpbmdzLi4u
DQoNCkhhcHB5IHRvIGhlbHAsIEkgd2lsbCBiZSBzdGFydGluZyBmcm9tIHplcm8gb24gbmV0bGlu
ayBidXQgSSBjYW4gY29udHJpYnV0ZSBteSBleGlzdGluZyB3b3JrIGluY29ycG9yYXRpbmcgTWFy
a3MgY29tbWVudHMgZm9yIHN4MTMwMSBldGFsLg0KDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2FmYWVyYmVyL2xpDQo+IG51eC1sb3JhLmdpdC90cmVl
L25ldC9sb3JhL25ldGxpbmsuYz9oPWxvcmEtbmV4dA0KPiANCj4gPiBMb1JhIHJhZGlvcyB1c2Vk
IGluIEdhdGV3YXkgZGV2aWNlcyBhcmUgdHlwaWNhbGx5IHJlbGF0aXZlbHkNCj4gaGlnaCBwb3dl
ciAoY2FwYWJsZSBvZiAyN2RCbSkgYW5kIG9wZXJhdGUgaW4gYmFuZHMgd2l0aA0KPiBjZXJ0YWlu
IHJlc3RyaWN0aW9ucywgZWcgdGhlIEVVIGhhcyBrZWVwIG91dCBhcmVhcyB3aXRoaW4NCj4gODY4
TUh6IGZvciBhbGFybXMgYW5kIFNSRCBkZXZpY2VzIG11c3QgYWJpZGUgYnkgY2VydGFpbg0KPiBk
dXR5IGN5Y2xlIHJlc3RyaWN0aW9ucywgdGhlcmUgYXJlIGFsc28gbWF4aW11bSBwb3dlcnMgdG8N
Cj4gY29uc2lkZXIgZm9yIHN1Yi1iYW5kcy4gKEVUU0kgRU4gMzAwIDIyMC0yIFYzLjIuMSwgQmFu
ZHMgSywNCj4gTCwgTSwgTiwgUCwgUSkNCj4gDQo+ID4gVGhlIGNlcnRpZmllZCBBVCBzdHlsZSBt
b2R1bGVzIHdpbGwgKHNob3VsZCkgYWxyZWFkeSBoYXZlDQo+IHRoaXMgcmVndWxhdG9yeSBkYXRh
IGJha2VkIGluIHNvIGl0IG9ubHkgYXBwbGllZCB0byBzaXR1YXRpb25zDQo+IHdoZXJlIHdlIGRy
aXZlIHRoZSB0cmFuc2NlaXZlcnMgZGlyZWN0bHksIGJ1dCBpdCB3b3VsZG4ndA0KPiBodXJ0IHRv
IGNoZWNrIHRoYXQgdGhlIGZyZXF1ZW5jeSBiZWluZyBhc2tlZCB0byB0cmFuc21pdCBvbg0KPiBk
b2Vzbid0IHNwaWxsIGludG8gYSByZXN0cmljdGVkIGJhbmQuDQo+IA0KPiBTb21lIGRvIGhhdmUg
Y29uZmlndXJhdGlvbiBvcHRpb25zIHRoYXQgd2lsbCBuZWVkIHRvIGJlIHNldA0KPiBvciBjaGVj
a2VkLg0KPiANCj4gUmVnYXJkcywNCj4gQW5kcmVhcw0KPiANCj4gLS0NCj4gU1VTRSBMaW51eCBH
bWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCj4gR0Y6IEZlbGl4
IEltZW5kw7ZyZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbg0KPiBIUkIgMjEyODQg
KEFHIE7DvHJuYmVyZykNCg==
