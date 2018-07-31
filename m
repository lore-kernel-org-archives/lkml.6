Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62962C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DC220862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OzcYOjP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DC220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbeGaOwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:52:55 -0400
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:32800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732068AbeGaOwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kQUKyCQ8agxIUpLafMmtlCZN+mjsi7TGYRBiEVYsQs=;
 b=OzcYOjP8oN5z7IjJCumTq93F6zr3JNK3n2hDV5Gkg2m5PZWUksvYqB7IX6DzbGo/7clXiaATsrdB1XVqH+Uw2tfklUKuTtF8HiIfiK3a6j21TKmCTDUKv1XpoELTDoXqrtMPA8DYBHHnBy5YXUffIvk+xvzgj9KCiR2FrEO6YUM=
Received: from MWHPR0201MB3481.namprd02.prod.outlook.com (10.167.161.158) by
 MWHPR0201MB3529.namprd02.prod.outlook.com (10.167.162.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Tue, 31 Jul 2018 13:12:32 +0000
Received: from MWHPR0201MB3481.namprd02.prod.outlook.com
 ([fe80::8c23:c29e:5c0a:a63f]) by MWHPR0201MB3481.namprd02.prod.outlook.com
 ([fe80::8c23:c29e:5c0a:a63f%3]) with mapi id 15.20.1017.010; Tue, 31 Jul 2018
 13:12:32 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        "atull@opensource.altera.com" <atull@opensource.altera.com>,
        "moritz.fischer@ettus.com" <moritz.fischer@ettus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        "atull@kernel.org" <atull@kernel.org>
Subject: RE: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
Thread-Topic: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
Thread-Index: AQHUKLXjboO8pwvbjE2osMCstNpM9qSpP4UAgAAOb+A=
Date:   Tue, 31 Jul 2018 13:12:32 +0000
Message-ID: <MWHPR0201MB34814FE28937F4A6F3540C72C22E0@MWHPR0201MB3481.namprd02.prod.outlook.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
 <63c5cfb5-e36b-86b7-732e-c37fe47a7fec@xilinx.com>
In-Reply-To: <63c5cfb5-e36b-86b7-732e-c37fe47a7fec@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3529;6:vtDWI8xDQG92X4Lf3DrmmH6CTNVuqyMwc8XkfDcv2vztUAQi+ZSedcDvB6IB3qZ5h+RB7WQsywG5JbPqWXly4vCNbttcGBNg7TGWpCASDMfZMgRkMCDv2XcBnAsv/p8uBjw0lArQ9jLTzjYHhOHOkb9eI8iWUkU6YP5tJ+hOBwYccZneQW4FI7Cs/opqabgk3p3NaOgbV2EjDx0msxM62BDySvsw3pK4z0k3b9WR5b2mxyK5U4mpBh7fqlNrzAEy6rJRGGW7dsqnXNnAnyA9jvYp3WAJM4ylE5AnE0xtjZKji0vP1mMfSjrv4RdEWhDVd0VAIdpEsVoUNa1QQQWB0di7kOVm1XwKPGkcV6GIysM2Ah01CXGRXQfre5Hr6x/4+sWJTW5csL17/DPQ5r7lqDlSdw83aJlEqj6e/ys68WBGcNgWcqQNaue3TQnfNTmwfn3M6DfY7e/NX2XOV0Ye0Q==;5:HGR+0KP8LgjtKCIFLrOpUICckPEvwmDpXKoR25ceMvqIr8qe+uF9i0swLjf1L7NFny8zsSgr1g6gepk7OUvl41VjfYHqeJGKUBlJkfryM14bCh+QdZEECf58Wu3fYh97Wy9Z7QGmOF2FI8qexUWuAZwlv2Vhf+8OTjyIdMiT58s=;7:tuKUjZh7S9SXQryWFPQlSOxcRqYh6GtXV/C11QQAmNxiRI1cwiep445tntt1/Dk9JiAfncknzmVnmCGRSAHDGEoiZLQP14SiYPindCyP5Qcc1tgFhfbiLV8FX5QsgCt/CifMo7QhnnU89/sar7bV0C1IUPwqDuNKHEmf6mBiIIU582/b+Arb0yejpGYAqpoU4TdDZvnAocJ56WRcJD9NiVn3Y4URH0arddFPo5Rsh543mTpLecBW0YoL59WvwWlD
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 987c803f-846f-4385-6827-08d5f6e746bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3529;
x-ms-traffictypediagnostic: MWHPR0201MB3529:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR0201MB3529E0D94C1EFBE353DFA5A3C22E0@MWHPR0201MB3529.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(80048183373757)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0201MB3529;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3529;
x-forefront-prvs: 0750463DC9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(13464003)(189003)(199004)(51914003)(2501003)(446003)(66066001)(25786009)(55016002)(26005)(86362001)(229853002)(3846002)(53546011)(6506007)(102836004)(476003)(11346002)(33656002)(5250100002)(97736004)(6436002)(2900100001)(8936002)(478600001)(2201001)(14454004)(106356001)(105586002)(9686003)(217873002)(7736002)(39060400002)(8676002)(486006)(53936002)(256004)(305945005)(99286004)(316002)(2906002)(110136005)(5660300001)(6246003)(81156014)(81166006)(7696005)(6116002)(76176011)(74316002)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3529;H:MWHPR0201MB3481.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0kPm8U/n2oHjU3xKRG+wzucSoG2nLschcP5HZzM7TEnuRscPMGGNbeHJkwoQc0ZK36AOEiQZk6YGfc1QyGi/+4YjM+oIhUUKnqT4OtRNLkfrTLXZuXcBmPaqr4KFo+M8ywZN5Ovdlg1rZRRtwbVSAxFMecIKiBwfCF7W5VwmKOEe6lKAhZZlnsObeddssbGW5U32E0bxgeFSfdZFp4Tf4o1RFbLJRknahVjQBmyGUcCvB7/FaPh7TlCnl4JNTzJsAEHmoUckGmlyQHknqN3UrCi6np55nScMa5QPAype5y4cjCLsn6EsGWlumc35+S2sX+bkaihPKfOiRyFksKYB9rj5RNyXdSBA6PauK+2FfVk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987c803f-846f-4385-6827-08d5f6e746bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2018 13:12:32.5738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3529
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcXVpY2sgcmVzcG9uc2UuLg0KDQpQbGVhc2Ugc2VlIG15IGNvbW1lbnRz
IGlubGluZS4uLi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNo
YWwgU2ltZWsgW21haWx0bzptaWNoYWwuc2ltZWtAeGlsaW54LmNvbV0NCj4gU2VudDogVHVlc2Rh
eSwgSnVseSAzMSwgMjAxOCA1OjQ4IFBNDQo+IFRvOiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFt
QHhpbGlueC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29t
OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IFNvcmVuIEJyaW5rbWFubg0KPiA8
c29yZW5iQHhpbGlueC5jb20+OyBhdHVsbEBvcGVuc291cmNlLmFsdGVyYS5jb207DQo+IG1vcml0
ei5maXNjaGVyQGV0dHVzLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IEFwcGFuYSBEdXJnYQ0KPiBLZWRhcmVzd2FyYSBSYW8gPGFwcGFuYWRAeGlsaW54LmNv
bT47IGNoaW5uaWtpc2hvcmUzNjlAZ21haWwuY29tDQo+IENjOiBOYXZhIGtpc2hvcmUgTWFubmUg
PG5hdmFtQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDEvMl0gQVJNOiBk
dDogZnBnYTogQWRkZWQgYmluZGluZyBkb2NzIGZvciBYaWxpbngNCj4genlucW1wIEZQR0EgbWFu
YWdlcg0KPiANCj4gT24gMS44LjIwMTggMTI6MDQsIE5hdmEga2lzaG9yZSBNYW5uZSB3cm90ZToN
Cj4gPiBOZXcgYmluZGluZ3MgZG9jdW1lbnQgZm9yIHp5bnFtcCBmcGdhIG1hbmFnZXIuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhpbGlueC5jb20+
DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGxueCx6eW5xbXAt
cGNhcC1mcGdhLnR4dCAgIHwgOSArKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2ZwZ2EveGxueCx6eW5xbXAtDQo+IHBjYXAtZnBnYS50eHQNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS94bG54
LHp5bnFtcC1wY2FwLQ0KPiBmcGdhLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9mcGdhL3hsbngsenlucW1wLXBjYXAtDQo+IGZwZ2EudHh0DQo+ID4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjBlYWM3NDc3NDdmNQ0KPiA+IC0tLSAv
ZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBn
YS94bG54LHp5bnFtcC1wY2FwLWZwZ2EudHh0DQo+ID4gQEAgLTAsMCArMSw5IEBADQo+ID4gK1hp
bGlueCBaeW5xbXAgRlBHQSBNYW5hZ2VyDQo+IA0KPiBUaGlzIHNob3VsZCBiZSBaeW5xTVAuDQo+
IA0KV2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lvbi4uDQoNCj4gPiArDQo+ID4gK1JlcXVpcmVk
IHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0aWJsZToJCXNob3VsZCBjb250YWluICJ4bG54LHp5
bnFtcC1wY2FwLWZwZ2EiDQo+ID4gKw0KPiA+ICtFeGFtcGxlOg0KPiA+ICsJcGNhcDogcGNhcEAw
MCB7DQo+IA0KPiBubyByZWFzb24gZm9yIGFkZHJlc3MgaWYgdGhlcmUgaXMgbm8gYW55IGJlbG93
Lg0KPiANCiBXaWxsIGZpeCBpbiB0aGUgbmV4dCB2ZXJzaW9uLi4uLg0KDQpSZWdhcmRzLA0KTmF2
YWtpc2hvcmUuDQo=
