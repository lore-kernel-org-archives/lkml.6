Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DDDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADF720866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="1f18PWyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADF720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406487AbeKWE0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:26:10 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:18169 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389307AbeKWE0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:26:09 -0500
X-IronPort-AV: E=Sophos;i="5.56,266,1539673200"; 
   d="scan'208";a="23429014"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 10:45:45 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 22 Nov 2018 10:45:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md6CKl11o8Hy2TIOdtB6iet6/xoHCW+RiVYCsyUG0BI=;
 b=1f18PWyGrYt3E3b+LcPcrCUCjVF8039GDd/NURRqKsOnj9sCwxJqilKGE2VMG8TfO7nEzP6nL+77PY1sebhwGCQ2LF+VBqDQZ9/CCp2OlBLzNQDCs+l6Fu0+iXaAQZiWbOKO7CQyo+/m6AIjOiwjMSXStN5lV19TqDJW0bnOtwo=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1985.namprd11.prod.outlook.com (10.173.31.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 17:45:39 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 17:45:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <eugeniy.paltsev@synopsys.com>
CC:     <boris.brezillon@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <alexey.brodkin@synopsys.com>,
        <vineet.gupta1@synopsys.com>, <linux-snps-arc@lists.infradead.org>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <richard@nod.at>
Subject: Re: [PATCH v2 0/2] MTD: spi-nor: add support for sst26wf016,
 sst26wf032
Thread-Topic: [PATCH v2 0/2] MTD: spi-nor: add support for sst26wf016,
 sst26wf032
Thread-Index: AQHUSPvuffhE0Br5ZEyOxS1chcEkcaUrZ/QAgAAkK4CALBojAIAE3h6A
Date:   Thu, 22 Nov 2018 17:45:39 +0000
Message-ID: <60792e70-a530-3403-f144-c430639d01f1@microchip.com>
References: <20180910114628.19156-1-Eugeniy.Paltsev@synopsys.com>
 <1540216028.19916.6.camel@synopsys.com> <20181022155635.2175a595@bbrezillon>
 <1542641133.4940.5.camel@synopsys.com>
In-Reply-To: <1542641133.4940.5.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0081.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::25) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1985;6:NfMIPUDzLSXoVGAzu8KZisPz4pwWIiDTmgEqc0dZgTmxn0kAGf62eO0wceMHD6fJucilXxUzElfduVczaP3mafYY/HWiBOeHhQy0mAx239VHJA4zgQWRsdk8MzdZqx98gBKxVJ1B232xiLl3h+vuM1eLq81Ioc4DkWXSXkQG+XG8hm1wa/3ThZAhbLhOGE+rs5EyttHcstyynVUlrOnDjCCVP56OgMRm5UCaw3CUdEyy1WpBFG85aBMUj4VLmYkm36eT64caEL/fFAqhT1Sb5oU7GecVygnX5iuM9O1jffp71tMZRPQNjIY+HvYyJIRjDV8dE4JxAukRqyO2BI1dXFfG/4Hd8pQ3Vnc9XGJgqZRDLmYjvdZ5YoI/ckpmWdUEFfGsfSzsPsTHmi7OmJOCInEs1wicYoRZo8XRYR0Fa9mMC+aFBQfHCJhzslVKfKcKc6enZ/iee+glBnZx/6ZPhQ==;5:QXLTUtguM21RAzl4knq2y2crgv97qXV30PxyfZH3s+f/dIFqfzFXB/bqObG+vAnb2VJ5I8PBAk2DeV89UicGhA3fqEzpWMiw/cf0ZwATi3QclYWSUAPif/QVAbiozLF4umrkgC2cZJO8Bm97jTjSZ3cZi6j9AIGom3IRyd25N0I=;7:2FAxp/JnGiyNVZm8Jz4toQr5KbYXtsxyUB907+cgr4fPLxkocwqM2eBVEo1alRgoHNSbNTAP1mwJWApPtXagv2bAoM3/qa9toj4+c+ri+R1M9ialIINq0qzhO3c3AyaqkHJ3dxHu/AyeviJzGN/bog==
x-ms-office365-filtering-correlation-id: 8ac7c5b0-daa1-4ef6-5a59-08d650a250d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1985;
x-ms-traffictypediagnostic: BN6PR11MB1985:
x-microsoft-antispam-prvs: <BN6PR11MB198573E8EF6946989F876510F0DB0@BN6PR11MB1985.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1985;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1985;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(396003)(376002)(189003)(199004)(52284002)(81166006)(81156014)(386003)(14444005)(8936002)(6506007)(256004)(53546011)(76176011)(72206003)(54906003)(31696002)(86362001)(316002)(52116002)(3846002)(106356001)(66066001)(6916009)(8676002)(36756003)(25786009)(478600001)(6116002)(2900100001)(99286004)(2616005)(6512007)(31686004)(39060400002)(14454004)(7736002)(446003)(476003)(11346002)(93886005)(229853002)(71190400001)(71200400001)(486006)(4326008)(5660300001)(97736004)(53936002)(4001150100001)(6246003)(6436002)(186003)(6486002)(345774005)(102836004)(105586002)(26005)(7416002)(2906002)(68736007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1985;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HiqEg9f3o7UqaFedqH7BgwnK40ZL1o96S/7XMgKwyZlFdzs+ZrecTyEZpvS8opyFc3r1JEMz15yagiM19g+UvXgtinvxmexcwmh96ZhPdkmE54ZG/HzABBfCCD7dL3K1907m0rN5+fgEXoRsEXpgqRt2cKTX16fslUNozSKE747gV69JRUH6clLgh+eHUkNxI6kirrBP8YYCkAj+QDvxsK9Y2e2zlqm0GvIKVGj+JKgROPWPzaBkif/PchIKVIO+n6XUbeuE9XtRkJfjcy7kD7ygEQJqr7su6GT58LDXzOnVjl2364R+hFh5TuJ/CHldgQ28ipZAzucyhjfl6VHmmKCTL/1mwiB39rDF/A9WPTo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E61F74ACCEFC2941A03A5B31B46D195C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac7c5b0-daa1-4ef6-5a59-08d650a250d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 17:45:39.4024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1985
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEV1Z2VuaXksDQoNClRoaXMgaXMganVzdCB0byBsZXQgeW91IGtub3cgdGhhdCBJJ20gZ2V0
dGluZyBmYW1pbGlhciB3aXRoIHRoZSBpbmRpdmlkdWFsIGJsb2NrDQpsb2NrIHN1cHBvcnQuIFlv
dSdsbCBoYXZlIG15IHJldmlldyBpbiB0aGUgZmlyc3QgcGFydCBvZiBuZXh0IHdlZWsuDQoNClRo
YW5rIHlvdSBmb3IgeW91ciBwYXRpZW5jZSwNCnRhDQoNCk9uIDExLzE5LzIwMTggMDU6MjUgUE0s
IEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gSGkgQm9yaXMsDQo+IA0KPiBBcyA0LjIwLXJjMSBp
cyBhbHJlYWR5IG91dCBJIGd1ZXNzIHlvdSBjYW4gcGljayB0aGlzIHBhdGNoZXMgdG8gc3BpLW5v
ci9uZXh0Pw0KPiANCj4gVGhhbmtzLg0KPiANCj4gT24gTW9uLCAyMDE4LTEwLTIyIGF0IDE1OjU2
ICswMjAwLCBCb3JpcyBCcmV6aWxsb24gd3JvdGU6DQo+PiArVHVkb3INCj4+DQo+PiBIaSBFdWdl
bml5LA0KPj4NCj4+IFNvcnJ5LCBpdCdzIGFscmVhZHkgdG9vIGxhdGUgZm9yIDQuMjAsIGFuZCBJ
IHdvbid0IGFwcGx5IHBhdGNoZXMgdG8gdGhlDQo+PiBzcGktbm9yL25leHQgYnJhbmNoIGJlZm9y
ZSA0LjIwLXJjMSBpcyBvdXQuDQo+Pg0KPj4gVHVkb3IsIE1hcmVrLCBjYW4gSSBoYXZlIGEgUmV2
aWV3ZWQtYnkvQWNrZWQtYnkgb24gdGhpcyBwYXRjaHNldD8NCj4+DQo+PiBUaGFua3MsDQo+Pg0K
Pj4gQm9yaXMNCj4+DQo+Pj4NCj4+PiBPbiBNb24sIDIwMTgtMDktMTAgYXQgMTQ6NDYgKzAzMDAs
IEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4+Pj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBTU1Qgc3N0
MjZ3ZjAxNiBhbmQgc3N0MjZ3ZjAzMiBmbGFzaCBJQzoNCj4+Pj4NCj4+Pj4gc3N0MjZ3ZioqKiBm
bGFzaCBzZXJpZXMgYmxvY2sgcHJvdGVjdGlvbiBpbXBsZW1lbnRhdGlvbiBkaWZmZXJzIGZyb20g
b3RoZXINCj4+Pj4gU1NUIHNlcmllcywgc28gd2UgYWRkIGltcGxlbWVudGF0aW9uIGZvciBzc3Qy
NndmKioqIGxvY2svdW5sb2NrL2lzX2xvY2tlZA0KPj4+PiBmdW5jdGlvbnMuDQo+Pj4+DQo+Pj4+
IEFkZCBzc3QyNndmMDE2IGFuZCBzc3QyNndmMDMyIGZsYXNoIElDIGluZm8gdG8gc3BpX2ZsYXNo
X2lkcyBsaXN0Lg0KPj4+Pg0KPj4+PiBFdWdlbml5IFBhbHRzZXYgKDIpOg0KPj4+PiAgIG10ZDog
c3BpLW5vcjogQWRkIHN1cHBvcnQgb2Ygc3N0MjZ3ZiogZmxhc2ggSUNzIHByb3RlY3Rpb24gb3Bz
DQo+Pj4+ICAgbXRkOiBzcGktbm9yOiBhZGQgc3VwcG9ydCBmb3Igc3N0MjZ3ZjAxNiwgc3N0MjZ3
ZjAzMg0KPj4+Pg0KPj4+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAxNzkgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICBpbmNsdWRlL2xp
bnV4L210ZC9zcGktbm9yLmggICB8ICAgNCArDQo+Pj4+ICAyIGZpbGVzIGNoYW5nZWQsIDE4MyBp
bnNlcnRpb25zKCspDQo+Pj4+ICAgDQo+Pg0KPj4NCg==
