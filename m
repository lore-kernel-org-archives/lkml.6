Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBB1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953B1214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953B1214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeIRALk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:11:40 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:53168 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIRALk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:11:40 -0400
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 94CFBB5;
        Mon, 17 Sep 2018 18:43:04 +0000 (UTC)
Received: from G9W8668.americas.hpqcorp.net (16.220.49.27) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 17 Sep 2018 18:43:04 +0000
Received: from G9W9210.americas.hpqcorp.net (16.220.66.155) by
 G9W8668.americas.hpqcorp.net (16.220.49.27) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 17 Sep 2018 18:43:03 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Mon, 17 Sep 2018 18:43:03 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0978.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Mon, 17 Sep 2018 18:43:02 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1143.014; Mon, 17 Sep 2018
 18:43:02 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] x86: pgtable: Drop pXd_none() checks from
 pXd_free_pYd_table()
Thread-Topic: [PATCH 3/5] x86: pgtable: Drop pXd_none() checks from
 pXd_free_pYd_table()
Thread-Index: AQHUSoMTsCmedJ847kC065sH/qNN66TwQJAAgAQe5ACAAHgFAA==
Date:   Mon, 17 Sep 2018 18:43:02 +0000
Message-ID: <62056eebf0627d9aeaa1e208f77e660977e158af.camel@hpe.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
         <1536747974-25875-4-git-send-email-will.deacon@arm.com>
         <dc8b03de1e3318e3dd577d80482260f99ab4e9a5.camel@hpe.com>
         <20180917113321.GB22717@arm.com>
In-Reply-To: <20180917113321.GB22717@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0978;6:B93d1AXSckPVqlGLPgTr7O29iV8eATCi8bJqQglxHIq1nnTVbFTuTgK1eXk6+1GM7h4RKGjJTMlW7c8c5FMpWbx/Mk75qckeItVJDYsKd4Aoysw0HZdf44zR0GoFqzkky3FEyKtyvGsdeVKb8lTgv/qJU5DXCn1iHJ3P/qIHN2MZTdoqDWmDWMy31AXazl79XsBQRZie1/RfhMEBd+ZVrUX65IpCPjiJYNYqQZqZmorEZw+4OcqAIxy/p0ESeUhLjzPGN82G+nYFhWY+7Zir1otMSQOYJEfh3CKSs3pf+fk30Yh7W0Vjx0qP2D6ds/FIXF0rugwseugSWt7mtqlb4hJ9RsYoG1fiFClz6x6Plvnp5VgDR2WCGsRXSe0KAxzAKrQUAqIZA3B0VkDrhSY1uehwCrcgHbOSWUiMF/fOFM9mbSMl/+S/CpGK2iL/wHUKIW6QJYyhp4/vAtpMW937oQ==;5:QXDCm7Ev6AaU+A8YYAyGdGr7qn1nckNvmZ68wIF314EphsHvC/hAfzBj6QamDHNqcI19CiYnhBdiHHek/5yVL9BJmEjrfTgKWbcRzS66ElNoH3R2LoCYbEW+Cl1frOZOxiIpxD7bpqx6bd8bOTdM0u96cq26nlkVYVS2UwKHqY0=;7:vg+pVKW6JAO8yM6eFGGSqbiYz+dJPgshQQlKjl0MOY7rexyYeA8N4c0gCNJz0LxO9HPFqYEDp6emP6gz/IejWVzU0adx90vz9tWEehQnvVUPATwIBx16qI83uIV+DQ+RZ+gkOrz2g6MdggJ+zx5/pNZKG4l866VDjN/FcgZ8ogeW9KUPe4JEejFg4LqDipW71vIifJPEUy9ysngEIK35PZuudklyaELf/l2+wTW1wXgsqekSV2tQtx3qm6elorx2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9c2764a3-bbce-4db6-6544-08d61ccd65eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0978;
x-ms-traffictypediagnostic: AT5PR8401MB0978:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB097808BD905CC248BDA7D147821E0@AT5PR8401MB0978.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(180628864354917)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:AT5PR8401MB0978;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0978;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(346002)(376002)(57704003)(199004)(189003)(2501003)(81166006)(256004)(86362001)(6916009)(66066001)(478600001)(68736007)(2351001)(7736002)(6506007)(305945005)(5660300001)(36756003)(81156014)(5250100002)(229853002)(2900100001)(8936002)(6512007)(105586002)(14454004)(106356001)(53936002)(99286004)(6486002)(76176011)(118296001)(11346002)(6436002)(4326008)(93886005)(26005)(476003)(186003)(25786009)(5640700003)(446003)(6116002)(3846002)(486006)(2906002)(54906003)(6246003)(8676002)(316002)(102836004)(97736004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0978;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qDNLV9yL9T4GygfzT4FQR81QRB0boEYfQxaVrk0XzjsHdWz5p4a7od+3W3/9a+4o8PTUMEU0oSb2AqJ19s7Khxvk8G2BsVghDUs3hdHCSr11wUduaBjttKyBYAfvTMa5/6uBwgHypzs/BnoQoVD5SASYu5a6amB40448BOEucgKKIUloqCMl8T2KK/jdA80AMHV/213F7f1AWf3PjiTOHQaqJEWZ0BEmwtfx9gp7FkRXJwwYRcEA9l7NYVd8PM4RjxnYZLj1FJdLIQIEl0EYLWxnu4NvY48UqtjCqObd5Nepq+ZphQMtkB+RKHrMtAa1DENpxZ4OqrWxowtSsM9fa5+z2KIP4ca1rgrcvkoap9c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <645DCF0DA2CC8A46ADF9017624263C3B@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2764a3-bbce-4db6-6544-08d61ccd65eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 18:43:02.2061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0978
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA5LTE3IGF0IDEyOjMzICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gRnJpLCBTZXAgMTQsIDIwMTggYXQgMDg6Mzc6NDhQTSArMDAwMCwgS2FuaSwgVG9zaGkgd3Jv
dGU6DQo+ID4gT24gV2VkLCAyMDE4LTA5LTEyIGF0IDExOjI2ICswMTAwLCBXaWxsIERlYWNvbiB3
cm90ZToNCj4gPiA+IE5vdyB0aGF0IHRoZSBjb3JlIGNvZGUgY2hlY2tzIHRoaXMgZm9yIHVzLCB3
ZSBkb24ndCBuZWVkIHRvIGRvIGl0IGluIHRoZQ0KPiA+ID4gYmFja2VuZC4NCj4gPiA+IA0KPiA+
ID4gQ2M6IENoaW50YW4gUGFuZHlhIDxjcGFuZHlhQGNvZGVhdXJvcmEub3JnPg0KPiA+ID4gQ2M6
IFRvc2hpIEthbmkgPHRvc2hpLmthbmlAaHBlLmNvbT4NCj4gPiA+IENjOiBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gPiA+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0Bz
dXNlLmNvbT4NCj4gPiA+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24u
b3JnPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5j
b20+DQo+ID4gPiAtLS0NCj4gPiA+ICBhcmNoL3g4Ni9tbS9wZ3RhYmxlLmMgfCA2IC0tLS0tLQ0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvbW0vcGd0YWJsZS5jIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5jDQo+
ID4gPiBpbmRleCBhZTM5NDU1MmZiOTQuLmI0OTE5YzQ0YTE5NCAxMDA2NDQNCj4gPiA+IC0tLSBh
L2FyY2gveDg2L21tL3BndGFibGUuYw0KPiA+ID4gKysrIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5j
DQo+ID4gPiBAQCAtNzk2LDkgKzc5Niw2IEBAIGludCBwdWRfZnJlZV9wbWRfcGFnZShwdWRfdCAq
cHVkLCB1bnNpZ25lZCBsb25nIGFkZHIpDQo+ID4gPiAgCXB0ZV90ICpwdGU7DQo+ID4gPiAgCWlu
dCBpOw0KPiA+ID4gIA0KPiA+ID4gLQlpZiAocHVkX25vbmUoKnB1ZCkpDQo+ID4gPiAtCQlyZXR1
cm4gMTsNCj4gPiA+IC0NCj4gPiANCj4gPiBEbyB3ZSBuZWVkIHRvIHJlbW92ZSB0aGlzIHNhZmUg
Z3VhcmQ/ICBJIGZlZWwgbGlzdCB0aGlzIGlzIHNhbWUgYXMNCj4gPiBrZnJlZSgpIGFjY2VwdGlu
ZyBOVUxMLg0KPiANCj4gSSB0aGluayB0d28gYmlnIGRpZmZlcmVuY2VzIHdpdGgga2ZyZWUoKSBh
cmUgKDEpIHRoYXQgdGhpcyBmdW5jdGlvbiBoYXMNCj4gZXhhY3RseSBvbmUgY2FsbGVyIGluIHRo
ZSB0cmVlIGFuZCAoMikgaXQncyBpbXBsZW1lbnRlZCBwZXItYXJjaC4gVGhlcmVmb3JlDQo+IHdl
J3JlIGluIGEgZ29vZCBwb3NpdGlvbiB0byBnaXZlIGl0IHNvbWUgc2ltcGxlIHNlbWFudGljcyBh
bmQgaW1wbGVtZW50DQo+IHRob3NlLiBPZiBjb3Vyc2UsIGlmIHRoZSB4ODYgcGVvcGxlIHdvdWxk
IGxpa2UgdG8ga2VlcCB0aGUgcmVkdW5kYW50IGNoZWNrLA0KPiB0aGF0J3MgdXAgdG8gdGhlbSwg
YnV0IEkgdGhpbmsgaXQgbWFrZXMgdGhlIGZ1bmN0aW9uIG1vcmUgY29uZnVzaW5nIGFuZA0KPiB0
ZW1wdHMgcGVvcGxlIGludG8gY2FsbGluZyBpdCBmb3IgcHJlc2VudCBlbnRyaWVzLg0KDQpXaXRo
IHBhdGNoIDEvNSBjaGFuZ2UgdG8gaGF2ZSBwWGRfcHJlc2VudCgpIGNoZWNrLCBJIGFncmVlIHRo
YXQgd2UgY2FuDQpyZW1vdmUgdGhpcyBwWGRfbm9uZSgpIGNoZWNrIHRvIGF2b2lkIGFueSBjb25m
dXNpb24uDQoNClJldmlld2VkLWJ5OiBUb3NoaSBLYW5pIDx0b3NoaS5rYW5pQGhwZS5jb20+DQoN
ClRoYW5rcywNCi1Ub3NoaQ0KDQo=
