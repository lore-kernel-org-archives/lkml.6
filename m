Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E14C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFB324790
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFB324790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeGCUbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:31:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:41690 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752647AbeGCUbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:31:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 13:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,305,1526367600"; 
   d="scan'208";a="72011303"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga002.jf.intel.com with ESMTP; 03 Jul 2018 13:31:36 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 3 Jul 2018 13:31:36 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.236]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.230]) with mapi id 14.03.0319.002;
 Tue, 3 Jul 2018 13:31:36 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
Thread-Topic: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
Thread-Index: AQHUEk16taaoNplRM0+eF95VPrt6a6R87tKAgAAKawCAAJzkAIAAXc9Q
Date:   Tue, 3 Jul 2018 20:31:35 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB365F0@ORSMSX110.amr.corp.intel.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com>
 <CAJZ5v0h5+O8xf_EqRPfdvtjQ7BvxLp8veaxB-7WsD8wq7RUFpA@mail.gmail.com>
 <9a9ef2bc-a66f-2af7-8766-b74426f062a6@arm.com>
 <CAJZ5v0j+9QOw1s3W07QRPDRydsdw7uSAgpvOwF_5302+zeViOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+9QOw1s3W07QRPDRydsdw7uSAgpvOwF_5302+zeViOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWI0ZjdjZDItMzAzMy00NWY3LWFlZTAtNmUxNzE4NzdjMjhlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUVgwXC9xZlM1QmVFRkR4bVBaciswd25hSE5CeVJ4aStoU1U4UU1BVENvVklMMlRKVW9KU3NVeWEycENCdldUaVwvIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1hY3BpLQ0KPiBvd25lckB2Z2VyLmtlcm5l
bC5vcmddIE9uIEJlaGFsZiBPZiBSYWZhZWwgSi4gV3lzb2NraQ0KPiBTZW50OiBUdWVzZGF5LCBK
dWx5IDMsIDIwMTggMTI6NTIgQU0NCj4gVG86IEplcmVteSBMaW50b24gPGplcmVteS5saW50b25A
YXJtLmNvbT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IFNj
aG1hdXNzLCBFcmlrDQo+IDxlcmlrLnNjaG1hdXNzQGludGVsLmNvbT47IGxpbnV4LWFjcGlAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgUmFmYWVsIEog
LiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5ldD47IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0u
Y29tPg0KPiBTdWJqZWN0OiBSZTogNC4xOHJjMyBUWDIgYm9vdCBmYWlsdXJlIHdpdGggIkFDUElD
QTogQU1MIHBhcnNlcjogYXR0ZW1wdCB0bw0KPiBjb250aW51ZSBsb2FkaW5nIHRhYmxlIGFmdGVy
IGVycm9yIg0KPiANCj4gT24gVHVlLCBKdWwgMywgMjAxOCBhdCAxMjozMCBBTSwgSmVyZW15IExp
bnRvbiA8amVyZW15LmxpbnRvbkBhcm0uY29tPg0KPiB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+
IE9uIDA3LzAyLzIwMTggMDQ6NTIgUE0sIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiA+Pg0K
PiA+PiBPbiBNb24sIEp1bCAyLCAyMDE4IGF0IDExOjQxIFBNLCBKZXJlbXkgTGludG9uDQo+ID4+
IDxqZXJlbXkubGludG9uQGFybS5jb20+DQo+ID4+IHdyb3RlOg0KPiA+Pj4NCj4gPj4+IEhpLA0K
PiA+Pj4NCj4gPj4+IEknbSBleHBlcmllbmNpbmcgdHdvIHByb2JsZW1zIHdpdGggY29tbWl0IDUw
ODg4MTRhNmU5MzEgd2hpY2ggaXMNCj4gIkFDUElDQToNCj4gPj4+IEFNTCBwYXJzZXI6IGF0dGVt
cHQgdG8gY29udGludWUgbG9hZGluZyB0YWJsZSBhZnRlciBlcnJvciINCj4gPj4+DQo+ID4+PiBU
aGUgZmlyc3QgaXMgdGhpcyBib290IGZhaWx1cmUgb24gYSB0aHVuZGVyWDI6DQo+ID4+Pg0KPiA+
Pj4gWyAgIDEwLjc3MDA5OF0gQUNQSSBFcnJvcjogSWdub3JlIGVycm9yIGFuZCBjb250aW51ZSB0
YWJsZSBsb2FkDQo+ID4+PiAoMjAxODA1MzEvcHNvYmplY3QtNjA0KQ0KPiA+Pj4gICAgICBbICAg
MTAuNzc3OTI2XSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UgYXQNCj4gPj4+ICAgICAgWyAgIDEwLjk1MDE5OV0gQ2FsbCB0cmFjZToNCj4gPj4+DQo+ID4+
PiAgICAgIFsgICAxMC45NTI2NjNdICBhY3BpX3BzX3BlZWtfb3Bjb2RlKzB4MWMvMHg0MA0KPiA+
Pj4gICAgICBbICAgMTAuOTU2Nzk3XSAgYWNwaV9wc19jcmVhdGVfb3ArMHg1NC8weDI3OA0KPiA+
Pj4gICAgICBbICAgMTAuOTYwODQyXSAgYWNwaV9wc19wYXJzZV9sb29wKzB4MWI0LzB4NmM4DQo+
ID4+PiAgICAgIFsgICAxMC45NjUwNjNdICBhY3BpX3BzX3BhcnNlX2FtbCsweGUwLzB4MmI0DQo+
ID4+PiAgICAgIFsgICAxMC45NjkxMDhdICBhY3BpX3BzX2V4ZWN1dGVfdGFibGUrMHhhMC8weDEw
NA0KPiA+Pj4gICAgICBbICAgMTAuOTczNTA1XSAgYWNwaV9uc19leGVjdXRlX3RhYmxlKzB4MTIw
LzB4MTk0DQo+ID4+PiAgICAgIFsgICAxMC45Nzc5ODldICBhY3BpX25zX3BhcnNlX3RhYmxlKzB4
MzQvMHg2OA0KPiA+Pj4gICAgICBbICAgMTAuOTgyMTIyXSAgYWNwaV9uc19sb2FkX3RhYmxlKzB4
NGMvMHhiYw0KPiA+Pj4gICAgICBbICAgMTAuOTg2MTY5XSAgYWNwaV90Yl9sb2FkX25hbWVzcGFj
ZSsweDFkNC8weDI0MA0KPiA+Pj4gICAgICBbICAgMTAuOTkwNzQ0XSAgYWNwaV9sb2FkX3RhYmxl
cysweDUwLzB4YmMNCj4gPj4+ICAgICAgWyAgIDEwLjk5NDYxNF0gIGFjcGlfaW5pdCsweGI4LzB4
Mzc0DQo+ID4+PiAgICAgIFsgICAxMC45OTc5NTldICBkb19vbmVfaW5pdGNhbGwrMHg1NC8weDIw
OA0KPiA+Pj4gICAgICBbICAgMTEuMDAxODI5XSAga2VybmVsX2luaXRfZnJlZWFibGUrMHgyMjQv
MHgzMDANCj4gPj4+ICAgICAgWyAgIDExLjAwNjIyOV0gIGtlcm5lbF9pbml0KzB4MTgvMHgxMTgN
Cj4gPj4+ICAgICAgWyAgIDExLjAwOTc0N10gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDE4DQo+ID4+
PiAgICAgIFsgICAxMS4wMTMzNTRdIENvZGU6IGFhMDAwM2YzIGFhMWUwM2UwIGQ1MDMyMDFmIGY5
NDAwNjYxICgzOTQwMDAyMCkNCj4gPj4+ICAgICAgWyAgIDExLjAxOTUzNV0gLS0tWyBlbmQgdHJh
Y2UgMmJkODA2ODU5M2NmOGFjYyBdLS0tDQo+ID4+PiAgICAgIFsgICAxMS4wMjQxOTVdIEtlcm5l
bCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24NCj4gPj4+ICAgICAgWyAgIDEx
LjAyOTQ4OF0gU01QOiBzdG9wcGluZyBzZWNvbmRhcnkgQ1BVcw0KPiA+Pj4gICAgICBbICAgMTEu
MDMzNDgwXSAtLS1bIGVuZCBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogRmF0YWwgZXhjZXB0
aW9uDQo+ID4+PiBdLS0tDQo+ID4+Pg0KPiA+Pj4gV2hpY2ggZG9lcyBhcHBlYXIgdG8gYmUgdGhl
IHJlc3VsdCBvZiBzb21lIGJhZCBkYXRhIGluIHRoZSB0YWJsZSwNCj4gPj4+IGJ1dCBpdCB3YXMg
d29ya2luZyB3aXRoIDQuMTcsIGFuZCByZXZlcnRpbmcgdGhpcyBjb21taXQgc29sdmVzIHRoZQ0K
PiA+Pj4gcHJvYmxlbS4NCj4gPj4NCj4gPj4NCj4gPj4gQnV0IHRoaXMgY29tbWl0IGZpeGVzIGFu
b3RoZXIgcmVncmVzc2lvbiB3aGljaCB3YXMgbW9yZSB3aWRlc3ByZWFkLg0KPiA+Pg0KPiA+PiBB
cHBhcmVudGx5LCB3ZSBjYW4ndCB3b3JrIGFyb3VuZCBhbGwgb2YgdGhlIGVycm9ycyBpbiB0aGUg
dGFibGVzIG91dA0KPiA+PiB0aGVyZSBhdCB0aGUgc2FtZSB0aW1lLiA6LS8NCj4gPg0KPiA+DQo+
ID4gTlAsIExldCBtZSBzZWUgaWYgSSBjYW4gY29tZSB1cCB3aXRoIGEgd2F5IHRvIGhhcmRlbiB0
aGUNCj4gPiBwYXJzZV9sb29wL2NyZWF0ZV9vcCBjb2RlIGVub3VnaCB0aGF0IGl0IGRvZXNuJ3Qg
Y3Jhc2ggdGhlIG1hY2hpbmUuDQo+IA0KPiBTdXJlLiAgSSdsbCBsb29rIGF0IGl0IHRvby4NCg0K
SSBpdCBsb29rcyBsaWtlIHRoZXJlIGFyZSBlcnJvciBjYXNlcyB0aGF0IGhhdmUgeWV0IHRvIGJl
IGltcGxlbWVudGVkLi4uDQpKZXJlbXksIGNvdWxkIHNlbmQgYW4gQUNQSSBkdW1wIG9mIHRoaXMg
dGh1bmRlclgyIG1hY2hpbmU/DQoNClRoYW5rcywNCkVyaWsNCg0KPiAtLQ0KPiBUbyB1bnN1YnNj
cmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgbGludXgtYWNw
aSIgaW4gdGhlIGJvZHkgb2YNCj4gYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5v
cmcgTW9yZSBtYWpvcmRvbW8gaW5mbyBhdA0KPiBodHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9y
ZG9tby1pbmZvLmh0bWwNCg==
