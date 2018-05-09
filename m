Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-555205-1525880890-2-2872791536210624491
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
    1525880889; b=Ma0SQL4YKh/IHyZ2hWemMRHl3N2NbZ2iTc/j4A8zyNzCC8+YXg
    r+fjsOvGnidJNwBXvnUETzYDfndNBBRDwFB0/Sf/RBInusTyPNzg9TSeSH+SUA8k
    aw13gquu1msNugmalk060nrHQQ2fPPau1Us+eSd9rauVLXi5WM54eJefAXsjwpKg
    Ug3AALGFBb3JOvFF64lXlnQiAv/qJpLui/ebC92NwIPSMChki5uAyCDr84pKWv/h
    YF80KhlhHuNWkfgPN/C5eWig9znY+keGTBOIoLIXkf4QCUWjWKRVTQVzrD9HTUT5
    UcAn1kFi+LMAs3nJbFjynF77idLVXPeDSYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1525880889; bh=m9M6mYOl2bmdcPiXf0wxV7PoZMJ4oUn3OqENNrUaJQo=; b=
    mJYxBqCxMU3xv1ie8btywdBmZ7ZfS/E02kd7jvmM5tjPRiyzCgklXc5rnLvcoEzu
    /HpYoCm5uQiKgCGBR7dPT3z5K29V5pXPzp5Iz6IxbV6FKErOl+soi48nIDEib7Lh
    DyJ/qPi/XpHtzG8pPM0rc2k+9sYPQBo2n+yfZxoaLvjVb4Cl112s3L01PtkTNZf5
    e8zyQ4Oe8bEbx0LNk338eRL0SkKcni5LlmIStscGskEh+lyBz9NYkIsJm/k2E9U2
    yHErojavqlHCGrOJUqtK/VpgqrWJtjdqqugsBiQ71yjkoMu2e26AaQmZz/ErrpyL
    AYJWZG19XFEa04G1esrgUg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfJvKHqe7Uh0NnqSywqBoKbpT/tzSEbSIioShRXTnAKolU9RXid7ldOulRcooYLtkAW/1vz+MLNSOghFNrZLNs9uJPGrqO3VoBh9uxEEnKRLdwVH22yKQ
    wDei27qsxHCHjE4rBmxrgOYE1yBMzVSpsv4DO33OTpimPwjxcRIWo7SgxalLUP6rEikD6XjhELmOiDW316zNIKRwAjnwdk7Sfp1ClRXrdHVup1ve7HVeVTTr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=mGcY1-y8K0sA:10 a=JQGMX7YiA1EA:10
    a=f42vwGsFWEMA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=QDZ4HvhdkI4A:10 a=tA7aZXjiAAAA:8 a=VGcmLtMpudURNlr_U38A:9 a=QEXdDO2ut3YA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935419AbeEIPrx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 11:47:53 -0400
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:31919 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935151AbeEIPrv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 May 2018 11:47:51 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/mm: disable ioremap free page handling on x86-PAE
Thread-Topic: [PATCH 3/3] x86/mm: disable ioremap free page handling on
 x86-PAE
Thread-Index: AQHT4K02VIDvFUCTQE661P1+g/51n6QnmF+A
Date: Wed, 9 May 2018 15:47:19 +0000
Message-ID: <1525880775.2693.558.camel@hpe.com>
References: <20180430175925.2657-1-toshi.kani@hpe.com>
         <20180430175925.2657-4-toshi.kani@hpe.com>
In-Reply-To: <20180430175925.2657-4-toshi.kani@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0851;7:w+DQ3qHPGKf5Qkf/8Mnx3DVFw3X7YkLVP02WBGu5r+RrmOYvAJ80h8TG9Bb9SYEqtnieBTDq2mOdMtcf8AlGEJgNFT+ha2Kyk3f09YYU01SoRBq6uacLlpInTm+bdR3OD7VLez0z6Aqk5CCoTPZb4P1WJwI/VMS2xlLaBaZz6IzuJgJ/pZthPOVvaXvUOJos7wcsrXLlVw1XNAse2+I9AyddPaI1OsghV81svMV9BJPPJD0CK2hCyZt+iOmrQ2Px
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0851;
x-ms-traffictypediagnostic: AT5PR8401MB0851:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0851122D0C4BB1F6A145C18582990@AT5PR8401MB0851.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AT5PR8401MB0851;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0851;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(376002)(346002)(396003)(189003)(199004)(377424004)(2501003)(102836004)(4326008)(53936002)(106356001)(305945005)(81156014)(103116003)(6486002)(8676002)(81166006)(105586002)(68736007)(5660300001)(54906003)(8936002)(5250100002)(7736002)(486006)(25786009)(6436002)(59450400001)(14454004)(476003)(446003)(6116002)(11346002)(6512007)(3846002)(229853002)(6506007)(2616005)(110136005)(478600001)(3280700002)(7416002)(36756003)(2906002)(99286004)(26005)(66066001)(2900100001)(316002)(2201001)(97736004)(186003)(76176011)(6246003)(86362001)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0851;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lBOPhc2jYRW9Bj8KeBvzZB6tQrx/TsM+p9Vs4uXu91LMNuJG6ey77tFvWneoFWvlz+kncPH2kolFDsnIdNzWPllAsE9qZLJzEZY1cWy0MVqZNqdpqNlGb8qu8ZKJ/Z6SImnqD5VyWX990Qh6wsfyniIXcoP06LoHsEiV3lOkrLa1bu2ytce3jW3xKbPFxbKs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8A4E1ED8C323440AC59F286858F2AF9@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3f3fedbc-2918-4e67-4629-08d5b5c425a8
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3fedbc-2918-4e67-4629-08d5b5c425a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 15:47:19.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0851
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uLCAyMDE4LTA0LTMwIGF0IDExOjU5IC0wNjAwLCBUb3NoaSBLYW5pIHdyb3RlOg0KPiBp
b3JlbWFwKCkgc3VwcG9ydHMgcG1kIG1hcHBpbmdzIG9uIHg4Ni1QQUUuICBIb3dldmVyLCBrZXJu
ZWwncyBwbWQNCj4gdGFibGVzIGFyZSBub3Qgc2hhcmVkIGFtb25nIHByb2Nlc3NlcyBvbiB4ODYt
UEFFLiAgVGhlcmVmb3JlLCBhbnkNCj4gdXBkYXRlIHRvIHN5bmMnZCBwbWQgZW50cmllcyBuZWVk
IHJlLXN5bmNpbmcuICBGcmVlaW5nIGEgcHRlIHBhZ2UNCj4gYWxzbyBsZWFkcyB0byBhIHZtYWxs
b2MgZmF1bHQgYW5kIGhpdHMgdGhlIEJVR19PTiBpbiB2bWFsbG9jX3N5bmNfb25lKCkuDQo+IA0K
PiBEaXNhYmxlIGZyZWUgcGFnZSBoYW5kbGluZyBvbiB4ODYtUEFFLiAgcHVkX2ZyZWVfcG1kX3Bh
Z2UoKSBhbmQNCj4gcG1kX2ZyZWVfcHRlX3BhZ2UoKSBzaW1wbHkgcmV0dXJuIDAgaWYgYSBnaXZl
biBwdWQvcG1kIGVudHJ5IGlzIHByZXNlbnQuDQo+IFRoaXMgYXNzdXJlcyB0aGF0IGlvcmVtYXAo
KSBkb2VzIG5vdCB1cGRhdGUgc3luYydkIHBtZCBlbnRyaWVzIGF0IHRoZQ0KPiBjb3N0IG9mIGZh
bGxpbmcgYmFjayB0byBwdGUgbWFwcGluZ3MuDQo+IA0KPiBGaXhlczogMjhlZTkwZmU2MDQ4ICgi
eDg2L21tOiBpbXBsZW1lbnQgZnJlZSBwbWQvcHRlIHBhZ2UgaW50ZXJmYWNlcyIpDQo+IFJlcG9y
dGVkLWJ5OiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4NCg0KSGkgSm9lcmcsDQoNCkRv
ZXMgaXQgc29sdmUgeW91ciBwcm9ibGVtPyAgTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGlz
c3VlIHdpdGggdGhlDQpzZXJpZXMuIA0KDQpUaGFua3MsDQotVG9zaGkNCg==
