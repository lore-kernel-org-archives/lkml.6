Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2514204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XsOONAXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2514204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeJ3Cu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:50:57 -0400
Received: from mail-by2nam03on0041.outbound.protection.outlook.com ([104.47.42.41]:23520
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbeJ3Cu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L127UQzvofIQ1HXfyx2/Pdl4fbcOHPGziShUtchSZY=;
 b=XsOONAXrW4JDJakLLwfJJixIykH+OeYqWPmrFqikB714QWw2pp7PMwNTXjvSdvX70ik3o5SXoDkXUQo8JgOtkB/ofVzm3GO9wobz0jYBtcSj0rvLRriy+gq0ET95ipcglunByfA7XPbEfBmO7vHIFMvND70oSeF7wGJpr6GFzy8=
Received: from DM5PR02MB2233.namprd02.prod.outlook.com (10.168.173.147) by
 DM5PR02MB2635.namprd02.prod.outlook.com (10.168.196.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Mon, 29 Oct 2018 18:01:12 +0000
Received: from DM5PR02MB2233.namprd02.prod.outlook.com
 ([fe80::cc96:c4e5:a161:caf3]) by DM5PR02MB2233.namprd02.prod.outlook.com
 ([fe80::cc96:c4e5:a161:caf3%5]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 18:01:06 +0000
From:   Jiaying Liang <jliang@xilinx.com>
To:     Wendy Liang <sunnyliangjy@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Thread-Topic: [PATCH v4 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Thread-Index: AQHUYGmN7EvU2AwWOkK/zNK80ad40KUYPoqAgADY14CAHYnHIA==
Date:   Mon, 29 Oct 2018 18:01:06 +0000
Message-ID: <DM5PR02MB2233AC6A0276887869AF72C9B0F30@DM5PR02MB2233.namprd02.prod.outlook.com>
References: <1539155912-29760-1-git-send-email-wendy.liang@xilinx.com>
 <1539155912-29760-3-git-send-email-wendy.liang@xilinx.com>
 <20181010095741.GA14472@e107155-lin>
 <CAA07jV_FWxMRq=4hmTdCXJG6e3=-8AejfpKxmh9KUi9KQDH7yQ@mail.gmail.com>
In-Reply-To: <CAA07jV_FWxMRq=4hmTdCXJG6e3=-8AejfpKxmh9KUi9KQDH7yQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jliang@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR02MB2635;6:ThI/0w7/XSgMfamc6I5d5ObC6Ueo1qNsoDEisl4t1vd5hyJ36ip4je9PlqG3FxSl5Bmbqy8hcVK+pxOZbrXlbyi6q+Ns4FqMxiu9xEyIzTG7Gf/qmtM8z45zjNPxalLcrp0lq93Dwh8BuPa5YUYW3HEzcD/TeSsFMSxdgzquRIJvD2oK0yRO8U6yk49VeRyD9lk5obRbi2fmiW3roVFZ3bZQ8zLkDcmxK1FQmkr3ZlCinOe2aKUF/SVEykdpFzcoD19hCMFtOpDhRcVlT/ujj9dGWGAt5ygRw4W+8dA/HFCgVlPgr9BRrXzo8eRbEXgpghsZJQqeNXiwqt5IjzlQjolvGSneiDCZTp4tu+re0ii5rv73aj+DSsbkmTOkyXhA/YC3o6y5nNSmJse5hcB9ngPpEP3Z7QgnLXcTMvJkq2H52DaIABLRrUUrjLPMpsHXK47FjOYfdUwFLPXIXdyD6Q==;5:MCZEwufuPpXw7IDTx3K7U8S55ms+/Po+d4NctbpD6L4ts+jcDEBiUFVZs5D4K2M38hWRyFALJWo8ikPiFYlb2YFfNoFY1gW0m6q3FywzOWy065e1+1ObrVnS7aiGeNEpXajYYSvW2Wes4AaMeAjVmcV7qYBbTEQ9xdUFEzDzwgE=;7:by/2bISXF6k9fR5i5sQbpJWxpDQu1ho8XLHqwy+hbzTaiChzrcCivqS+1if4FNpZq/6DFOB+dCWVC41wZ9WtDYvrtOrluQtyGQ3eB5Ielbh49Tx7BnPJzFH2YY/2h2zOiEM0cJL3GjpzM6ftEQ6bnw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(376002)(39860400002)(13464003)(189003)(199004)(14454004)(105586002)(106356001)(9686003)(71190400001)(25786009)(71200400001)(55016002)(2906002)(76176011)(102836004)(5250100002)(68736007)(5660300001)(15650500001)(6506007)(7696005)(3846002)(6116002)(53546011)(305945005)(74316002)(7736002)(26005)(6246003)(6436002)(229853002)(256004)(81166006)(99286004)(14444005)(53936002)(486006)(33656002)(81156014)(4326008)(8676002)(66066001)(478600001)(8936002)(110136005)(186003)(11346002)(446003)(476003)(86362001)(2900100001)(54906003)(39060400002)(316002)(97736004)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2635;H:DM5PR02MB2233.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 6237baf6-1a8d-4cca-16b1-08d63dc87fd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR02MB2635;
x-ms-traffictypediagnostic: DM5PR02MB2635:
x-microsoft-antispam-prvs: <DM5PR02MB2635E83AD84A8536B8026258B0F30@DM5PR02MB2635.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(9452136761055)(258649278758335)(180628864354917)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR02MB2635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2635;
x-forefront-prvs: 084080FC15
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xh3Wgz+G2ScLN42CPK/uz1dq2BMNqEUq5eo+RDORfvRiFsJbIhNhCGSq7VK9Fr988B8J6IV04fbjjUdI3dmA4sitptwswWN1BVS4f34zVk6Ykn5ud3EtYGuxBXRTuS3B2QfMHU0ur5aVfMXRTyqCfmRrBCUuGu7FiLC0UBfwV/xzYrfk1R0azNnOPSSgsi2Z7fFsPt7GF9QtyfrZmlCGmEa0NXzff5iG+x1AlYEZ+iGrwuUOhuLQ+kGtdO0Tllwk3tiGtY3Ijo8t0PLlWSIimLkQyFEpqHalT336GexuO9KvpQNO+/eInhRcluRdCB8ompWEciYurlWpQEOxNk7+L39TgktE7jHHarR3eCWss6Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6237baf6-1a8d-4cca-16b1-08d63dc87fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 18:01:06.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2VuZHkgTGlhbmcgW21h
aWx0bzpzdW5ueWxpYW5nanlAZ21haWwuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIg
MTAsIDIwMTggMzo1NCBQTQ0KPiBUbzogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNv
bT4NCj4gQ2M6IEppYXlpbmcgTGlhbmcgPGpsaWFuZ0B4aWxpbnguY29tPjsgSmFzc2kgQnJhciA8
amFzc2lzaW5naGJyYXJAZ21haWwuY29tPjsNCj4gTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlu
eC5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsNCj4gTWFyayBSdXRsYW5k
IDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IERldmljZXRyZWUgTGlzdA0KPiA8ZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWFybS1rZXJuZWwgPGxpbnV4LWFybS0NCj4ga2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi8yXSBk
dC1iaW5kaW5nczogbWFpbGJveDogQWRkIFhpbGlueCBJUEkgTWFpbGJveA0KPiANCj4gT24gV2Vk
LCBPY3QgMTAsIDIwMTggYXQgMjo1OSBBTSBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0u
Y29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgT2N0IDEwLCAyMDE4IGF0IDEyOjE4OjMy
QU0gLTA3MDAsIFdlbmR5IExpYW5nIHdyb3RlOg0KPiA+ID4gWGlsaW54IFp5bnFNUCBJUEkoSW50
ZXIgUHJvY2Vzc29yIEludGVycnVwdCkgaXMgYSBoYXJkd2FyZSBibG9jayBpbg0KPiA+ID4gWnlu
cU1QIFNvQyB1c2VkIGZvciB0aGUgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIHZhcmlvdXMgcHJvY2Vz
c29yDQo+ID4gPiBzeXN0ZW1zLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFdlbmR5IExp
YW5nIDx3ZW5keS5saWFuZ0B4aWxpbnguY29tPg0KPiA+DQo+ID4gWy4uLl0NCj4gPg0KPiA+ID4g
K09wdGlvbmFsIHByb3BlcnRpZXM6DQo+ID4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+
ICstIG1ldGhvZDogICAgICAgICAgICAgIFRoZSBtZXRob2Qgb2YgYWNjZXNzaW5nIHRoZSBJUEkg
YWdlbnQgcmVnaXN0ZXJzLg0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgUGVybWl0dGVk
IHZhbHVlcyBhcmU6ICJzbWMiIGFuZCAiaHZjIi4gRGVmYXVsdCBpcw0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgInNtYyIuDQo+ID4NCj4gPiBZb3UgYXJlIG1peGluZyB0aGUgaGFyZHdh
cmUgbWVzc2FnaW5nIGJhc2VkIG1haWxib3ggYW5kIHRoZSBzb2Z0d2FyZQ0KPiA+ICJzbWMvaHZj
IiBiYXNlZCBtYWlsYm94IHRvZ2V0aGVyIGhlcmUuIFBsZWFzZSBrZWVwIHRoZW0gc2VwYXJhdGVk
Lg0KPiA+IElJVUMgc21jL2h2YyBiYXNlZCBtYWlsY294IGlzIHVzZWQgZm9yICJ0eCIgb3IgdG9v
IGtlZXAgaXQgc2ltcGxlIGluDQo+ID4gb25lIGRpcmVjdGlvbiBhbmQgaGFyZHdhcmUgYmFzZWQg
aXMgdXNlZCBmb3IgInJ4IiBvciB0aGUgb3RoZXINCj4gPiBkaXJlY3Rpb24gZm9yIGNvbW11bmlj
YXRpb24uDQo+ID4NCj4gSGkgU3VkZWVwLA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRz
Lg0KPiANCj4gVGhlIElQSSBoYXJkd2FyZSBibG9jayBoYXMgYm90aCBidWZmZXJzIGFuZCByZWdp
c3RlcnMuIFRoZSBoYXJkd2FyZSBibG9jaw0KPiBoYXMgZGVkaWNhdGVkIGJ1ZmZlcnMgZm9yIGVh
Y2ggbWFpbGJveGVzLCBhbmQgdGh1cywgaW4gdGhlIGltcGxlbWVudGF0aW9uLA0KPiB3ZSBkaXJl
Y3RseSBhY2Nlc3MgdGhlIGJ1ZmZlcnMgZnJvbSBJUEkgZHJpdmVyLiBIb3dldmVyLCB0aGUgY29u
dHJvbGxlcg0KPiByZWdpc3RlcnMgYXJlIHNoYXJlZCBiZXR3ZWVuIG1haWxib3hlcyBpbiB0aGUg
aGFyZHdhcmUsIGFzIHRoZSBBVEYgd2lsbCBhbHNvDQo+IGFjY2VzcyB0aGUgcmVnaXN0ZXJzLCB3
ZSBuZWVkIHRvIHVzZSBTTUMvSFZDIHRvIGFjY2VzcyB0aGUgcmVnaXN0ZXJzIChjb250cm9sDQo+
IG9yIElTUikuIEFuZCB0aGUgU01DL0hWQyBoZXJlIGlzIGZvciB0aGUgcmVnaXN0ZXIgYWNjZXNz
Lg0KPiANCj4gSSBhbSBub3QgY2xlYXIgb24gc21jL2h2YyBiYXNlZCBtYWlsYm94IGlzIHVzZWQg
Zm9yIHR4LCBhbmQgaGFyZHdhcmUgYmFzZWQNCj4gaXMgdXNlZCBmb3IgICJyeCIuIEFzIGZvciBi
b3RoIFRYIGFuZCBSWCwgd2UgbmVlZCB0byB3cml0ZS9yZWFkIHRoZSByZWdpc3RlcnMNCj4gKHRo
cm91Z2ggU01DKSBhbmQgd3JpdGUvcmVhZCB0aGUgYnVmZmVycyBwcm92aWRlZCBieSB0aGUgSVBJ
IGhhcmR3YXJlIGJsb2NrDQo+IGRpcmVjdGx5Lg0KW1dlbmR5XSBIaSBTdWRlZXAsDQoNClRoZSBT
TUMvSFZDIGlzIGZvciBoYXJkd2FyZSByZWdpc3RlcnMgYWNjZXNzIGFzIGJ1dCBub3Qgc2VuZGlu
ZyBtZXNzYWdlcy4NCkRvIHlvdSBoYXZlIGZ1cnRoZXIgY29tbWVudHMgb3IgYXJlIHlvdSBmaW5l
IHdpdGggdGhlIGV4cGxhbmF0aW9uPw0KDQpUaGFua3MsDQpXZW5keQ0KDQo+IA0KPiBUaGFua3Ms
DQo+IFdlbmR5DQo+IA0KPiA+IFlvdSAqc2hvdWxkIG5vdCogbWl4IHRoZW0gYXMgc2luZ2xlIHVu
aXQuIEFsc28gbG90cyBvZiBvdGhlciB2ZW5kb3INCj4gPiBuZWVkIFNNQy9IVkMgYmFzZWQgbWFp
bGJveC4gU28gbWFrZSBpdCBnZW5lcmljIGFuZCBrZWVwIGl0IHNlcGFyYXRlLg0KPiA+DQo+ID4g
LS0NCj4gPiBSZWdhcmRzLA0KPiA+IFN1ZGVlcA0K
