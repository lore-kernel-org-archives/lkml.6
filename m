Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-717497-1524858552-2-15727791175172438735
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
    1524858551; b=guXTER6g4YEu6nmRURJuSknwpYB6kw1cbDWidmu98QIUVdWWgj
    z2Jy9PjoZ1mTanAzSBNp+F319OncAycBxTyCCqexN81gqsNiJ7sCDQjS/W6odeuJ
    d1R3nemMFLm/ZLo7750Tr1AfQB+ccIGnyp6ojnIuXwW7IOSh3njVdEaPOPdzA+fD
    H+VdBYjzYfDRSs2wYH3gYo4PxSdNeLcYVowifTZLLBLc1kWtGWwlQoAYFQzsLPFK
    NAz8x/RjnsMuuV51hsQdW2N8lfhyFD/aMRZL1W6jQk7NNJtHZrMRqfOQeOxz1o9C
    8LgoC+Ic6OZW1aVTLxedqkTAg1xb0nEulW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1524858551; bh=6U/00pZqXzg1aMyOFacJ14DMCSkJBPyEVuoi6kQ7R08=; b=
    nV1+EsSBrpJCU503d6Qxy3o8gEJc5z+E3ano+nGFDg9mNBMeyd7hIF42IHchJuvt
    tbtq9MJqkZCgqXB31VLzG0E3AuKkZIS7CBOardKk1hCLA+pJXw7KiqxX8L4h5xYp
    /I1LGkCx6LOziQ96jUs/H+tgw9a3tA6VV+5g7Ga0y5BCSZ7tM+yPxkBHU6jK6np6
    Kjyz+EEP1aLwLIzgZJ2D3WceyEpITmREk6pFHHIvzMAPjeCuODfmAwVDudP8HrJy
    nJ6TGFsL6Gg0/9/DSHQvS0QqGg7ppcPGS4Pue6NBkI2MgT3QVdqPWpfk2HWa9tRz
    T5ydh1tQSTuBH4Av3vaAsA==
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
X-CM-Envelope: MS4wfB2U/NcNAtZindc7rm+r9YfipsaCjdpoO30e8giDtahlpLFsgmQyj52tJUUsnwvkj2xLvwijBJJQNe1YrA0hyMaR88qG8EsMyQnlpvD+85qEFhu8sEgI
    uDXnUk2Hcku/omMo59FmZwij2GNepCJcW2TnJDTWOxSUbBH6AQihZF6+PSt/HWgxniuLkWa0pVjXfQCuVxXP/bENNbeMAKjoufucqxjWhbWHwvegy9LqRAwT
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=mGcY1-y8K0sA:10 a=JQGMX7YiA1EA:10
    a=TQVxmOB8j98A:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=QDZ4HvhdkI4A:10 a=MvuuwTCpAAAA:8 a=vavRpC3w_GHTHyq08SoA:9 a=QEXdDO2ut3YA:10
    a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758474AbeD0TtJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 15:49:09 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:8276 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758418AbeD0TtH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 15:49:07 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "mingo@kernel.org" <mingo@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [PATCH] Revert "x86/mm: implement free pmd/pte page interfaces"
Thread-Topic: [PATCH] Revert "x86/mm: implement free pmd/pte page interfaces"
Thread-Index: AQHT3XFOK+nexkbX406FiURX1p6mcqQTPGiAgADqnICAAN90gA==
Date: Fri, 27 Apr 2018 19:49:04 +0000
Message-ID: <1524858493.2693.535.camel@hpe.com>
References: <1524755647-18695-1-git-send-email-joro@8bytes.org>
         <1524760125.2693.468.camel@hpe.com>
         <20180427062827.js6kwkwye4ewkuz4@gmail.com>
In-Reply-To: <20180427062827.js6kwkwye4ewkuz4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0787;7:4nkiFEjQaVViUG6aUBP8taxJZpoze2lQvH+lT1CHiF8PBQRmwOtgeNiU/NC3Obb4umqail4/PYVboFkHsWVUeSdILUREuidmCV93R6I79vSRcSnDX5iXv+zMa7PA29uQLLc1iFh5du7HcOnkISAcpTRBzWhPJkIYLz23PlIzNkhCll98KgScE0ZZLpPS08I466yUngXhFDFceRrSku+1gMYpSLta669HybeFN30JWdhFAmZXz5roMQZ6jQj/0oOd
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0787;
x-ms-traffictypediagnostic: AT5PR8401MB0787:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0787BC455ABDD78A1B5A5E3F828D0@AT5PR8401MB0787.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AT5PR8401MB0787;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0787;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(396003)(39860400002)(377424004)(199004)(189003)(1730700003)(6116002)(305945005)(7736002)(2900100001)(3846002)(2906002)(53936002)(106356001)(2351001)(68736007)(8676002)(103116003)(97736004)(54906003)(186003)(8936002)(4326008)(316002)(26005)(6506007)(102836004)(81156014)(81166006)(6916009)(11346002)(14454004)(486006)(478600001)(446003)(2501003)(5250100002)(2616005)(105586002)(76176011)(476003)(3280700002)(5640700003)(6246003)(6436002)(66066001)(7416002)(36756003)(6512007)(229853002)(3660700001)(6486002)(575784001)(5660300001)(86362001)(99286004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0787;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0cRA479+Jq5LrQtqRzCi50mstonzZgvcRdEfM14r9D3k4nyH0Bd5qZaio2RFx25NYoauXjPflpDUv4wlSFTeuWvjlUVrxXFKF3lDzGr6VckzfyK9G6N0LvjybUeZpLM2ijIgjzaaKGYVuaoTg8aAKagA3bWybHwWpoleXZ6wtId0TitCTYhutRidi7IDlyKF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D23BD1DABC4B3248BD91F9F06108575E@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e34af201-0a24-4fec-5c98-08d5ac77ee82
X-MS-Exchange-CrossTenant-Network-Message-Id: e34af201-0a24-4fec-5c98-08d5ac77ee82
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 19:49:04.3878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0787
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gRnJpLCAyMDE4LTA0LTI3IGF0IDA4OjI4ICswMjAwLCBJbmdvIE1vbG5hciB3cm90ZToNCj4g
KiBLYW5pLCBUb3NoaSA8dG9zaGkua2FuaUBocGUuY29tPiB3cm90ZToNCj4gDQo+ID4gT24gVGh1
LCAyMDE4LTA0LTI2IGF0IDE3OjE0ICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+ID4gPiBG
cm9tOiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NCj4gPiA+IA0KPiA+ID4gVGhpcyBy
ZXZlcnRzIGNvbW1pdCAyOGVlOTBmZTYwNDhmYTdiN2NlYWViODgzMWMwZTRlNDU0YTRjZjg5Lg0K
PiA+ID4gDQo+ID4gPiBUaGlzIGNvbW1pdCBpcyBicm9rZW4gZm9yIHg4NiwgYXMgaXQgdW5tYXBz
IHRoZSBQVEUgYW5kIFBNRA0KPiA+ID4gcGFnZXMgYW5kIGltbWVkaWF0bHkgZnJlZXMgdGhlbSB3
aXRob3V0IGRvaW5nIGEgVExCIGZsdXNoLg0KPiA+ID4gDQo+ID4gPiBGdXJ0aGVyIHRoaXMgbGFj
a3Mgc3luY2hyb25pemF0aW9uIHdpdGggb3RoZXIgcGFnZS10YWJsZXMgaW4NCj4gPiA+IHRoZSBz
eXN0ZW0gd2hlbiB0aGUgUE1EIHBhZ2VzIGFyZSBub3Qgc2hhcmVkIGJldHdlZW4NCj4gPiA+IG1t
X3N0cnVjdHMuDQo+ID4gPiANCj4gPiA+IE9uIHg4Ni0zMiB3aXRoIFBBRSBhbmQgUFRJIHBhdGNo
ZXMgb24tdG9wIHRoaXMgcGF0Y2gNCj4gPiA+IHRyaWdnZXJzIHRoZSBCVUdfT04gaW4gdm1hbGxv
Y19zeW5jX29uZSgpIGJlY2F1c2UgdGhlIGtlcm5lbA0KPiA+ID4gYW5kIHRoZSBwcm9jZXNzIHBh
Z2UtdGFibGUgd2VyZSBub3Qgc3luY2hyb25pemVkLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NCj4gPiANCj4gPiBJIGRvIG5vdCBh
Z3JlZSB3aXRoIHRoZSBjb21tZW50cyBhbmQgdGhpcyByZXZlcnQuICBMZXQncyBkaXNjdXNzIGZ1
cnRoZXINCj4gPiBvbiB0aGUgb3JpZ2luYWwgdGhyZWFkLg0KPiANCj4gVGhlIG9yaWdpbmFsIHBh
dGNoIGlzIHRvdGFsbHkgYnJva2VuIChpdCdzIGJhc2VkIG9uIGEgbWlzdW5kZXJzdGFuZGluZyks
IHNvIHVubGVzcyANCj4geW91IGhhdmUgYSBmaXggdGhlIHJldmVydCBpcyBqdXN0aWZpZWQuDQoN
CkkgYW0gd29ya2luZyBvbiBhIGZpeCBvbiB0b3Agb2YgdGhpcyBwYXRjaC4NCg0KVGhhbmtzLA0K
LVRvc2hpDQo=
