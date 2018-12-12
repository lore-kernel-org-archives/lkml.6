Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E02C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA22C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="h6q6/bKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA22C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeLLSOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:14:05 -0500
Received: from mail-eopbgr730060.outbound.protection.outlook.com ([40.107.73.60]:42441
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727748AbeLLSOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQoky+UbPDb8Qs8ZyuZ0pixqq9ZDBgE3LC+FdvJJqfo=;
 b=h6q6/bKsfjy5IR5p6C7GQ0uG+YaJQi9Hi2mtsSr9fnglmy18XN2s4Ru89J1qrCFRIYxb8SX7rpUQbmqe1i7pU/m+F0N7pq3XG9ZKHa+UJV9vUOO65me0WM2Cd4TZQ4DhGMSXpm8+KfLjEkNHdPAroMKQBUB/vB9HtKoMaX49KlY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4088.namprd05.prod.outlook.com (52.135.199.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.11; Wed, 12 Dec 2018 18:14:00 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.006; Wed, 12 Dec 2018
 18:14:00 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Edward Cree <ecree@solarflare.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 0/4] Static calls
Thread-Topic: [PATCH v2 0/4] Static calls
Thread-Index: AQHUkXwZUa+u7sLIDUq4r+bCTWcEL6V6nNUAgAC7gQCAABGZgA==
Date:   Wed, 12 Dec 2018 18:14:00 +0000
Message-ID: <294E22E9-7577-4716-A531-CBFE628789C3@vmware.com>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
 <20181211180521.ljdvnnztjnvoijge@treble>
 <86D72260-838C-4CE0-ACE3-BE92A3E9CFD8@vmware.com>
 <899194d1-9777-71ed-70db-212d2983a400@solarflare.com>
In-Reply-To: <899194d1-9777-71ed-70db-212d2983a400@solarflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4088;20:VdRNx3VdXFHRCOnyIhWtq5uq58db0MAldOSyODvv3VbISj5Sx5tFNjOZkX3MmVY29kOlFK0F8rAGa2zs9UZG+8zxBYx8DujsMzMnwC//KcHcunlOeLOoJ1A0sma8E3/Yqb4ZSioF7yJfwXNXeaeFjicVjcTCSOiRaPct5uskj6E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cd8e62be-f1de-4517-b0db-08d6605d975d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4088;
x-ms-traffictypediagnostic: BYAPR05MB4088:
x-microsoft-antispam-prvs: <BYAPR05MB408892A29B551711051E7E3ED0A70@BYAPR05MB4088.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4088;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4088;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(366004)(346002)(396003)(189003)(199004)(36756003)(106356001)(6916009)(81166006)(83716004)(305945005)(76176011)(2616005)(6246003)(486006)(81156014)(476003)(25786009)(14454004)(105586002)(71190400001)(71200400001)(3846002)(6436002)(6116002)(446003)(7736002)(6486002)(229853002)(86362001)(8936002)(186003)(54906003)(11346002)(82746002)(93886005)(68736007)(4326008)(66066001)(6512007)(97736004)(2906002)(256004)(5660300001)(53546011)(478600001)(33656002)(99286004)(26005)(53936002)(316002)(8676002)(102836004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4088;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 30rNNdvFW6plgwcXOQsqZs0lGuRGCkzwUNozRZP9Q7U6Qem4rYBBx8ebm+/ikTHcVoojpXuk0T5vQ6PqePND2iqapPCMrBnvr+sDVxdWfggYlPrgG5AOItIrNVqTWkRb0NqMCg8/ptl6pTGB1tXUByAvx8oZx+vwTCzuWjaLIPSOcPSNsimTq37t7YM5WwOuIQIDPsr7+2WQkujivKaLVAoL4jnHR6T+IRn/T4deV/0XUcuxkTL2UUzGTmc3t3JdU395ZcgCl7YOMO7ue4tiIifAu68mFutbmiHeQ6N3EO8Pai7a66LcJoC8MSUQm/vR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A82C65EC66013F408BED6DE00A233581@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8e62be-f1de-4517-b0db-08d6605d975d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 18:14:00.5187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTIsIDIwMTgsIGF0IDk6MTEgQU0sIEVkd2FyZCBDcmVlIDxlY3JlZUBzb2xhcmZs
YXJlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMi8xMi8xOCAwNTo1OSwgTmFkYXYgQW1pdCB3cm90
ZToNCj4+IFRoYW5rcyBmb3IgY2PigJlpbmcgbWUuIChJIGRpZG7igJl0IGtub3cgYWJvdXQgdGhl
IG90aGVyIHBhdGNoLXNldHMuKQ0KPiBXZWxsIGluIG15IGNhc2UsIHRoYXQncyBiZWNhdXNlIEkg
aGF2ZW4ndCBwb3N0ZWQgYW55IHlldC4gIChXaWxsIGZvbGxvdyB1cA0KPiAgc2hvcnRseSB3aXRo
IHdoYXQgSSBjdXJyZW50bHkgaGF2ZSwgdGhvdWdoIGl0J3Mgbm90IHByZXR0eS4pDQo+IA0KPiBM
b29raW5nIGF0IHlvdXIgcGF0Y2hlcywgaXQgc2VlbXMgeW91J3ZlIGdvdCBhIG11Y2ggbW9yZSBk
ZXZlbG9wZWQgbGVhcm5pbmcNCj4gIG1lY2hhbmlzbS4gIE1pbmUgb24gdGhlIG90aGVyIGhhbmQg
aXMgYnJ1dGFsbHkgc2ltcGxlIGJ1dCBydW5zIGNvbnRpbnVvdXNseQ0KPiAgKGkuZS4gYWZ0ZXIg
d2UgcGF0Y2ggd2UgaW1tZWRpYXRlbHkgZW50ZXIgdGhlIG5leHQgJ3JlbGVhcm5pbmcnIHBoYXNl
KTsNCj4gIHNpbmNlIGl0IG5ldmVyIGRvZXMgYW55dGhpbmcgYnV0IHByb2QgYSBoYW5kZnVsIG9m
IHBlcmNwdSB2YXJpYWJsZXMsIHRoaXMNCj4gIHNob3VsZG4ndCBiZSB0b28gY29zdGx5Lg0KPiAN
Cj4gQWxzbywgeW91J3ZlIGdvdCB0aGUgbWFjcm9sb2d5IGZvciBtYWtpbmcgYWxsIGluZGlyZWN0
IGNhbGxzIHVzZSB0aGlzLA0KPiAgd2hlcmVhcyBhdCBwcmVzZW50IEkganVzdCBoYXZlIGFuIG9w
ZW4tY29kZWQgaW5zdGFuY2Ugb24gYSBzaW5nbGUgY2FsbCBzaXRlDQo+ICAoSSB3ZW50IHdpdGgg
ZGVsaXZlcl9za2IgaW4gdGhlIG5ldHdvcmtpbmcgc3RhY2spLg0KPiANCj4gU28gSSB0aGluayB3
aGVyZSB3ZSBwcm9iYWJseSB3YW50IHRvIGdvIGZyb20gaGVyZSBpczoNCj4gIDEpIGdldCBKb3No
J3Mgc3RhdGljX2NhbGxzIGluLiAgQUlVSSBMaW51cyBzZWVtcyB0byBwcmVmZXIgdGhlIG91dC1v
Zi1saW5lDQo+ICAgICBhcHByb2FjaDsgSSdkIHNheSBkaXRjaCB0aGUgaW5saW5lIHZlcnNpb24g
KGF0IGxlYXN0IGZvciBub3cpLg0KPiAgMikgYnVpbGQgYSByZWxwb2xpbmVzIHBhdGNoIHNlcmll
cyB0aGF0IHVzZXMNCj4gICAgaSkgc3RhdGljX2NhbGxzIGZvciB0aGUgdGV4dC1wYXRjaGluZyBw
YXJ0DQo+ICAgaWkpIGFzIG11Y2ggb2YgTmFkYXYncyBtYWNyb2xvZ3kgYXMgaXMgYXBwbGljYWJs
ZQ0KPiAgaWlpKSBlaXRoZXIgbXkgb3IgTmFkYXYncyBsZWFybmluZyBtZWNoYW5pc207IHdlIGNh
biBleHBlcmltZW50IHdpdGggYm90aCwNCj4gICAgICAgYmlrZXNoZWQgaXQgaW5jZXNzYW50bHkg
ZXRjLg0KPiANCj4gU2VlbSByZWFzb25hYmxlPw0KDQpNb3N0bHkgeWVzLiBJIGhhdmUgYSBmZXcg
cmVzZXJ2YXRpb25zIChhbmQgbGV04oCZcyBjYWxsIHRoZW0gb3B0cG9saW5lcyBmcm9tDQpub3cg
b24sIHNpbmNlIEpvc2ggZGlzbGlrZWQgdGhlIHByZXZpb3VzIG5hbWUpLg0KDQpGaXJzdCwgSSBz
dGlsbCBoYXZlIHRvIGFkZHJlc3MgdGhlIGlzc3VlcyB0aGF0IEpvc2ggcmFpc2VkIGJlZm9yZSwg
YW5kIHRyeQ0KdG8gdXNlIGdjYyBwbHVnaW4gaW5zdGVhZCBvZiAobW9zdCkgb2YgdGhlIG1hY3Jv
cy4gU3BlY2lmaWNhbGx5LCBJIG5lZWQgdG8NCmJyaW5nIGJhY2sgKGZyb20gbXkgUG9DIGNvZGUp
IHRoZSBwYXJ0IHRoYXQgc2V0cyBtdWx0aXBsZSB0YXJnZXRzLg0KDQpTZWNvbmQsICgyaSkgaXMg
bm90IHZlcnkgaW50dWl0aXZlIGZvciBtZS4gVXNpbmcgdGhlIG91dC1vZi1saW5lIHN0YXRpYw0K
Y2FsbHMgc2VlbXMgdG8gbWUgYXMgbGVzcyBwZXJmb3JtYW50IHRoYW4gdGhlIGlubGluZSAocG90
ZW50aWFsbHksIEkgZGlkbuKAmXQNCmNoZWNrKS4NCg0KQW55aG93LCB0aGUgdXNlIG9mIG91dC1v
Zi1saW5lIHN0YXRpYyBjYWxscyBzZWVtcyB0byBtZSBhcw0KY291bnRlci1pbnR1aXRpdmUuIEkg
dGhpbmsgKGRpZG7igJl0IG1lYXN1cmUpIHRoYXQgaXQgbWF5IGFkZCBtb3JlIG92ZXJoZWFkDQp0
aGFuIGl0IHNhdmVzIGR1ZSB0byB0aGUgYWRkaXRpb25hbCBjYWxsLCByZXQsIGFuZCBzbyBvbiAt
IGF0IGxlYXN0IGlmDQpyZXRwb2xpbmVzIGFyZSBub3QgdXNlZC4gRm9yIG11bHRpcGxlIHRhcmdl
dHMgaXQgbWF5IGJlIHVzZWZ1bCBpbiBzYXZpbmcNCnNvbWUgbWVtb3J5IGlmIHRoZSBvdXRsaW5l
IGJsb2NrIGlzIGR5bmFtaWNhbGx5IGFsbG9jYXRlZCAoYXMgSSBkaWQgaW4gbXkNCnlldCB1bnB1
Ymxpc2hlZCBjb2RlKS4gQnV0IHRoYXTigJlzIG5vdCBob3cgaXTigJlzIGRvbmUgaW4gSm9zaOKA
mXMgY29kZS4NCg0KSWYgd2UgdGFsayBhYm91dCBpbmxpbmUgaW1wbGVtZW50YXRpb24gdGhlcmUg
aXMgYSBkaWZmZXJlbnQgcHJvYmxlbSB0aGF0DQpwcmV2ZW50cyBtZSBvZiB1c2luZyBKb3No4oCZ
cyBzdGF0aWMtY2FsbHMgYXMtaXMuIEkgdHJpZWQgdG8gYXZvaWQgcmVhZGluZyB0bw0KY29tcGFy
ZWQgdGFyZ2V0IGZyb20gbWVtb3J5IGFuZCB0aGVyZWZvcmUgdXNlZCBhbiBpbW1lZGlhdGUuIFRo
aXMgc2hvdWxkDQpwcmV2ZW50IGRhdGEgY2FjaGUgbWlzc2VzIGFuZCBldmVuIHdoZW4gdGhlIGRh
dGEgaXMgYXZhaWxhYmxlIGlzIGZhc3RlciBieQ0Kb25lIGN5Y2xlLiBCdXQgaXQgcmVxdWlyZXMg
dGhlIHBhdGNoaW5nIG9mIGJvdGggdGhlIOKAnGNtcCAldGFyZ2V0LXJlZywgaW1t4oCdDQphbmQg
4oCcY2FsbCByZWwtdGFyZ2V04oCdIHRvIGJlIHBhdGNoZWQg4oCcYXRvbWljYWxseeKAnS4gU28g
dGhlIHN0YXRpYy1jYWxscw0KbWVjaGFuaXNtIHdvdWxkbuKAmXQgYmUgc3VmZmljaWVudC4NCg0K
QmFzZWQgb24gSm9zaOKAmXMgcHJldmlvdXMgZmVlZGJhY2ssIEkgdGhvdWdodCBvZiBpbXByb3Zp
bmcgdGhlIGxlYXJuaW5nIHVzaW5nDQpzb21lIGh5c3RlcmVzaXMuIEFueWhvdywgbm90ZSB0aGF0
IHRoZXJlIGFyZSBxdWl0ZSBhIGZldyBjYXNlcyBpbiB3aGljaCB5b3UNCndvdWxkbuKAmXQgd2Fu
dCBvcHRwb2xpbmVzLiBUaGUgcXVlc3Rpb24gaXMgd2hldGhlciBpbiBnZW5lcmFsIGl0IHdvdWxk
IGJlIGFuDQpvcHQtaW4gb3Igb3B0LW91dCBtZWNoYW5pc20uDQoNCkxldCBtZSBrbm93IHdoYXQg
eW91IHRoaW5rLg0KDQpCVFc6IFdoZW4gaXQgY29tZXMgdG8gZGVsaXZlcl9za2IsIHlvdSBoYXZl
IHBhY2tldF90eXBlIGFzIGFuIGlkZW50aWZpZXIuDQpZb3UgY2FuIHVzZSBpdCBkaXJlY3RseSBv
ciB0aHJvdWdoIGFuIGluZGlyZWN0aW9uIHRhYmxlIHRvIGZpZ3VyZSB0aGUNCnRhcmdldC4gSGVy
ZeKAmXMgYSBjaHVuayBvZiBhc3NlbWJseSBtYWdpYyB0aGF0IEkgdXNlZCBpbiBhIHNpbWlsYXIg
Y2FzZToNCg0KLm1hY3JvIF9jYWxsX3RhYmxlIHZhbDpyZXEgYml0OnJlcSBtYXg6cmVxIHZhbDE6
cmVxIGJpdDE6cmVxDQpjYWxsX3RhYmxlX1x2YWxcKClfXGJpdFwoKToNCiAgICAgICAgdGVzdCAk
KDEgPDwgXGJpdCksICVhbA0KLmlmIFx2YWwxICsgKDEgPDwgXGJpdDEpID49IFxtYXgNCiAgICAg
ICAgam56IHN5c2NhbGxfcmVscG9saW5lX1x2YWwxDQogICAgICAgIGptcCBzeXNjYWxsX3JlbHBv
bGluZV9cdmFsDQouZWxzZQ0KICAgICAgICBqbnogY2FsbF90YWJsZV9cdmFsMVwoKV9cYml0MQ0K
DQogICAgICAgICMgZmFsbC10aHJvdWdoIHRvIG5vIGNhcnJ5LCB2YWwgdW5jaGFuZ2UsIGdvaW5n
IHRvIG5leHQgYml0DQogICAgICAgIGNhbGxfdGFibGUgXHZhbCxcYml0MSxcbWF4DQogICAgICAg
IGNhbGxfdGFibGUgXHZhbDEsXGJpdDEsXG1heA0KLmVuZGlmDQouZW5kbQ0KDQoubWFjcm8gY2Fs
bF90YWJsZSB2YWw6cmVxIGJpdDpyZXEgbWF4OnJlcQ0KLmFsdG1hY3JvDQogICAgICAgIF9jYWxs
X3RhYmxlIFx2YWwsXGJpdCxcbWF4LCUoXHZhbCArICgxIDw8IFxiaXQpKSwlKFxiaXQgKyAxKQ0K
Lm5vYWx0bWFjcm8NCi5lbmRtDQoNCkVOVFJZKGRpcmVjdF9zeXNjYWxsKQ0KICAgICAgICBtb3Yg
JWVzaSwgJWVheA0KICAgICAgICBjYWxsX3RhYmxlIHZhbD0wIGJpdD0wIG1heD0xNg0KRU5EUFJP
QyhkaXJlY3Rfc3lzY2FsbCk=
