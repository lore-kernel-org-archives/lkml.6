Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1381604-1525095849-2-16552880255060304268
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
    1525095848; b=OI16yaghyD1zE4Z7c53gRbriWGcxzfoUoHRvcTYoAO5a7A9cqd
    v9f5mmFJtWcfZGRqB+1lfCxyW6Enm55HPGH2SFJi9FMvv8auWneH9ut4TdraVGGE
    z9x4NBEI8xjGNQRR1aUCbKg3i96mEGk663h0SUGfMzsqAWs7cB0RmiZFTGkZ8LpI
    pjiX3oqFh1l9TqNvSO1A6Yv/KA/k3tgg8cO5XjKUftDa2xLqlA+XOYxDbZ8yYW9P
    scwJ5LK9eq6Ixcim5NJGPzRuuuZM/JdxJjbCQVMnaGeTNZl6wde2hSTSLd04avZD
    XRPv2u9DDmuu61BTJPzAK4w+2+UxnFfLEtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1525095848; bh=sJnxjYPzR80cZMjLAEuHGtSX/daDZe+fpoi4f8LrPQ8=; b=
    LE0hmQiTqur0JKUAxguz9qry2X+F1e6HlHmisMtSSCgy3aV73q5yL+xunkeS90cG
    cEorRxxMBJWQX2CYFKj56MlA2c3MCfwK5p4h/wnlXkdmGxhY0RepZ6JcV6y+0icU
    LhnUrGqmPStyEAt70nt4ycnWPaf6HcfCeU9Zp7DfnsIQ7eUw1AIV5vgdR6INeVLs
    AJErs0X1ZeNvMzPN4XZb1nxAFyE3tLzoO1zqn4mQ6C9KKNI04DG9Thv1l/RpNWWb
    RMOIBv+Bcdj4m+foYH7/hpnlLtY/BkK/oKh8MZahKwPDvMAmiopJmy+CkIYiIzpx
    owoXD1Qa7cndRKeu2kcHhQ==
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
X-CM-Envelope: MS4wfBnek9q4onGEZkEwT/I7nmW0XnAQPHMlJ1haU2VWcv8/AB59bV2voTHY03RCiPoK0MNZspGTpn8aQwrHAh6r4qkg0/bdoQKw0C5OlWLTWvv3KV+Xzrdk
    ElA8OVxxheiynHIlYRYxWS4HZhJYQgGU/eyoUtG1WezxVpQuNJ76eXVvCDusON0kWgg1bM0BCa/iMkIkyTc3LtRHLdH+6O5fyAdayDOYV3ycnDOQeolbKIv/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VtQtJH8w3oYA:10 a=hkdB2cgs02UA:10
    a=A3aqUMXqizAA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=QDZ4HvhdkI4A:10 a=tA7aZXjiAAAA:8 a=tA4uqISWePZ5iWWqRkEA:9 a=QEXdDO2ut3YA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeD3Nnz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 09:43:55 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:52686 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbeD3Nnu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 09:43:50 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "joro@8bytes.org" <joro@8bytes.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "bp@suse.de" <bp@suse.de>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Thread-Topic: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Thread-Index: AQHTu76cmkz1ie7mb0G/9GXlGHy7daQTW6wAgAAh0oCAABGZAIAABywAgAAmsYCAACedAIAAmRcAgABzlACAATZ9gIAAxs2AgAJEWoCAAGfdgA==
Date: Mon, 30 Apr 2018 13:43:37 +0000
Message-ID: <1525095763.2693.550.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
         <20180314180155.19492-3-toshi.kani@hpe.com>
         <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
         <20180426172327.GQ15462@8bytes.org> <1524764948.2693.478.camel@hpe.com>
         <20180426200737.GS15462@8bytes.org> <1524781764.2693.503.camel@hpe.com>
         <20180427073719.GT15462@8bytes.org> <1524839460.2693.531.camel@hpe.com>
         <20180428090217.n2l3w4vobmtkvz6k@8bytes.org>
         <1524948829.2693.547.camel@hpe.com>
         <c8c5e78a-2cb2-ca46-6521-928b6c0114c6@codeaurora.org>
In-Reply-To: <c8c5e78a-2cb2-ca46-6521-928b6c0114c6@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0387;7:yDzz8/Bk77u8WpsmgBbYQT4fUDlFR7SxUHdEybG1+P/8tcBeL8RypEKLIGAF397oDK24Ez51Uls/BHeTfB6AhJRwZSa8sY4AAmNlDSrZ4dvHVzH4b8W7p5LYZA1qREs5/upNpwF1O9vaA4IbLx6CS7KHaatSE1UROB3vT7QoWVqh2efxRqGycp8e0x4DqVJIO2BIqZGfo571C+LDF7W4XhHvSSNamlrKtxwyVx5PLDtISFYU/8atUY8n35LmPZE1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0387;
x-ms-traffictypediagnostic: AT5PR8401MB0387:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0387F6E5339FA2984C9C20ED82820@AT5PR8401MB0387.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AT5PR8401MB0387;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0387;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(39380400002)(376002)(396003)(366004)(377424004)(189003)(199004)(99286004)(6246003)(8676002)(110136005)(8936002)(86362001)(76176011)(36756003)(66066001)(68736007)(6506007)(11346002)(186003)(53546011)(446003)(81166006)(81156014)(2900100001)(102836004)(486006)(26005)(4326008)(476003)(2616005)(316002)(54906003)(25786009)(53936002)(3660700001)(14454004)(5660300001)(6116002)(97736004)(6436002)(93886005)(103116003)(5250100002)(2501003)(6512007)(7416002)(7736002)(2906002)(6486002)(3280700002)(3846002)(105586002)(478600001)(106356001)(229853002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0387;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: gfGFNr2trF3+8Y0NShAg/UDkipZQSRsZjRYFy3WfurylbOAfq8gHp5jqmX7JauyD4+XAX3cJzWG8Su1+bbdLu+IUXa1g7mLqUMHi1yhDu3ngEWgHT+7vYT7t78vMP7Zfs3ItJP+D3n+EiKhMm9xGtJhtUD9+4WCA+oiqCAmzOphW+6z+oAZVyhYN7KkBV8xg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A59DFC846261343BB407C0FE1A574EB@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 61c0ca5d-ddb8-4cb2-452b-08d5aea06067
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c0ca5d-ddb8-4cb2-452b-08d5aea06067
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 13:43:37.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0387
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uLCAyMDE4LTA0LTMwIGF0IDEzOjAwICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gDQo+IE9uIDQvMjkvMjAxOCAyOjI0IEFNLCBLYW5pLCBUb3NoaSB3cm90ZToNCj4gPiBPbiBT
YXQsIDIwMTgtMDQtMjggYXQgMTE6MDIgKzAyMDAsIGpvcm9AOGJ5dGVzLm9yZyB3cm90ZToNCj4g
PiA+IE9uIEZyaSwgQXByIDI3LCAyMDE4IGF0IDAyOjMxOjUxUE0gKzAwMDAsIEthbmksIFRvc2hp
IHdyb3RlOg0KPiA+ID4gPiBTbywgd2UgY2FuIGFkZCB0aGUgc3RlcCAyIG9uIHRvcCBvZiB0aGlz
IHBhdGNoLg0KPiA+ID4gPiAgIDEuIENsZWFyIHB1ZC9wbWQgZW50cnkuDQo+ID4gPiA+ICAgMi4g
U3lzdGVtIHdpZGUgVExCIGZsdXNoIDwtLSBUTyBCRSBBRERFRCBCWSBORVcgUEFUQ0gNCj4gPiA+
ID4gICAzLiBGcmVlIGl0cyB1bmRlcmxpbmluZyBwbWQvcHRlIHBhZ2UuDQo+ID4gPiANCj4gPiA+
IFRoaXMgc3RpbGwgbGFja3MgdGhlIHBhZ2UtdGFibGUgc3luY2hyb25pemF0aW9uIGFuZCB3aWxs
IHRodXMgbm90IGZpeA0KPiA+ID4gdGhlIEJVR19PTiBiZWluZyB0cmlnZ2VyZWQuDQo+ID4gDQo+
ID4gVGhlIEJVR19PTiBpc3N1ZSBpcyBzcGVjaWZpYyB0byBQQUUgdGhhdCBpdCBzeW5jcyBhdCB0
aGUgcG1kIGxldmVsLg0KPiA+IHg4Ni82NCBkb2VzIG5vdCBoYXZlIHRoaXMgaXNzdWUgc2luY2Ug
aXQgc3luY3MgYXQgdGhlIHBnZCBvciBwNGQgbGV2ZWwuDQo+ID4gDQo+ID4gPiA+IFdlIGRvIG5v
dCBuZWVkIHRvIHJldmVydCB0aGlzIHBhdGNoLiAgV2UgY2FuIG1ha2UgdGhlIGFib3ZlIGNoYW5n
ZSBJDQo+ID4gPiA+IG1lbnRpb25lZC4NCj4gPiA+IA0KPiA+ID4gUGxlYXNlIG5vdGUgdGhhdCB3
ZSBhcmUgbm90IGluIHRoZSBtZXJnZSB3aW5kb3cgYW55bW9yZSBhbmQgdGhhdCBhbnkgZml4DQo+
ID4gPiBuZWVkcyB0byBiZSBzaW1wbGUgYW5kIG9idmlvdXNseSBjb3JyZWN0Lg0KPiA+IA0KPiA+
IFVuZGVyc3Rvb2QuICBDaGFuZ2luZyB0aGUgeDg2LzMyIHN5bmMgcG9pbnQgaXMgcmlza3kuICBT
bywgSSBhbSBnb2luZyB0bw0KPiA+IHJldmVydCB0aGUgZnJlZSBwYWdlIGhhbmRsaW5nIGZvciBQ
QUUuDQo+IA0KPiBXaWxsIHRoaXMgYWZmZWN0IHBtZF9mcmVlX3B0ZV9wYWdlKCkgJiBwdWRfZnJl
ZV9wbWRfcGFnZSgpICdzIGV4aXN0ZW5jZQ0KPiBvciBpdHMgcGFyYW1ldGVycyA/IEknbSBhc2tp
bmcgYmVjYXVzZSwgSSd2ZSBzaW1pbGFyIGNoYW5nZSBmb3IgYXJtNjQNCj4gYW5kIHJlYWR5IHRv
IHNlbmQgdjkgcGF0Y2hlcy4NCg0KTm8sIGl0IHdvbid0LiAgVGhlIGNoYW5nZSBpcyBvbmx5IHRv
IHRoZSB4ODYgc2lkZS4NCg0KPiBJJ20gdGhpbmtpbmcgdG8gc2hhcmUgbXkgdjkgcGF0Y2hlcyBp
biBhbnkgY2FzZS4gSWYgeW91IGFyZSBnb2luZyB0byBkbw0KPiBUTEIgaW52YWxpZGF0aW9uIHdp
dGhpbiB0aGVzZSBBUElzLCBteSBmaXJzdCBwYXRjaCB3aWxsIGhlbHAuDQoNCkkgd2lsbCBtYWtl
IG15IGNoYW5nZSBvbiB0b3Agb2YgeW91ciB2OSAxLzQgcGF0Y2ggc28gdGhhdCB3ZSBjYW4gYXZv
aWQNCm1lcmdlIGNvbmZsaWN0Lg0KDQpUaGFua3MsDQotVG9zaGkNCg==
