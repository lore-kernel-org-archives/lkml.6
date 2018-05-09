Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-546355-1525879754-2-15272537931604716485
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
    1525879754; b=k6+CrdWbiu0fCfzmYkLwN0H/Ti+XpcVwk79su24oP/JE1rnRKX
    SuQB0qLMAgsNXr5pin2mQmBokAnL7v2qPY/PD52776X6hbJbIGU7TD+3Y+Tpz+M4
    T2ksKfdKqWKygghM9jsI2g2/3zsxuXk0W6p5MCHByFAMaN+K2jIiscuqS3D0uDMJ
    f5KMvDBEjOMU1XOAR79IT0gm4AIU3EobruEQEhrOyOiMy8g12vwykYFZRNaG2ITG
    lLiAnY8MU2k/60Bn9x1ZcpLwuo3v6RZqWXWHquA4/TcJb79iQ8xTE37o1/xRt2sU
    aMni7IS6loySVcTLKSUCeajYqV4Qlpp5liPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1525879754; bh=R9S1TILUEiVGe2oG0udjTQruyHhh/nrtaGEj09KDCy0=; b=
    NDqmtoWypDqDLHAMZNmONDYxou8+jygTA5/OmKqgfwhzGFFSunt21wCbnGUuUwLA
    R8yb8c4r98+LP30mJrmSR8FUo01/s9fBKrp4GApi6GobJydjroKkeV/r/Whdieh0
    k5iqYmpV9iJe6KbML4F9RZ3w/rGhgBqknAJnCfvr/COjDfoLzAdFTap9ndtIJLTy
    WdqrauPFHAWaEg+e6FHVc/F+Sp8IJlQ1ZBmf2OaQyDzDaBXAUxPUGn7YjhTYrb1V
    srpXoPEKdg/N1+sKKGt3QaRLMxdR5fNF5CmYcmBZDdl02PB1J5QniVuCcvcAGNrb
    ql0wnfjQCNGTH5bjmk3S+g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=sharedspace.onmicrosoft.com
    header.i=@sharedspace.onmicrosoft.com header.b=L9EXycIv x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=YjkbwJrz x-bits=2048
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=sharedspace.onmicrosoft.com
      header.i=@sharedspace.onmicrosoft.com header.b=L9EXycIv x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=YjkbwJrz x-bits=2048
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
X-CM-Envelope: MS4wfLDJpLfyc+gq1pcSBagFCJMt0tXrelu0Xp4gH9a8Tr/zCLgvqGKq66SYuGuKR6R63miWh5dvPoRVqx4OgxfPZFrN3WoQ+DIsCVmQG89xVpIeSjocmDjq
    dENVXrUl4dKaPShyajscH4i/cjNjIPLQnZ91gED3DoPt8ttgRl8lJjqUpm2na3XJVJMcCfwEzCKdKWZhw94JJ0vd9jQ6kAjb9VbRGZiop7zQ0dXMNqlzybgx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=aoKwaT32oDQA:10 a=z9u8ow3asF8A:10
    a=Wta_QN2i4hwA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=X0ROFhD97x8A:10 a=VwQbUJbxAAAA:8 a=ZPZh0FaAJCmiZirNdx0A:9 a=QEXdDO2ut3YA:10
    a=ic4oXV6auKO-Q6VfiSZ6:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964874AbeEIP3K (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 11:29:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:18524 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935397AbeEIP3F (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 May 2018 11:29:05 -0400
X-IronPort-AV: E=Sophos;i="5.49,382,1520870400";
   d="scan'208";a="77801135"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] fs: Convert kiocb rw_hint from enum to u16
Thread-Topic: [PATCH v3 2/3] fs: Convert kiocb rw_hint from enum to u16
Thread-Index: AQHT5vP8AOC95biaMU660lFL7j5vfaQnZwQAgAANiwCAABBvgIAAAgOA
Date: Wed, 9 May 2018 15:29:00 +0000
Message-ID: <a22de016-686f-ce93-c311-71a6719ee521@wdc.com>
References: <20180508174202.2537-1-adam.manzanares@wdc.com>
 <20180508174202.2537-3-adam.manzanares@wdc.com>
 <20180509133432.GD28388@thunk.org>
 <0aad993b-448c-3586-cfc0-f2e50b1dda28@kernel.dk>
 <20180509152149.GG28388@thunk.org>
In-Reply-To: <20180509152149.GG28388@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.173]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0684;7:LulN41c1sZFbPLu2XiudqOsyY/bB6CKntDcg2WXh3OfZaMOYA6R4a0WNHQ/1Iyk7GC02OzC5HMPEkG9bweDwOLXYW6oPBHK1RL+Nak3iV/5aFD2mYZH27LBG4J3ARxppFIy0Q1TM+6QM6u7y6w0f5hVwOnfb4tniKpP5lN8WenKBAJ2ZHmuzaGAf2a1XDSlPOvphpbn6aLPPS5Gi3RVkc9Ybag3qNx0d2/mhk4b1Swqa/b0Izccm42dq0xA+njjf;20:AlKoWmlnfs+2CE5jGp0InKvQ8W73RQk6zeCAzb85lTkejrmpsis/tr+62khsHHTyuswq2C2E86FLcMphMmvKJ0Nnf01kgCvatULPUc3x2Q4QVrFxIIy3qQfupVpjrNrui5M3czF6tvC1EeIzckdLd/AeruGd5u5zGOOaHe+Q5Vo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0684;
x-ms-traffictypediagnostic: DM5PR04MB0684:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB0684702CBE9466D023C0E32AF0990@DM5PR04MB0684.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR04MB0684;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0684;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(5250100002)(26005)(316002)(66066001)(6436002)(8676002)(5660300001)(31686004)(6486002)(102836004)(81156014)(81166006)(99286004)(186003)(6116002)(2201001)(14454004)(110136005)(3846002)(8936002)(93886005)(2900100001)(105586002)(97736004)(106356001)(2501003)(72206003)(76176011)(31696002)(6512007)(478600001)(25786009)(11346002)(68736007)(305945005)(7736002)(6506007)(86362001)(53546011)(6246003)(2616005)(3660700001)(446003)(36756003)(476003)(229853002)(2906002)(3280700002)(486006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0684;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ckN8YfCmS0z/fGSL3wD/cNtuOBjy5ihibIXPcclp0A7WcLc6/CpLAao1rwkHMYxvF3wTmokIXy8cAUYtQJpMMfk/YUXtFeClNnThP57r3nVBaMLVv1fjHfhPKQ2u5DFwq+ogTl8UDHwrEagSD7n789pVa4Rv4FLRrZ33j9Hy28dfdBOKvm29xrSD6ubChtkz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D1CEED69CA4194DAC16276FE7E2C4F9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1db88dba-35ae-421c-c796-08d5b5c19707
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db88dba-35ae-421c-c796-08d5b5c19707
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 15:29:00.8728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0684
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDUvOS8xOCAxMToyMSBBTSwgVGhlb2RvcmUgWS4gVHMnbyB3cm90ZToNCj4gT24gV2Vk
LCBNYXkgMDksIDIwMTggYXQgMDg6MjM6MDBBTSAtMDYwMCwgSmVucyBBeGJvZSB3cm90ZToNCj4+
IFN0cmVhbXMgaXMgZXNzZW50aWFsbHkgdGhlIG9ubHkgdGhpbmcga2lfaGludCBpcyBjdXJyZW50
bHkgdXNlZCBmb3IsDQo+PiB3aXRoIHRoZSB3cml0ZSBsaWZlIHRpbWUgaGludHMgbWFwcGluZyB0
byBhIHN0cmVhbS4gVGhlIGlkZWEgZm9yIHRoZQ0KPj4gdXNlciBzaWRlIEFQSSB3YXMgdG8gaGF2
ZSBvdGhlciB0aGluZ3MgdGhhbiBqdXN0IHdyaXRlIGxpZmUgdGltZSBoaW50cy4NCj4+DQo+PiBT
aW5jZSBBZGFtIHdhbnRzIHRvIGRvIHByaW9yaXRpZXMsIGhlJ2QgZWl0aGVyIG5lZWQgdG8gcGFj
ayBpbnRvIHRoZQ0KPj4gZXhpc3Rpbmcga2lfaGludCwgb3IgZG8gdGhpcyBwYXRjaCBkb2VzLCB3
aGljaCBpcyBtYWtlIGl0IHNtYWxsZXIgYW5kDQo+PiBhZGQgYSBuZXcgbWVtYmVyLiBJIHRoaW5r
IHRoZSBsYXR0ZXIgaXMgY2xlYW5lci4NCj4gDQo+IEZhaXIgZW5vdWdoOyBidXQgbWF5YmUgd2Ug
Y2FuIHVzZSBhIHU4IGluc3RlYWQgb2YgYSB1MTY/ICA2NSw1MzUNCj4gcHJpb3JpdGllcyBzdGls
bCBzZWVtIGxpa2Ugd2F5IG1vcmUgdGhhbiB3b3VsZCBldmVyIG1ha2Ugc2Vuc2UuICBJDQo+IHRo
aW5rIDI1NiBwcmlvcml0aWVzIGlzIHN0aWxsIHdheSB0byBtYW55LCBidXQgaXQncyBzaW1wbGVy
IHdoaWxlDQo+IHN0aWxsIHJlc2VydmluZyBudW1iZXIgb2YgYml0cyBmb3IgZnV0dXJlIHNlLg0K
DQpUaGUgaW50ZW50aW9uIHdhcyB0byBtaW1pYyB0aGUgaW9wcmlvX3NldCBzeXN0ZW0gY2FsbCwg
d2hpY2ggdXNlcyAzIGJpdHMgDQpmb3IgYSBwcmlvIGNsYXNzIGFuZCAxMyBiaXRzIGZvciBhIHBy
aW9fdmFsdWUuDQoNCklESyB3aGF0IGlzIHRoZSByaWdodCBhbW91bnQgb2YgYml0cyB0byB1c2Us
IGJ1dCB0aGUgZXhpc3RpbmcgdXNlIG9mIA0KYml0cyBzZWVtZWQgZmxleGlibGUgZW5vdWdoIHRv
IHN1cHBvcnQgbWFueSB0eXBlcyBvZiBhcHBsaWNhdGlvbnMgYW5kIA0KZGV2aWNlcy4NCj4gDQo+
ICAgICAgICAgICAgICAJCSAgICAgICAJICAgICAgIAkgICAtIFRlZA0KPiA=
