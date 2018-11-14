Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFA7208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ph6dAuTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFA7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbeKNWBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:01:13 -0500
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:44800
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727691AbeKNWBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShvTcVDlZ7WGBJfyamRU45/V2eRhKwQbvD8faaD6Qac=;
 b=ph6dAuTqNTQxe71GCDV6d1DaL9xaU4D9Vb6G0GvY9LjtYU250A/MzrJyQXI1/V3s/bXohOoP7l8W0S5i2x1zjvoQjLl4huTQH0Quv9jwPLadJB/J0kAHa3QJkPkmJxSq3EoytcULh1z00FdnjUhiPBEnAZtF4c66XNhKuuc1V70=
Received: from VI1PR08MB3294.eurprd08.prod.outlook.com (52.134.31.11) by
 VI1PR08MB0399.eurprd08.prod.outlook.com (10.162.12.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Wed, 14 Nov 2018 11:58:09 +0000
Received: from VI1PR08MB3294.eurprd08.prod.outlook.com
 ([fe80::8db0:9eca:8ed:92b1]) by VI1PR08MB3294.eurprd08.prod.outlook.com
 ([fe80::8db0:9eca:8ed:92b1%3]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 11:58:08 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Dave P Martin <Dave.Martin@arm.com>,
        Daniel Colascione <dancol@google.com>
CC:     nd <nd@arm.com>, Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
Thread-Topic: Official Linux system wrapper library?
Thread-Index: AQHUeYuU4J3dLZKEX06mfdiwAKJEwaVKawj+gAA1+ICAASqMJIAAVfkAgAH8cYCAARGOAA==
Date:   Wed, 14 Nov 2018 11:58:08 +0000
Message-ID: <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com>
 <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <20181113193859.GJ3505@e103592.cambridge.arm.com>
In-Reply-To: <20181113193859.GJ3505@e103592.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::35) To VI1PR08MB3294.eurprd08.prod.outlook.com
 (2603:10a6:803:3e::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0399;6:VQYI4u6pD/7nISnxC3pTneKo2yiQNozlkGu2macii6qrVBcq9PMS65WHSesXO7uPyGrl8QmEqgyycZbMEq9IROFwM5yWVONso5iY65Pg4XiNtlw2SLe3/hshx/+zsxkncVKZ7N0tea5LHhStx6c1K/iPX4P53tY2aMpqsGVT+iAKZcd4tUIAe41RDhcGcgRnTdHtsjopZbt+fW4m1d4kIchTOvAmnxUWDhgpFEcvo9wt/pIrzkeILOsC6GB+M5IMGPkQLd4iVuFHokMayywKn28dtgEkA5sqIgQgno1ot0QlHNDAg+l5zVS2ThNU1+jY7I44KRJfROamzJBk9MWetiyOUqloFIu3dOAWZXU4uwAPs6mkU8WoD9eRHbFNgL+HZInRd8rWJ2HwCzHebB0/c8UXHkr9k7bFpO0+thqjcq+jQot8kxPY/DKF0b2G5HvPZxYb6EAs2aQB2oEOZ+W+/Dt6O56tvBuTIQZUWsvy4J0=;5:LybuJi6psnA4PTOgPLxquNgj5MuHH2GrYTjhVRDVaPO2gYBZRPBXd6gkN1T6vAH/cRGBFpRG0XwhLEPvs9bgO/9Zcdc0qBX9fModUK2YOwfzKp/2c2LpX+J4vUT2zJttiBLnzIlESwOPXdSSj/DE+au/ngAiElStNw0gf8Re1iQ=;7:2HyokOaGu8BRQ+60X2GpsCmutPqvUH1x92Y7TdFeXIwCqH9LbEeuDRZN4pTlkPg9B8YBCfkf5mX6tXJzAnn0DOUd3Ys2CzLrgoAxIFzEMDmtPPIJPWYuvxYGLwsRVCpoPMW8QBMMQPZetFueDyk6+Q==
x-ms-office365-filtering-correlation-id: 2873ef45-405b-4e2d-5bae-08d64a28718f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0399;
x-ms-traffictypediagnostic: VI1PR08MB0399:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB0399653A158CA59C0F2D1A77EDC30@VI1PR08MB0399.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231410)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB0399;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0399;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(396003)(346002)(199004)(189003)(561944003)(68736007)(6486002)(71190400001)(71200400001)(26005)(2906002)(8936002)(105586002)(256004)(36756003)(7736002)(31696002)(81166006)(106356001)(31686004)(44832011)(14444005)(8676002)(81156014)(99286004)(3846002)(305945005)(14454004)(229853002)(6116002)(186003)(2900100001)(7416002)(66066001)(5660300001)(65826007)(65956001)(39060400002)(6512007)(486006)(53936002)(54906003)(58126008)(65806001)(97736004)(446003)(478600001)(110136005)(6436002)(2616005)(86362001)(476003)(25786009)(11346002)(64126003)(52116002)(316002)(76176011)(4326008)(386003)(6246003)(93886005)(72206003)(6506007)(102836004)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB0399;H:VI1PR08MB3294.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mPFzT/gNdzrKX6zWggEGX3e3gs6+02vvBjH0JszeNkAlBrzSO1wyJqhxVzvuBE04z4D2mfM7yLeEHM+eX77a0x2mB2xE1SfNEzBrO/H6ZL3cW9QtZq9euMk3LFXi9aKpfP5578k+8/v3RX3/jKEMFOkEICN1k4PlAf4NBet5/P+jA1XovTqjW1IBSoW/8p9BS/KBQDtzALnh9FsF6tQx189u00lzNlKCxS5TY76M7G3ScspSBPJEEzrqTDzpiXoscgeZccJWHBl16rj68NuHWsTUmpOs9x9r0wGI9GEeCawjVj0+ciPUtmhUpsFAuWYL5sM4OHdFIX5zQGOuzxwFYxYpjRWoia8QHFgugu73n6M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F542CCBF9FA874C817CD69279E84127@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2873ef45-405b-4e2d-5bae-08d64a28718f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 11:58:08.8344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMTEvMTggMTk6MzksIERhdmUgTWFydGluIHdyb3RlOg0KPiBPbiBNb24sIE5vdiAxMiwg
MjAxOCBhdCAwNToxOToxNEFNIC0wODAwLCBEYW5pZWwgQ29sYXNjaW9uZSB3cm90ZToNCj4+IFdl
IHNob3VsZCBhZG9wdCBhIHNpbWlsYXIgYXBwcm9hY2guIFNoaXBwaW5nIGEgbG93ZXItbGV2ZWwN
Cj4+ICJsaWJsaW51eC5zbyIgdGlnaHRseSBib3VuZCB0byB0aGUga2VybmVsIHdvdWxkIG5vdCBv
bmx5IGxldCB0aGUNCj4+IGtlcm5lbCBieXBhc3MgZ2xpYmMncyAiZWRpdG9yaWFsIGRpc2NyZXRp
b24iIGluIGV4cG9zaW5nIG5ldw0KPj4gZmFjaWxpdGllcyB0byB1c2Vyc3BhY2UsIGJ1dCB3b3Vs
ZCBhbHNvIGFsbG93IGZvciB0aWdodGVyIHVzZXIta2VybmVsDQo+PiBpbnRlZ3JhdGlvbiB0aGF0
IG9uZSBjYW4gYWNoaWV2ZSB3aXRoIGEgc2ltcGxpc3RpYyBzeXNjYWxsKDIpLXN0eWxlDQo+PiBl
c2NhcGUgaGF0Y2guIChGb3IgZXhhbXBsZSwgZm9yIGEgbG9uZyB0aW1lIG5vdywgSSd2ZSB3YW50
ZWQgdG8gZ28NCj4+IGJleW9uZCBQT1NJWCBhbmQgaW1wcm92ZSB0aGUgc3lzdGVtJ3Mgc2lnbmFs
IGhhbmRsaW5nIEFQSSwgYW5kIHRoaXMNCj4+IGltcHJvdmVtZW50IHJlcXVpcmVzIHVzZXJzcGFj
ZSBjb29wZXJhdGlvbi4pIFRoZSB2ZHNvIGlzIHByb2JhYmx5IHRvbw0KPj4gc21hbGwgYW5kIHNp
bXBsaXN0aWMgdG8gc2VydmUgaW4gdGhpcyByb2xlOyBJJ2Qgd2FudCBhIHJlYWwgbGlicmFyeS4N
Cj4gDQo+IENhbiB5b3UgZXhwYW5kIG9uIHlvdXIgcmVhc29uaW5nIGhlcmU/DQoNCnN1Y2ggbGli
IGNyZWF0ZXMgYSB1c2VsZXNzIGFiaSthcGkgbGF5ZXIgdGhhdA0Kc29tZWJvZHkgaGFzIHRvIG1h
aW50YWluIGFuZCBkb2N1bWVudCAod2l0aCBvcg0Kd2l0aG91dCB2ZHNvKS4NCg0KaXQgb2J2aW91
c2x5IGNhbm5vdCB3b3JrIHRvZ2V0aGVyIHdpdGggYSBwb3NpeA0KY29uZm9ybSBsaWJjIGltcGxl
bWVudGF0aW9uIGZvciB3aGljaCBpdCB3b3VsZA0KcmVxdWlyZSBrbm93bGVkZ2UgYWJvdXQNCg0K
dGhyZWFkIGNhbmNlbGxhdGlvbiBpbnRlcm5hbHMsIHBvdGVudGlhbGx5IFRMUw0KZm9yIGVycm5v
LCBrbm93IGxpYmMgdHlwZXMgZXZlbiBvbmVzIHRoYXQgYXJlDQpiYXNlZCBvbiBjb21waWxlIHRp
bWUgZmVhdHVyZSBtYWNyb3MgKGFuZCBleHBvc2UNCnRoZW0gaW4gaGVhZGVycyBpbiBhIHdheSB0
aGF0IGRvZXMgbm90IGNvbGxpZGUNCndpdGggbGliYyBoZWFkZXJzKSwgYWJpIHZhcmlhbnRzIHRo
ZSBsaWJjIHN1cHBvcnRzDQooZS5nLiBzb2Z0ZnAsIHNlY3VyaXR5IGhhcmRlbmVkIGFiaSksIGxp
YmMNCmludGVybmFsIHNpZ25hbHMgKGZvciBhbnl0aGluZyB0aGF0J3MgY2hhbmdpbmcNCnNpZ25h
bCBtYXNrcyksIHRocmVhZCBpbnRlcm5hbHMgZm9yIHN5c2NhbGxzIHRoYXQNCnJlcXVpcmUgY29v
cmRpbmF0aW9uIGJldHdlZW4gYWxsIHVzZXIgY3JlYXRlZA0KdGhyZWFkcyAoc2V0eGlkKSwgbGli
YyBpbnRlcm5hbCBzdGF0ZSBmb3Igc3lzY2FsbHMNCnRoYXQgY3JlYXRlL2Rlc3Ryb3kgdGhyZWFk
cy4NCg0KYW5kIHRodXMgc3VjaCBsaWIgZG9lcyBub3Qgc29sdmUgdGhlIHByb2JsZW1zDQpvZiB1
c2VycyB3aG8gYWN0dWFsbHkgcmVxdWVzdGVkIHdyYXBwZXJzIGZvcg0KbmV3IHN5c2NhbGxzIChz
aW5jZSB0aGV5IHdhbnQgdG8gY2FsbCBpbnRvIGxpYmMNCmFuZCBjcmVhdGUgdGhyZWFkcykuDQoN
CnRoZXJlIGlzIGEgbG90IG9mIGJpa2VzaGVkaW5nIGhlcmUgYnkgcGVvcGxlIHdobw0KZG9uJ3Qg
dW5kZXJzdGFuZCB0aGUgY29uc3RyYWludHMgbm9yIHRoZSB1c2UtY2FzZXMuDQoNCmFuIGFjdHVh
bCBwcm9wb3NhbCBpbiB0aGUgdGhyZWFkIHRoYXQgaSB0aGluayBpcw0Kd29ydGggY29uc2lkZXJp
bmcgaXMgdG8gbWFrZSB0aGUgbGludXggc3lzY2FsbA0KZGVzaWduIHByb2Nlc3MgaW52b2x2ZSBs
aWJjIGRldnMgc28gdGhlIGMgYXBpIGlzDQpkZXNpZ25lZCB0b2dldGhlciB3aXRoIHRoZSBzeXNj
YWxsIGFiaS4NCg0KdW5mb3J0dW5hdGVseSBpIHN0aWxsIGhhdmVuJ3Qgc2VlbiBhIHNvbHV0aW9u
IHRoYXQNCm1ha2VzIHVzaW5nIGxpbnV4IHVhcGkgaGVhZGVycyB0b2dldGhlciB3aXRoIGxpYmMN
CmhlYWRlcnMgcmVsaWFibGUsIGNvbnRpbnVvdXNseSB0ZXN0aW5nIHRoZW0gaW4NCmlzb2xhdGlv
biBpcyB1c2VmdWwsIGJ1dCB0aGF0IGRvZXMgbm90IHNvbHZlIHRoZQ0KcG90ZW50aWFsIGNvbmZs
aWN0cyB3aXRoIGxpYmMgZGVmaW5pdGlvbnMuDQo=
