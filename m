Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9430C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6610B20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="HFQrylLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6610B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeLLVqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:46:39 -0500
Received: from mail-eopbgr780077.outbound.protection.outlook.com ([40.107.78.77]:62544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbeLLVqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG0zmTspdFz82A3JqIEFK36sWzEq2DVZvLHAcly7Dhg=;
 b=HFQrylLQVVBf0Rl5Vhc8OiPjSIYDqOdpI1HUTxJLHcZ7GB9lvZ0xemBu3UF6TnVUr0YaLuML/uU8MXEBe+2EeVi2E0aDB9zZ8BfKV8FNEUtXpSe52AN4BnjTVVWedzIf9hTpmHvxIwZbOPnIqDx6S6ovK0puUIvTE3fOTiE32Hs=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5878.namprd05.prod.outlook.com (20.178.50.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.8; Wed, 12 Dec 2018 21:45:54 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.006; Wed, 12 Dec 2018
 21:45:54 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Edward Cree <ecree@solarflare.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 0/4] Static calls
Thread-Topic: [PATCH v2 0/4] Static calls
Thread-Index: AQHUkXwZUa+u7sLIDUq4r+bCTWcEL6V6nNUAgAC7gQCAABGZgIAABVSAgAAtSICAAAXwAIAAAqcA
Date:   Wed, 12 Dec 2018 21:45:53 +0000
Message-ID: <6C3BA76B-6C03-470E-91DB-3228A912F315@vmware.com>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
 <20181211180521.ljdvnnztjnvoijge@treble>
 <86D72260-838C-4CE0-ACE3-BE92A3E9CFD8@vmware.com>
 <899194d1-9777-71ed-70db-212d2983a400@solarflare.com>
 <294E22E9-7577-4716-A531-CBFE628789C3@vmware.com>
 <496ba248-eca5-d432-0ec9-95b2e0d775a1@solarflare.com>
 <B83BB5F6-4EBB-4BCA-9AA2-18EEB6483E7A@vmware.com>
 <406f3f88-026c-f611-3b47-6dee3c6bbb0b@solarflare.com>
In-Reply-To: <406f3f88-026c-f611-3b47-6dee3c6bbb0b@solarflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5878;20:ruaJtyZRDmvSHG+UqnCR/zR6SdmAgvXXShtReIRZwAzm5CvvNr2yopEd4kpJe3YHgJKVO8LWNNMyiNE0CYYXJAo1MGGu7W/d59V89AYBT0a66eo5LpcEajRrHk35A9ITrN2iSd+qNz4f/9JkBzdGPl82ysHKYxV8W48gl5gVNUE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9e5a979a-1e0c-4b8c-2de5-08d6607b3121
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5878;
x-ms-traffictypediagnostic: BYAPR05MB5878:
x-microsoft-antispam-prvs: <BYAPR05MB587839493877CD7EA90E254FD0A70@BYAPR05MB5878.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230020)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5878;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5878;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(366004)(346002)(189003)(199004)(3846002)(6116002)(5660300001)(105586002)(86362001)(6436002)(82746002)(25786009)(8936002)(305945005)(316002)(446003)(7736002)(486006)(93886005)(2616005)(99286004)(11346002)(476003)(229853002)(66066001)(54906003)(6916009)(97736004)(2906002)(6486002)(6506007)(76176011)(256004)(26005)(53546011)(83716004)(186003)(102836004)(106356001)(71200400001)(4326008)(53936002)(14454004)(6246003)(8676002)(81166006)(36756003)(81156014)(71190400001)(33656002)(6512007)(478600001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5878;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w/5kutkNYyPIVx4HG/io1EvKEX3oehz2QTxyiZzWfpZBMoyv4iPtmP1zeS7Na58yGupFbsiTz+MVhQ8Zj9modcveFygVjd7OKP9nYYbSRlS0xY7ugUGr6JU/NSDv1JGP3VkaqSpJUcRs+KWgUO1/vb06MrZRK6sHjXVDg5urAhwvL86k9I5T7i+SDPYlrhKfBLuM06oDueOQv3W9Gby8YgwlDNTjuR3NegxleXNci4aHW6gMgXA7mqf5gX5wZv0e+0wZzjarRQCSeh9MbEp8Mz0EhKpbf9wGPSDQ0M/TLM6IuvugivTxnXXSxbrKkf9r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <597E8FA9ABF53D4C900E2CDFBA89F7DF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5a979a-1e0c-4b8c-2de5-08d6607b3121
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 21:45:53.9444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTIsIDIwMTgsIGF0IDE6MzYgUE0sIEVkd2FyZCBDcmVlIDxlY3JlZUBzb2xhcmZs
YXJlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMi8xMi8xOCAyMToxNSwgTmFkYXYgQW1pdCB3cm90
ZToNCj4+PiBPbiBEZWMgMTIsIDIwMTgsIGF0IDEwOjMzIEFNLCBFZHdhcmQgQ3JlZSA8ZWNyZWVA
c29sYXJmbGFyZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEFJVUkgdGhlIG91dGxpbmUgdmVyc2lv
biB1c2VzIGEgdGFpbC1jYWxsIChpLmUuIGptcHEgKnRhcmdldCkgcmF0aGVyIHRoYW4gYW4NCj4+
PiBhZGRpdGlvbmFsIGNhbGwgYW5kIHJldC4gIFNvIEkgd291bGRuJ3QgZXhwZWN0IGl0IHRvIGJl
IHRvbyBleHBlbnNpdmUuDQo+Pj4gTW9yZSB0byB0aGUgcG9pbnQsIGl0IHNlZW1zIGxpa2UgaXQn
cyBlYXNpZXIgdG8gZ2V0IHJpZ2h0IHRoYW4gdGhlIGlubGluZQ0KPj4+IHZlcnNpb24sIGFuZCBp
ZiB3ZSBnZXQgdGhlIGlubGluZSB2ZXJzaW9uIHdvcmtpbmcgbGF0ZXIgd2UgY2FuIGludHJvZHVj
ZSBpdA0KPj4+IHdpdGhvdXQgYW55IEFQSSBjaGFuZ2UsIG11Y2ggYXMgSm9zaCdzIGV4aXN0aW5n
IHBhdGNoZXMgaGF2ZSBib3RoIHZlcnNpb25zDQo+Pj4gYmVoaW5kIGEgS2NvbmZpZyBzd2l0Y2gu
DQo+PiBJIHNlZS4gRm9yIG15IG91dGxpbmVkIGJsb2NrcyBJIHVzZWQgdGhlIG9wcG9zaXRlIGFw
cHJvYWNoIC0gYSBjYWxsIGZvbGxvd2VkDQo+PiBieSBqbXANCj4gVGhhdCdzIHdoYXQgSm9zaCBk
aWQgdG9vLiAgSS5lLiBjYWxsZXIgY2FsbHMgdGhlIHRyYW1wb2xpbmUsIHdoaWNoIGptcHMgdG8g
dGhlDQo+ICBjYWxsZWU7IGxhdGVyIGl0IHJldHMsIHRha2luZyBpdCBiYWNrIHRvIHRoZSBjYWxs
ZXIuICBQZXJoYXBzIEkgd2Fzbid0IGNsZWFyLg0KPiBUaGUgcG9pbnQgaXMgdGhhdCB0aGVyZSdz
IHN0aWxsIG9ubHkgb25lIGNhbGwgYW5kIG9uZSByZXQuDQoNClNvcnJ5IGZvciB0aGUgbWlzdW5k
ZXJzdGFuZGluZy4NCg0KPiANCj4+PiBJIHdhcyB3b3JraW5nIG9uIHRoZSBhc3N1bXB0aW9uIHRo
YXQgaXQgd291bGQgYmUgb3B0LWluLCB3cmFwcGluZyBhIG1hY3JvDQo+Pj4gYXJvdW5kIGluZGly
ZWN0IGNhbGxzIHRoYXQgYXJlIGtub3duIHRvIGhhdmUgYSBmYWlybHkgc21hbGwgbnVtYmVyIG9m
IGhvdA0KPj4+IHRhcmdldHMuICBUaGVyZSBhcmUgcGxlbnR5IG9mIGluZGlyZWN0IGNhbGxzIGlu
IHRoZSBrZXJuZWwgdGhhdCBhcmUgb25seQ0KPj4+IGNhbGxlZCBvbmNlIGluIGEgYmx1ZSBtb29u
LCBlLmcuIGluIGNvbnRyb2wtcGxhbmUgb3BlcmF0aW9ucyBsaWtlIGV0aHRvb2w7DQo+Pj4gd2Ug
ZG9uJ3QgcmVhbGx5IG5lZWQgdG8gYnVsayB1cCAudGV4dCB3aXRoIHRyYW1wb2xpbmVzIGZvciBh
bGwgb2YgdGhlbS4NCj4+IE9uIHRoZSBvdGhlciBoYW5kLCBJ4oCZbSBub3Qgc3VyZSB0aGUgc3Rh
dGljX2NhbGwgaW50ZXJmYWNlIGlzIHNvIGludHVpdGl2ZS4NCj4+IEFuZCBleHRlbmRpbmcgaXQg
aW50byDigJxkeW5hbWljX2NhbGzigJ0gbWlnaHQgYmUgZXZlbiB3b3JzZS4gQXMgSSBpbml0aWFs
bHkNCj4+IHVzZWQgYW4gb3B0LWluIGFwcHJvYWNoLCBJIGNhbiB0ZWxsIHlvdSB0aGF0IGl0IHdh
cyB2ZXJ5IGV4aGF1c3RpbmcuDQo+IFdlbGwsIGlmIGl0J3MgZG9uZSB3aXRoIGEgZ2NjIHBsdWdp
biBhZnRlciBhbGwsIHRoZW4gaXQgd291bGRuJ3QgYmUgdG9vIGhhcmQNCj4gIHRvIG1ha2UgaXQg
b3B0LW91dC4NCj4gT25lIGFkdmFudGFnZSBvZiB0aGUgZXhwbGljaXQgb3B0LWluIGR5bmFtaWNf
Y2FsbCwgdGhvdWdoLCB3aGljaCBjYW4gYmUgc2Vlbg0KPiAgaW4gbXkgcGF0Y2ggaXMgdGhhdCBt
dWx0aXBsZSBjYWxsIHNpdGVzIGNhbiBzaGFyZSB0aGUgc2FtZSBsZWFybmluZy1zdGF0ZSwNCj4g
IGlmIHRoZXkncmUgZXhwZWN0ZWQgdG8gY2FsbCB0aGUgc2FtZSBzZXQgb2YgZnVuY3Rpb25zLiAg
QW4gb3B0LW91dCBhcHByb2FjaA0KPiAgd291bGQgYXV0b21hdGljYWxseSBnaXZlIGVhY2ggaW5k
aXJlY3QgY2FsbCBzdGF0ZW1lbnQgaXRzIG93biBpbmRpdmlkdWFsIEJUQi4NCj4gRWl0aGVyIHdh
eSwgSSB0aGluayB0aGUgcXVlc3Rpb24gaXMgb3J0aG9nb25hbCB0byB3aGF0IHRoZSB0cmFtcG9s
aW5lcw0KPiAgdGhlbXNlbHZlcyBsb29rIGxpa2UgKGFuZCBldmVuIHRvIHRoZSBpbmxpbmUgdnMg
b3V0bGluZSBxdWVzdGlvbikuDQoNCk5vdCBlbnRpcmVseS4gSWYgdGhlIG1lY2hhbmlzbSBpcyBv
cHQtb3V0IGFuZCBvdXRsaW5lZCwgYW5kIGVzcGVjaWFsbHkgaWYgaXQNCmFsc28gc3VwcG9ydHMg
bXVsdGlwbGUgdGFyZ2V0cywgeW91IG1heSBub3Qgd2FudCB0byBhbGxvY2F0ZSBhbGwgdGhlIG1l
bW9yeQ0KZm9yIHRoZW0gZHVyaW5nIGJ1aWxkLXRpbWUsIGFuZCBpbnN0ZWFkIHVzZSBtb2R1bGUg
bWVtb3J5IHRvIGFsbG9jYXRlIHRoZW0NCmR5bmFtaWNhbGx5ICh0aGF04oCZcyB3aGF0IHdlIGRp
ZCku
