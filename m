Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-472497-1522183297-2-4745719768773781505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522183297; b=Q0BX+zvHK1xkH8qtZ24HCABm4kKXFFVUZuOc/hd3AXC2RRA
    8f5k1wlY+f6fCCoE7fIwzsqDjYU38NTaHKPhOdC7gmNAtWmVNeDX5msH2UNcXKQP
    dr05g0bgKII9zkYwCpIC6MnkHTwqk2rU8AZBWwyCdGl5qV6IuCgmH0vnZiUId5jJ
    XF8U6aPMQadweIIW8OecARqrGFuPXiqTFlichaP2yh8KiSBF4Bip0F6m+wo61FII
    W5s8DVY8Q6WWzygcMeVljimPG8Z0I3/rObJY+T+OTKSvYsMaF4j6jYsauUnGdCxX
    Gu9IHICpLLRpomXrlYE8b4XhoTJRmO9FxqKUuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1522183297; bh=AYZeYcUqOS10yyzPRlZskkbEPf9Lh4iPnaHkCo
    UNSEw=; b=cbmWdVorVj5yHTxqeK9hUbmISHdNCLXaHNg383LO4oLWbp0Ihcybnj
    NdiwvCTdleWtPtjmI6pvMKOdYHi8J9yw/RK2ITJed5bSZo4ah03k37Y4LcUvB3Ww
    lr3xqH36JeQ7J4WAbUKcroedEmZ4t3vYjg8kiAd5bE1vESF3kDgcIWJLsLnseHD2
    +FHoXWrK37/HVqnbAXJ6VTKN8ob9RjBTZLjmygXyx+0bbgQo0mnJg+TrjBxhg0B6
    AdvCNbgz7UmNourtNtsHMwTBbPDmuPp40UaiZy24UQ4Vrf0cszhAIGZafEJCog8E
    46uDa1b8MDeIFiJul0VbpyivWSt6t5eg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFjUELeoeJjyTrQNro/r9oA4fOPeGzwgaPiFzjJ3d32wBirF4n3ynRUMBz0u8qB8WsALd/9hc4gjvnnXw8TSPJxmaXAuCYNFay6kKz1szo/1JMadPl06
    g1X8blhi9fvpMcNNbTGyG7BYj/HbSTacIxLAsWstBjvW7OoiR0DAhpAE/toexT2FsTReqZ+U7P2DkHS+TcAf1VocYiYOuCPePpC0KPFI0KwbEmeThBNfbrSQ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=-QivDyp7SNMA:10 a=F3kEEn-mzN4A:10
    a=4ryF5tWLDgoA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10
    a=QDZ4HvhdkI4A:10 a=PAMlk8q3h9qyen7Q6kwA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeC0UlF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 16:41:05 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:28046 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeC0UlE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 16:41:04 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "dan.rue@linaro.org" <dan.rue@linaro.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "lious.lilei@hisilicon.com" <lious.lilei@hisilicon.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 4.4 20/43] mm/vmalloc: add interfaces to free unmapped
 page table
Thread-Topic: [PATCH 4.4 20/43] mm/vmalloc: add interfaces to free unmapped
 page table
Thread-Index: AQHTxejJnWYIqchHYkKAUWneqflDN6PkhU4AgAAEDQCAAAKOgA==
Date: Tue, 27 Mar 2018 20:40:56 +0000
Message-ID: <1522183239.2693.240.camel@hpe.com>
References: <20180327162716.407986916@linuxfoundation.org>
         <20180327162717.580646019@linuxfoundation.org>
         <20180327201700.xmgzgqox3sz3z32r@xps> <20180327203130.GA18921@localhost>
In-Reply-To: <20180327203130.GA18921@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0427;7:Dui0ZtrvTmDaD7xLVs/qmjByVwyxifTqQJIQfT75l+vUNy9S786mIwdstqFn6zyrb92n8NwtsMhES7rxs1fY6peJIu5XuVIfQf8VLFG4KQj+3VxOLrTHKssmVAyC/r9u695K5Xj9rHTW4PW0geIoLgFc2gp5DiKCRfuKsEM6WJsNZXK4B2K4Sy8c4tBhYt0mIAH8WyPzJGeOi+Qb4iwn2Hkjc7Y+gidLhuFuh141Rc5Q95UKdgZzanjIHe+pDtxh
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4aab7830-df61-4cff-810f-08d594230ae6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0427;
x-ms-traffictypediagnostic: DF4PR8401MB0427:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <DF4PR8401MB04276B7F7AD782BFF3E11CE782AC0@DF4PR8401MB0427.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(155532106045638);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DF4PR8401MB0427;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0427;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(377424004)(8936002)(478600001)(53936002)(229853002)(86362001)(97736004)(81166006)(6246003)(39060400002)(8676002)(81156014)(36756003)(3280700002)(486005)(486005)(66066001)(6486002)(105586002)(2906002)(25786009)(4326008)(6436002)(68736007)(103116003)(3660700001)(7736002)(14454004)(6512007)(6116002)(3846002)(93886005)(5660300001)(106356001)(7416002)(6506007)(5250100002)(54906003)(186003)(99286004)(305945005)(26005)(2900100001)(476003)(316002)(76176011)(446003)(11346002)(102836004)(110136005)(2616005)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0427;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: /Vx129bcDkUm9Si9WxEAWf7B9s9PbZSHiyfHilzeFX1VdzjfnuXNq0WznOhIyBMcvXhnGIOC5BAkOWVBv+4io9cQuZG7KEaqAbOqSlllQJxgIykf0ED1+2aFCVgNUppqnbt3/WUR9QnMrLUWJDtoAuZ88l7RCj1DUb0gaNVERWDHNp+mOnHozy47y9juAJh/Kpdes7uEaS8m5nqcxNQEoxW0217J6SvEIb/ArhZZq74mczzqBfYMSFtmQo5279WhOaXNljzYZiUuCjFylkfgBdBsR851q8+BDm4TT8zGGnpaKTYv3TIv3lc8hf3XZaBpv1zajCUJc2+vkTv7YJF5Gg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B7159EA4D81F34B9E57922E4D8B0ADA@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aab7830-df61-4cff-810f-08d594230ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 20:40:56.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0427
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVHVlLCAyMDE4LTAzLTI3IGF0IDEzOjMxIC0wNzAwLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90
ZToNCj4gT24gVHVlLCBNYXIgMjcsIDIwMTggYXQgMDM6MTc6MDBQTSAtMDUwMCwgRGFuIFJ1ZSB3
cm90ZToNCj4gPiBPbiBUdWUsIE1hciAyNywgMjAxOCBhdCAwNjoyNzoyNFBNICswMjAwLCBHcmVn
IEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+ID4gPiA0LjQtc3RhYmxlIHJldmlldyBwYXRjaC4gIElm
IGFueW9uZSBoYXMgYW55IG9iamVjdGlvbnMsIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gPiA+IA0K
IDoNCj4gPiANCj4gPiBUaGlzIHBhdGNoIGNhdXNlcyB0aGUgZm9sbG93aW5nIGJ1aWxkIGVycm9y
IG9uIDQuNCBhcm02NDoNCj4gPiANCj4gPiAkIG1ha2UgQVJDSD1hcm02NCBDUk9TU19DT01QSUxF
PWFhcmNoNjQtbGludXgtZ251LSBPPWJ1aWxkLWFybTY0IGRlZmNvbmZpZw0KPiA+ICQgbWFrZSBB
UkNIPWFybTY0IENST1NTX0NPTVBJTEU9YWFyY2g2NC1saW51eC1nbnUtIE89YnVpbGQtYXJtNjQN
Cj4gPiANCj4gPiAgIENDICAgICAgYXJjaC9hcm02NC9tbS9tbXUubw0KPiA+IC4uL2FyY2gvYXJt
NjQvbW0vbW11LmM6NzAxOjU6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCYcHVkX2ZyZWVfcG1k
X3BhZ2XigJkNCj4gPiAgaW50IHB1ZF9mcmVlX3BtZF9wYWdlKHB1ZF90ICpwdWQpDQo+ID4gICAg
ICBefn5+fn5+fn5+fn5+fn5+fg0KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi9hcmNoL2Fy
bTY0L2luY2x1ZGUvYXNtL3BndGFibGUuaDo2ODI6MCwNCj4gPiAgICAgICAgICAgICAgICAgIGZy
b20gLi4vaW5jbHVkZS9saW51eC9tbS5oOjU1LA0KPiA+ICAgICAgICAgICAgICAgICAgZnJvbSAu
Li9pbmNsdWRlL2xpbnV4L21tYW4uaDo0LA0KPiA+ICAgICAgICAgICAgICAgICAgZnJvbSAuLi9h
cmNoL2FybTY0L21tL21tdS5jOjI1Og0KPiA+IC4uL2luY2x1ZGUvYXNtLWdlbmVyaWMvcGd0YWJs
ZS5oOjc3NzoxOTogbm90ZTogcHJldmlvdXMgZGVmaW5pdGlvbiBvZiDigJhwdWRfZnJlZV9wbWRf
cGFnZeKAmSB3YXMgaGVyZQ0KPiA+ICBzdGF0aWMgaW5saW5lIGludCBwdWRfZnJlZV9wbWRfcGFn
ZShwdWRfdCAqcHVkKQ0KPiA+ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fg0K
PiA+IC4uL2FyY2gvYXJtNjQvbW0vbW11LmM6NzA2OjU6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg
4oCYcG1kX2ZyZWVfcHRlX3BhZ2XigJkNCj4gPiAgaW50IHBtZF9mcmVlX3B0ZV9wYWdlKHBtZF90
ICpwbWQpDQo+ID4gICAgICBefn5+fn5+fn5+fn5+fn5+fg0KPiA+IEluIGZpbGUgaW5jbHVkZWQg
ZnJvbSAuLi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3BndGFibGUuaDo2ODI6MCwNCj4gPiAgICAg
ICAgICAgICAgICAgIGZyb20gLi4vaW5jbHVkZS9saW51eC9tbS5oOjU1LA0KPiA+ICAgICAgICAg
ICAgICAgICAgZnJvbSAuLi9pbmNsdWRlL2xpbnV4L21tYW4uaDo0LA0KPiA+ICAgICAgICAgICAg
ICAgICAgZnJvbSAuLi9hcmNoL2FybTY0L21tL21tdS5jOjI1Og0KPiA+IC4uL2luY2x1ZGUvYXNt
LWdlbmVyaWMvcGd0YWJsZS5oOjc4MToxOTogbm90ZTogcHJldmlvdXMgZGVmaW5pdGlvbiBvZiDi
gJhwbWRfZnJlZV9wdGVfcGFnZeKAmSB3YXMgaGVyZQ0KPiA+ICBzdGF0aWMgaW5saW5lIGludCBw
bWRfZnJlZV9wdGVfcGFnZShwbWRfdCAqcG1kKQ0KPiA+ICAgICAgICAgICAgICAgICAgICBefn5+
fn5+fn5+fn5+fn5+fg0KPiA+IG1ha2VbMl06ICoqKiBbLi4vc2NyaXB0cy9NYWtlZmlsZS5idWls
ZDoyNzA6IGFyY2gvYXJtNjQvbW0vbW11Lm9dIEVycm9yIDENCj4gPiBtYWtlWzFdOiAqKiogWy9o
b21lL2RydWUvc3JjL2xpbnV4LzQuNC1yYy9NYWtlZmlsZTo5Njk6IGFyY2gvYXJtNjQvbW1dIEVy
cm9yIDINCj4gPiBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL2hvbWUvZHJ1ZS9zcmMvbGlu
dXgvNC40LXJjL2J1aWxkLWFybTY0Jw0KPiA+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MTUyOiBzdWIt
bWFrZV0gRXJyb3IgMg0KPiA+IA0KPiA+IA0KPiANCj4gQm90aCBvZiBteSBhcm02NCBkZXZpY2Vz
IGJ1aWx0IGZpbmUgd2l0aCB0aGlzIHBhdGNoLi4uIEl0IHNlZW1zIGxpa2UNCj4gdGhlIG9ubHkg
d2F5IHRvIGhpdCB0aGF0IGVycm9yIGlzIGlmIEhBVkVfQVJDSF9IVUdFX1ZNQVAgaXNuJ3Qgc2V0
LA0KPiB3aGljaCBzZWVtcyBpbXBvc3NpYmxlIHNpbmNlIGl0IGlzIHNlbGVjdGVkIGJ5IEFSTTY0
Li4uDQo+IA0KPiBTb21lb25lIHNtYXJ0ZXIgdGhhbiBJIG1pZ2h0IGhhdmUgbW9yZSBpbnNpZ2h0
IGJ1dCB0aGlzIHBhdGNoIGlzDQo+IHVuY2hhbmdlZCBmcm9tIHVwc3RyZWFtIHNvIEkgY2FuIG9u
bHkgYXNzdW1lIHRoYXQgdGhpcyBlcnJvciB3b3VsZA0KPiBtYW5pZmVzdCB0aGVyZSBhcyB3ZWxs
Lg0KDQpJdCBhcHBlYXJzIHRoYXQgSEFWRV9BUkNIX0hVR0VfVk1BUCB3YXMgaW50cm9kdWNlZCBp
biA0LjYgb24gYXJtNjQuIA0KSGVuY2UgdGhlIHByb2JsZW0gaW4gNC40Lg0KDQpUaGFua3MsDQot
VG9zaGkNCg0K
