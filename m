Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AA2C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FB125819
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="SOzV3B+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FB125819
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755335AbeFYL1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:27:03 -0400
Received: from mail-he1eur01on0097.outbound.protection.outlook.com ([104.47.0.97]:64416
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932089AbeFYL1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Bc6sIj1KRY4htN8yYKyL91dHRmg0L+/+LBt69shz4=;
 b=SOzV3B+Hjt11WoNlmD3niZCLbzxW+eBwskQrTTDWy7gYHMFJq8EAykAM0ox0x3IL2HgLLxxPofYgbR2mkzA0lcc9qoBoyC0obXbsIsVT/IVWc6Z/fDUJd4+NHtPX1lF51q+XsMIFP5eASRXUnPCBDsL3G1NkK9GM1Hchb5XoL68=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB1982.eurprd05.prod.outlook.com (10.166.45.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Mon, 25 Jun 2018 11:26:50 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3%9]) with mapi id 15.20.0884.023; Mon, 25 Jun 2018
 11:26:49 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dean_Jenkins@mentor.com" <Dean_Jenkins@mentor.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] net: usb: asix: allow optionally getting mac address from
 device tree
Thread-Topic: [PATCH] net: usb: asix: allow optionally getting mac address
 from device tree
Thread-Index: AQHUDFrD9SOlWe/HGkGEZAlascIgqKRw1hkA
Date:   Mon, 25 Jun 2018 11:26:49 +0000
Message-ID: <1529926008.12558.14.camel@toradex.com>
References: <20180625080108.32441-1-marcel@ziswiler.com>
In-Reply-To: <20180625080108.32441-1-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB1982;7:/ml1wrY9H8LvvwFzbtwSjJSvhZ57I3IDZceLyetyVyKwY1R+ymppZYXTX0xLgTir60zGZ83sjp/X4OSYtUKrjJYgtRPrSEp6qexR1c9l12Nf+X1tLkJxb16ppfUmIHQ/K9HjlzppQVkauP7do/DuYIoViXVQINfnRHdWQJWlJ9gbeWqCHz09XdpMEubiwcDPd3EIhZ+p/82DmKYsjUlaVMoz18j8iAGPCoXhHalOK0Xjkja0+/GlrJpYCtXzOsD8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 77cb8106-1630-494f-d355-08d5da8e8b42
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB1982;
x-ms-traffictypediagnostic: VI1PR0501MB1982:
x-microsoft-antispam-prvs: <VI1PR0501MB1982416C241A8A3FBECFD02DFB4A0@VI1PR0501MB1982.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB1982;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB1982;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39840400004)(346002)(376002)(189003)(199004)(6116002)(3846002)(305945005)(486006)(478600001)(68736007)(44832011)(14454004)(2616005)(8936002)(8676002)(476003)(6436002)(2906002)(4326008)(99286004)(106356001)(105586002)(7736002)(2501003)(5250100002)(11346002)(446003)(5660300001)(86362001)(97736004)(2351001)(2900100001)(26005)(186003)(25786009)(36756003)(3660700001)(102836004)(316002)(54906003)(103116003)(6486002)(66066001)(81166006)(6512007)(81156014)(6246003)(1730700003)(76176011)(3280700002)(53936002)(6916009)(229853002)(5640700003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB1982;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mecLpEhUmgGZpT736KDZch8T39fgf2n+6FgW9zGmtO+Y+z5MWUEYcOPeO+nIJKvDd4k+jGEDMCRjhVlughWlZdFiJRXLZQoxStQ8zZy7E3CpETcHxCsIcbDmeU9VMRyPTRcwgpUAOTImYVACK2NNIbA9OJRvlWcVA87b5EB+JY4nQR0zTTxrakofz6f9nNnJGUvSql1WLq3Zoxa4lv/ko9LRAOFINqFMNqFunsQl8cxfP5yPkS/aAQ6t85pPKyt2wTwdjKkV+ZXbtqQbJW8ehZrF1LOMpG80dxOs3unkuBwRi6fha0XC7UOAxa+PTK7R/gTt5XVlwg/U8ZvwIHLDdJbpgFM4+0IBKtmfZwhnx/I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B67AC83BEF237549B37AB9351A5D5BD0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cb8106-1630-494f-d355-08d5da8e8b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 11:26:49.8323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB1982
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQNCg0KT24gTW9uLCAyMDE4LTA2LTI1IGF0IDEwOjAxICswMjAwLCBNYXJjZWwgWmlz
d2lsZXIgd3JvdGU6DQo+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRv
cmFkZXguY29tPg0KPiANCj4gRm9yIEVtYmVkZGVkIHVzZSB3aGVyZSBlLmcuIEFYODg3NzJCIGNo
aXBzIG1heSBiZSB1c2VkIHdpdGhvdXQNCj4gZXh0ZXJuYWwNCj4gRUVQUk9NcyB0aGUgYm9vdCBs
b2FkZXIgbWF5IGNob29zZSB0byBwYXNzIHRoZSBNQUMgYWRkcmVzcyB0byBiZSB1c2VkDQo+IHZp
YSBkZXZpY2UgdHJlZS4gVGhlcmVmb3JlLCBhbGxvdyBmb3Igb3B0aW9uYWxseSBnZXR0aW5nIHRo
ZSBNQUMNCj4gYWRkcmVzcyBmcm9tIGRldmljZSB0cmVlIGRhdGEgZS5nLiBhcyBmb2xsb3dzIChl
eGNlcnB0IGZyb20gYSBUMzANCj4gYmFzZWQNCj4gYm9hcmQsIGxvY2FsLW1hYy1hZGRyZXNzIHRv
IGJlIGZpbGxlZCBpbiBieSBib290IGxvYWRlcik6DQo+IA0KPiAvKiBFSENJIGluc3RhbmNlIDE6
IFVTQjJfRFAvTiAtPiBBWDg4NzcyQiAqLw0KPiB1c2JAN2QwMDQwMDAgew0KPiAJc3RhdHVzID0g
Im9rYXkiOw0KPiAJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+IAkjc2l6ZS1jZWxscyA9IDwwPjsN
Cj4gCWFzaXhAMSB7DQo+IAkJcmVnID0gPDE+Ow0KPiAJCWxvY2FsLW1hYy1hZGRyZXNzID0gWzAw
IDAwIDAwIDAwIDAwIDAwXTsNCj4gCX07DQo+IH07DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJj
ZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gDQo+IC0tLQ0KPiAN
Cj4gIGRyaXZlcnMvbmV0L3VzYi9hc2l4LmggICAgICAgICB8ICAxICsNCj4gIGRyaXZlcnMvbmV0
L3VzYi9hc2l4X2RldmljZXMuYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0K
PiAtLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTUgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdXNiL2FzaXguaCBiL2Ry
aXZlcnMvbmV0L3VzYi9hc2l4LmgNCj4gaW5kZXggOWE0MTcxYjkwOTQ3Li5jODE2MTk2MGNlZjIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3VzYi9hc2l4LmgNCj4gKysrIGIvZHJpdmVycy9u
ZXQvdXNiL2FzaXguaA0KPiBAQCAtMzcsNiArMzcsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3Vz
Yi91c2JuZXQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvaWZfdmxhbi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX25ldC5oPg0KPiAgDQo+ICAjZGVm
aW5lIERSSVZFUl9WRVJTSU9OICIyMi1EZWMtMjAxMSINCj4gICNkZWZpbmUgRFJJVkVSX05BTUUg
ImFzaXgiDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2IvYXNpeF9kZXZpY2VzLmMNCj4g
Yi9kcml2ZXJzL25ldC91c2IvYXNpeF9kZXZpY2VzLmMNCj4gaW5kZXggM2Q0Zjc5NTlkYWJiLi5h
ODhkNjVkZmM2NGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3VzYi9hc2l4X2RldmljZXMu
Yw0KPiArKysgYi9kcml2ZXJzL25ldC91c2IvYXNpeF9kZXZpY2VzLmMNCj4gQEAgLTY5MCwyNSAr
NjkwLDM0IEBAIHN0YXRpYyBpbnQgYXg4ODc3Ml9iaW5kKHN0cnVjdCB1c2JuZXQgKmRldiwNCj4g
c3RydWN0IHVzYl9pbnRlcmZhY2UgKmludGYpDQo+ICAJdTggYnVmW0VUSF9BTEVOXSwgY2hpcGNv
ZGUgPSAwOw0KPiAgCXUzMiBwaHlpZDsNCj4gIAlzdHJ1Y3QgYXNpeF9jb21tb25fcHJpdmF0ZSAq
cHJpdjsNCj4gKwljb25zdCB1OCAqbWFjX2FkZHI7DQo+ICANCj4gLQl1c2JuZXRfZ2V0X2VuZHBv
aW50cyhkZXYsaW50Zik7DQo+ICsJdXNibmV0X2dldF9lbmRwb2ludHMoZGV2LCBpbnRmKTsNCj4g
IA0KPiAtCS8qIEdldCB0aGUgTUFDIGFkZHJlc3MgKi8NCj4gLQlpZiAoZGV2LT5kcml2ZXJfaW5m
by0+ZGF0YSAmIEZMQUdfRUVQUk9NX01BQykgew0KPiAtCQlmb3IgKGkgPSAwOyBpIDwgKEVUSF9B
TEVOID4+IDEpOyBpKyspIHsNCj4gLQkJCXJldCA9IGFzaXhfcmVhZF9jbWQoZGV2LCBBWF9DTURf
UkVBRF9FRVBST00sDQo+IDB4MDQgKyBpLA0KPiAtCQkJCQkgICAgMCwgMiwgYnVmICsgaSAqIDIs
IDApOw0KPiAtCQkJaWYgKHJldCA8IDApDQo+IC0JCQkJYnJlYWs7DQo+IC0JCX0NCj4gKwkvKiBN
YXliZSB0aGUgYm9vdCBsb2FkZXIgcGFzc2VkIHRoZSBNQUMgYWRkcmVzcyB2aWEgZGV2aWNlDQo+
IHRyZWUgKi8NCj4gKwltYWNfYWRkciA9IG9mX2dldF9tYWNfYWRkcmVzcyhkZXYtPnVkZXYtPmRl
di5vZl9ub2RlKTsNCj4gKwlpZiAobWFjX2FkZHIpIHsNCj4gKwkJbWVtY3B5KGJ1ZiwgbWFjX2Fk
ZHIsIEVUSF9BTEVOKTsNCj4gIAl9IGVsc2Ugew0KPiAtCQlyZXQgPSBhc2l4X3JlYWRfY21kKGRl
diwgQVhfQ01EX1JFQURfTk9ERV9JRCwNCj4gLQkJCQkwLCAwLCBFVEhfQUxFTiwgYnVmLCAwKTsN
Cj4gLQl9DQo+ICsJCS8qIFRyeSBnZXR0aW5nIHRoZSBNQUMgYWRkcmVzcyBmcm9tIEVFUFJPTSAq
Lw0KPiArCQlpZiAoZGV2LT5kcml2ZXJfaW5mby0+ZGF0YSAmIEZMQUdfRUVQUk9NX01BQykgew0K
PiArCQkJZm9yIChpID0gMDsgaSA8IChFVEhfQUxFTiA+PiAxKTsgaSsrKSB7DQo+ICsJCQkJcmV0
ID0gYXNpeF9yZWFkX2NtZChkZXYsDQo+IEFYX0NNRF9SRUFEX0VFUFJPTSwNCj4gKwkJCQkJCSAg
ICAweDA0ICsgaSwgMCwgMiwNCj4gYnVmICsgaSAqIDIsDQo+ICsJCQkJCQkgICAgMCk7DQo+ICsJ
CQkJaWYgKHJldCA8IDApDQo+ICsJCQkJCWJyZWFrOw0KPiArCQkJfQ0KPiArCQl9IGVsc2Ugew0K
PiArCQkJcmV0ID0gYXNpeF9yZWFkX2NtZChkZXYsDQo+IEFYX0NNRF9SRUFEX05PREVfSUQsDQo+
ICsJCQkJCSAgICAwLCAwLCBFVEhfQUxFTiwgYnVmLCAwKTsNCj4gKwkJfQ0KPiAgDQo+IC0JaWYg
KHJldCA8IDApIHsNCj4gLQkJbmV0ZGV2X2RiZyhkZXYtPm5ldCwgIkZhaWxlZCB0byByZWFkIE1B
QyBhZGRyZXNzOg0KPiAlZFxuIiwgcmV0KTsNCj4gLQkJcmV0dXJuIHJldDsNCj4gKwkJaWYgKHJl
dCA8IDApIHsNCj4gKwkJCW5ldGRldl9kYmcoZGV2LT5uZXQsICJGYWlsZWQgdG8gcmVhZCBNQUMN
Cj4gYWRkcmVzczogJWRcbiIsDQo+ICsJCQkJICAgcmV0KTsNCj4gKwkJCXJldHVybiByZXQ7DQo+
ICsJCX0NCj4gIAl9DQo+ICANCj4gIAlhc2l4X3NldF9uZXRkZXZfZGV2X2FkZHIoZGV2LCBidWYp
Ow0KDQpOb3cgdGhhdCB5b3UgbWVudGlvbmVkIGV0aF9wbGF0Zm9ybV9nZXRfbWFjX2FkZHJlc3Mo
KSBvbiBteSBpZ2IgYXR0ZW1wdCBJIGFtDQp3b25kZXJpbmcgd2hldGhlciB0aGF0IHdvdWxkIG5v
dCBhbHNvIGJlIHRoZSBiZXR0ZXIgYXBwcm9hY2ggZm9yIEFTSVggVVNCIG5ldA0KdXNlLiBMb29r
cyBsaWtlIGF0IGxlYXN0IGxhbjc4eHggYWxyZWFkeSBkb2VzIGl0IHRoYXQgd2F5IGFzIHdlbGwu
DQoNCldoYXQgZG8geW91IHRoaW5rPw0KDQpDaGVlcnMNCg0KTWFyY2Vs
