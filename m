Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32DFC2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1542084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="V0JbKZy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfAUOiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:38:51 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:12715 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbfAUOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:38:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="25760302"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Jan 2019 07:38:50 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 21 Jan 2019 07:38:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P5fzxLdAxFCcIQmqkZrgpoN8vDnKPCQuB1hGhe4c74=;
 b=V0JbKZy9jo0xbTNTPJCyrABZ/6Yjm1jwNUG84nPe6fY44AX+thrNYb8KhMMbMGSy0Gf9mXB98lIqVt0QOCHPxHLNYvPHIehvuVsRRypNbzF7YyoY6w0PQHizHNzX9+FPYEXCTpiGq5kxFVezaGe3W4RF0hROIcF5AeOT7FbciHg=
Received: from DM5PR11MB1257.namprd11.prod.outlook.com (10.168.108.11) by
 DM5PR11MB1417.namprd11.prod.outlook.com (10.168.104.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Mon, 21 Jan 2019 14:38:47 +0000
Received: from DM5PR11MB1257.namprd11.prod.outlook.com
 ([fe80::3437:d1a8:fda4:a881]) by DM5PR11MB1257.namprd11.prod.outlook.com
 ([fe80::3437:d1a8:fda4:a881%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 14:38:47 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <vkoul@kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel as
 in use
Thread-Topic: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Thread-Index: AQHUrn8vO/Ym+tRt40+WbUu3tf2aBaW4AseAgAHOTIA=
Date:   Mon, 21 Jan 2019 14:38:47 +0000
Message-ID: <450ee975-a603-cf89-0000-13156c1cb5e8@microchip.com>
References: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
 <20190120110417.GS4635@vkoul-mobl>
In-Reply-To: <20190120110417.GS4635@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0392.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::20) To DM5PR11MB1257.namprd11.prod.outlook.com
 (2603:10b6:3:14::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1417;6:XCjIrZu/FB0d5vNr9bb+r2fwjNGZWDpxqI2o8BIWRUpdACVriKrUTvS7CX90loP+2AaXSGCvWl6EfMjnPcAtNo0EFYct7CJEel/Z+7JUYx3Bqxb38Wj4RBNAE/MnLs8s3vyfQDlalDyhAnRg54SOBND0Eb8a+nhP5cACRWUyevh93LukSFHHfFgwW2eV7rhlD3QxF5iGmrGHhyxgNYjD1U/I0zj+WB7Df3TiKz9FOO9spkGAzlG+qwJbcdY6x3F18M1OJNj5IVtbwiZCk7Fxb+RzJfcyv/QnggDvbST67NPvgWqCARdWbxS8s+EYETEqKbecjxFnbLynihg2itVklqDq1OCF8xH35bAwaQgRXROD7Ax9gEs0ww8arCa606htgRLTBVV6pTVEnqrG25e5Iw6n2LmiOmh5akHJRgowAz31wkECWIjb2xmU9MpNChiib4R/H9lXCvzbvLf64SsOfA==;5:G7MU/lBmUrtbk/wtbYvRbdHGCP/t87MwL564UHSWt9Cm/ci6CcQCQue1Fnn2dT+E/JyrsEAQBTU0y8cS7SEz2eAwpQViMXR110KFpw8I18eDgcFps7os2D/huFtjBJtLREtiKhqX8nriBt1P1AI52e8k9tZlaQETmyTpLgRbcK1eN1SDmC256Thgoei/awCOLow7OL+2+0XGECApi65CJQ==;7:Mo4Uq/lSwbLGaJoM+MXPA43cm7img+7FOixCCK0hjv5h8fIELC8UMTbaX3q9owRoSuf5dKX/pYl3a2MrQiupp51ytBPAZ9dzSlwcuOGdFB18jwgCN7VuNPihnZ0BXVoxosPn2j/GyxNYwFLqqO6QgA==
x-ms-office365-filtering-correlation-id: 0f7dd48f-1916-4818-56df-08d67fae26cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1417;
x-ms-traffictypediagnostic: DM5PR11MB1417:
x-microsoft-antispam-prvs: <DM5PR11MB1417710CFBCD5E577136550FE79F0@DM5PR11MB1417.namprd11.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(478600001)(81156014)(31686004)(81166006)(105586002)(8936002)(106356001)(2906002)(6116002)(3846002)(8676002)(14454004)(36756003)(229853002)(99286004)(4326008)(72206003)(6916009)(68736007)(6486002)(71190400001)(71200400001)(6436002)(53936002)(6512007)(316002)(52116002)(486006)(6246003)(476003)(7736002)(2616005)(54906003)(6506007)(25786009)(305945005)(97736004)(446003)(11346002)(26005)(53546011)(31696002)(186003)(102836004)(14444005)(256004)(386003)(66066001)(76176011)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1417;H:DM5PR11MB1257.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ALw61F+njE7MRWx9p93yOLngOmD0eEZNjVUNl7K9kzkyY/BCjdPER339cfUVhJEFiNrqsrvmXKOrXV5rHDwHVJV+IbhSdfhD5+Oovhgh/ClIMyuX1D5oV60CgD0/WtaBeGPX6NuFeUu4d43onBBbR/lBYGWxHm+mw2Dmv690cTjiX3LLbw2Y48iKjHV1d64Sx5vRb+xxPdKVGrup9De8Pkx7V+JYLDe6rD9teilyN/cvGGnCrwU+jZwph/Z2ue2g/757TI1NEbjOsDIri3VjwaOhLks5zWxDV4RjDQHPjztXYtql0qZK7IFj+K3qwuXGm7W349W7jmectszRABqeoCfOm5m34QYlL5tVf+1RDwnbGW1Bmho2zsVDc5zxJjtPxq1uV+rhJMMExFzsi/vzifVGtqSbSqSqUHaiZ6yzgZA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBDC3F9482FDA943AA6B6ADE473DF109@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7dd48f-1916-4818-56df-08d67fae26cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 14:38:45.8407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1417
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAuMDEuMjAxOSAxMzowNCwgVmlub2QgS291bCB3cm90ZToNCj4gSGkgQ29kcmluLA0KPiAN
Cj4gT24gMTctMDEtMTksIDE2OjEwLCBDb2RyaW4uQ2l1Ym90YXJpdUBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPj4gRnJvbTogQ29kcmluIENpdWJvdGFyaXUgPGNvZHJpbi5jaXVib3Rhcml1QG1pY3Jv
Y2hpcC5jb20+DQo+Pg0KPj4gYXRjaGFuLT5zdGF0dXMgaXMgdXNlZCBmb3IgdHdvIHRoaW5nczoN
Cj4+ICAgLSBwYXNzIGNoYW5uZWwgaW50ZXJydXB0cyBzdGF0dXMgZnJvbSBpbnRlcnJ1cHQgaGFu
ZGxlciB0byB0YXNrbGV0Ow0KPj4gICAtIGNoYW5uZWwgaW5mb3JtYXRpb24gbGlrZSB3aGV0aGVy
IGl0IGlzIGN5Y2xpYyBvciBwYXVzZWQ7DQo+Pg0KPj4gU2luY2UgdGhlc2Ugb3BlcmF0aW9ucyBo
YXZlIG5vdGhpbmcgaW4gY29tbW9uLCB0aGlzIHBhdGNoIGFkZHMgYQ0KPj4gZGlmZmVyZW50IHN0
cnVjdCBtZW1iZXIgdG8ga2VlcCB0aGUgaW50ZXJydXB0cyBzdGF0dXMuDQo+Pg0KPj4gRml4ZXMg
YSBidWcgaW4gd2hpY2ggYSBjaGFubmVsIGlzIHdyb25nZnVsbHkgcmVwb3J0ZWQgYXMgaW4gdXNl
IHdoZW4NCj4+IHRyeWluZyB0byBvYnRhaW4gYSBuZXcgZGVzY3JpcHRpb3IgZm9yIGEgcHJldmlv
dXNseSB1c2VkIGN5Y2xpYyBjaGFubmVsLg0KPiANCj4gVGhpcyBsb29rcyByZWFzb25hYmxlIGJ1
dCBhbSB1bmFibGUgdG8gc2VlIGhvdyB0aGUgYnVnIGlzIGZpeGVkLiBQZXJoYXBzDQo+IHdvdWxk
IGJlIGdyZWF0IHRvIHNwbGl0IHRoZSBidWcgcGFydCAod2hpY2ggY2FuIGdvIHRvIGZpeGVzKSBh
bmQgcmVtb3ZlDQo+IHRoZSByZXVzZSBvZiB2YXJpYWJsZSBhcyBhIHN1YnNlcXVlbnQgcGF0Y2gu
Lg0KDQpIaSBWaW5vZCwNCg0KVGhpcyBwYXRjaCBpcyB0aGUgZml4LCBzaW5jZSBpdCBtb3ZlcyB0
aGUgb3BlcmF0aW9ucyBvbiBhdGNoYW4tPnN0YXR1cywgDQppbiB3aGljaCB0aGUgaW50ZXJydXB0
IHN0YXR1cyByZWdpc3RlciBpcyBzYXZlZCwgdG8gYSBkaWZmZXJlbnQgbWVtYmVyIA0KKGlycV9z
dGF0dXMpLiBUaGUgQVRfWERNQUNfQ0hBTl9JU19DWUNMSUMgYW5kIEFUX1hETUFDX0NIQU5fSVNf
UEFVU0VEIA0KYml0cyBoYXZlIG5vdGhpbmcgaW4gY29tbW9uIHdpdGggdGhlIGludGVycnVwdCBz
dGF0dXMgcmVnaXN0ZXIuDQoNClRoZSBidWcgcmVwcm9kdWNlcyB3aGVuIGEgZGV2aWNlX3Rlcm1p
bmF0ZV9hbGwoKSBpcyBjYWxsZWQsIA0KKEFUX1hETUFDX0NIQU5fSVNfQ1lDTElDIGNsZWFyZWQg
b24gYXRjaGFuLT5zdGF0dXMpIGFuZCB0aGVuIGEgbGF0ZSBFbmQgDQpvZiBCbG9jayBpbnRlcnJ1
cHQgYXJyaXZlcyAoQVRfWERNQUNfQ0lTX0JJUyksIHdoaWNoIHNldHMgYml0IDAgb2YgDQphdGNo
YW4tPnN0YXR1cy4gQml0IDAgaXMgYWxzbyB1c2VkIGZvciBBVF9YRE1BQ19DSEFOX0lTX0NZQ0xJ
Qywgc28gd2hlbiANCmEgbmV3IGRlc2NyaXB0b3IgZm9yIGEgY3ljbGljIHRyYW5zZmVyIGlzIGNy
ZWF0ZWQsIHRoZSBkcml2ZXIgcmVwb3J0cyANCnRoZSBjaGFubmVsIGFzIGluIHVzZToNCg0KaWYg
KHRlc3RfYW5kX3NldF9iaXQoQVRfWERNQUNfQ0hBTl9JU19DWUNMSUMsICZhdGNoYW4tPnN0YXR1
cykpIHsNCglkZXZfZXJyKGNoYW4yZGV2KGNoYW4pLCAiY2hhbm5lbCBjdXJyZW50bHkgdXNlZFxu
Iik7DQoJcmV0dXJuIE5VTEw7DQp9DQoNCkkgY2FuIHNlbmQgdjIgaWYgeW91IGNvbnNpZGVyIHRo
ZSBjb21taXQgbWVzc2FnZSBtaXNsZWFkaW5nLg0KDQpCZXN0IHJlZ2FyZHMsDQpDb2RyaW4NCg0K
PiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb2RyaW4gQ2l1Ym90YXJpdSA8Y29kcmluLmNpdWJv
dGFyaXVAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2RtYS9hdF94ZG1hYy5j
IHwgMTkgKysrKysrKysrKy0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEv
YXRfeGRtYWMuYyBiL2RyaXZlcnMvZG1hL2F0X3hkbWFjLmMNCj4+IGluZGV4IDRlNTU3Njg0Zjc5
Mi4uZmU2OWRjY2ZhMGMwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9kbWEvYXRfeGRtYWMuYw0K
Pj4gKysrIGIvZHJpdmVycy9kbWEvYXRfeGRtYWMuYw0KPj4gQEAgLTIwMyw2ICsyMDMsNyBAQCBz
dHJ1Y3QgYXRfeGRtYWNfY2hhbiB7DQo+PiAgIAl1MzIJCQkJc2F2ZV9jaW07DQo+PiAgIAl1MzIJ
CQkJc2F2ZV9jbmRhOw0KPj4gICAJdTMyCQkJCXNhdmVfY25kYzsNCj4+ICsJdTMyCQkJCWlycV9z
dGF0dXM7DQo+PiAgIAl1bnNpZ25lZCBsb25nCQkJc3RhdHVzOw0KPj4gICAJc3RydWN0IHRhc2ts
ZXRfc3RydWN0CQl0YXNrbGV0Ow0KPj4gICAJc3RydWN0IGRtYV9zbGF2ZV9jb25maWcJCXNjb25m
aWc7DQo+PiBAQCAtMTU4MCw4ICsxNTgxLDggQEAgc3RhdGljIHZvaWQgYXRfeGRtYWNfdGFza2xl
dCh1bnNpZ25lZCBsb25nIGRhdGEpDQo+PiAgIAlzdHJ1Y3QgYXRfeGRtYWNfZGVzYwkqZGVzYzsN
Cj4+ICAgCXUzMgkJCWVycm9yX21hc2s7DQo+PiAgIA0KPj4gLQlkZXZfZGJnKGNoYW4yZGV2KCZh
dGNoYW4tPmNoYW4pLCAiJXM6IHN0YXR1cz0weCUwOGx4XG4iLA0KPj4gLQkJIF9fZnVuY19fLCBh
dGNoYW4tPnN0YXR1cyk7DQo+PiArCWRldl9kYmcoY2hhbjJkZXYoJmF0Y2hhbi0+Y2hhbiksICIl
czogc3RhdHVzPTB4JTA4eFxuIiwNCj4+ICsJCV9fZnVuY19fLCBhdGNoYW4tPmlycV9zdGF0dXMp
Ow0KPj4gICANCj4+ICAgCWVycm9yX21hc2sgPSBBVF9YRE1BQ19DSVNfUkJFSVMNCj4+ICAgCQkg
ICAgIHwgQVRfWERNQUNfQ0lTX1dCRUlTDQo+PiBAQCAtMTU4OSwxNSArMTU5MCwxNSBAQCBzdGF0
aWMgdm9pZCBhdF94ZG1hY190YXNrbGV0KHVuc2lnbmVkIGxvbmcgZGF0YSkNCj4+ICAgDQo+PiAg
IAlpZiAoYXRfeGRtYWNfY2hhbl9pc19jeWNsaWMoYXRjaGFuKSkgew0KPj4gICAJCWF0X3hkbWFj
X2hhbmRsZV9jeWNsaWMoYXRjaGFuKTsNCj4+IC0JfSBlbHNlIGlmICgoYXRjaGFuLT5zdGF0dXMg
JiBBVF9YRE1BQ19DSVNfTElTKQ0KPj4gLQkJICAgfHwgKGF0Y2hhbi0+c3RhdHVzICYgZXJyb3Jf
bWFzaykpIHsNCj4+ICsJfSBlbHNlIGlmICgoYXRjaGFuLT5pcnFfc3RhdHVzICYgQVRfWERNQUNf
Q0lTX0xJUykNCj4+ICsJCSAgIHx8IChhdGNoYW4tPmlycV9zdGF0dXMgJiBlcnJvcl9tYXNrKSkg
ew0KPj4gICAJCXN0cnVjdCBkbWFfYXN5bmNfdHhfZGVzY3JpcHRvciAgKnR4ZDsNCj4+ICAgDQo+
PiAtCQlpZiAoYXRjaGFuLT5zdGF0dXMgJiBBVF9YRE1BQ19DSVNfUkJFSVMpDQo+PiArCQlpZiAo
YXRjaGFuLT5pcnFfc3RhdHVzICYgQVRfWERNQUNfQ0lTX1JCRUlTKQ0KPj4gICAJCQlkZXZfZXJy
KGNoYW4yZGV2KCZhdGNoYW4tPmNoYW4pLCAicmVhZCBidXMgZXJyb3IhISEiKTsNCj4+IC0JCWlm
IChhdGNoYW4tPnN0YXR1cyAmIEFUX1hETUFDX0NJU19XQkVJUykNCj4+ICsJCWlmIChhdGNoYW4t
PmlycV9zdGF0dXMgJiBBVF9YRE1BQ19DSVNfV0JFSVMpDQo+PiAgIAkJCWRldl9lcnIoY2hhbjJk
ZXYoJmF0Y2hhbi0+Y2hhbiksICJ3cml0ZSBidXMgZXJyb3IhISEiKTsNCj4+IC0JCWlmIChhdGNo
YW4tPnN0YXR1cyAmIEFUX1hETUFDX0NJU19ST0lTKQ0KPj4gKwkJaWYgKGF0Y2hhbi0+aXJxX3N0
YXR1cyAmIEFUX1hETUFDX0NJU19ST0lTKQ0KPj4gICAJCQlkZXZfZXJyKGNoYW4yZGV2KCZhdGNo
YW4tPmNoYW4pLCAicmVxdWVzdCBvdmVyZmxvdyBlcnJvciEhISIpOw0KPj4gICANCj4+ICAgCQlz
cGluX2xvY2soJmF0Y2hhbi0+bG9jayk7DQo+PiBAQCAtMTY1Miw3ICsxNjUzLDcgQEAgc3RhdGlj
IGlycXJldHVybl90IGF0X3hkbWFjX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQo+
PiAgIAkJCWF0Y2hhbiA9ICZhdHhkbWFjLT5jaGFuW2ldOw0KPj4gICAJCQljaGFuX2ltciA9IGF0
X3hkbWFjX2NoYW5fcmVhZChhdGNoYW4sIEFUX1hETUFDX0NJTSk7DQo+PiAgIAkJCWNoYW5fc3Rh
dHVzID0gYXRfeGRtYWNfY2hhbl9yZWFkKGF0Y2hhbiwgQVRfWERNQUNfQ0lTKTsNCj4+IC0JCQlh
dGNoYW4tPnN0YXR1cyA9IGNoYW5fc3RhdHVzICYgY2hhbl9pbXI7DQo+PiArCQkJYXRjaGFuLT5p
cnFfc3RhdHVzID0gY2hhbl9zdGF0dXMgJiBjaGFuX2ltcjsNCj4+ICAgCQkJZGV2X3ZkYmcoYXR4
ZG1hYy0+ZG1hLmRldiwNCj4+ICAgCQkJCSAiJXM6IGNoYW4lZDogaW1yPTB4JXgsIHN0YXR1cz0w
eCV4XG4iLA0KPj4gICAJCQkJIF9fZnVuY19fLCBpLCBjaGFuX2ltciwgY2hhbl9zdGF0dXMpOw0K
Pj4gQEAgLTE2NjYsNyArMTY2Nyw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBhdF94ZG1hY19pbnRl
cnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPj4gICAJCQkJIGF0X3hkbWFjX2NoYW5fcmVh
ZChhdGNoYW4sIEFUX1hETUFDX0NEQSksDQo+PiAgIAkJCQkgYXRfeGRtYWNfY2hhbl9yZWFkKGF0
Y2hhbiwgQVRfWERNQUNfQ1VCQykpOw0KPj4gICANCj4+IC0JCQlpZiAoYXRjaGFuLT5zdGF0dXMg
JiAoQVRfWERNQUNfQ0lTX1JCRUlTIHwgQVRfWERNQUNfQ0lTX1dCRUlTKSkNCj4+ICsJCQlpZiAo
YXRjaGFuLT5pcnFfc3RhdHVzICYgKEFUX1hETUFDX0NJU19SQkVJUyB8IEFUX1hETUFDX0NJU19X
QkVJUykpDQo+PiAgIAkJCQlhdF94ZG1hY193cml0ZShhdHhkbWFjLCBBVF9YRE1BQ19HRCwgYXRj
aGFuLT5tYXNrKTsNCj4+ICAgDQo+PiAgIAkJCXRhc2tsZXRfc2NoZWR1bGUoJmF0Y2hhbi0+dGFz
a2xldCk7DQo+PiAtLSANCj4+IDIuMTcuMQ0KPiANCg0K
