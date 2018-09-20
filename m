Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2027B21532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yO5EYUo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2027B21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388670AbeIUDYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:24:49 -0400
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:36800
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbeIUDYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ETxErsJeWWib4gWexGIAXuHKHFg2abepIZhl9+lVJo=;
 b=yO5EYUo3nnvyj6UPNgYG9wYAYFzdl5qG/SW+oqn3qKk9WfAYnsdLa2AbZqWVy0KW+ojfu4f+L510o2zLwze0eU9RISyqS9hHG6a4KTnUbsuA9uwjowuSM0V7rBXvS/iqTYrRe2XnORdeNAgaRYKULZW2qus9qPxnkNrqufIARmU=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0302.namprd12.prod.outlook.com (10.162.4.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.19; Thu, 20 Sep 2018 21:38:59 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.019; Thu, 20 Sep 2018
 21:38:59 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/2] Provide options to enable spectre_v2
 userspace-userspace protection
Thread-Topic: [PATCH 0/2] Provide options to enable spectre_v2
 userspace-userspace protection
Thread-Index: AQHUUGV5bSUg7rHX5kCrUgywYzutiqT5s90A
Date:   Thu, 20 Sep 2018 21:38:59 +0000
Message-ID: <3609a852-1477-a5b2-3858-c2cbfb3999a9@amd.com>
References: <cover.1537392876.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1537392876.git.tim.c.chen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:300:16::15) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0302;20:dosbi8r2nui6mlRh7n4mvVwFR9R15FplpxvR6t6S3tRzFOZnbN0azd7RNcS1dvYp/nzaYhwoErSrX0rVmxtYuiqXMNX0jXgo9jECmYEczyfNUlAWWWUZeBGJxI1fnlTsQvgDQYfyyrESjB989nbcvtekOfZoimSrqNRzoVKYmHqYc2AizAYIQ6HesmKtsp6SB6yvj9UcrQ2b2/wt3E7QaA1FQGbGA/SVb+FaEHPhm0HSK3cdl19iOXrpB10Hs8EJ
x-ms-office365-filtering-correlation-id: cf026999-5250-4b57-93a7-08d61f41792b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0302;
x-ms-traffictypediagnostic: SN1PR12MB0302:
x-microsoft-antispam-prvs: <SN1PR12MB03028AD6BC85BCF47DC79721EC130@SN1PR12MB0302.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:SN1PR12MB0302;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0302;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(14454004)(71200400001)(6436002)(6512007)(53546011)(102836004)(6506007)(386003)(72206003)(97736004)(53936002)(71190400001)(26005)(36756003)(66066001)(5250100002)(2900100001)(31686004)(3846002)(6116002)(68736007)(478600001)(81156014)(81166006)(105586002)(8936002)(486006)(256004)(8676002)(14444005)(110136005)(54906003)(229853002)(476003)(7416002)(2616005)(25786009)(86362001)(106356001)(11346002)(305945005)(446003)(76176011)(99286004)(52116002)(4326008)(6246003)(6486002)(316002)(186003)(7736002)(2906002)(31696002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0302;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DucXrEniZa2smqePx1r9rMuravlAkeN+9gFj7dCiJDjR6RQbHfP1VWK92l1xWSPQFTzIe+1KkvqwY0qZAfL8ehnnt8L+1WEcREXaK4lZZ0iI6OwA2ALYfFR88GQMY/D2QqCxTlup/dQFtl1e0C2ESidWAqGCfe3ZwG1COQBqZVB8e5TrvjvJd2wXwBFIMTNa0hjTWX4UxckRa8w4+kCvNtowprEDET3NaJhPamxylsZPyIJ01Y5jKrkqleYcxjk8YSBdlr1bzefJQGdku66EAKiexQ8Ui9/mTsv6M7Koo741s8R4Q8kqxwIM4pHR3VXTB4wZjyT+Bpid6O5QtrLjFeQTlOjSgfNqFEDxTRmxvkA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA6AFDCFFFA4024AAA3FA0C4F2635BD6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf026999-5250-4b57-93a7-08d61f41792b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 21:38:59.7612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMTkvMjAxOCAwNDozNSBQTSwgVGltIENoZW4gd3JvdGU6DQo+IFRoaXMgcGF0Y2hzZXQg
cHJvdmlkZXMgYW4gb3B0aW9uIHRvIGFwcGx5IElCUEIgYW5kIFNUSUJQIG1pdGlnYXRpb24NCj4g
dG8gb25seSBub24tZHVtcGFibGUgcHJvY2Vzc2VzLg0KPiANCj4gSmlyaSdzIHBhdGNoIHRvIGhh
cmRlbiBzcGVjdHJlX3YyIG1ha2VzIElCUEIgYW5kIFNUSUJQIGF2YWlsYWJsZSBmb3INCj4gZ2Vu
ZXJhbCBzcGVjdHJlIHYyIGFwcCB0byBhcHAgbWl0aWdhdGlvbi4gIElCUEIgd2lsbCBiZSBpc3N1
ZWQgZm9yDQo+IHN3aXRjaGluZyB0byBhbiBhcHAgdGhhdCdzIG5vdCBwdHJhY2VhYmxlIGJ5IHRo
ZSBwcmV2aW91cw0KPiBhcHAgYW5kIFNUSUJQIHdpbGwgYmUgYWx3YXlzIHR1cm5lZCBvbi4NCj4g
DQo+IEhvd2V2ZXIsIGxlYXZpbmcgU1RJQlAgb24gYWxsIHRoZSB0aW1lIGlzIGV4cGVuc2l2ZSBm
b3IgY2VydGFpbg0KPiBhcHBsaWNhdGlvbnMgdGhhdCBoYXZlIGZyZXF1ZW50IGluZGlyZWN0IGJy
YW5jaGVzLiBPbmUgc3VjaCBhcHBsaWNhdGlvbg0KPiBpcyBwZXJsYmVuY2ggaW4gdGhlIFNwZWNJ
bnQgUmF0ZSAyMDA2IHRlc3Qgc3VpdGUgd2hpY2ggc2hvd3MgYQ0KPiAyMSUgcmVkdWN0aW9uIGlu
IHRocm91Z2hwdXQuICBPdGhlciBhcHBsaWNhdGlvbiBsaWtlIGJ6aXAyIGluDQo+IHRoZSBzYW1l
IHRlc3Qgc3VpdGUgd2l0aCAgbWluaW1hbCBpbmRpcmN0IGJyYW5jaGVzIGhhdmUNCj4gb25seSBh
IDAuNyUgcmVkdWN0aW9uIGluIHRocm91Z2hwdXQuIElCUEIgd2lsbCBhbHNvIGltcG9zZQ0KPiBv
dmVyaGVhZCBkdXJpbmcgY29udGV4dCBzd2l0Y2hlcy4NCj4gDQo+IEFwcCB0byBhcHAgZXhwbG9p
dCBpcyBpbiBnZW5lcmFsIGRpZmZpY3VsdA0KPiBkdWUgdG8gYWRkcmVzcyBzcGFjZSBsYXlvdXQg
cmFuZG9taXphdGlvbiBpbiBhcHBzIGFuZA0KPiB0aGUgbmVlZCB0byBrbm93IGFuIGFwcCdzIGFk
ZHJlc3Mgc3BhY2UgbGF5b3V0IGFoZWFkIG9mIHRpbWUuDQo+IFVzZXJzIG1heSBub3Qgd2lzaCB0
byBpbmN1ciBhcHAgdG8gYXBwIHBlcmZvcm1hbmNlDQo+IG92ZXJoZWFkIGZyb20gSUJQQiBhbmQg
U1RJQlAgZm9yIGdlbmVyYWwgbm9uIHNlY3VyaXR5IHNlbnNpdGl2ZSBhcHBzDQo+IGFuZCB1c2Ug
dGhlc2UgbWl0aWdhdGlvbnMgb25seSBmb3Igbm9uLWR1bXBhYmxlIGFwcHMuDQo+IA0KPiBUaGUg
Zmlyc3QgcGF0Y2ggcHJvdmlkZXMgYSBsaXRlIG9wdGlvbiBmb3Igc3BlY3RyZV92MiBhcHAgdG8g
YXBwDQo+IG1pdGlnYXRpb24gd2hlcmUgSUJQQiBpcyBvbmx5IGlzc3VlZCBmb3Igc2VjdXJpdHkg
c2Vuc2l0aXZlDQo+IG5vbi1kdW1wYWJsZSBhcHAuICBUaGUgc2Vjb25kIHBhdGNoIGV4dGVuZHMg
dGhpcyBvcHRpb24NCj4gd2hlcmUgU1RJQlAgaXMgb25seSBpc3N1ZWQgZm9yIG5vbi1kdW1wYWJs
ZSBhcHAuDQo+IA0KPiBUaGUgY2hhbmdlcyBhcHBseSB0byBpbnRlbCBjcHVzIGFmZmVjdGVkIGJ5
IHNwZWN0cmVfdjIuIFRvbSwNCj4gY2FuIHlvdSB1cGRhdGUgdGhlIFNUSUJQIGNoYW5nZXMgZm9y
IEFNRCBjcHVzIG9uICANCj4gX19zcGVjdWxhdGl2ZV9zdG9yZV9ieXBhc3NfdXBkYXRlIGFuZCB4
ODZfdmlydF9zcGVjX2N0cmwNCj4gdG8gdXBkYXRlIHRoZSBTUEVDX0NUUkwgbXNyIGZvciBBTUQg
Y3B1Pw0KDQpIaSBUaW0sDQoNCkxldCBtZSB0aGluayBhYm91dCB0aGlzIGEgYml0LCBzaW5jZSBp
dCBjYW4gZ2V0IGEgYml0IHRyaWNreSBpZg0KSSB3YW50IHRvIGF2b2lkIG11bHRpcGxlIE1TUiB3
cml0ZXMgd2hlbiBvbmx5IG9uZSBtYXkgaGF2ZSBiZWVuDQpuZWVkZWQgKGFzc3VtaW5nIFNTQkQg
aXMgbm90IHVzaW5nIHRoZSBTUEVDX0NUUkwgTVNSKS4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+
IFRoYW5rcy4NCj4gDQo+IFRpbQ0KPiANCj4gVGltIENoZW4gKDIpOg0KPiAgIHg4Ni9zcGVjdWxh
dGlvbjogT3B0aW9uIHRvIHNlbGVjdCBhcHAgdG8gYXBwIG1pdGlnYXRpb24gZm9yIHNwZWN0cmVf
djINCj4gICB4ODYvc3BlY3VsYXRpb246IFByb3ZpZGUgYXBwbGljYXRpb24gcHJvcGVydHkgYmFz
ZWQgU1RJQlAgcHJvdGVjdGlvbg0KPiANCj4gIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2Vy
bmVsLXBhcmFtZXRlcnMudHh0IHwgIDExICsrKw0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXNy
LWluZGV4LmggICAgICAgICAgICAgICAgfCAgIDMgKy0NCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNt
L25vc3BlYy1icmFuY2guaCAgICAgICAgICAgIHwgICA5ICsrDQo+ICBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9zcGVjLWN0cmwuaCAgICAgICAgICAgICAgICB8ICAxMiArKysNCj4gIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL3RocmVhZF9pbmZvLmggICAgICAgICAgICAgIHwgICA0ICstDQo+ICBhcmNoL3g4
Ni9rZXJuZWwvY3B1L2J1Z3MuYyAgICAgICAgICAgICAgICAgICAgICB8IDEwNSArKysrKysrKysr
KysrKysrKysrKysrLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMgICAgICAgICAgICAg
ICAgICAgICAgIHwgICA5ICstDQo+ICBhcmNoL3g4Ni9tbS90bGIuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICA0MSArKysrKysrKy0NCj4gIDggZmlsZXMgY2hhbmdlZCwgMTc5IGlu
c2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCg==
