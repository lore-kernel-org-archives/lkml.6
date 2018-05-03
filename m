Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3092874-1525379124-2-12781781835073644463
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525379123; b=C5FTW3CB+l+mhHMfQctbIV1nTsjQBYf/6/igpUkx5GeoPXDRfJ
    34wQk4IHjyGnygOssOjz77KIpFAtbUUayG7/4LqMLxzLG7CRJhXDwVVjMEw1coUk
    xsJ74LRKbXAQna1lanyEz4QdFmLOoGfaKHtQkdypEQwWd1tKXqKhBBdUc1g63wps
    XPrJNjXa9mi51IU+VUTgZtOZtnuDKThekeRGAFYasnWwo5tR2KiOXA2AxGdyd+ED
    TfNxslx6T3x16p2/sSuvivLIEws+7oFBzWnOd17OedGNT5ncXB2W1m5IgxEdGBY4
    Fl0CQ6rDQxAlARfCwodlnVTVVuQ3nfI7S/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1525379123; bh=U12ZSgHMJ+ftAoZRjm87Ac91PAFhvgHJ+amh0NZ15Mk=; b=
    dQ+fOuODi9I+GWSM0/xjIbleka23XpLMH3Z3HPDApIHIYoM02BOGH9XO331NI/Ql
    6EBPd3Q3CQ2X3BpeF2DeabzrvKhBTBbI6Rb0wjr0VTuXLFYa5x0y0hJ9o0uLOFkV
    Zjs1eJWqba7BxTHOeV0+N6z24f1Y86l4bqszhG7/lr2RTnmPtmJuczu8sBsR32/N
    sCAhWN7J5b+n9qAfJ0amPiiLzLxMX/mYhD7c4xC1AAtWOLo/erh7u4h60Vl2v5Uu
    SZFXZnRkIOvVz44u6KY33ABQ/fuqk8Qi+aVsnHVTy4Udh9IYhjtl73Ml97o5Sq1J
    i9oEtWN96qHu5vnTXmzEhA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=sharedspace.onmicrosoft.com
    header.i=@sharedspace.onmicrosoft.com header.b=iSLMz0Id x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=Mx66dXWT x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=sharedspace.onmicrosoft.com
      header.i=@sharedspace.onmicrosoft.com header.b=iSLMz0Id x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=Mx66dXWT x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCHJjN5hoTMAmKlg2KBCeRWiOEAFVJdifr1giypQKAbKBFc4yrKzV4pZ1b5aj84YetfI1yIQ5soYgLZdEBhlkAvDxHVv57AUpTTl1GqX9Z3GBO5SXTdY
    sXga28vsHxuAa9JplXj1RIzZXw5xLs8i3GQlglDS4V79kWCX5cFgqkabUhmVYVErTK3EKT8mUDddaqmoV/3pnovdb0Va/Rf5Q2SNpE/G0w0VaFAucuiwK+2R
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=NW1C4N5ZCfcA:10 a=l63GRFdEORMA:10
    a=wwSihFc02yEA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=X0ROFhD97x8A:10 a=JF9118EUAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8
    a=Z4Xt1mSqlT29oCMHb0AA:9 a=QEXdDO2ut3YA:10 a=sHJpmtqPaPkA:10
    a=ic4oXV6auKO-Q6VfiSZ6:22 a=xVlTc564ipvMDusKsbsT:22 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeECUYf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 16:24:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64445 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeECUYd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 16:24:33 -0400
X-IronPort-AV: E=Sophos;i="5.49,359,1520870400";
   d="scan'208";a="77406971"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Jeff Moyer <jmoyer@redhat.com>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs: Add aio iopriority support for block_dev
Thread-Topic: [PATCH v2] fs: Add aio iopriority support for block_dev
Thread-Index: AQHT4wufiwM6RlY01kC8IdAQoZXaF6QeVStwgAAeNIA=
Date: Thu, 3 May 2018 20:24:29 +0000
Message-ID: <002c2c33-2b22-01a2-dc26-4ca19ac4ac24@wdc.com>
References: <20180503182114.2797-1-adam.manzanares@wdc.com>
 <x49po2cr3hc.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49po2cr3hc.fsf@segfault.boston.devel.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0460;7:/GLDUdBthThew3FK/9ZxtBb4cGDP5EJ947jcNtGvXFldk4KxnO/GPWmitN+ppbHycBWOw6rFN9ISasrTZ6tbSLePMgQgtUcd68hZTYcnrbLg4zw5YtZ353Rn1pIqHgX3+mShhT6zC41xrLHoUVRbQwOODsWgQiZQy6rvNb2UUrVYgRQy+5PdN8t/yzFCzzCAnPKwHpNM9Kfkjcj2xK7dcDF5wZC5lnOGNUj1COENNzP43J7MyaPqkgeS8lgNTBWj;20:i/U9Ab4ZHqEAdOkXJ2BQVx3Gg7vGdgggs1i8ho+bpoeGS4Fi9p287lAG9J8mNTHMTX/NZmV0C9SrqoK+ExRkTtEGzoQOEsHpwQZgpJNnGSRJauZLdajvTQ9Mf5aw4hrkOKuDFxolNx23uFSJUXDTk59lrXm6H50tpJuObL6jI6A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0460;
x-ms-traffictypediagnostic: DM5PR04MB0460:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB0460269FFCD628BB0DDC2C64F0870@DM5PR04MB0460.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR04MB0460;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0460;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(346002)(39860400002)(366004)(199004)(189003)(486006)(25786009)(81156014)(2900100001)(11346002)(2616005)(5250100002)(8936002)(6246003)(476003)(446003)(3846002)(6116002)(305945005)(59450400001)(36756003)(105586002)(7736002)(5660300001)(8676002)(81166006)(6486002)(14454004)(966005)(6512007)(478600001)(76176011)(26005)(4326008)(99286004)(316002)(54906003)(53936002)(229853002)(102836004)(97736004)(6436002)(6306002)(6916009)(68736007)(31686004)(31696002)(186003)(106356001)(72206003)(3660700001)(6506007)(2906002)(86362001)(66066001)(3280700002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0460;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iIfFfeOGLhbJBESJqBWRcrcBQyuq6/kD34D6KQ7dTeMyIsqoAokfl3dxPOUBND+wx0ZUeA1/SJcpqbnyOzOaKIyKzT5YdEIC9U0jT626LfDZ9g3jgBs9F3NRgY9sqbFMyqbFA8nbaiJNw6EQ0kN0MhXpUgOLMpXyVdxDQNj1cu8bUVzfff4YponBA6CcRRGu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <99A997E4068F4D45B1B099E9C5021693@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3ed9e8fa-977f-4b1a-b2be-08d5b133df76
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed9e8fa-977f-4b1a-b2be-08d5b133df76
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 20:24:29.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0460
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDUvMy8xOCAxMTozNiBBTSwgSmVmZiBNb3llciB3cm90ZToNCj4gSGksIEFkYW0sDQoN
CkhlbGxvIEplZmYsDQoNCj4gDQo+IGFkYW0ubWFuemFuYXJlc0B3ZGMuY29tIHdyaXRlczoNCj4g
DQo+PiBGcm9tOiBBZGFtIE1hbnphbmFyZXMgPGFkYW0ubWFuemFuYXJlc0B3ZGMuY29tPg0KPj4N
Cj4+IFRoaXMgaXMgdGhlIHBlci1JL08gZXF1aXZhbGVudCBvZiB0aGUgaW9wcmlvX3NldCBzeXN0
ZW0gY2FsbC4NCj4+DQo+PiBXaGVuIElPQ0JfRkxBR19JT1BSSU8gaXMgc2V0IG9uIHRoZSBpb2Ni
IGFpb19mbGFncyBmaWVsZCwgdGhlbiB3ZSBzZXQgdGhlDQo+PiBuZXdseSBhZGRlZCBraW9jYiBr
aV9pb3ByaW8gZmllbGQgdG8gdGhlIHZhbHVlIGluIHRoZSBpb2NiIGFpb19yZXFwcmlvIGZpZWxk
Lg0KPj4NCj4+IFdoZW4gYSBiaW8gaXMgY3JlYXRlZCBmb3IgYW4gYWlvIHJlcXVlc3QgYnkgdGhl
IGJsb2NrIGRldiB3ZSBzZXQgdGhlIHByaW9yaXR5DQo+PiB2YWx1ZSBvZiB0aGUgYmlvIHRvIHRo
ZSB1c2VyIHN1cHBsaWVkIHZhbHVlLg0KPj4NCj4+IFNlZSB0aGUgZm9sbG93aW5nIGxpbmsgZm9y
IHBlcmZvcm1hbmNlIGltcGxpY2F0aW9ucyBvbiBhIFNBVEEgSEREOg0KPj4gaHR0cHM6Ly9sa21s
Lm9yZy9sa21sLzIwMTYvMTIvNi80OTUNCj4+DQo+PiBHaXZlbiB0aGF0IFdSUiBzdXBwb3J0IGZv
ciBOVk1FIGRldmljZXMgaGFzIHBhdGNoZXMgZmxvYXRpbmcgYXJvdW5kIGFuZCBpdCB3YXMNCj4+
IGRpc2N1c3NlZCBhdCBMU0ZNTSwgd2UgbWF5IHNvb24gaGF2ZSBhIGxvd2VyIGxhdGVuY3kgc3Rv
cmFnZSBkZXZpY2UgdGhhdCBjYW4NCj4+IG1ha2UgdXNlIG9mIGlvcHJpb3JpdGllcy4gQSBwZXIg
Y29tbWFuZCBpb3ByaW9yaXR5IGludGVyZmFjZSBzZWVtcyB0aW1lbHkNCj4+IGdpdmVuIHRoZXNl
IGRldmVsb3BtZW50cy4NCj4+DQo+PiBJZiB3ZSB3YW50IHRvIGF2b2lkIGJsb2F0aW5nIHN0cnVj
dCBraW9jYiwgSSBzdWdnZXN0IHdlIHR1cm4gdGhlIHByaXZhdGUgZmllbGQNCj4+IGludG8gYSB1
bmlvbiBvZiB0aGUgcHJpdmF0ZSBhbmQga2lfaW9wcmlvIGZpZWxkLiBJdCBzZWVtcyBsaWtlIHRo
ZSB1c2VycyBvZg0KPj4gdGhlIHByaXZhdGUgZmllbGQgYWxsIHVzZSBpdCBhdCBhIHBvaW50IHdo
ZXJlIHdlIGNhbiB5YW5rIHRoZSBwcmlvcml0eSBmcm9tDQo+PiB0aGUga2lvY2IgYmVmb3JlIHRo
ZSBwcml2YXRlIGZpZWxkIGlzIHVzZWQuIENvbW1lbnRzIGFuZCBzdWdnZXN0aW9ucyB3ZWxjb21l
Lg0KPiANCj4gVGhlIGlvcHJpb19zZXQgc3lzdGVtIGNhbGwgcmVxdWlyZXMgQ0FQX1NZU19BRE1J
TiBmb3Igc2V0dGluZw0KPiBJT1BSSU9fQ0xBU1NfUlQuICBJIHRoaW5rIHdlIG5lZWQgc2ltaWxh
ciBjaGVja3MgaGVyZS4NCg0KSSBmb3Jnb3QgaG93IGRhbmdlcm91cyBJT1BSSU9fQ0xBU1NfUlQg
Y2FuIGJlIDopLiBJIHdpbGwgbWFrZSBhIG5ldyANCmZ1bmN0aW9uIGJhc2VkIG9uIHRoZSBjaGVj
a3MgaW4gaW9wcmlvLmMgYW5kIHJldXNlLg0KDQpUaGFua3MsDQpBZGFtDQoNCj4gDQo+IC1KZWZm
DQo+IA0KPj4NCj4+IHYyOiBtZXJnZSBwYXRjaGVzDQo+PiAgICAgIHVzZSBJT0NCX0ZMQUdfSU9Q
UklPDQo+PiAgICAgIHZhbGlkYXRlIGludGVuZGVkIHVzZSB3aXRoIElPQ0JfSU9QUklPDQo+PiAg
ICAgIGFkZCBsaW51eC1hcGkgYW5kIGxpbnV4LWJsb2NrIHRvIGNjDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogQWRhbSBNYW56YW5hcmVzIDxhZGFtLm1hbnphbmFyZXNAd2RjLmNvbT4NCj4+IC0tLQ0K
Pj4gICBmcy9haW8uYyAgICAgICAgICAgICAgICAgICAgIHwgMTAgKysrKysrKysrKw0KPj4gICBm
cy9ibG9ja19kZXYuYyAgICAgICAgICAgICAgIHwgIDIgKysNCj4+ICAgaW5jbHVkZS9saW51eC9m
cy5oICAgICAgICAgICB8ICAyICsrDQo+PiAgIGluY2x1ZGUvdWFwaS9saW51eC9haW9fYWJpLmgg
fCAgMSArDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9mcy9haW8uYyBiL2ZzL2Fpby5jDQo+PiBpbmRleCA4OGQ3OTI3ZmZiYzYuLmYz
NjYzNmQ4ZmYyYyAxMDA2NDQNCj4+IC0tLSBhL2ZzL2Fpby5jDQo+PiArKysgYi9mcy9haW8uYw0K
Pj4gQEAgLTE1OTcsNiArMTU5NywxNiBAQCBzdGF0aWMgaW50IGlvX3N1Ym1pdF9vbmUoc3RydWN0
IGtpb2N0eCAqY3R4LCBzdHJ1Y3QgaW9jYiBfX3VzZXIgKnVzZXJfaW9jYiwNCj4+ICAgCQlyZXEt
PmNvbW1vbi5raV9mbGFncyB8PSBJT0NCX0VWRU5URkQ7DQo+PiAgIAl9DQo+PiAgIA0KPj4gKwlp
ZiAoaW9jYi0+YWlvX2ZsYWdzICYgSU9DQl9GTEFHX0lPUFJJTykgew0KPj4gKwkJLyoNCj4+ICsJ
CSAqIElmIHRoZSBJT0NCX0ZMQUdfSU9QUklPIGZsYWcgb2YgYWlvX2ZsYWdzIGlzIHNldCwgdGhl
bg0KPj4gKwkJICogYWlvX3JlcXByaW8gaXMgaW50ZXJwcmV0ZWQgYXMgYW4gSS9PIHNjaGVkdWxp
bmcNCj4+ICsJCSAqIGNsYXNzIGFuZCBwcmlvcml0eS4NCj4+ICsJCSAqLw0KPj4gKwkJcmVxLT5j
b21tb24ua2lfaW9wcmlvID0gaW9jYi0+YWlvX3JlcXByaW87DQo+PiArCQlyZXEtPmNvbW1vbi5r
aV9mbGFncyB8PSBJT0NCX0lPUFJJTzsNCj4+ICsJfQ0KPj4gKw0KPj4gICAJcmV0ID0ga2lvY2Jf
c2V0X3J3X2ZsYWdzKCZyZXEtPmNvbW1vbiwgaW9jYi0+YWlvX3J3X2ZsYWdzKTsNCj4+ICAgCWlm
ICh1bmxpa2VseShyZXQpKSB7DQo+PiAgIAkJcHJfZGVidWcoIkVJTlZBTDogYWlvX3J3X2ZsYWdz
XG4iKTsNCj4+IGRpZmYgLS1naXQgYS9mcy9ibG9ja19kZXYuYyBiL2ZzL2Jsb2NrX2Rldi5jDQo+
PiBpbmRleCA3ZWM5MjBlMjcwNjUuLjk3MGJlZjc5Y2FhNiAxMDA2NDQNCj4+IC0tLSBhL2ZzL2Js
b2NrX2Rldi5jDQo+PiArKysgYi9mcy9ibG9ja19kZXYuYw0KPj4gQEAgLTM1NSw2ICszNTUsOCBA
QCBfX2Jsa2Rldl9kaXJlY3RfSU8oc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIg
Kml0ZXIsIGludCBucl9wYWdlcykNCj4+ICAgCQliaW8tPmJpX3dyaXRlX2hpbnQgPSBpb2NiLT5r
aV9oaW50Ow0KPj4gICAJCWJpby0+YmlfcHJpdmF0ZSA9IGRpbzsNCj4+ICAgCQliaW8tPmJpX2Vu
ZF9pbyA9IGJsa2Rldl9iaW9fZW5kX2lvOw0KPj4gKwkJaWYgKGlvY2ItPmtpX2ZsYWdzICYgSU9D
Ql9JT1BSSU8pDQo+PiArCQkJYmlvLT5iaV9pb3ByaW8gPSBpb2NiLT5raV9pb3ByaW87DQo+PiAg
IA0KPj4gICAJCXJldCA9IGJpb19pb3ZfaXRlcl9nZXRfcGFnZXMoYmlvLCBpdGVyKTsNCj4+ICAg
CQlpZiAodW5saWtlbHkocmV0KSkgew0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnMu
aCBiL2luY2x1ZGUvbGludXgvZnMuaA0KPj4gaW5kZXggNzYwZDhkYTFiNmM3Li5hYjYzY2U3MjAz
MDUgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+ICsrKyBiL2luY2x1ZGUv
bGludXgvZnMuaA0KPj4gQEAgLTI5Miw2ICsyOTIsNyBAQCBlbnVtIHJ3X2hpbnQgew0KPj4gICAj
ZGVmaW5lIElPQ0JfU1lOQwkJKDEgPDwgNSkNCj4+ICAgI2RlZmluZSBJT0NCX1dSSVRFCQkoMSA8
PCA2KQ0KPj4gICAjZGVmaW5lIElPQ0JfTk9XQUlUCQkoMSA8PCA3KQ0KPj4gKyNkZWZpbmUgSU9D
Ql9JT1BSSU8JCSgxIDw8IDgpDQo+PiAgIA0KPj4gICBzdHJ1Y3Qga2lvY2Igew0KPj4gICAJc3Ry
dWN0IGZpbGUJCSpraV9maWxwOw0KPj4gQEAgLTMwMCw2ICszMDEsNyBAQCBzdHJ1Y3Qga2lvY2Ig
ew0KPj4gICAJdm9pZAkJCSpwcml2YXRlOw0KPj4gICAJaW50CQkJa2lfZmxhZ3M7DQo+PiAgIAll
bnVtIHJ3X2hpbnQJCWtpX2hpbnQ7DQo+PiArCXUxNgkJCWtpX2lvcHJpbzsgLyogU2VlIGxpbnV4
L2lvcHJpby5oICovDQo+PiAgIH0gX19yYW5kb21pemVfbGF5b3V0Ow0KPj4gICANCj4+ICAgc3Rh
dGljIGlubGluZSBib29sIGlzX3N5bmNfa2lvY2Ioc3RydWN0IGtpb2NiICpraW9jYikNCj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYWlvX2FiaS5oIGIvaW5jbHVkZS91YXBpL2xp
bnV4L2Fpb19hYmkuaA0KPj4gaW5kZXggYTA0YWRiYzcwZGRmLi5kNDU5M2E2MDYyZWYgMTAwNjQ0
DQo+PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYWlvX2FiaS5oDQo+PiArKysgYi9pbmNsdWRl
L3VhcGkvbGludXgvYWlvX2FiaS5oDQo+PiBAQCAtNTQsNiArNTQsNyBAQCBlbnVtIHsNCj4+ICAg
ICogICAgICAgICAgICAgICAgICAgaXMgdmFsaWQuDQo+PiAgICAqLw0KPj4gICAjZGVmaW5lIElP
Q0JfRkxBR19SRVNGRAkJKDEgPDwgMCkNCj4+ICsjZGVmaW5lIElPQ0JfRkxBR19JT1BSSU8JKDEg
PDwgMSkNCj4+ICAgDQo+PiAgIC8qIHJlYWQoKSBmcm9tIC9kZXYvYWlvIHJldHVybnMgdGhlc2Ug
c3RydWN0dXJlcy4gKi8NCj4+ICAgc3RydWN0IGlvX2V2ZW50IHs=
