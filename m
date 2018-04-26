Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3258746-1524781826-2-4071238489024023388
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
    1524781825; b=BYvpUZiBuUljqeiKY5Fgtcpxcredq/+hX9hBSrkR0R6zoOcuWh
    4SYKJ2QaSqzlS2h/MtGIUeUu/L+lgiH4PeMMVSTYzUYlvDoydqhYrYFDw7vUKOr7
    rPcUwAJngXZKRk1AxFpAwC83LmuklTN0jC+1d7XOuG/TasqE4t9dRs3OCO0fepPj
    2oYqocURHudfuBFKb3jPXQ5Ge/SGK+JFPqQUPz5vFYs63/qqaRwL2Ne6I2CkCtUr
    j2ySyTbwBHqCjEVuJ0TjCJdcNOfe2PxyShiojdKFQOEt0JcGqxA4Eng6TVyrdUgZ
    3nwJA4EHZ0PIf+Nwt8NKCUTogJsrXFIpALVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1524781825; bh=GoaPQRLX10+42E0t3vj0CQd1/YWR2+Gx3lpGYFpob6A=; b=
    p16otqA46HHmrdjUVjwF2R7QLFEOVlKqLJOnZhjsvJVNVjFKCzwPkH6F+iWTqsfp
    +aZr7C2jbWR3ZRL4E7XekitUbrSW+mxpWeZvrm+Oee9Y4ZiJ2OSJZSxcRKZhPfZh
    ka9lvxPTOKv6tifhEmp9DizjB2m7OCwIgzzwm0vIXwvQlSF/Ja+lvJsgUGpTleB0
    3ATMhL8qPZhFf0sYgHHy/quPuW/T7noG8RV/xgt+GQzIgHXgQ4shkQCSI1fXAfUC
    XjKC9t2edwCHCfDKX7VPXHJE2cEirDAagcuz+m5XKqhXdmcgRIXuJJSfKXAfY8hg
    wxc6IcNH+Fa12SsTVMjhPg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfA6Wx6jscRnwB8obRwNnLeLfVpLoXvAtOUv/+Fq0VPNEqb/4n8MdZcf1z/JTaqWj+utC3CHNPbtdYWiz2Patge+MzVzgH/Ug8tes/jv+EdQEfpzHLTW2
    6rpMwTvkZ/NRLNIM9hyRVJvu7aq6KLHiFPK4/iOiRaIxrxZBs0E2mF3ZUUyJvt7mfTeGFWL+HSUzOoFk02Z1g+XRXrpd8iiAyy4BMmkhrovSSLSstWcwYsG1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=mGcY1-y8K0sA:10 a=JQGMX7YiA1EA:10
    a=A3aqUMXqizAA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=QDZ4HvhdkI4A:10 a=tA7aZXjiAAAA:8 a=BMchEuyBHqcTz5F5yCoA:9
    a=RwvliEkiSOGulirM:21 a=8AqQBDu0J88IBUqj:21 a=QEXdDO2ut3YA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755207AbeDZWaX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 18:30:23 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:14748 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbeDZWaV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 18:30:21 -0400
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
Thread-Index: AQHTu76cmkz1ie7mb0G/9GXlGHy7daQTW6wAgAAh0oCAABGZAIAABywAgAAmsYCAACedAA==
Date: Thu, 26 Apr 2018 22:30:14 +0000
Message-ID: <1524781764.2693.503.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
         <20180314180155.19492-3-toshi.kani@hpe.com>
         <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
         <20180426172327.GQ15462@8bytes.org> <1524764948.2693.478.camel@hpe.com>
         <20180426200737.GS15462@8bytes.org>
In-Reply-To: <20180426200737.GS15462@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1028;7:FdMR4uL4cs1l7eih9TjKzzmyoPTvmFXnxufixOkt3DHS/Hd1uEGD0RRRD0n+XFhvtteDymplLdGCY+/iUsW8WvwnW/GkLDDtg9Kb+9GDubfTySAOSNpTaYrd1EmFlUU0A5a1msdR7AyxE+CknVoy4FrKQfTxePLKhrZpqh8whcZI6GDX6IZoU5idxo5WSu6xVyjfI3feaCrcOmSI5nt14jWWLG3qph2qIcX5+oSHbxXOkiIMEtMltwMJYROFkm3U
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1028;
x-ms-traffictypediagnostic: AT5PR8401MB1028:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB10283C4F7BCB670CBBBEF0BF828E0@AT5PR8401MB1028.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AT5PR8401MB1028;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1028;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(377424004)(189003)(199004)(51914003)(6116002)(316002)(76176011)(8936002)(2501003)(8676002)(6436002)(81156014)(6506007)(103116003)(11346002)(53936002)(59450400001)(6486002)(2900100001)(5250100002)(1730700003)(81166006)(6246003)(106356001)(97736004)(486006)(105586002)(2616005)(6916009)(7736002)(36756003)(66066001)(5640700003)(476003)(6512007)(446003)(68736007)(25786009)(99286004)(54906003)(86362001)(2351001)(93886005)(478600001)(7416002)(5660300001)(305945005)(26005)(14454004)(3660700001)(4326008)(186003)(102836004)(229853002)(3846002)(3280700002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1028;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ypMZ2LoOUFtJr9K+y/QzbQRNhQ8C5sZ6ROzV39JPZXXAYx8XxpRF5eU7HodnCq+l/WTMaq7d0jwUBf78ROHWyOgFhP/mtbEZ7KWcufPh5IrwEMjCB+JhYtBzytzLP+D0XZ5KigEf2N1l6qeHQtZ//HBQ6f3euVH2SvKxRW+JJphwBlhDk39deBe/sqlxvc4z
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EDE787B35BE6D488AF4ABE41F90DD56@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: da81a5db-b2bf-4067-f84d-08d5abc547e5
X-MS-Exchange-CrossTenant-Network-Message-Id: da81a5db-b2bf-4067-f84d-08d5abc547e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 22:30:14.4252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1028
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTI2IGF0IDIyOjA3ICswMjAwLCBqb3JvQDhieXRlcy5vcmcgd3JvdGU6
DQo+IE9uIFRodSwgQXByIDI2LCAyMDE4IGF0IDA1OjQ5OjU4UE0gKzAwMDAsIEthbmksIFRvc2hp
IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAxOC0wNC0yNiBhdCAxOToyMyArMDIwMCwgam9yb0A4Ynl0
ZXMub3JnIHdyb3RlOg0KPiA+ID4gU28gdGhlIFBNRCBlbnRyeSB5b3UgY2xlYXIgY2FuIHN0aWxs
IGJlIGluIGEgcGFnZS13YWxrIGNhY2hlIGFuZCB0aGlzDQo+ID4gPiBuZWVkcyB0byBiZSBmbHVz
aGVkIHRvbyBiZWZvcmUgeW91IGNhbiBmcmVlIHRoZSBQVEUgcGFnZS4gT3RoZXJ3aXNlDQo+ID4g
PiBwYWdlLXdhbGtzIG1pZ2h0IHN0aWxsIGdvIHRvIHRoZSBwYWdlIHlvdSBqdXN0IGZyZWVkLiBU
aGF0IGlzIGVzcGVjaWFsbHkNCj4gPiA+IGJhZCB3aGVuIHRoZSBwYWdlIGlzIGFscmVhZHkgcmVh
bGxvY2F0ZWQgYW5kIGZpbGxlZCB3aXRoIG90aGVyIGRhdGEuDQo+ID4gDQo+ID4gSSBkbyBub3Qg
dW5kZXJzdGFuZCB3aHkgd2UgbmVlZCB0byBmbHVzaCBwcm9jZXNzb3IgY2FjaGVzIGhlcmUuIHg4
Ng0KPiA+IHByb2Nlc3NvciBjYWNoZXMgYXJlIGNvaGVyZW50IHdpdGggTUVTSS4gIFNvLCBjbGVh
cmluZyBhbiBQTUQgZW50cnkNCj4gPiBtb2RpZmllcyBhIGNhY2hlIGVudHJ5IG9uIHRoZSBwcm9j
ZXNzb3IgYXNzb2NpYXRlZCB3aXRoIHRoZSBhZGRyZXNzLA0KPiA+IHdoaWNoIGluIHR1cm4gaW52
YWxpZGF0ZXMgYWxsIHN0YWxlIGNhY2hlIGVudHJpZXMgb24gb3RoZXIgcHJvY2Vzc29ycy4NCj4g
DQo+IEEgcGFnZSB3YWxrIGNhY2hlIGlzIG5vdCBhYm91dCB0aGUgcHJvY2Vzc29ycyBkYXRhIGNh
Y2hlLCBpdHMgYSBjYWNoZQ0KPiBzaW1pbGFyIHRvIHRoZSBUTEIgdG8gc3BlZWQgdXAgcGFnZS13
YWxrcyBieSBjYWNoaW5nIGludGVybWVkaWF0ZQ0KPiByZXN1bHRzIG9mIHByZXZpb3VzIHBhZ2Ug
d2Fsa3MuDQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uIEFmdGVyIHJlYWRpbmcgdGhy
b3VnaCBTRE0gb25lIG1vcmUgdGltZSwgSQ0KYWdyZWUgdGhhdCB3ZSBuZWVkIGEgVExCIHB1cmdl
IGhlcmUuIEhlcmUgaXMgbXkgY3VycmVudCB1bmRlcnN0YW5kaW5nLiANCg0KIC0gSU5WTFBHIHB1
cmdlcyBib3RoIFRMQiBhbmQgcGFnaW5nLXN0cnVjdHVyZSBjYWNoZXMuIFNvLCBQTUQgY2FjaGUg
d2FzDQpwdXJnZWQgb25jZS4NCiAtIEhvd2V2ZXIsIHByb2Nlc3NvciBtYXkgY2FjaGUgdGhpcyBQ
TUQgZW50cnkgbGF0ZXIgaW4gc3BlY3VsYXRpb24NCnNpbmNlIGl0IGhhcyBwLWJpdCBzZXQuIChU
aGlzIGlzIHdoZXJlIG15IG1pc3VuZGVyc3RhbmRpbmcgd2FzLg0KU3BlY3VsYXRpb24gaXMgbm90
IGFsbG93ZWQgdG8gYWNjZXNzIGEgdGFyZ2V0IGFkZHJlc3MsIGJ1dCBpdCBtYXkgc3RpbGwNCmNh
Y2hlIHRoaXMgUE1EIGVudHJ5LikNCiAtIEEgc2luZ2xlIElOVkxQRyBvbiBlYWNoIHByb2Nlc3Nv
ciBwdXJnZXMgdGhpcyBQTUQgY2FjaGUuIEl0IGRvZXMgbm90DQpuZWVkIGEgcmFuZ2UgcHVyZ2Ug
KHdoaWNoIHdhcyBhbHJlYWR5IGRvbmUpLg0KDQpEb2VzIGl0IHNvdW5kIHJpZ2h0IHRvIHlvdT8N
Cg0KQXMgZm9yIHRoZSBCVUdfT04gaXNzdWUsIGFyZSB5b3UgYWJsZSB0byByZXByb2R1Y2UgdGhp
cyBpc3N1ZT8gIElmIHNvLA0Kd291bGQgeW91IGJlIGFibGUgdG8gdGVzdCB0aGUgZml4Pw0KDQpS
ZWdhcmRzLA0KLVRvc2hpDQo=
