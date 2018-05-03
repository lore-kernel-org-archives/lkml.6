Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3120198-1525381118-2-1898377552568216646
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
    1525381117; b=i7yJteA1AIyPfWJAZmwK5mnGQGIx5KE4DRDnSHmV9pFPdnDGeT
    5s5cdZIXQ7ysXGMk0lHtt/DrQi2A+CbG6z5YJWnBM+Wg2+HYs69O04y8Qw/rPW3I
    d3RSL2iL/034zlLou0Fd+QpC/+foK3fsiCq86H0QSE86PkmBGlWA8YfU+mJz31A3
    EZ81SCt0b3CuzExr/cNGfgynW22dUIQ1qLkVzr6XjTT2THDL0yyVQixvhXTIGjnk
    tz0shOq543ApIGIaJFb/5I5nv3NTOTPk3KEEOqXmwWmvemW6YUGHw3stL77I7tJh
    T06g2jiNN+nBlaa2YBYVVnelo5vCFEf2OOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1525381117; bh=PMywoZeT0/zMBThQqtZxc0jsii88Np8IyZyODEnWiEM=; b=
    COKlsilniodjcHyk7kMP/SBj3/25Ph/QOYngRYzAlefKlL9wsjSZALPOczsoXxdQ
    TzZBioeq0VfJRSCE1SmPpOaaBX/SE3q8oKXTr7jHlRzS/bVUbScJleS+FF6YTUcc
    oET309ATaQ6fNowh5SphdDyGRSmXlNPaZ1LjQgJReY6zM3Q6WB8k7+ji3rzj9Epd
    GmhI8k/+Z9qv6JZ5NpY7GdsNz/reZpSph7N0w5+VMr2p3cIUSSyhWc+2Bi7m7dxz
    x24n/wxc4Wh27UEAfBOXZEN7GSOYZIiQhXYwD9pxe4DdjRspA+qGkmIZ20wDsNlm
    RRWmF2p+zRtBbU9fghmpLg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=sharedspace.onmicrosoft.com
    header.i=@sharedspace.onmicrosoft.com header.b=T7+X/Sqf x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=GmI1xMMn x-bits=2048
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=sharedspace.onmicrosoft.com
      header.i=@sharedspace.onmicrosoft.com header.b=T7+X/Sqf x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=GmI1xMMn x-bits=2048
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
X-CM-Envelope: MS4wfE3eXxMienL9loO44/i+p5yKQj0e4/bdn093Ban69bKf+2o3zsVduS9Akvu02MwcWt8cRDKmNo6mHADxVV53nNNuoi9i063eUtBX1lU6w8EmkXbRF52j
    LMB34I2/sUYc+oy5QIFQuvDaxYvVcZo+pyjkluwRm4/LrLhowfGj+rd8wsTki73m7EbayWG1xdwBO7+DrfLmM0MQkzP0lIIrPepOqEOid+WrcaQ4rv60bcqI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=NW1C4N5ZCfcA:10 a=l63GRFdEORMA:10
    a=wwSihFc02yEA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=X0ROFhD97x8A:10 a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=yDi9mTBSSXKHG8BmxV0A:9
    a=QEXdDO2ut3YA:10 a=ic4oXV6auKO-Q6VfiSZ6:22 a=xVlTc564ipvMDusKsbsT:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeECU6Y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 16:58:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44404 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbeECU6W (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 16:58:22 -0400
X-IronPort-AV: E=Sophos;i="5.49,359,1520870400";
   d="scan'208";a="180427516"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs: Add aio iopriority support for block_dev
Thread-Topic: [PATCH v2] fs: Add aio iopriority support for block_dev
Thread-Index: AQHT4wufiwM6RlY01kC8IdAQoZXaF6QeVHuAgAAcXoCAAAKrAIAACU4A
Date: Thu, 3 May 2018 20:58:17 +0000
Message-ID: <e81c74fd-a4a2-80e0-476c-6ff35f158abf@wdc.com>
References: <20180503182114.2797-1-adam.manzanares@wdc.com>
 <20180503183353.GC1562@bombadil.infradead.org>
 <47e0a519-37b4-f5e7-0616-8659d11c2b69@wdc.com>
 <18300bdb-a12f-0b6c-1317-6db3e4391d57@kernel.dk>
In-Reply-To: <18300bdb-a12f-0b6c-1317-6db3e4391d57@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0955;7:Xn7UB0wFcNXbr34M0vdPR0MBgi65SKvg4SstCx2sO+SbRrDybvuIJj+g+5R4sRONAMEybnQvWuHQ+906cdmWZcjoNwyN8PLI7N70f6SZqSFPsZpWPom2mhkrfigzC+tOxv+7YrAepCIsTSJYHD5fB6aVI2gks+yJINA19enmsc4ZvYFlNOcDtT2sCYz5grKm6zaLwPsDi6ir+0KkoY98N7av3qskXpTvfOTeRIHwxB2GtyANSd9R1RWjfxMIai2X;20:2c91uJW5Zwo3LNSBfuVRaP+X1eXc5y6Gy8vwLLgjgyc9g3APwMoMxsBMAqSPCE7lDsmTVMZYecvdxd9y+mr1jN67HJhWEaiRM4A2Cl9HU7VnzJEHnyc7N8qxJN6pIvmUrHST2E/uk5/AKoOxAJzc8KT9EtbaUDptRn7ENC1DZoU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0955;
x-ms-traffictypediagnostic: DM5PR04MB0955:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB09554434E04BB6AF94EAE869F0870@DM5PR04MB0955.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR04MB0955;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0955;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(189003)(199004)(54906003)(3280700002)(7736002)(4326008)(5250100002)(2906002)(3660700001)(25786009)(97736004)(6246003)(229853002)(478600001)(486006)(2616005)(81166006)(446003)(81156014)(110136005)(476003)(11346002)(8936002)(5660300001)(305945005)(53936002)(6436002)(36756003)(316002)(59450400001)(6506007)(2900100001)(31696002)(14454004)(3846002)(106356001)(93886005)(6512007)(6116002)(8676002)(53546011)(105586002)(31686004)(68736007)(86362001)(72206003)(186003)(26005)(76176011)(66066001)(99286004)(102836004)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0955;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0N7PKz5z+Slvf1nhLWsOMaE+DE8w5Ng9DFzMxWQiTUq/xVMWCN0v5SI2okWxKOeMiqSOd063qfAc4uAxoHChblmkenwCWoQhJrPG8XYEsQPVcrLKrHmTaazLUWg6Qw7XSyA/gNRWYGPEpOF7Ll9gT94qITbx0v3e55d9Z7CjaBGTpROtw4myynXBvxZ8/aMl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E98C0F07F155E64EBB398B22DCB40485@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a5dd12a6-dc62-45fa-8835-08d5b1389896
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dd12a6-dc62-45fa-8835-08d5b1389896
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 20:58:17.7517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0955
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDUvMy8xOCAxOjI0IFBNLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBPbiA1LzMvMTggMjox
NSBQTSwgQWRhbSBNYW56YW5hcmVzIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiA1LzMvMTggMTE6MzMg
QU0sIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPj4+IE9uIFRodSwgTWF5IDAzLCAyMDE4IGF0IDEx
OjIxOjE0QU0gLTA3MDAsIGFkYW0ubWFuemFuYXJlc0B3ZGMuY29tIHdyb3RlOg0KPj4+PiBJZiB3
ZSB3YW50IHRvIGF2b2lkIGJsb2F0aW5nIHN0cnVjdCBraW9jYiwgSSBzdWdnZXN0IHdlIHR1cm4g
dGhlIHByaXZhdGUgZmllbGQNCj4+Pj4gaW50byBhIHVuaW9uIG9mIHRoZSBwcml2YXRlIGFuZCBr
aV9pb3ByaW8gZmllbGQuIEl0IHNlZW1zIGxpa2UgdGhlIHVzZXJzIG9mDQo+Pj4+IHRoZSBwcml2
YXRlIGZpZWxkIGFsbCB1c2UgaXQgYXQgYSBwb2ludCB3aGVyZSB3ZSBjYW4geWFuayB0aGUgcHJp
b3JpdHkgZnJvbQ0KPj4+PiB0aGUga2lvY2IgYmVmb3JlIHRoZSBwcml2YXRlIGZpZWxkIGlzIHVz
ZWQuIENvbW1lbnRzIGFuZCBzdWdnZXN0aW9ucyB3ZWxjb21lLg0KPj4+DQo+Pj4gT3Igd2UgY291
bGQganVzdCBtYWtlIGtpX2hpbnQgYSB1OCBvciB1MTYgLi4uIHNlZW1zIHVubGlrZWx5IHdlJ2xs
IG5lZWQNCj4+PiAzMiBiaXRzIG9mIGtpX2hpbnQuICAoY3VycmVudGx5IGRlZmluZWQgdmFsdWVz
IGFyZSAxLTUpDQo+Pg0KPj4gSSBsaWtlIHRoZSBhcHByb2FjaCBvZiB1c2luZyBhIHUxNiBmb3Ig
dGhlIGtpX2hpbnQuIEknbGwgdXBkYXRlIGFuZA0KPj4gcmVzdWJtaXQuDQo+IA0KPiBJdCdzIGlu
dGVuZGVkIHRvIGJlIGEgbWFzay4gSWYgeW91IGRvIHNocmluayBpdCBmb3Igbm93LCB0aGVuIHdl
IG5lZWQgc29tZQ0KPiBndWFyZCBjb2RlIHRvIGVuc3VyZSBpdCBjYW4gYWx3YXlzIGNhcnJ5IHdo
YXQgaXQgbmVlZHMgdG8uDQo+IA0KDQpHb3QgaXQsIEknbGwgYWRkIHRoZSBndWFyZCB0byByd19o
aW50X3ZhbGlkIGFsb25nIHdpdGggYSBjb21tZW50IGFib3V0IA0KYmVpbmcgbGltaXRlZCBieSB0
aGUgc2l6ZSBvZiBraV9oaW50IGluIGNhc2Ugd2UgZ2V0IHRvIGEgc2l0dWF0aW9uIHdoZXJlIA0K
MTYgYml0cyBpcyBub3QgZW5vdWdoLg0K
