Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2827469-1524759704-2-15010703789800122520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524759703; b=ivCSGsPVSU315OtmaW0fn0rAzd9x8lLKiTMPk+ldS1Y7Y0CkCB
    bznNxzuucRNZ1aPCnIngdtfAADb/JOJFlXkl0zJQoz6jvLOd1Bf2rIBhXOMLO16H
    Irjq7nOJgMU9wO56OmdzdwxcK5TXcVNwtpdmV0mQRzrDtcQc/kpyDwIFEF7woJ+C
    MynQE6Fuqs6tHOBxFRcxKmf3CSE9QjP0pAsjh7MC62IG2yh2Xx6tdjbCWk1v/Dwr
    09xyFS4VLEsP1xeHoVGqTK3JjtXWgYbPRKDqyvyDNI1zuMrBr+glEvI4gtMIm5Fp
    clTjFyMVMBjoE8fi1RIBKCffhjoW/WuM4G9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1524759703; bh=Cs+m1HVUy/S1B/Rdw+fKlGB/gNS5Ln4uqWahDLKr+U8=; b=
    LNZxwhD3wft0EgF6sISFsYsIg2A+IQsoPD4DG6awUYZRcOrm4hRx12VGzKahBc+T
    YJt62ReBv9HDtibStMZ8Lkz5TJsEG7bUWYZdf8VlruDA4Gwh9nvtExNW/P7MohtD
    45GBTYsz/sDqh6NvIKwJfV2DYLp1OXRyhFKEE38yMFwWVhZDozr7qT8ZKhBNBMqc
    aW53ZXTxIK4EGKt1QV0M1Wa8h/0+O1d6sQw08rk2fgI50ENmPXqgoPBPdCWpchpc
    3Au9X+dQjKdUg0X21pT0+qf0qyt6ksiogWvMl9mhTl4XyjoXXbsvGWA0JgXLfYnb
    vnwusX7uKI/OTtPO3WYvbQ==
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
X-CM-Envelope: MS4wfFG8bYTchvKvUaK/9u8b05OpuI/tiUvFgDGtFHdcuM+qa/HJJ5QIC7JSzlJaLOLpJuNkzDbRtq3iQ6+j4FQD7qp5Rb0h2+m7KKdiNYoEgB0cBEn9DhBW
    wWaussWSAcqa6tkIaTTLH45GlNaP4BxA5YcV/0RylHkKKkIQTq4e1IJa9gmbmPJ6KU3n1bTKU0dpGSK9vnUWJsIlvDDkpS+m+tAmtm4pm989s6ZJEySmUMHz
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VtQtJH8w3oYA:10 a=hkdB2cgs02UA:10
    a=A3aqUMXqizAA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=QDZ4HvhdkI4A:10 a=9ks1SlOOdPw7evV3AhIA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756787AbeDZQV3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 12:21:29 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:31935 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756750AbeDZQVZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 12:21:25 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "joro@8bytes.org" <joro@8bytes.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Thread-Topic: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Thread-Index: AQHTu76cmkz1ie7mb0G/9GXlGHy7daQTW6wAgAAh0oA=
Date: Thu, 26 Apr 2018 16:21:19 +0000
Message-ID: <1524759629.2693.465.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
         <20180314180155.19492-3-toshi.kani@hpe.com>
         <20180426141926.GN15462@8bytes.org>
In-Reply-To: <20180426141926.GN15462@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0532;7:oY62O00fviAKUy5X8pehvOX4TxxIiGW023p4SOVhQruwPvniIVM4a7dTEAaal6QetsiMMdWTO6ar01nzq1X4YvFdWZbK0oIPtxEaRb53UZ6rF/R9VkQDgk2Q7VgrRoaMkJE/KFW4OR0IU6kMhA/S++XwwnOzqzBZpC7pkb0zdkR9CBzV6uhM3EHv5JcrpMT9uaiH61tCRWPg+yY4Yugz4DEckqjRhEjhlOd1RzA5MtsCtGywC8OfGUap7XyHZEzw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0532;
x-ms-traffictypediagnostic: AT5PR8401MB0532:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB053210898B418DA707EE3D68828E0@AT5PR8401MB0532.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AT5PR8401MB0532;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0532;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39380400002)(376002)(39860400002)(396003)(377424004)(189003)(199004)(99286004)(2501003)(6512007)(229853002)(103116003)(5250100002)(2351001)(6246003)(3280700002)(3660700001)(6436002)(54906003)(476003)(3846002)(2906002)(486006)(86362001)(97736004)(5640700003)(68736007)(2616005)(478600001)(2900100001)(6116002)(11346002)(14454004)(446003)(7416002)(76176011)(53936002)(5660300001)(6916009)(305945005)(6506007)(105586002)(26005)(106356001)(6486002)(36756003)(4326008)(7736002)(8936002)(316002)(102836004)(25786009)(186003)(81156014)(66066001)(1730700003)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0532;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jaAmclr4l91cSvV0xPqZQ8neegKn7bfPiejrjTqw00V47MOdF7rt6OQSlYdhoK/YdSN08vOjYRnfu6fONC8v/vE8faDv62r9COSf+pM9kNGFO78eTNTXmsmLY0NdLdPIWwwdoWb8CCCqo8w2dNc9AvEIrPXhv8czwVTPTghQK6R+3wtPEO4ob+pwx1mFn0kf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8BF7B687565FC47954EFC81C3D22EE6@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d87ddf17-6662-4d44-9574-08d5ab91be75
X-MS-Exchange-CrossTenant-Network-Message-Id: d87ddf17-6662-4d44-9574-08d5ab91be75
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 16:21:19.5546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0532
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTI2IGF0IDE2OjE5ICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
IEhpIFRvc2hpLCBBbmRyZXcsDQo+IA0KPiB0aGlzIHBhdGNoKC1zZXQpIGlzIGJyb2tlbiBpbiBz
ZXZlcmFsIHdheXMsIHBsZWFzZSBzZWUgYmVsb3cuDQo+IA0KPiBPbiBXZWQsIE1hciAxNCwgMjAx
OCBhdCAxMjowMTo1NVBNIC0wNjAwLCBUb3NoaSBLYW5pIHdyb3RlOg0KPiA+IEltcGxlbWVudCBw
dWRfZnJlZV9wbWRfcGFnZSgpIGFuZCBwbWRfZnJlZV9wdGVfcGFnZSgpIG9uIHg4Niwgd2hpY2gN
Cj4gPiBjbGVhciBhIGdpdmVuIHB1ZC9wbWQgZW50cnkgYW5kIGZyZWUgdXAgbG93ZXIgbGV2ZWwg
cGFnZSB0YWJsZShzKS4NCj4gPiBBZGRyZXNzIHJhbmdlIGFzc29jaWF0ZWQgd2l0aCB0aGUgcHVk
L3BtZCBlbnRyeSBtdXN0IGhhdmUgYmVlbiBwdXJnZWQNCj4gPiBieSBJTlZMUEcuDQo+IA0KPiBB
biBJTlZMUEcgYmVmb3JlIGFjdHVhbGx5IHVubWFwcGluZyB0aGUgcGFnZSBpcyB1c2VsZXNzLCBh
cyBvdGhlciBjb3Jlcw0KPiBvciBldmVuIHNwZWN1bGF0aXZlIGluc3RydWN0aW9uIGV4ZWN1dGlv
biBjYW4gYnJpbmcgdGhlIFRMQiBlbnRyeSBiYWNrDQo+IGJlZm9yZSB0aGUgY29kZSBhY3R1YWxs
eSB1bm1hcHMgdGhlIHBhZ2UuDQoNCkhpIEpvZXJnLA0KDQpBbGwgcGFnZXMgdW5kZXIgdGhlIHBt
ZCBoYWQgYmVlbiB1bm1hcHBlZCBhbmQgdGhlbiBsYXp5IFRMQiBwdXJnZWQgd2l0aA0KSU5WTFBH
IGJlZm9yZSBjb21pbmcgdG8gdGhpcyBjb2RlIHBhdGguICBTcGVjdWxhdGlvbiBpcyBub3QgYWxs
b3dlZCB0bw0KcGFnZXMgd2l0aG91dCBtYXBwaW5nLiAgDQoNCj4gPiAgaW50IHB1ZF9mcmVlX3Bt
ZF9wYWdlKHB1ZF90ICpwdWQpDQo+ID4gIHsNCj4gPiAtCXJldHVybiBwdWRfbm9uZSgqcHVkKTsN
Cj4gPiArCXBtZF90ICpwbWQ7DQo+ID4gKwlpbnQgaTsNCj4gPiArDQo+ID4gKwlpZiAocHVkX25v
bmUoKnB1ZCkpDQo+ID4gKwkJcmV0dXJuIDE7DQo+ID4gKw0KPiA+ICsJcG1kID0gKHBtZF90ICop
cHVkX3BhZ2VfdmFkZHIoKnB1ZCk7DQo+ID4gKw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IFBUUlNf
UEVSX1BNRDsgaSsrKQ0KPiA+ICsJCWlmICghcG1kX2ZyZWVfcHRlX3BhZ2UoJnBtZFtpXSkpDQo+
ID4gKwkJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCXB1ZF9jbGVhcihwdWQpOw0KPiANCj4gVExC
IGZsdXNoIG5lZWRlZCBoZXJlLCBiZWZvcmUgdGhlIHBhZ2UgaXMgZnJlZWQuDQo+IA0KPiA+ICsJ
ZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKXBtZCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDE7DQo+
ID4gIH0NCj4gPiAgDQo+ID4gIC8qKg0KPiA+IEBAIC03MjQsNiArNzM5LDE1IEBAIGludCBwdWRf
ZnJlZV9wbWRfcGFnZShwdWRfdCAqcHVkKQ0KPiA+ICAgKi8NCj4gPiAgaW50IHBtZF9mcmVlX3B0
ZV9wYWdlKHBtZF90ICpwbWQpDQo+ID4gIHsNCj4gPiAtCXJldHVybiBwbWRfbm9uZSgqcG1kKTsN
Cj4gPiArCXB0ZV90ICpwdGU7DQo+ID4gKw0KPiA+ICsJaWYgKHBtZF9ub25lKCpwbWQpKQ0KPiA+
ICsJCXJldHVybiAxOw0KPiA+ICsNCj4gPiArCXB0ZSA9IChwdGVfdCAqKXBtZF9wYWdlX3ZhZGRy
KCpwbWQpOw0KPiA+ICsJcG1kX2NsZWFyKHBtZCk7DQo+IA0KPiBTYW1lIGhlcmUsIFRMQiBmbHVz
aCBuZWVkZWQuDQo+IA0KPiBGdXJ0aGVyIHRoaXMgbmVlZHMgc3luY2hyb25pemF0aW9uIHdpdGgg
b3RoZXIgcGFnZS10YWJsZXMgaW4gdGhlIHN5c3RlbQ0KPiB3aGVuIHRoZSBrZXJuZWwgUE1EcyBh
cmUgbm90IHNoYXJlZCBiZXR3ZWVuIHByb2Nlc3Nlcy4gSW4geDg2LTMyIHdpdGgNCj4gUEFFIHRo
aXMgY2F1c2VzIGEgQlVHX09OKCkgYmVpbmcgdHJpZ2dlcmVkIGF0IGFyY2gveDg2L21tL2ZhdWx0
LmM6MjY4DQo+IGJlY2F1c2UgdGhlIHBhZ2UtdGFibGVzIGFyZSBub3QgY29ycmVjdGx5IHN5bmNo
cm9uaXplZC4NCg0KSSB0aGluayB0aGlzIGlzIGFuIGlzc3VlIHdpdGggcG1kIG1hcHBpbmcgc3Vw
cG9ydCBvbiB4ODYtMzItUEFFLCBub3QNCndpdGggdGhpcyBwYXRjaC4gIEkgdGhpbmsgdGhlIGNv
ZGUgbmVlZGVkIHRvIGJlIHVwZGF0ZWQgdG8gc3luYyBhdCB0aGUNCnB1ZCBsZXZlbC4NCg0KVGhh
bmtzLA0KLVRvc2hpDQo=
