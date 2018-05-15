Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2900152-1526402075-2-16252435686214853033
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526402074; b=XegWBJTS2vctk0M9e22D/vF9C6VZokOgxFxlZMSy3NGlT+xJUK
    irQt89sFAsUjclVKsENoDGt//PM3k9ui/NJcg0Jk0uEgyUi+gZYqdy7j9fPzl6D1
    U2J1U7ATqrsERhIL5607mIVyUPtGqSr6QR5pDk6fhvrfst37CgK+HD2R6evDpoXL
    Yr2JmywBqbdRpqJdOlDWECTjg9O8Xeb1soGfIhbHw+h+fHzqI3j8hX2tv4J9vvO3
    8R7K8SJlGGFLeuV3D8MXH/GgNmP1iMEIhEpELdYMhvcZEbAAGOkEF23timmn7Urh
    0AbJS0hscM+HBuyJ3BgrbluxS+oRdnGdOWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1526402074; bh=PHkHv3dQYXCaXYIZ+9R6/ZwXmfPsLvWfMK/BQ3Idr/c=; b=
    h9maifjoc1X2Ni2KlI+A1HoBHWoHx3atR9agYdCqF501ikkCboeJU59fh2tPMRAh
    8YdNmBoZEzVAP426GFKu1Lu73MR4Q/bhDkCXH7g+TTemxp5PAJoAGyEe5op4tCn5
    xSmBMjHrr40THYyYyckeoRqii3ctietchIin+/xfofpcP0O+wMYFuORpQkAgPCAO
    QoEJqcsXmhSkwO3zKv6Cts3O+vncabd7f2gkt0MpzuoTLGhOTCpC2b2+flrF8f9T
    MR59xF9Ba3YN0iW0nlHo1tur2MTtmZ77G5g3Vaop/Bt9rBKzEx7+Dkab7s89lw+9
    rAFkXFXTCnnzuAZ1FTxIZQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPazCquC/5yCkBrXdZ79EzuBwwcA64EjkA410KtRlRsZtGJYA00gRF+VDHt2A/0KjNAu7qapT/3HQpdTNjDrmYXLCPdKjivSfUt8Pt8OGOwCs6zKzrrN
    zK0X2Ssy7oQZ6j+82/hYauiUuLq0PUG1Zxpe8UuQE2lYxdLB7MOfyqZxfAJIA0bH49xefwIJ4WwdjDoY+vA+SDBHmTULVxpTqH1HJcE6sCKTI46qpkhwsD85
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=-QivDyp7SNMA:10 a=F3kEEn-mzN4A:10
    a=Q-w0y_TIGQ4A:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=QDZ4HvhdkI4A:10 a=CGXWiVzC7ngFntcVC5UA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeEOQec (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 12:34:32 -0400
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:19338 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbeEOQe2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 12:34:28 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "joro@8bytes.org" <joro@8bytes.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] x86/mm: add TLB purge to free pmd/pte page interfaces
Thread-Topic: [PATCH 2/3] x86/mm: add TLB purge to free pmd/pte page
 interfaces
Thread-Index: AQHT4K0zgm5y8x8aI0ixjt8+V5QJuaQw6kyAgAApL4A=
Date: Tue, 15 May 2018 16:34:24 +0000
Message-ID: <1526401993.2693.605.camel@hpe.com>
References: <20180430175925.2657-1-toshi.kani@hpe.com>
         <20180430175925.2657-3-toshi.kani@hpe.com>
         <20180515140549.GE18595@8bytes.org>
In-Reply-To: <20180515140549.GE18595@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1268;7:Kgjf6nRbnBNn45wc5S812846sP8fgR7GAW9XcXPgO//uyr00Fzuqcg0hrpULvlA4VNcg8YC7TTDhPGfxq8bawyL9e34W5davfWWSzrAx9DphDId0z1HREcE+BymNRM1xi+eRLea1uUBEd96R+WNb7ba6JHbRDSZ9Ewxd5lHN5vi0f8DtXjIjZ1iE4iyDxKnA4To0uifKMf0/cRTXYNzJKd67380ym3H//YPsDJsA4pSY47+NTOdNS4aDEQHOFqzl
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1268;
x-ms-traffictypediagnostic: AT5PR8401MB1268:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB12680340CB34F344E42CE8D582930@AT5PR8401MB1268.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AT5PR8401MB1268;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1268;
x-forefront-prvs: 0673F5BE31
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(189003)(199004)(377424004)(26005)(6486002)(25786009)(305945005)(5640700003)(6436002)(59450400001)(6506007)(2900100001)(2501003)(7736002)(66066001)(102836004)(14454004)(11346002)(6246003)(97736004)(5250100002)(3280700002)(3660700001)(103116003)(6116002)(6916009)(53936002)(186003)(3846002)(446003)(229853002)(7416002)(99286004)(68736007)(86362001)(4326008)(8676002)(1730700003)(316002)(486006)(5660300001)(54906003)(8936002)(81156014)(81166006)(6512007)(478600001)(36756003)(106356001)(2351001)(2616005)(76176011)(2906002)(476003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1268;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oqCu+Gvi8cncIBYhV5N2nQy5S760UUzsyReH6Z7QCG7ageVg/iMcUEiDsY/KCRPv30iYX57RvMppyRXN/iQe1r+tMbeNpDHggBq071yFhO9YvqcLQDqdrGxTjmnwfuoZqwB//j4jzWPvlu+SauxfRgQ2T9xBudWpSrpOIRaovTIjZQ7AKIfUnsCrv64ltnv3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <680043A3F4C61F41930C5FFC82921F1F@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cc11d9e3-f9eb-4878-8d88-08d5ba81b7ef
X-MS-Exchange-CrossTenant-Network-Message-Id: cc11d9e3-f9eb-4878-8d88-08d5ba81b7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2018 16:34:24.1176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1268
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVHVlLCAyMDE4LTA1LTE1IGF0IDE2OjA1ICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
IE9uIE1vbiwgQXByIDMwLCAyMDE4IGF0IDExOjU5OjI0QU0gLTA2MDAsIFRvc2hpIEthbmkgd3Jv
dGU6DQo+ID4gIGludCBwdWRfZnJlZV9wbWRfcGFnZShwdWRfdCAqcHVkLCB1bnNpZ25lZCBsb25n
IGFkZHIpDQo+ID4gIHsNCj4gPiAtCXBtZF90ICpwbWQ7DQo+ID4gKwlwbWRfdCAqcG1kLCAqcG1k
X3N2Ow0KPiA+ICsJcHRlX3QgKnB0ZTsNCj4gPiAgCWludCBpOw0KPiA+ICANCj4gPiAgCWlmIChw
dWRfbm9uZSgqcHVkKSkNCj4gPiAgCQlyZXR1cm4gMTsNCj4gPiAgDQo+ID4gIAlwbWQgPSAocG1k
X3QgKilwdWRfcGFnZV92YWRkcigqcHVkKTsNCj4gPiArCXBtZF9zdiA9IChwbWRfdCAqKV9fZ2V0
X2ZyZWVfcGFnZShHRlBfS0VSTkVMKTsNCj4gDQo+IFNvIHlvdSBuZWVkIHRvIGFsbG9jYXRlIGEg
cGFnZSB0byBmcmVlIGEgcGFnZT8gSXQgaXMgYmV0dGVyIHRvIHB1dCB0aGUNCj4gcGFnZXMgaW50
byBhIGxpc3Qgd2l0aCBhIGxpc3RfaGVhZCBvbiB0aGUgc3RhY2suDQoNClRoZSBjb2RlIHNob3Vs
ZCBoYXZlIGNoZWNrZWQgaWYgcG1kX3N2IGlzIE5VTEwuLi4gIEkgd2lsbCB1cGRhdGUgdGhlDQpw
YXRjaC4NCg0KRm9yIHBlcmZvcm1hbmNlLCBJIGRvIG5vdCB0aGluayB0aGlzIHBhZ2UgYWxsb2Mg
aXMgYSBwcm9ibGVtLiAgVW5saWtlDQpwbWRfZnJlZV9wdGVfcGFnZSgpLCBwdWRfZnJlZV9wbWRf
cGFnZSgpIGNvdmVycyBhbiBleHRyZW1lbHkgcmFyZSBjYXNlLiANCiAgU2luY2UgcHVkIHJlcXVp
cmVzIDFHQi1hbGlnbm1lbnQsIHB1ZCBhbmQgcG1kL3B0ZSBtYXBwaW5ncyBkbyBub3QNCnNoYXJl
IHRoZSBzYW1lIHJhbmdlcyB3aXRoaW4gdGhlIHZtYWxsb2Mgc3BhY2UuICBJIGhhZCB0byBpbnN0
cnVtZW50IHRoZQ0Ka2VybmVsIHRvIGZvcmNlIHRoZW0gc2hhcmUgdGhlIHNhbWUgcmFuZ2VzIGlu
IG9yZGVyIHRvIHRlc3QgdGhpcyBwYXRjaC4NCg0KPiBJIGFtIHN0aWxsIG9uIGZhdm91ciBvZiBq
dXN0IHJldmVydGluZyB0aGUgYnJva2VuIGNvbW1pdCBhbmQgZG8gYQ0KPiBjb3JyZWN0IGFuZCB3
b3JraW5nIGZpeCBmb3IgdGhlL2EgbWVyZ2Ugd2luZG93Lg0KDQpJIHdpbGwgcmVvcmRlciB0aGUg
cGF0Y2ggc2VyaWVzLCBhbmQgY2hhbmdlIHBhdGNoIDMvMyB0byAxLzMgc28gdGhhdCB3ZQ0KY2Fu
IHRha2UgaXQgZmlyc3QgdG8gZml4IHRoZSBCVUdfT04gb24gUEFFLiAgVGhpcyByZXZlcnQgd2ls
bCBkaXNhYmxlDQoyTUIgaW9yZW1hcCBvbiBQQUUgaW4gc29tZSBjYXNlcywgYnV0IEkgZG8gbm90
IHRoaW5rIGl0J3MgaW1wb3J0YW50IG9uDQpQQUUgYW55d2F5Lg0KDQpJIGRvIG5vdCB0aGluayBy
ZXZlcnQgb24geDg2LzY0IGlzIG5lY2Vzc2FyeSBhbmQgSSBhbSBtb3JlIHdvcnJpZWQgYWJvdXQN
CmRpc2FibGluZyAyTUIgaW9yZW1hcCBpbiBzb21lIGNhc2VzLCB3aGljaCBjYW4gYmUgc2VlbiBh
cyBkZWdyYWRhdGlvbi4gDQpQYXRjaCAyLzMgZml4ZXMgYSBwb3NzaWJsZSBwYWdlLWRpcmVjdG9y
eSBjYWNoZSBpc3N1ZSB0aGF0IEkgY2Fubm90IGhpdA0KZXZlbiB0aG91Z2ggSSBwdXQgaW9yZW1h
cC9pb3VubWFwIHdpdGggdmFyaW91cyBzaXplcyBpbnRvIGEgdGlnaHQgbG9vcA0KZm9yIGEgZGF5
Lg0KDQpUaGFua3MsDQotVG9zaGkNCg==
