Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A955C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1338921736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="b+xqbem8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfA1Iel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:34:41 -0500
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:30976
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726648AbfA1Iel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDKH4wClZPkKCLfB5zVvdTkOgLfmrW19cJKspkCPhJY=;
 b=b+xqbem8I1+1/vcfIMPuufQ7VSVt3+kKaywdQNN2fOLu7oY2vBOfCHcBKMsUHqrxPwNYTT7wvR+5q8LcPwlc36WI7O4NB9gnBu+m5eNZbAoaLF3yo5FiR6WgkEMNCKV4CTHdj9O5FWmhZUfMcRBiNxT6AG6C6dAv2bDNN1HGY+o=
Received: from VI1PR0702MB3710.eurprd07.prod.outlook.com (52.134.3.144) by
 VI1PR0702MB3837.eurprd07.prod.outlook.com (52.134.1.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.13; Mon, 28 Jan 2019 08:34:35 +0000
Received: from VI1PR0702MB3710.eurprd07.prod.outlook.com
 ([fe80::95ff:2ede:57df:f1ba]) by VI1PR0702MB3710.eurprd07.prod.outlook.com
 ([fe80::95ff:2ede:57df:f1ba%2]) with mapi id 15.20.1580.014; Mon, 28 Jan 2019
 08:34:35 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     Paul Moore <pmoore@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Richard Guy Briggs <rbriggs@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: always enable syscall auditing when supported and
 audit is enabled
Thread-Topic: [PATCH] audit: always enable syscall auditing when supported and
 audit is enabled
Thread-Index: AQHUtuRMqf59sA9YxEyiYKAWmGDXiA==
Date:   Mon, 28 Jan 2019 08:34:35 +0000
Message-ID: <5490ae28-251b-bfda-38a6-5be201a4a8d8@nokia.com>
References: <20151208164237.15736.42955.stgit@localhost>
In-Reply-To: <20151208164237.15736.42955.stgit@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.165]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-clientproxiedby: HE1PR09CA0051.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::19) To VI1PR0702MB3710.eurprd07.prod.outlook.com
 (2603:10a6:803:7::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0702MB3837;6:hLxcFj+eo6Z8V20Q4H9UKecxVnp+urQCGi082iYMIPb3VT8FkBsmGeejeA0HL+dQXcv2Q4NW+dS9yN6H6If+5funhAUhL6jwLGcpbRbym0mYsURkZonO5sYa19yX1znd5Ndx+qxcr7YJAfHpFRqmm+XfQdH1ZK7HTqOBU62BKnSlU8ZUxGvTs2uNkly/JTCovWQx0nL4Njm8kHoEGh/hb449r/76ZfFNR4ryZUTzm3lde9lG/ofXGKURjHeCSGL4hgmmqKhDQsf/+uOPn4jW8gRwrGoRHi20HyVU1hQFi4/i3D1bLHNwrrJdySdYr7odayzrf8dBESHRXTD6BJ3rHeBGFAf300E5ud5823MlJoZDuMYbhx+GMUBWodVdTyMXBVTp5uoFXgkC3yBwK9/3ofbb79MjGBsYY3ekED2+FYNzdkhyibY2u8Uj4FOsX4Sk+FVCD9oNakHVnE1PrEf4bQ==;5:/VQnda7YWWPl2VKXaS3P8mOcl0Zygc3dKEWx2uNlF5BY+M4Kk8xpfrANIxi0CdTGBP3FgLVgp75lO/CSB1YADFGCD40VXi+q6S2iZiVl9dEUGh4G41HQq0OWOqlsQfjdO/kWZh9Pt89xlup/mytF93cyj3vZoqzYGUsIJs0SlcDkhmETfS/z0Kg0Adn5GI8oEn/+kyzhd1bamFXAc59djg==;7:Pda5td9Wj4XZEiQkk/+2emMT9nx54G5xjQJwOZKrDR1OkcT63TEJgX1Wb4dPVZ4mev5xlBb/wC4WwbT6dR1QhTGR5/cdGl68maf3JE6ly8tXc8QR6xr2OGeJb7YvQzdxzpwRHfE9rBVW/7wuKYbAZw==
x-ms-office365-filtering-correlation-id: 5ab9ce1d-13c6-4f77-f2a7-08d684fb6ed8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:VI1PR0702MB3837;
x-ms-traffictypediagnostic: VI1PR0702MB3837:
x-microsoft-antispam-prvs: <VI1PR0702MB38372A4C56E266CCE12F8AC788960@VI1PR0702MB3837.eurprd07.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(65826007)(31686004)(14454004)(7736002)(68736007)(305945005)(6512007)(2906002)(6246003)(6306002)(2501003)(99286004)(478600001)(476003)(966005)(11346002)(102836004)(2616005)(486006)(52116002)(76176011)(4326008)(6506007)(53546011)(386003)(26005)(54906003)(110136005)(186003)(25786009)(446003)(6436002)(64126003)(81156014)(3846002)(65806001)(36756003)(6486002)(97736004)(58126008)(8936002)(86362001)(6116002)(31696002)(14444005)(256004)(106356001)(229853002)(316002)(105586002)(8676002)(81166006)(65956001)(53936002)(66066001)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0702MB3837;H:VI1PR0702MB3710.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uZVrMiZXKGeHZHdRZzq1eMXd972JL7j9oUmRTgO9uuzfRZw73/a0GUXt3e7AEvwnP/22qgg7vmlyuJUjtxMdJslKigMswlt9H2mxJh6Mz2qTpfq7Ez70TJROCBPiQfcF43SGDuMRw99ADfmSXhdsk5MK+oab7uDHdKz5pI9gZWOWdKvHxAltA/cpi+POuBsIveKWYNEUhqDnhNbv4kK0IOo1rpAN4lhnpHybwjxHol/P18lCs9wsq2CdY3cGmScFXdJqwSnB1xwVymsRrJXndh/tGrUUBB6FKROW2PzsD8RkEhEfpqQ0se+Uui1N2rboyLOt/IFYwUAErZBfvwu+g8G/AdCln/B3UlKgodMeUM0UBSfykkhnLOMSWb4p26hqtcEh9Z27/w0CFJTJ5RpNCt/pecUD89aR4Of+dmEDrIs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C3F08B100571341AC2A33EAD0D3C167@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab9ce1d-13c6-4f77-f2a7-08d684fb6ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 08:34:34.3217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0702MB3837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUGF1bCwNCg0KT24gMDgvMTIvMjAxNSAxNzo0MiwgUGF1bCBNb29yZSB3cm90ZToNCj4g
VG8gdGhlIGJlc3Qgb2Ygb3VyIGtub3dsZWRnZSwgZXZlcnlvbmUgd2hvIGVuYWJsZXMgYXVkaXQg
YXQgY29tcGlsZQ0KPiB0aW1lIGFsc28gZW5hYmxlcyBzeXNjYWxsIGF1ZGl0aW5nOyB0aGlzIHBh
dGNoIHNpbXBsaWZpZXMgdGhlIEtjb25maWcNCj4gbWVudXMgYnkgcmVtb3ZpbmcgdGhlIG9wdGlv
biB0byBkaXNhYmxlIHN5c2NhbGwgYXVkaXRpbmcgd2hlbiBhdWRpdA0KPiBpcyBzZWxlY3RlZCBh
bmQgdGhlIHRhcmdldCBhcmNoIHN1cHBvcnRzIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGF1
bCBNb29yZSA8cG1vb3JlQHJlZGhhdC5jb20+DQoNCnRoaXMgcGF0Y2ggaXMgcmVzcG9uc2libGUg
Zm9yIG1hc3NpdmUgcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gZm9yIHRob3NlDQp3aG8gdXNlZCBv
bmx5IENPTkZJR19TRUNVUklUWV9BUFBBUk1PUi4NCg0KQW5kIHRoZSBudW1iZXJzIGFyZSwgdGFr
ZSB0aGUgZm9sbG93aW5nIHRlc3QgZm9yIGluc3RhbmNlOg0KDQpkZCBpZj0vZGV2L3plcm8gb2Y9
L2Rldi9udWxsIGNvdW50PTJNDQogICAgDQpBUk02NDogICAgICA1MDBNQi9zIC0+IDM1ME1CL3MN
CkFSTTogICAgICAgIDQwME1CL3MgLT4gMzAwTUIvcw0KDQood2l0aCBzb21lIHBhcnRpY3VsYXIg
Q1BVIGZyZXF1ZW5jaWVzKS4NCg0KU2hvdWxkIHdlIHJldmVydCB0aGlzIHBhdGNoPw0KDQo+IC0t
LQ0KPiAgaW5pdC9LY29uZmlnIHwgICAxMSArKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IA0KPiAtLQ0KPiBMaW51eC1h
dWRpdCBtYWlsaW5nIGxpc3QNCj4gTGludXgtYXVkaXRAcmVkaGF0LmNvbQ0KPiBodHRwczovL3d3
dy5yZWRoYXQuY29tL21haWxtYW4vbGlzdGluZm8vbGludXgtYXVkaXQNCj4gDQo+IGRpZmYgLS1n
aXQgYS9pbml0L0tjb25maWcgYi9pbml0L0tjb25maWcNCj4gaW5kZXggYzI0YjZmNy4uZDQ2NjNi
MSAxMDA2NDQNCj4gLS0tIGEvaW5pdC9LY29uZmlnDQo+ICsrKyBiL2luaXQvS2NvbmZpZw0KPiBA
QCAtMjk5LDIwICsyOTksMTUgQEAgY29uZmlnIEFVRElUDQo+ICAJaGVscA0KPiAgCSAgRW5hYmxl
IGF1ZGl0aW5nIGluZnJhc3RydWN0dXJlIHRoYXQgY2FuIGJlIHVzZWQgd2l0aCBhbm90aGVyDQo+
ICAJICBrZXJuZWwgc3Vic3lzdGVtLCBzdWNoIGFzIFNFTGludXggKHdoaWNoIHJlcXVpcmVzIHRo
aXMgZm9yDQo+IC0JICBsb2dnaW5nIG9mIGF2YyBtZXNzYWdlcyBvdXRwdXQpLiAgRG9lcyBub3Qg
ZG8gc3lzdGVtLWNhbGwNCj4gLQkgIGF1ZGl0aW5nIHdpdGhvdXQgQ09ORklHX0FVRElUU1lTQ0FM
TC4NCj4gKwkgIGxvZ2dpbmcgb2YgYXZjIG1lc3NhZ2VzIG91dHB1dCkuICBTeXN0ZW0gY2FsbCBh
dWRpdGluZyBpcyBpbmNsdWRlZA0KPiArCSAgb24gYXJjaGl0ZWN0dXJlcyB3aGljaCBzdXBwb3J0
IGl0Lg0KPiAgDQo+ICBjb25maWcgSEFWRV9BUkNIX0FVRElUU1lTQ0FMTA0KPiAgCWJvb2wNCj4g
IA0KPiAgY29uZmlnIEFVRElUU1lTQ0FMTA0KPiAtCWJvb2wgIkVuYWJsZSBzeXN0ZW0tY2FsbCBh
dWRpdGluZyBzdXBwb3J0Ig0KPiArCWRlZl9ib29sIHkNCj4gIAlkZXBlbmRzIG9uIEFVRElUICYm
IEhBVkVfQVJDSF9BVURJVFNZU0NBTEwNCj4gLQlkZWZhdWx0IHkgaWYgU0VDVVJJVFlfU0VMSU5V
WA0KPiAtCWhlbHANCj4gLQkgIEVuYWJsZSBsb3ctb3ZlcmhlYWQgc3lzdGVtLWNhbGwgYXVkaXRp
bmcgaW5mcmFzdHJ1Y3R1cmUgdGhhdA0KPiAtCSAgY2FuIGJlIHVzZWQgaW5kZXBlbmRlbnRseSBv
ciB3aXRoIGFub3RoZXIga2VybmVsIHN1YnN5c3RlbSwNCj4gLQkgIHN1Y2ggYXMgU0VMaW51eC4N
Cj4gIA0KPiAgY29uZmlnIEFVRElUX1dBVENIDQo+ICAJZGVmX2Jvb2wgeQ0KPiANCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpBbGV4YW5kZXIgU3ZlcmRsaW4uDQo=
