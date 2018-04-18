Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-909730-1524071495-2-13476082106027721831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524071493; b=HzELAbeSVCM8TXQ+jjZ1UmvSzkh0vy6SBIqKm0TAqGU8iiFRPo
    IdEXTSQ+hSawm2ZzGD9aXJwVfVvPrSHVCM09/zfuJ8UE+HSuh9YczOY2FrVpZcie
    egYsHx6HJV1bzpCTvWE425cUynZNPCpzDozQUzfxDQ/qHrwKms+EN8v0tjiEfGjr
    vUa0gZgaz1malf3pzP+WaWk4gsLH870Z+UhdqVNeL4tOIIODAqjgmyp5SCfwjUCr
    h/EZTBqPJ8vGpKhMbXr/4A4ZAmQI1/JAUn1JzVfHmuMY609Na+ZRFMLmKvc+jicc
    gyhgAPMC1JHNyWnKC0geRphnd8Z9r6lHqqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524071493; bh=Li0cym9g3S
    a1PZm94fL0IsMsPUNFR8RzNPSbT6Mit0s=; b=pZHmmEAeFzu8ME2BmmfxGbigV0
    uWYw4dMC/KJyi4B/+w46+GUPDOB4xvjIegPGtbVGzoxqcPF86grXEfBP1T2UQQ4B
    rH3RP8mcLSjQaYwnZpTecclzkh0yjTQpzvGc/zh5+UPApSSNY6e4bHLIJrxirLk0
    jNYB0fUeEQxRY443AoY0EzTk5T0BF+YjCaIxGbE0oggfiI2T1uwNfONEMFIH0HmV
    lzJhZBOFg5aAxVxQu0x1upVEZWZ4KdFayk6n/zL9C9egZGL4nTUJxe10jtj500KJ
    2Woy7cYk7cSK4t18D93In2K/Ooz29oYUDjCw4tw+ksuGhMZCtd08W/+7Wnew==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aA836NTl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aA836NTl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEhoDG/Rn8C7S/o1zh+a3V1V6mz+dPbvkpTavlimro/XtYW7j0ava0zA3/Dl4GoZvujtRPNGfJ83dP5aCmbnJ7eh2czrIqexKstX/4drMt+76WaZu1Mq
    Rwhs86xeVZpoNix4bLbMTT8edy+2M68BGDM5RAKGLmFuZ3VD3nIpGpxt39mivg/Rmkwo4PZO7xxpivvCgi0XB/h4W+Us/LA4fkBedu87r/rwWP1RAi/Q2OMP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=IYp8n1Yz95QA:10
    a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=yMhMjlubAAAA:8 a=EMVZCveT_ezDfw9fApQA:9 a=md12jQuXk9sfh_JZ:21
    a=yTwz7NP9j9EJO9K6:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDRRLU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 13:11:20 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com ([104.47.36.115]:63904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751047AbeDRRLR (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 13:11:17 -0400
From: Long Li <longli@microsoft.com>
To: Tom Talpey <tom@talpey.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Topic: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Index: AQHT1q0nc3yHaleoh0CJYtibUbzbEqQGZIIAgAAa8ICAABB7AIAAMDvw
Date: Wed, 18 Apr 2018 17:11:14 +0000
Message-ID: <MWHPR2101MB072909460F3898C6D13B4D4CCEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180418003358.25098-1-longli@linuxonhyperv.com>
 <d7e569b6-d268-b8c1-e91d-d6dc0e7cdfc2@talpey.com>
 <e9e7f77032c5402e848de0293e4db3ee@AcuMS.aculab.com>
 <b8e56b14-a746-2a22-cb8d-94f1ba7d646b@talpey.com>
In-Reply-To: <b8e56b14-a746-2a22-cb8d-94f1ba7d646b@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0811;7:8fojCVD+wWBsQmOv0S1Dc7sxDxBgtrNV736g67FtJwtMY/0HgW44xEHNwMb9FXRuvbQSUbQ+t+PLT8zctkY3v5PSy/Ncx16XMwQYhgnGwT00F18rn9f8+gcKnnYpEqU5db5Uk3gzSedreAoZJObhGUQfWd+Uhke+7LFi77br9Xh2zTVhD9fh3j5gn8711aJGbbxp15jNQApsOayV3cf/jnKeIDFo0aJnu6GOFR1/Gz3n67GWyIBa6CfM2QvFv9in;20:NwFN2PQHeS6+ZNa2QBDVDHXOWiLBmajgIsbnwWSdkhDYmxJQTm4GqaDvI/Y3IpN6v7Crwtqqcp6ogKhGRkkuoHKMv2ghwO7bzBrjsDLn/M1vnoUt10EpKCBF9p1bW9t4A8eNKbO+SFNLtu7CtgN3HtBHSEhsk3fgOjDt9VEFAwY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:MWHPR2101MB0811;
x-ms-traffictypediagnostic: MWHPR2101MB0811:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB081174AC3F18F3BB9296E6F7CEB60@MWHPR2101MB0811.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501368)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR2101MB0811;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0811;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(346002)(376002)(2906002)(229853002)(8936002)(14454004)(10290500003)(9686003)(6436002)(55016002)(25786009)(15650500001)(478600001)(76176011)(53546011)(86612001)(476003)(7696005)(59450400001)(99286004)(446003)(11346002)(6506007)(186003)(10090500001)(102836004)(33656002)(3280700002)(5660300001)(3660700001)(110136005)(6246003)(2501003)(316002)(22452003)(7736002)(6116002)(93886005)(4326008)(305945005)(2201001)(5250100002)(53936002)(81166006)(74316002)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0811;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: NpHEpKIOcKsQ6HEa/m/hnFhsMI866GsR4iDjjPbgIxrHVYRZVlfWy0a0OqORJQ5kJP4gXHa3zSh01chkEIsdKOPcd1313IsbbiKWS56wbJJwvgjd6iXMMyIx6v4pr2eYersh10mkD8ZOAaQdNlTdpYPFyTVOd80YtY6DNE0akf5OqEPkF1FJZUZaRxUSck/N
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 345aa365-0eba-4c0a-f8b2-08d5a54f6414
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345aa365-0eba-4c0a-f8b2-08d5a54f6414
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 17:11:14.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0811
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYzIDIvNl0gY2lmczogQWxsb2NhdGUgdmFsaWRhdGUgbmVn
b3RpYXRpb24gcmVxdWVzdCB0aHJvdWdoDQo+IGttYWxsb2MNCj4gDQo+IE9uIDQvMTgvMjAxOCA5
OjA4IEFNLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogVG9tIFRhbHBleQ0KPiA+PiBT
ZW50OiAxOCBBcHJpbCAyMDE4IDEyOjMyDQo+ID4gLi4uDQo+ID4+IE9uIDQvMTcvMjAxOCA4OjMz
IFBNLCBMb25nIExpIHdyb3RlOg0KPiA+Pj4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29m
dC5jb20+DQo+ID4+Pg0KPiA+Pj4gVGhlIGRhdGEgYnVmZmVyIGFsbG9jYXRlZCBvbiB0aGUgc3Rh
Y2sgY2FuJ3QgYmUgRE1BJ2VkLCBhbmQgaGVuY2UNCj4gPj4+IGNhbid0IHNlbmQgdGhyb3VnaCBS
RE1BIHZpYSBTTUIgRGlyZWN0Lg0KPiA+Pg0KPiA+PiBUaGlzIGNvbW1lbnQgaXMgY29uZnVzaW5n
LiBBbnkgcmVnaXN0ZXJlZCBtZW1vcnkgY2FuIGJlIERNQSdkLCBuZWVkDQo+ID4+IHRvIHN0YXRl
IHRoZSByZWFzb24gZm9yIHRoZSBjaG9pY2UgaGVyZSBtb3JlIGNsZWFybHkuDQo+ID4NCj4gPiBU
aGUgc3RhY2sgY291bGQgYmUgYWxsb2NhdGVkIHdpdGggdm1hbGxvYygpLg0KPiA+IEluIHdoaWNo
IGNhc2UgdGhlIHBhZ2VzIG1pZ2h0IG5vdCBiZSBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMgYW5kIHRo
ZXJlDQo+ID4gaXMgbm8NCj4gPiAoc2Vuc2libGUpIGNhbGwgdG8gZ2V0IHRoZSBwaHlzaWNhbCBh
ZGRyZXNzIHJlcXVpcmVkIGJ5IHRoZSBkbWENCj4gPiBjb250cm9sbGVyIChvciBvdGhlciBidXMg
bWFzdGVyKS4NCj4gDQo+IE1lbW9yeSByZWdpc3RyYXRpb24gZG9lcyBub3QgcmVxdWlyZXMgcGFn
ZXMgdG8gYmUgcGh5c2ljYWxseSBjb250aWd1b3VzLg0KPiBSRE1BIFJlZ2lvbnMgY2FuIGFuZCBk
byBzdXBwb3J0IHZlcnkgbGFyZ2UgcGh5c2ljYWwgcGFnZSBzY2F0dGVyL2dhdGhlciwNCj4gYW5k
IHRoZSBhZGFwdGVyIERNQSdzIHRoZW0gcmVhZGlseS4gSXMgdGhpcyB0aGUgb25seSByZWFzb24/
DQoNCmliX2RtYV9tYXBfcGFnZSB3aWxsIHJldHVybiBhbiBpbnZhbGlkIERNQSBhZGRyZXNzIGZv
ciBhIGJ1ZmZlciBvbiBzdGFjay4gRXZlbiB3b3JzZSwgdGhpcyBpbmNvcnJlY3QgYWRkcmVzcyBj
YW4ndCBiZSBkZXRlY3RlZCBieSBpYl9kbWFfbWFwcGluZ19lcnJvci4gU2VuZGluZyBkYXRhIGZy
b20gdGhpcyBhZGRyZXNzIHRvIGhhcmR3YXJlIHdpbGwgbm90IGZhaWwsIGJ1dCB0aGUgcmVtb3Rl
IHBlZXIgd2lsbCBnZXQganVuayBkYXRhLg0KDQpJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIGFzIHN0
YWNrIGlzIGR5bmFtaWMgYW5kIGNhbiBzaHJpbmsgYXMgSS9PIHByb2NlZWRzLCBzbyB0aGUgYnVm
ZmVyIGlzIGdvbmUuIE90aGVyIGtlcm5lbCBjb2RlIHVzZSBvbmx5IGRhdGEgb24gdGhlIGhlYXAg
Zm9yIERNQSwgZS5nLiBCTEsvU0NTSSBsYXllciBuZXZlciB1c2UgYnVmZmVyIG9uIHRoZSBzdGFj
ayB0byBzZW5kIGRhdGEuDQoNCj4gDQo+IFRvbS4NCg==
