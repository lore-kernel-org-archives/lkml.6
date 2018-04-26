Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2961956-1524765067-2-7163166380969294946
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
    1524765066; b=DLWuH411cwXxM+v7wizFgjU3hGZ99wL0ybrXolfTkQNsw3B6Zl
    UIFYpPcUWE4RmdBDFAMl6l/9NXNTG0MX8QrRzHTNu/djx1ZcRmzlJQI6B12/bGS0
    4CawlXt5fYs0nC+293XwIfe8VtQRLUq/dcR6VB2uMjxoB+S2roZ+XYoE/r0ma5Hg
    /Xaz1+P+rzHoamC9zsYp5cc9zKpk3KuAfskuQYC/0Fcp9xgg5FR6oGL4ibqQwQP4
    jFeXsZcZtxq9lqYSKxsjwX0PUqqdiUakAHj0EQoj03/zuSqk7TxpNWC0QXqomG1J
    dS/yTkHVniyrZrPsg0rd+BE9puad8uwlkJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1524765066; bh=QLp1baOgXyy499CIZWKT6kRGgII2OhZotVmMEMHfhzQ=; b=
    u8SK6Ih84aOUo4kXvW363NgIVtY+Z8eYJJH/vBKruu1ebM2B0FDSHy5sQ93cD0wj
    TRh9w+6oYiSLjer9QH4BUMPr5E1GQJ6hXHpAbIr2L2Apwa5upvX8DBA8sqIBpPu2
    KDkuPlxd7ow37oNT6KRxuP54XF/Sl2duqgTmYPqS7AsOytobH13MUaiHJkhGzPNs
    q2XyNn6p6uwfzQ5+MMQIxQJbPtFNL109+78z/O/UK5s78Hlvw8bsJURF9C5PlC94
    YYhsXzqYwcUFwwI1TrOme4bxEZAeup0dScW9bzFuI0wEWYpmbr00WY/7BnGw/P0Q
    t8gCSJzDj18I0RVevH3ysw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfE4mVNEH6n4GW4B2ix07hyypaVkoB6SfZpsdF1gUBoLj30hN9D5aPm1UKhmAOEPOpz5zsNMVZr79VYVxLeGqibA0PGWTjWI+UeIQSjMWTQO0qHOGAgud
    2UpJRE/IPt7/EOHcZ6aRpTCWhP7YN4j4tKuBudAAurrkPGBtSOSCPni0gP9X7HDQZP6gkoJqZ0IbOtOMNykKjjmsrGnwmtAG0kvvLolpk5dF8ZItT6pa/i6O
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VtQtJH8w3oYA:10 a=hkdB2cgs02UA:10
    a=A3aqUMXqizAA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=QDZ4HvhdkI4A:10 a=tA7aZXjiAAAA:8 a=2OIiB4FpLrNOMFRTXXMA:9 a=QEXdDO2ut3YA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757002AbeDZRuu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 13:50:50 -0400
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:11310 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756723AbeDZRuq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 13:50:46 -0400
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
Thread-Index: AQHTu76cmkz1ie7mb0G/9GXlGHy7daQTW6wAgAAh0oCAABGZAIAABywA
Date: Thu, 26 Apr 2018 17:49:58 +0000
Message-ID: <1524764948.2693.478.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
         <20180314180155.19492-3-toshi.kani@hpe.com>
         <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
         <20180426172327.GQ15462@8bytes.org>
In-Reply-To: <20180426172327.GQ15462@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0483;7:EVl5aEd+VmsKT8mrVbWqAIPONQ2QMHOFkoiCALydkxKDazGb0w1xxdroKjvYjf6Q8/pmeqzONTGk0z9LIxBQ3QvGotIRSgWSOMtygkWWLywHakqaRFuuV0UvRc6O7YCx23r3OjSg1UFo31qMt7FRVypA357iOs+3d+RKfqhSakxtH3DqHbOacYl1Y4/t2rip/ob0XkA2h2TdkKe/TX0CoHSWXlU5Dx2FS1LArpxcHPmvvoAM7XVh0Ur8ci03LJre
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0483;
x-ms-traffictypediagnostic: AT5PR8401MB0483:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0483BF7393CB9C449A4FB469828E0@AT5PR8401MB0483.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AT5PR8401MB0483;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0483;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(377424004)(199004)(189003)(3660700001)(81156014)(1730700003)(81166006)(2906002)(68736007)(305945005)(102836004)(2351001)(8936002)(97736004)(5660300001)(8676002)(26005)(2616005)(476003)(54906003)(486006)(6436002)(11346002)(186003)(7736002)(6506007)(3280700002)(316002)(86362001)(76176011)(446003)(229853002)(6486002)(106356001)(2900100001)(105586002)(7416002)(66066001)(5250100002)(5640700003)(6512007)(6246003)(6116002)(103116003)(14454004)(3846002)(93886005)(99286004)(2501003)(4326008)(53936002)(25786009)(478600001)(36756003)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0483;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: StQnF/upErK3QoYr+C3i5JUIuGBh+u1x9oSOBrYFq7W3B916TQD4l/+bLXXhRxbtAKA8Rk3U2H4H1HsXl/Z1TvT44ZUCRx4YIrZyNx6Y7O+EVywCN/f+u9n4BUhfweYlcMdE80LPnmoP40d6b18zn8utjrEQ9bp1JbXvPSC+utMW+2Qp6nMLmFVT6ZnX9DJX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD7B01EDF5027C46BE3A540B0138870D@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 72ead034-bf58-4e6b-9a3f-08d5ab9e20f9
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ead034-bf58-4e6b-9a3f-08d5ab9e20f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 17:49:58.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0483
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTI2IGF0IDE5OjIzICswMjAwLCBqb3JvQDhieXRlcy5vcmcgd3JvdGU6
DQo+IE9uIFRodSwgQXByIDI2LCAyMDE4IGF0IDA0OjIxOjE5UE0gKzAwMDAsIEthbmksIFRvc2hp
IHdyb3RlOg0KPiA+IEFsbCBwYWdlcyB1bmRlciB0aGUgcG1kIGhhZCBiZWVuIHVubWFwcGVkIGFu
ZCB0aGVuIGxhenkgVExCIHB1cmdlZCB3aXRoDQo+ID4gSU5WTFBHIGJlZm9yZSBjb21pbmcgdG8g
dGhpcyBjb2RlIHBhdGguICBTcGVjdWxhdGlvbiBpcyBub3QgYWxsb3dlZCB0bw0KPiA+IHBhZ2Vz
IHdpdGhvdXQgbWFwcGluZy4NCj4gDQo+IENQVXMgaGF2ZSBub3Qgb25seSBUTEJzLCBidXQgYWxz
byBwYWdlLXdhbGsgY2FjaGVzIHdoaWNoIGNhY2hlDQo+IGludGVybWVkaWFyeSByZXN1bHRzIG9m
IHBhZ2UtdGFibGUgd2Fsa3MgYW5kIHdoaWNoIGlzIGZsdXNoZWQgdG9nZXRoZXINCj4gd2l0aCB0
aGUgVExCLg0KPiANCj4gU28gdGhlIFBNRCBlbnRyeSB5b3UgY2xlYXIgY2FuIHN0aWxsIGJlIGlu
IGEgcGFnZS13YWxrIGNhY2hlIGFuZCB0aGlzDQo+IG5lZWRzIHRvIGJlIGZsdXNoZWQgdG9vIGJl
Zm9yZSB5b3UgY2FuIGZyZWUgdGhlIFBURSBwYWdlLiBPdGhlcndpc2UNCj4gcGFnZS13YWxrcyBt
aWdodCBzdGlsbCBnbyB0byB0aGUgcGFnZSB5b3UganVzdCBmcmVlZC4gVGhhdCBpcyBlc3BlY2lh
bGx5DQo+IGJhZCB3aGVuIHRoZSBwYWdlIGlzIGFscmVhZHkgcmVhbGxvY2F0ZWQgYW5kIGZpbGxl
ZCB3aXRoIG90aGVyIGRhdGEuDQoNCkkgZG8gbm90IHVuZGVyc3RhbmQgd2h5IHdlIG5lZWQgdG8g
Zmx1c2ggcHJvY2Vzc29yIGNhY2hlcyBoZXJlLiB4ODYNCnByb2Nlc3NvciBjYWNoZXMgYXJlIGNv
aGVyZW50IHdpdGggTUVTSS4gIFNvLCBjbGVhcmluZyBhbiBQTUQgZW50cnkNCm1vZGlmaWVzIGEg
Y2FjaGUgZW50cnkgb24gdGhlIHByb2Nlc3NvciBhc3NvY2lhdGVkIHdpdGggdGhlIGFkZHJlc3Ms
DQp3aGljaCBpbiB0dXJuIGludmFsaWRhdGVzIGFsbCBzdGFsZSBjYWNoZSBlbnRyaWVzIG9uIG90
aGVyIHByb2Nlc3NvcnMuDQoNCj4gPiA+IEZ1cnRoZXIgdGhpcyBuZWVkcyBzeW5jaHJvbml6YXRp
b24gd2l0aCBvdGhlciBwYWdlLXRhYmxlcyBpbiB0aGUgc3lzdGVtDQo+ID4gPiB3aGVuIHRoZSBr
ZXJuZWwgUE1EcyBhcmUgbm90IHNoYXJlZCBiZXR3ZWVuIHByb2Nlc3Nlcy4gSW4geDg2LTMyIHdp
dGgNCj4gPiA+IFBBRSB0aGlzIGNhdXNlcyBhIEJVR19PTigpIGJlaW5nIHRyaWdnZXJlZCBhdCBh
cmNoL3g4Ni9tbS9mYXVsdC5jOjI2OA0KPiA+ID4gYmVjYXVzZSB0aGUgcGFnZS10YWJsZXMgYXJl
IG5vdCBjb3JyZWN0bHkgc3luY2hyb25pemVkLg0KPiA+IA0KPiA+IEkgdGhpbmsgdGhpcyBpcyBh
biBpc3N1ZSB3aXRoIHBtZCBtYXBwaW5nIHN1cHBvcnQgb24geDg2LTMyLVBBRSwgbm90DQo+ID4g
d2l0aCB0aGlzIHBhdGNoLiAgSSB0aGluayB0aGUgY29kZSBuZWVkZWQgdG8gYmUgdXBkYXRlZCB0
byBzeW5jIGF0IHRoZQ0KPiA+IHB1ZCBsZXZlbC4NCj4gDQo+IEl0IGlzIGFuIGlzc3VlIHdpdGgg
dGhpcyBwYXRjaCwgYmVjYXVzZSB0aGlzIHBhdGNoIGlzIGZvciB4ODYgYW5kIG9uIHg4Ng0KPiBl
dmVyeSBjaGFuZ2UgdG8gdGhlIGtlcm5lbCBwYWdlLXRhYmxlcyBwb3RlbnRpYWxseSBuZWVkcyB0
byBieQ0KPiBzeW5jaHJvbml6ZWQgdG8gdGhlIG90aGVyIHBhZ2UtdGFibGVzLiBBbmQgdGhpcyBw
YXRjaCBkb2Vzbid0IGltcGxlbWVudA0KPiBpdCwgd2hpY2ggdHJpZ2dlcnMgYSBCVUdfT04oKSB1
bmRlciBjZXJ0YWluIGNvbmRpdGlvbnMuDQoNClRoZSBpc3N1ZSB3YXMgaW50cm9kdWNlZCB3aGVu
IHBtZCBtYXBwaW5nIHN1cHBvcnQgd2FzIGFkZGVkIG9uIHg4Ni8zMiwNCndoaWNoIHdhcyBtYWRl
IHByaW9yIHRvIHRoaXMgcGF0Y2guDQoNClRoYW5rcywNCi1Ub3NoaQ0K
