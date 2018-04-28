Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2435290-1524948893-2-10256787487806365294
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
    1524948892; b=DXkKqT0g7wDOW8CmeMcHY0oTOFaSSlYmsKtKACTw4buaepBtTS
    dBihfnP9+su43d2RpQlTwM1QlwCl8V2MX3lVYjCKU2gar+6qxWx7cFgQvAUc+71L
    DfmbcIXqhaCjXpq6VScM92km3x18AUYofr3hcmO5U8emh2TMcwkzso0UexpnE0Sy
    +IfzsyV2/lEolGnAuo6yyxv0NpeH9fy7UVqLh0ubH7qq7SRKzN89SOxvlofil0gV
    iqJF3oj7AhzJegN2oGfsSN9yXzm2E2+BQzwTngIL1V2FnMJDudNRX32pOHq8eZmt
    QRkeufv2DqpCMSVzmfeaSNEEN18bPRVRValQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1524948892; bh=MJsrkwGxbEPHb0tF0DTRGM1EewsoRXUKKSnVxvqjVsI=; b=
    e9jTjnkQSpzPhzPOt22P5left0ngRX7q8QyWGqcXeMoGhz3PfmgCaX+hXvam0BQC
    5MwXo8p+P8gzlk/G0ugPecdKD6+iQqhBZQfPssWzrCt3uIwjrPFxBA/tK2D7m10v
    o3DTOXIpoux8hCZ3jLSYOt3rE6JqO5wplh1Qlt/R44E0s8UCbrrYKqyAdgOUGDuz
    aia158vKpRkyy7xn4K51VBXQ0JaUhqp8j8c2ShmV9zbimWfiMZmfx19tWNnJonEc
    PmpX7JDgEIeEIBAfQ9J6pcd/J+oNnjndmncvR2m658NGU8hLPt5ux0wQ7aECPAmn
    MceG04Mft1q3e+4ppbpotA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfEh8PZMBElcDFplq2laRRLgUffSOB6CKKt4hgyiwS71SM6B+MLYz8S29bhRHS0xnN0gkMgyUMiTpkDTCDi2v/7qVykVANDLXBnidpDfNkWZSchQ2j9+D
    Vye3XQv0+s3k++yvSUVsS1dTmdEqYCvXRtVtJc0Nd1SS6Gaic9uul6hicsqc7j8Bf41C2yE1WwnRZMqcvZI3FH2S6ezU72uKylF5lkFZWfISAk+JAsw3WfLQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VtQtJH8w3oYA:10 a=hkdB2cgs02UA:10
    a=A3aqUMXqizAA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=QDZ4HvhdkI4A:10 a=tA7aZXjiAAAA:8 a=_wVPTqdbajV8wyL9XWEA:9 a=QEXdDO2ut3YA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeD1Uyt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 16:54:49 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:27245 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeD1Uys (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Apr 2018 16:54:48 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "joro@8bytes.org" <joro@8bytes.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
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
Thread-Index: AQHTu76cmkz1ie7mb0G/9GXlGHy7daQTW6wAgAAh0oCAABGZAIAABywAgAAmsYCAACedAIAAmRcAgABzlACAATZ9gIAAxs2A
Date: Sat, 28 Apr 2018 20:54:42 +0000
Message-ID: <1524948829.2693.547.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
         <20180314180155.19492-3-toshi.kani@hpe.com>
         <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
         <20180426172327.GQ15462@8bytes.org> <1524764948.2693.478.camel@hpe.com>
         <20180426200737.GS15462@8bytes.org> <1524781764.2693.503.camel@hpe.com>
         <20180427073719.GT15462@8bytes.org> <1524839460.2693.531.camel@hpe.com>
         <20180428090217.n2l3w4vobmtkvz6k@8bytes.org>
In-Reply-To: <20180428090217.n2l3w4vobmtkvz6k@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0642;7:IxbWIgiudHGD0K7I6tDxURTPBpIZS6mb+a8Pl0vvOR96cWJ9RC+ObISlW9kN/gTQ7ATpKgJgdDSvASDrZZ4kPd70/F6ZI4UEd10DIjyf8D3/aJVv8QLYSdDzE56iqCjuBZzIaDOBtJ5kysiBOJsKtOq78LMefMqlz+Hej73txi/+d4/CByCV7bFS0Gf9/PEe1fcGuvRBAnnOv75JDZDtuYy+3opqAIs2549j+YhM1Q/ch3YbffU81x2B2uCwBHZ6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0642;
x-ms-traffictypediagnostic: AT5PR8401MB0642:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB06427E37C562DB70C6610EDE828C0@AT5PR8401MB0642.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AT5PR8401MB0642;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0642;
x-forefront-prvs: 0656A4403B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(377424004)(93886005)(54906003)(186003)(36756003)(316002)(229853002)(6246003)(53936002)(6512007)(6916009)(86362001)(2900100001)(2501003)(99286004)(66066001)(106356001)(5640700003)(5250100002)(6486002)(14454004)(6436002)(486006)(105586002)(76176011)(305945005)(7416002)(446003)(11346002)(102836004)(8936002)(26005)(5660300001)(3660700001)(8676002)(81166006)(1730700003)(81156014)(68736007)(7736002)(3280700002)(2616005)(4326008)(476003)(2906002)(25786009)(6506007)(478600001)(6116002)(3846002)(2351001)(103116003)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0642;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xS6rBWLC+SvLIa5amyMLwx1tL8qgvAT+Rlzs7k94Ss/WFLoo9iL8CQ9EnjBQ/xfjMOiR68jVydsMWiuEuP6+wlcLotJ7LprRRXEyN2TefhJEAHRb/pLvmrOHn7xKs5MDhDwcl/WstLX8p1gD4+eY5qMZXwpV8ydbqaYFHpCAXbpGBUoMMHP4UumUIYNOuCrE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE6C04653E607F4DA2883AEC95039EB8@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 505886b9-760d-4b95-9e97-08d5ad4a441e
X-MS-Exchange-CrossTenant-Network-Message-Id: 505886b9-760d-4b95-9e97-08d5ad4a441e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2018 20:54:42.3944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0642
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gU2F0LCAyMDE4LTA0LTI4IGF0IDExOjAyICswMjAwLCBqb3JvQDhieXRlcy5vcmcgd3JvdGU6
DQo+IE9uIEZyaSwgQXByIDI3LCAyMDE4IGF0IDAyOjMxOjUxUE0gKzAwMDAsIEthbmksIFRvc2hp
IHdyb3RlOg0KPiA+IFNvLCB3ZSBjYW4gYWRkIHRoZSBzdGVwIDIgb24gdG9wIG9mIHRoaXMgcGF0
Y2guDQo+ID4gIDEuIENsZWFyIHB1ZC9wbWQgZW50cnkuDQo+ID4gIDIuIFN5c3RlbSB3aWRlIFRM
QiBmbHVzaCA8LS0gVE8gQkUgQURERUQgQlkgTkVXIFBBVENIDQo+ID4gIDMuIEZyZWUgaXRzIHVu
ZGVybGluaW5nIHBtZC9wdGUgcGFnZS4NCj4gDQo+IFRoaXMgc3RpbGwgbGFja3MgdGhlIHBhZ2Ut
dGFibGUgc3luY2hyb25pemF0aW9uIGFuZCB3aWxsIHRodXMgbm90IGZpeA0KPiB0aGUgQlVHX09O
IGJlaW5nIHRyaWdnZXJlZC4NCg0KVGhlIEJVR19PTiBpc3N1ZSBpcyBzcGVjaWZpYyB0byBQQUUg
dGhhdCBpdCBzeW5jcyBhdCB0aGUgcG1kIGxldmVsLg0KeDg2LzY0IGRvZXMgbm90IGhhdmUgdGhp
cyBpc3N1ZSBzaW5jZSBpdCBzeW5jcyBhdCB0aGUgcGdkIG9yIHA0ZCBsZXZlbC4NCg0KPiA+IFdl
IGRvIG5vdCBuZWVkIHRvIHJldmVydCB0aGlzIHBhdGNoLiAgV2UgY2FuIG1ha2UgdGhlIGFib3Zl
IGNoYW5nZSBJDQo+ID4gbWVudGlvbmVkLg0KPiANCj4gUGxlYXNlIG5vdGUgdGhhdCB3ZSBhcmUg
bm90IGluIHRoZSBtZXJnZSB3aW5kb3cgYW55bW9yZSBhbmQgdGhhdCBhbnkgZml4DQo+IG5lZWRz
IHRvIGJlIHNpbXBsZSBhbmQgb2J2aW91c2x5IGNvcnJlY3QuDQoNClVuZGVyc3Rvb2QuICBDaGFu
Z2luZyB0aGUgeDg2LzMyIHN5bmMgcG9pbnQgaXMgcmlza3kuICBTbywgSSBhbSBnb2luZyB0bw0K
cmV2ZXJ0IHRoZSBmcmVlIHBhZ2UgaGFuZGxpbmcgZm9yIFBBRS4gICANCg0KVGhhbmtzLA0KLVRv
c2hpDQoNCg==
