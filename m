Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAFDC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F505213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F505213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gatech.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJINqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:46:31 -0400
Received: from mail-eopbgr720125.outbound.protection.outlook.com ([40.107.72.125]:21204
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbeJINqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:46:31 -0400
Received: from BLUPR0701MB2068.namprd07.prod.outlook.com (10.163.122.150) by
 BLUPR0701MB2068.namprd07.prod.outlook.com (10.163.122.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Tue, 9 Oct 2018 06:31:06 +0000
Received: from BLUPR0701MB2068.namprd07.prod.outlook.com
 ([fe80::d4dd:e205:6dfb:aa5]) by BLUPR0701MB2068.namprd07.prod.outlook.com
 ([fe80::d4dd:e205:6dfb:aa5%5]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 06:31:06 +0000
From:   Mansour Alharthi <malharthi9@gatech.edu>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Alharthi, Mansour A" <mansourah@gatech.edu>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: tracing child threads with address filtering using intel_pt in
 perf
Thread-Topic: tracing child threads with address filtering using intel_pt in
 perf
Thread-Index: AQHUXr6OVM59/0GOJkuWlLqOGl6Xb6UVPTaAgAAqu4CAAQ3agA==
Date:   Tue, 9 Oct 2018 06:31:06 +0000
Message-ID: <bdea7ef1-1cfc-029e-be41-317ac3911a4b@gatech.edu>
References: <8fc78808-db61-2f41-180a-9713178e22f6@gatech.edu>
 <5267CD8C-A8B1-416E-BCCD-5DD87DCA4FB1@gatech.edu>
 <87o9c464gi.fsf@ashishki-desk.ger.corp.intel.com>
 <87k1ms5xdm.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87k1ms5xdm.fsf@ashishki-desk.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0104.namprd02.prod.outlook.com
 (2603:10b6:301:75::45) To BLUPR0701MB2068.namprd07.prod.outlook.com
 (2a01:111:e400:52f4::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mansourah@gatech.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:c0:c380:8c9:9db:c522:dfec:e6d5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR0701MB2068;6:VUuUFTGoP0ghZzszoQCRE7QXX54hkQT+A0tSocWlEXDUg3jCTJkzAZCRA+m7Pnv97xIPxR2lowNTgGws4IiWMCpB6V0cH36OKAJuX3wxc+oAIPqtsweXo9M8hwfMv5y9GHUud6KVjYfiT5F7Q1CF1kuKXecMKKWT7eCVSzbhjWYrNfVj0IXEo2/UUCTk7J4MwRdnCJUkhDLgvbCzjCiqQRRH9esAAMMpbCRP+grcXdrhvWSJrhTr0y5krCWgVv6g7rSNDyO3up7ysMpBffLAvWcBy46IQx4ZwKtLV1cW0Ajt2mqLCdFqIMdvov5C/xjfS6O+bH6Iv4gxO0Y6gMEITgS3VN0rFvXjA07EpxrIXJApFnbGOndODkhhQTlLyYxOlsqsOaxQv9my+rmz4N+FC+a8FZiBc6P/gLpOJdRs8bzv3p1sCiIyeYQFqgwkLwWsWfycJE5qzL1CpuDngn9/pw==;5:p9qa+mxfZX+fPMRzYGZidDVLT+m8PGMdTQWZW6zNGWlPgwFwLqHJHMkyEDNsV6vEeWBteH3zdEsCvWGKTSNjB2E6syRlwCp5z14B+d2AN4QqXCCCzifLBXgr5JfUl/tt8IsnfBeh8aWz7x3I7SPdyfDMYmGceCbxak6rJr2Odek=;7:hh+ayRiqLU6hN49O9dvZChoebmOTCNQ7oR7BocwrQ0jBVh9+sdXtXttp/FpiVjBpVMt/xra01gaLmBpmVKamW3tZ+PkfMUkpj46ZenB0llliO9r4O5L4l7Z/yiRf2fXlq0jwyD9eUHnceW5uhHl/MZc8qAXjIPtNs/+HkdCKnPpQonnAYz+5x61B0jD09IwtZykGPkeQZVP+RnYaqzEsX5R/Im2VPVb1ArKw46oiuF9R4mmLORf8w4BIw22UW+dU
x-ms-office365-filtering-correlation-id: 06bab7ee-0b84-439f-ad74-08d62db0ca54
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0701MB2068;
x-ms-traffictypediagnostic: BLUPR0701MB2068:
x-microsoft-antispam-prvs: <BLUPR0701MB20688881C20DE42DFBC52DFCCCE70@BLUPR0701MB2068.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(108815179253565);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:BLUPR0701MB2068;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB2068;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(136003)(396003)(346002)(189003)(199004)(53754006)(102836004)(88552002)(71200400001)(5660300001)(97736004)(81156014)(93886005)(476003)(81166006)(11346002)(2501003)(186003)(110136005)(14454004)(5250100002)(25786009)(53546011)(6512007)(2171002)(36756003)(14444005)(53936002)(256004)(6506007)(386003)(105586002)(71190400001)(8936002)(316002)(786003)(6246003)(2906002)(2616005)(446003)(305945005)(478600001)(75432002)(31696002)(99286004)(52116002)(4326008)(7736002)(2201001)(31686004)(2900100001)(76176011)(46003)(8676002)(6486002)(486006)(106356001)(229853002)(6116002)(6436002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR0701MB2068;H:BLUPR0701MB2068.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: gatech.edu does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GaP3Bf+DSVgNLB9bvSabXAScXmj7WxTxx/W61spf59um5p9Bfppb/bxIm1h9goe9d/ihHtnT+UZdqZF0jG8eDD80axGUHEM9eolkEEkgEXQrNHvgO0j9PIDCQFGBLb42P2cBAVxI4rt4F6v2+kY2zaN0rFIsaF3EZdyWT8WAXeQmeOqUBmbBIJOlRk2Bbetr4sPenHvG0C8YyTRc3BjNZujhwkY6X0RLnm6tZ0Dj8Z3rxckY7CqNuAZsnie78C1HINZZS6w0rlrX9aaDCPje+Be2EkesyRWYCemgI+cra7hVvgCAXJWenQUfqlwwlcnVQqd3nJ2jY8O3f6y/5BUO9NFCrnjiPrx92D5HpxUVQ78=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <62C6FC0D50C1A14393D3D3514D098867@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bab7ee-0b84-439f-ad74-08d62db0ca54
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 06:31:06.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB2068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IEFsZXggZm9yIHRoZSBwcm9tcHQgcmVzcG9uc2UgYW5kIGZpeCENCg0KaXQgd29y
a3MgcGVyZmVjdGx5IG5vdy4uDQoNCk1hbnNvdXIuLg0KDQoNCk9uIDEwLzA4LzIwMTggMTA6MjUg
QU0sIEFsZXhhbmRlciBTaGlzaGtpbiB3cm90ZToNCj4gQWxleGFuZGVyIFNoaXNoa2luIDxhbGV4
YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPiB3cml0ZXM6DQo+DQo+PiAiQWxoYXJ0aGks
IE1hbnNvdXIgQSIgPG1hbnNvdXJhaEBnYXRlY2guZWR1PiB3cml0ZXM6DQo+Pg0KPj4+IEhlbGxv
IGFsbCwNCj4+IEhpLA0KPj4NCj4+PiBBc3N1bWUgdGhpcyB0ZXN0IGNvZGU6DQo+Pj4NCj4+PiB0
aHJlYWRfc3RhcnQoKXsNCj4+PiAuLi4NCj4+PiB0ZXN0KCk7DQo+Pj4gLi4uDQo+Pj4gfQ0KPj4+
DQo+Pj4gdGVzdCgpew0KPj4+IHByaW50ZigidGVzdCIpOw0KPj4+IH0NCj4+Pg0KPj4+IG1haW4o
KXsNCj4+PiAuLi4NCj4+PiBwdGhyZWFkX2NyZWF0ZSguLi4uLi4sIHRocmVhZF9zdGFydCwuLi4u
KTsNCj4+PiB9DQo+PiBDYW4geW91IGluY2x1ZGUgdGhlIGNvbXBsZXRlIHRlc3QgY2FzZSBjb2Rl
Pw0KPj4NCj4+PiBUcmFjaW5nIHRoZSBhYm92ZSBwcm9ncmFtIHdpdGggdGhlIGZvbGxvd2luZyBj
b21tYW5kOg0KPj4+IHBlcmYgcmVjb3JkIC12IC1tIDUxMiwxMDAwMCAtZSBpbnRlbF9wdC8vdSAt
VCAtLXN3aXRjaC1ldmVudHMgLS1maWx0ZXINCj4+PiAnZmlsdGVyICogQCAuL3Rlc3QnIC0tIC4v
dGVzdA0KPj4gQ2FuIHlvdSBydW4gaXQgd2l0aCAtdnZ2IGFuZCBhbHNvIGluY2x1ZGUgaXRzIG91
dHB1dD8NCj4gU2NyYXRjaCB0aGF0LiBJbnN0ZWFkLCBjYW4geW91IHRyeSB0aGUgYmVsb3cgcGF0
Y2ggYW5kIHNlZSBpZiBpdCB3b3Jrcw0KPiBmb3IgeW91Pw0KPg0KPiBUaGFua3MsDQo+IC0tDQo+
IEFsZXgNCj4NCj4gIEZyb20gMDI5YTcyNmI2M2VkNmViZWY1MjczOTM3MDRjODNkYWI5Yzc2ZmI5
YSBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogQWxleGFuZGVyIFNoaXNoa2luIDxh
bGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPg0KPiBEYXRlOiBNb24sIDggT2N0IDIw
MTggMTc6MTY6MzAgKzAzMDANCj4gU3ViamVjdDogW1BBVENIXSBwZXJmOiBDb3B5IHBhcmVudCdz
IGFkZHJlc3MgZmlsdGVyIG9mZnNldHMgb24gY2xvbmUNCj4NCj4gV2hlbiBhIGNoaWxkIGV2ZW50
IGlzIGFsbG9jYXRlZCBpbiB0aGUgaW5oZXJpdF9ldmVudCgpIHBhdGgsIHRoZSBWTUENCj4gYmFz
ZWQgZmlsdGVyIG9mZnNldHMgYXJlIG5vdCBjb3BpZWQgZnJvbSB0aGUgcGFyZW50LCBldmVuIHRo
b3VnaCB0aGUNCj4gYWRkcmVzcyBzcGFjZSBtYXBwaW5nIG9mIHRoZSBuZXcgdGFzayByZW1haW5z
IHRoZSBzYW1lLCB3aGljaCBsZWFkcw0KPiB0byBubyB0cmFjZSBmb3IgdGhlIG5ldyB0YXNrIHVu
dGlsIGV4ZWMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBTaGlzaGtpbiA8YWxleGFu
ZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICAga2VybmVsL2V2ZW50cy9j
b3JlLmMgfCAxNSArKysrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2V2ZW50cy9jb3JlLmMgYi9rZXJuZWwv
ZXZlbnRzL2NvcmUuYw0KPiBpbmRleCBjODA1NDliZjgyYzYuLjhjZWNiZDYxY2Q5MCAxMDA2NDQN
Cj4gLS0tIGEva2VybmVsL2V2ZW50cy9jb3JlLmMNCj4gKysrIGIva2VybmVsL2V2ZW50cy9jb3Jl
LmMNCj4gQEAgLTEyNTQsNiArMTI1NCw3IEBAIHN0YXRpYyB2b2lkIHB1dF9jdHgoc3RydWN0IHBl
cmZfZXZlbnRfY29udGV4dCAqY3R4KQ0KPiAgICAqCSAgICAgIHBlcmZfZXZlbnRfY29udGV4dDo6
bG9jaw0KPiAgICAqCSAgICBwZXJmX2V2ZW50OjptbWFwX211dGV4DQo+ICAgICoJICAgIG1tYXBf
c2VtDQo+ICsgKgkgICAgICBwZXJmX2FkZHJfZmlsdGVyc19oZWFkOjpsb2NrDQo+ICAgICoNCj4g
ICAgKiAgICBjcHVfaG90cGx1Z19sb2NrDQo+ICAgICogICAgICBwbXVzX2xvY2sNCj4gQEAgLTEw
MDU4LDYgKzEwMDU5LDIwIEBAIHBlcmZfZXZlbnRfYWxsb2Moc3RydWN0IHBlcmZfZXZlbnRfYXR0
ciAqYXR0ciwgaW50IGNwdSwNCj4gICAJCQlnb3RvIGVycl9wZXJfdGFzazsNCj4gICAJCX0NCj4g
ICANCj4gKwkJLyoNCj4gKwkJICogQ2xvbmUgdGhlIHBhcmVudCdzIHZtYSBvZmZzZXRzOiB0aGV5
IGFyZSB2YWxpZCB1bnRpbCBleGVjKCkNCj4gKwkJICogZXZlbiBpZiB0aGUgbW0gaXMgbm90IHNo
YXJlZCB3aXRoIHRoZSBwYXJlbnQuDQo+ICsJCSAqLw0KPiArCQlpZiAoZXZlbnQtPnBhcmVudCkg
ew0KPiArCQkJc3RydWN0IHBlcmZfYWRkcl9maWx0ZXJzX2hlYWQgKmlmaCA9IHBlcmZfZXZlbnRf
YWRkcl9maWx0ZXJzKGV2ZW50KTsNCj4gKw0KPiArCQkJcmF3X3NwaW5fbG9ja19pcnEoJmlmaC0+
bG9jayk7DQo+ICsJCQltZW1jcHkoZXZlbnQtPmFkZHJfZmlsdGVyc19vZmZzLA0KPiArCQkJICAg
ICAgIGV2ZW50LT5wYXJlbnQtPmFkZHJfZmlsdGVyc19vZmZzLA0KPiArCQkJICAgICAgIHBtdS0+
bnJfYWRkcl9maWx0ZXJzICogc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKTsNCj4gKwkJCXJhd19zcGlu
X3VubG9ja19pcnEoJmlmaC0+bG9jayk7DQo+ICsJCX0NCj4gKw0KPiAgIAkJLyogZm9yY2UgaHcg
c3luYyBvbiB0aGUgYWRkcmVzcyBmaWx0ZXJzICovDQo+ICAgCQlldmVudC0+YWRkcl9maWx0ZXJz
X2dlbiA9IDE7DQo+ICAgCX0NCg0K
