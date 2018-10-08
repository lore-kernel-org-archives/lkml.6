Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031BEC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1562075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NKzfCdHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1562075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJHVqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:46:04 -0400
Received: from mail-eopbgr700069.outbound.protection.outlook.com ([40.107.70.69]:10688
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbeJHVqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KSx7+sb+9hOTWVET/ZKGahg+4S97XhdEc2Pg3DCeiA=;
 b=NKzfCdHx27+aW9tWGaIkBUptR31V7qK0kgpH4UOuyFnB8oMiJ2ZRLz+MrpT/YduvGnbVwytsr+a3RbOYS9aSRzp44P3TAQmVgctk3HTT11F4q8ffvmkVrCHma0DGH3ZDppx/QUdOtvE8ZpA4yqS0aYrFJDLVsK/1OInlHaHz890=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.146) by
 BN6PR12MB1220.namprd12.prod.outlook.com (10.168.227.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 8 Oct 2018 14:33:58 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee%5]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 14:33:56 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Zhu, Rex" <Rex.Zhu@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: RE: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
Thread-Topic: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
Thread-Index: AQHUVARg2MOAZvRixUSipQEGskb4iKUVfsWA
Date:   Mon, 8 Oct 2018 14:33:56 +0000
Message-ID: <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113125.488862921@linuxfoundation.org>
In-Reply-To: <20180924113125.488862921@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.49.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1220;20:+WDC+iGrzIuUoy3FdpjPDzvesoNABWhqJA5nf75kD7GyObHIYN9pBu1XtXgamrr/QOyl0RYmSPePHIZZngCX6d0CGY38gLnPDhYrLvkwbFcuNyB5aPGdoX0QshTwmWwt3N/x+RX/iSykrI3pAajXTzyERhom/cwhDXBFReLBgS9CMO7Lc3ZRNlQI9B6lXIkjLiulzLVej9LCjK14O8dw8roIc2xQafQyYh1F4XyLhxdbntj3R6Aj0rveAIHUCu+l
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(13464003)(189003)(199004)(6116002)(3846002)(54906003)(110136005)(6506007)(256004)(76176011)(71190400001)(2900100001)(476003)(305945005)(7696005)(478600001)(72206003)(446003)(486006)(229853002)(53546011)(26005)(6436002)(102836004)(14454004)(86362001)(11346002)(186003)(966005)(71200400001)(66066001)(9686003)(7736002)(99286004)(33656002)(5660300001)(74316002)(6306002)(81156014)(2501003)(106356001)(8676002)(5250100002)(6246003)(53936002)(68736007)(97736004)(8936002)(105586002)(4326008)(55016002)(316002)(25786009)(2906002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1220;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 76e4539c-57a8-4a35-819a-08d62d2b13f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1220;
x-ms-traffictypediagnostic: BN6PR12MB1220:
x-microsoft-antispam-prvs: <BN6PR12MB1220E864B545B77BCC260BDAF7E60@BN6PR12MB1220.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:BN6PR12MB1220;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1220;
x-forefront-prvs: 081904387B
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: etwMPfMXhE9dnoC+lrRZ/OwRdSbh7Kyh6+lF4XnVDajz+4NOOnFn5659NE3W0arzrEfNonMGGouUOX4tpJCs2KYGfvYR5p5qJRemiJWuMDAsOzZsQn/isBabjbu5pESWsvRm7bJI9ITFbuDK0rwhxzJCeOy74TYnljyXgBvtEfVtoG1mpl4T9D8NiBeU31dyhBYQhvy9IZpk2bk7nCO8zuxqTQzUTU3Ak0upfqak17o9DpLGyIvrJZ3mlQmF+FcBzao5zSwjuvQubo09mwIoeyIOLRHSl2ic/mF/quBF0S2rzB2xYNH6gAOIddc58gdCQ8k8MfX84rpqvZ6TTfQPrLdtLwdZUCxgeE/844waHco=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e4539c-57a8-4a35-819a-08d62d2b13f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 14:33:56.0800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAy
NCwgMjAxOCA3OjUzIEFNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gc3Rh
YmxlQHZnZXIua2VybmVsLm9yZzsgV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQu
Y29tPjsNCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
Wmh1LCBSZXgNCj4gPFJleC5aaHVAYW1kLmNvbT47IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2
aW5AbWljcm9zb2Z0LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDQuMTggMjIyLzIzNV0gZHJtL2Ft
ZC9wcDogU2VuZCBraHogY2xvY2sgdmFsdWVzIHRvIERDIGZvcg0KPiBzbXU3LzgNCj4gDQo+IDQu
MTgtc3RhYmxlIHJldmlldyBwYXRjaC4gIElmIGFueW9uZSBoYXMgYW55IG9iamVjdGlvbnMsIHBs
ZWFzZSBsZXQgbWUga25vdy4NCj4gDQoNClRoaXMgcmVncmVzc2VzIHBvd2VyIHVzYWdlIG9uIDQu
MTguICBQbGVhc2UgcmV2ZXJ0Lg0KaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVn
LmNnaT9pZD0yMDEyNzUNCg0KVGhhbmtzLA0KDQpBbGV4DQoNCj4gLS0tLS0tLS0tLS0tLS0tLS0t
DQo+IA0KPiBGcm9tOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCj4g
DQo+IFsgVXBzdHJlYW0gY29tbWl0IGMzY2I0MjRhMDg2OTIxZjZiYjA0NDliMTBkOTk4MzUyYTc1
NmQ2ZDUgXQ0KPiANCj4gVGhlIHByZXZpb3VzIGNoYW5nZSB3YXNuJ3QgY292ZXJpbmcgc211IDcg
YW5kIDggYW5kIHRoZXJlZm9yZSBEQyB3YXMNCj4gc2VlaW5nIHdyb25nIGNsb2NrIHZhbHVlcy4N
Cj4gDQo+IFRoaXMgZml4ZXMgYW4gaXNzdWUgd2hlcmUgdGhlIHBpcGVzIHNlZW0gdG8gaGFuZyB3
aXRoIGEgNGsgRFAgYW5kIDEwODBwDQo+IEhETUkgZGlzcGxheS4NCj4gDQo+IEZpeGVzOiBjM2Rm
NTBhYmM4NGIgKCJkcm0vYW1kL3BwOiBDb252ZXJ0IGNsb2NrIHVuaXQgdG8gS0h6IGFzIGRlZmlu
ZWQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1k
LmNvbT4NCj4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4NCj4gQ2M6cmV4LnpodUBhbWQuY29tDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4g
PGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBHcmVnIEty
b2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYyB8ICAgIDggKysrKy0t
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3IuYyB8
ICAgIDYgKysrLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkNCj4gDQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdy
L3NtdTdfaHdtZ3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21n
ci9zbXU3X2h3bWdyLmMNCj4gQEAgLTQ1NTUsMTIgKzQ1NTUsMTIgQEAgc3RhdGljIGludCBzbXU3
X2dldF9zY2xrcyhzdHJ1Y3QgcHBfaHdtZw0KPiAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICAJCWRl
cF9zY2xrX3RhYmxlID0gdGFibGVfaW5mby0+dmRkX2RlcF9vbl9zY2xrOw0KPiAgCQlmb3IgKGkg
PSAwOyBpIDwgZGVwX3NjbGtfdGFibGUtPmNvdW50OyBpKyspDQo+IC0JCQljbG9ja3MtPmNsb2Nr
W2ldID0gZGVwX3NjbGtfdGFibGUtPmVudHJpZXNbaV0uY2xrOw0KPiArCQkJY2xvY2tzLT5jbG9j
a1tpXSA9IGRlcF9zY2xrX3RhYmxlLT5lbnRyaWVzW2ldLmNsayAqIDEwOw0KPiAgCQljbG9ja3Mt
PmNvdW50ID0gZGVwX3NjbGtfdGFibGUtPmNvdW50Ow0KPiAgCX0gZWxzZSBpZiAoaHdtZ3ItPnBw
X3RhYmxlX3ZlcnNpb24gPT0gUFBfVEFCTEVfVjApIHsNCj4gIAkJc2Nsa190YWJsZSA9IGh3bWdy
LT5keW5fc3RhdGUudmRkY19kZXBlbmRlbmN5X29uX3NjbGs7DQo+ICAJCWZvciAoaSA9IDA7IGkg
PCBzY2xrX3RhYmxlLT5jb3VudDsgaSsrKQ0KPiAtCQkJY2xvY2tzLT5jbG9ja1tpXSA9IHNjbGtf
dGFibGUtPmVudHJpZXNbaV0uY2xrOw0KPiArCQkJY2xvY2tzLT5jbG9ja1tpXSA9IHNjbGtfdGFi
bGUtPmVudHJpZXNbaV0uY2xrICogMTA7DQo+ICAJCWNsb2Nrcy0+Y291bnQgPSBzY2xrX3RhYmxl
LT5jb3VudDsNCj4gIAl9DQo+IA0KPiBAQCAtNDU5Miw3ICs0NTkyLDcgQEAgc3RhdGljIGludCBz
bXU3X2dldF9tY2xrcyhzdHJ1Y3QgcHBfaHdtZw0KPiAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICAJ
CWRlcF9tY2xrX3RhYmxlID0gdGFibGVfaW5mby0+dmRkX2RlcF9vbl9tY2xrOw0KPiAgCQlmb3Ig
KGkgPSAwOyBpIDwgZGVwX21jbGtfdGFibGUtPmNvdW50OyBpKyspIHsNCj4gLQkJCWNsb2Nrcy0+
Y2xvY2tbaV0gPSBkZXBfbWNsa190YWJsZS0+ZW50cmllc1tpXS5jbGs7DQo+ICsJCQljbG9ja3Mt
PmNsb2NrW2ldID0gZGVwX21jbGtfdGFibGUtPmVudHJpZXNbaV0uY2xrICogMTA7DQo+ICAJCQlj
bG9ja3MtPmxhdGVuY3lbaV0gPSBzbXU3X2dldF9tZW1fbGF0ZW5jeShod21nciwNCj4gIAkJCQkJ
CWRlcF9tY2xrX3RhYmxlLQ0KPiA+ZW50cmllc1tpXS5jbGspOw0KPiAgCQl9DQo+IEBAIC00NjAw
LDcgKzQ2MDAsNyBAQCBzdGF0aWMgaW50IHNtdTdfZ2V0X21jbGtzKHN0cnVjdCBwcF9od21nDQo+
ICAJfSBlbHNlIGlmIChod21nci0+cHBfdGFibGVfdmVyc2lvbiA9PSBQUF9UQUJMRV9WMCkgew0K
PiAgCQltY2xrX3RhYmxlID0gaHdtZ3ItDQo+ID5keW5fc3RhdGUudmRkY19kZXBlbmRlbmN5X29u
X21jbGs7DQo+ICAJCWZvciAoaSA9IDA7IGkgPCBtY2xrX3RhYmxlLT5jb3VudDsgaSsrKQ0KPiAt
CQkJY2xvY2tzLT5jbG9ja1tpXSA9IG1jbGtfdGFibGUtPmVudHJpZXNbaV0uY2xrOw0KPiArCQkJ
Y2xvY2tzLT5jbG9ja1tpXSA9IG1jbGtfdGFibGUtPmVudHJpZXNbaV0uY2xrICogMTA7DQo+ICAJ
CWNsb2Nrcy0+Y291bnQgPSBtY2xrX3RhYmxlLT5jb3VudDsNCj4gIAl9DQo+ICAJcmV0dXJuIDA7
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3Iu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU4X2h3bWdy
LmMNCj4gQEAgLTE2MDUsMTcgKzE2MDUsMTcgQEAgc3RhdGljIGludCBzbXU4X2dldF9jbG9ja19i
eV90eXBlKHN0cnVjdA0KPiAgCXN3aXRjaCAodHlwZSkgew0KPiAgCWNhc2UgYW1kX3BwX2Rpc3Bf
Y2xvY2s6DQo+ICAJCWZvciAoaSA9IDA7IGkgPCBjbG9ja3MtPmNvdW50OyBpKyspDQo+IC0JCQlj
bG9ja3MtPmNsb2NrW2ldID0gZGF0YS0+c3lzX2luZm8uZGlzcGxheV9jbG9ja1tpXTsNCj4gKwkJ
CWNsb2Nrcy0+Y2xvY2tbaV0gPSBkYXRhLT5zeXNfaW5mby5kaXNwbGF5X2Nsb2NrW2ldICogMTA7
DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgYW1kX3BwX3N5c19jbG9jazoNCj4gIAkJdGFibGUgPSBo
d21nci0+ZHluX3N0YXRlLnZkZGNfZGVwZW5kZW5jeV9vbl9zY2xrOw0KPiAgCQlmb3IgKGkgPSAw
OyBpIDwgY2xvY2tzLT5jb3VudDsgaSsrKQ0KPiAtCQkJY2xvY2tzLT5jbG9ja1tpXSA9IHRhYmxl
LT5lbnRyaWVzW2ldLmNsazsNCj4gKwkJCWNsb2Nrcy0+Y2xvY2tbaV0gPSB0YWJsZS0+ZW50cmll
c1tpXS5jbGsgKiAxMDsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBhbWRfcHBfbWVtX2Nsb2NrOg0K
PiAgCQljbG9ja3MtPmNvdW50ID0gU01VOF9OVU1fTkJQTUVNT1JZQ0xPQ0s7DQo+ICAJCWZvciAo
aSA9IDA7IGkgPCBjbG9ja3MtPmNvdW50OyBpKyspDQo+IC0JCQljbG9ja3MtPmNsb2NrW2ldID0g
ZGF0YS0NCj4gPnN5c19pbmZvLm5icF9tZW1vcnlfY2xvY2tbY2xvY2tzLT5jb3VudCAtIDEgLSBp
XTsNCj4gKwkJCWNsb2Nrcy0+Y2xvY2tbaV0gPSBkYXRhLQ0KPiA+c3lzX2luZm8ubmJwX21lbW9y
eV9jbG9ja1tjbG9ja3MtPmNvdW50IC0gMQ0KPiArLSBpXSAqIDEwOw0KPiAgCQlicmVhazsNCj4g
IAlkZWZhdWx0Og0KPiAgCQlyZXR1cm4gLTE7DQo+IA0KDQo=
