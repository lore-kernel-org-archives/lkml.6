Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F4C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D454A208A1
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D454A208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932924AbeGHLNZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:13:25 -0400
Received: from mail-oln040092067098.outbound.protection.outlook.com ([40.92.67.98]:55332
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932821AbeGHLNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:13:24 -0400
Received: from VE1EUR02FT058.eop-EUR02.prod.protection.outlook.com
 (10.152.12.59) by VE1EUR02HT116.eop-EUR02.prod.protection.outlook.com
 (10.152.13.226) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.906.15; Sun, 8
 Jul 2018 11:13:21 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com (10.152.12.60) by
 VE1EUR02FT058.mail.protection.outlook.com (10.152.13.52) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.930.16 via Frontend Transport; Sun, 8 Jul 2018 11:13:21 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243]) by AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243%7]) with mapi id 15.20.0952.013; Sun, 8 Jul 2018
 11:13:21 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the oldconfig target rule
Thread-Topic: [PATCH] Fix the oldconfig target rule
Thread-Index: AQHUFoVN4VKe8QEqTUu43IsWDRn/EqSE+MyAgAAqoQCAAAjgAA==
Date:   Sun, 8 Jul 2018 11:13:21 +0000
Message-ID: <AM5PR0701MB26575A5A1FBEDFC9127110BAE4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2657B3C36CDB2D67702077D8E4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <AM5PR0701MB265789020943AD2E03E81AD2E4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <CAK7LNAT1bqDKo2zS3kUVKnPYgziibuwCdQ4+Y5hQE_xbjcGAWw@mail.gmail.com>
In-Reply-To: <CAK7LNAT1bqDKo2zS3kUVKnPYgziibuwCdQ4+Y5hQE_xbjcGAWw@mail.gmail.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0153.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::21) To AM5PR0701MB2657.eurprd07.prod.outlook.com
 (2603:10a6:203:75::7)
x-incomingtopheadermarker: OriginalChecksum:0B8F68C2614E18686C8693B77EBFE05E61FBCEE93EC2262B895EA38F87E515B9;UpperCasedChecksum:4028B4D9998EA34B51F922B88EB8CCC4A528FE8022909F715653BEF9C950A4D6;SizeAsReceived:7802;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [KiiwDr1YJQV1fjbd6bFekj+IqRHVvWp7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR02HT116;7:OW4SKextmFHsLWsJEScpIfvhWBltcaO8yxia9G7jmNADIDwvec7QEkRwWAjz6pKnQBiWeAwzgodOTjsmrJfgkYPyGsbiO6DCtzU1ElQY8H33XuzzW3Wd9dzqnfF7/uXq7Dmj+wKBaAilQ/C6xHSwsfgqVG3BLZONe9FWvVn9iaVrnClA6Hbw6hILu52ynPt5dVtFildlanTs5Hfowiinb7Ef4b+raE7tsHPKPF2TiPIIA9x/2PuwLUQCmur17H+v
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101448)(1701031045);SRVR:VE1EUR02HT116;
x-ms-traffictypediagnostic: VE1EUR02HT116:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(82015058);SRVR:VE1EUR02HT116;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR02HT116;
x-forefront-prvs: 0727122FC6
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(199004)(189003)(54534003)(4326008)(104016004)(75402003)(73972006)(26005)(6506007)(44832011)(53546011)(76176011)(106356001)(102836004)(386003)(105586002)(9686003)(82202002)(966005)(256004)(6246003)(25786009)(14454004)(97736004)(5250100002)(86362001)(14444005)(74482002)(229853002)(81156014)(54906003)(33656002)(55016002)(74316002)(2900100001)(5660300001)(11346002)(6436002)(68736007)(8936002)(305945005)(99286004)(446003)(6346003)(6306002)(6916009)(486006)(7696005)(8676002)(476003);DIR:OUT;SFP:1901;SCL:1;SRVR:VE1EUR02HT116;H:AM5PR0701MB2657.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:;
received-spf: None (protection.outlook.com: hotmail.de does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bernd.edlinger@hotmail.de; 
x-microsoft-antispam-message-info: nzzJqsvxHKhcmBsX7TotL2ni2kAefa1H1cAcuav6MMZ8ar3caPrkYwev8CUxnJ33KLX6RRtvrSEGx5+L/5B40hDBIIaoSlynKef1eYztwPyMaOYQbJMe5C5FUmFQ7j+O5xr+XfnvWCGxDorFzdNy+XN5WAwiyTnJs2PLkR44s+Z96a0zJCVdKNDfZIP6D8IxKFFPhpTqLtnJMX4eJJ7Sts+H01OFQMv4mvQn8gbHq2M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00E67358DFEC8C4BB43244F9C2DBEDD1@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaa12f5-1d60-4ffe-6d82-08d5e4c3d0a9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2018 11:13:21.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDgvMTggMTI6NDEsIE1hc2FoaXJvIFlhbWFkYSB3cm90ZToNCj4gMjAxOC0wNy0wOCAx
NzowOSBHTVQrMDk6MDAgQmVybmQgRWRsaW5nZXIgPGJlcm5kLmVkbGluZ2VyQGhvdG1haWwuZGU+
Og0KPj4gT24gMDcvMDgvMTggMDg6MzEsIEJlcm5kIEVkbGluZ2VyIHdyb3RlOg0KPj4+IFRoZSBu
ZXh0IG1ha2UgYWZ0ZXIgYW4gb2xkY29uZmlnIHJlYWRzIGluIHRoZSBvdXRkYXRlZA0KPj4+IGlu
Y2x1ZGUvY29uZmlnL2F1dG8uY29uZiB3aGljaCBjYW4ga2lsbCB0aGUgbWFrZSBiZWZvcmUNCj4+
PiBpdCBpcyBhYmxlIHRvIGNhbGwgdGhlIHN5bmNjb25maWcgdGFyZ2V0Lg0KPj4+DQo+Pj4gJCBt
YWtlIGRlZmNvbmZpZw0KPj4+ICoqKiBEZWZhdWx0IGNvbmZpZ3VyYXRpb24gaXMgYmFzZWQgb24g
J3g4Nl82NF9kZWZjb25maWcnDQo+Pj4gJCBtYWtlDQo+Pj4gc2NyaXB0cy9rY29uZmlnL2NvbmYg
IC0tc3luY2NvbmZpZyBLY29uZmlnDQo+Pj4gTWFrZWZpbGU6OTM2OiAqKiogIkNhbm5vdCBnZW5l
cmF0ZSBPUkMgbWV0YWRhdGEgZm9yIENPTkZJR19VTldJTkRFUl9PUkM9eSwNCj4+PiBwbGVhc2Ug
aW5zdGFsbCBsaWJlbGYtZGV2LCBsaWJlbGYtZGV2ZWwgb3IgZWxmdXRpbHMtbGliZWxmLWRldmVs
Ii4gIFN0b3AuDQo+Pj4NCj4+PiAkIHNlZCAtaSBzL0NPTkZJR19VTldJTkRFUl9PUkM9eS8vIC5j
b25maWdzDQo+Pj4gJCBtYWtlIG9sZGNvbmZpZw0KPj4+IENob29zZSBrZXJuZWwgdW53aW5kZXIN
Cj4+Pj4gMS4gT1JDIHVud2luZGVyIChVTldJTkRFUl9PUkMpIChORVcpDQo+Pj4gICAgIDIuIEZy
YW1lIHBvaW50ZXIgdW53aW5kZXIgKFVOV0lOREVSX0ZSQU1FX1BPSU5URVIpDQo+Pj4gY2hvaWNl
WzEtMj9dOiAyDQo+Pj4gJCBtYWtlDQo+Pj4gTWFrZWZpbGU6OTM2OiAqKiogIkNhbm5vdCBnZW5l
cmF0ZSBPUkMgbWV0YWRhdGEgZm9yIENPTkZJR19VTldJTkRFUl9PUkM9eSwNCj4+PiBwbGVhc2Ug
aW5zdGFsbCBsaWJlbGYtZGV2LCBsaWJlbGYtZGV2ZWwgb3IgZWxmdXRpbHMtbGliZWxmLWRldmVs
Ii4gIFN0b3AuDQo+Pj4NCj4+PiBXaXRoIHRoaXMgcGF0Y2ggb2xkY29uZmlnIGFuZCBzaW1pbGFy
IHRhcmdldHMgbGlrZQ0KPj4+IG1lbnVjb25maWcgY2FsbCBzeW5jY29uZmlnIHRvIGF2b2lkIHRo
aXMgZmFpbHVyZS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEJlcm5kIEVkbGluZ2VyIDxiZXJu
ZC5lZGxpbmdlckBob3RtYWlsLmRlPg0KPj4+IC0tLQ0KPj4+ICAgIHNjcmlwdHMva2NvbmZpZy9N
YWtlZmlsZSB8IDEgKw0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL3NjcmlwdHMva2NvbmZpZy9NYWtlZmlsZSBiL3NjcmlwdHMva2Nv
bmZpZy9NYWtlZmlsZQ0KPj4+IGluZGV4IGEzYWMyYzkuLmVmMzQyNzUgMTAwNjQ0DQo+Pj4gLS0t
IGEvc2NyaXB0cy9rY29uZmlnL01ha2VmaWxlDQo+Pj4gKysrIGIvc2NyaXB0cy9rY29uZmlnL01h
a2VmaWxlDQo+Pj4gQEAgLTYyLDYgKzYyLDcgQEAgUEhPTlkgKz0gJChzaW1wbGUtdGFyZ2V0cykN
Cj4+Pg0KPj4+ICAgICQoc2ltcGxlLXRhcmdldHMpOiAkKG9iaikvY29uZg0KPj4+ICAgICAgICAk
PCAkKHNpbGVudCkgLS0kQCAkKEtjb25maWcpDQo+Pj4gKyAgICAkKFEpJChNQUtFKSAtZiAkKHNy
Y3RyZWUpL01ha2VmaWxlIHN5bmNjb25maWcNCj4+DQo+PiBPbiBzZWNvbmQgdGhvdWdodCwgcmVt
b3ZpbmcgdGhlIGF1dG8uY29uZiBtaWdodCBiZSBzdWZmaWNpZW50Og0KPj4gJChRKXJtIC1mIGlu
Y2x1ZGUvY29uZmlnL2F1dG8uY29uZiBpbmNsdWRlL2NvbmZpZy9hdXRvLmNvbmYuY21kDQo+Pg0K
Pj4gV291bGQgeW91IHByZWZlciB0aGF0Pw0KPiANCj4gTm8uDQo+IA0KPiBNeSBzdWdnZXN0aW9u
IGlzIHRoaXM6DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA1MTMwNjUv
DQo+IA0KPiANCg0KT2ssIHRoYW5rcyBhIGxvdC4NCg0KSSB0cmllZCB5b3VyIHBhdGNoIGFuZCBp
dCBzZWVtcyByZWFzb25hYmxlIG1lLg0KKG5pdDogSW4gdGhlIGNoYW5nZSBsb2cgZW50cnkgcy9S
RVRQT1JJTkUvUkVUUE9MSU5FLykNCg0KSG93ZXZlciB0aGUgd2FybmluZyBpcyBnb25lIGFzIHdl
bGwsIHdoaWNoIHdhcyBwcm9iYWJseSBkb25lDQpvbiBwdXJwb3NlIHRvIHB1c2ggcGVvcGxlIHRv
IGluc3RhbGwgdGhlIGVsZiBsaWJyYXJ5Lg0KDQpJIHdvbmRlciBpbiBnZW5lcmFsIGlmIHRoZSB0
ZXN0IHVzaW5nIEhPU1RDQyBtaXNzZXMNCnNvbWVob3cgdGhlIHBvc3NpYmlsaXR5IHRoYXQgdGhl
cmUgbWF5IGJlIGEgQ1JPU1NfQ09NUExJTEUgPw0KDQoNCkJlcm5kLg0K
